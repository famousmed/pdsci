package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ContractStatusEnum implements GeneralEnum<String> {
	
	Auditing("Auditing","¥˝…Û∫À"),
	Implement("Implement","÷¥––÷–"),
	Finish("Finish","÷¥––ÕÍ±œ"),
	Terminate("Terminate","‘›Õ£"),
	End("End","÷’÷π")
	;

	private final String id;
	private final String name;
	
	ContractStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, ContractStatusEnum.class).getName();
	}
	
}
