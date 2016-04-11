package com.pinde.sci.enums.sys;

import java.util.List;
import java.util.Map;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;
import com.pinde.sci.model.mo.SysDict;

public enum DictTypeEnum implements GeneralEnum<String> {
	
	ProjType("ProjType","������Ŀ����","srm"),//������Ŀ
	SubjType("SubjType","�ص�ѧ������","srm"),//�ص�ѧ��
	TalentType("TalentType","�ص��˲�����","srm"),//�ص��˲�
	AidProjType("AidProjType" , "��Ŀ��������" , "srm"),//��Ŀ��������
	
	AidCountryProjType("AidCountryProjType","��Ŀ����[����].���Ҽ�","srm"),
	AidProvinceProjType("AidProvinceProjType","��Ŀ����[����].ʡ��","srm"),
	AidCityProjType("AidCityProjType","��Ŀ����[����].������","srm"),
	
	UserTitle("UserTitle","��Ա.ְ��","sys"),
	UserDegree("UserDegree","��Ա.ѧλ","sys"),
	UserEducation("UserEducation","��Ա.ѧ��","sys"),
	UserPost("UserPost","��Ա.ְ��","sys"),
	
	LaborPay("LaborPay" , "ר��.����֧����ʽ" , "srm"),
	
//	PersonalInfo("PersonalInfo","�˲�.�������","srm"),
//	PostgraduateTeacher("PostgraduateTeacher","�˲�.�о�����ʦ","srm"),
//	TalentsDevelop("TalentsDevelop","�˲�.�˲�����","srm"),
//	AcademicHonour("AcademicHonour","�˲�.ѧ������","srm"),
	
//	LanSkillful("LanSkillful","ҽѧ�¼���.���������̶�","srm"),
	
//    DiscussType("DiscussType","�о����","sys"),
//    TrueAndFalse("TrueAndFalse","�����","sys"),
//    SubjectInfo("SubjectInfo","ѧ�����","sys"),
	
	
	OrgBelong("OrgBelong","�ɹ�.������λ","srm"),
	ProjSource("ProjSource","�ɹ�.��Ŀ��Դ","srm"),
	LanguageType("LanguageType","�ɹ�.��������","srm"),	
	AuthorType("AuthorType","�ɹ�.��������","srm"),
	SubjectType("SubjectType","�ɹ�.ѧ������","srm"),
	ApplyUserType("ApplyUserType","�ɹ�.����˳��","srm"),
	
	ThesisType("ThesisType","����.��������","srm"),
	JournalType("JournalType","����.�ڿ�����","srm"),
	PublishType("PublishType","����.��������","srm"),
	PublishScope("PublishScope","����.����Χ","srm"),
	MeetingType("MeetingType","����.��������","srm"),
	
	AchType("AchType","�Ƽ�.�ɹ���ʽ","srm"),
	PrizedGrade("PrizedGrade","�Ƽ�.�񽱼���","srm"),
	PrizedLevel("PrizedLevel","�Ƽ�.�񽱵ȼ�","srm"),
	
	AchBookType("AchBookType","����.�������","srm"),
	PressLevelType("PressLevelType","����.�����缶��","srm"),
	PlaceNameType("PlaceNameType","����.�����","srm"),
	WriteNameType("WriteNameType","����.����.�α�����","srm"),
	
	CopyrightType("CopyrightType","����Ȩ.����Ȩ����","srm"),
	
	AppraisalResultName("AppraisalResultName","����.��������","srm"),
	AppraisalTypeName("AppraisalTypeName","����.������ʽ","srm"),
	FinishTypeName("FinishTypeName","����.�����ʽ","srm"),
	
	PatentType("PatentType","ר��.ר������","srm"),
	PatentRange("PatentRange","ר��.ר����Χ","srm"),
	PatentStatus("PatentStatus","ר��.ר��״̬","srm"),
	PatentCooperType("PatentCooperType","ר��.��������","srm"),
	
	AcceptOrg("AcceptOrg" , "�о�����.���ɵ�λ" , "srm"),
	
