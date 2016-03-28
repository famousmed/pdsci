package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RegulationCategoryEnum implements GeneralEnum<String> {
	
	Country ("Country" , "国家文件"),
	Local("Local" , "地方文件"),
	Org ("Org" , "机构文件"),
	Dept ("Dept" , "专业组文件")
	;

	private final String id;
	private final String name;
	
	RegulationCategoryEnum(String id,String name) {
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
		return EnumUtil.getById(id, RegulationCategoryEnum.class).getName();
	}
}
