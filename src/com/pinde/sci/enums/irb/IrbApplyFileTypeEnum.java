package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbApplyFileTypeEnum implements GeneralEnum<String> {
	
	Pro("Pro","方案"),
	Icf("Icf","知情同意书"),
	;

	private final String id;
	private final String name;
	


	IrbApplyFileTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, IrbApplyFileTypeEnum.class).getName();
	}
}
