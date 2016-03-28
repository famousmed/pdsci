package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AppReqTypeEnum implements GeneralEnum<String> {
	
	login("login","�û���¼"),
	projList("projList","��Ŀ�б�"),
	applyParam("applyParam","�������"),
	apply("apply","��������"),
	
	visit("visit","�������"),
	patientList("patientList","�����¼"),
	patientDetail("patientDetail","��¼����"),
	update("update","�汾����")
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
