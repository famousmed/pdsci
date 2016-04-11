package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbReviewTypeEnum implements GeneralEnum<String> {
	
	Meeting("Meeting","�������","�ύ�������"),
	Fast("Fast","�������","�ύ���鱨��"),
	UrgentMeeting("UrgentMeeting","�����������","�ύ�������"),
	//Avoid("Avoid","������","������"),
	;

	private final String id;
	private final String name;
	private final String arrange;

	IrbReviewTypeEnum(String id,String name,String arrange) {
		this.id = id;
		this.name = name;
		this.arrange = arrange;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}
	
	public String getArrange() {
		return arrange;
	}

	public static String getNameById(String id) {
		return EnumUtil.getById(id, IrbReviewTypeEnum.class).getName();
	}
}
