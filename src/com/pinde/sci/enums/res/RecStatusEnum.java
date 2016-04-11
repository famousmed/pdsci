package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RecStatusEnum implements GeneralEnum<String> {
	
	Edit("Edit","填写"),
	Submit("Submit","提交"),
	TeacherAuditY("TeacherAuditY","带教老师审核通过"),
	TeacherAuditN("TeacherAuditN","带教老师审核不通过"),
	HeadAuditY("HeadAuditY","科主任审核通过"),
	HeadAuditN("HeadAuditN","科主任审核不通过"),
	ManagerAuditY("ManagerAuditY","基地主任审核通过"),
	ManagerAuditN("ManagerAuditN","基地主任审核不通过"),
	AdminAuditY("AdminAuditY","管理员审核通过"),
	AdminAuditN("AdminAuditN","管理员审核不通过"),
	;

	private final String id;
	private final String name;
	


	RecStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, RecStatusEnum.class).getName();
	}
}
