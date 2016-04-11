package com.pinde.sci.enums.sys;

import java.util.List;
import java.util.Map;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;
import com.pinde.sci.model.mo.SysDict;

public enum DictTypeEnum implements GeneralEnum<String> {
	
	ProjType("ProjType","科研项目类型","srm"),//科研项目
	SubjType("SubjType","重点学科类型","srm"),//重点学科
	TalentType("TalentType","重点人才类型","srm"),//重点人才
	AidProjType("AidProjType" , "项目备案类型" , "srm"),//项目备案类型
	
	AidCountryProjType("AidCountryProjType","项目类型[补填].国家级","srm"),
	AidProvinceProjType("AidProvinceProjType","项目类型[补填].省级","srm"),
	AidCityProjType("AidCityProjType","项目类型[补填].市厅级","srm"),
	
	UserTitle("UserTitle","人员.职称","sys"),
	UserDegree("UserDegree","人员.学位","sys"),
	UserEducation("UserEducation","人员.学历","sys"),
	UserPost("UserPost","人员.职务","sys"),
	
	LaborPay("LaborPay" , "专家.劳务支付方式" , "srm"),
	
//	PersonalInfo("PersonalInfo","人才.个人情况","srm"),
//	PostgraduateTeacher("PostgraduateTeacher","人才.研究生导师","srm"),
//	TalentsDevelop("TalentsDevelop","人才.人才培养","srm"),
//	AcademicHonour("AcademicHonour","人才.学术荣誉","srm"),
	
//	LanSkillful("LanSkillful","医学新技术.外语熟练程度","srm"),
	
//    DiscussType("DiscussType","研究类别","sys"),
//    TrueAndFalse("TrueAndFalse","是与否","sys"),
//    SubjectInfo("SubjectInfo","学科情况","sys"),
	
	
	OrgBelong("OrgBelong","成果.所属单位","srm"),
	ProjSource("ProjSource","成果.项目来源","srm"),
	LanguageType("LanguageType","成果.语言种类","srm"),	
	AuthorType("AuthorType","成果.作者类型","srm"),
	SubjectType("SubjectType","成果.学科门类","srm"),
	ApplyUserType("ApplyUserType","成果.署名顺序","srm"),
	
	ThesisType("ThesisType","论文.论文类型","srm"),
	JournalType("JournalType","论文.期刊类型","srm"),
	PublishType("PublishType","论文.版面类型","srm"),
	PublishScope("PublishScope","论文.发表范围","srm"),
	MeetingType("MeetingType","论文.会议类型","srm"),
	
	AchType("AchType","科技.成果形式","srm"),
	PrizedGrade("PrizedGrade","科技.获奖级别","srm"),
	PrizedLevel("PrizedLevel","科技.获奖等级","srm"),
	
	AchBookType("AchBookType","著作.著作类别","srm"),
	PressLevelType("PressLevelType","著作.出版社级别","srm"),
	PlaceNameType("PlaceNameType","著作.出版地","srm"),
	WriteNameType("WriteNameType","著作.作者.参编类型","srm"),
	
	CopyrightType("CopyrightType","著作权.著作权类型","srm"),
	
	AppraisalResultName("AppraisalResultName","鉴定.鉴定结论","srm"),
	AppraisalTypeName("AppraisalTypeName","鉴定.鉴定形式","srm"),
	FinishTypeName("FinishTypeName","鉴定.完成形式","srm"),
	
	PatentType("PatentType","专利.专利类型","srm"),
	PatentRange("PatentRange","专利.专利范围","srm"),
	PatentStatus("PatentStatus","专利.专利状态","srm"),
	PatentCooperType("PatentCooperType","专利.合作类型","srm"),
	
	AcceptOrg("AcceptOrg" , "研究报告.采纳单位" , "srm"),
	
	YhProjCategory("YhProjCategory","余杭.项目类别","srm"),
	YhTechnologyField("YhTechnologyField","余杭.技术领域","srm"),
	YhTechnologySource("YhTechnologySource","余杭.技术来源","srm"),
	YhProjStatus("YhProjStatus","余杭.项目状态","srm"),
	YhBAProjCategory("YhBAProjCategory","余杭.备案项目来源/类别","srm",2),
	
	JsPlanCategory("JsPlanCategory","江苏.计划类别","srm"),
	JsApplyType("JsApplyType","江苏.申请类型","srm"),
	JsRelyType("JsRelyType","江苏.依托类型","srm"),
	JsOrgCharacter("JsOrgCharacter","江苏.单位性质","srm"),
	JsSubordinateRelation("JsSubordinateRelation","江苏.隶属关系","srm"),
	JsStudyAbroadTime("JsStudyAbroadTime","江苏.留学时间","srm"),
	
	GcpProjType("GcpProjType","项目类别","irb,gcp"),
	TrackFrequency("TrackFrequency","跟踪审查频率","irb"),
	
	RegulationCountry("RegulationCountry","法规文件.国家文件","gcp"),
	RegulationLocal("RegulationLocal","法规文件.地方文件","gcp"),
	RegulationOrg("RegulationOrg","法规文件.机构文件","gcp"),
	RegulationDept("RegulationDept","法规文件.专业组文件","gcp"),
	
