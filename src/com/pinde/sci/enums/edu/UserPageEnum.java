package com.pinde.sci.enums.edu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserPageEnum implements GeneralEnum<String>{
	Student("edu/user/student" , "学生信息页面"),
	Teacher("edu/user/teacher" , "教师信息页面"),
	HospitalManager("edu/user/hospital" , "医院管理员页面"),
	UniversityManager("edu/user/admin" , "学校管理员页面"),
	AdminManager("edu/user/system" , "系统管理员页面")
	;

	private String id;
	private String name;
	
	UserPageEnum(String id , String name){
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
		return EnumUtil.getById(id, UserPageEnum.class).getName();
	}
}
