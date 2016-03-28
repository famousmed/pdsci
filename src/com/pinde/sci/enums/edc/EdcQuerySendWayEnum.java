package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EdcQuerySendWayEnum implements GeneralEnum<String> {
	
	Sdv("S","SDV疑问"),
	Logic("L","逻辑检查"),
	Manual("M","手工疑问"),
	;

	private final String id;
	private final String name;
	
	EdcQuerySendWayEnum(String id,String name) {
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
		return EnumUtil.getById(id, EdcQuerySendWayEnum.class).getName();
	}
}