	YhProjCategory("YhProjCategory","�ຼ.��Ŀ���","srm"),
	YhTechnologyField("YhTechnologyField","�ຼ.��������","srm"),
	YhTechnologySource("YhTechnologySource","�ຼ.������Դ","srm"),
	YhProjStatus("YhProjStatus","�ຼ.��Ŀ״̬","srm"),
	YhBAProjCategory("YhBAProjCategory","�ຼ.������Ŀ��Դ/���","srm",2),
	
	JsPlanCategory("JsPlanCategory","����.�ƻ����","srm"),
	JsApplyType("JsApplyType","����.��������","srm"),
	JsRelyType("JsRelyType","����.��������","srm"),
	JsOrgCharacter("JsOrgCharacter","����.��λ����","srm"),
	JsSubordinateRelation("JsSubordinateRelation","����.������ϵ","srm"),
	JsStudyAbroadTime("JsStudyAbroadTime","����.��ѧʱ��","srm"),
	
	GcpProjType("GcpProjType","��Ŀ���","irb,gcp"),
	TrackFrequency("TrackFrequency","�������Ƶ��","irb"),
	
	RegulationCountry("RegulationCountry","�����ļ�.�����ļ�","gcp"),
	RegulationLocal("RegulationLocal","�����ļ�.�ط��ļ�","gcp"),
	RegulationOrg("RegulationOrg","�����ļ�.�����ļ�","gcp"),
	RegulationDept("RegulationDept","�����ļ�.רҵ���ļ�","gcp"),
	
	GcpFundUses("GcpFundUses","������;","gcp"),
	
	DoseUnit("DoseUnit","������λ","gcp"),
	PreparationUnit("PreparationUnit","�Ƽ���λ","gcp"),
	Usage("Usage","��ҩ;��","gcp"),
	Solution("Solution","��Һ","gcp"),
	MiniPackUnit("MiniPackUnit","��С��װ��λ","gcp"),

	
	VisitType("VisitType","ECRF.��������","edc"),
	StandardUnit("StandardUnit","ECRF.����ֵ��λ","edc"),
	ModuleType("ModuleType","ECRF.ģ������","edc"),
	QueryType("QueryType","ECRF.��������","edc"),
	
	BudgetItem("BudgetItem","����.Ԥ����","srm"),
	ProjFundType("ProjFundType","����.��������","srm"),
	ProjFundAccountsType("ProjFundAccountsType","����.���ѵ�������","srm"),	

//	SysWorkStation("SysWorkStation","����վ","sys"),
	SysModule("SysModule","ϵͳ.ģ��˵�","sys",3),
	Region("Region","ϵͳ.�����������","sys",3),
//	SysMenuSet("SysMenuSet","ϵͳ.һ���˵�","sys",2),
//	SysMenu("SysMenu","ϵͳ.�����˵�","sys",3),
	
	
	
	CourseMajor("CourseMajor","edu.רҵ","edu"),
	NjmuCourseMajor("NjmuCourseMajor","edu.רҵ","njmuedu"),
	
	CustomerGrade("CustomerGrade","�ͻ��ȼ�","erp"),
	HospitalGrade("HospitalGrade","ҽԺ����","erp"),
	HospitalLevel("HospitalLevel","ҽԺ�Ӽ���","erp"),
	HospitalType("HospitalType","ҽԺ����","erp"),
	SchoolType("SchoolType","ѧУ����","erp"),
	ProductType("ProductType","��Ʒ����","erp"),
	DocType("DocType","�����ĵ�.�ĵ�����","erp"),
	Label("Label","�����ĵ�.��ǩ","erp"),
	PreSalesSupport("PreSalesSupport","��ǰ֧��","erp"),
	SalesImplement("SalesImplement","����ʵʩ","erp"),
	Service("Service","�ۺ����","erp"),
	
