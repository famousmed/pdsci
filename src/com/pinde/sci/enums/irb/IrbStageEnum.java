package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbStageEnum implements GeneralEnum<String> {
	Apply("Apply","申请"),
	Handle("Handle","受理/处理"),
	Review("Review","审查"),
	Decision("Decision","传达决定"),
	Archive("Archive","文件存档"),
	Filing ("Filing","归档")
	;

	private final String id;
	private final String name;
	
	IrbStageEnum(String id,String name) {
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
		return EnumUtil.getById(id, IrbStageEnum.class).getName();
	}
}
