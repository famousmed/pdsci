package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbRecTypeEnum implements GeneralEnum<String> {
	
	ApplyFile("ApplyFile" , "送审文件清单","N"),
	AddModNotice("AddModNotice" , "补充修改通知","N"),
	InitApplication("InitApplication" , "初始审查申请表","Y"),
	InitWorksheetPRO ("InitWorksheetPRO" , "初始审查工作表_方案","Y"),
	InitWorksheetICF("InitWorksheetICF" , "初始审查工作表_知情同意书","Y"),
	RetrialApplication("RetrialApplication" , "复审审查申请表","Y"),
	RetrialWorksheet("RetrialWorksheet" , "复审审查工作表","Y"),
	ReviseApplication("ReviseApplication" , "修正案审查申请表","Y"),
	ReviseWorksheet("ReviseWorksheet" , "修正案审查工作表","Y"),
	ScheduleApplication("ScheduleApplication" , "研究进展报告","Y"),
	ScheduleWorksheet("ScheduleWorksheet" , "研究进展审查工作表","Y"),
	SaeApplication("SaeApplication" , "严重不良事件报告表","Y"),
	SaeWorksheet("SaeWorksheet" , "严重不良事件审查工作表","Y"),
	ViolateApplication("ViolateApplication" , "违背方案报告","Y"),
	ViolateWorksheet("ViolateWorksheet" , "违背方案审查工作表","Y"),
	TerminateApplication("TerminateApplication" , "暂停/终止研究报告","Y"),
	TerminateWorksheet("TerminateWorksheet" , "暂停/终止审查工作表","Y"),
	FinishApplication("FinishApplication" , "研究完成报告","Y"),
	FinishWorksheet("FinishWorksheet" , "研究完成审查工作表","Y"),
	IndepConsultantWorksheet("IndepConsultantWorksheet" , "独立顾问咨询表","Y"),
	QuickOpinion("QuickOpinion" , "快速主审综合意见","N"),
	MeetingDecision("MeetingDecision" , "会议审查决定表","N"),
	Minutes("Minutes" , "会议纪要","N"),
	ApproveFile("ApproveFile" , "伦理审查批件","N"),
	OpinionFile("OpinionFile" , "伦理审查意见","N"),
	Archive("Archive" , "文件存档","N"),
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
