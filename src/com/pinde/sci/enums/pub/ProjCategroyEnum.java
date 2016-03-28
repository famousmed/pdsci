package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjCategroyEnum implements GeneralEnum<String> {
	
	Yw("yw","药物试验"),
	Ky("ky","临床科研"),
	Qx("qx","医疗器械"),
	Xk("xk","重点学科"),
	Rc("rc","重点人才"),
	;

	private final String id;
	private final String name;
	
	ProjCategroyEnum(String id,String name) {
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

	public  static String getNameById(String id) {
		return EnumUtil.getById(id, ProjCategroyEnum.class).getName();
	}
}
