package com.pinde.sci.model.erp;

import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractRef;

public class ErpCrmContractRefExt extends ErpCrmContractRef{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5337561156192266611L;
   
	private ErpCrmContract contract;

	public ErpCrmContract getContract() {
		return contract;
	}

	public void setContract(ErpCrmContract contract) {
		this.contract = contract;
	}
	
	
}
