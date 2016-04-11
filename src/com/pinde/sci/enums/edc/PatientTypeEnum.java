package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum PatientTypeEnum implements GeneralEnum<String> {
	
	Real("Real","ÕıÊ½²¡Àı"),
	Test("Test","²âÊÔ²¡Àı"),
	Disabled("Disabled","·ÏÖ¹²¡Àı"),
	
	;

	private final String id;
	private final String name;
	
	PatientTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, PatientTypeEnum.class).getName();
	}
}
