package com.pinde.sci.enums.sch;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SchRotationMedicineType implements GeneralEnum<String> {
	ChineseMedicine("ChineseMedicine","中医"),
	WesternMedicine("WesternMedicine","西医"),
	Custom("Custom","自定义"),
	;

	private final String id;
	private final String name;
	
	SchRotationMedicineType(String id,String name) {
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
		return EnumUtil.getById(id, SchRotationMedicineType.class).getName();
	}
}
