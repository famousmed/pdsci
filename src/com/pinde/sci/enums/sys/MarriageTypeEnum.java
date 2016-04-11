package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum MarriageTypeEnum implements GeneralEnum<String>{

	NotMarried("1","Œ¥ªÈ"),
	Married("2","“—ªÈ"),
	Partner("3","…•≈º"),
	Divorce("4","¿ÎªÈ"),
	Other("9","∆‰À˚"),
	;
	private final String id;
	private final String name;
	


	MarriageTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, MarriageTypeEnum.class).getName();
	}
}
