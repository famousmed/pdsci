package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RecDocTypeEnum implements GeneralEnum<String> {
	
	Agency("Agency","��λ��/ί����"),
	Industry("Industry","��ҵ��"),
	;
	private final String id;
	private final String name;
	


	RecDocTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, RecDocTypeEnum.class).getName();
	}
}
