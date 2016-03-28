package com.pinde.sci.model.res;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.SysDict;

public class HospitalDoctorExportInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String userName;
	
	private String sexName;
	
	private String idNo;
	
	private String userPhone;
	
	private String userEmail;
	
	private String graduatedName;
	
	private String specialized;
	
	private String graduationTime;
	
	private String educationName;
	
	private String examResult;
	
	private String speName;
	
	public String getEducationName() {
		return educationName;
	}

	public void setEducationName(String educationName) {
		this.educationName = educationName;
	}

	private String swap;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSexName() {
		return sexName;
	}

	public void setSexName(String sexName) {
		this.sexName = sexName;
	}

	public String getIdNo() {
		return idNo;
	}

	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getSpecialized() {
		return specialized;
	}

	public void setSpecialized(String specialized) {
		List<SysDict> dicts = DictTypeEnum.sysListDictMap.get(DictTypeEnum.GraduateMajor.getId());
		for(SysDict dict:dicts){
			if(dict.getDictId().equals(specialized)){
				this.specialized = dict.getDictName();		
			}
		}
		
	}

	public String getGraduatedName() {
		return graduatedName;
	}

	public void setGraduatedName(String graduatedName) {
		this.graduatedName = graduatedName;
	}

	public String getGraduationTime() {
		return graduationTime;
	}

	public void setGraduationTime(String graduationTime) {
		this.graduationTime = graduationTime;
	}

	public String getExamResult() {
		return examResult;
	}

	public void setExamResult(String examResult) {
		this.examResult = examResult;
	}

	public String getSpeName() {
		return speName;
	}

	public void setSpeName(String speName) {
		this.speName = speName;
	}

	public String getSwap() {
		return swap;
	}

	public void setSwap(String swap) {
		if(GlobalConstant.FLAG_Y.equals(swap)){
			this.swap = "ÊÇ";	
		}else{
			this.swap = "·ñ";
		}
	}
	
	
	
}
