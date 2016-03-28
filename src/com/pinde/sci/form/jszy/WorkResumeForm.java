package com.pinde.sci.form.jszy;

import java.io.Serializable;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.SysUser;

public class WorkResumeForm implements Serializable{

	private static final long serialVersionUID = -2181384506782700990L;
	
	/**
	 * 临床工作起止时间
	 */
	private String clinicalRoundDate;
	
	/**
	 * 时间长度
	 */
	private String dateLength;
	
	/**
	 * 医院名称
	 */
	private String hospitalName;
	
	/**
	 * 医院等级
	 */
	private String hospitalLevel;
	
	/**
	 * 部门
	 */
	private String deptName;
	
	/**
	 * 职务
	 */
	private String postName;
	
	/**
	 * 证明人
	 */
	private String witness;
	
	/**
	 * 证明人职务
	 */
	private String witnessPost;
	
	/**
	 * 证明人电话
	 */
	private String witnessPhone;
	
	public String getClinicalRoundDate() {
		return clinicalRoundDate;
	}
	
	public void setClinicalRoundDate(String clinicalRoundDate) {
		this.clinicalRoundDate = clinicalRoundDate;
	}
	
	public String getDateLength() {
		return dateLength;
	}
	
	public void setDateLength(String dateLength) {
		this.dateLength = dateLength;
	}
	
	public String getHospitalName() {
		return hospitalName;
	}
	
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
	
	public String getHospitalLevel() {
		return hospitalLevel;
	}
	
	public void setHospitalLevel(String hospitalLevel) {
		this.hospitalLevel = hospitalLevel;
	}
	
	public String getDeptName() {
		return deptName;
	}
	
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	public String getPostName() {
		return postName;
	}
	
	public void setPostName(String postName) {
		this.postName = postName;
	}

	public String getWitness() {
		return witness;
	}

	public void setWitness(String witness) {
		this.witness = witness;
	}

	public String getWitnessPost() {
		return witnessPost;
	}

	public void setWitnessPost(String witnessPost) {
		this.witnessPost = witnessPost;
	}

	public String getWitnessPhone() {
		return witnessPhone;
	}

	public void setWitnessPhone(String witnessPhone) {
		this.witnessPhone = witnessPhone;
	}
}
