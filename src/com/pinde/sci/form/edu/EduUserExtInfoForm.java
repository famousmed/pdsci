package com.pinde.sci.form.edu;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class EduUserExtInfoForm{
	 //个人信息
		//基本信息
		private String height;//身高
		private String bloodType;//血型
		private String foreignLanguageLevel;//外语水平
		private String computerLevel;//计算机水平
		private String mandarinLevel;//普通话水平
		private String speciality;//特长
		private String firstEducationContentId;
		private String firstEducationContentName;//第一学历
		//学历学位信息
		private String undergraduateOrgName;//本科毕业单位名称
		private String underDiplomaCode; //本科毕业证书编号
		private String underAwardDegreeOrg;//获取学士学位单位
		private String underMajor;//获学士学位专业名称
		private String underDegreeCertCode;//学士学位证书编号
		private String underStudyForm;//取得本科学历的学习形式
		private String underGraduateTime;//本科毕业年月	
//		private String underawardDegreeTime;//获得学士学位年月
		private String underAwardDegreeYear;//获得学士学位年月
		public String getUnderAwardDegreeYear() {
			return underAwardDegreeYear;
		}
		public void setUnderAwardDegreeYear(String underAwardDegreeYear) {
			this.underAwardDegreeYear = underAwardDegreeYear;
		}
		private String underGraduateMajor;//本科毕业专业名称
		private String masterUnitName;//硕士毕业单位名称
		private String masterDiplomaCode;//硕士毕业证书编号
		private String masterAwardDegreeOrg;//获取硕士学位单位
		private String masterDegreeCertCode;//硕士学位证书编号
		private String masterStudyForm;//取得硕士学位方式
		private String masterGraduateTime;//硕士毕业年月
		private String masterAwardDegreeTime;//获得硕士学位年月
		private String masterGraduateMajor;//硕士毕业专业名称
		private String code;//最后学位证书编号
		private String reAndPuStatusContent;//入学前奖惩情况
		//户口信息
		private String address;//户口详细地址
		private String oldDomicile;//原户籍地
		//居住信息
		private String nowResideAddress;//现在家庭住址
		private String linkMan;//联系人
		private String postCode;//邮政编码
		private String telephone;//固定电话
		 //档案信息
		private String oldFileLocationOrg;//原档案所在单位
		private String oldFileLocationOrgCode;//原档案所在单位邮编
		private String oldOrgName;//原工作学习单位
		 //婚姻生育状况  
		private String statusId; //婚姻状况编号
		private String statusName;  //婚姻状况名称
		private String bearStatusName;//婚育状况名称
		//政治情况
		private String joinTime;//加入时间
		private String isRelationInto;//党团关系是否转入
		 //缴费信息
		private String accountNum;//缴费账号
		 //录取信息
		//外国语
		private String foreignLanguageName;//名称
		private String foreignLanguageScore;// 分数
		//政治理论
		private String politicalTheoryName;//名称
		private String politicalTheoryScore;//分数
		//业务课
		private String firstSubjectName;//名称
		private String firstSubjectScore;//分数
		private String secondSubjectName;//名称
		private String secondSubjectScore;//分数
		//加试科
		private String firstAddExamName;//名称
		private String firstAddExamScore;// 分数
		private String secondAddExamName;//名称
		private String secondAddExamScore;// 分数
		//复试
		private String reexamineScore;//分数
		 //总分
		private String totalPointsScore;//分数
		//医师资格证
		private String isDoctorQuaCert ;//是否拥有
		private String codeDoctorQuaCert  ;//编号
		//执业医师执照
		private String isMedicalPractitioner ;//是否拥有
		private String codeMedicalPractitioner ;//编号
		 //住宿
		private String isStay ;//是否住宿
		private String roomNumStay ;//宿舍号
		private String telephoneStay ;//宿舍电话
		 //配偶姓名
		private String mateName;//姓名
		private String mateIdNo ;//身份证
		//定向培养单位
		private String directionalOrgName;//单位名称
		//备注
		private String remark;//备注内容
		
		
		public String getMasterDegreeCertCode() {
			return masterDegreeCertCode;
		}
		public void setMasterDegreeCertCode(String masterDegreeCertCode) {
			this.masterDegreeCertCode = masterDegreeCertCode;
		}
		public String getMasterStudyForm() {
			return masterStudyForm;
		}
		public void setMasterStudyForm(String masterStudyForm) {
			this.masterStudyForm = masterStudyForm;
		}
		public String getMasterGraduateTime() {
			return masterGraduateTime;
		}
		public void setMasterGraduateTime(String masterGraduateTime) {
			this.masterGraduateTime = masterGraduateTime;
		}
		public String getMasterAwardDegreeTime() {
			return masterAwardDegreeTime;
		}
		public void setMasterAwardDegreeTime(String masterAwardDegreeTime) {
			this.masterAwardDegreeTime = masterAwardDegreeTime;
		}
		public String getHeight() {
			return height;
		}
		public void setHeight(String height) {
			this.height = height;
		}
		public String getBloodType() {
			return bloodType;
		}
		public void setBloodType(String bloodType) {
			this.bloodType = bloodType;
		}
		public String getForeignLanguageLevel() {
			return foreignLanguageLevel;
		}
		public void setForeignLanguageLevel(String foreignLanguageLevel) {
			this.foreignLanguageLevel = foreignLanguageLevel;
		}
		public String getComputerLevel() {
			return computerLevel;
		}
		public void setComputerLevel(String computerLevel) {
			this.computerLevel = computerLevel;
		}
		public String getMandarinLevel() {
			return mandarinLevel;
		}
		public void setMandarinLevel(String mandarinLevel) {
			this.mandarinLevel = mandarinLevel;
		}
		public String getSpeciality() {
			return speciality;
		}
		public void setSpeciality(String speciality) {
			this.speciality = speciality;
		}
		public String getUndergraduateOrgName() {
			return undergraduateOrgName;
		}
		public void setUndergraduateOrgName(String undergraduateOrgName) {
			this.undergraduateOrgName = undergraduateOrgName;
		}
		public String getUnderDiplomaCode() {
			return underDiplomaCode;
		}
		public void setUnderDiplomaCode(String underDiplomaCode) {
			this.underDiplomaCode = underDiplomaCode;
		}
		public String getUnderAwardDegreeOrg() {
			return underAwardDegreeOrg;
		}
		public void setUnderAwardDegreeOrg(String underAwardDegreeOrg) {
			this.underAwardDegreeOrg = underAwardDegreeOrg;
		}
		public String getUnderMajor() {
			return underMajor;
		}
		public void setUnderMajor(String underMajor) {
			this.underMajor = underMajor;
		}
		public String getUnderDegreeCertCode() {
			return underDegreeCertCode;
		}
		public void setUnderDegreeCertCode(String underDegreeCertCode) {
			this.underDegreeCertCode = underDegreeCertCode;
		}
		public String getUnderStudyForm() {
			return underStudyForm;
		}
		public void setUnderStudyForm(String underStudyForm) {
			this.underStudyForm = underStudyForm;
		}
		public String getUnderGraduateTime() {
			return underGraduateTime;
		}
		public void setUnderGraduateTime(String underGraduateTime) {
			this.underGraduateTime = underGraduateTime;
		}
		public String getUnderGraduateMajor() {
			return underGraduateMajor;
		}
		public void setUnderGraduateMajor(String underGraduateMajor) {
			this.underGraduateMajor = underGraduateMajor;
		}
		public String getMasterUnitName() {
			return masterUnitName;
		}
		public void setMasterUnitName(String masterUnitName) {
			this.masterUnitName = masterUnitName;
		}
		public String getMasterDiplomaCode() {
			return masterDiplomaCode;
		}
		public void setMasterDiplomaCode(String masterDiplomaCode) {
			this.masterDiplomaCode = masterDiplomaCode;
		}
		public String getMasterAwardDegreeOrg() {
			return masterAwardDegreeOrg;
		}
		public void setMasterAwardDegreeOrg(String masterAwardDegreeOrg) {
			this.masterAwardDegreeOrg = masterAwardDegreeOrg;
		}
		public String getMasterGraduateMajor() {
			return masterGraduateMajor;
		}
		public void setMasterGraduateMajor(String masterGraduateMajor) {
			this.masterGraduateMajor = masterGraduateMajor;
		}
		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
		}
		public String getReAndPuStatusContent() {
			return reAndPuStatusContent;
		}
		public void setReAndPuStatusContent(String reAndPuStatusContent) {
			this.reAndPuStatusContent = reAndPuStatusContent;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public String getOldDomicile() {
			return oldDomicile;
		}
		public void setOldDomicile(String oldDomicile) {
			this.oldDomicile = oldDomicile;
		}
		public String getNowResideAddress() {
			return nowResideAddress;
		}
		public void setNowResideAddress(String nowResideAddress) {
			this.nowResideAddress = nowResideAddress;
		}
		public String getLinkMan() {
			return linkMan;
		}
		public void setLinkMan(String linkMan) {
			this.linkMan = linkMan;
		}
		public String getPostCode() {
			return postCode;
		}
		public void setPostCode(String postCode) {
			this.postCode = postCode;
		}
		public String getTelephone() {
			return telephone;
		}
		public void setTelephone(String telephone) {
			this.telephone = telephone;
		}
		public String getOldFileLocationOrg() {
			return oldFileLocationOrg;
		}
		public void setOldFileLocationOrg(String oldFileLocationOrg) {
			this.oldFileLocationOrg = oldFileLocationOrg;
		}
		public String getOldFileLocationOrgCode() {
			return oldFileLocationOrgCode;
		}
		public void setOldFileLocationOrgCode(String oldFileLocationOrgCode) {
			this.oldFileLocationOrgCode = oldFileLocationOrgCode;
		}
		public String getOldOrgName() {
			return oldOrgName;
		}
		public void setOldOrgName(String oldOrgName) {
			this.oldOrgName = oldOrgName;
		}
		public String getStatusId() {
			return statusId;
		}
		public void setStatusId(String statusId) {
			this.statusId = statusId;
		}
		public String getStatusName() {
			return statusName;
		}
		public void setStatusName(String statusName) {
			this.statusName = statusName;
		}
		public String getBearStatusName() {
			return bearStatusName;
		}
		public void setBearStatusName(String bearStatusName) {
			this.bearStatusName = bearStatusName;
		}
		public String getJoinTime() {
			return joinTime;
		}
		public void setJoinTime(String joinTime) {
			this.joinTime = joinTime;
		}
		public String getIsRelationInto() {
			return isRelationInto;
		}
		public void setIsRelationInto(String isRelationInto) {
			this.isRelationInto = isRelationInto;
		}
		public String getAccountNum() {
			return accountNum;
		}
		public void setAccountNum(String accountNum) {
			this.accountNum = accountNum;
		}
		
		public String getForeignLanguageName() {
			return foreignLanguageName;
		}
		public void setForeignLanguageName(String foreignLanguageName) {
			this.foreignLanguageName = foreignLanguageName;
		}
		public String getForeignLanguageScore() {
			return foreignLanguageScore;
		}
		public void setForeignLanguageScore(String foreignLanguageScore) {
			this.foreignLanguageScore = foreignLanguageScore;
		}
		public String getPoliticalTheoryName() {
			return politicalTheoryName;
		}
		public void setPoliticalTheoryName(String politicalTheoryName) {
			this.politicalTheoryName = politicalTheoryName;
		}
		public String getPoliticalTheoryScore() {
			return politicalTheoryScore;
		}
		public void setPoliticalTheoryScore(String politicalTheoryScore) {
			this.politicalTheoryScore = politicalTheoryScore;
		}
		public String getMateName() {
			return mateName;
		}
		public void setMateName(String mateName) {
			this.mateName = mateName;
		}
		public String getMateIdNo() {
			return mateIdNo;
		}
		public void setMateIdNo(String mateIdNo) {
			this.mateIdNo = mateIdNo;
		}
		public String getFirstSubjectName() {
			return firstSubjectName;
		}
		public void setFirstSubjectName(String firstSubjectName) {
			this.firstSubjectName = firstSubjectName;
		}
		public String getFirstSubjectScore() {
			return firstSubjectScore;
		}
		public void setFirstSubjectScore(String firstSubjectScore) {
			this.firstSubjectScore = firstSubjectScore;
		}
		public String getSecondSubjectName() {
			return secondSubjectName;
		}
		public void setSecondSubjectName(String secondSubjectName) {
			this.secondSubjectName = secondSubjectName;
		}
		public String getSecondSubjectScore() {
			return secondSubjectScore;
		}
		public void setSecondSubjectScore(String secondSubjectScore) {
			this.secondSubjectScore = secondSubjectScore;
		}
		public String getFirstAddExamName() {
			return firstAddExamName;
		}
		public void setFirstAddExamName(String firstAddExamName) {
			this.firstAddExamName = firstAddExamName;
		}
		public String getFirstAddExamScore() {
			return firstAddExamScore;
		}
		public void setFirstAddExamScore(String firstAddExamScore) {
			this.firstAddExamScore = firstAddExamScore;
		}
		public String getSecondAddExamName() {
			return secondAddExamName;
		}
		public void setSecondAddExamName(String secondAddExamName) {
			this.secondAddExamName = secondAddExamName;
		}
		public String getSecondAddExamScore() {
			return secondAddExamScore;
		}
		public void setSecondAddExamScore(String secondAddExamScore) {
			this.secondAddExamScore = secondAddExamScore;
		}
		
		public String getReexamineScore() {
			return reexamineScore;
		}
		public void setReexamineScore(String reexamineScore) {
			this.reexamineScore = reexamineScore;
		}
		public String getTotalPointsScore() {
			return totalPointsScore;
		}
		public void setTotalPointsScore(String totalPointsScore) {
			this.totalPointsScore = totalPointsScore;
		}

		
		public String getIsDoctorQuaCert() {
			return isDoctorQuaCert;
		}
		public void setIsDoctorQuaCert(String isDoctorQuaCert) {
			this.isDoctorQuaCert = isDoctorQuaCert;
		}
		public String getCodeDoctorQuaCert() {
			return codeDoctorQuaCert;
		}
		public void setCodeDoctorQuaCert(String codeDoctorQuaCert) {
			this.codeDoctorQuaCert = codeDoctorQuaCert;
		}
		public String getIsMedicalPractitioner() {
			return isMedicalPractitioner;
		}
		public void setIsMedicalPractitioner(String isMedicalPractitioner) {
			this.isMedicalPractitioner = isMedicalPractitioner;
		}
		public String getCodeMedicalPractitioner() {
			return codeMedicalPractitioner;
		}
		public void setCodeMedicalPractitioner(String codeMedicalPractitioner) {
			this.codeMedicalPractitioner = codeMedicalPractitioner;
		}
		public String getIsStay() {
			return isStay;
		}
		public void setIsStay(String isStay) {
			this.isStay = isStay;
		}
		public String getRoomNumStay() {
			return roomNumStay;
		}
		public void setRoomNumStay(String roomNumStay) {
			this.roomNumStay = roomNumStay;
		}
		public String getTelephoneStay() {
			return telephoneStay;
		}
		public void setTelephoneStay(String telephoneStay) {
			this.telephoneStay = telephoneStay;
		}
		public String getDirectionalOrgName() {
			return directionalOrgName;
		}
		public void setDirectionalOrgName(String directionalOrgName) {
			this.directionalOrgName = directionalOrgName;
		}
		public String getRemark() {
			return remark;
		}
		public void setRemark(String remark) {
			this.remark = remark;
		}
		public String getFirstEducationContentId() {
			return firstEducationContentId;
		}
		public void setFirstEducationContentId(String firstEducationContentId) {
			this.firstEducationContentId = firstEducationContentId;
		}
		public String getFirstEducationContentName() {
			return firstEducationContentName;
		}
		public void setFirstEducationContentName(String firstEducationContentName) {
			this.firstEducationContentName = firstEducationContentName;
		}
//		public String getUnderawardDegreeTime() {
//			return underawardDegreeTime;
//		}
//		public void setUnderawardDegreeTime(String underawardDegreeTime) {
//			this.underawardDegreeTime = underawardDegreeTime;
//		}
		
	}

