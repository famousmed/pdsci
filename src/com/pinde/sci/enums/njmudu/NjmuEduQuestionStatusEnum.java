package com.pinde.sci.enums.njmudu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum NjmuEduQuestionStatusEnum implements GeneralEnum<String> {
	
	Answered("Answered","ÒÑ»Ø´ð"),
	Unanswered("Unanswered","Î´»Ø´ð")
	;

	private final String id;
	private final String name;
	
	NjmuEduQuestionStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, NjmuEduQuestionStatusEnum.class).getName();
	}
}
