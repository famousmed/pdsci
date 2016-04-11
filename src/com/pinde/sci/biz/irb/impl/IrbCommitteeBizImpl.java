package com.pinde.sci.biz.irb.impl;


import java.util.ArrayList;
import java.util.List;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbCommitteeBiz;
import com.pinde.sci.biz.irb.IIrbInfoUserBiz;
import com.pinde.sci.biz.irb.IIrbMeetingBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.IIrbResearcherBiz;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.IrbApplyMapper;
import com.pinde.sci.dao.base.IrbUserMapper;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.enums.irb.IrbDecisionEnum;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.form.irb.IrbVoteForm;
import com.pinde.sci.model.irb.IrbForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbMeeting;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysUser;
@Service
@Transactional(rollbackFor=Exception.class)
public class IrbCommitteeBizImpl implements IIrbCommitteeBiz {
	@Autowired
	private IrbUserMapper irbUserMapper;
	@Autowired
	private IrbApplyMapper irbApplyMapper;
	@Autowired
	private PubProjMapper projMapper;
	@Autowired
	private IIrbResearcherBiz researcherBiz;
	@Autowired
	private IIrbUserBiz irbUserBiz;
	@Autowired
	private IIrbRecBiz irbRecBiz;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IIrbInfoUserBiz irbInfoUserBiz;
	@Autowired
	private IIrbMeetingBiz meetingBiz;

	@Override
	public List<IrbForm> searchIrbFormList(List<IrbUser> irbUserList) {
		List<IrbForm> irbFormList = new ArrayList<IrbForm>();
		for(IrbUser user : irbUserList){
			IrbApply irb = irbApplyMapper.selectByPrimaryKey(user.getIrbFlow());
			IrbForm temp = new IrbForm();
			temp.setIrb(irb);
			
			if(itemCount(temp,irbFormList)==0){//过滤多条apply
				PubProj proj =  projMapper.selectByPrimaryKey(irb.getProjFlow());
				temp.setProj(proj);
				irbFormList.add(temp);
			}
		}
		return irbFormList;
	}
	private int itemCount(IrbForm form,List<IrbForm> forms){
		int count = 0;
		if(form!=null&&forms!=null&&!forms.isEmpty()){
			for (IrbForm irbForm : forms) {
				if(irbForm.getIrb().getIrbFlow().equals(form.getIrb().getIrbFlow())){
					count++;
				}
			}
		}
		return count;
	}

