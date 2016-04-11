package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjMineBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjExample.Criteria;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.PubProjRecExample;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class ProjMineBizImpl implements IProjMineBiz {
	
	@Autowired
	private PubProjMapper pubProjMapper;	
	@Autowired
	private IProjRecBiz projRecBiz;	
	@Autowired
	private IProjProcessBiz projProcessBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IOrgBiz orgBiz;

	@Override
	public List<PubProj> searchProjList(PubProj proj) {
		PubProjExample projectExample  = new PubProjExample();
		projectExample.setOrderByClause("CREATE_TIME DESC");
		Criteria criteria =  projectExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		_pageConditionForSearchProj(proj, criteria);
		String projCateScope = (String)GlobalContext.getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		criteria.andProjCategoryIdEqualTo(projCateScope);
		return pubProjMapper.selectByExample(projectExample);
	}
	
	private void _pageConditionForSearchProj(PubProj proj, Criteria criteria) {
		if(StringUtil.isNotBlank(proj.getProjStageId())){
			criteria.andProjStageIdEqualTo(proj.getProjStageId());
		}
		if(StringUtil.isNotBlank(proj.getProjStatusId())){
			criteria.andProjStatusIdEqualTo(proj.getProjStatusId());
		}
		if(StringUtil.isNotBlank(proj.getProjName())){
			criteria.andProjNameLike("%"+proj.getProjName()+"%");
		}
		if(StringUtil.isNotBlank((proj.getProjNo()))){
			criteria.andProjNoEqualTo(proj.getProjNo());
		}
		if(StringUtil.isNotBlank((proj.getProjYear()))){
			criteria.andProjYearEqualTo(proj.getProjYear());
		}
		if(StringUtil.isNotBlank(proj.getProjTypeId())){
			criteria.andProjTypeIdEqualTo(proj.getProjTypeId());
		}
		if(StringUtil.isNotBlank(proj.getProjSubTypeId())){
			criteria.andProjSubTypeIdEqualTo(proj.getProjSubTypeId());
		}
		if(StringUtil.isNotBlank(proj.getApplyUserFlow())){
			criteria.andApplyUserFlowEqualTo(proj.getApplyUserFlow());
		}
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(proj.getApplyOrgFlow());
		}
	}
	
	@Override
	public List<PubProj> searchProjListForFund(PubProj proj) {
		PubProjExample proExample = new PubProjExample();
		Criteria proCriteria = proExample.createCriteria();
		
		/*实施阶段，结束阶段，成果阶段*/
		List<String> stageIds = new ArrayList<String>();
		stageIds.add(ProjStageEnum.Schedule.getId());
		stageIds.add(ProjStageEnum.Complete.getId());
		proCriteria.andProjStageIdIn(stageIds);
		proCriteria.andProjCategoryIdEqualTo(ProjCategroyEnum.Ky.getId());
		/*立项阶段*/
		Criteria proCriteria2 = proExample.createCriteria();
		proCriteria2.andProjStageIdEqualTo(ProjStageEnum.Approve.getId());
		proCriteria2.andProjStatusIdEqualTo(ProjApproveStatusEnum.Approve.getId());
		proCriteria2.andProjCategoryIdEqualTo(ProjCategroyEnum.Ky.getId());
		if(proj!=null){
			if(StringUtil.isNotBlank(proj.getProjName())){
				String projName = proj.getProjName();
				proCriteria.andProjNameLike("%"+projName+"%");
				proCriteria2.andProjNameLike("%"+projName+"%");
			}
			//TODO 项目来源
			if(StringUtil.isNotBlank(proj.getApplyUserName())){
				String applyUserName = proj.getApplyUserName();
				proCriteria.andApplyUserNameLike("%"+applyUserName+"%");
				proCriteria2.andApplyUserNameLike("%"+applyUserName+"%");
			}
		}
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(GlobalContext.getSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE))){
			String currentOrgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			proCriteria.andApplyOrgFlowEqualTo(currentOrgFlow);
			proCriteria2.andApplyOrgFlowEqualTo(currentOrgFlow);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL.equals(GlobalContext.getSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE))){
			String currentUserFlow = GlobalContext.getCurrentUser().getUserFlow();
			proCriteria.andApplyUserFlowEqualTo(currentUserFlow);
			proCriteria2.andApplyUserFlowEqualTo(currentUserFlow);
		}
		
		
		proExample.or(proCriteria2);
		return this.pubProjMapper.selectByExample(proExample);
	}
	
