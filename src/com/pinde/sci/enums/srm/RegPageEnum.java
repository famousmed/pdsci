package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RegPageEnum implements GeneralEnum<String>{
	orgRegPage("sys/reg/srm/orgReg" , "������������Ϣҳ��"),
	ProjRegPage("sys/reg/srm/projReg" , "��Ŀ��������Ϣҳ��"),
	ExpertRegPage("sys/reg/srm/expertReg" , "ר����Ϣҳ��")
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
