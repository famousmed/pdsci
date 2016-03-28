package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbRecTypeEnum implements GeneralEnum<String> {
	
	ApplyFile("ApplyFile" , "�����ļ��嵥","N"),
	AddModNotice("AddModNotice" , "�����޸�֪ͨ","N"),
	InitApplication("InitApplication" , "��ʼ��������","Y"),
	InitWorksheetPRO ("InitWorksheetPRO" , "��ʼ��鹤����_����","Y"),
	InitWorksheetICF("InitWorksheetICF" , "��ʼ��鹤����_֪��ͬ����","Y"),
	RetrialApplication("RetrialApplication" , "������������","Y"),
	RetrialWorksheet("RetrialWorksheet" , "������鹤����","Y"),
	ReviseApplication("ReviseApplication" , "��������������","Y"),
	ReviseWorksheet("ReviseWorksheet" , "��������鹤����","Y"),
	ScheduleApplication("ScheduleApplication" , "�о���չ����","Y"),
	ScheduleWorksheet("ScheduleWorksheet" , "�о���չ��鹤����","Y"),
	SaeApplication("SaeApplication" , "���ز����¼������","Y"),
	SaeWorksheet("SaeWorksheet" , "���ز����¼���鹤����","Y"),
	ViolateApplication("ViolateApplication" , "Υ����������","Y"),
	ViolateWorksheet("ViolateWorksheet" , "Υ��������鹤����","Y"),
	TerminateApplication("TerminateApplication" , "��ͣ/��ֹ�о�����","Y"),
	TerminateWorksheet("TerminateWorksheet" , "��ͣ/��ֹ��鹤����","Y"),
	FinishApplication("FinishApplication" , "�о���ɱ���","Y"),
	FinishWorksheet("FinishWorksheet" , "�о������鹤����","Y"),
	IndepConsultantWorksheet("IndepConsultantWorksheet" , "����������ѯ��","Y"),
	QuickOpinion("QuickOpinion" , "���������ۺ����","N"),
	MeetingDecision("MeetingDecision" , "������������","N"),
	Minutes("Minutes" , "�����Ҫ","N"),
	ApproveFile("ApproveFile" , "�����������","N"),
	OpinionFile("OpinionFile" , "����������","N"),
	Archive("Archive" , "�ļ��浵","N"),
	;

	private final String id;
	private final String name;
	private final String isForm;
	
	IrbRecTypeEnum(String id,String name,String isForm) {
		this.id = id;
		this.name = name;
		this.isForm = isForm;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}
	
	public String getIsForm() {
		return isForm;
	}

	
	public static String getNameById(String id) {
		return EnumUtil.getById(id, IrbRecTypeEnum.class).getName();
	}
}
