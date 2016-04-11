package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SatisfactionEnum implements GeneralEnum<String> {
	
	VerySatisfied("VerySatisfied","������"),
	Satisfied("Satisfied","����"),
	General("General","һ��"),
	Dissatisfied("Dissatisfied","������"),
	VeryDissatisfied("VeryDissatisfied","�ܲ�����")
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
