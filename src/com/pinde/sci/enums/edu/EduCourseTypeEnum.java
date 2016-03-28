package com.pinde.sci.enums.edu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EduCourseTypeEnum implements GeneralEnum<String> {
	
	Required("Required","必修课"),
	Optional("Optional","选修课"),
	Public("Public","公开课")
	;

	private final String id;
	private final String name;
	
	EduCourseTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, EduCourseTypeEnum.class).getName();
	}
}
