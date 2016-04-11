package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum TrainSummaryTypeEnum implements GeneralEnum<String> {
	
	Plan("Plan","计划"),
	Summary("Summary","总结")
	;

	private final String id;
	private final String name;
	
	TrainSummaryTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, TrainSummaryTypeEnum.class).getName();
	}
}
