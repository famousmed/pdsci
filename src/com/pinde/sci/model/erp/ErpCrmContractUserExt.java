package com.pinde.sci.model.erp;

import com.pinde.sci.model.mo.ErpCrmContractUser;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public class ErpCrmContractUserExt extends ErpCrmContractUser{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6364406853668036517L;
	
	private ErpCrmCustomerUser customerUser;

	public ErpCrmCustomerUser getCustomerUser() {
		return customerUser;
	}

	public void setCustomerUser(ErpCrmCustomerUser customerUser) {
		this.customerUser = customerUser;
	}
	
	
}
