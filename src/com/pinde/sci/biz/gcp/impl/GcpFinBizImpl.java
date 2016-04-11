package com.pinde.sci.biz.gcp.impl;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpFinBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.GcpContractMapper;
import com.pinde.sci.dao.base.GcpFundMapper;
import com.pinde.sci.dao.gcp.GcpContractExtMapper;
import com.pinde.sci.dao.gcp.GcpFundExtMapper;
import com.pinde.sci.enums.gcp.GcpFundScaleEnum;
import com.pinde.sci.enums.gcp.GcpFundTypeEnum;
import com.pinde.sci.model.gcp.GcpContractExt;
import com.pinde.sci.model.mo.GcpContract;
import com.pinde.sci.model.mo.GcpContractExample;
import com.pinde.sci.model.mo.GcpContractExample.Criteria;
import com.pinde.sci.model.mo.GcpFund;
import com.pinde.sci.model.mo.GcpFundExample;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;

@Service
@Transactional(rollbackFor = Exception.class)
public class GcpFinBizImpl implements IGcpFinBiz {
	@Autowired
	private GcpContractMapper gcpContractMapper;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private GcpFundMapper gcpFundMapper;
	@Autowired
	private GcpFundExtMapper gcpFundExtMapper;
	@Autowired
	private GcpContractExtMapper contractExtMapper;

