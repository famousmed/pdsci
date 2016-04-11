package com.pinde.sci.enums.edu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserPageEnum implements GeneralEnum<String>{
	Student("edu/user/student" , "ѧ����Ϣҳ��"),
	Teacher("edu/user/teacher" , "��ʦ��Ϣҳ��"),
	HospitalManager("edu/user/hospital" , "ҽԺ����Աҳ��"),
	UniversityManager("edu/user/admin" , "ѧУ����Աҳ��"),
	AdminManager("edu/user/system" , "ϵͳ����Աҳ��")
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
