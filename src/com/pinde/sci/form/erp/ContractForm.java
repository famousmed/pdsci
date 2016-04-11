package com.pinde.sci.form.erp;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractPayPlan;
import com.pinde.sci.model.mo.ErpCrmContractProduct;
import com.pinde.sci.model.mo.ErpCrmContractRef;
import com.pinde.sci.model.mo.ErpCrmContractUser;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public class ContractForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5402190973699256795L;

    private ErpCrmContract contract;
    
    private List<ErpCrmContractProduct> productList;
    
    private List<ErpCrmCustomerUser> userList;
    
    private List<ErpCrmContractPayPlan> payPlanList;
    
    private List<ErpCrmContractRef> refList;
    

	public ErpCrmContract getContract() {
		return contract;
	}

	public void setContract(ErpCrmContract contract) {
		this.contract = contract;
	}

	
	public List<ErpCrmContractProduct> getProductList() {
		return productList;
	}

	public void setProductList(List<ErpCrmContractProduct> productList) {
		this.productList = productList;
	}

	public List<ErpCrmContractPayPlan> getPayPlanList() {
		return payPlanList;
	}

	public void setPayPlanList(List<ErpCrmContractPayPlan> payPlanList) {
		this.payPlanList = payPlanList;
	}

	public List<ErpCrmContractRef> getRefList() {
		return refList;
	}

	public void setRefList(List<ErpCrmContractRef> refList) {
		this.refList = refList;
	}

	public List<ErpCrmCustomerUser> getUserList() {
		return userList;
	}

	public void setUserList(List<ErpCrmCustomerUser> userList) {
		this.userList = userList;
	}
    
    
    
}
