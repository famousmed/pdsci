package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpQcCategoryEnum implements GeneralEnum<String> {
	
	FirstCaseGroup("FirstCaseGroup","首例入组"),
	OneThirdGroup("OneThirdGroup","入组1/3")
	;

	private final String id;
	private final String name;
	
	GcpQcCategoryEnum(String id,String name) {
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
		return EnumUtil.getById(id, GcpQcCategoryEnum.class).getName();
	}
}
