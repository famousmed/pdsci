package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AidProjCategoryEnum implements GeneralEnum<String>{
     Country("Country","国家级项目"),
     Province("Province","省级项目"),
     City("City","市厅级"),
	;
	private final String id;
	private final String name;
	
	AidProjCategoryEnum(String id,String name) {
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
		return EnumUtil.getById(id, AidProjCategoryEnum.class).getName();
	}
}
