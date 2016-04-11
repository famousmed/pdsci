package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RoleLevelEnum implements GeneralEnum<String> {
	
	SysLevel("SysLevel","ϵͳ��ɫ"),
	ProjLevel("ProjLevel","��Ŀ��ɫ")
	;

	private final String id;
	private final String name;
	
	RoleLevelEnum(String id,String name) {
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
		return EnumUtil.getById(id, RoleLevelEnum.class).getName();
	}
}
