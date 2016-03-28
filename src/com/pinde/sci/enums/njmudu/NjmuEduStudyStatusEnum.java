package com.pinde.sci.enums.njmudu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum NjmuEduStudyStatusEnum implements GeneralEnum<String> {
	
	NotStarted("NotStarted","未开始"),
	Underway("Underway","进行中"),
	Finish("Finish","已完成")
	;

	private final String id;
	private final String name;
	
	NjmuEduStudyStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, NjmuEduStudyStatusEnum.class).getName();
	}
}
