package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum OrgLevelEnum implements GeneralEnum<String> {
	
	CountryOrg("CountryOrg","国家基地"),
	ProvinceOrg("ProvinceOrg","省级基地"),
	GaugeTrainingBase("GaugeTrainingBase","规培基地"),
	;
	private final String id;
	private final String name;
	


	OrgLevelEnum(String id,String name) {
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
		return EnumUtil.getById(id, OrgLevelEnum.class).getName();
	}
}
