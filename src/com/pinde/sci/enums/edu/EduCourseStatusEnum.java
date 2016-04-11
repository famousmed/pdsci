package com.pinde.sci.enums.edu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EduCourseStatusEnum implements GeneralEnum<String>{

	NoPublish("NoPublish","未发布"),
	Publish("Publish","已发布"),
	Disabled("Disabled","停用")
	;

	private final String id;
	private final String name;
	
	EduCourseStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, EduCourseStatusEnum.class).getName();
	}
}
