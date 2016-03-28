package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum OutWindowTypeEnum implements GeneralEnum<String> {
	
	Earlier("Earlier","Ã·«∞"),
	Delayed("Delayed","—”∫Û")
	;

	private final String id;
	private final String name;
	
	OutWindowTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, OutWindowTypeEnum.class).getName();
	}
}
