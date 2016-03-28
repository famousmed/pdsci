package com.pinde.sci.model.erp;

import com.pinde.sci.model.mo.ErpDoc;
import com.pinde.sci.model.mo.ErpDocShare;

public class ErpDocShareExt extends ErpDocShare{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2867881658564376917L;
	private ErpDoc erpDoc;

	public ErpDoc getErpDoc() {
		return erpDoc;
	}

	public void setErpDoc(ErpDoc erpDoc) {
		this.erpDoc = erpDoc;
	}
	

}
