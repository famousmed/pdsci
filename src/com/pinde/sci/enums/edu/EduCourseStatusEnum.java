package com.pinde.sci.enums.edu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EduCourseStatusEnum implements GeneralEnum<String>{

	NoPublish("NoPublish","δ����"),
	Publish("Publish","�ѷ���"),
	Disabled("Disabled","ͣ��")
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
