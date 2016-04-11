package com.pinde.sci.model.mo;

import com.pinde.core.model.MybatisObject;

public class SchDoctorDept extends MybatisObject {

	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.RECORD_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String recordFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.DOCTOR_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String doctorFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.DOCTOR_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String doctorName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.ROTATION_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String rotationFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.ROTATION_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String rotationName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.SESSION_NUMBER
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String sessionNumber;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.GROUP_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String groupFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.SCH_MONTH
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String schMonth;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String schDeptFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String schDeptName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.DEPT_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String deptFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.DEPT_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String deptName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.ORDINAL
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private Integer ordinal;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.RECORD_STATUS
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String recordStatus;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.CREATE_TIME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String createTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.CREATE_USER_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String createUserFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.MODIFY_TIME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String modifyTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.MODIFY_USER_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String modifyUserFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.ORG_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String orgFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.ORG_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String orgName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_ID
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String standardDeptId;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String standardDeptName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.SCH_DOCTOR_DEPT.IS_REQUIRED
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	private String isRequired;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.RECORD_FLOW
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.RECORD_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getRecordFlow() {
		return recordFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.RECORD_FLOW
	 * @param recordFlow  the value for PDSCI.SCH_DOCTOR_DEPT.RECORD_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setRecordFlow(String recordFlow) {
		this.recordFlow = recordFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.DOCTOR_FLOW
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.DOCTOR_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getDoctorFlow() {
		return doctorFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.DOCTOR_FLOW
	 * @param doctorFlow  the value for PDSCI.SCH_DOCTOR_DEPT.DOCTOR_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setDoctorFlow(String doctorFlow) {
		this.doctorFlow = doctorFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.DOCTOR_NAME
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.DOCTOR_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getDoctorName() {
		return doctorName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.DOCTOR_NAME
	 * @param doctorName  the value for PDSCI.SCH_DOCTOR_DEPT.DOCTOR_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.ROTATION_FLOW
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.ROTATION_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getRotationFlow() {
		return rotationFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.ROTATION_FLOW
	 * @param rotationFlow  the value for PDSCI.SCH_DOCTOR_DEPT.ROTATION_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setRotationFlow(String rotationFlow) {
		this.rotationFlow = rotationFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.ROTATION_NAME
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.ROTATION_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getRotationName() {
		return rotationName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.ROTATION_NAME
	 * @param rotationName  the value for PDSCI.SCH_DOCTOR_DEPT.ROTATION_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setRotationName(String rotationName) {
		this.rotationName = rotationName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.SESSION_NUMBER
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.SESSION_NUMBER
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getSessionNumber() {
		return sessionNumber;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.SESSION_NUMBER
	 * @param sessionNumber  the value for PDSCI.SCH_DOCTOR_DEPT.SESSION_NUMBER
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setSessionNumber(String sessionNumber) {
		this.sessionNumber = sessionNumber;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.GROUP_FLOW
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.GROUP_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getGroupFlow() {
		return groupFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.GROUP_FLOW
	 * @param groupFlow  the value for PDSCI.SCH_DOCTOR_DEPT.GROUP_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setGroupFlow(String groupFlow) {
		this.groupFlow = groupFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.SCH_MONTH
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.SCH_MONTH
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getSchMonth() {
		return schMonth;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.SCH_MONTH
	 * @param schMonth  the value for PDSCI.SCH_DOCTOR_DEPT.SCH_MONTH
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setSchMonth(String schMonth) {
		this.schMonth = schMonth;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_FLOW
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getSchDeptFlow() {
		return schDeptFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_FLOW
	 * @param schDeptFlow  the value for PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setSchDeptFlow(String schDeptFlow) {
		this.schDeptFlow = schDeptFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_NAME
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getSchDeptName() {
		return schDeptName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_NAME
	 * @param schDeptName  the value for PDSCI.SCH_DOCTOR_DEPT.SCH_DEPT_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setSchDeptName(String schDeptName) {
		this.schDeptName = schDeptName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.DEPT_FLOW
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.DEPT_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getDeptFlow() {
		return deptFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.DEPT_FLOW
	 * @param deptFlow  the value for PDSCI.SCH_DOCTOR_DEPT.DEPT_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setDeptFlow(String deptFlow) {
		this.deptFlow = deptFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.DEPT_NAME
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.DEPT_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getDeptName() {
		return deptName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.DEPT_NAME
	 * @param deptName  the value for PDSCI.SCH_DOCTOR_DEPT.DEPT_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.ORDINAL
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.ORDINAL
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public Integer getOrdinal() {
		return ordinal;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.ORDINAL
	 * @param ordinal  the value for PDSCI.SCH_DOCTOR_DEPT.ORDINAL
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setOrdinal(Integer ordinal) {
		this.ordinal = ordinal;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.RECORD_STATUS
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.RECORD_STATUS
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getRecordStatus() {
		return recordStatus;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.RECORD_STATUS
	 * @param recordStatus  the value for PDSCI.SCH_DOCTOR_DEPT.RECORD_STATUS
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setRecordStatus(String recordStatus) {
		this.recordStatus = recordStatus;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.CREATE_TIME
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.CREATE_TIME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.CREATE_TIME
	 * @param createTime  the value for PDSCI.SCH_DOCTOR_DEPT.CREATE_TIME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.CREATE_USER_FLOW
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.CREATE_USER_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getCreateUserFlow() {
		return createUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.CREATE_USER_FLOW
	 * @param createUserFlow  the value for PDSCI.SCH_DOCTOR_DEPT.CREATE_USER_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setCreateUserFlow(String createUserFlow) {
		this.createUserFlow = createUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.MODIFY_TIME
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.MODIFY_TIME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getModifyTime() {
		return modifyTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.MODIFY_TIME
	 * @param modifyTime  the value for PDSCI.SCH_DOCTOR_DEPT.MODIFY_TIME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.MODIFY_USER_FLOW
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.MODIFY_USER_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getModifyUserFlow() {
		return modifyUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.MODIFY_USER_FLOW
	 * @param modifyUserFlow  the value for PDSCI.SCH_DOCTOR_DEPT.MODIFY_USER_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setModifyUserFlow(String modifyUserFlow) {
		this.modifyUserFlow = modifyUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.ORG_FLOW
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.ORG_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getOrgFlow() {
		return orgFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.ORG_FLOW
	 * @param orgFlow  the value for PDSCI.SCH_DOCTOR_DEPT.ORG_FLOW
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setOrgFlow(String orgFlow) {
		this.orgFlow = orgFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.ORG_NAME
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.ORG_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getOrgName() {
		return orgName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.ORG_NAME
	 * @param orgName  the value for PDSCI.SCH_DOCTOR_DEPT.ORG_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_ID
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_ID
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getStandardDeptId() {
		return standardDeptId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_ID
	 * @param standardDeptId  the value for PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_ID
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setStandardDeptId(String standardDeptId) {
		this.standardDeptId = standardDeptId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_NAME
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getStandardDeptName() {
		return standardDeptName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_NAME
	 * @param standardDeptName  the value for PDSCI.SCH_DOCTOR_DEPT.STANDARD_DEPT_NAME
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setStandardDeptName(String standardDeptName) {
		this.standardDeptName = standardDeptName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.SCH_DOCTOR_DEPT.IS_REQUIRED
	 * @return  the value of PDSCI.SCH_DOCTOR_DEPT.IS_REQUIRED
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public String getIsRequired() {
		return isRequired;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.SCH_DOCTOR_DEPT.IS_REQUIRED
	 * @param isRequired  the value for PDSCI.SCH_DOCTOR_DEPT.IS_REQUIRED
	 * @mbggenerated  Tue Aug 04 14:36:39 CST 2015
	 */
	public void setIsRequired(String isRequired) {
		this.isRequired = isRequired;
	}
}