package com.pinde.sci.enums.erp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ContractTypeEnum implements GeneralEnum<String> {
	
	Product("Product","产品","Sales"),
	Project("Project","项目","Sales"),
	ProductProject("ProductProject","产品+项目","Sales"),
	Upgrade("Upgrade","升级合同","Second"),
	Maintain("Maintain","维护合同","Second")
	;

	private final String id;
	private final String name;
	private final String categoryId;
	
	ContractTypeEnum(String id,String name,String categoryId) {
		this.id = id;
		this.name = name;
		this.categoryId = categoryId;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public static String getNameById(String id) {
		return EnumUtil.getById(id, ContractTypeEnum.class).getName();
	}
	
	public static String getCategoryIdById(String id) {
		return ((ContractTypeEnum)EnumUtil.getById(id, ContractTypeEnum.class)).getCategoryId();
	}
}
