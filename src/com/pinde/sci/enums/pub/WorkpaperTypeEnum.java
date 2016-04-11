package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum WorkpaperTypeEnum implements GeneralEnum<String> {
	
	WorkReport ("WorkReport" , "�����㱨"),
	WorkPlan("WorkPlan" , "�����ƻ�"),
	YearSummary("YearSummary" , "�����ܽ�"),
	ApplyMaterial ("AppMaterial" , "�걨����"),
	ApplyReport ("ApplyReport" , "���뱨��")
	;

	private final String id;
	private final String name;
	
	WorkpaperTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, WorkpaperTypeEnum.class).getName();
	}
}
