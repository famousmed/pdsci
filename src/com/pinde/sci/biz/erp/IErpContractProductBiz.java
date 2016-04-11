package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpCrmContractProduct;
import com.pinde.sci.model.mo.ErpCrmContractUser;


public interface IErpContractProductBiz {
    /**
     * ��ѯ��ͬ��Ʒ
     * @param product
     * @return
     */
	List<ErpCrmContractProduct> searchContactProductList(
			ErpCrmContractProduct product);
   
	/**
	 * �����ͬ��Ʒ
	 * @param productList
	 * @return
	 */
	public String saveContractProduct(List<ErpCrmContractProduct> productList,String contractFlow);
	
	/**
	 * ɾ����ͬ��Ʒ
	 * @param productFlows
	 * @return
	 */
	public String deleteContractProduct(String productFlows);
	/**
	 * ��ѯһ����Ʒ����ϸ��Ϣ
	 * @param productFlow
	 * @return
	 */
	public ErpCrmContractProduct readContractProduct(String productFlow);
}
