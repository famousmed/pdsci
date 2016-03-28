package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpDrugStoreStatusEnum implements GeneralEnum<String> {
	
	UnStorage("UnStorage","δ���"),
	Storaged("Storaged","�����"),
	UnSend("UnSend","δ��ҩ"),
	Send("Send","�ѷ�ҩ"),
	Back("Back","�ѷ���"),
	Recall("Recall","�ٻ�"),
	Disable("Disable","��ֹ"),
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
