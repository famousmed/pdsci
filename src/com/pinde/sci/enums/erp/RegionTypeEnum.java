package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RegionTypeEnum implements GeneralEnum<String> {
	
	Prov("Prov","省级"),
	City("City","市级"),
	Area("Area","区级")
	;

	private final String id;
	private final String name;
	
	RegionTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, RegionTypeEnum.class).getName();
	}
}
