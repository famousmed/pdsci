package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserPhoneStatusEnum implements GeneralEnum<String> {
	
	Unauth("Unauth","未认证"),
	Authed("Authed","已认证");

	private final String id;
	private final String name;
	
	UserPhoneStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, UserPhoneStatusEnum.class).getName();
	}
}
