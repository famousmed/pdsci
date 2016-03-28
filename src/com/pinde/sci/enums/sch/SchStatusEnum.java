package com.pinde.sci.enums.sch;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SchStatusEnum implements GeneralEnum<String> {
	Submit("Submit","提交"),
	AuditY("AuditY","审核通过"),
	;

	private final String id;
	private final String name;
	
	SchStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, SchStatusEnum.class).getName();
	}
}
