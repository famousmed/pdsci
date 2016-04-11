package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjArchiveStatusEnum implements GeneralEnum<String>{
	
	Archive("Archive","同意归档"),
	NotArchive("NotArchive","不同意归档"),

	;
	
	
	private final String id;
	private final String name;
	
	ProjArchiveStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, ProjArchiveStatusEnum.class).getName();
	}
}
