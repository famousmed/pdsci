package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum WorkOrderStatusEnum implements GeneralEnum<String> {
	
	Save("Save","δ�ɹ�"),
	ApplyAudit("ApplyAudit","����-�ύ���������"),
	ApplyTargetAudit("ApplyTargetAudit","����-���������ͨ��"),
	ApplyTargetUnPassed("ApplyTargetUnPassed","����-Ŀ�겿����˲�ͨ��"),
	Implementing("Implementing","ʵʩ��"),
	Implemented("Implemented","ʵʩ���"),
	CompletePassed("CompletePassed","ʵʩ������ͨ��"),
	CompleteUnPassed("CompleteUnPassed","ʵʩ�����˲�ͨ��"),
	Passed("Passed","ʵʩ�������ͨ��"),
	Closed("Closed","�ѹر�")
	;

	private final String id;
	private final String name;
	
	WorkOrderStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, WorkOrderStatusEnum.class).getName();
	}
	
}
