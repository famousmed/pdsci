package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpRecTypeEnum implements GeneralEnum<String> {
	EvaluationSheet("EvaluationSheet" , "����������","N"),
	ApplyFile("ApplyFile" , "�����ļ��嵥","N"),
	StartNotice("StartNotice" , "����֪ͨ","N"),
	FinishWork("FinishWork" , "�о���������","N"),
	SummaryStamp("SummaryStamp" , "�ܽ����","N"),
	ProvinceFiling("ProvinceFiling" , "ʡ������","N"),
	Archive("Archive" , "�ļ��鵵","N"),
	
	IcfInspect("IcfInspect" , "֪��ͬ����","Y"),
	FileInspect("FileInspect" , "�ļ��˲�","Y"),
	DrugInspect("DrugInspect" , "ҩ��˲�","Y"),
	RawDataInspect("RawDataInspect" , "ԭʼ���ݺ˲�","Y"),
	Org_First_CheckList("Org_First_CheckList","�˲��嵥","Y"),
	Dept_OTG_CheckList("Dept_OTG_CheckList","�˲��嵥","Y"),
	InspectSummary("InspectSummary" , "�ܽ�","Y"),
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
