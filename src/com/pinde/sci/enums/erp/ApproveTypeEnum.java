package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ApproveTypeEnum implements GeneralEnum<String> {
	
	Common("Common","常规"),
	Special("Special","特批")
	;

	private final String id;
	private final String name;
	
	ApproveTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, ApproveTypeEnum.class).getName();
	}
}
