package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserEmailStatusEnum implements GeneralEnum<String> {
	
	Unauth("Unauth","δ��֤"),
	Authed("Authed","����֤");

	private final String id;
	private final String name;
	
	UserEmailStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, UserEmailStatusEnum.class).getName();
	}
}
