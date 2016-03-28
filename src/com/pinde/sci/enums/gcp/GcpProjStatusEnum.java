package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpProjStatusEnum implements GeneralEnum<String> {
	Edit("Edit","编辑"),
	Passing("Passing","提交审核"),
	Passed("Passed","审核通过"),
	NoPassed("NoPassed","审核不通过")
	;

	private final String id;
	private final String name;
	
	GcpProjStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, GcpProjStatusEnum.class).getName();
	}
}
