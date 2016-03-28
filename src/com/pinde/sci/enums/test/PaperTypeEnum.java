package com.pinde.sci.enums.test;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum PaperTypeEnum implements GeneralEnum<String> {
	
	Simulate("0","Ä£Äâ"),
	Random("1","Ëæ»ú"),
	Invariant("2","¹Ì¶¨"),
	;

	private final String id;
	private final String name;
	
	PaperTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, PaperTypeEnum.class).getName();
	}
}
