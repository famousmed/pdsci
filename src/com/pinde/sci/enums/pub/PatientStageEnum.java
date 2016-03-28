package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum PatientStageEnum implements GeneralEnum<String> {
	
	Filter("Filter","筛选"),
	Exclude("Exclude","排除"),
	In("In","入组"),
	Finish("Finish","完成"),
	Off("Off","脱落")
	
	;

	private final String id;
	private final String name;
	
	PatientStageEnum(String id,String name) {
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
		return EnumUtil.getById(id, PatientStageEnum.class).getName();
	}
}
