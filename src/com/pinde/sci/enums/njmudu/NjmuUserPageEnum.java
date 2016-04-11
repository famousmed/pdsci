package com.pinde.sci.enums.njmudu;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum NjmuUserPageEnum implements GeneralEnum<String>{
	Student("njmuedu/user/student" , "ѧ����Ϣҳ��"),
	Teacher("njmuedu/user/teacher" , "��ʦ��Ϣҳ��"),
	HospitalManager("njmuedu/user/hospital" , "ҽԺ����Աҳ��"),
	UniversityManager("njmuedu/user/admin" , "ѧУ����Աҳ��"),
	AdminManager("njmuedu/user/system" , "ϵͳ����Աҳ��")
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
