package com.pinde.sci.enums.sczyres;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SczyResOrgLevelEnum implements GeneralEnum<String> {
	
	Main("Main","主基地"),
	Joint("Joint","协同基地"),
	;
	private final String id;
	private final String name;
	


	SczyResOrgLevelEnum(String id,String name) {
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
		return EnumUtil.getById(id, SczyResOrgLevelEnum.class).getName();
	}
}
