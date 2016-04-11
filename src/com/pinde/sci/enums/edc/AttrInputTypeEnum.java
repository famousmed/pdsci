package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AttrInputTypeEnum implements GeneralEnum<String> {
	
	Text("text","�ı�"),
	Radio("radio","��ѡ"),
	Checkbox("checkbox","��ѡ"),
	Select("select","����"),
	Date("date","����"),
	Textarea("Textarea","�ı���")
	;

	private final String id;
	private final String name;
	
	AttrInputTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AttrInputTypeEnum.class).getName();
	}
}
