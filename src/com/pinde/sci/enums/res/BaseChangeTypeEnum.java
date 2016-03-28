package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum BaseChangeTypeEnum implements GeneralEnum<String> {
	
	Org("Org","培训基地"),
	TrainSpe("TrainSpe","培训专业"),
	;

	private final String id;
	private final String name;
	


	BaseChangeTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, BaseChangeTypeEnum.class).getName();
	}
}
