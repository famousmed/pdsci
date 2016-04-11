package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SatisfactionEnum implements GeneralEnum<String> {
	
	VerySatisfied("VerySatisfied","很满意"),
	Satisfied("Satisfied","满意"),
	General("General","一般"),
	Dissatisfied("Dissatisfied","不满意"),
	VeryDissatisfied("VeryDissatisfied","很不满意")
	;

	private final String id;
	private final String name;
	
	SatisfactionEnum(String id,String name) {
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
		return EnumUtil.getById(id, SatisfactionEnum.class).getName();
	}
}
