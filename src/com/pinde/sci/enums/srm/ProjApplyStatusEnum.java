package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjApplyStatusEnum implements GeneralEnum<String> {
	
	Apply("Apply","�걨��д"),
	Submit("Submit","�걨�ύ"),
	FirstAudit("FirstAudit","�е���λ���ͨ��"),
	FirstBack("FirstBack","�е���λ�˻�"),
	SecondAudit("SecondAudit","���ܲ������ͨ��"),
	SecondBack("SecondBack","���ܲ����˻�"),
	ThirdAudit("ThirdAudit","���������ͨ��"),
	ThirdBack("ThirdBack","�������˻�"),
	;

	private final String id;
	private final String name;
	
	ProjApplyStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, ProjApplyStatusEnum.class).getName();
	}
}
