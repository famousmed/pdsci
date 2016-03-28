package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpQcStatusEnum implements GeneralEnum<String> {
	
	Save("Save","保存"),
	Submit("Submit","提交"),
	OrgCheck("OrgCheck","机构已审核"),
	Feedback("Feedback","已反馈"),
	Finish("Finish","完成")
	;

	private final String id;
	private final String name;
	
	GcpQcStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, GcpQcStatusEnum.class).getName();
	}
}
