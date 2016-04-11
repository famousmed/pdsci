package com.pinde.sci.enums.jsres;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum BaseStatusEnum implements GeneralEnum<String> {
	
	NotSubmit("NotSubmit","δ�ύ"),
	Auditing("Auditing","�����"),
	ChargePassed("ChargePassed" , "�о����ͨ��"),
	GlobalPassed("GlobalPassed" , "ʡ�����ͨ��"),
	Passed("Passed" , "���ͨ��"),
	NotPassed("NotPassed" , "��˲�ͨ��")
	;

	private final String id;
	private final String name;
	
	BaseStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, BaseStatusEnum.class).getName();
	}
}
