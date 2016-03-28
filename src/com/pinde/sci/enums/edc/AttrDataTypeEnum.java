package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AttrDataTypeEnum implements GeneralEnum<String> {
	
	String("S","文本"),
	Integer("I","整数"),
	Float("F","浮点数"),
	Date("D","日期")
	;

	private final String id;
	private final String name;
	
	AttrDataTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AttrDataTypeEnum.class).getName();
	}
}
