package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum OperTypeEnum implements GeneralEnum<String> {
	
	LogIn("LogIn","��¼"),
	LogOut("LogOut","�˳�"),
	Course("Course","�γ�"),
	DataInput("DataInput","����¼��")
	;

	private final String id;
	private final String name;
	
	OperTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, OperTypeEnum.class).getName();
	}
}
