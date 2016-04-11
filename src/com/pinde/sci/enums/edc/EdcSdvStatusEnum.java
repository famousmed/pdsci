package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EdcSdvStatusEnum implements GeneralEnum<String> {
	
	NotSdv("NotSdv","δ�˲�"),
	Sdving("Sdving","�˲���"),
	Sdved("Sdved","�Ѻ˲�"),
	;

	private final String id;
	private final String name;
	
	EdcSdvStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, EdcSdvStatusEnum.class).getName();
	}
}
