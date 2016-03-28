package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum EdcQueryStatusEnum implements GeneralEnum<String> {
	
	UnSend("UnSend","Œ¥∑¢ÀÕ"),
	Sended("Sended","“—∑¢ÀÕ"),
	Disabled("Disabled","∑œ÷π"),
	;

	private final String id;
	private final String name;
	
	EdcQueryStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, EdcQueryStatusEnum.class).getName();
	}
}
