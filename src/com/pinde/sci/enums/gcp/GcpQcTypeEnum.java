package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpQcTypeEnum implements GeneralEnum<String> {
	
	Dept("Dept","专业组质控"),
	Org("Org","机构质控"),
	Inspection("Inspection","监查、稽查、视察")
	;

	private final String id;
	private final String name;
	
	GcpQcTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, GcpQcTypeEnum.class).getName();
	}
}
