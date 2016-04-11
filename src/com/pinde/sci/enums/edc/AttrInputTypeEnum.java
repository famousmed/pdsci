package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AttrInputTypeEnum implements GeneralEnum<String> {
	
	Text("text","文本"),
	Radio("radio","单选"),
	Checkbox("checkbox","复选"),
	Select("select","下拉"),
	Date("date","日期"),
	Textarea("Textarea","文本框")
	;

	private final String id;
	private final String name;
	
	AttrInputTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AttrInputTypeEnum.class).getName();
	}
}
