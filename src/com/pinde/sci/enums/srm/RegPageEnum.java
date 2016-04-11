package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RegPageEnum implements GeneralEnum<String>{
	orgRegPage("sys/reg/srm/orgReg" , "机构负责人信息页面"),
	ProjRegPage("sys/reg/srm/projReg" , "项目负责人信息页面"),
	ExpertRegPage("sys/reg/srm/expertReg" , "专家信息页面")
	;

	private String id;
	private String name;
	
	RegPageEnum(String id , String name){
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
		return EnumUtil.getById(id, RegPageEnum.class).getName();
	}
}
