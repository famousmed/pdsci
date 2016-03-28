package com.pinde.sci.enums.edu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EduQuestionStatusEnum implements GeneralEnum<String> {
	
	Answered("Answered","ÒÑ»Ø´ð"),
	Unanswered("Unanswered","Î´»Ø´ð")
	;

	private final String id;
	private final String name;
	
	EduQuestionStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, EduQuestionStatusEnum.class).getName();
	}
}
