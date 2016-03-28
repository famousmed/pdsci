package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum PatientRecipeStatusEnum implements GeneralEnum<String> {
	
	UnDispens("UnDispens","已开具未发药"),
	Dispensed("Dispensed","已发药")
	;

	private final String id;
	private final String name;
	
	PatientRecipeStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, PatientRecipeStatusEnum.class).getName();
	}
}
