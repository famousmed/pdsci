package com.pinde.sci.biz.erp.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractBiz;
import com.pinde.sci.biz.erp.IErpContractPayPlanBiz;
import com.pinde.sci.biz.erp.IErpContractProductBiz;
import com.pinde.sci.biz.erp.IErpContractRefBiz;
import com.pinde.sci.biz.erp.IErpContractUserBiz;
import com.pinde.sci.biz.erp.IErpContractUserRefBiz;
import com.pinde.sci.biz.erp.IErpCrmContractPayBalanceBiz;
import com.pinde.sci.biz.erp.IErpCustomerBiz;
import com.pinde.sci.biz.erp.IErpCustomerUserBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ErpCrmContractMapper;
import com.pinde.sci.dao.base.SysCfgMapper;
import com.pinde.sci.dao.erp.ErpCrmContractExtMapper;
import com.pinde.sci.enums.erp.ContractCategoryEnum;
import com.pinde.sci.enums.erp.UserCategoryEnum;
import com.pinde.sci.model.erp.ErpCrmContractExt;
import com.pinde.sci.model.erp.ErpCrmContractRefExt;
import com.pinde.sci.model.erp.ErpCrmContractUserExt;
import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractExample;
import com.pinde.sci.model.mo.ErpCrmContractExample.Criteria;
import com.pinde.sci.model.mo.ErpCrmContractPayBalance;
import com.pinde.sci.model.mo.ErpCrmContractPayPlan;
import com.pinde.sci.model.mo.ErpCrmContractProduct;
import com.pinde.sci.model.mo.ErpCrmContractRef;
import com.pinde.sci.model.mo.ErpCrmContractUserRef;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.SysCfg;

@Service
@Transactional(rollbackFor = Exception.class)
public class ErpContractBizImpl implements IErpContractBiz{
    
	@Autowired
	private ErpCrmContractMapper contractMapper;
	@Autowired
	private IErpContractProductBiz productBiz;
	@Autowired
	private IErpContractUserBiz contractUserBiz;
	@Autowired
	private IErpContractPayPlanBiz payPlanBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private ErpCrmContractExtMapper contractExtMapper;
	@Autowired
	private IErpContractRefBiz refBiz;
	@Autowired
	private IErpCustomerBiz customerBiz;
	@Autowired
	private IErpCustomerUserBiz customerUserBiz;
	@Resource
	private SysCfgMapper sysCfgMapper;
	@Autowired
	private IErpCrmContractPayBalanceBiz payBalanceBiz;
	@Autowired
	private IErpContractUserRefBiz contractUserRefBiz;
	
