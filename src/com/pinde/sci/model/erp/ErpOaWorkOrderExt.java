package com.pinde.sci.model.erp;

import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpOaContactOrder;
import com.pinde.sci.model.mo.ErpOaWorkOrder;

public class ErpOaWorkOrderExt extends ErpOaWorkOrder{
     
	/**
	 * 
	 */
	private static final long serialVersionUID = 8950697031093934936L;
	
	private ErpOaContactOrder contactOrder;
	private ErpCrmCustomer customer;

	public ErpOaContactOrder getContactOrder() {
		return contactOrder;
	}
	public void setContactOrder(ErpOaContactOrder contactOrder) {
		this.contactOrder = contactOrder;
	}

	public ErpCrmCustomer getCustomer() {
		return customer;
	}
	public void setCustomer(ErpCrmCustomer customer) {
		this.customer = customer;
	}
}
