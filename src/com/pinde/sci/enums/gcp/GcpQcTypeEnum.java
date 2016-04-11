package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpQcTypeEnum implements GeneralEnum<String> {
	
	Dept("Dept","רҵ���ʿ�"),
	Org("Org","�����ʿ�"),
	Inspection("Inspection","��顢���顢�Ӳ�")
	;

	private final String id;
	private final String name;
	
	GcpQcTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, GcpQcTypeEnum.class).getName();
	}
}
