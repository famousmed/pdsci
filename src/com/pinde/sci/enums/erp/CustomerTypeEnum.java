package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum CustomerTypeEnum implements GeneralEnum<String> {
	
	Hospital("Hospital","医院"),
	School("School","学校"),
	ResearchInst("ResearchInst","科研机构"),
	Enterprise("Enterprise","企业"),
	Government("Government","政府"),
	Institutions("Institutions","事业单位"),
	Association("Association","行业协会")
	;

	private final String id;
	private final String name;
	
	CustomerTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, CustomerTypeEnum.class).getName();
	}
}
