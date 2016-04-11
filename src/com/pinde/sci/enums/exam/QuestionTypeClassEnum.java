package com.pinde.sci.enums.exam;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum QuestionTypeClassEnum implements GeneralEnum<String> {
	
	Class0("0","��ѡ����"),
	Class1("1","��ѡ����"),
	Class2("2","��д����"),
	Class3("3","��ý������"),
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
