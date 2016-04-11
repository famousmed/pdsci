package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ExpertScoreResultEnum implements GeneralEnum<String> {
	
	Agree("Agree","同意"),
	NotAgree("NotAgree","不同意"),
	;

	private final String id;
	private final String name;
	
	ExpertScoreResultEnum(String id,String name) {
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
		return EnumUtil.getById(id, ExpertScoreResultEnum.class).getName();
	}
}
