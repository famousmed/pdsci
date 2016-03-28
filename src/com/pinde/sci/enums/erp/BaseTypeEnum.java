package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum BaseTypeEnum implements GeneralEnum<String> {
	
	Base("Base","基地"),
	Joint("Joint","协同"),
	Other("Other","其他")
	;

	private final String id;
	private final String name;
	
	BaseTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, BaseTypeEnum.class).getName();
	}
}
