package com.pinde.sci.biz.irb.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.IIrbResearcherBiz;
import com.pinde.sci.biz.irb.IIrbSecretaryBiz;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.common.DateTrans;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.IrbApplyMapper;
import com.pinde.sci.dao.base.IrbProcessMapper;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.enums.irb.IrbDecisionEnum;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.form.irb.IrbDecisionDetailForm;
import com.pinde.sci.form.irb.IrbNoticeForm;
import com.pinde.sci.form.irb.IrbQuickOpinionForm;
import com.pinde.sci.form.irb.IrbReceiptNoticeForm;
import com.pinde.sci.model.irb.ApplyFileTemp;
import com.pinde.sci.model.irb.IrbForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbProcessExample;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysUser;
@Service
@Transactional(rollbackFor=Exception.class)
public class IrbSecretaryBizImpl implements IIrbSecretaryBiz{
	@Resource
	private IrbApplyMapper applyMapper;
	@Autowired
	private PubProjMapper projMapper;
	@Autowired
	private IIrbResearcherBiz researcherBiz;
	@Autowired
	private IIrbRecBiz irbRecBiz;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IrbProcessMapper irbProcessMapper;
	@Autowired
	private IIrbUserBiz irbUserBiz;
	@Autowired
	private IFileBiz fileBiz;

	@Override
	public IrbForm readIrbForm(String irbFlow) {
		IrbApply irb = applyMapper.selectByPrimaryKey(irbFlow);
		PubProj proj =  projMapper.selectByPrimaryKey(irb.getProjFlow());
		IrbForm irbForm = new IrbForm();
		irbForm.setIrb(irb);
		irbForm.setProj(proj);
		return irbForm;
	}


