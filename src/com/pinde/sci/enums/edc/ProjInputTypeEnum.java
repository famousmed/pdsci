package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjInputTypeEnum implements GeneralEnum<String> {
	
	Single("Single","单份录入"),
	Double("Double","双份录入"),
	;

	private final String id;
	private final String name;
	
	ProjInputTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, ProjInputTypeEnum.class).getName();
	}
}
