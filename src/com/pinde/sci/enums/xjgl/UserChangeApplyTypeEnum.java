package com.pinde.sci.enums.xjgl;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserChangeApplyTypeEnum implements GeneralEnum<String>{

	Makeup("Makeup","课程补考"),
	ChangeTrainType("ChangeTrainType","更换培养类别"),
	ChangeTeacher("ChangeTeacher","更换导师"),
	ChangeMajor("ChangeMajor","更换专业"),
	DelayExam("DelayExam","课程缓考"),
	DelayStudy("DelayStudy","课程缓修"),
	LeaveSchool("LeaveSchool","退学（转学）"),
	OutStudy("OutStudy","外出学习"),
	StopStudy("StopStudy","休学（复学）"),
	DelayGraduate("DelayGraduate","延期毕业")
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
