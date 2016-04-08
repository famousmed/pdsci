package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EdcRandomTypeEnum implements GeneralEnum<String> {
	
	
	Dynamic("Dynamic","动态随机"),
	BlockCompetition("BlockCompetition","区组竞争随机")
	;

	private final String id;
	private final String name;
	
	EdcRandomTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, EdcRandomTypeEnum.class).getName();
	}
}