	@Override
	public List<ErpCrmContract> searchErpContractList(ErpCrmContract contract) {
		ErpCrmContractExample example=new ErpCrmContractExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(contract.getContractFlow())){
			criteria.andContractFlowNotEqualTo(contract.getContractFlow());
		}
		if(StringUtil.isNotBlank(contract.getContractName())){
			criteria.andContractNameLike("%"+contract.getContractName()+"%");
		}
		if(StringUtil.isNotBlank(contract.getContractNo())){
			criteria.andContractNoEqualTo(contract.getContractNo());
		}
		if(StringUtil.isNotBlank(contract.getCustomerFlow())){
			criteria.andCustomerFlowEqualTo(contract.getCustomerFlow());
		}
		if(StringUtil.isNotBlank(contract.getChargeUserFlow())){
			criteria.andChargeUserFlowEqualTo(contract.getChargeUserFlow());
		}
		example.setOrderByClause("SIGN_DATE desc");
		return contractMapper.selectByExample(example);
	}

	@Override
	public List<ErpCrmContract> searchErpContracts(ErpCrmContract contract) {
		ErpCrmContractExample example=new ErpCrmContractExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(contract.getContractFlow())){
			criteria.andContractFlowNotEqualTo(contract.getContractFlow());
		}
		if(StringUtil.isNotBlank(contract.getContractName())){
			criteria.andContractNameLike("%"+contract.getContractName()+"%");
		}
		if(StringUtil.isNotBlank(contract.getContractNo())){
			criteria.andContractNoEqualTo(contract.getContractNo());
		}
		if(StringUtil.isNotBlank(contract.getCustomerFlow())){
			criteria.andCustomerFlowEqualTo(contract.getCustomerFlow());
			Criteria criteria2=example.createCriteria().andConsumerFlowEqualTo(contract.getCustomerFlow());
			example.or(criteria2);
		}
		if(StringUtil.isNotBlank(contract.getChargeUserFlow())){
			criteria.andChargeUserFlowEqualTo(contract.getChargeUserFlow());
		}
		if(StringUtil.isNotBlank(contract.getSignDeptFlow())){
			criteria.andSignDeptFlowEqualTo(contract.getSignDeptFlow());
		}
		example.setOrderByClause("SIGN_DATE desc");
		return contractMapper.selectByExample(example);
	}
	
	@Override
	public String saveContractInfo(ErpCrmContract contract,
			List<ErpCrmContractProduct> productList,
			List<ErpCrmCustomerUser> userList, MultipartFile file,
			List<ErpCrmContractPayPlan> payPlanList,
			List<ErpCrmContractRef> refList) {
		    String contractFlow="";
		    //保存合同和文件
		    if(contract!=null){
		    	contractFlow=saveContract(contract,file);
		    	if(GlobalConstant.SAVE_FAIL.equals(contractFlow)){
		    		return GlobalConstant.SAVE_FAIL;
		    	}
		    }
		    //保存该合同的产品
		    if(productList!=null && !productList.isEmpty()){
		    	String result=this.productBiz.saveContractProduct(productList,contractFlow);
		    	if(!GlobalConstant.SAVE_SUCCESSED.equals(result)){
		    		return GlobalConstant.SAVE_FAIL;
		    	}
		    }
		    //保存该合同的联系人
		    if(userList!=null && !userList.isEmpty()){
		    	String result=this.contractUserBiz.saveCustomerAndContractUser(userList,contractFlow);
		    	if(!GlobalConstant.SAVE_SUCCESSED.equals(result)){
		    		return GlobalConstant.SAVE_FAIL;
		    	}
		    }
		    //保存该合同的回款计划
		    if(payPlanList!=null && !payPlanList.isEmpty()){
		    	String result=this.payPlanBiz.saveContractPayPlan(payPlanList,contractFlow);
		    	if(!GlobalConstant.SAVE_SUCCESSED.equals(result)){
		    		return GlobalConstant.SAVE_FAIL;
		    	}
		    }
		    if(refList!=null && !refList.isEmpty()){
		    	String result=this.refBiz.saveRefList(refList, contractFlow);
		    	if(!GlobalConstant.SAVE_SUCCESSED.equals(result)){
		    		return GlobalConstant.SAVE_FAIL;
		    	}
		    }
		    int result=updateContractSubCount(contractFlow);
		    if(result!=GlobalConstant.ONE_LINE){
		    	return GlobalConstant.SAVE_FAIL;
		    }
		    return contractFlow;
	}
    
	@Override
	public int updateContractSubCount(String contractFlow) {
    		ErpCrmContractRef refCondition=new ErpCrmContractRef();
    		refCondition.setSubContractFlow(contractFlow);
    		List<ErpCrmContractRef> refList=this.refBiz.searchAllRefList(refCondition);
    		if(refList!=null && !refList.isEmpty()){
    			for(ErpCrmContractRef ref:refList){
    				ErpCrmContract mainContract=this.readContract(ref.getContractFlow());
    				ErpCrmContractRef mainRef=new ErpCrmContractRef();
    				mainRef.setContractFlow(mainContract.getContractFlow());
    				List<ErpCrmContractRef> mainContractRefList=this.refBiz.searchRefList(mainRef);
    				if(mainContractRefList!=null){
    					mainContract.setSubCount(new BigDecimal(mainContractRefList.size()));
    					String result=saveContract(mainContract, null);
    					if(GlobalConstant.SAVE_FAIL.equals(result)){
    						return GlobalConstant.ZERO_LINE;
    					}
    				}	
    			}
    		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public String saveContract(ErpCrmContract contract,MultipartFile file) {
		String fileFlow="";
		if(file!=null && file.getSize()!=GlobalConstant.ZERO_LINE){
			fileFlow=this.fileBiz.addFile(file, "");
			contract.setContractFileFlow(fileFlow);
		}
		if(StringUtil.isNotBlank(contract.getContractFlow())){
		   GeneralMethod.setRecordInfo(contract, false);
		   int result=this.contractMapper.updateByPrimaryKeySelective(contract);
		   if(result!=GlobalConstant.ONE_LINE){
			   return GlobalConstant.SAVE_FAIL;
		   }
		}else{
			//保存合同信息
			synchronized(this){
				//生成合同编号
				String newNo = "";
				String contractOwnId = contract.getContractOwnId();
				String signYear = DateUtil.transDateTime(contract.getSignDate(), "yyyy-MM-dd","yyyy");
				   String cfgCode =  contractOwnId + signYear;
				   SysCfg cfg = sysCfgMapper.selectByPrimaryKey(cfgCode);
				   if (cfg != null && StringUtil.isNotBlank(cfg.getCfgValue())) {
					  String cfgValue =  cfg.getCfgValue();
					  newNo = Integer.parseInt(cfgValue) + 1 + "";
				   } else {
					   newNo = "1";
				   }
				   //回写cfgValue
				   if (cfg == null) {
				       cfg = new SysCfg();
					   cfg.setCfgCode(cfgCode);
					   cfg.setCfgValue(newNo);
					   cfg.setCfgDesc(contract.getContractOwnName()+"最新合同号");
					   cfg.setWsId("contract");
					   cfg.setWsName("合同管理");
					   GeneralMethod.setRecordInfo(cfg, true);
					   sysCfgMapper.insert(cfg);
				   } else {
					   cfg.setCfgValue(newNo);
					   cfg.setCfgDesc(contract.getContractOwnName()+"最新合同号");
					   cfg.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
					   GeneralMethod.setRecordInfo(cfg, false);
					   sysCfgMapper.updateByPrimaryKeySelective(cfg);
				   }
				   
				   //newNo不足三位补0
				   int length = newNo.length();
				   if (length<3) {
					   for (int i=0;i<(3-length);i++) {
						   newNo = "0" + newNo;
					   }
				   }
				   contract.setContractNo(cfgCode + newNo);
				   contract.setContractFlow(PkUtil.getUUID());
				   contract.setSubCount(new BigDecimal(0));
				   GeneralMethod.setRecordInfo(contract, true);
				   int result=this.contractMapper.insertSelective(contract);
				   if(result!=GlobalConstant.ONE_LINE){
					   return GlobalConstant.SAVE_FAIL;
				   }
			}
		}
		//回写客户资料“合同客户”字段
		String customerFlow = contract.getCustomerFlow();
		ErpCrmCustomer customer = customerBiz.readCustomer(customerFlow);
		if (customer != null && !GlobalConstant.FLAG_Y.equals(customer.getIsContract())) {
			customer.setIsContract(GlobalConstant.FLAG_Y);
			customerBiz.saveCustomer(customer);
		}
		return contract.getContractFlow();
	}

  
	@Override
	public List<ErpCrmContract> searchMainContact(String customerFlow,String contractFlow) {
		ErpCrmContractExample example=new ErpCrmContractExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andCustomerFlowEqualTo(customerFlow).andContractCategoryIdNotEqualTo(ContractCategoryEnum.Second.getId());
		if(StringUtil.isNotBlank(contractFlow)){
			criteria.andContractFlowNotEqualTo(contractFlow);
		}
		example.setOrderByClause("sign_date DESC,create_time DESC");
		return contractMapper.selectByExample(example);
	}

	@Override
	public List<ErpCrmContractExt> searchErpContractListByCondition(
			Map<String, Object> paramMap) {
		return this.contractExtMapper.searchContractList(paramMap);
	}

	@Override
	public Map<String,Object> readContractExt(String contractFlow,ErpCrmCustomerUser crmCustomerUser) {
		Map<String,Object> resultMap=new HashMap<String, Object>();
		//查询合同信息
		ErpCrmContract contract=new ErpCrmContract();
		contract.setContractFlow(contractFlow);
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("contract", contract);
		List<ErpCrmContractExt> contractExtList=searchContracts(paramMap);
		//如果该合同类别为经销合同，交换使用方和经销商信息
		if(contractExtList!=null && !contractExtList.isEmpty()){
			if(ContractCategoryEnum.Sell.getId().equals(contractExtList.get(0).getContractCategoryId())){
				ErpCrmCustomer userCustomer=this.customerBiz.readCustomer(contractExtList.get(0).getCustomerFlow());
	            String useCustomerName = null;
	            if(userCustomer!=null){
	            	useCustomerName=userCustomer.getCustomerName();
	            }
	            String tempFlow=contractExtList.get(0).getCustomerFlow();
	            String tempName=useCustomerName;
	            contractExtList.get(0).setCustomerFlow(contractExtList.get(0).getConsumerFlow());
	            contractExtList.get(0).getCustomer().setCustomerFlow(contractExtList.get(0).getConsumerFlow());
	            contractExtList.get(0).getCustomer().setCustomerName(contractExtList.get(0).getConsumerName());
	            contractExtList.get(0).setConsumerFlow(tempFlow);
	            contractExtList.get(0).setConsumerName(tempName);
			}
		}
		//查询关联主合同信息
		List<ErpCrmContractRefExt> mainRefExtList=this.refBiz.searchContractListByRef(contractFlow,null);
		//查询子合同信息
		List<ErpCrmContractRefExt> subRefExtList=this.refBiz.searchContractListByRef(null,contractFlow);
		//查询产品信息
		ErpCrmContractProduct product=new ErpCrmContractProduct();
		product.setContractFlow(contractFlow);
		List<ErpCrmContractProduct> productList=this.productBiz.searchContactProductList(product);
		//查询合同联系人
				crmCustomerUser.setUserFlow(null);//避免查询冲突，不能省
				Map<String,Object> paramUserMap=new HashMap<String, Object>();
				paramUserMap.put("contractFlow", contractFlow);
				paramUserMap.put("customerUser", crmCustomerUser);
				List<ErpCrmContractUserExt> userList=this.contractUserBiz.searchContractUserExtList(paramUserMap);
		        List<String> contractUserFlowList=new ArrayList<String>();
				if(userList!=null && !userList.isEmpty()){
		        	for(ErpCrmContractUserExt userExt:userList){
		        		contractUserFlowList.add(userExt.getUserFlow());
		        	}
		        }
		//查询产品使用人信息
		Map<String,List<ErpCrmCustomerUser>> productUserMap = new HashMap<String, List<ErpCrmCustomerUser>>();
		ErpCrmContractUserRef tem = new ErpCrmContractUserRef();
		tem.setContractFlow(contractFlow);
		tem.setUserCategoryId(UserCategoryEnum.User.getId());
		List<ErpCrmContractUserRef> userRefList = contractUserRefBiz.searchContractUserRefList(tem);
		if (userRefList != null && userRefList.size() > 0) {
			for (ErpCrmContractUserRef ref:userRefList) {
				String productFlow = ref.getProductFlow();
				List<ErpCrmCustomerUser> tempList = productUserMap.get(productFlow);
				if (tempList == null) {
					tempList = new ArrayList<ErpCrmCustomerUser>();
				}
				ErpCrmCustomerUser user = customerUserBiz.readCustomerUser(ref.getUserFlow());
				tempList.add(user);
				productUserMap.put(productFlow, tempList);
			}
		}
		resultMap.put("productUserMap", productUserMap);
		
		//查询回款计划
		ErpCrmContractPayPlan payPlan=new ErpCrmContractPayPlan();
		payPlan.setContractFlow(contractFlow);
		List<ErpCrmContractPayPlan> payPlanList=this.payPlanBiz.searchContractPayPlanList(payPlan);
		//查询回款到账金额
		ErpCrmContractPayBalance balance = new ErpCrmContractPayBalance();
		balance.setContractFlow(contractFlow);
		List<ErpCrmContractPayBalance> balanceList = payBalanceBiz.searchBalanceList(balance);
		Map<String, List<ErpCrmContractPayBalance>> balanceMap = null;
		if(balanceList != null && !balanceList.isEmpty()){
			balanceMap = new LinkedHashMap<String, List<ErpCrmContractPayBalance>>();
			for(ErpCrmContractPayBalance bal : balanceList){
				String planFlow = bal.getPlanFlow();
				//根据关联planFlow组织Map
				List<ErpCrmContractPayBalance> temp = balanceMap.get(planFlow);
				if(temp == null){
					temp = new ArrayList<ErpCrmContractPayBalance>();
				}
				temp.add(bal);
				balanceMap.put(planFlow, temp);
			}
		}
		//查询合同文件
		if(contractExtList!=null && !contractExtList.isEmpty()){
			PubFile file=this.fileBiz.readFile(contractExtList.get(0).getContractFileFlow());
			resultMap.put("contractExt", contractExtList.get(0));
			if(file!=null){
				resultMap.put("file",file);
			}
		}
		//查询该合同客户的联系人
		ErpCrmCustomerUser customerUser=new ErpCrmCustomerUser();
		customerUser.setCustomerFlow(contractExtList.get(0).getCustomerFlow());
		List<ErpCrmCustomerUser> customerUserList=this.customerUserBiz.searchCustomerUserList(customerUser);
		List<String> customerUserFlowList=new ArrayList<String>();
		if(customerUserList!=null && !customerUserList.isEmpty()){
			for(ErpCrmCustomerUser user:customerUserList){
				customerUserFlowList.add(user.getUserFlow());
			}
		}
		resultMap.put("productList", productList);
		/*resultMap.put("customerUserMap", customerUserMap);*/
		resultMap.put("userList", userList);
		resultMap.put("payPlanList", payPlanList);
		resultMap.put("mainRefExtList", mainRefExtList);
		resultMap.put("subRefExtList", subRefExtList);
		resultMap.put("customerUserFlowList", customerUserFlowList);
		resultMap.put("balanceMap", balanceMap);
		return resultMap;
	}

	@Override
	public ErpCrmContract readContract(String contractFlow) {
		ErpCrmContract contract=this.contractMapper.selectByPrimaryKey(contractFlow);
		if(contract!=null){
			if(ContractCategoryEnum.Sell.getId().equals(contract.getContractCategoryId())){
				ErpCrmCustomer userCustomer=this.customerBiz.readCustomer(contract.getCustomerFlow());
	            String useCustomerName = null;
	            if(userCustomer!=null){
	            	useCustomerName=userCustomer.getCustomerName();
	            }
	            String tempFlow=contract.getCustomerFlow();
	            String tempName=useCustomerName;
	            contract.setCustomerFlow(contract.getConsumerFlow());
	            contract.setConsumerFlow(tempFlow);
	            contract.setConsumerName(tempName);
			}
		}
		return contract;
	}

	@Override
	public List<ErpCrmContractExt> searchContracts(Map<String, Object> paramMap) {
		return this.contractExtMapper.searchContracts(paramMap);
	}

	@Override
	public int deleteContract(String contractFlow) {
		ErpCrmContract contract=this.readContract(contractFlow);
		if(contract!=null){
			contract.setRecordStatus(GlobalConstant.RECORD_STATUS_D);
			if(!ContractCategoryEnum.Second.getId().equals(contract.getContractCategoryId())){
				contract.setSubCount(new BigDecimal(0));
		    }
			GeneralMethod.setRecordInfo(contract, false);
		    int resultDel=this.contractMapper.updateByPrimaryKeySelective(contract);
		    String resultRef=this.refBiz.updateOneContractRef(contractFlow);
			if(resultDel==GlobalConstant.ONE_LINE && GlobalConstant.SAVE_SUCCESSED.equals(resultRef)){
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	
	
}
