package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RegStatusEnum implements GeneralEnum<String> {
	UnSubmit("UnSubmit","未提交"),
	Passing("Passing","待审核"),
	Passed("Passed","报名审核通过"),
	UnPassed("UnPassed","报名审核不通过")
	;

	private final String id;
	private final String name;
	
	RegStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, RegStatusEnum.class).getName();
	}
}
