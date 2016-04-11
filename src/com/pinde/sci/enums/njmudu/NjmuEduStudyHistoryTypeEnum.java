package com.pinde.sci.enums.njmudu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum NjmuEduStudyHistoryTypeEnum implements GeneralEnum<String> {
	
	Course("Course","ѧϰ�γ�"),
	Question("Question","�ʴ�����"),
	Reply("Reply","�ʴ�ظ�"),
	Test("Test","����")
	;

	private final String id;
	private final String name;
	
	NjmuEduStudyHistoryTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, NjmuEduStudyHistoryTypeEnum.class).getName();
	}
}
