package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum OrgTypeEnum implements GeneralEnum<String> {
	
	Hospital("Hospital","医院/基地"),
	//Hospital_S("Hospital_S","国家基地"),
	Declare("Declare","申办方"),
	CRO("CRO","CRO"),
	University("University","学校")
	;

	private final String id;
	private final String name;
	
	OrgTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, OrgTypeEnum.class).getName();
	}
}