	TrainingType("TrainingType","��ѵ���","res"),
	TrainingYears("TrainingYears","��������","res"),
	CampaignType("CampaignType","���ʽ","res"),
	GraduateSchool("GraduateSchool","��ҵѧУ","sch,res"),
	GraduateMajor("GraduateMajor","��ҵרҵ","res"),
	DoctorTrainingSpe("DoctorTrainingSpe","��ѵרҵ","sch,res"),
	DoctorSessionNumber("DoctorSessionNumber","����","sch,res"),
	ExamSite("ExamSite","����","res"),
	InfoColumn("InfoColumn","֪ͨ��Ŀ","res"),
	TeachType("TeachType","��ѧ��ʽ","res"),
	StandardDept("StandardDept","��׼����","res",3),
	ResGroup("ResGroup","���","res"),
	TestType("TestType","��������","res"),
//	OrgLevel("OrgLevel","�����ȼ�","res"),
	
	DoctorType("DoctorType","�Ϻ���ͯ-��Ա����","res"),
	
	//����ʡסԺҽʦ - ��ѵרҵ����
	WMFirst("WMFirst","����.2014����ǰ��ҽһ�׶���ѵרҵ","res"),
	WMSecond("WMSecond","����.2014����ǰ��ҽ���׶���ѵרҵ","res"),
	AssiGeneral("AssiGeneral","����.2014����ǰ����ȫ����ѵרҵ","res"),
	
	WM("WM","����.2014��֮����ҽ��ѵרҵ","res"),
	TCM("TCM","����.2014��֮����ҽ��ѵרҵ","res"),
	
	DoctorStatus("DoctorStatus","����.ҽʦ״̬","res"),
	DoctorStrike("DoctorStrike","����.ҽʦ����","res"),
	
	FstuType("FstuType","�̽���Ŀ����","fstu"),
	
	//sczy
	ZySpe("ZySpe","�Ĵ���ҽ.��ҽרҵ","res"),
	ZyqkSpe("ZyqkSpe","�Ĵ���ҽȫ��רҵ","res"),
	
	//sr
	StudentSource("StudentSource","ѧ��.������Դ","res"),
	AdmitType("AdmitType","ѧ��.¼ȡ���","res"),
	TrainType("TrainType","ѧ��.�������","res"),
	StudyForm("StudyForm","ѧ��.ѧϰ��ʽ","res"),
	AtSchoolStatus("AtSchoolStatus","ѧ��.��У״̬","res"),
	SchoolRollStatus("SchoolRollStatus","ѧ��.ѧ��״̬","res"),
	RecruitSeason("RecruitSeason","ѧ��.��������","res"),
	TrainCategory("TrainCategory","ѧ��.��������","res"),
	FirstEducation("FirstEducation","ѧ��.��һѧ��","res"),
	Major("Major","ѧ��.רҵ","res",2),
	DegreeCategory("DegreeCategory","ѧ��.ѧλ���","res"),
    XjClass("XjClass","ѧ��.�༶","res"),
    XjCourseType("XjCourseType","ѧ��.�γ�����","res"),
	;
	
	public static Map<String,String> sysDictIdMap ;
	public static Map<String,List<SysDict>> sysListDictMap ;
	
	//��ǩʹ��
	public static String getDictName(DictTypeEnum dictTypeEnum, String id){
		return sysDictIdMap.get(dictTypeEnum.getId()+"."+id);
	}
	
	public String getDictNameById(String id){
		return sysDictIdMap.get(getId()+"."+id);
	}
	
	public List<SysDict> getSysDictList(){
		return sysListDictMap.get(getId());
	}

	private final String id;
	private final String name;
	private final String wsid;
	private Integer level = 1;
	
	DictTypeEnum(String id,String name,String wsid) {
		this.id = id;
		this.name = name;
		this.wsid = wsid;
	}
	
	DictTypeEnum(String id,String name,String wsid,int level) {
		this.id = id;
		this.name = name;
		this.wsid = wsid;
		this.level = level;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}
	
	public String getWsid(){
		return wsid;		
	}

	public static String getNameById(String id) {
		if(EnumUtil.getById(id, DictTypeEnum.class) != null){
			return EnumUtil.getById(id, DictTypeEnum.class).getName();
		}else {
			return "";
		}
	}

	public int getLevel() {
		return level;
	}
}
