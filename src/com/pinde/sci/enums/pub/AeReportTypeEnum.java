package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AeReportTypeEnum implements GeneralEnum<String> {
	Added("Added","首次报告"),
	Reged("Reged","跟踪报告"),
	Activated("Activated","总结报告")
	;

	private final String id;
	private final String name;
	
	AeReportTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AeReportTypeEnum.class).getName();
	}
}
