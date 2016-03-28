package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EvaluationEnum implements GeneralEnum<String> {
	
	ApproveEvaluation("ApproveEvaluation","立项评审"),
	CompleteEvaluation("CompleteEvaluation","验收评审")
	;

	private final String id;
	private final String name;
	
	EvaluationEnum(String id,String name) {
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
		return EnumUtil.getById(id, EvaluationEnum.class).getName();
	}
}