	GcpFundUses("GcpFundUses","经费用途","gcp"),
	
	DoseUnit("DoseUnit","剂量单位","gcp"),
	PreparationUnit("PreparationUnit","制剂单位","gcp"),
	Usage("Usage","给药途径","gcp"),
	Solution("Solution","溶液","gcp"),
	MiniPackUnit("MiniPackUnit","最小包装单位","gcp"),

	
	VisitType("VisitType","ECRF.访视类型","edc"),
	StandardUnit("StandardUnit","ECRF.正常值单位","edc"),
	ModuleType("ModuleType","ECRF.模块类型","edc"),
	QueryType("QueryType","ECRF.疑问类型","edc"),
	
	BudgetItem("BudgetItem","经费.预算项","srm"),
	ProjFundType("ProjFundType","经费.经费类型","srm"),
	ProjFundAccountsType("ProjFundAccountsType","经费.经费到账类型","srm"),	

//	SysWorkStation("SysWorkStation","工作站","sys"),
	SysModule("SysModule","系统.模块菜单","sys",3),
	Region("Region","系统.行政区域代码","sys",3),
//	SysMenuSet("SysMenuSet","系统.一级菜单","sys",2),
//	SysMenu("SysMenu","系统.二级菜单","sys",3),
	
	
	
	CourseMajor("CourseMajor","edu.专业","edu"),
	NjmuCourseMajor("NjmuCourseMajor","edu.专业","njmuedu"),
	
	CustomerGrade("CustomerGrade","客户等级","erp"),
	HospitalGrade("HospitalGrade","医院级别","erp"),
	HospitalLevel("HospitalLevel","医院子级别","erp"),
	HospitalType("HospitalType","医院类型","erp"),
	SchoolType("SchoolType","学校级别","erp"),
	ProductType("ProductType","产品类型","erp"),
	DocType("DocType","公共文档.文档类型","erp"),
	Label("Label","公共文档.标签","erp"),
	PreSalesSupport("PreSalesSupport","售前支持","erp"),
	SalesImplement("SalesImplement","售中实施","erp"),
	Service("Service","售后服务","erp"),
	
	TrainingType("TrainingType","培训类别","res"),
	TrainingYears("TrainingYears","培养年限","res"),
	CampaignType("CampaignType","活动形式","res"),
	GraduateSchool("GraduateSchool","毕业学校","sch,res"),
	GraduateMajor("GraduateMajor","毕业专业","res"),
	DoctorTrainingSpe("DoctorTrainingSpe","培训专业","sch,res"),
	DoctorSessionNumber("DoctorSessionNumber","届数","sch,res"),
	ExamSite("ExamSite","考点","res"),
	InfoColumn("InfoColumn","通知栏目","res"),
	TeachType("TeachType","教学形式","res"),
	StandardDept("StandardDept","标准科室","res",3),
	ResGroup("ResGroup","组别","res"),
	TestType("TestType","考试类型","res"),
//	OrgLevel("OrgLevel","机构等级","res"),
	
	DoctorType("DoctorType","上海儿童-人员类型","res"),
	
	//江苏省住院医师 - 培训专业分类
	WMFirst("WMFirst","江苏.2014年以前西医一阶段培训专业","res"),
	WMSecond("WMSecond","江苏.2014年以前西医二阶段培训专业","res"),
	AssiGeneral("AssiGeneral","江苏.2014年以前助理全科培训专业","res"),
	
	WM("WM","江苏.2014年之后西医培训专业","res"),
	TCM("TCM","江苏.2014年之后中医培训专业","res"),
	
	DoctorStatus("DoctorStatus","江苏.医师状态","res"),
	DoctorStrike("DoctorStrike","江苏.医师走向","res"),
	
	FstuType("FstuType","继教项目分类","fstu"),
	
	//sczy
	ZySpe("ZySpe","四川中医.中医专业","res"),
	ZyqkSpe("ZyqkSpe","四川中医全科专业","res"),
	
	//sr
	StudentSource("StudentSource","学籍.考生来源","res"),
	AdmitType("AdmitType","学籍.录取类别","res"),
	TrainType("TrainType","学籍.培养层次","res"),
	StudyForm("StudyForm","学籍.学习形式","res"),
	AtSchoolStatus("AtSchoolStatus","学籍.在校状态","res"),
	SchoolRollStatus("SchoolRollStatus","学籍.学籍状态","res"),
	RecruitSeason("RecruitSeason","学籍.招生季节","res"),
	TrainCategory("TrainCategory","学籍.培养类型","res"),
	FirstEducation("FirstEducation","学籍.第一学历","res"),
	Major("Major","学籍.专业","res",2),
	DegreeCategory("DegreeCategory","学籍.学位类别","res"),
    XjClass("XjClass","学籍.班级","res"),
    XjCourseType("XjCourseType","学籍.课程类型","res"),
	;
	
	public static Map<String,String> sysDictIdMap ;
	public static Map<String,List<SysDict>> sysListDictMap ;
	
	//标签使用
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
