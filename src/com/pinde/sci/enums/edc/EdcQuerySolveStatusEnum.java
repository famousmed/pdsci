package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EdcQuerySolveStatusEnum implements GeneralEnum<String> {
	
	UnSolve("UnSolve","未解决"),
	Solved("Solved","已解决"),
	;

	private final String id;
	private final String name;
	
	EdcQuerySolveStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, EdcQuerySolveStatusEnum.class).getName();
	}
}
