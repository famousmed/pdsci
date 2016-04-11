package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AidProjStatusEnum implements GeneralEnum<String>{
	NonSubmit("NonSubmit","待提交"),//已创建,待提交
	NonAudit("NonAudit","待审核"),//已提交,待审核
	Pass("Pass" , "审核通过"),//审核通过
	Back("Back", "退回"),//退回
	;
	private final String id;
	private final String name;
	
	private AidProjStatusEnum(String id, String name) {
		this.id = id;
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}
	
	public static String getNameById(String id) {
		return EnumUtil.getById(id, AidProjStatusEnum.class).getName();
	}
}
