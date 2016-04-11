package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpRecTypeEnum implements GeneralEnum<String> {
	EvaluationSheet("EvaluationSheet" , "立项评估表","N"),
	ApplyFile("ApplyFile" , "送审文件清单","N"),
	StartNotice("StartNotice" , "启动通知","N"),
	FinishWork("FinishWork" , "研究结束工作","N"),
	SummaryStamp("SummaryStamp" , "总结盖章","N"),
	ProvinceFiling("ProvinceFiling" , "省级备案","N"),
	Archive("Archive" , "文件归档","N"),
	
	IcfInspect("IcfInspect" , "知情同意书","Y"),
	FileInspect("FileInspect" , "文件核查","Y"),
	DrugInspect("DrugInspect" , "药物核查","Y"),
	RawDataInspect("RawDataInspect" , "原始数据核查","Y"),
	Org_First_CheckList("Org_First_CheckList","核查清单","Y"),
	Dept_OTG_CheckList("Dept_OTG_CheckList","核查清单","Y"),
	InspectSummary("InspectSummary" , "总结","Y"),
	;

	private final String id;
	private final String name;
	private final String isForm;
	
	GcpRecTypeEnum(String id,String name,String isForm) {
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
		return EnumUtil.getById(id, GcpRecTypeEnum.class).getName();
	}
}
