package com.pinde.sci.enums.xjgl;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum XjglCourseTypeEnum implements GeneralEnum<String> {
	
	Degree("Degree","ѧλ�γ�"),
	Optional("Optional","רҵѡ�޿�"),
	Public("Public","����ѡ�޿γ�")
	;

	private final String id;
	private final String name;
	
	XjglCourseTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, XjglCourseTypeEnum.class).getName();
	}
}
