package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ContactOrderStatusEnum implements GeneralEnum<String> {
	
	Save("Save","δ�ύ"),
	Submit("Submit","���ύ"),
	SalePassed("SalePassed","�������ͨ��"),
	SaleUnPassed("Save","������˲�ͨ��"),
	BusinessPassed("Passed","�������ͨ��"),
	BusinessUnPassed("Save","������˲�ͨ��"),
	ManagerAuditing("ManagerAuditing","�������ͨ�����ܾ������"),
	ManagerPassed("Passed","�ܾ������ͨ��"),
	ManagerUnPassed("Save","�ܾ�����˲�ͨ��"),
	Received("Received","�ѽ���"),
	Implementing("Implementing","ʵʩ��"),
	Implemented("Implemented","ʵʩ���"),
	ReturnVisited("ReturnVisited","�ط����"),
	Closed("Closed","�ѹر�")
	;

	private final String id;
	private final String name;
	
	ContactOrderStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, ContactOrderStatusEnum.class).getName();
	}
	
}
