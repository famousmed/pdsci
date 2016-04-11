package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ResRecTypeEnum implements GeneralEnum<String> {
	
	CaseRegistry("CaseRegistry","�����ǼǱ�","Y","����"),
	DiseaseRegistry("DiseaseRegistry","���ֵǼǱ�","Y","����"),
	OperationRegistry("OperationRegistry","�����ǼǱ�","Y","����"),
	SkillRegistry("SkillRegistry","�������ܵǼǱ�","Y","��������"),
	SkillAndOperationRegistry("SkillAndOperationRegistry","�������ܺ������ǼǱ�","Y","�������ܺ�����"),
	CampaignRegistry("CampaignRegistry","��ǼǱ�","Y","�μӻ"),
	TrainData("TrainData","��ѵ����","Y","��ѵ����"),
	AfterSummary("AfterSummary","����С��","Y","����С��"),
	AfterEvaluation("AfterEvaluation","���ƿ��˱�","Y","���ƿ���"),
	TeacherGrade("TeacherGrade","�Դ�����ʦ����","N","������ʦ����"),
	DeptGrade("DeptGrade","�Կ�������","N","��������"),
	TeachRegistry("TeachRegistry","��ѧ�Ǽ�","Y","��ѧ�Ǽ�"),
	ManageBedRegistry("ManageBedRegistry","�������ǼǱ�","Y","�ܴ���¼"),
	Grave("Grave","Σ�ؼ�¼","Y","Σ�ؼ�¼"),
	Internship("Internship","ʵϰ��¼","Y","ʵϰ��¼"),
	Ethics("Ethics","ҽ��ҽ��","Y","ҽ��ҽ��"),
	Document("Document","ҽѧ�İ�","Y","ҽѧ�İ�"),
	Appraisal("Appraisal","ʵϰ�ܼ���","Y","ʵϰ�ܼ���"),
	PreTrainForm("PreTrainForm","��ǰ��ѵ��","Y","��ǰ��ѵ��"),
	AnnualTrainForm("AnnualTrainForm","�����ѵ��¼","Y","�����ѵ��¼"),
	TeachRecordRegistry("TeachRecordRegistry","��ѧ��¼","Y","��ѧ��¼"),
	SpeAbilityAssess("SpeAbilityAssess","���רҵ����������","Y","���רҵ����������"),
	RegistryCheckForm("RegistryCheckForm","��ȿ��˵ǼǱ�","Y","��ȿ��˵ǼǱ�"),
	EmergencyCase("EmergencyCase","�ż�֢����","Y","�ż�֢����"),
	AnnualActivity("AnnualActivity","��Ȼ","Y","��Ȼ"),
	HospitalizationLog("HospitalizationLog","סԺ־","Y","סԺ־"),
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
