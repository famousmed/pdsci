package com.pinde.sci.form.res;

import java.io.Serializable;
import java.math.BigDecimal;

public class AppealForm implements Serializable{

	private static final long serialVersionUID = 9077398975259057503L;
	
	private String recTypeId;
	private String itemName;
	private BigDecimal appealNum;
	public String getRecTypeId() {
		return recTypeId;
	}
	public void setRecTypeId(String recTypeId) {
		this.recTypeId = recTypeId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public BigDecimal getAppealNum() {
		return appealNum;
	}
	public void setAppealNum(BigDecimal appealNum) {
		this.appealNum = appealNum;
	}
}
