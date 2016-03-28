package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

/**
 * 立项阶段状态
 * @author Administrator
 *
 */
public enum ProjFundPlanTypeEnum implements GeneralEnum<String> {
	
	SumAmount("SumAmount" , "计划总计费"),
	MatchingAmount("MatchingAmount" , "计划配套"),
	YearAmount("YearAmount" , "计划年")
	;

	private final String id;
	private final String name;
	
	ProjFundPlanTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, ProjFundPlanTypeEnum.class).getName();
	}
}
