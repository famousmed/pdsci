package com.pinde.sci.enums.xjgl;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserChangeApplyStatusEnum implements GeneralEnum<String>{

	Save("Save","δ�ύ"),
	Submit("Submit","���ύ"),
	Approve("Approve","���ͨ��"),
	NotApprove("NotApprove","��˲�ͨ��")
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
