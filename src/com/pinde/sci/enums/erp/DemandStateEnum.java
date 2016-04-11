package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum DemandStateEnum implements GeneralEnum<String> {
	
	Normal("Normal","Õý³£"),
	Urgent("Urgent","¼Ó¼±")
	;

	private final String id;
	private final String name;
	
	DemandStateEnum(String id,String name) {
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
		return EnumUtil.getById(id, DemandStateEnum.class).getName();
	}
}
