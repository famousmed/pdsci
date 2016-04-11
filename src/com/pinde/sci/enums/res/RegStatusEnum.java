package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RegStatusEnum implements GeneralEnum<String> {
	UnSubmit("UnSubmit","δ�ύ"),
	Passing("Passing","�����"),
	Passed("Passed","�������ͨ��"),
	UnPassed("UnPassed","������˲�ͨ��")
	;

	private final String id;
	private final String name;
	
	RegStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, RegStatusEnum.class).getName();
	}
}
