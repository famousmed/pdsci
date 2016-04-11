package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ContractCategoryEnum implements GeneralEnum<String> {
	
	Sales("Sales","���ۺ�ͬ"),
	Purchase("Purchase","�ɹ���ͬ"),
	Second("Second","���κ�ͬ"),
	Sell("Sell","������ͬ"),
	TrialAgreement("TrialAgreement","����Э��")
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
