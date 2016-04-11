package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AchTypeEnum implements GeneralEnum<String>{
	Thesis("Thesis","����"),
	Appraisal("Appraisal","����"),
	Book("Book","����"),
	Patent("Patent","ר��"),
	Reseachrep("Reseachrep","�о�����"),
	Copyright("Copyright","����Ȩ"),
	Sat("Sat","����")
	;

	private final String id;
	private final String name;
	
	
	private AchTypeEnum(String id, String name) {
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
		return EnumUtil.getById(id, AchTypeEnum.class).getName();
	}

}
