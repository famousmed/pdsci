package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpProjStatusEnum implements GeneralEnum<String> {
	Edit("Edit","�༭"),
	Passing("Passing","�ύ���"),
	Passed("Passed","���ͨ��"),
	NoPassed("NoPassed","��˲�ͨ��")
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
