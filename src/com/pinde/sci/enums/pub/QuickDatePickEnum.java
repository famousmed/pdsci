package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum QuickDatePickEnum implements GeneralEnum<String> {
	
	Month("Month","ÔÂ"),
	Season("Season","¼¾"),
	Year("Year","Äê"),
	;

	private final String id;
	private final String name;
	
	QuickDatePickEnum(String id,String name) {
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
		return EnumUtil.getById(id, QuickDatePickEnum.class).getName();
	}
}
