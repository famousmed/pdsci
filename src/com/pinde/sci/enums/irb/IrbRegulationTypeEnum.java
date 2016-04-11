package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbRegulationTypeEnum implements GeneralEnum<String> {
	
	Role("Role","�����������ƶ�","SOP"),
	Guide("Guide","����ָ��","SOP"),
	Sop("Sop","����ίԱ��SOP","SOP"),
	ResearchEthics("ResearchEthics","�о�����","LAW"),
	MedicalTechnology("MedicalTechnology","ҽ�Ƽ����ٴ�Ӧ��","LAW"),
	;

	private final String id;
	private final String name;
	private final String arrange;

	IrbRegulationTypeEnum(String id,String name,String arrange) {
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
		return EnumUtil.getById(id, IrbRegulationTypeEnum.class).getName();
	}
}