/*	private void _pageConditionForSearchProj(PubProj proj, Criteria criteria) {
		if(StringUtil.isNotBlank(proj.getProjStageId())){
			criteria.andProjStageIdEqualTo(proj.getProjStageId());
		}
		if(StringUtil.isNotBlank(proj.getProjName())){
			criteria.andProjNameLike("%"+proj.getProjName()+"%");
		}
		if(StringUtil.isNotBlank((proj.getProjNo()))){
			criteria.andProjNoEqualTo(proj.getProjNo());
		}
		if(StringUtil.isNotBlank((proj.getProjYear()))){
			criteria.andProjYearEqualTo(proj.getProjYear());
		}
		if(StringUtil.isNotBlank(proj.getProjTypeId())){
			criteria.andProjTypeIdEqualTo(proj.getProjTypeId());
		}
		if(StringUtil.isNotBlank(proj.getProjSubTypeId())){
			criteria.andProjSubTypeIdEqualTo(proj.getProjSubTypeId());
		}
	}*/
	
	@Override
	public void addProjInfo(PubProj proj) {
		SysUser currUser = GlobalContext.getCurrentUser();
		//1.新增proj信息
		proj.setProjFlow(PkUtil.getUUID());
		SysOrg org = this.orgBiz.readSysOrg(currUser.getOrgFlow());
		proj.setChargeOrgFlow(org.getChargeOrgFlow());
		proj.setChargeOrgName(org.getChargeOrgName());
		proj.setApplyUserFlow(currUser.getUserFlow());
		proj.setApplyUserName(currUser.getUserName());
		proj.setApplyOrgFlow(currUser.getOrgFlow());
		proj.setApplyOrgName(currUser.getOrgName());
		proj.setApplyDeptFlow(currUser.getDeptFlow());
		proj.setApplyDeptName(currUser.getDeptName());
//		proj.setProjShortName(PyUtil.getFirstSpell(proj.getProjName()));
		proj.setProjYear(DateUtil.getCurrDateTime("yyyy")); 
		
		//新增项目初始化 "申报" 阶段 ，"填写"状态
		proj.setProjStageId(ProjStageEnum.Apply.getId());
		proj.setProjStageName(ProjStageEnum.Apply.getName());
		proj.setProjStatusId(ProjApplyStatusEnum.Apply.getId());
		proj.setProjStatusName(ProjApplyStatusEnum.Apply.getName());
		
		//项目类别，子类别
//		proj.setProjTypeName(DictTypeEnum.getNameById(proj.getProjTypeId()));
//		proj.setProjSubTypeName(DictTypeEnum.sysDictIdMap.get(proj.getProjTypeId()+"."+ proj.getProjSubTypeId()));
		
		//record status
		GeneralMethod.setRecordInfo(proj,true);
		pubProjMapper.insert(proj);
		
		
		
		//2.新增rec空白信息
//		PubProjRec rec = new PubProjRec();
//		rec.setRecFlow(PkUtil.getUUID());
//		rec.setProjFlow(proj.getProjFlow());
//		rec.setProjStageId(proj.getProjStageId());
//		rec.setProjStageName(proj.getProjStageName());
//		rec.setProjStatusId(proj.getProjStatusId());
//		rec.setProjStatusName(proj.getProjStatusName());
//		rec.setRecTypeId(ProjRecTypeEnum.Apply.getId());
//		rec.setRecTypeName(ProjRecTypeEnum.Apply.getName());
//		rec.setOperUserFlow(currUser.getUserFlow());
//		rec.setOperUserName(currUser.getUserName());
//		rec.setOperTime(DateUtil.getCurrDateTime());
//		//record status
//		GeneralMethod.setRecordInfo(rec,true);
//		projRecBiz.addProjRec(rec);
		
		
		//3.新增process信息
		PubProjProcess process = new PubProjProcess();
		process.setProjFlow(proj.getProjFlow());
		process.setProjStageId(proj.getProjStageId());
		process.setProjStageName(proj.getProjStageName());
		process.setProjStatusId(proj.getProjStatusId());
		process.setProjStatusName(proj.getProjStatusName());
		projProcessBiz.addProcess(process);
		
		//return rec.getRecFlow();
	}


	@Override
	public List<PubProjRec> searchScheduleReport(String projFlow) {
		List<String> recTypeIdList = new ArrayList<String>();
		recTypeIdList.add(ProjRecTypeEnum.ScheduleReport.getId());
		recTypeIdList.add(ProjRecTypeEnum.ChangeReport.getId());
		recTypeIdList.add(ProjRecTypeEnum.DelayReport.getId());
		
		PubProjRecExample example = new PubProjRecExample();
		example.setOrderByClause("OPER_TIME DESC");
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andRecTypeIdIn(recTypeIdList)
		.andProjFlowEqualTo(projFlow);
		example.setOrderByClause("OPER_TIME desc");
		return projRecBiz.searchProjRec(example);
	}

	@Override
	public void addRecAndProcess(PubProjRec projRec) {
		SysUser currUser = GlobalContext.getCurrentUser();
		projRec.setOperUserFlow(currUser.getUserFlow());
		projRec.setOperUserName(currUser.getUserName());
		//将信息添加到rec中
		this.projRecBiz.addProjRec(projRec);

		//更新当前proj
		PubProj proj = new PubProj();
		proj.setProjFlow(projRec.getProjFlow());
		proj.setProjStageId(projRec.getProjStageId());
		proj.setProjStageName(projRec.getProjStageName());
		proj.setProjStatusId(projRec.getProjStatusId());
		proj.setProjStatusName(projRec.getProjStatusName());
		this.projBiz.modProject(proj);
		//在process中新增
		this.projProcessBiz.addProcess(projRec);
		
	}

	@Override
	public void delRecContent(String projFlow, String recTypeId) {
		PubProjRec projRec =  this.projRecBiz.selectProjRecByProjFlowAndRecType(projFlow, recTypeId);
		projRec.setRecContent("");
		this.projRecBiz.modProjRecWithXml(projRec);
		
	}

	@Override
	public void prepareReview(PubProjRec projRec) {
		//更新rec
		this.projRecBiz.modProjRec(projRec);
		//在过程表中新增
		this.projProcessBiz.addProcess(projRec);
		//按照proj_Flow 更新状态
		PubProj proj = new PubProj();
		proj.setProjFlow(projRec.getProjFlow());
		proj.setProjStatusId(projRec.getProjStatusId());
		proj.setProjStatusName(projRec.getProjStatusName());
		this.projBiz.modProject(proj);
		
	}

	@Override
	public void prepareReview(PubProj proj) {
		//按照proj_Flow 更新状态
		this.projBiz.modProject(proj);
		PubProjProcess process = new PubProjProcess();
		process.setProjFlow(proj.getProjFlow());
		process.setProjStageId(proj.getProjStageId());
		process.setProjStageName(proj.getProjStageName());
		process.setProjStatusId(proj.getProjStatusId());
		process.setProjStatusName(proj.getProjStatusName());
		this.projProcessBiz.addProcess(process);
		
	}

	@Override
	public List<PubProj> searchProjListForBudget(PubProj proj) {
		PubProjExample projectExample  = new PubProjExample();
		projectExample.setOrderByClause("CREATE_TIME DESC");
		Criteria criteria =  projectExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		_pageConditionForSearchProj(proj, criteria);
		criteria.andProjNoIsNotNull();
		//String projCateScope = (String)GlobalContext.getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		if(StringUtil.isNotBlank(proj.getProjCategoryId())){
			criteria.andProjCategoryIdEqualTo(proj.getProjCategoryId());	
		}
		return pubProjMapper.selectByExample(projectExample);
	}

	@Override
	public int searchProjCount(PubProj proj) {
		PubProjExample example = new PubProjExample();
		com.pinde.sci.model.mo.PubProjExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(proj.getProjYear())){
			criteria.andProjYearEqualTo(proj.getProjYear());
		}
		if(StringUtil.isNotBlank(proj.getApplyUserFlow())){
			criteria.andApplyUserFlowEqualTo(proj.getApplyUserFlow());
		}
		if(StringUtil.isNotBlank(proj.getProjCategoryId())){
			criteria.andProjCategoryIdEqualTo(proj.getProjCategoryId());
		}
		return pubProjMapper.countByExample(example);
	}
	
}
