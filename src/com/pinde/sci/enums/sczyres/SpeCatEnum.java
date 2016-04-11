package com.pinde.sci.enums.sczyres;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SpeCatEnum implements GeneralEnum<String> {
	Zy("Zy","中医"),
	Zyqk("Zyqk","中医全科"),
	;

	private final String id;
	private final String name;
	
	SpeCatEnum(String id,String name) {
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
		return EnumUtil.getById(id, SpeCatEnum.class).getName();
	}
}
