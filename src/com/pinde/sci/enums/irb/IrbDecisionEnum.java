package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbDecisionEnum implements GeneralEnum<String> {
	
	Agree("Agree" , "同意","Init,Retrial,Revise,Schedule,Sae,Violate,Terminate"),
	AmendmentAgree("AmendmentsAgree","作必要的修正后同意","Init,Retrial,Revise,Schedule,Sae,Violate"),
	AmendmentRetrial("AmendmentRetrial","作必要的修正后重审","Init,Retrial,Revise,Schedule,Sae,Violate"),
	Terminate("Terminate","终止或暂停已批准的研究","Retrial,Revise,Schedule,Sae,Violate"),
	Disagree("Disagree","不同意","Init,Retrial,Revise"),
	AgreeFinish("AgreeFinish" , "同意结题","Finish"),
	FurtherMeasure("FurtherMeasure","需要进一步采取保护受试者的措施","Terminate,Finish");

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
