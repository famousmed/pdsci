package com.pinde.sci.enums.njmudu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;
import com.pinde.sci.enums.erp.ContractTypeEnum;

public enum NjmuEduVideoLevelEnum implements GeneralEnum<String>{
	
	HyperCrystal("HyperCrystal","超清"),
	High("High","高清"),
	Standard("Standard","标清"),
	Topspeed("Topspeed","极速")
	;
	
	
	private final String id;
	private final String name;
	
	NjmuEduVideoLevelEnum(String id,String name){
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
		return EnumUtil.getById(id, NjmuEduVideoLevelEnum.class).getName();
	}
	
}
