package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbDecisionEnum implements GeneralEnum<String> {
	
	Agree("Agree" , "ͬ��","Init,Retrial,Revise,Schedule,Sae,Violate,Terminate"),
	AmendmentAgree("AmendmentsAgree","����Ҫ��������ͬ��","Init,Retrial,Revise,Schedule,Sae,Violate"),
	AmendmentRetrial("AmendmentRetrial","����Ҫ������������","Init,Retrial,Revise,Schedule,Sae,Violate"),
	Terminate("Terminate","��ֹ����ͣ����׼���о�","Retrial,Revise,Schedule,Sae,Violate"),
	Disagree("Disagree","��ͬ��","Init,Retrial,Revise"),
	AgreeFinish("AgreeFinish" , "ͬ�����","Finish"),
	FurtherMeasure("FurtherMeasure","��Ҫ��һ����ȡ���������ߵĴ�ʩ","Terminate,Finish");

	private final String id;
	private final String name;
	private final String irbTypeId;
	
	IrbDecisionEnum(String id,String name,String irbTypeId) {
		this.id = id;
		this.name = name;
		this.irbTypeId = irbTypeId;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}
	
	public String getIrbTypeId() {
		return irbTypeId;
	}

	public static String getNameById(String id) {
		return EnumUtil.getById(id, IrbDecisionEnum.class).getName();
	}
}
