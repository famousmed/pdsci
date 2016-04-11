package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbAuthTypeEnum implements GeneralEnum<String> {
	
	CommitteePRO("1","����ίԱ_����"),
	CommitteeICF("2","����ίԱ_֪��ͬ����"),
	Committee("3","����ίԱ"),
	Consultant("4","��������"),
	;

	private final String id;
	private final String name;
	


	IrbAuthTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, IrbAuthTypeEnum.class).getName();
	}
}
