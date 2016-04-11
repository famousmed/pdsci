package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum WeixinStatusEnum implements GeneralEnum<String> {

	Status0("-1","δ���"),
	Status1("1","�ѹ�ע"),
	Status2("2","�Ѷ���"),
	Status4("4","δ��ע")
	;

	private final String id;
	private final String name;
	
	WeixinStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, WeixinStatusEnum.class).getName();
	}
}
