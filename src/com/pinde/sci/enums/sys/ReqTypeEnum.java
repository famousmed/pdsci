package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ReqTypeEnum implements GeneralEnum<String> {
	
	GET("GET","查询"),
	POST("POST","新增"),
	PUT("PUT","修改"),
	DELETE("DELETE","删除")
	;

	private final String id;
	private final String name;
	
	ReqTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, ReqTypeEnum.class).getName();
	}
}
