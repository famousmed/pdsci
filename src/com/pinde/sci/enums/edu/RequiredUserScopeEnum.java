package com.pinde.sci.enums.edu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RequiredUserScopeEnum implements GeneralEnum<String>{
	
	Major("Major","按培训专业"),
	Dept("Dept","按轮转科室"),
	User("User","按人员"),
	;

	private final String id;
	private final String name;
	
	RequiredUserScopeEnum(String id,String name) {
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
		return EnumUtil.getById(id, RequiredUserScopeEnum.class).getName();
	}
}
