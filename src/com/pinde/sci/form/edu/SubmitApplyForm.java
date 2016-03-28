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
	private String sid;//学号
	private String userName;//姓名
	private String sex;//性别
	private String major;//专业
	private String trainOrg;//培养单位
	private String teacher;//导师
	private String trainType;//培养类型
	private String studyDegree;//层次
	private String willTrainType;//拟培养类型
	private String qualifiedNo;//执业医师资格证
	private String docQualifiedNo;//医师资格证
	private String applyMakeUpCou;//申请补考科目
	private String delayCourName;//缓考课程名称
	private String delayExamTime;//缓考考试时间
	private String makeUpTime;//补考时间
	private String delayStudycourName;//缓修课程名称
	private String delayStudyTime;//缓修起始时间
	private String againStudyTime;//复修时间
	private String destination;//目的地
	private String startTime;//开始时间
	private String endTime;//结束时间
	private String stopStudyStarTime;//休学开始时间
	private String stopStudyEndTime;//休学结束时间
	private String swichmajorName;//转入的专业名称
	private String applyReason;//申请原因
	private String auditPerson;//审核人
	private String auditContent;//审核意见
	private String auditDate;//审核日期
	private String teacherSugg;//导师意见
	private String trainOrgSugg;//培养单位意见
	private String postgraduSchSugg;//研究生学院意见
	private String swichTeachSugg;//拟转入导师的意见
	private String switchOrgSugg;//拟转入单位的意见
	private String studySuggg;//学工部意见
	private String trainSugg;//培养科意见
	
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
