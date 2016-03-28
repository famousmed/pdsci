package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProcessRemarkEnum implements GeneralEnum<String> {
	
	FirstAuditAgree("�е���λ���ͨ��"),
	FirstAuditNotAgree("�е���λ����˻�"),
	SecondAuditAgree("���ܲ������ͨ��"),
	SecondAuditNotAgree("���ܲ�������˻�"),
	ThirdAuditAgree("���������ͨ��"),
	ThirdAuditNotAgree("����������˻�"),
	ApproveAgree("����ͨ��"),
	ApproveNotAgree("���ͨ��"),
	;

	private final String id;
	private final String name;
	
	ProcessRemarkEnum(String name) {
		this.id = "";
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

//	public static String getNameById(String id) {
//		return EnumUtil.getById(id, ProcessRemarkEnum.class).getName();
//	}
}
