package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AchTypeEnum implements GeneralEnum<String>{
	Thesis("Thesis","论文"),
	Appraisal("Appraisal","鉴定"),
	Book("Book","著作"),
	Patent("Patent","专利"),
	Reseachrep("Reseachrep","研究报告"),
	Copyright("Copyright","著作权"),
	Sat("Sat","报奖")
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
