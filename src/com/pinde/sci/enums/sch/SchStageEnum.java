package com.pinde.sci.enums.sch;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SchStageEnum implements GeneralEnum<String> {
	FirstStage("FirstStage","第一阶段"),
	SecondStage("SecondStage","第二阶段"),
	ThirdStage("ThirdStage","第三阶段"),
	;

	private final String id;
	private final String name;
	
	SchStageEnum(String id,String name) {
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
		return EnumUtil.getById(id, SchStageEnum.class).getName();
	}
}