	@Override
	public int fileConfirm(String[] fileIds,String irbFlow) throws Exception {
		if(fileIds!=null&&fileIds.length>0&&StringUtil.isNotBlank(irbFlow)){
			IrbRec irbRec = new IrbRec();
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
			List<IrbRec> irbRecList =  this.irbRecBiz.queryList(irbRec);
			if(irbRecList!=null&&!irbRecList.isEmpty()&&StringUtil.isNotBlank(irbRecList.get(0).getRecContent())){
				IrbRec findIrbRec = irbRecList.get(0);
				String content = findIrbRec.getRecContent();
				Document dom = DocumentHelper.parseText(content);
				for (String fileId : fileIds) {
					Element fileElement = this.irbRecBiz.queryUploadFile(dom, fileId);//根据id查找file节点
					if(fileElement!=null){
						fileElement.addAttribute("confirm", "true");
						/*插入存档文件*/
						IrbArchiveForm form = new IrbArchiveForm();
						form.setIrbFlow(irbFlow);
						form.setName(fileElement.elementTextTrim("fileName"));
						form.setRecType(IrbRecTypeEnum.ApplyFile.getId());
						String fileFlow = fileElement.elementTextTrim("fileFlow");
						form.setFileFlow(fileFlow);
						String url = null;
						if(GlobalConstant.FLAG_N.equals(fileId)){//审查申请表
							Element urlEl = fileElement.element("url");
							if(urlEl!=null){
								url =  urlEl.getTextTrim();
							}
						}else{
							url = GlobalContext.getRequest().getContextPath()+"/pub/file/down?fileFlow="+fileFlow;
						}
						form.setUrl(url);
						this.irbRecBiz.saveArchiveFile(form);
					}
				}
				findIrbRec.setRecContent(dom.asXML());
				return this.irbRecBiz.edit(findIrbRec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}


	@Override
	public int saveApplyAndModifyFile(IrbNoticeForm form,IrbRec irbRec) throws Exception {
		if((form!=null)&&irbRec!=null){
			Document dom = null;
			Element root = null;
			String content = null;
			List<IrbRec> irbRecList = this.irbRecBiz.queryList(irbRec);
			if(irbRecList!=null&&!irbRecList.isEmpty()){
				IrbRec findIrbRec  = irbRecList.get(0);
				irbRec.setRecFlow(findIrbRec.getRecFlow());
				content = findIrbRec.getRecContent();
			}
			if(StringUtil.isNotBlank(content)){
				dom = DocumentHelper.parseText(content);
				root = dom.getRootElement();
			}else{
				dom = DocumentHelper.createDocument();
				root = dom.addElement("notices");
			}
			Element noticeElement = root.addElement("notice");
			List<ApplyFileTemp> applyFiles = form.getApplyFiles();
			if(applyFiles!=null&&!applyFiles.isEmpty()){
				Element applyFileElement = noticeElement.addElement("applyFile");
				for (ApplyFileTemp file : applyFiles) {
					Element fileElement = applyFileElement.addElement("file").addAttribute("id", StringUtil.defaultIfEmpty(file.getId(), ""));
					fileElement.addElement("fileName").setText(StringUtil.defaultIfEmpty(file.getName(), ""));
				}
			}
			 List<IrbApplyFileForm> modifyFiles = form.getModifyFiles();
			if(modifyFiles!=null&&!modifyFiles.isEmpty()){
				Element modifyFileElement = noticeElement.addElement("modifyFile");
				for (IrbApplyFileForm aform : modifyFiles) {
					Element fileElement = modifyFileElement.addElement("file").addAttribute("id", StringUtil.defaultIfEmpty(aform.getFileTempId(), ""));
					fileElement.addElement("fileFlow").setText(StringUtil.defaultIfEmpty(aform.getFileFlow(), ""));
					fileElement.addElement("fileName").setText(StringUtil.defaultIfEmpty(aform.getFileName(), ""));
					fileElement.addElement("suggest").setText(StringUtil.defaultIfEmpty(aform.getSuggest(), ""));
				}
			}
			irbRec.setRecContent(dom.asXML());
			irbRec.setRecVersion(GlobalConstant.FLAG_Y);
		    this.irbRecBiz.edit(irbRec);
		    String irbFlow = form.getIrbFlow();
		    /*修改apply状态*/
		    IrbApply irbApply = new IrbApply();
		    irbApply.setIrbFlow(irbFlow);
		    irbApply.setIrbStageId(IrbStageEnum.Apply.getId());
		    irbApply.setIrbStageName(IrbStageEnum.Apply.getName());
		    this.irbApplyBiz.edit(irbApply);
		    /*记录状态改变过程*/
		    //IrbApply findIrbApply = this.irbApplyBiz.queryByFlow(irbFlow);
		    //this.researcherBiz.handProcess(findIrbApply);
		    /*修改irb_rec中的apply状态*/
		    List<IrbRec> irbRecList2 = this.irbRecBiz.queryList(irbRec);
			if(irbRecList2!=null&&!irbRecList2.isEmpty()){
				IrbRec findIrbRec  = irbRecList2.get(0);
				findIrbRec.setIrbStageId(IrbStageEnum.Apply.getId());
				findIrbRec.setIrbStageName(IrbStageEnum.Apply.getName());
				this.irbRecBiz.edit(findIrbRec);
			}
		    return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}


	@Override
	public int saveRecNotice(IrbReceiptNoticeForm form) {
		if(form!=null){
			/*保存受理号*/
			IrbApply irbApply = new IrbApply();
			String irbFlow = form.getIrbFlow();
			irbApply.setIrbFlow(irbFlow);
			irbApply.setIrbNo(form.getIrbNo());
			irbApply.setIrbAcceptedDate(form.getOperTime());
			this.irbApplyBiz.edit(irbApply);
			/*插入process*/
			IrbApply findIrb = this.irbApplyBiz.queryByFlow(irbFlow);
			IrbProcess process = queryLatestHandlePro(irbFlow);
			if (process == null) {
				process = new IrbProcess();
				process.setOperTime(form.getOperTime());
				this.researcherBiz.saveProcess(findIrb, process );
			} else {
				SysUser currentUser = GlobalContext.getCurrentUser();
				process.setOperTime(form.getOperTime());
				process.setOperUserFlow(currentUser.getUserFlow());
				process.setOperUserName(currentUser.getUserName());
				this.researcherBiz.modifyIrbProcess(process);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}


	@Override
	public IrbProcess queryLatestHandlePro(String irbFlow) {
		if(StringUtil.isNotBlank(irbFlow)){
			IrbProcessExample example = new IrbProcessExample();
			example.createCriteria().andIrbFlowEqualTo(irbFlow).andIrbStageIdEqualTo(IrbStageEnum.Handle.getId());
			example.setOrderByClause("create_time desc");
			List<IrbProcess> list =  this.irbProcessMapper.selectByExample(example);
			if(list!=null&&!list.isEmpty()){
				return list.get(0);
			}
		}
		return null;
	}


	@Override
	public int saveQuickOpinion(IrbQuickOpinionForm form) throws Exception {
		if(form!=null){
			Document dom = DocumentHelper.createDocument();
			Element root = dom.addElement("quickOpinions");
			Element opinionEl = root.addElement("opinion");
			opinionEl.addElement("reviewWayId").setText(StringUtil.defaultIfEmpty(form.getReviewWayId(), ""));
			SysUser curUser = GlobalContext.getCurrentUser();
			opinionEl.addElement("operUserFlow").setText(StringUtil.defaultIfEmpty(curUser.getUserFlow(), ""));
			opinionEl.addElement("operUserName").setText(StringUtil.defaultIfEmpty(curUser.getUserName(), ""));
			opinionEl.addElement("operTime").setText(StringUtil.defaultIfEmpty(form.getOperTime(), ""));
			if(StringUtil.isNotBlank(form.getIrbDecisionId())){
				opinionEl.addElement("irbDecisionId").setText(form.getIrbDecisionId());
			}
			if(StringUtil.isNotBlank(form.getReviewOpinion())){
				opinionEl.addElement("reviewOpinion").setText(form.getReviewOpinion());
			}
			String content = dom.asXML();
			String irbFlow = form.getIrbFlow();
			
			IrbRec irbRec = new IrbRec();
			irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.QuickOpinion.getId());
			IrbRec findRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findRec==null){
				IrbApply curApply = this.irbApplyBiz.queryByFlow(irbFlow);
				irbRec.setRecTypeName(IrbRecTypeEnum.QuickOpinion.getName());
				irbRec.setRecContent(content);
				if(curApply!=null){
					irbRec.setProjFlow(curApply.getProjFlow());
					irbRec.setIrbStageId(curApply.getIrbStageId());
					irbRec.setIrbStageName(curApply.getIrbStageName());
					return this.irbRecBiz.edit(irbRec);
				}
			}else{
				findRec.setRecContent(content);
				return this.irbRecBiz.edit(findRec);
			}
			
			/*插入存档文件*/
			IrbArchiveForm aForm = new IrbArchiveForm();
			aForm.setIrbFlow(irbFlow);
			aForm.setName(IrbRecTypeEnum.QuickOpinion.getName());
			aForm.setRecType(IrbRecTypeEnum.QuickOpinion.getId());
			aForm.setFileFlow(null);
			String url =  GlobalContext.getRequest().getContextPath()+"/irb/secretary/quickOpinion?irbFlow="+irbFlow;
			aForm.setUrl(url);
			this.irbRecBiz.saveArchiveFile(aForm);
		}
		return GlobalConstant.ZERO_LINE;
	}


	@Override
	public List<IrbForm> searchIrbListByForm(IrbApplyForm form) {
		List<IrbForm> list = null;
		List<IrbApply> aList = this.irbApplyBiz.queryList(form); //按送审日期排序
		aList = irbApplyBiz.sortApplyByIrbType(aList); //按审查类别排序
		if(aList!=null&&!aList.isEmpty()){
			list = new ArrayList<IrbForm>();
			IrbForm irbForm = null;  
			for (IrbApply irbApply : aList) {
				irbForm = readIrbForm(irbApply.getIrbFlow());
				list.add(irbForm);
			}
		}
		return list;
	}
	
	

	@Override
	public IrbQuickOpinionForm readQuickOpinion(String irbFlow)
			throws Exception {
		IrbQuickOpinionForm form = null;
		if(StringUtil.isNotBlank(irbFlow)){
			IrbRec irbRec = new IrbRec();
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.QuickOpinion.getId());
			IrbRec findRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findRec!=null&&StringUtil.isNotBlank(findRec.getRecContent())){
				form = new IrbQuickOpinionForm();
				Document dom = DocumentHelper.parseText(findRec.getRecContent());
				Element opinionEl = dom.getRootElement().element("opinion");
				form.setReviewWayId(opinionEl.elementTextTrim("reviewWayId"));
				form.setOperTime(opinionEl.elementTextTrim("operTime"));
				form.setOperUserFlow(opinionEl.elementTextTrim("operUserFlow"));
				form.setOperUserName(opinionEl.elementTextTrim("operUserName"));
				Element irbDecisionIdEl = opinionEl.element("irbDecisionId");
				if(irbDecisionIdEl!=null){
					form.setIrbDecisionId(irbDecisionIdEl.getTextTrim());
					form.setIrbDecisionName(IrbDecisionEnum.getNameById(irbDecisionIdEl.getTextTrim()));
				}
				Element reviewOpinionEl = opinionEl.element("reviewOpinion");
				if(reviewOpinionEl!=null){
					form.setReviewOpinion(reviewOpinionEl.getTextTrim());
				}
			}
		}
		return form;
	}


	@Override
	public int saveDecDetail(String irbFlow, IrbDecisionDetailForm form) throws Exception {
		if(StringUtil.isNotBlank(irbFlow)&&form!=null){
			IrbApply curApply = this.irbApplyBiz.queryByFlow(irbFlow);
			String recFlow = form.getRecFlow();
			if(curApply!=null){
				IrbRec irbRec = new IrbRec();
				irbRec.setRecFlow(recFlow);
				irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				irbRec.setIrbFlow(irbFlow);
				String irbRecTypeId = form.getIrbRecTypeId();
				irbRec.setRecTypeId(irbRecTypeId);
				irbRec.setRecTypeName(IrbRecTypeEnum.getNameById(irbRecTypeId));
				irbRec.setProjFlow(curApply.getProjFlow());
				irbRec.setIrbStageId(curApply.getIrbStageId());
				irbRec.setIrbStageName(curApply.getIrbStageName());
				Document dom = DocumentHelper.createDocument();
				Element root = dom.addElement("decisionFile");
				root.addElement("opinion").setText(StringUtil.defaultString(form.getOpinion()));
				root.addElement("approveValidity").setText(StringUtil.defaultString(form.getApproveValidity()));
				root.addElement("contact").setText(StringUtil.defaultString(form.getContact()));
				root.addElement("chairman").setText(StringUtil.defaultString(form.getChairman()));
				root.addElement("irbInfo").setText(StringUtil.defaultString(form.getIrbInfo()));
				root.addElement("trackFrequency").setText(StringUtil.defaultString(form.getTrackFrequency()));
				root.addElement("trackDate").setText(StringUtil.defaultString(form.getTrackDate()));
				root.addElement("irbDecisionDate").setText(StringUtil.defaultString(form.getIrbDecisionDate()));
				if (StringUtil.isNotBlank(recFlow)) {
					IrbRec rec = irbRecBiz.readIrbRec(recFlow);
					if (rec != null && StringUtil.isNotBlank(rec.getRecContent())) {
						Document domcu = DocumentHelper.parseText(rec.getRecContent());
						Element reviewFileEle = (Element)domcu.selectSingleNode("/decisionFile/reviewFile");
						Element newEle = reviewFileEle.createCopy();
						if (reviewFileEle != null) {
							root.add(newEle);
						}
					}
				} else {
					Element reviewFileEle = root.addElement("reviewFile");
					List<IrbApplyFileForm> fileList =  this.irbRecBiz.queryConfirmFile(irbFlow);
					if (fileList != null && fileList.size() > 0) {
						for (IrbApplyFileForm fileForm:fileList) {
							Element fileElement = reviewFileEle.addElement("file");
							fileElement.addAttribute("id", StringUtil.defaultString(fileForm.getFileTempId()));
							fileElement.addAttribute("confirm", "true");
							fileElement.addElement("fileFlow").setText(StringUtil.defaultString(fileForm.getFileFlow()));
							if(StringUtil.isNotBlank(fileForm.getUrl())){
								fileElement.addElement("url").setText(fileForm.getUrl());
							}
							fileElement.addElement("fileName").setText(StringUtil.defaultString(fileForm.getFileName()));
							fileElement.addElement("fileType").setText(StringUtil.defaultString(fileForm.getFileType()));
							fileElement.addElement("version").setText(StringUtil.defaultString(fileForm.getVersion()));
							fileElement.addElement("versionDate").setText(StringUtil.defaultString(fileForm.getVersionDate()));
							fileElement.addElement("showNotice").setText(StringUtil.defaultString(fileForm.getShowNotice()));
						}
					}
				}
				
				irbRec.setRecContent(dom.asXML());
				int result =  this.irbRecBiz.edit(irbRec);
				curApply.setIrbDecisionDate(StringUtil.defaultString(form.getIrbDecisionDate()));//保存决定日期
				curApply.setTrackFrequency(StringUtil.defaultString(form.getTrackFrequency()));
				curApply.setTrackDate(StringUtil.defaultString(form.getTrackDate()));
				if(result==GlobalConstant.ONE_LINE&&IrbRecTypeEnum.ApproveFile.getId().equals(form.getIrbRecTypeId())){//批件
					curApply.setApproveDate(form.getIrbDecisionDate());
					curApply.setApproveValidity(form.getApproveValidity());
					String validityDate = "";
					if (StringUtil.isNotBlank(form.getIrbDecisionDate()) && StringUtil.isNotBlank(form.getApproveValidity())) {
						validityDate = DateTrans.newDateOfAddMonths(form.getIrbDecisionDate(), Integer.parseInt(form.getApproveValidity()));
						curApply.setApproveValidityDate(validityDate);
					}
				}
				this.irbApplyBiz.edit(curApply);
				/*插入存档文件*/
				IrbArchiveForm aForm = new IrbArchiveForm();
				aForm.setIrbFlow(irbFlow);
				aForm.setName(IrbRecTypeEnum.getNameById(irbRecTypeId));
				aForm.setRecType(irbRecTypeId);
				aForm.setFileFlow(null);
				String url = GlobalContext.getRequest().getContextPath()+"/irb/secretary/decisionDetail?irbFlow="+irbFlow;
				aForm.setUrl(url);
				this.irbRecBiz.saveArchiveFile(aForm);
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveReviewFile(IrbDecisionDetailForm form) throws Exception {
		if(form!=null){
			String irbFlow = form.getIrbFlow();
			String irbRecTypeId = form.getIrbRecTypeId();
			IrbRec temp = new IrbRec();
			temp.setIrbFlow(irbFlow);
			temp.setRecTypeId(irbRecTypeId);
			IrbRec approveRec = this.irbRecBiz.readIrbRec(temp);
			String content = "<decisionFile/>";
			if(approveRec != null){
				if (StringUtil.isNotBlank(approveRec.getRecContent())) {
					content = approveRec.getRecContent();
				}
			} else {
				IrbApply curApply = this.irbApplyBiz.queryByFlow(irbFlow);
				approveRec = new IrbRec();
				approveRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				approveRec.setIrbFlow(irbFlow);
				approveRec.setRecTypeId(irbRecTypeId);
				approveRec.setRecTypeName(IrbRecTypeEnum.getNameById(irbRecTypeId));
				approveRec.setProjFlow(curApply.getProjFlow());
				approveRec.setIrbStageId(curApply.getIrbStageId());
				approveRec.setIrbStageName(curApply.getIrbStageName());
			}
			Document dom = DocumentHelper.parseText(content);
			Element root = dom.getRootElement();
			Element reviewFileEle = (Element)root.selectSingleNode("reviewFile");
			if (reviewFileEle != null) {
				root.remove(reviewFileEle);	//直接删掉重新保存reviewFile节点
			}
			reviewFileEle = root.addElement("reviewFile");
			
			List<IrbApplyFileForm> fileList = form.getApplyFileForms();
			if(fileList !=null && !fileList.isEmpty()){//批量保存审查文件
				for (int i=0;i<fileList.size();i++) {
					IrbApplyFileForm fileForm = fileList.get(i);
					Element fileElement = reviewFileEle.addElement("file");
					fileElement.addAttribute("id", StringUtil.defaultString(fileForm.getFileTempId()));
					fileElement.addAttribute("confirm", "true");
					String fileFlow = StringUtil.defaultString(fileForm.getFileFlow());
					if (StringUtil.isNotBlank(fileForm.getUrl())) {
						fileFlow = "";
					}
					fileElement.addElement("fileFlow").setText(fileFlow);
					if(StringUtil.isNotBlank(fileForm.getUrl())){
						fileElement.addElement("url").setText(fileForm.getUrl());
					}
					fileElement.addElement("fileName").setText(StringUtil.defaultString(fileForm.getFileName()));
					fileElement.addElement("fileType").setText(StringUtil.defaultString(fileForm.getFileType()));
					fileElement.addElement("version").setText(StringUtil.defaultString(fileForm.getVersion()));
					fileElement.addElement("versionDate").setText(StringUtil.defaultString(fileForm.getVersionDate()));
					fileElement.addElement("showNotice").setText(StringUtil.defaultString(fileForm.getShowNotice()));
				}
			}
			approveRec.setRecContent(dom.asXML());
			this.irbRecBiz.edit(approveRec);
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}


	@SuppressWarnings("unchecked")
	@Override
	public IrbDecisionDetailForm readDecDetail(String irbFlow,
			String irbRecTypeId) throws Exception {
		IrbDecisionDetailForm form = null;
		if(StringUtil.isNotBlank(irbFlow)&&StringUtil.isNotBlank(irbRecTypeId)){
			IrbRec irbRec = new IrbRec();
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(irbRecTypeId);
			IrbRec findRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findRec!=null&&StringUtil.isNotBlank(findRec.getRecContent())){
				form = new IrbDecisionDetailForm();
				Document dom = DocumentHelper.parseText(findRec.getRecContent());
				Element root = dom.getRootElement();
				form.setChairman(root.elementTextTrim("chairman"));
				form.setOpinion(root.elementText("opinion"));
				form.setApproveValidity(root.elementTextTrim("approveValidity"));
				form.setContact(root.elementTextTrim("contact"));
				form.setIrbInfo(root.elementTextTrim("irbInfo"));
				form.setTrackFrequency(root.elementTextTrim("trackFrequency"));
				form.setTrackDate(root.elementTextTrim("trackDate"));
				form.setIrbDecisionDate(root.elementTextTrim("irbDecisionDate"));
				form.setIrbRecTypeId(irbRecTypeId);
				form.setRecFlow(findRec.getRecFlow());
				
				List<IrbApplyFileForm> list = null;
				List<Element> fileElements = dom.selectNodes("/decisionFile/reviewFile/file");
				if(fileElements !=null && !fileElements.isEmpty()){
					list = new ArrayList<IrbApplyFileForm>();
					IrbApplyFileForm applyForm = null;
					for (Element e : fileElements) {
						applyForm = new IrbApplyFileForm();
						applyForm.setFileTempId(e.attributeValue("id"));
						applyForm.setFileFlow(e.element("fileFlow").getTextTrim());
						applyForm.setFileName(e.element("fileName").getTextTrim());
						if(e.element("showNotice")!=null){ 
							applyForm.setShowNotice(e.element("showNotice").getTextTrim());
						}
						if(e.element("fileType")!=null){
							applyForm.setFileType(e.element("fileType").getTextTrim());
						}
						if(e.element("version")!=null){
							applyForm.setVersion(e.element("version").getTextTrim());
						}
						if(e.element("versionDate")!=null){
							applyForm.setVersionDate(e.element("versionDate").getTextTrim());
						}
						if(e.element("url")!=null){
							applyForm.setUrl(e.element("url").getTextTrim());
						}
						list.add(applyForm);
					}
				}
				if (list != null) {
					form.setApplyFileForms(list);
				}
			}
		}
		return form;
	}


	@Override
	public String checkFileType(IrbApply curApply) {
		String fileType = IrbRecTypeEnum.OpinionFile.getId();//意见
		List<String> typeList = new ArrayList<String>();
		typeList.add(IrbTypeEnum.Init.getId());
		typeList.add(IrbTypeEnum.Retrial.getId());
		typeList.add(IrbTypeEnum.Revise.getId());
		/*判断是否已发批件*/
		IrbApply ia = new IrbApply();
		ia.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		ia.setProjFlow(curApply.getProjFlow());
		IrbApplyForm form = new IrbApplyForm();
		form.setIrbApply(ia);
		form.setIrbTypeIdList(typeList);
		form.setForMeeting(GlobalConstant.FLAG_N);
		List<IrbApply> applyList = this.irbApplyBiz.queryList(form);
		boolean haveApprove = false;
		if(applyList!=null&&!applyList.isEmpty()){
			for (IrbApply irbApply : applyList) {
				if(StringUtil.isNotBlank(irbApply.getApproveDate())){
					haveApprove = true;
					break;
				}
			}
		}
		/*批件满足的条件：（同意、未发过批件、初始审查,复审,修正案审查之一） 或 （ApproveDate 有值）  */
		if((IrbDecisionEnum.Agree.getId().equals(curApply.getIrbDecisionId())&&!haveApprove
				&&typeList.contains(curApply.getIrbTypeId()))||StringUtil.isNotBlank(curApply.getApproveDate())){//批件
			fileType = IrbRecTypeEnum.ApproveFile.getId();
		}
		return fileType;
	}
	
	@Override
	public boolean isHaveApprove(IrbApply curApply) {
		List<String> typeList = new ArrayList<String>();
		typeList.add(IrbTypeEnum.Init.getId());
		typeList.add(IrbTypeEnum.Retrial.getId());
		typeList.add(IrbTypeEnum.Revise.getId());
		/*判断是否已发批件*/
		IrbApply ia = new IrbApply();
		ia.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		ia.setProjFlow(curApply.getProjFlow());
		IrbApplyForm form = new IrbApplyForm();
		form.setIrbApply(ia);
		form.setIrbTypeIdList(typeList);
		form.setForMeeting(GlobalConstant.FLAG_N);
		List<IrbApply> applyList = this.irbApplyBiz.queryList(form);
		boolean haveApprove = false;
		if(applyList!=null&&!applyList.isEmpty()){
			for (IrbApply irbApply : applyList) {
				if(StringUtil.isNotBlank(irbApply.getApproveDate())){
					haveApprove = true;
					break;
				}
			}
		}
		return haveApprove;
	}


	@Override
	public int addApplyFile(IrbArchiveForm form, PubFile pubFile)throws Exception {
		if(form!=null){
			String fileFlow = "";
			if (pubFile!=null) {
				if(StringUtil.isNotBlank(form.getFileFlow())){
					pubFile.setFileFlow(form.getFileFlow());
				}
				int saveFileResult = this.fileBiz.editFile(pubFile);
				if(saveFileResult==GlobalConstant.ZERO_LINE){
					return GlobalConstant.ZERO_LINE;
				}
				fileFlow = pubFile.getFileFlow();
				String url = GlobalContext.getRequest().getContextPath()+"/pub/file/down?fileFlow="+fileFlow;
				form.setFileFlow(fileFlow);
				form.setUrl(url);
			}
			this.irbRecBiz.saveArchiveFile(form);
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	
}
