package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpProjSubTypeEnum implements GeneralEnum<String> {
	
	Ⅰ("Ⅰ","Ⅰ期"),
	Ⅱ("Ⅱ","Ⅱ期"),
	Ⅲ("Ⅲ","Ⅲ期"),
	Ⅳ("Ⅳ","Ⅳ期"),
	Ky("ky","临床科研"),
	Qx("qx","医疗器械"),
	Qt("qt","其他")
	;

	private final String id;
	private final String name;
	
	GcpProjSubTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, GcpProjSubTypeEnum.class).getName();
	}
}
