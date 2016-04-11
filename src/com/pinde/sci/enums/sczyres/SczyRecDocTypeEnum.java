package com.pinde.sci.enums.sczyres;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum SczyRecDocTypeEnum implements GeneralEnum<String> {
	
	Industry("Industry","社会人"),
	Agency("Agency","单位人/委培人"),
	Graduate("Graduate","在读研究生"),
	;
	private final String id;
	private final String name;
	


	SczyRecDocTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, SczyRecDocTypeEnum.class).getName();
	}
}
