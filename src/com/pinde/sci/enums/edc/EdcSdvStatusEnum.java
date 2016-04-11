package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EdcSdvStatusEnum implements GeneralEnum<String> {
	
	NotSdv("NotSdv","未核查"),
	Sdving("Sdving","核查中"),
	Sdved("Sdved","已核查"),
	;

	private final String id;
	private final String name;
	
	EdcSdvStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, EdcSdvStatusEnum.class).getName();
	}
}
