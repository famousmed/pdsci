package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum WorkOrderStatusEnum implements GeneralEnum<String> {
	
	Save("Save","未派工"),
	ApplyAudit("ApplyAudit","改派-提交本部门审核"),
	ApplyTargetAudit("ApplyTargetAudit","改派-本部门审核通过"),
	ApplyTargetUnPassed("ApplyTargetUnPassed","改派-目标部门审核不通过"),
	Implementing("Implementing","实施中"),
	Implemented("Implemented","实施完成"),
	CompletePassed("CompletePassed","实施完成审核通过"),
	CompleteUnPassed("CompleteUnPassed","实施完成审核不通过"),
	Passed("Passed","实施经理审核通过"),
	Closed("Closed","已关闭")
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
