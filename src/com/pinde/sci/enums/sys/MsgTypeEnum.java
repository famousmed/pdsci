package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum MsgTypeEnum implements GeneralEnum<String> {
	
	Email("Email","Email"),
	Sms("Sms","短信"),
	Sys("Sys","系统"),
	Weixin("Weixin","微信")
	;

	private final String id;
	private final String name;
	
	MsgTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, MsgTypeEnum.class).getName();
	}
}
