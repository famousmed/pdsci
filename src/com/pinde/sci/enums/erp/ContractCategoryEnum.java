package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ContractCategoryEnum implements GeneralEnum<String> {
	
	Sales("Sales","销售合同"),
	Purchase("Purchase","采购合同"),
	Second("Second","二次合同"),
	Sell("Sell","经销合同"),
	TrialAgreement("TrialAgreement","试用协议")
	;

	private final String id;
	private final String name;
	
	ContractCategoryEnum(String id,String name) {
		this.id = id;
		this.name = name;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}
	
	public static String getNameById(String id) {
		return EnumUtil.getById(id, ContractCategoryEnum.class).getName();
	}
	
}
