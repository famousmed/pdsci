package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AidTalentsStatusEnum implements GeneralEnum<String>{
	Edit("Edit","编辑"),
	Passing("Passing","待审核"),
	LocalPassed("LocalPassed","医院审核通过"),
	LocalNoPassed("LocalNoPassed","医院审核不通过"),
	GlobalPassed("GlobalPassed","卫生局审核通过"),
	GlobalNoPassed("GlobalNoPassed","卫生局审核不通过")
	;
	private final String id;
	private final String name;
	
	private AidTalentsStatusEnum(String id, String name) {
		this.id = id;
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}
	
	public static String getNameById(String id) {
		return EnumUtil.getById(id, AidTalentsStatusEnum.class).getName();
	}
}
