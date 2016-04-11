package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum OrgTypeEnum implements GeneralEnum<String> {
	
	Hospital("Hospital","ҽԺ/����"),
	//Hospital_S("Hospital_S","���һ���"),
	Declare("Declare","��췽"),
	CRO("CRO","CRO"),
	University("University","ѧУ")
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
