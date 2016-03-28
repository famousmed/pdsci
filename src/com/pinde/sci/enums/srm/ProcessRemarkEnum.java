package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProcessRemarkEnum implements GeneralEnum<String> {
	
	FirstAuditAgree("承担单位审核通过"),
	FirstAuditNotAgree("承担单位审核退回"),
	SecondAuditAgree("主管部门审核通过"),
	SecondAuditNotAgree("主管部门审核退回"),
	ThirdAuditAgree("卫生局审核通过"),
	ThirdAuditNotAgree("卫生局审核退回"),
	ApproveAgree("立项通过"),
	ApproveNotAgree("立项不通过"),
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
