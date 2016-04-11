package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ShareTypeEnum implements GeneralEnum<String> {
	
	Dept("Dept","部门"),
	User("User","个人")
	;

	private final String id;
	private final String name;
	
	ShareTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, ShareTypeEnum.class).getName();
	}
}
