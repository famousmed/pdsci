package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ContactOrderStatusEnum implements GeneralEnum<String> {
	
	Save("Save","未提交"),
	Submit("Submit","已提交"),
	SalePassed("SalePassed","销售审核通过"),
	SaleUnPassed("Save","销售审核不通过"),
	BusinessPassed("Passed","商务审核通过"),
	BusinessUnPassed("Save","商务审核不通过"),
	ManagerAuditing("ManagerAuditing","商务审核通过至总经理审核"),
	ManagerPassed("Passed","总经理审核通过"),
	ManagerUnPassed("Save","总经理审核不通过"),
	Received("Received","已接收"),
	Implementing("Implementing","实施中"),
	Implemented("Implemented","实施完成"),
	ReturnVisited("ReturnVisited","回访完成"),
	Closed("Closed","已关闭")
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
