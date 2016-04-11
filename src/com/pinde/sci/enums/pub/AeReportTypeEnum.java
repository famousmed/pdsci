package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AeReportTypeEnum implements GeneralEnum<String> {
	Added("Added","�״α���"),
	Reged("Reged","���ٱ���"),
	Activated("Activated","�ܽᱨ��")
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