	@Override
	public int editContract(GcpContract cont,MultipartFile file) throws IOException {
		if(cont!=null){
			if(file!=null&&file.getSize()>0){
				PubFile pubFile = new PubFile();
				pubFile.setFileFlow(cont.getContractFile());
				pubFile.setFileName(file.getOriginalFilename());
				pubFile.setFileContent(file.getBytes());
				int result = this.fileBiz.editFile(pubFile);
				if(result == GlobalConstant.ZERO_LINE){
					return GlobalConstant.ZERO_LINE;
				}
				cont.setContractFile(pubFile.getFileFlow());
			}
			if(StringUtil.isNotBlank(cont.getContractFlow())){//修改
				GeneralMethod.setRecordInfo(cont, false);
				return this.gcpContractMapper.updateByPrimaryKeySelective(cont);
			}else{//新增
				cont.setContractFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(cont, true);
				return this.gcpContractMapper.insertSelective(cont);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<GcpContract> searchContList(GcpContract cont,String orderBy) {
		GcpContractExample example = new GcpContractExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(cont!=null){
			if(StringUtil.isNotBlank(cont.getProjFlow())){
				criteria.andProjFlowEqualTo(cont.getProjFlow());
			}
			if(StringUtil.isNotBlank(cont.getOrgFlow())){
				criteria.andOrgFlowEqualTo(cont.getOrgFlow());
			}
			if(StringUtil.isNotBlank(cont.getContractNo())){
				criteria.andContractNoEqualTo(cont.getContractNo());
			}
		}
		if(StringUtil.isEmpty(orderBy)||StringUtil.isBlank(orderBy)){
			orderBy = "STAMP_DATE DESC";
		}
		example.setOrderByClause(orderBy);
		return this.gcpContractMapper.selectByExample(example);
	}

	@Override
	public GcpContract searchContByFlow(String contractFlow) {
		return this.gcpContractMapper.selectByPrimaryKey(contractFlow);
	}

	@Override
	public int delContractFile(String contractFlow) {
		GcpContract cont = this.searchContByFlow(contractFlow);
		if(cont!=null){
			cont.setContractFile(null);
			return this.gcpContractMapper.updateByPrimaryKey(cont);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int delContract(String contractFlow) {
		if(StringUtil.isNotBlank(contractFlow)){
			GcpContract cont = new GcpContract();
			cont.setContractFlow(contractFlow);
			cont.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			return this.gcpContractMapper.updateByPrimaryKeySelective(cont);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public Map<String, Map<String, Object>> countContract(List<PubProj> projList,String contractNo) {
		Map<String, Map<String, Object>> countMap = null;
		if(projList!=null&&!projList.isEmpty()){
			countMap = new HashMap<String, Map<String, Object>>();
			GcpContract cont = null;
			for (PubProj proj : projList) {
				cont = new GcpContract();
				cont.setProjFlow(proj.getProjFlow());
				cont.setContractNo(contractNo);
				List<GcpContract> contList = this.searchContList(cont,null);
				if(contList!=null&&!contList.isEmpty()){
					long caseTotal = 0;//总例数
					BigDecimal fundTotal = new BigDecimal(0);//总经费
					for (GcpContract gcont : contList) {
						if (gcont.getCaseNumber() != null) {
							caseTotal += gcont.getCaseNumber();
						}
						if (gcont.getContractFund() != null) {
							fundTotal = fundTotal.add(gcont.getContractFund());
						}
					}
					Map<String, Object> itemMap = new HashMap<String, Object>();
					itemMap.put("caseTotal", caseTotal);
					itemMap.put("fundTotal", fundTotal);
					countMap.put(proj.getProjFlow(),itemMap);
				}
			}
		}
		return countMap;
	}

	@Override
	public GcpFund readFund(String fundFlow) {
		return gcpFundMapper.selectByPrimaryKey(fundFlow);
	}

	@Override
	public int saveFund(GcpFund gcpFund) {
	    if(StringUtil.isNotBlank(gcpFund.getFundFlow())){
	    	GeneralMethod.setRecordInfo(gcpFund, false);
	    	return this.gcpFundMapper.updateByPrimaryKeySelective(gcpFund);
	    }else{
	    	gcpFund.setFundFlow(PkUtil.getUUID());
	    	GeneralMethod.setRecordInfo(gcpFund, true);
	    	return this.gcpFundMapper.insertSelective(gcpFund);
	    }
	}

	@Override
	public Map<String, Map<String, Object>> countFund(List<PubProj> projList) {
		Map<String, Map<String, Object>> countMap = null;
		if(null != projList && !projList.isEmpty()){
			countMap = new HashMap<String, Map<String, Object>>();
			GcpFund gcpFund=null;
			
			for (PubProj proj : projList) {
				gcpFund = new GcpFund();
				gcpFund.setProjFlow(proj.getProjFlow());
				List<GcpFund> fundList = this.searchFundList(gcpFund);
				if(null != fundList && !fundList.isEmpty()){
					BigDecimal fundInTotal = new BigDecimal(0);
					BigDecimal fundOutTotal = new BigDecimal(0);
					BigDecimal fundRemainTotal = new BigDecimal(0);
					BigDecimal scaleInTotal=null;
					for(GcpFund fund:fundList){
						if(GcpFundTypeEnum.In.getId().equals(fund.getFundTypeId())){
							fundInTotal=fundInTotal.add(fund.getFundAmount());
						}else if(GcpFundTypeEnum.Out.getId().equals(fund.getFundTypeId())){
							fundOutTotal=fundOutTotal.add(fund.getFundAmount());
						}
						fundRemainTotal=fundInTotal.subtract(fundOutTotal);
					}
					Map<String, Object> itemMap = new HashMap<String, Object>();
					itemMap.put("fundInTotal", fundInTotal);
					itemMap.put("fundOutTotal",fundOutTotal);
					itemMap.put("fundRemainTotal",fundRemainTotal);
					for(GcpFundScaleEnum str:GcpFundScaleEnum.values()){
						scaleInTotal=new BigDecimal(0);
						double scale=Double.parseDouble(InitConfig.getSysCfg("gcp_fund_scale_"+str.getId()))/100;
						BigDecimal scaleDec=new BigDecimal(scale);
						scaleInTotal=fundInTotal.multiply(scaleDec).setScale(2,BigDecimal.ROUND_HALF_UP);
						itemMap.put(str.getId(),scaleInTotal);
					}
					
					countMap.put(proj.getProjFlow(),itemMap);
				}
			}
		}
		
		return countMap;
	}

	@Override
	public List<GcpFund> searchFundList(GcpFund gcpFund) {
		GcpFundExample example=new GcpFundExample();
		com.pinde.sci.model.mo.GcpFundExample.Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(gcpFund.getProjFlow())){
			criteria.andProjFlowEqualTo(gcpFund.getProjFlow());
		}
		if(StringUtil.isNotBlank(gcpFund.getFundTypeId())){
			criteria.andFundTypeIdEqualTo(gcpFund.getFundTypeId());
		}
		if(StringUtil.isNotBlank(gcpFund.getOrgFlow())){
			criteria.andOrgFlowEqualTo(gcpFund.getOrgFlow());
		}
		example.setOrderByClause("fund_date desc");
		return  gcpFundMapper.selectByExample(example);
	}

	@Override
	public Map<String,List<GcpFund>> fundMap(List<PubProj> projList) {
		Map<String,List<GcpFund>> fundMap=null;
		if(null != projList && !projList.isEmpty()){
			fundMap=new HashMap<String, List<GcpFund>>();
			GcpFund gcpFund=null;
			for (PubProj proj : projList) {
				gcpFund=new GcpFund();
				gcpFund.setProjFlow(proj.getProjFlow());
				List<GcpFund> fundList = this.searchFundList(gcpFund);
				fundMap.put(proj.getProjFlow(), fundList);
			}
		}
		return fundMap;
	}

	@Override
	public int delFund(String fundFlow) {
			GcpFund gcpFund=this.readFund(fundFlow);
			if(null!=gcpFund){
				gcpFund.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				GeneralMethod.setRecordInfo(gcpFund, false);
				return gcpFundMapper.updateByPrimaryKeySelective(gcpFund);
			}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public BigDecimal searchSumFund(GcpFund fund) {
		return this.gcpFundExtMapper.selectSum(fund);
	}

	@Override
	public GcpContract searchContByNo(String contractNo) {
		GcpContract contract = null;
		GcpContract cont = new GcpContract();
		cont.setContractNo(contractNo);
		List<GcpContract> contList = this.searchContList(cont, null);
		if(contList!=null&&!contList.isEmpty()){
			contract = contList.get(0);
		}
		return contract;
	}

	@Override
	public List<GcpContractExt> searchContractList(PubProj proj,
			GcpContract gcpContract) {
		Map<String,Object> map=new HashMap<String, Object>();
		if(null!=proj){
			map.put("proj", proj);
		}
		if(null!=gcpContract){
			map.put("contract", gcpContract);
		}
		
		return contractExtMapper.searchContractList(map);
	}

	@Override
	public List<GcpContract> searchContractList() {
		GcpContractExample example = new GcpContractExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return gcpContractMapper.selectByExample(example);
	}

	@Override
	public List<GcpContract> searchContractList(List<String> projFlowList) {
		if(projFlowList != null && !projFlowList.isEmpty()){
			GcpContractExample example = new GcpContractExample();
			example.createCriteria().andProjFlowIn(projFlowList).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			return gcpContractMapper.selectByExample(example);
		}
		return null;
	}
    
	
}
