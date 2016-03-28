package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum LogTypeEnum implements GeneralEnum<String> {
	Day("Day" , "�ռ�"),
	Week("Week" , "�ܼ�"),
	Month("Month" , "�¼�")
	;

	private final String id;
	private final String name;
	
	LogTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, LogTypeEnum.class).getName();
	}
}
