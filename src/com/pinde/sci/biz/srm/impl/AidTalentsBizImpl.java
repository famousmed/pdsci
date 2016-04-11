package com.pinde.sci.biz.srm.impl;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.BeanUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IAidTalentsBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.AidTalentsMapper;
import com.pinde.sci.enums.srm.AidAssessStatusEnum;
import com.pinde.sci.enums.srm.AidTalentsStatusEnum;
import com.pinde.sci.model.mo.AidTalents;
import com.pinde.sci.model.mo.AidTalentsExample;
import com.pinde.sci.model.mo.AidTalentsExample.Criteria;
import com.pinde.sci.model.srm.AidTalentsExt;
@Service
@Transactional(rollbackFor=Exception.class)
public class AidTalentsBizImpl implements IAidTalentsBiz {
	@Autowired
	private AidTalentsMapper aidTalentsMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	@Override
	public int edit(AidTalentsExt aidExt) throws RuntimeException{
		if(aidExt!=null){
			 String mainCompose = aidExt.getMainCompose();
			 String content = aidExt.getContent();
			 String  wsjOpinion = aidExt.getWsjOpinion();
			 String czjOpinion = aidExt.getCzjOpinion();
			 String sqPrincipal = aidExt.getSqPrincipal();
			 String newBusiness = aidExt.getNewBusiness();
			 String thesis = aidExt.getThesis();
			 String project = aidExt.getProject();
			 String other = aidExt.getOther();
			 String pjPrincipal = aidExt.getPjPrincipal();
			 String talentsFlow = aidExt.getTalentsFlow();
			if(StringUtil.isNotBlank(talentsFlow)){//修改
				GeneralMethod.setRecordInfo(aidExt, false);
				AidTalents findAid = this.aidTalentsMapper.selectByPrimaryKey(talentsFlow);
				if(findAid!=null&&StringUtil.isNotBlank(findAid.getTalentsContent())){
					
					Document dom = null; 
					try {
						dom = DocumentHelper.parseText(findAid.getTalentsContent());
					} catch (DocumentException e) {
						throw new RuntimeException(e.getMessage());
					}
					Element root = dom.getRootElement();
					if(mainCompose!=null){
						root.element("mainCompose").setText(mainCompose);
					}
					if(content!=null){
						root.element("content").setText(content);
					}
					if(wsjOpinion!=null){
						root.element("wsjOpinion").setText(wsjOpinion);
					}
					if(czjOpinion!=null){
						root.element("czjOpinion").setText(czjOpinion);
					}
					if(sqPrincipal!=null){
						root.element("sqPrincipal").setText(sqPrincipal);
					}
					if(newBusiness!=null){
						root.element("newBusiness").setText(newBusiness);
					}
					if(thesis!=null){
						root.element("thesis").setText(thesis);
					}
					if(project!=null){
						root.element("project").setText(project);
					}
					if(other!=null){
						root.element("other").setText(other);
					}
					if(pjPrincipal!=null){
						root.element("pjPrincipal").setText(pjPrincipal);
					}
					aidExt.setTalentsContent(dom.asXML());
				}
				return this.aidTalentsMapper.updateByPrimaryKeySelective(aidExt);
			}else{//新增
				aidExt.setTalentsFlow(PkUtil.getUUID());
				if(GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL.equals(aidExt.getRole())){//负责人
					aidExt.setStatusId(AidTalentsStatusEnum.Edit.getId());
					aidExt.setStatusName(AidTalentsStatusEnum.Edit.getName());
				}else{//科技处、主管部门、卫生局
					aidExt.setStatusId(AidTalentsStatusEnum.Passing.getId());
					aidExt.setStatusName(AidTalentsStatusEnum.Passing.getName());
				}
				aidExt.setAssessStatusId(AidAssessStatusEnum.Assessing.getId());
				aidExt.setAssessStatusName(AidAssessStatusEnum.Assessing.getName());
				GeneralMethod.setRecordInfo(aidExt, true);
				Document dom = DocumentHelper.createDocument();
				Element root = dom.addElement("talentsContent");
				root.addElement("mainCompose").setText(StringUtil.defaultIfEmpty(mainCompose, ""));
				root.addElement("content").setText(StringUtil.defaultIfEmpty(content, ""));
				root.addElement("wsjOpinion").setText(StringUtil.defaultIfEmpty(wsjOpinion, ""));
				root.addElement("czjOpinion").setText(StringUtil.defaultIfEmpty(czjOpinion, ""));
				root.addElement("sqPrincipal").setText(StringUtil.defaultIfEmpty(sqPrincipal, ""));
				root.addElement("newBusiness").setText(StringUtil.defaultIfEmpty(newBusiness, ""));
				root.addElement("thesis").setText(StringUtil.defaultIfEmpty(thesis, ""));
				root.addElement("project").setText(StringUtil.defaultIfEmpty(project, ""));
				root.addElement("other").setText(StringUtil.defaultIfEmpty(other, ""));
				root.addElement("pjPrincipal").setText(StringUtil.defaultIfEmpty(pjPrincipal, ""));
				aidExt.setTalentsContent(dom.asXML());
				return this.aidTalentsMapper.insertSelective(aidExt);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<AidTalents> queryList(AidTalents aid,List<String> orgFlowList) {
		AidTalentsExample example = new AidTalentsExample();
		Criteria criteria = example.createCriteria();
		if(aid!=null){
			if(StringUtil.isNotBlank(aid.getRecordStatus())){
				criteria.andRecordStatusEqualTo(aid.getRecordStatus());
			}
			if(StringUtil.isNotBlank(aid.getOrgName())){
				criteria.andOrgNameLike("%"+aid.getOrgName()+"%");
			}
			if(StringUtil.isNotBlank(aid.getDeptName())){
				criteria.andDeptNameLike("%"+aid.getDeptName()+"%");
			}
			if(StringUtil.isNotBlank(aid.getUserName())){
				criteria.andUserNameLike("%"+aid.getUserName()+"%");
			}
			if(StringUtil.isNotBlank(aid.getStudyName())){
				criteria.andStudyNameLike("%"+aid.getStudyName()+"%");
			}
			if(StringUtil.isNotBlank(aid.getUserFlow())){
				criteria.andUserFlowEqualTo(aid.getUserFlow());
			}
			if(StringUtil.isNotBlank(aid.getAssessStatusId())){
				criteria.andAssessStatusIdEqualTo(aid.getAssessStatusId());
			}
			String orgFlow = aid.getOrgFlow();
			if(orgFlowList!=null&&!orgFlowList.isEmpty()){//主管部门
				criteria.andOrgFlowIn(orgFlowList);
			}else if(StringUtil.isNotBlank(orgFlow)){
				criteria.andOrgFlowEqualTo(orgFlow);
			}
			if(StringUtil.isNotBlank(aid.getStatusId())){
				criteria.andStatusIdEqualTo(aid.getStatusId());
			}
			
		}
		example.setOrderByClause("create_time desc");
		return this.aidTalentsMapper.selectByExample(example);
	}

	@Override
	public AidTalentsExt query(String talentsFlow) throws RuntimeException {
		AidTalentsExt aidExt = null;
		AidTalents aid = this.aidTalentsMapper.selectByPrimaryKey(talentsFlow);
		if(aid!=null){
			aidExt = new AidTalentsExt();
			try{
				BeanUtil.copyProperties(aidExt, aid);
				String talentsContent = aid.getTalentsContent();
				if(StringUtil.isNotBlank(talentsContent)){
					Document dom = DocumentHelper.parseText(talentsContent);
					Element root = dom.getRootElement();
					aidExt.setMainCompose(root.elementText("mainCompose"));
					aidExt.setContent(root.elementText("content"));
					aidExt.setWsjOpinion(root.elementText("wsjOpinion"));
					aidExt.setCzjOpinion(root.elementText("czjOpinion"));
					aidExt.setSqPrincipal(root.elementText("sqPrincipal"));
					aidExt.setNewBusiness(root.elementText("newBusiness"));
					aidExt.setThesis(root.elementText("thesis"));
					aidExt.setProject(root.elementText("project"));
					aidExt.setOther(root.elementText("other"));
					aidExt.setPjPrincipal(root.elementText("pjPrincipal"));
				}
			}catch(Exception e){
				throw new RuntimeException(e.getMessage());
			}
			
		}
		return aidExt;
	}

	@Override
	public int edit(AidTalents aid) {
		if(aid!=null){
			if(StringUtil.isNotBlank(aid.getTalentsFlow())){//修改
				GeneralMethod.setRecordInfo(aid, false);
				return this.aidTalentsMapper.updateByPrimaryKeySelective(aid);
			}else{//新增
				aid.setTalentsFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(aid, true);
				aid.setAssessStatusId(AidAssessStatusEnum.Assessing.getId());
				aid.setAssessStatusName(AidAssessStatusEnum.Assessing.getName());
				return this.aidTalentsMapper.insertSelective(aid);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

}
