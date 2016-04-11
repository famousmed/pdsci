package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum DevelopLanguageEnum implements GeneralEnum<String>{
	java("Java","java"),
	net("Net",".net"),
	;

	private final String id;
    private final String name;
    
    DevelopLanguageEnum(String id,String name) {
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
		return EnumUtil.getById(id, DevelopLanguageEnum.class).getName();
	}
}
