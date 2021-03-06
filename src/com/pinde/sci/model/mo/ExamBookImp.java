package com.pinde.sci.model.mo;

import com.pinde.core.model.MybatisObject;

public class ExamBookImp extends MybatisObject {

	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.BOOK_IMP_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String bookImpFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.BOOK_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String bookFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.BOOK_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String bookName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.STATUS_ID
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String statusId;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.STATUS_DESC
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String statusDesc;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.IMP_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String impUserFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.IMP_USER_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String impUserName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.IMP_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String impTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.CHECK_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String checkUserFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.CHECK_USER_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String checkUserName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.CHECK_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String checkTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.AUDIT_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String auditUserFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.AUDIT_USER_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String auditUserName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.AUDIT_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String auditTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.MEMO
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String memo;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.RECORD_STATUS
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String recordStatus;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.CREATE_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String createTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.CREATE_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String createUserFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.MODIFY_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String modifyTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.MODIFY_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String modifyUserFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.SUBJECT_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String subjectFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.EXAM_BOOK_IMP.SUBJECT_MEMO
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	private String subjectMemo;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.BOOK_IMP_FLOW
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.BOOK_IMP_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getBookImpFlow() {
		return bookImpFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.BOOK_IMP_FLOW
	 * @param bookImpFlow  the value for PDSCI.EXAM_BOOK_IMP.BOOK_IMP_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setBookImpFlow(String bookImpFlow) {
		this.bookImpFlow = bookImpFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.BOOK_FLOW
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.BOOK_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getBookFlow() {
		return bookFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.BOOK_FLOW
	 * @param bookFlow  the value for PDSCI.EXAM_BOOK_IMP.BOOK_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setBookFlow(String bookFlow) {
		this.bookFlow = bookFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.BOOK_NAME
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.BOOK_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getBookName() {
		return bookName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.BOOK_NAME
	 * @param bookName  the value for PDSCI.EXAM_BOOK_IMP.BOOK_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.STATUS_ID
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.STATUS_ID
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getStatusId() {
		return statusId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.STATUS_ID
	 * @param statusId  the value for PDSCI.EXAM_BOOK_IMP.STATUS_ID
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setStatusId(String statusId) {
		this.statusId = statusId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.STATUS_DESC
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.STATUS_DESC
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getStatusDesc() {
		return statusDesc;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.STATUS_DESC
	 * @param statusDesc  the value for PDSCI.EXAM_BOOK_IMP.STATUS_DESC
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.IMP_USER_FLOW
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.IMP_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getImpUserFlow() {
		return impUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.IMP_USER_FLOW
	 * @param impUserFlow  the value for PDSCI.EXAM_BOOK_IMP.IMP_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setImpUserFlow(String impUserFlow) {
		this.impUserFlow = impUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.IMP_USER_NAME
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.IMP_USER_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getImpUserName() {
		return impUserName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.IMP_USER_NAME
	 * @param impUserName  the value for PDSCI.EXAM_BOOK_IMP.IMP_USER_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setImpUserName(String impUserName) {
		this.impUserName = impUserName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.IMP_TIME
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.IMP_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getImpTime() {
		return impTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.IMP_TIME
	 * @param impTime  the value for PDSCI.EXAM_BOOK_IMP.IMP_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setImpTime(String impTime) {
		this.impTime = impTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.CHECK_USER_FLOW
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.CHECK_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getCheckUserFlow() {
		return checkUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.CHECK_USER_FLOW
	 * @param checkUserFlow  the value for PDSCI.EXAM_BOOK_IMP.CHECK_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setCheckUserFlow(String checkUserFlow) {
		this.checkUserFlow = checkUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.CHECK_USER_NAME
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.CHECK_USER_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getCheckUserName() {
		return checkUserName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.CHECK_USER_NAME
	 * @param checkUserName  the value for PDSCI.EXAM_BOOK_IMP.CHECK_USER_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setCheckUserName(String checkUserName) {
		this.checkUserName = checkUserName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.CHECK_TIME
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.CHECK_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getCheckTime() {
		return checkTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.CHECK_TIME
	 * @param checkTime  the value for PDSCI.EXAM_BOOK_IMP.CHECK_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.AUDIT_USER_FLOW
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.AUDIT_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getAuditUserFlow() {
		return auditUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.AUDIT_USER_FLOW
	 * @param auditUserFlow  the value for PDSCI.EXAM_BOOK_IMP.AUDIT_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setAuditUserFlow(String auditUserFlow) {
		this.auditUserFlow = auditUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.AUDIT_USER_NAME
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.AUDIT_USER_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getAuditUserName() {
		return auditUserName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.AUDIT_USER_NAME
	 * @param auditUserName  the value for PDSCI.EXAM_BOOK_IMP.AUDIT_USER_NAME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setAuditUserName(String auditUserName) {
		this.auditUserName = auditUserName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.AUDIT_TIME
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.AUDIT_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getAuditTime() {
		return auditTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.AUDIT_TIME
	 * @param auditTime  the value for PDSCI.EXAM_BOOK_IMP.AUDIT_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setAuditTime(String auditTime) {
		this.auditTime = auditTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.MEMO
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.MEMO
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getMemo() {
		return memo;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.MEMO
	 * @param memo  the value for PDSCI.EXAM_BOOK_IMP.MEMO
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setMemo(String memo) {
		this.memo = memo;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.RECORD_STATUS
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.RECORD_STATUS
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getRecordStatus() {
		return recordStatus;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.RECORD_STATUS
	 * @param recordStatus  the value for PDSCI.EXAM_BOOK_IMP.RECORD_STATUS
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setRecordStatus(String recordStatus) {
		this.recordStatus = recordStatus;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.CREATE_TIME
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.CREATE_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.CREATE_TIME
	 * @param createTime  the value for PDSCI.EXAM_BOOK_IMP.CREATE_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.CREATE_USER_FLOW
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.CREATE_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getCreateUserFlow() {
		return createUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.CREATE_USER_FLOW
	 * @param createUserFlow  the value for PDSCI.EXAM_BOOK_IMP.CREATE_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setCreateUserFlow(String createUserFlow) {
		this.createUserFlow = createUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.MODIFY_TIME
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.MODIFY_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getModifyTime() {
		return modifyTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.MODIFY_TIME
	 * @param modifyTime  the value for PDSCI.EXAM_BOOK_IMP.MODIFY_TIME
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.MODIFY_USER_FLOW
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.MODIFY_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getModifyUserFlow() {
		return modifyUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.MODIFY_USER_FLOW
	 * @param modifyUserFlow  the value for PDSCI.EXAM_BOOK_IMP.MODIFY_USER_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setModifyUserFlow(String modifyUserFlow) {
		this.modifyUserFlow = modifyUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.SUBJECT_FLOW
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.SUBJECT_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getSubjectFlow() {
		return subjectFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.SUBJECT_FLOW
	 * @param subjectFlow  the value for PDSCI.EXAM_BOOK_IMP.SUBJECT_FLOW
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setSubjectFlow(String subjectFlow) {
		this.subjectFlow = subjectFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.EXAM_BOOK_IMP.SUBJECT_MEMO
	 * @return  the value of PDSCI.EXAM_BOOK_IMP.SUBJECT_MEMO
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public String getSubjectMemo() {
		return subjectMemo;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.EXAM_BOOK_IMP.SUBJECT_MEMO
	 * @param subjectMemo  the value for PDSCI.EXAM_BOOK_IMP.SUBJECT_MEMO
	 * @mbggenerated  Thu Dec 18 15:18:44 CST 2014
	 */
	public void setSubjectMemo(String subjectMemo) {
		this.subjectMemo = subjectMemo;
	}
}