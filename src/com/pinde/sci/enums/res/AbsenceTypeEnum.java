package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AbsenceTypeEnum implements GeneralEnum<String> {
	
	Leave("Leave","ÊÂ¼Ù"),
	Sickleave("Sickleave","²¡¼Ù"),
	Maternityleave("Maternityleave","²ú¼Ù"),
	Marriage("Marriage","»é¼Ù"),
	Absenteeism("Absenteeism","¿õ¹¤")
	;

	private final String id;
	private final String name;
	


	AbsenceTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AbsenceTypeEnum.class).getName();
	}
}
