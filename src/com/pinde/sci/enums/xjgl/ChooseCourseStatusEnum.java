package com.pinde.sci.enums.xjgl;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ChooseCourseStatusEnum implements GeneralEnum<String>{

	Choose("Choose","ÒÑÑ¡¿Î"),
	UnChoose("UnChoose","Î´Ñ¡¿Î")
	;
	private final String id;
	private final String name;
	
	ChooseCourseStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, ChooseCourseStatusEnum.class).getName();
	}
}
