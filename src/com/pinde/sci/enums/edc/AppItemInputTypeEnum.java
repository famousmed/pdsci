package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AppItemInputTypeEnum implements GeneralEnum<String> {
	
	Number("number","数值"),
	Bool("bool","布尔值"),
	;

	private final String id;
	private final String name;
	
	AppItemInputTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AppItemInputTypeEnum.class).getName();
	}
}
