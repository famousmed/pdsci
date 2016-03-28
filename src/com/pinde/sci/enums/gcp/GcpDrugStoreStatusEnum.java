package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpDrugStoreStatusEnum implements GeneralEnum<String> {
	
	UnStorage("UnStorage","未入库"),
	Storaged("Storaged","已入库"),
	UnSend("UnSend","未发药"),
	Send("Send","已发药"),
	Back("Back","已返还"),
	Recall("Recall","召回"),
	Disable("Disable","废止"),
	;

	private final String id;
	private final String name;
	
	GcpDrugStoreStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, GcpDrugStoreStatusEnum.class).getName();
	}
}
