package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum MeetingTypeEnum implements GeneralEnum<String> {
	
	Office("Office","办公室会议"),
	SchoolBoard("SchoolBoard","院部会议"),
	Researchers("Researchers","研究者会议"),
	Summary("Summary","总结会议"),
	National("National","全国会议")
	;

	private final String id;
	private final String name;
	
	MeetingTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, MeetingTypeEnum.class).getName();
	}
}