	@SuppressWarnings("unchecked")
	@Override
	public int saveVote(IrbVoteForm form, String irbFlow,String[] userFlows) throws Exception {
		if(form!=null&&StringUtil.isNotBlank(irbFlow)){
			IrbRec irbRec = new IrbRec(); 
			irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.MeetingDecision.getId());
			IrbRec findIrbRec = this.irbRecBiz.readIrbRec(irbRec);
			Document dom = null;
			Element root = null;
			IrbApply irbApply = this.irbApplyBiz.queryByFlow(irbFlow);
			if(findIrbRec==null){
				irbRec.setRecTypeName(IrbRecTypeEnum.MeetingDecision.getName());
				irbRec.setProjFlow(irbApply.getProjFlow());
				irbRec.setIrbStageId(irbApply.getIrbStageId());
				irbRec.setIrbStageName(irbApply.getIrbStageName());
				findIrbRec = irbRec;
				dom = DocumentHelper.createDocument();
				root = dom.addElement("meetingDecision");
			}else{
				String findContent = findIrbRec.getRecContent();
				dom = DocumentHelper.parseText(findContent);
				root = dom.getRootElement();
			}
			String mDecisionId = form.getmDecisionId();
			if(StringUtil.isNotBlank(mDecisionId)){
				root.addElement("mDecisionId").setText(mDecisionId);//会议最终决定
				IrbMeeting meeting = this.meetingBiz.readIrbMeeting(form.getMeetingFlow());
				String meetingDate = "";
				if(meeting!=null){
					meetingDate = meeting.getMeetingDate();
				}
				if (!"edit".equals(form.getOperType())) {
					/*插入process*/
					IrbProcess process = new IrbProcess();
					process.setOperTime(meetingDate);
					this.researcherBiz.saveProcess(irbApply, process);
				}
				
				irbApply.setIrbDecisionId(mDecisionId);
				irbApply.setIrbDecisionName(IrbDecisionEnum.getNameById(mDecisionId));
				irbApply.setIrbReviewDate(meetingDate);	//保存审查日期
				if (!"edit".equals(form.getOperType())) {
					irbApply.setIrbStageId(IrbStageEnum.Decision.getId());
					irbApply.setIrbStageName(IrbStageEnum.Decision.getName());
				}
				this.irbApplyBiz.changeStage(irbApply);//改状态
			}else if(userFlows!=null&&userFlows.length>0){//批量利益冲突退出
				/*移除原来的所有利益冲突的vote节点*/
				List<Element> decisionIds = dom.selectNodes("//decisionId[@conflict='"+GlobalConstant.FLAG_Y+"']");
				for (Element el : decisionIds) {
					root.remove(el.getParent());
				}
				/*添加新的利益冲突vote节点*/
				for (String userFlow : userFlows) {
					Element voteElement = root.addElement("vote");
					voteElement.addElement("userFlow").setText(userFlow);
					SysUser user = this.userBiz.readSysUser(userFlow);
					voteElement.addElement("userName").setText(StringUtil.defaultIfEmpty(user.getUserName(), ""));
					voteElement.addElement("decisionId").addAttribute("conflict", GlobalConstant.FLAG_Y);
					voteElement.addElement("date");
					voteElement.addElement("opinion");
				}
			}else {//每个委员的投票
				Element voteElement = (Element)root.selectSingleNode("vote[userFlow='"+form.getUserFlow()+"']");
				if (voteElement == null) {
					voteElement = root.addElement("vote");
				}
				String decisionId = voteElement.selectSingleNode("decisionId")==null?"":voteElement.selectSingleNode("decisionId").getText();
				if (StringUtil.isBlank(decisionId) || !decisionId.equals(form.getDecisionId())) {	//若秘书改变委员已有投票决定，则重新保存；否则不做处理
					root.remove(voteElement);
					voteElement = root.addElement("vote");
				 	voteElement.addElement("userFlow").setText(StringUtil.defaultIfEmpty(form.getUserFlow(), ""));
					voteElement.addElement("userName").setText(StringUtil.defaultIfEmpty(form.getUserName(), ""));
					Element decisionIdEl= voteElement.addElement("decisionId");
					if(StringUtil.isNotBlank(form.getDecisionId())){
						decisionIdEl.setText(form.getDecisionId());
					}else if(StringUtil.isNotBlank(form.getConflict())){
						decisionIdEl.addAttribute("conflict", form.getConflict());
					}
					voteElement.addElement("date").setText(StringUtil.defaultIfEmpty(form.getDate(), ""));
					voteElement.addElement("opinion").setText(StringUtil.defaultIfEmpty(form.getOpinion(), ""));
				}
			}
			findIrbRec.setRecContent(dom.asXML());
			return this.irbRecBiz.edit(findIrbRec);
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public int saveConflict(String irbFlow,String[] userFlows) throws Exception {
		if(StringUtil.isNotBlank(irbFlow)){
			IrbRec irbRec = new IrbRec(); 
			irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.MeetingDecision.getId());
			IrbRec findIrbRec = this.irbRecBiz.readIrbRec(irbRec);
			Document dom = null;
			Element root = null;
			IrbApply irbApply = this.irbApplyBiz.queryByFlow(irbFlow);
			if(findIrbRec==null){
				irbRec.setRecTypeName(IrbRecTypeEnum.MeetingDecision.getName());
				irbRec.setProjFlow(irbApply.getProjFlow());
				irbRec.setIrbStageId(irbApply.getIrbStageId());
				irbRec.setIrbStageName(irbApply.getIrbStageName());
				findIrbRec = irbRec;
				dom = DocumentHelper.createDocument();
				root = dom.addElement("meetingDecision");
			}else{
				String findContent = findIrbRec.getRecContent();
				dom = DocumentHelper.parseText(findContent);
				root = dom.getRootElement();
			}
			/*移除原来的所有利益冲突的vote节点*/
			List<Element> decisionIds = dom.selectNodes("//decisionId[@conflict='"+GlobalConstant.FLAG_Y+"']");
			for (Element el : decisionIds) {
				root.remove(el.getParent());
			}
			if(userFlows!=null&&userFlows.length>0){//批量利益冲突退出
				/*添加新的利益冲突vote节点*/
				for (String userFlow : userFlows) {
					if (StringUtil.isNotBlank(userFlow)) {
						Element voteElement = root.addElement("vote");
						voteElement.addElement("userFlow").setText(userFlow);
						SysUser user = this.userBiz.readSysUser(userFlow);
						voteElement.addElement("userName").setText(StringUtil.defaultIfEmpty(user.getUserName(), ""));
						voteElement.addElement("decisionId").addAttribute("conflict", GlobalConstant.FLAG_Y);
						voteElement.addElement("date");
						voteElement.addElement("opinion");
					}
				}
			}
			findIrbRec.setRecContent(dom.asXML());
			return this.irbRecBiz.edit(findIrbRec);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IrbVoteForm> queryIrbVoteList(String irbFlow, String userFlow)throws Exception {
		List<IrbVoteForm> list = null;
		if(StringUtil.isNotBlank(irbFlow)){
			IrbRec irbRec = new IrbRec(); 
			irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.MeetingDecision.getId());
			IrbRec findIrbRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findIrbRec!=null&&StringUtil.isNotBlank(findIrbRec.getRecContent())){
				list = new ArrayList<IrbVoteForm>();
				Document dom = DocumentHelper.parseText(findIrbRec.getRecContent());
				if(StringUtil.isNotBlank(userFlow)){//查询单个委员投票
					Element voteEl = (Element) dom.selectSingleNode("//vote[userFlow='"+userFlow+"']");
					if(voteEl!=null){
						fillForm(list, voteEl);
					}
				}else{
					List<Element> elList = dom.selectNodes("//vote");
					if(elList!=null&&!elList.isEmpty()){
						for (Element voteEl : elList) {
							fillForm(list, voteEl);
						}
					}
				}
			}
		}
		return list;
	}

