package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum DemandMatterEnum implements GeneralEnum<String> {
	
	PreSalesSupport("PreSalesSupport","售前支持"),
	SalesImplement("SalesImplement","售中实施"),
	Service("Service","售后服务")
	;

	private final String id;
	private final String name;
	
	DemandMatterEnum(String id,String name) {
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
		return EnumUtil.getById(id, DemandMatterEnum.class).getName();
	}
	
}
