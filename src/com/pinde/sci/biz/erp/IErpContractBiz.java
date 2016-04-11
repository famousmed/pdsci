package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.erp.ErpCrmContractExt;
import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractPayPlan;
import com.pinde.sci.model.mo.ErpCrmContractProduct;
import com.pinde.sci.model.mo.ErpCrmContractRef;
import com.pinde.sci.model.mo.ErpCrmContractUser;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public interface IErpContractBiz {
    /**
     * 
     * @param contract
     * @return
     */
	public List<ErpCrmContract> searchErpContractList(ErpCrmContract contract);
	/**
	 * 根据条件查询合同
	 * @param paramMap
	 * @return
	 */
	public List<ErpCrmContractExt> searchErpContractListByCondition(Map<String,Object> paramMap);
	
	/**
	 * 保存合同相关信息
	 * @param contract
	 * @param productList
	 * @param userList
	 * @param file
	 * @return
	 */
	public String saveContractInfo(ErpCrmContract contract,List<ErpCrmContractProduct> productList,List<ErpCrmCustomerUser> userList,MultipartFile file,List<ErpCrmContractPayPlan> payPlanList,List<ErpCrmContractRef> refList);
	/**
	 * 保存合同
	 * @param contract
	 * @param file
	 * @return
	 */
	public String saveContract(ErpCrmContract contract,MultipartFile file);
	
	/**
	 * 查询主合同
	 * @param customerFlow
	 * @return
	 */
	List<ErpCrmContract> searchMainContact(String customerFlow,String contractFlow);
	/**
	 * 查询合同及其产品，联系人，回款，客户的详细信息
	 * @param contractFlow
	 * @return
	 */
     public Map<String,Object> readContractExt(String contractFlow,ErpCrmCustomerUser crmCustomerUser);
     /**
      * 查询合同详细信息
      * @param contractFlow
      * @return
      */
     public ErpCrmContract readContract(String contractFlow);
     /**
      * 修改合同的子合同数量
      * @param contractFlow
      * @return
      */
     public int updateContractSubCount(String contractFlow);
     
	 List<ErpCrmContractExt> searchContracts(Map<String, Object> paramMap);
	 /**
	  * 删除合同
	  * @param contractFlow
	  * @return
	  */
	 public int deleteContract(String contractFlow);
	 
	    /**
	     * 查询合同列表，工作联系单专用
	     * @param contract
	     * @return
	     */
		public List<ErpCrmContract> searchErpContracts(ErpCrmContract contract);
}
