package com.pinde.sci.biz.erp.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractBiz;
import com.pinde.sci.biz.erp.IErpContractRefBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ErpCrmContractRefMapper;
import com.pinde.sci.dao.erp.ErpCrmContractRefExtMapper;
import com.pinde.sci.enums.erp.ContractCategoryEnum;
import com.pinde.sci.model.erp.ErpCrmContractRefExt;
import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractRef;
import com.pinde.sci.model.mo.ErpCrmContractRefExample;
import com.pinde.sci.model.mo.ErpCrmContractRefExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class ErpContractRefBizImpl implements IErpContractRefBiz{

	@Autowired
	private ErpCrmContractRefMapper refMapper;
	@Autowired
	private ErpCrmContractRefExtMapper refExtMapper;
	@Autowired
	private IErpContractBiz contractBiz;
	
	@Override
	public String saveRefList(List<ErpCrmContractRef> refList,String contractFlow) {
		if(refList!=null && !refList.isEmpty() && StringUtil.isNotBlank(contractFlow)){
			for(ErpCrmContractRef ref:refList){
				ref.setSubContractFlow(contractFlow);
				if(StringUtil.isBlank(ref.getRecordFlow())){
					ref.setRecordFlow(PkUtil.getUUID());
					GeneralMethod.setRecordInfo(ref, true);
					int result=this.refMapper.insertSelective(ref);
					if(result!=GlobalConstant.ONE_LINE){
						return GlobalConstant.SAVE_FAIL;
					}
				}
				
			}
		
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}

	@Override
	public List<ErpCrmContractRefExt> searchContractListByRef(
			String subContractFlow,String contractFlow) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		if(StringUtil.isNotBlank(subContractFlow)){
			paramMap.put("subContractFlow", subContractFlow);
		}
		if(StringUtil.isNotBlank(contractFlow)){
			paramMap.put("contractFlow", contractFlow);
		}
		return this.refExtMapper.searchContractListByRef(paramMap);
	}

	@Override
	public List<ErpCrmContractRef> searchRefList(ErpCrmContractRef ref) {
		ErpCrmContractRefExample example=new ErpCrmContractRefExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(ref.getSubContractFlow())){
			criteria.andSubContractFlowEqualTo(ref.getSubContractFlow());
		}
		if(StringUtil.isNotBlank(ref.getContractFlow())){
			criteria.andContractFlowEqualTo(ref.getContractFlow());
		}
		return this.refMapper.selectByExample(example);
	}

	@Override
	public String updateOneContractRef(String contractFlow) {
		ErpCrmContract contract=this.contractBiz.readContract(contractFlow);
		if(contract!=null){
			ErpCrmContractRef contractRef=new ErpCrmContractRef();
			if(ContractCategoryEnum.Second.getId().equals(contract.getContractCategoryId())){
				contractRef.setSubContractFlow(contractFlow);
		    }else{
		    	contractRef.setContractFlow(contractFlow);	
		    }
			List<ErpCrmContractRef> refs=searchRefList(contractRef);
			if(refs!=null && !refs.isEmpty()){
				for(ErpCrmContractRef ref:refs){
					ref.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
					GeneralMethod.setRecordInfo(ref, false);
					int result=this.refMapper.updateByPrimaryKeySelective(ref);
					int resultCount=this.contractBiz.updateContractSubCount(contractFlow);
					if(result!=GlobalConstant.ONE_LINE){
						return GlobalConstant.SAVE_FAIL;
					}
					if(resultCount!=GlobalConstant.ONE_LINE){
						return GlobalConstant.SAVE_FAIL;
					}
				}
			}
		}
		
		return GlobalConstant.SAVE_SUCCESSED;
	}

	@Override
	public List<ErpCrmContractRef> searchAllRefList(ErpCrmContractRef ref) {
		ErpCrmContractRefExample example=new ErpCrmContractRefExample();
		Criteria criteria=example.createCriteria();
		if(StringUtil.isNotBlank(ref.getSubContractFlow())){
			criteria.andSubContractFlowEqualTo(ref.getSubContractFlow());
		}
		if(StringUtil.isNotBlank(ref.getContractFlow())){
			criteria.andContractFlowEqualTo(ref.getContractFlow());
		}
		return this.refMapper.selectByExample(example);
	}

}
