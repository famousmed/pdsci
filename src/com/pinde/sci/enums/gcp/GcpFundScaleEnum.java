package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpFundScaleEnum implements GeneralEnum<String> {
	
	Dept("detp","专业组"),
	Hospital("hospital","医院"),
	Qc("qc","质控"),
	Gcp("gcp","机构"),
	;

	private final String id;
	private final String name;
	
	GcpFundScaleEnum(String id,String name) {
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
		return EnumUtil.getById(id, GcpFundScaleEnum.class).getName();
	}
}
