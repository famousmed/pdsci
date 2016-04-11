package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EdcRandomAssignStatusEnum implements GeneralEnum<String> {
	
	UnAssign("UnAssign","Œ¥…Í«Î"),
	Assigned("Assigned","“—…Í«Î"),
	;

	private final String id;
	private final String name;
	
	EdcRandomAssignStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, EdcRandomAssignStatusEnum.class).getName();
	}
}
