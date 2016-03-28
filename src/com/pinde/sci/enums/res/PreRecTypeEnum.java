package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum PreRecTypeEnum implements GeneralEnum<String> {
	
	PreTrainForm("PreTrainForm","¸ÚÇ°ÅàÑµ±í"),
	;

	private final String id;
	private final String name;

	PreRecTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, PreRecTypeEnum.class).getName();
	}
}
