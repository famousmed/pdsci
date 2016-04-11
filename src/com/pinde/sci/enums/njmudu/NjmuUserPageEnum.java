package com.pinde.sci.enums.njmudu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum NjmuUserPageEnum implements GeneralEnum<String>{
	Student("njmuedu/user/student" , "学生信息页面"),
	Teacher("njmuedu/user/teacher" , "教师信息页面"),
	HospitalManager("njmuedu/user/hospital" , "医院管理员页面"),
	UniversityManager("njmuedu/user/admin" , "学校管理员页面"),
	AdminManager("njmuedu/user/system" , "系统管理员页面")
	;

	private String id;
	private String name;
	
	NjmuUserPageEnum(String id , String name){
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
		return EnumUtil.getById(id, NjmuUserPageEnum.class).getName();
	}
}
