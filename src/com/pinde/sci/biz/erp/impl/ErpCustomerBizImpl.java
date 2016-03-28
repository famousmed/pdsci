package com.pinde.sci.biz.erp.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractUserBiz;
import com.pinde.sci.biz.erp.IErpCustomerBiz;
import com.pinde.sci.biz.erp.IErpCustomerUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ErpCrmCustomerMapper;
import com.pinde.sci.dao.base.ErpCrmCustomerUserMapper;
import com.pinde.sci.dao.erp.ErpCrmCustomerExtMapper;
import com.pinde.sci.enums.erp.CustomerTypeEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.erp.CustomerUserForm;
import com.pinde.sci.form.erp.InputReportForm;
import com.pinde.sci.model.mo.ErpCrmContractUser;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerExample;
import com.pinde.sci.model.mo.ErpCrmCustomerExample.Criteria;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;
import com.pinde.sci.model.mo.ErpCrmCustomerUserExample;
@Service
@Transactional(rollbackFor = Exception.class)
public class ErpCustomerBizImpl implements IErpCustomerBiz, IErpCustomerUserBiz{
	@Autowired
	private ErpCrmCustomerMapper customerMapper;
	@Autowired
	private ErpCrmCustomerUserMapper customerUserMapper;
	@Autowired
	private ErpCrmCustomerExtMapper customerExtMapper;
	@Autowired
	private IErpContractUserBiz contractUserBiz;
 
