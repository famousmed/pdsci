package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjEvaluationStatusEnum implements GeneralEnum<String> {
	
	Evaluation("evaling","∆¿…Û÷–"),
	;

	private final String id;
	private final String name;
	
	ProjEvaluationStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, ProjEvaluationStatusEnum.class).getName();
	}
}
