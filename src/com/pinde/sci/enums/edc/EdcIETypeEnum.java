package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EdcIETypeEnum implements GeneralEnum<String> {
	
	Include("include","纳入标准"),
	Exclude("exclude","排除标准"),
	;

	private final String id;
	private final String name;
	
	EdcIETypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, EdcIETypeEnum.class).getName();
	}
}
