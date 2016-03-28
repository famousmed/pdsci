package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjRecTypeEnum implements GeneralEnum<String> {
	
	Info("Info" , "��Ŀ������Ϣ"),
	Apply("Apply","�걨����Ϣ"),
	SetUp("SetUp","������Ϣ"),
	Contract("Contract","��ͬ��Ϣ"), 
	ScheduleReport("ScheduleReport","��չ����"),
	ChangeReport("ChangeReport" , "�������"),
	DelayReport("DelayReport" , "��������"),
	CompleteReport("CompleteReport","���ձ���"),
	TerminateReport("TerminateReport" , "��ֹ����"),
	;

	private final String id;
	private final String name;
	
	ProjRecTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, ProjRecTypeEnum.class).getName();
	}
}
