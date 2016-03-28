package com.pinde.sci.form.edu;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class EduUserExtInfoForm{
	 //������Ϣ
		//������Ϣ
		private String height;//���
		private String bloodType;//Ѫ��
		private String foreignLanguageLevel;//����ˮƽ
		private String computerLevel;//�����ˮƽ
		private String mandarinLevel;//��ͨ��ˮƽ
		private String speciality;//�س�
		private String firstEducationContentId;
		private String firstEducationContentName;//��һѧ��
		//ѧ��ѧλ��Ϣ
		private String undergraduateOrgName;//���Ʊ�ҵ��λ����
		private String underDiplomaCode; //���Ʊ�ҵ֤����
		private String underAwardDegreeOrg;//��ȡѧʿѧλ��λ
		private String underMajor;//��ѧʿѧλרҵ����
		private String underDegreeCertCode;//ѧʿѧλ֤����
		private String underStudyForm;//ȡ�ñ���ѧ����ѧϰ��ʽ
		private String underGraduateTime;//���Ʊ�ҵ����	
//		private String underawardDegreeTime;//���ѧʿѧλ����
		private String underAwardDegreeYear;//���ѧʿѧλ����
		public String getUnderAwardDegreeYear() {
			return underAwardDegreeYear;
		}
		public void setUnderAwardDegreeYear(String underAwardDegreeYear) {
			this.underAwardDegreeYear = underAwardDegreeYear;
		}
		private String underGraduateMajor;//���Ʊ�ҵרҵ����
		private String masterUnitName;//˶ʿ��ҵ��λ����
		private String masterDiplomaCode;//˶ʿ��ҵ֤����
		private String masterAwardDegreeOrg;//��ȡ˶ʿѧλ��λ
		private String masterDegreeCertCode;//˶ʿѧλ֤����
		private String masterStudyForm;//ȡ��˶ʿѧλ��ʽ
		private String masterGraduateTime;//˶ʿ��ҵ����
		private String masterAwardDegreeTime;//���˶ʿѧλ����
		private String masterGraduateMajor;//˶ʿ��ҵרҵ����
		private String code;//���ѧλ֤����
		private String reAndPuStatusContent;//��ѧǰ�������
		//������Ϣ
		private String address;//������ϸ��ַ
		private String oldDomicile;//ԭ������
		//��ס��Ϣ
		private String nowResideAddress;//���ڼ�ͥסַ
		private String linkMan;//��ϵ��
		private String postCode;//��������
		private String telephone;//�̶��绰
		 //������Ϣ
		private String oldFileLocationOrg;//ԭ�������ڵ�λ
		private String oldFileLocationOrgCode;//ԭ�������ڵ�λ�ʱ�
		private String oldOrgName;//ԭ����ѧϰ��λ
		 //��������״��  
		private String statusId; //����״�����
		private String statusName;  //����״������
		private String bearStatusName;//����״������
		//�������
		private String joinTime;//����ʱ��
		private String isRelationInto;//���Ź�ϵ�Ƿ�ת��
		 //�ɷ���Ϣ
		private String accountNum;//�ɷ��˺�
		 //¼ȡ��Ϣ
		//�����
		private String foreignLanguageName;//����
		private String foreignLanguageScore;// ����
		//��������
		private String politicalTheoryName;//����
		private String politicalTheoryScore;//����
		//ҵ���
		private String firstSubjectName;//����
		private String firstSubjectScore;//����
		private String secondSubjectName;//����
		private String secondSubjectScore;//����
		//���Կ�
		private String firstAddExamName;//����
		private String firstAddExamScore;// ����
		private String secondAddExamName;//����
		private String secondAddExamScore;// ����
		//����
		private String reexamineScore;//����
		 //�ܷ�
		private String totalPointsScore;//����
		//ҽʦ�ʸ�֤
		private String isDoctorQuaCert ;//�Ƿ�ӵ��
		private String codeDoctorQuaCert  ;//���
		//ִҵҽʦִ��
		private String isMedicalPractitioner ;//�Ƿ�ӵ��
		private String codeMedicalPractitioner ;//���
		 //ס��
		private String isStay ;//�Ƿ�ס��
		private String roomNumStay ;//�����
		private String telephoneStay ;//����绰
		 //��ż����
		private String mateName;//����
		private String mateIdNo ;//���֤
		//����������λ
		private String directionalOrgName;//��λ����
		//��ע
		private String remark;//��ע����
		
		
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

