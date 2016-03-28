package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjRecTypeEnum implements GeneralEnum<String> {
	
	Info("Info" , "项目基本信息"),
	Apply("Apply","申报书信息"),
	SetUp("SetUp","立项信息"),
	Contract("Contract","合同信息"), 
	ScheduleReport("ScheduleReport","进展报告"),
	ChangeReport("ChangeReport" , "变更申请"),
	DelayReport("DelayReport" , "延期申请"),
	CompleteReport("CompleteReport","验收报告"),
	TerminateReport("TerminateReport" , "中止报告"),
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
