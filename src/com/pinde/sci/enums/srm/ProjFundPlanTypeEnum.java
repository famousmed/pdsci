package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

/**
 * ����׶�״̬
 * @author Administrator
 *
 */
public enum ProjFundPlanTypeEnum implements GeneralEnum<String> {
	
	SumAmount("SumAmount" , "�ƻ��ܼƷ�"),
	MatchingAmount("MatchingAmount" , "�ƻ�����"),
	YearAmount("YearAmount" , "�ƻ���")
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
