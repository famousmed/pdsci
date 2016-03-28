package com.pinde.sci.form.jszy;

import java.io.Serializable;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.SysUser;

public class WorkResumeForm implements Serializable{

	private static final long serialVersionUID = -2181384506782700990L;
	
	/**
	 * �ٴ�������ֹʱ��
	 */
	private String clinicalRoundDate;
	
	/**
	 * ʱ�䳤��
	 */
	private String dateLength;
	
	/**
	 * ҽԺ����
	 */
	private String hospitalName;
	
	/**
	 * ҽԺ�ȼ�
	 */
	private String hospitalLevel;
	
	/**
	 * ����
	 */
	private String deptName;
	
	/**
	 * ְ��
	 */
	private String postName;
	
	/**
	 * ֤����
	 */
	private String witness;
	
	/**
	 * ֤����ְ��
	 */
	private String witnessPost;
	
	/**
	 * ֤���˵绰
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
