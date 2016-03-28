package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ResponseStatusEnum implements GeneralEnum<String>{
	
	Save("Save","δ�ύ"),
	NoResponse("NoResponse","δ��Ӧ"),
	Responsed("Responsed","����Ӧ")
	;
	
	private final String id;
	private final String name;
	
	ResponseStatusEnum(String id,String name){
		this.id=id;
		this.name=name;
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
		return EnumUtil.getById(id, ResponseStatusEnum.class).getName();
	}
}
