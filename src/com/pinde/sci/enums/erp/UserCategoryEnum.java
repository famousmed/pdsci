package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserCategoryEnum implements GeneralEnum<String> {
	
	Business("1","��������"),
	Technical("2","����������"),
	User("3","ʹ����")
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
