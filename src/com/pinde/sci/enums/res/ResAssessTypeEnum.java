package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ResAssessTypeEnum implements GeneralEnum<String> {
	
	TeacherAssess("TeacherAssess","带教老师评分"),
	DeptAssess("DeptAssess","科室评分"),
	;

	private final String id;
	private final String name;
	


	ResAssessTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, ResAssessTypeEnum.class).getName();
	}
}
