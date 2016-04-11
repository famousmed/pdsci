package com.pinde.sci.biz.erp.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractUserBiz;
import com.pinde.sci.biz.erp.IErpContractUserRefBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ErpCrmContractUserMapper;
import com.pinde.sci.dao.base.ErpCrmCustomerUserMapper;
import com.pinde.sci.dao.erp.ErpCrmContractUserExtMapper;
import com.pinde.sci.enums.erp.UserCategoryEnum;
import com.pinde.sci.model.erp.ErpCrmContractUserExt;
import com.pinde.sci.model.mo.ErpCrmContractUser;
import com.pinde.sci.model.mo.ErpCrmContractUserExample;
import com.pinde.sci.model.mo.ErpCrmContractUserRef;
import com.pinde.sci.model.mo.ErpCrmContractUserExample.Criteria;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class ErpContractUserBizImpl implements IErpContractUserBiz{

	@Autowired
	private ErpCrmContractUserMapper userMapper;
	@Autowired
	private IErpContractUserRefBiz userRefBiz;
	@Autowired
	private ErpCrmCustomerUserMapper customerUserMapper;
	@Autowired
	private ErpCrmContractUserExtMapper contractUserExtMapper;

	@Override
	public String saveCustomerAndContractUser(List<ErpCrmCustomerUser> customerUserList,String contractFlow) {
		 List<ErpCrmContractUser> contractUserList=new ArrayList<ErpCrmContractUser>();
		 List<ErpCrmContractUser> nowContractUserList=searchContractUsers(contractFlow, "");
		 List<String> nowContractUserFlowList=new ArrayList<String>();
		 if(nowContractUserList!=null && !nowContractUserList.isEmpty()){
			 for(ErpCrmContractUser user:nowContractUserList){
				 nowContractUserFlowList.add(user.getUserFlow());
			 }
		 }
		 int result;
		 if(customerUserList!=null && !customerUserList.isEmpty()){
			ErpCrmContractUser contractUser=null;
			for(ErpCrmCustomerUser user:customerUserList){
				if(StringUtil.isNotBlank(user.getUserFlow())){
					GeneralMethod.setRecordInfo(user, false);
					result=customerUserMapper.updateByPrimaryKeySelective(user);
					if(result==GlobalConstant.ZERO_LINE){
						return GlobalConstant.SAVE_FAIL;
					}
				}else{
					user.setUserFlow(PkUtil.getUUID());
					GeneralMethod.setRecordInfo(user, true);
					result=customerUserMapper.insertSelective(user);
					if(result==GlobalConstant.ZERO_LINE){
						return GlobalConstant.SAVE_FAIL;
					}
				
			    }
				if(result==GlobalConstant.ONE_LINE && !nowContractUserFlowList.contains(user.getUserFlow())){
					contractUser=new ErpCrmContractUser();
					contractUser.setContractFlow(contractFlow);
					contractUser.setUserFlow(user.getUserFlow());
					contractUserList.add(contractUser);
			}
		}
		 }	 
		 if(contractUserList!=null && !contractUserList.isEmpty()){
			 for(ErpCrmContractUser u:contractUserList){
				 u.setRecordFlow(PkUtil.getUUID());
				 GeneralMethod.setRecordInfo(u, true);
				 result=this.userMapper.insertSelective(u);
				 if(result==GlobalConstant.ZERO_LINE){
				    return GlobalConstant.SAVE_FAIL;
				 }
			 }
		 }
		return GlobalConstant.SAVE_SUCCESSED;
	}
     
	
	@Override
	public List<ErpCrmContractUser> searchContractUserList(
			ErpCrmContractUser user) {
		ErpCrmContractUserExample example=new ErpCrmContractUserExample();
		Criteria criteria=example.createCriteria().andRecordStatusNotEqualTo(GlobalConstant.RECORD_STATUS_D);
		if(StringUtil.isNotBlank(user.getContractFlow())){
			criteria.andContractFlowEqualTo(user.getContractFlow());
		}
		if(StringUtil.isNotBlank(user.getDeptName())){
			criteria.andDeptNameLike("%"+user.getDeptName()+"%");
		}
		if(StringUtil.isNotBlank(user.getUserName())){
			criteria.andUserNameLike("%"+user.getUserName()+"%");
		}
		if(StringUtil.isNotBlank(user.getRecordStatus())){
			criteria.andRecordStatusEqualTo(user.getRecordStatus());
		}
		if(StringUtil.isNotBlank(user.getUserFlow())){
			criteria.andUserFlowEqualTo(user.getUserFlow());
		}
		if(StringUtil.isNotBlank(user.getUserCategoryId())){
			criteria.andUserCategoryIdLike("%"+user.getUserCategoryId()+"%");
		}
		example.setOrderByClause("record_status desc nulls last,is_main desc nulls last,NLSSORT(USER_NAME,'NLS_SORT = SCHINESE_PINYIN_M')");
		return this.userMapper.selectByExample(example);
	}


	@Override
	public int saveOneContractUser(ErpCrmContractUser contractUser,ErpCrmCustomerUser customerUser) {
		if(contractUser!=null){
			//设置人员类别
			Boolean refFlag = true;
			if(StringUtil.isNotBlank(contractUser.getUserCategoryId())){
				String userCategoryName="";
				String [] userCategoryArray=contractUser.getUserCategoryId().split(",");
			    for(int i=0;i<userCategoryArray.length;i++){
			    	if(userCategoryArray.length-1==i){
			    		userCategoryName+=UserCategoryEnum.getNameById(userCategoryArray[i]);
			    	}else{
			    		userCategoryName+=UserCategoryEnum.getNameById(userCategoryArray[i]);
			    		userCategoryName+=",";
			    	}
			    }
			    contractUser.setUserCategoryName(userCategoryName);
			    if (StringUtil.contains(contractUser.getUserCategoryId(),UserCategoryEnum.User.getId())) {
			    	refFlag = false;
				}
			}else{
				contractUser.setUserCategoryId("");
				contractUser.setUserCategoryName("");
			}
			//删除使用人/产品关联
			if (refFlag) {
				ErpCrmContractUserRef temp = new ErpCrmContractUserRef();
				temp.setUserRecordFlow(contractUser.getRecordFlow());
				temp.setUserCategoryId(UserCategoryEnum.User.getId());
				List<ErpCrmContractUserRef> userRefList = userRefBiz.searchContractUserRefList(temp);
				if (userRefList != null && userRefList.size() >0) {
					for (ErpCrmContractUserRef tem:userRefList) {
						tem.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						userRefBiz.saveContractUserRef(tem);
					}
				}
			}
		}
		if(customerUser!=null){
        	if(StringUtil.isBlank(contractUser.getSexId())){
				contractUser.setSexName("");
			}
        	customerUser.setIsMain("");
        	if(StringUtil.isNotBlank(customerUser.getUserFlow())){
        		GeneralMethod.setRecordInfo(customerUser, false);
        		int result=this.customerUserMapper.updateByPrimaryKeySelective(customerUser);
        		if(result!=GlobalConstant.ONE_LINE){
        			return GlobalConstant.ZERO_LINE;
        		}else{
        			GeneralMethod.setRecordInfo(contractUser, false);
        			result=this.userMapper.updateByPrimaryKeySelective(contractUser);
        			if(result!=GlobalConstant.ONE_LINE){
            			return GlobalConstant.ZERO_LINE;
            		}
        		}
        	}else{
        		customerUser.setUserFlow(PkUtil.getUUID());
        		GeneralMethod.setRecordInfo(customerUser, true);
        		int result=this.customerUserMapper.insertSelective(customerUser);
        		if(result!=GlobalConstant.ONE_LINE){
        			return GlobalConstant.ZERO_LINE;
        		}else{
        			contractUser.setRecordFlow(PkUtil.getUUID());
        			contractUser.setUserFlow(customerUser.getUserFlow());
        			GeneralMethod.setRecordInfo(contractUser, true);
        			result=this.userMapper.insertSelective(contractUser);
        			if(result!=GlobalConstant.ONE_LINE){
            			return GlobalConstant.ZERO_LINE;
            		}
        		}
        	}
		}
                return GlobalConstant.ONE_LINE;		
	}

    
	@Override
	public int saveContractUser(ErpCrmContractUser user) {
		if(StringUtil.isNotBlank(user.getRecordFlow())){
			GeneralMethod.setRecordInfo(user, false);
			return this.userMapper.updateByPrimaryKeySelective(user);
		}else{
			user.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(user, true);
			return this.userMapper.insertSelective(user);
		}
	}

	
	@Override
	public ErpCrmContractUser readContractUser(String recordFlow) {
	    return this.userMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public List<ErpCrmContractUser> searchContractUsers(String contractFlow,String userName) {
		ErpCrmContractUserExample example=new ErpCrmContractUserExample();
		Criteria criteria=example.createCriteria().andRecordStatusNotEqualTo(GlobalConstant.RECORD_STATUS_D);
		if(StringUtil.isNotBlank(contractFlow)){
			criteria.andContractFlowEqualTo(contractFlow);
		}
		if(StringUtil.isNotBlank(userName)){
			criteria.andUserNameEqualTo(userName);
		}
		return this.userMapper.selectByExample(example);
	}
	
	@Override
	public String updateContractUsers(String recordFlows[]) {
		if (recordFlows != null && recordFlows.length>0) {
			ErpCrmContractUser user = new ErpCrmContractUser();
			for (String recordFlow:recordFlows) {
				user.setRecordFlow(recordFlow);
				user.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				GeneralMethod.setRecordInfo(user, false);
				this.userMapper.updateByPrimaryKeySelective(user);
			}
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}


	@Override
	public int deleteContractUser(String recordFlow) {
		ErpCrmContractUser user=this.readContractUser(recordFlow);
		if(user!=null){
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_D);
			GeneralMethod.setRecordInfo(user, false);
			return this.userMapper.updateByPrimaryKeySelective(user);
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public void updateUser(ErpCrmContractUser user,Boolean newUser,ErpCrmContractUserRef userRef,List<ErpCrmContractUserRef> userRefList) {
		if (newUser) {
			this.userMapper.insertSelective(user);
		} else {
			GeneralMethod.setRecordInfo(user, false);
			this.userMapper.updateByPrimaryKeySelective(user);
		}
		if(userRef != null){
			userRefBiz.saveContractUserRef(userRef);
		}
		if (userRefList != null && userRefList.size() >0) {
			for (ErpCrmContractUserRef temp:userRefList) {
				temp.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				userRefBiz.saveContractUserRef(temp);
			}
		}
	}


	@Override
	public List<ErpCrmContractUserExt> searchContractUserExtList(
			Map<String, Object> paramMap) {
		return this.contractUserExtMapper.searchContractUserExtList(paramMap);
	}

	/**
	 * 查询合同联系人人员类别（商务或技术负责人）
	 * @param contractFlow
	 * @return
	 */
	@Override
	public Map<String,String> searchUserCategoryMap(String contractFlow){
		Map<String,String> userCategoryMap=new HashMap<String, String>();
		if(StringUtil.isNotBlank(contractFlow)){
			ErpCrmContractUser contractUser=new ErpCrmContractUser();
			contractUser.setContractFlow(contractFlow);
			List<ErpCrmContractUser> userList=searchContractUserList(contractUser);
			if(userList!=null && !userList.isEmpty()){
				for(ErpCrmContractUser user:userList){
					userCategoryMap.put(user.getUserFlow(), user.getUserCategoryName());
				}
			}
		}
		return userCategoryMap;
	}
}