	private void fillForm(List<IrbVoteForm> list, Element voteEl) {
		IrbVoteForm form = new IrbVoteForm();
		form.setUserFlow(voteEl.elementText("userFlow"));
		form.setUserName(voteEl.elementText("userName"));
		Element decisionIdEl = voteEl.element("decisionId");
		String decisionId = decisionIdEl.getTextTrim();
		form.setDecisionId(decisionId);
		if(StringUtil.isNotBlank(decisionId)){
			form.setDecisionName(IrbDecisionEnum.getNameById(decisionId));
		}
		Attribute conflictAt =  decisionIdEl.attribute("conflict");
		if(conflictAt!=null){
			form.setConflict(conflictAt.getValue());
		}
		form.setDate(voteEl.elementText("date"));
		form.setOpinion(voteEl.elementText("opinion"));
		list.add(form);
	}

	@Override
	public int saveVoteDecision(IrbVoteForm form) throws Exception {
		if(form!=null){
			IrbVoteForm mForm = new IrbVoteForm();
			mForm.setOperType(form.getOperType());
			mForm.setmDecisionId(form.getmDecisionId());
			mForm.setMeetingFlow(form.getMeetingFlow());
			String irbFlow = form.getIrbFlow();
			saveVote(mForm, irbFlow,null);//保存最终决定
			List<IrbVoteForm> voteList = form.getVoteList();
			String currDate = DateUtil.getCurrDate();
			if(voteList!=null&&!voteList.isEmpty()){//批量保存投票
				String userFlows[] = new String[voteList.size()];
				for (int i=0;i<voteList.size();i++) {
					IrbVoteForm irbVoteForm = voteList.get(i);
					String userFlow = irbVoteForm.getUserFlow();
					IrbVoteForm sForm = new IrbVoteForm();
					sForm.setOperType(form.getOperType());
					sForm.setUserFlow(userFlow);
					sForm.setUserName(irbVoteForm.getUserName());
					String decisionId = irbVoteForm.getDecisionId();
					String conflict = irbVoteForm.getConflict();
					if(GlobalConstant.FLAG_Y.equals(conflict)){
						sForm.setConflict(GlobalConstant.FLAG_Y);
						sForm.setDecisionId("");
						userFlows[i] = userFlow;
					}else{
						sForm.setDecisionId(decisionId);
						sForm.setConflict("");
					}
					sForm.setDate(currDate);
					saveVote(sForm, irbFlow, null);
				}
				saveConflict(irbFlow,userFlows);//批量保存利益冲突退出
			}
			if (!"edit".equals(form.getOperType())) {
				/*插入存档文件*/
				IrbArchiveForm aForm = new IrbArchiveForm();
				aForm.setIrbFlow(irbFlow);
				aForm.setName(IrbRecTypeEnum.MeetingDecision.getName());
				aForm.setRecType(IrbRecTypeEnum.MeetingDecision.getId());
				aForm.setFileFlow(null);
				String url =  GlobalContext.getRequest().getContextPath()+"/irb/meeting/voteDesction?irbFlow="+irbFlow;
				aForm.setUrl(url);
				this.irbRecBiz.saveArchiveFile(aForm);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
}
