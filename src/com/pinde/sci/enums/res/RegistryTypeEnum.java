package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RegistryTypeEnum implements GeneralEnum<String> {
	
	TeachRecordRegistry("TeachRecordRegistry","��ѧ��¼","Y","N","N"),
	CaseRegistry("CaseRegistry","����","Y","N","N"),
	EmergencyCase("EmergencyCase","�ż�֢����","Y","N","N"),
	DiseaseRegistry("DiseaseRegistry","����","Y","Y","Y"),
	SkillRegistry("SkillRegistry","��������","Y","Y","Y"),
	OperationRegistry("OperationRegistry","����","Y","Y","Y"),
	ManageBedRegistry("ManageBedRegistry","�ܴ���¼","Y","Y","N"),
	Grave("Grave","Σ�ؼ�¼","Y","Y","N"),
	AnnualTrainForm("AnnualTrainForm","�����ѵ��¼","N","N","N"),
	SkillAndOperationRegistry("SkillAndOperationRegistry","�������ܺ�����","Y","Y","Y"),
	HospitalizationLog("HospitalizationLog","סԺ־","Y","Y","N"),
	CampaignRegistry("CampaignRegistry","�μӻ","Y","N","N"),
	Internship("Internship","ʵϰ��¼","Y","N","N"),
	;

	private final String id;
	private final String name;
	private final String haveReq;
	private final String haveAppeal;
	private final String haveItem;

	RegistryTypeEnum(String id,String name,String haveReq,String haveAppeal,String haveItem) {
		this.id = id;
		this.name = name;
		this.haveReq = haveReq;
		this.haveAppeal = haveAppeal;
		this.haveItem = haveItem;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}
	
	public String getHaveAppeal(){
		return haveAppeal;
	}
	
	public String getHaveReq(){
		return haveReq;
	}
	
	public String getHaveItem(){
		return haveItem;
	}
	
	public static String getNameById(String id) {
		return EnumUtil.getById(id, RegistryTypeEnum.class).getName();
	}
}
