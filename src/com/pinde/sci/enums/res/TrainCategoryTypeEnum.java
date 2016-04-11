package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum TrainCategoryTypeEnum implements GeneralEnum<String> {
	
	Before2014("Before2014","2014��ǰ��ѵ���"),
	After2014("After2014","2014�����ѵ���")
	;

	private final String id;
	private final String name;
	


	TrainCategoryTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, TrainCategoryTypeEnum.class).getName();
	}
}
