package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjCategroyEnum implements GeneralEnum<String> {
	
	Yw("yw","ҩ������"),
	Ky("ky","�ٴ�����"),
	Qx("qx","ҽ����е"),
	Xk("xk","�ص�ѧ��"),
	Rc("rc","�ص��˲�"),
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
