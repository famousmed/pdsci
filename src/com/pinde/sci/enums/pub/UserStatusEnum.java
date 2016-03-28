package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserStatusEnum implements GeneralEnum<String> {
	Added("Added","����"),
	Reged("Reged","�����"),
	Locked("Locked","����"),
	Activated("Activated","�Ѽ���"), 
	;

	private final String id;
	private final String name;
	
	UserStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, UserStatusEnum.class).getName();
	}
}
