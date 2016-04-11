package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RecStatusEnum implements GeneralEnum<String> {
	
	Edit("Edit","��д"),
	Submit("Submit","�ύ"),
	TeacherAuditY("TeacherAuditY","������ʦ���ͨ��"),
	TeacherAuditN("TeacherAuditN","������ʦ��˲�ͨ��"),
	HeadAuditY("HeadAuditY","���������ͨ��"),
	HeadAuditN("HeadAuditN","��������˲�ͨ��"),
	ManagerAuditY("ManagerAuditY","�����������ͨ��"),
	ManagerAuditN("ManagerAuditN","����������˲�ͨ��"),
	AdminAuditY("AdminAuditY","����Ա���ͨ��"),
	AdminAuditN("AdminAuditN","����Ա��˲�ͨ��"),
	;

	private final String id;
	private final String name;
	


	RecStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, RecStatusEnum.class).getName();
	}
}
