package com.pinde.sci.enums.exam;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum QuestionTypeClassEnum implements GeneralEnum<String> {
	
	Class0("0","单选类型"),
	Class1("1","多选类型"),
	Class2("2","填写类型"),
	Class3("3","多媒体题型"),
	;

	private final String id;
	private final String name;
	
	QuestionTypeClassEnum(String id,String name) {
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
		return EnumUtil.getById(id, QuestionTypeClassEnum.class).getName();
	}
}
