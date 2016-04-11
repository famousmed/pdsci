package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbStageEnum implements GeneralEnum<String> {
	Apply("Apply","����"),
	Handle("Handle","����/����"),
	Review("Review","���"),
	Decision("Decision","�������"),
	Archive("Archive","�ļ��浵"),
	Filing ("Filing","�鵵")
	;

	private final String id;
	private final String name;
	
	IrbStageEnum(String id,String name) {
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
		return EnumUtil.getById(id, IrbStageEnum.class).getName();
	}
}
