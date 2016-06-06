package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IdofDrugTypeEnum implements GeneralEnum<String> {
	
	Yw("Yw","药物(未上市)"),
	Yp("Yp","药品(已上市)")
	;

	private final String id;
	private final String name;
	
	IdofDrugTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, IdofDrugTypeEnum.class).getName();
	}
}
