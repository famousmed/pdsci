package com.pinde.sci.enums.exam;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ExamBankTypeEnum implements GeneralEnum<String> {
	
	Bank0("0","�����"),
	Bank1("1","��ҽ�����"),
	Bank2("2","��ҽ�����"),
	Bank3("3","��������"),
	Bank4("4","�ٴ�ҽѧ�����"),
	Bank5("5","סԺҽʦ�����"),
	Bank6("6","��ҽסԺҽʦ�����"),
	Bank15("15","סԺҽʦ�����2"),
	Bank16("16","��ҽסԺҽʦ�����2"),
	;

	private final String id;
	private final String name;
	
	ExamBankTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, ExamBankTypeEnum.class).getName();
	}
}
