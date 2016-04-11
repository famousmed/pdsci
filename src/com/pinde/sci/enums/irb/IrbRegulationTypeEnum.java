package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbRegulationTypeEnum implements GeneralEnum<String> {
	
	Role("Role","伦理审查管理制度","SOP"),
	Guide("Guide","伦理指南","SOP"),
	Sop("Sop","伦理委员会SOP","SOP"),
	ResearchEthics("ResearchEthics","研究伦理","LAW"),
	MedicalTechnology("MedicalTechnology","医疗技术临床应用","LAW"),
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
