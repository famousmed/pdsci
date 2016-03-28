package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjOrgTypeEnum implements GeneralEnum<String> {
	
	Leader("Leader","组长"),
	Parti("Parti","参与"),
	Operate("Operate","运维")
	;

	private final String id;
	private final String name;
	
	ProjOrgTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, ProjOrgTypeEnum.class).getName();
	}
}
