package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbTrainTypeEnum implements GeneralEnum<String>{
	Gcp("Gcp","GCP"),
	Irb("Irb","Â×Àí")
	;
	private final String id;
	private final String name;
	
	private IrbTrainTypeEnum(String id, String name) {
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
		return EnumUtil.getById(id, IrbTrainTypeEnum.class).getName();
	}
}
