package com.pinde.sci.enums.njmudu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum NjmuEduCourseTypeEnum implements GeneralEnum<String> {
	
	Required("Required","���޿�"),
	Optional("Optional","ѡ�޿�"),
	Public("Public","������")
	;

	private final String id;
	private final String name;
	
	NjmuEduCourseTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, NjmuEduCourseTypeEnum.class).getName();
	}
}
