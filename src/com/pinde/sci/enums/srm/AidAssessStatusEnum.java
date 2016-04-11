package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AidAssessStatusEnum implements GeneralEnum<String>{
	Assessing("Assessing","´ýÆÀ¼Û"),
	Assessed("Assessed","ÒÑÆÀ¼Û"),
	;
	private final String id;
	private final String name;
	
	private AidAssessStatusEnum(String id, String name) {
		this.id = id;
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}
	
	public static String getNameById(String id) {
		return EnumUtil.getById(id, AidAssessStatusEnum.class).getName();
	}
}
