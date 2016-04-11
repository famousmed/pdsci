package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ResRecTypeEnum implements GeneralEnum<String> {
	
	CaseRegistry("CaseRegistry","大病历登记表","Y","大病历"),
	DiseaseRegistry("DiseaseRegistry","病种登记表","Y","病种"),
	OperationRegistry("OperationRegistry","手术登记表","Y","手术"),
	SkillRegistry("SkillRegistry","操作技能登记表","Y","操作技能"),
	SkillAndOperationRegistry("SkillAndOperationRegistry","操作技能和手术登记表","Y","操作技能和手术"),
	CampaignRegistry("CampaignRegistry","活动登记表","Y","参加活动"),
	TrainData("TrainData","培训数据","Y","培训数据"),
	AfterSummary("AfterSummary","出科小结","Y","出科小结"),
	AfterEvaluation("AfterEvaluation","出科考核表","Y","出科考核"),
	TeacherGrade("TeacherGrade","对带教老师评分","N","带教老师评分"),
	DeptGrade("DeptGrade","对科室评分","N","科室评分"),
	TeachRegistry("TeachRegistry","教学登记","Y","教学登记"),
	ManageBedRegistry("ManageBedRegistry","管理病床登记表","Y","管床记录"),
	Grave("Grave","危重记录","Y","危重记录"),
	Internship("Internship","实习记录","Y","实习记录"),
	Ethics("Ethics","医德医风","Y","医德医风"),
	Document("Document","医学文案","Y","医学文案"),
	Appraisal("Appraisal","实习总鉴定","Y","实习总鉴定"),
	PreTrainForm("PreTrainForm","岗前培训表","Y","岗前培训表"),
	AnnualTrainForm("AnnualTrainForm","年度培训记录","Y","年度培训记录"),
	TeachRecordRegistry("TeachRecordRegistry","教学记录","Y","教学记录"),
	SpeAbilityAssess("SpeAbilityAssess","年度专业能力评估表","Y","年度专业能力评估表"),
	RegistryCheckForm("RegistryCheckForm","年度考核登记表","Y","年度考核登记表"),
	EmergencyCase("EmergencyCase","门急症病例","Y","门急症病例"),
	AnnualActivity("AnnualActivity","年度活动","Y","年度活动"),
	HospitalizationLog("HospitalizationLog","住院志","Y","住院志"),
	;

	private final String id;
	private final String name;
	private final String isForm;
	private final String typeName;


	ResRecTypeEnum(String id,String name,String isForm,String typeName) {
		this.id = id;
		this.name = name;
		this.isForm = isForm;
		this.typeName = typeName;
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
	public String getTypeName() {
		return typeName;
	}
	public static String getNameById(String id) {
		return EnumUtil.getById(id, ResRecTypeEnum.class).getName();
	}
}
