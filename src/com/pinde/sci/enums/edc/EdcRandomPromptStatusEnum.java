package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EdcRandomPromptStatusEnum implements GeneralEnum<String> {
	
	UnPrompt("UnPrompt","δ��ä"), 
	Apply("Apply","�����ä"),
	Agree("Agree","ͬ���ä"),
	Prompted("Prompted","�ѽ�ä"),
	;

	private final String id;
	private final String name;
	
	EdcRandomPromptStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, EdcRandomPromptStatusEnum.class).getName();
	}
}
