package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AidTalentsStatusEnum implements GeneralEnum<String>{
	Edit("Edit","�༭"),
	Passing("Passing","�����"),
	LocalPassed("LocalPassed","ҽԺ���ͨ��"),
	LocalNoPassed("LocalNoPassed","ҽԺ��˲�ͨ��"),
	GlobalPassed("GlobalPassed","���������ͨ��"),
	GlobalNoPassed("GlobalNoPassed","��������˲�ͨ��")
	;
	private final String id;
	private final String name;
	
	private AidTalentsStatusEnum(String id, String name) {
		this.id = id;
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}
	
	public static String getNameById(String id) {
		return EnumUtil.getById(id, AidTalentsStatusEnum.class).getName();
	}
}
