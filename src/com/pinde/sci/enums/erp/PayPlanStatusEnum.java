package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum PayPlanStatusEnum implements GeneralEnum<String> {
	
	NotStart("NotStart","未开始"),
	InProgress("InProgress","进行中"),
	Complete("Complete","完成")
	;

	private final String id;
	private final String name;
	
	PayPlanStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, PayPlanStatusEnum.class).getName();
	}
	
}
