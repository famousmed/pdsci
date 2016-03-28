package com.pinde.sci.enums.xjgl;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserChangeApplyStatusEnum implements GeneralEnum<String>{

	Save("Save","未提交"),
	Submit("Submit","已提交"),
	Approve("Approve","审核通过"),
	NotApprove("NotApprove","审核不通过")
	;
	private final String id;
	private final String name;
	
	UserChangeApplyStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, UserChangeApplyStatusEnum.class).getName();
	}
}
