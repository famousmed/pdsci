package com.pinde.sci.enums.exam;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum BookImpStatusEnum implements GeneralEnum<String> {
	
	Save("Save","����"),
	Submit("Submit","�ύ"),
	NotChecked("NotChecked","У�鲻ͨ��"),
	Checked("Checked","У��ͨ��"),
	NotAudited("NotAudited","��˲�ͨ��"),
	Audited("Audited","���ͨ��"),
	;

	private final String id;
	private final String name;
	
	BookImpStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, BookImpStatusEnum.class).getName();
	}
}
