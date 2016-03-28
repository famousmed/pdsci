package com.pinde.sci.form.edu;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class SubmitApplyForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4467791817892963176L;
	private String sid;//ѧ��
	private String userName;//����
	private String sex;//�Ա�
	private String major;//רҵ
	private String trainOrg;//������λ
	private String teacher;//��ʦ
	private String trainType;//��������
	private String studyDegree;//���
	private String willTrainType;//����������
	private String qualifiedNo;//ִҵҽʦ�ʸ�֤
	private String docQualifiedNo;//ҽʦ�ʸ�֤
	private String applyMakeUpCou;//���벹����Ŀ
	private String delayCourName;//�����γ�����
	private String delayExamTime;//��������ʱ��
	private String makeUpTime;//����ʱ��
	private String delayStudycourName;//���޿γ�����
	private String delayStudyTime;//������ʼʱ��
	private String againStudyTime;//����ʱ��
	private String destination;//Ŀ�ĵ�
	private String startTime;//��ʼʱ��
	private String endTime;//����ʱ��
	private String stopStudyStarTime;//��ѧ��ʼʱ��
	private String stopStudyEndTime;//��ѧ����ʱ��
	private String swichmajorName;//ת���רҵ����
	private String applyReason;//����ԭ��
	private String auditPerson;//�����
	private String auditContent;//������
	private String auditDate;//�������
	private String teacherSugg;//��ʦ���
	private String trainOrgSugg;//������λ���
	private String postgraduSchSugg;//�о���ѧԺ���
	private String swichTeachSugg;//��ת�뵼ʦ�����
	private String switchOrgSugg;//��ת�뵥λ�����
	private String studySuggg;//ѧ�������
	private String trainSugg;//���������
	
	public String getStudySuggg() {
		return studySuggg;
	}
	public void setStudySuggg(String studySuggg) {
		this.studySuggg = studySuggg;
	}
	public String getTrainSugg() {
		return trainSugg;
	}
	public void setTrainSugg(String trainSugg) {
		this.trainSugg = trainSugg;
	}
	public String getSwitchOrgSugg() {
		return switchOrgSugg;
	}
	public void setSwitchOrgSugg(String switchOrgSugg) {
		this.switchOrgSugg = switchOrgSugg;
	}
	public String getSwichTeachSugg() {
		return swichTeachSugg;
	}
	public void setSwichTeachSugg(String swichTeachSugg) {
		this.swichTeachSugg = swichTeachSugg;
	}
	public String getPostgraduSchSugg() {
		return postgraduSchSugg;
	}
	public void setPostgraduSchSugg(String postgraduSchSugg) {
		this.postgraduSchSugg = postgraduSchSugg;
	}
	public String getTrainOrgSugg() {
		return trainOrgSugg;
	}
	public void setTrainOrgSugg(String trainOrgSugg) {
		this.trainOrgSugg = trainOrgSugg;
	}
	public String getTeacherSugg() {
		return teacherSugg;
	}
	public void setTeacherSugg(String teacherSugg) {
		this.teacherSugg = teacherSugg;
	}
	public String getAuditPerson() {
		return auditPerson;
	}
	public void setAuditPerson(String auditPerson) {
		this.auditPerson = auditPerson;
	}
	public String getAuditContent() {
		return auditContent;
	}
	public void setAuditContent(String auditContent) {
		this.auditContent = auditContent;
	}
	public String getAuditDate() {
		return auditDate;
	}
	public void setAuditDate(String auditDate) {
		this.auditDate = auditDate;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	
	public String getTrainOrg() {
		return trainOrg;
	}
	public void setTrainOrg(String trainOrg) {
		this.trainOrg = trainOrg;
	}
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	public String getWillTrainType() {
		return willTrainType;
	}
	public void setWillTrainType(String willTrainType) {
		this.willTrainType = willTrainType;
	}
	public String getQualifiedNo() {
		return qualifiedNo;
	}
	public void setQualifiedNo(String qualifiedNo) {
		this.qualifiedNo = qualifiedNo;
	}
	public String getDocQualifiedNo() {
		return docQualifiedNo;
	}
	public void setDocQualifiedNo(String docQualifiedNo) {
		this.docQualifiedNo = docQualifiedNo;
	}
	public String getApplyMakeUpCou() {
		return applyMakeUpCou;
	}
	public void setApplyMakeUpCou(String applyMakeUpCou) {
		this.applyMakeUpCou = applyMakeUpCou;
	}
	public String getTrainType() {
		return trainType;
	}
	public void setTrainType(String trainType) {
		this.trainType = trainType;
	}
	public String getDelayCourName() {
		return delayCourName;
	}
	public void setDelayCourName(String delayCourName) {
		this.delayCourName = delayCourName;
	}
	public String getDelayExamTime() {
		return delayExamTime;
	}
	public void setDelayExamTime(String delayExamTime) {
		this.delayExamTime = delayExamTime;
	}
	public String getMakeUpTime() {
		return makeUpTime;
	}
	public void setMakeUpTime(String makeUpTime) {
		this.makeUpTime = makeUpTime;
	}
	public String getDelayStudycourName() {
		return delayStudycourName;
	}
	public void setDelayStudycourName(String delayStudycourName) {
		this.delayStudycourName = delayStudycourName;
	}
	public String getDelayStudyTime() {
		return delayStudyTime;
	}
	public void setDelayStudyTime(String delayStudyTime) {
		this.delayStudyTime = delayStudyTime;
	}
	public String getAgainStudyTime() {
		return againStudyTime;
	}
	public void setAgainStudyTime(String againStudyTime) {
		this.againStudyTime = againStudyTime;
	}
	public String getStudyDegree() {
		return studyDegree;
	}
	public void setStudyDegree(String studyDegree) {
		this.studyDegree = studyDegree;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getStopStudyStarTime() {
		return stopStudyStarTime;
	}
	public void setStopStudyStarTime(String stopStudyStarTime) {
		this.stopStudyStarTime = stopStudyStarTime;
	}
	public String getStopStudyEndTime() {
		return stopStudyEndTime;
	}
	public void setStopStudyEndTime(String stopStudyEndTime) {
		this.stopStudyEndTime = stopStudyEndTime;
	}
	public String getSwichmajorName() {
		return swichmajorName;
	}
	public void setSwichmajorName(String swichmajorName) {
		this.swichmajorName = swichmajorName;
	}
	public String getApplyReason() {
		return applyReason;
	}
	public void setApplyReason(String applyReason) {
		this.applyReason = applyReason;
	}
}
