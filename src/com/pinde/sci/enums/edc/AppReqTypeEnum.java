package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AppReqTypeEnum implements GeneralEnum<String> {
	
	login("login","用户登录"),
	projList("projList","项目列表"),
	applyParam("applyParam","申请参数"),
	apply("apply","入组申请"),
	
	visit("visit","随访申请"),
	patientList("patientList","申请记录"),
	patientDetail("patientDetail","记录详情"),
	update("update","版本升级")
	;

	private final String id;
	private final String name;
	
	AppReqTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AppReqTypeEnum.class).getName();
	}
}
