package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AppResultTypeEnum implements GeneralEnum<String> {
	
	Success("200","���׳ɹ�"),
	Req404("404","�����ڵĽ�����"),
	Illegal("403","��Ȩ����"),
	Error("500","��̨����"),
	
	PhoneEmpty("0101","�ֻ���Ϊ��"),
	PasswordEmpty("0102","����Ϊ��"),
	LoginError("0199","�ֻ��Ż��������"),
	UserFlowNull("0103","�û�Ϊ��"),
	UserUnActivated("0104","�û�δ�����������"),
	
	UserFlowEmpty("0201","�û�Ψһ��ʶΪ��"),
	UserNotFound("0202","������û�Ψһ��ʶ"),
	
	
	PatientNotFound("0401","����ʧ�ܣ�δ����������"),
	RecNotFound("0402","����ʧ�ܣ��޿��������"),
	DrugNotFound("0403","����ʧ�ܣ�ҩ�ﲻ��"),
	CfgNotFound("0404","����ʧ�ܣ��������δ����"),
	RandomLock("0409","����ʧ�ܣ��������")
	;

	private final String id;
	private final String name;
	
	AppResultTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AppResultTypeEnum.class).getName();
	}
}
