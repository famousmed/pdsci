package com.pinde.sci.enums.jsres;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum BaseStatusEnum implements GeneralEnum<String> {
	
	NotSubmit("NotSubmit","未提交"),
	Auditing("Auditing","待审核"),
	ChargePassed("ChargePassed" , "市局审核通过"),
	GlobalPassed("GlobalPassed" , "省厅审核通过"),
	Passed("Passed" , "审核通过"),
	NotPassed("NotPassed" , "审核不通过")
	;

	private final String id;
	private final String name;
	
	BaseStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, BaseStatusEnum.class).getName();
	}
}
