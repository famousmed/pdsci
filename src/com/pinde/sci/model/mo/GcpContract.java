package com.pinde.sci.model.mo;

import com.pinde.core.model.MybatisObject;
import java.math.BigDecimal;

public class GcpContract extends MybatisObject {
    /**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CONTRACT_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String contractFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CONTRACT_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String contractName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.PROJ_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String projFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.PROJ_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String projName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.PROJ_SHORT_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String projShortName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_ID
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String projSubTypeId;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String projSubTypeName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.PROJ_DECLARER
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String projDeclarer;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.PROJ_SHORT_DECLARER
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String projShortDeclarer;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CONTRACT_TYPE_ID
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String contractTypeId;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CONTRACT_TYPE_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String contractTypeName;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CONTRACT_FUND
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private BigDecimal contractFund;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CONTRACT_NO
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String contractNo;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CASE_NUMBER
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private Integer caseNumber;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CONTRACT_COPIES
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private Integer contractCopies;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.STAMP_DATE
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String stampDate;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CONTRACT_FILE
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String contractFile;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.RECORD_STATUS
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String recordStatus;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CREATE_TIME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String createTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.CREATE_USER_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String createUserFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.MODIFY_TIME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String modifyTime;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.MODIFY_USER_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String modifyUserFlow;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column PDSCI.GCP_CONTRACT.ORG_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	private String orgFlow;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_FLOW
	 * @return  the value of PDSCI.GCP_CONTRACT.CONTRACT_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getContractFlow() {
		return contractFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_FLOW
	 * @param contractFlow  the value for PDSCI.GCP_CONTRACT.CONTRACT_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setContractFlow(String contractFlow) {
		this.contractFlow = contractFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_NAME
	 * @return  the value of PDSCI.GCP_CONTRACT.CONTRACT_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getContractName() {
		return contractName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_NAME
	 * @param contractName  the value for PDSCI.GCP_CONTRACT.CONTRACT_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.PROJ_FLOW
	 * @return  the value of PDSCI.GCP_CONTRACT.PROJ_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getProjFlow() {
		return projFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.PROJ_FLOW
	 * @param projFlow  the value for PDSCI.GCP_CONTRACT.PROJ_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setProjFlow(String projFlow) {
		this.projFlow = projFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.PROJ_NAME
	 * @return  the value of PDSCI.GCP_CONTRACT.PROJ_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getProjName() {
		return projName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.PROJ_NAME
	 * @param projName  the value for PDSCI.GCP_CONTRACT.PROJ_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setProjName(String projName) {
		this.projName = projName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.PROJ_SHORT_NAME
	 * @return  the value of PDSCI.GCP_CONTRACT.PROJ_SHORT_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getProjShortName() {
		return projShortName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.PROJ_SHORT_NAME
	 * @param projShortName  the value for PDSCI.GCP_CONTRACT.PROJ_SHORT_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setProjShortName(String projShortName) {
		this.projShortName = projShortName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_ID
	 * @return  the value of PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_ID
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getProjSubTypeId() {
		return projSubTypeId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_ID
	 * @param projSubTypeId  the value for PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_ID
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setProjSubTypeId(String projSubTypeId) {
		this.projSubTypeId = projSubTypeId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_NAME
	 * @return  the value of PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getProjSubTypeName() {
		return projSubTypeName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_NAME
	 * @param projSubTypeName  the value for PDSCI.GCP_CONTRACT.PROJ_SUB_TYPE_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setProjSubTypeName(String projSubTypeName) {
		this.projSubTypeName = projSubTypeName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.PROJ_DECLARER
	 * @return  the value of PDSCI.GCP_CONTRACT.PROJ_DECLARER
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getProjDeclarer() {
		return projDeclarer;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.PROJ_DECLARER
	 * @param projDeclarer  the value for PDSCI.GCP_CONTRACT.PROJ_DECLARER
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setProjDeclarer(String projDeclarer) {
		this.projDeclarer = projDeclarer;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.PROJ_SHORT_DECLARER
	 * @return  the value of PDSCI.GCP_CONTRACT.PROJ_SHORT_DECLARER
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getProjShortDeclarer() {
		return projShortDeclarer;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.PROJ_SHORT_DECLARER
	 * @param projShortDeclarer  the value for PDSCI.GCP_CONTRACT.PROJ_SHORT_DECLARER
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setProjShortDeclarer(String projShortDeclarer) {
		this.projShortDeclarer = projShortDeclarer;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_TYPE_ID
	 * @return  the value of PDSCI.GCP_CONTRACT.CONTRACT_TYPE_ID
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getContractTypeId() {
		return contractTypeId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_TYPE_ID
	 * @param contractTypeId  the value for PDSCI.GCP_CONTRACT.CONTRACT_TYPE_ID
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setContractTypeId(String contractTypeId) {
		this.contractTypeId = contractTypeId;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_TYPE_NAME
	 * @return  the value of PDSCI.GCP_CONTRACT.CONTRACT_TYPE_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getContractTypeName() {
		return contractTypeName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_TYPE_NAME
	 * @param contractTypeName  the value for PDSCI.GCP_CONTRACT.CONTRACT_TYPE_NAME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setContractTypeName(String contractTypeName) {
		this.contractTypeName = contractTypeName;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_FUND
	 * @return  the value of PDSCI.GCP_CONTRACT.CONTRACT_FUND
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public BigDecimal getContractFund() {
		return contractFund;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_FUND
	 * @param contractFund  the value for PDSCI.GCP_CONTRACT.CONTRACT_FUND
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setContractFund(BigDecimal contractFund) {
		this.contractFund = contractFund;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_NO
	 * @return  the value of PDSCI.GCP_CONTRACT.CONTRACT_NO
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getContractNo() {
		return contractNo;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_NO
	 * @param contractNo  the value for PDSCI.GCP_CONTRACT.CONTRACT_NO
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CASE_NUMBER
	 * @return  the value of PDSCI.GCP_CONTRACT.CASE_NUMBER
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public Integer getCaseNumber() {
		return caseNumber;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CASE_NUMBER
	 * @param caseNumber  the value for PDSCI.GCP_CONTRACT.CASE_NUMBER
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setCaseNumber(Integer caseNumber) {
		this.caseNumber = caseNumber;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_COPIES
	 * @return  the value of PDSCI.GCP_CONTRACT.CONTRACT_COPIES
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public Integer getContractCopies() {
		return contractCopies;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_COPIES
	 * @param contractCopies  the value for PDSCI.GCP_CONTRACT.CONTRACT_COPIES
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setContractCopies(Integer contractCopies) {
		this.contractCopies = contractCopies;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.STAMP_DATE
	 * @return  the value of PDSCI.GCP_CONTRACT.STAMP_DATE
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getStampDate() {
		return stampDate;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.STAMP_DATE
	 * @param stampDate  the value for PDSCI.GCP_CONTRACT.STAMP_DATE
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setStampDate(String stampDate) {
		this.stampDate = stampDate;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_FILE
	 * @return  the value of PDSCI.GCP_CONTRACT.CONTRACT_FILE
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getContractFile() {
		return contractFile;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CONTRACT_FILE
	 * @param contractFile  the value for PDSCI.GCP_CONTRACT.CONTRACT_FILE
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setContractFile(String contractFile) {
		this.contractFile = contractFile;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.RECORD_STATUS
	 * @return  the value of PDSCI.GCP_CONTRACT.RECORD_STATUS
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getRecordStatus() {
		return recordStatus;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.RECORD_STATUS
	 * @param recordStatus  the value for PDSCI.GCP_CONTRACT.RECORD_STATUS
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setRecordStatus(String recordStatus) {
		this.recordStatus = recordStatus;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CREATE_TIME
	 * @return  the value of PDSCI.GCP_CONTRACT.CREATE_TIME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CREATE_TIME
	 * @param createTime  the value for PDSCI.GCP_CONTRACT.CREATE_TIME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.CREATE_USER_FLOW
	 * @return  the value of PDSCI.GCP_CONTRACT.CREATE_USER_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getCreateUserFlow() {
		return createUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.CREATE_USER_FLOW
	 * @param createUserFlow  the value for PDSCI.GCP_CONTRACT.CREATE_USER_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setCreateUserFlow(String createUserFlow) {
		this.createUserFlow = createUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.MODIFY_TIME
	 * @return  the value of PDSCI.GCP_CONTRACT.MODIFY_TIME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getModifyTime() {
		return modifyTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.MODIFY_TIME
	 * @param modifyTime  the value for PDSCI.GCP_CONTRACT.MODIFY_TIME
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.MODIFY_USER_FLOW
	 * @return  the value of PDSCI.GCP_CONTRACT.MODIFY_USER_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getModifyUserFlow() {
		return modifyUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.MODIFY_USER_FLOW
	 * @param modifyUserFlow  the value for PDSCI.GCP_CONTRACT.MODIFY_USER_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setModifyUserFlow(String modifyUserFlow) {
		this.modifyUserFlow = modifyUserFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column PDSCI.GCP_CONTRACT.ORG_FLOW
	 * @return  the value of PDSCI.GCP_CONTRACT.ORG_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public String getOrgFlow() {
		return orgFlow;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column PDSCI.GCP_CONTRACT.ORG_FLOW
	 * @param orgFlow  the value for PDSCI.GCP_CONTRACT.ORG_FLOW
	 * @mbggenerated  Thu Oct 30 14:48:52 GMT+08:00 2014
	 */
	public void setOrgFlow(String orgFlow) {
		this.orgFlow = orgFlow;
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -5898292851163219090L;
}