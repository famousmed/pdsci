package com.pinde.sci.enums.xjgl;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserChangeApplyTypeEnum implements GeneralEnum<String>{

	Makeup("Makeup","�γ̲���"),
	ChangeTrainType("ChangeTrainType","�����������"),
	ChangeTeacher("ChangeTeacher","������ʦ"),
	ChangeMajor("ChangeMajor","����רҵ"),
	DelayExam("DelayExam","�γ̻���"),
	DelayStudy("DelayStudy","�γ̻���"),
	LeaveSchool("LeaveSchool","��ѧ��תѧ��"),
	OutStudy("OutStudy","���ѧϰ"),
	StopStudy("StopStudy","��ѧ����ѧ��"),
	DelayGraduate("DelayGraduate","���ڱ�ҵ")
	;
	private final String id;
	private final String name;
	
	UserChangeApplyTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, UserChangeApplyTypeEnum.class).getName();
	}
}
