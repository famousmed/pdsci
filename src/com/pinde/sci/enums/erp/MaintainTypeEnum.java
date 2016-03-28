package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum MaintainTypeEnum implements GeneralEnum<String> {
	
	TryOut("TryOut","演示"),
	Install("Install","安装"),
	Train("Train","培训"),
	Maintain("Maintain","维护"),
	Patrol("Patrol","巡检")
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
