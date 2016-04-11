package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserCategoryEnum implements GeneralEnum<String> {
	
	Business("1","商务负责人"),
	Technical("2","技术负责人"),
	User("3","使用人")
	;

	private final String id;
	private final String name;
	
	UserCategoryEnum(String id,String name) {
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
		return EnumUtil.getById(id, UserCategoryEnum.class).getName();
	}
}
