package com.pinde.sci.biz.srm.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IPaymentBiz;
import com.pinde.sci.biz.srm.IProjMineBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.base.SrmFundProcessMapper;
import com.pinde.sci.dao.base.SrmFundSchemeDetailMapper;
import com.pinde.sci.dao.base.SrmProjFundDetailMapper;
import com.pinde.sci.dao.base.SrmProjFundInfoMapper;
import com.pinde.sci.dao.srm.ProjFundExtMapper;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.srm.ProjFundTypeEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmFundProcess;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmFundSchemeDetailExample;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundDetailExample;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.mo.SrmProjFundInfoExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.FundInfoExt;
import com.pinde.sci.model.srm.ProjFundDetailExt;
import com.pinde.sci.model.srm.PubProjExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class PaymentBizImpl implements IPaymentBiz{
	
	@Resource
	private SrmProjFundInfoMapper fundInfoMapper;
	@Resource
	private PubProjMapper pubProjMapper;
	@Resource
	private SrmProjFundDetailMapper fundDetailMapper;
	@Resource
	private SrmFundSchemeDetailMapper schemeDetailMapper;
	@Resource
	private SrmFundProcessMapper processMapper;
	@Autowired
	private ProjFundExtMapper projFundExtMapper;
	@Autowired
	private IProjMineBiz projMineBiz;
	

	@Override
	public List<FundInfoExt> queryPaymentList(PubProj proj) {
		SysUser currUser = GlobalContext.getCurrentUser();
		proj.setApplyUserFlow(currUser.getUserFlow());
		List<PubProj> proList = this.projMineBiz.searchProjListForBudget(proj);
		Map<String , PubProj> projMap = new HashMap<String, PubProj>(); 
		for (PubProj p : proList) {
			projMap.put(p.getProjFlow(), p);
		}
		SrmProjFundInfoExample fundExample  = new SrmProjFundInfoExample();
		List<SrmProjFundInfo> funds = new ArrayList<SrmProjFundInfo>();
		if(!projMap.isEmpty()){
			fundExample.createCriteria().andProjFlowIn(new ArrayList<String>(projMap.keySet())).andBudgetStatusIdEqualTo(AchStatusEnum.FirstAudit.getId());
			funds = this.fundInfoMapper.selectByExample(fundExample);
		}
		List<FundInfoExt> fundInfoExtList = new ArrayList<FundInfoExt>();
		for(SrmProjFundInfo fundInfo : funds){
			PubProj projForFundInfo = projMap.get(fundInfo.getProjFlow());
			FundInfoExt fundInfoExt = new FundInfoExt();
		    fundInfoExt.setFund(fundInfo);
			fundInfoExt.setProject(projForFundInfo);
			fundInfoExtList.add(fundInfoExt);
		}
		return fundInfoExtList;
		
	}

	@Override
	public List<SrmProjFundDetail> getDetailByFundFlow(String fundFlow) {
		SrmProjFundDetailExample example = new SrmProjFundDetailExample();
		example.createCriteria().andFundFlowEqualTo(fundFlow).andFundTypeIdEqualTo(ProjFundTypeEnum.Reimburse.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("CREATE_TIME");
		return fundDetailMapper.selectByExample(example);
	}

	@Override
	public void saveDetailList(String fundFlow,List<SrmProjFundDetail> detailList,SrmFundProcess fundProcess) {
		for(SrmProjFundDetail detail :detailList){
			if(detail!=null){
				//修改报销明细
				if(StringUtil.isNotBlank(detail.getFundDetailFlow())){
					SrmProjFundDetail findDetail = this.getDetailByDetailFlow(detail.getFundDetailFlow());
					if(findDetail==null||!AchStatusEnum.FirstAudit.getId().equals(findDetail.getOperStatusId())){
						GeneralMethod.setRecordInfo(detail, false);
						detail.setFundFlow(fundFlow);
						fundDetailMapper.updateByPrimaryKeySelective(detail);
					}
				}
				else{
					GeneralMethod.setRecordInfo(detail, true);
					detail.setFundDetailFlow(PkUtil.getUUID());
					//设项目经费流水号
					detail.setFundFlow(fundFlow);
					fundDetailMapper.insert(detail);
					//操作过程
					fundProcess.setFundProcessFlow(PkUtil.getUUID());
				    GeneralMethod.setRecordInfo(fundProcess, true);
				    fundProcess.setOperateTime(DateUtil.getCurrDateTime());
				    processMapper.insert(fundProcess);
				}
			}
		}
	}
	
	@Override
	public void reimburse(SrmProjFundDetail fundDetail) {
		String fundFlow = fundDetail.getFundFlow();
		//经费类型-->报销
		fundDetail.setFundTypeId(ProjFundTypeEnum.Reimburse.getId());
		fundDetail.setFundTypeName(ProjFundTypeEnum.Reimburse.getName());
		//操作-->提交
		fundDetail.setOperStatusId(AchStatusEnum.Submit.getId());
		fundDetail.setOperStatusName(AchStatusEnum.Submit.getName());
		
		if(StringUtil.isNotBlank(fundDetail.getFundDetailFlow())){
			SrmProjFundDetail findDetail = this.getDetailByDetailFlow(fundDetail.getFundDetailFlow());
			if(findDetail==null||!AchStatusEnum.FirstAudit.getId().equals(findDetail.getOperStatusId())){
				GeneralMethod.setRecordInfo(fundDetail, false);
				fundDetail.setFundFlow(fundFlow);
				fundDetailMapper.updateByPrimaryKeySelective(fundDetail);
			}
		}else{
			GeneralMethod.setRecordInfo(fundDetail, true);
			fundDetail.setFundDetailFlow(PkUtil.getUUID());
			//设项目经费流水号
			fundDetail.setFundFlow(fundFlow);
			fundDetailMapper.insert(fundDetail);
			
		}
		
		//封装过程对象
		SrmFundProcess fundProcess=new SrmFundProcess();
		fundProcess.setFundFlow(fundFlow);
		fundProcess.setFundDetailFlow(fundDetail.getFundDetailFlow());
		fundProcess.setOperStatusId(AchStatusEnum.Submit.getId());
		fundProcess.setOperStatusName(AchStatusEnum.Submit.getName());
		
		//操作过程
		fundProcess.setFundProcessFlow(PkUtil.getUUID());
	    GeneralMethod.setRecordInfo(fundProcess, true);
	    SysUser currUser = GlobalContext.getCurrentUser();
	    fundProcess.setOperateUserFlow(currUser.getUserFlow());
	    fundProcess.setOperateUserName(currUser.getUserName());
	    fundProcess.setOperateTime(DateUtil.getCurrDateTime());
	    processMapper.insert(fundProcess);
	}

	@Override
	public List<SrmFundSchemeDetail> getSchemeDetailBySchemeFlow(String schemeFlow) {
		SrmFundSchemeDetailExample example = new SrmFundSchemeDetailExample();
		example.createCriteria().andSchemeFlowEqualTo(schemeFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		return schemeDetailMapper.selectByExample(example);
	}


	@Override
	public List<ProjFundDetailExt> queryFundDetailAuditList(ProjFundDetailExt fundDetailExt) {
		SysUser currUser = GlobalContext.getCurrentUser();
		fundDetailExt.setRecordStatus(GlobalConstant.FLAG_Y);
		fundDetailExt.setFundTypeId(ProjFundTypeEnum.Reimburse.getId());
		List<String> statusIds = new ArrayList<String>();
		statusIds.add(AchStatusEnum.Submit.getId());
		statusIds.add(AchStatusEnum.FirstAudit.getId());
		fundDetailExt.setOperStatusIds(statusIds);
		PubProj proj =  fundDetailExt.getProj();
		if(proj==null){
			//是否增加所在单位
			proj = new PubProj();
			proj.setApplyOrgFlow(currUser.getOrgFlow());
			fundDetailExt.setProj(proj);
		}else{
			proj.setApplyOrgFlow(currUser.getOrgFlow());
		}
		return this.projFundExtMapper.selectProjFundDetailList(fundDetailExt);
	}

	@Override
	public SrmProjFundInfo getFundInfoByFundFlow(String fundFlow) {
		return fundInfoMapper.selectByPrimaryKey(fundFlow);
	}

	@Override
	public SrmProjFundDetail getDetailByDetailFlow(String fundDetailFlow) {
		return fundDetailMapper.selectByPrimaryKey(fundDetailFlow);
	}

	@Override
	public void updateDetailStatus(SrmProjFundDetail fundDetail,SrmFundProcess fundProcess) {
		if(StringUtil.isNotBlank(fundDetail.getFundDetailFlow())){
			GeneralMethod.setRecordInfo(fundDetail, false);
			//报销时间
			fundDetail.setProvideDateTime(DateUtil.getCurrDateTime());
			fundDetailMapper.updateByPrimaryKeySelective(fundDetail);
			if(StringUtil.isNotBlank(fundDetail.getFundDetailFlow())){
				fundProcess.setFundDetailFlow(fundDetail.getFundDetailFlow());
			}
			processMapper.insert(fundProcess);
			if(AchStatusEnum.FirstAudit.getId().equals(fundDetail.getOperStatusId())){
				//更新项目经费表
				SrmProjFundInfo fundInfo =  fundInfoMapper.selectByPrimaryKey(fundDetail.getFundFlow());
				//已报销金额=原来已报销的+现在报销的
				BigDecimal yetPayment = fundInfo.getYetPaymentAmount().add(fundDetail.getMoney());
				fundInfo.setYetPaymentAmount(yetPayment);
				//到账余额=实际到账-已报销
				fundInfo.setRealityBalance(fundInfo.getRealityAmount().subtract(yetPayment));
				this.fundInfoMapper.updateByPrimaryKeySelective(fundInfo);
			}
		}
	}

	@Override
	public SrmProjFundDetail searchBudgetDetail(String fundFlow, String itemFlow) {
		SrmProjFundDetailExample example = new SrmProjFundDetailExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y).
		andFundFlowEqualTo(fundFlow).
		andItemFlowEqualTo(itemFlow).
		andFundTypeIdEqualTo(ProjFundTypeEnum.Budget.getId());
		List<SrmProjFundDetail> resultList = this.fundDetailMapper.selectByExample(example);
		if(resultList.size()==1){
			return resultList.get(0);
		}
		return null;
	}

	@Override
	public int searchFundDetailNoApproveCount(SrmProjFundDetail fundDetail) {

		SrmProjFundDetailExample example = new SrmProjFundDetailExample();
		com.pinde.sci.model.mo.SrmProjFundDetailExample.Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		if(StringUtil.isNotBlank(fundDetail.getFundFlow())){
			criteria.andFundFlowEqualTo(fundDetail.getFundFlow());
		}
		if(StringUtil.isNotBlank(fundDetail.getFundTypeId())){
			criteria.andFundTypeIdEqualTo(fundDetail.getFundTypeId());
		}
		if(StringUtil.isNotBlank(fundDetail.getOperStatusId())){
			criteria.andOperStatusIdEqualTo(fundDetail.getOperStatusId());
		}
		return this.fundDetailMapper.countByExample(example );
	}

	
}
