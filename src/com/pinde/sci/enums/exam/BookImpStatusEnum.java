package com.pinde.sci.enums.exam;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum BookImpStatusEnum implements GeneralEnum<String> {
	
	Save("Save","保存"),
	Submit("Submit","提交"),
	NotChecked("NotChecked","校验不通过"),
	Checked("Checked","校验通过"),
	NotAudited("NotAudited","审核不通过"),
	Audited("Audited","审核通过"),
	;

	private final String id;
	private final String name;
	
	BookImpStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, BookImpStatusEnum.class).getName();
	}
}
