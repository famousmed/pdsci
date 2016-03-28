package com.pinde.sci.enums.njmudu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;
import com.pinde.sci.enums.erp.ContractTypeEnum;

public enum NjmuEduVideoLevelEnum implements GeneralEnum<String>{
	
	HyperCrystal("HyperCrystal","����"),
	High("High","����"),
	Standard("Standard","����"),
	Topspeed("Topspeed","����")
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
