package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum InspectTypeEnum implements GeneralEnum<String> {
	
	Observation("Observation","观测指标设计")
	
	;

	private final String id;
	private final String name;
	
	InspectTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, InspectTypeEnum.class).getName();
	}
}
