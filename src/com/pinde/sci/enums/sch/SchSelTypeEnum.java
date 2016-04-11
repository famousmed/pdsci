package com.pinde.sci.enums.sch;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SchSelTypeEnum implements GeneralEnum<String> {
	Fixed("Fixed","�̶�ѡ��"),
	Free("Free","����ѡ��"),
	;

	private final String id;
	private final String name;
	
	SchSelTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, SchSelTypeEnum.class).getName();
	}
}
