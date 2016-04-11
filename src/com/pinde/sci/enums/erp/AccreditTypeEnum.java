package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AccreditTypeEnum implements GeneralEnum<String>{
	 Develop("Develop","开发"),
	 Show("Show","演示"),
	 Official("Official","正式"),
	;
     
	 
	private final String id;
    private final String name;
    
    AccreditTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AccreditTypeEnum.class).getName();
	}
}
