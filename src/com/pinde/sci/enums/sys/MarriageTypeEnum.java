package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum MarriageTypeEnum implements GeneralEnum<String>{

	NotMarried("1","δ��"),
	Married("2","�ѻ�"),
	Partner("3","ɥż"),
	Divorce("4","���"),
	Other("9","����"),
	;
	private final String id;
	private final String name;
	


	MarriageTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, MarriageTypeEnum.class).getName();
	}
}
