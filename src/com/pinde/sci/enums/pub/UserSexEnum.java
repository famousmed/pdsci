package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserSexEnum implements GeneralEnum<String> {
	
	Unknown("Unknown","Í¨ÓÃ"),
	Man("Man","ÄÐ"),
	Woman("Woman","Å®")
	;

	private final String id;
	private final String name;
	
	UserSexEnum(String id,String name) {
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
		return EnumUtil.getById(id, UserSexEnum.class).getName();
	}
}
