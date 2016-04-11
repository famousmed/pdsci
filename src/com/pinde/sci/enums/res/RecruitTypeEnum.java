package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RecruitTypeEnum implements GeneralEnum<String> {
	
	Fill("Fill","Ìî±¨"),
	Swap("Swap","µ÷¼Á"),
	;
	private final String id;
	private final String name;
	


	RecruitTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, RecruitTypeEnum.class).getName();
	}
}
