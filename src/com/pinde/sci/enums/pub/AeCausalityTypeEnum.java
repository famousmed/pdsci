package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AeCausalityTypeEnum implements GeneralEnum<String> {
	Sure("Sure","�϶�"),
	Probably("Probably","�ܿ���"),
	Possible("Possible","����"),
	Suspicious("Suspicious","����"),
	Impossible("Locked","������")
	;

	private final String id;
	private final String name;
	
	AeCausalityTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AeCausalityTypeEnum.class).getName();
	}
}