	@Override
	public int saveCustomerAndUser(CustomerUserForm form) {
		if(form != null){
			ErpCrmCustomer customer = form.getCustomer();
			EditCustomer(customer);
			
			List<ErpCrmCustomerUser> customerUserList = form.getCustomerUserList();
			if(customerUserList != null && !customerUserList.isEmpty()){
				return  saveCustomerUserList(customerUserList, customer.getCustomerFlow());
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int saveCustomer(ErpCrmCustomer customer) {
		if(StringUtil.isNotBlank(customer.getCustomerFlow())){
			GeneralMethod.setRecordInfo(customer, false);
			return customerMapper.updateByPrimaryKeySelective(customer);
		}else{
			customer.setCustomerFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(customer, true);
			return customerMapper.insert(customer);
		}
	}

	@Override
	public int saveCustomerUser(ErpCrmCustomerUser customerUser) {
		if(StringUtil.isNotBlank(customerUser.getUserFlow())){
			ErpCrmCustomerUser user=this.readCustomerUser(customerUser.getUserFlow());
			if(user!=null){
				GeneralMethod.setRecordInfo(customerUser, false);
				return customerUserMapper.updateByPrimaryKeySelective(customerUser);
			}else{
				GeneralMethod.setRecordInfo(customerUser, true);
				return customerUserMapper.insert(customerUser);	
			}
		}else{
			customerUser.setUserFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(customerUser, true);
			return customerUserMapper.insert(customerUser);
		}
	}
	
	@Override
	public List<ErpCrmCustomerUser> searchCustomerUserList(ErpCrmCustomerUser customerUser) {
		ErpCrmCustomerUserExample example = new ErpCrmCustomerUserExample();
		com.pinde.sci.model.mo.ErpCrmCustomerUserExample.Criteria criteria = example.createCriteria().andRecordStatusNotEqualTo(GlobalConstant.RECORD_STATUS_D);
		if(StringUtil.isNotBlank(customerUser.getCustomerFlow())){
			criteria.andCustomerFlowEqualTo(customerUser.getCustomerFlow());
		}
		if(StringUtil.isNotBlank(customerUser.getUserName())){
			criteria.andUserNameLike("%" + customerUser.getUserName() + "%");
		}
		if(StringUtil.isNotBlank(customerUser.getDeptName())){
			criteria.andDeptNameLike("%" + customerUser.getDeptName() + "%");
		}
		if(StringUtil.isNotBlank(customerUser.getRecordStatus())){
			criteria.andRecordStatusEqualTo(customerUser.getRecordStatus());
		}
		example.setOrderByClause("RECORD_STATUS desc nulls last, IS_MAIN desc nulls last, NLSSORT(USER_NAME,'NLS_SORT = SCHINESE_PINYIN_M'), CREATE_TIME DESC");
		return customerUserMapper.selectByExample(example);
	}

	@Override
	public int saveCustomerUserList(List<ErpCrmCustomerUser> customerUserList, String customerFlow){
		if(customerUserList != null && !customerUserList.isEmpty() && StringUtil.isNotBlank(customerFlow)){
			for(ErpCrmCustomerUser user :customerUserList){
				if(StringUtil.isNotBlank(user.getSexId())){
					user.setSexName(UserSexEnum.getNameById(user.getSexId()));
				}else{
					user.setSexName("");
				}
				user.setCustomerFlow(customerFlow);
				saveCustomerUser(user);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public ErpCrmCustomer readCustomer(String customerFlow) {
		if(StringUtil.isNotBlank(customerFlow)){
			return customerMapper.selectByPrimaryKey(customerFlow);
		}
		return null;
	}

	@Override
	public int EditCustomer(ErpCrmCustomer customer) {
		if(customer != null){
			String customerTypeId = customer.getCustomerTypeId();
			if(StringUtil.isNotBlank(customerTypeId)){
				customer.setCustomerTypeName(CustomerTypeEnum.getNameById(customer.getCustomerTypeId()));
				//客户类别
				if(CustomerTypeEnum.Hospital.getId().equals(customerTypeId)){
					//医院级别
					if(StringUtil.isNotBlank(customer.getHospitalGradeId())){
						customer.setHospitalGradeName(DictTypeEnum.HospitalGrade.getDictNameById(customer.getHospitalGradeId()));
					}else{
						customer.setHospitalGradeName("");
					}
					if(StringUtil.isNotBlank(customer.getHospitalLevelId())){
						customer.setHospitalLevelName(DictTypeEnum.HospitalLevel.getDictNameById(customer.getHospitalLevelId()));
					}else{
						customer.setHospitalLevelName("");
					}
					//医院类型
					if(StringUtil.isNotBlank(customer.getHospitalTypeId())){
						String hospitalTypeId = customer.getHospitalTypeId();
						String[] hospitalTypeIds = hospitalTypeId.split(",");
						List<String> hospitalTypeIdList = Arrays.asList(hospitalTypeIds);
						StringBuffer hospitalTypeName = new StringBuffer("");
						for(int i = 0; i < hospitalTypeIdList.size();i++){
							String typeName = DictTypeEnum.HospitalType.getDictNameById(hospitalTypeIdList.get(i));
							if(i==0){
								hospitalTypeName.append(typeName);
							}else{
								hospitalTypeName.append("、").append(typeName);
							}
						}
						customer.setHospitalTypeName(hospitalTypeName.toString());
					}else{
						customer.setHospitalTypeId("");
						customer.setHospitalTypeName("");
					}
					clearSchoolType(customer);
				}
				else if(CustomerTypeEnum.School.getId().equals(customerTypeId)){
					if(StringUtil.isNotBlank(customer.getSchoolTypeId())){
						customer.setSchoolTypeName(DictTypeEnum.SchoolType.getDictNameById(customer.getSchoolTypeId()));
					}else{
						clearSchoolType(customer);
					}
					clearHospitalGradeLevel(customer);
				}
				else{
					clearHospitalGradeLevel(customer);
					clearSchoolType(customer);
				}
			}else{
				customer.setCustomerTypeId("");
				customer.setCustomerTypeName("");
			}
			
			String isContract = customer.getIsContract();
			if(StringUtil.isNotBlank(isContract)){
				if(GlobalConstant.RECORD_STATUS_Y.equals(isContract)){
					if(StringUtil.isNotBlank(customer.getCustomerGradeId())){
						customer.setCustomerGradeName(DictTypeEnum.CustomerGrade.getDictNameById(customer.getCustomerGradeId()));
					}else{
						clearCustomerGrade(customer);
					}
				}else{
					clearCustomerGrade(customer);
				}
			}else{
				customer.setIsContract("");
				clearCustomerGrade(customer);
			}
			
			return saveCustomer(customer);
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	//清空客户级别
	private void clearCustomerGrade(ErpCrmCustomer customer) {
		customer.setCustomerGradeId("");
		customer.setCustomerGradeName("");
	}

	//清空学校类型
	private void clearSchoolType(ErpCrmCustomer customer) {
		customer.setSchoolTypeId("");
		customer.setSchoolTypeName("");
	}

	//清空医院等级、类型
	private void clearHospitalGradeLevel(ErpCrmCustomer customer) {
		customer.setHospitalGradeId("");
		customer.setHospitalGradeName("");
		customer.setHospitalLevelId("");
		customer.setHospitalLevelName("");
		customer.setHospitalTypeId("");
		customer.setHospitalTypeName("");
	}

	@Override
	public ErpCrmCustomerUser readCustomerUser(String userFlow) {
		if(StringUtil.isNotBlank(userFlow)){
			return customerUserMapper.selectByPrimaryKey(userFlow);
		}
		return null;
	}

	@Override
	public List<ErpCrmCustomer> searchCustomerList(Map<String, Object> paramMap) {
		return customerExtMapper.searchCustomerList(paramMap);
	}

	@Override
	public ErpCrmCustomer findCustomerByCustomerName(String customerName) {
		if(StringUtil.isNotBlank(customerName)){
			ErpCrmCustomerExample example = new ErpCrmCustomerExample();
			example.createCriteria().andCustomerNameEqualTo(customerName).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			List<ErpCrmCustomer> customerList = customerMapper.selectByExample(example);
			if(customerList != null && !customerList.isEmpty()){
				return customerList.get(0);
			}
		}
		return null;
	}

	@Override
	public List<ErpCrmCustomerUser> searchUsersByUserFlows(String userFlows) {
		List<ErpCrmCustomerUser> userList=new ArrayList<ErpCrmCustomerUser>();
	    if(StringUtil.isNotBlank(userFlows)){
	    	String [] flowArray=userFlows.split(",");
	    	if(flowArray!=null){
	    		for(String userFlow:flowArray){
	    			ErpCrmCustomerUser user=readCustomerUser(userFlow);
	    			if(user!=null){
	    				userList.add(user);
	    			}
	    		}
	    	}
	    }
		return userList;
	}

	@Override
	public List<ErpCrmCustomer> searchCustomer(ErpCrmCustomer customer) {
		ErpCrmCustomerExample example=new ErpCrmCustomerExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(customer.getCustomerTypeId())){
			criteria.andCustomerTypeIdEqualTo(customer.getCustomerTypeId());
		}
		return customerMapper.selectByExample(example);
	}

	@Override
	public List<InputReportForm> searchCrmInput(Map<String, Object> paramMap) {
		return customerExtMapper.searchCrmInput(paramMap);
	}
	
	@Override
	public List<ErpCrmCustomerUser> searchCustomerUsers(String customerFlow,String userName) {
		ErpCrmCustomerUserExample example = new ErpCrmCustomerUserExample();
		com.pinde.sci.model.mo.ErpCrmCustomerUserExample.Criteria criteria = example.createCriteria().andRecordStatusNotEqualTo(GlobalConstant.RECORD_STATUS_D);
		if(StringUtil.isNotBlank(customerFlow)){
			criteria.andCustomerFlowEqualTo(customerFlow);
		}
		if(StringUtil.isNotBlank(userName)){
			criteria.andUserNameEqualTo(userName);
		}
		return customerUserMapper.selectByExample(example);
	}

	@Override
	public List<ErpCrmCustomerUser> searchCustomerUserList(
			List<String> userFlowList) {
		return this.customerExtMapper.searchCustomerUserList(userFlowList);
	}

	@Override
	public String deleteCustomerUser(String userFlow) {
		if(StringUtil.isNotBlank(userFlow)){
			ErpCrmCustomerUser customerUser = new ErpCrmCustomerUser();
			customerUser.setUserFlow(userFlow);
			customerUser.setRecordStatus(GlobalConstant.RECORD_STATUS_D);
			int result = saveCustomerUser(customerUser);
			if(result!=GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_FAIL;
			}
			ErpCrmContractUser contractUser=new ErpCrmContractUser();
			contractUser.setUserFlow(userFlow);
			List<ErpCrmContractUser> contractUserList=this.contractUserBiz.searchContractUserList(contractUser);
			if(contractUserList!=null && !contractUserList.isEmpty()){
				for(ErpCrmContractUser user:contractUserList){
					user.setRecordStatus(GlobalConstant.RECORD_STATUS_D);
					int res=this.contractUserBiz.saveContractUser(user);
					if(res!=GlobalConstant.ONE_LINE){
						return GlobalConstant.DELETE_FAIL;
					}
				}
			}
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	@Override
	public int updateCustomerUser(ErpCrmCustomerUser customerUser) {
		saveCustomerUser(customerUser);
		ErpCrmContractUser contractUser=new ErpCrmContractUser();
		contractUser.setUserFlow(customerUser.getUserFlow());
		List<ErpCrmContractUser> contractUserList=this.contractUserBiz.searchContractUserList(contractUser);
		if(contractUserList!=null && !contractUserList.isEmpty()){
			for(ErpCrmContractUser user:contractUserList){
				user.setRecordStatus(customerUser.getRecordStatus());
				this.contractUserBiz.saveContractUser(user);
			}
		}
		return GlobalConstant.ONE_LINE;
	}
	
}
