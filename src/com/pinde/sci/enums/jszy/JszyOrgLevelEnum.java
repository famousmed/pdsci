package com.pinde.sci.enums.jszy;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum JszyOrgLevelEnum implements GeneralEnum<String> {
	
	Main("Main","主基地"),
	Joint("Joint","协同基地"),
	;
	private final String id;
	private final String name;
	


	JszyOrgLevelEnum(String id,String name) {
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
		return EnumUtil.getById(id, JszyOrgLevelEnum.class).getName();
	}
}
