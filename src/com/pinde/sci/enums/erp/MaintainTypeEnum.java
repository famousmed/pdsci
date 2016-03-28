package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum MaintainTypeEnum implements GeneralEnum<String> {
	
	TryOut("TryOut","��ʾ"),
	Install("Install","��װ"),
	Train("Train","��ѵ"),
	Maintain("Maintain","ά��"),
	Patrol("Patrol","Ѳ��")
	;

	private final String id;
	private final String name;
	
	MaintainTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, MaintainTypeEnum.class).getName();
	}
}
