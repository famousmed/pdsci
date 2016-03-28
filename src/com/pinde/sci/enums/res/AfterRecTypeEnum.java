package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AfterRecTypeEnum implements GeneralEnum<String> {
	
	AfterEvaluation("AfterEvaluation","���ƿ��˱�"),
	AfterSummary("AfterSummary","����С��"),
	;

	private final String id;
	private final String name;

	AfterRecTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AfterRecTypeEnum.class).getName();
	}
}
