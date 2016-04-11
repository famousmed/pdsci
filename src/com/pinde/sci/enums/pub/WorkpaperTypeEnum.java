package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum WorkpaperTypeEnum implements GeneralEnum<String> {
	
	WorkReport ("WorkReport" , "工作汇报"),
	WorkPlan("WorkPlan" , "工作计划"),
	YearSummary("YearSummary" , "年终总结"),
	ApplyMaterial ("AppMaterial" , "申报材料"),
	ApplyReport ("ApplyReport" , "申请报告")
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
