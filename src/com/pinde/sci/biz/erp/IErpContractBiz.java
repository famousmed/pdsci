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
	 * ����������ѯ��ͬ
	 * @param paramMap
	 * @return
	 */
	public List<ErpCrmContractExt> searchErpContractListByCondition(Map<String,Object> paramMap);
	
	/**
	 * �����ͬ�����Ϣ
	 * @param contract
	 * @param productList
	 * @param userList
	 * @param file
	 * @return
	 */
	public String saveContractInfo(ErpCrmContract contract,List<ErpCrmContractProduct> productList,List<ErpCrmCustomerUser> userList,MultipartFile file,List<ErpCrmContractPayPlan> payPlanList,List<ErpCrmContractRef> refList);
	/**
	 * �����ͬ
	 * @param contract
	 * @param file
	 * @return
	 */
	public String saveContract(ErpCrmContract contract,MultipartFile file);
	
	/**
	 * ��ѯ����ͬ
	 * @param customerFlow
	 * @return
	 */
	List<ErpCrmContract> searchMainContact(String customerFlow,String contractFlow);
	/**
	 * ��ѯ��ͬ�����Ʒ����ϵ�ˣ��ؿ�ͻ�����ϸ��Ϣ
	 * @param contractFlow
	 * @return
	 */
     public Map<String,Object> readContractExt(String contractFlow,ErpCrmCustomerUser crmCustomerUser);
     /**
      * ��ѯ��ͬ��ϸ��Ϣ
      * @param contractFlow
      * @return
      */
     public ErpCrmContract readContract(String contractFlow);
     /**
      * �޸ĺ�ͬ���Ӻ�ͬ����
      * @param contractFlow
      * @return
      */
     public int updateContractSubCount(String contractFlow);
     
	 List<ErpCrmContractExt> searchContracts(Map<String, Object> paramMap);
	 /**
	  * ɾ����ͬ
	  * @param contractFlow
	  * @return
	  */
	 public int deleteContract(String contractFlow);
	 
	    /**
	     * ��ѯ��ͬ�б�������ϵ��ר��
	     * @param contract
	     * @return
	     */
		public List<ErpCrmContract> searchErpContracts(ErpCrmContract contract);
}
