package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjCompleteStatusEnum implements GeneralEnum<String> {
	
	Apply("Apply","��д"),
	Submit("Submit","�ύ"),
	FirstAudit("FirstAudit","�е���λ���ͨ��"),
	FirstBack("FirstBack","�е���λ�˻�"),
	SecondAudit("SecondAudit","���ܲ������ͨ��"),
	SecondBack("SecondBack","���ܲ����˻�"),
	ThirdAudit("ThirdAudit","���������ͨ��"),
	ThirdBack("ThirdAudit","�������˻�"),
	;

	private final String id;
	private final String name;
	
	ProjCompleteStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, ProjCompleteStatusEnum.class).getName();
	}
}
