package com.pinde.sci.enums.sch;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SchArrangeStatusEnum implements GeneralEnum<String> {
	Process("Process","�Ű���"),
	Finish("Finish","�Ű����"),
	Confirm("Confirm","�Ű�ȷ��"),
	;

	private final String id;
	private final String name;
	
	SchArrangeStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, SchArrangeStatusEnum.class).getName();
	}
}
