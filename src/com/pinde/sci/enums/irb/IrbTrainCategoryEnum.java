package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbTrainCategoryEnum implements GeneralEnum<String>{
	Out("Out","外出培训"),
	Inner("Inner","机构内部培训")
	;
	private final String id;
	private final String name;
	
	private IrbTrainCategoryEnum(String id, String name) {
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
		return EnumUtil.getById(id, IrbTrainCategoryEnum.class).getName();
	}
}
