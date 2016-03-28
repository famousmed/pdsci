package com.pinde.sci.form.erp;

import java.util.ArrayList;
import java.util.List;

import com.pinde.sci.model.mo.ErpCrmCustomerUser;
import com.pinde.sci.model.mo.ErpOaWorkOrder;

public class WorkOrderForm extends ErpOaWorkOrder{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8611093669119469123L;
	
	private String customerAddress;
	private String consumerAddress;
	private String requireCompleteDate;
	private String contactGenerateDate;
	private List<ErpCrmCustomerUser> customerUserList = new ArrayList<ErpCrmCustomerUser>();
	
	private String salesAdvice;
	private String dealTypeId;
	
	private String taskState;
	
	/*完成工作任务*/
	private String content;
	private String arriveDate;
	private String completeDate;
	private String isCompleted;
	
	/*完成工作任务审核*/
	private String isSatisfied;//是否满意
	private String advice;     //客户意见
	private String signUser;   //客户签字
	private String signDate;   //签字日期
	private String adviceRecorderUserFlow; //记录人flow
	private String adviceRecorder;  //记录人流水号
	
	/*部门经理审核*/
	private String departmentManagerUserFlow;  //部门经理流水号
	private String departmentManager;          //部门经理名称
	private String departmentManagerSignDate;  //签字日期
	private String departmentManagerAuditContent;     //部门经理审核内容
	
	/*客户回访*/
	private String customerLinkman;
	private String visitDate;
	private String isSolved;
	private String visitContent;
	private String visitor;
	
	private String auditContent;
    
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	public String getRequireCompleteDate() {
		return requireCompleteDate;
	}
	public void setRequireCompleteDate(String requireCompleteDate) {
		this.requireCompleteDate = requireCompleteDate;
	}
	public String getContactGenerateDate() {
		return contactGenerateDate;
	}
	public void setContactGenerateDate(String contactGenerateDate) {
		this.contactGenerateDate = contactGenerateDate;
	}
	public List<ErpCrmCustomerUser> getCustomerUserList() {
		return customerUserList;
	}
	public void setCustomerUserList(List<ErpCrmCustomerUser> customerUserList) {
		this.customerUserList = customerUserList;
	}
	public String getSalesAdvice() {
		return salesAdvice;
	}
	public void setSalesAdvice(String salesAdvice) {
		this.salesAdvice = salesAdvice;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getArriveDate() {
		return arriveDate;
	}
	public void setArriveDate(String arriveDate) {
		this.arriveDate = arriveDate;
	}
	public String getCompleteDate() {
		return completeDate;
	}
	public void setCompleteDate(String completeDate) {
		this.completeDate = completeDate;
	}
	public String getIsSatisfied() {
		return isSatisfied;
	}
	public void setIsSatisfied(String isSatisfied) {
		this.isSatisfied = isSatisfied;
	}
	public String getAdvice() {
		return advice;
	}
	public void setAdvice(String advice) {
		this.advice = advice;
	}
	public String getSignUser() {
		return signUser;
	}
	public void setSignUser(String signUser) {
		this.signUser = signUser;
	}
	public String getSignDate() {
		return signDate;
	}
	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}
	public String getAdviceRecorder() {
		return adviceRecorder;
	}
	public void setAdviceRecorder(String adviceRecorder) {
		this.adviceRecorder = adviceRecorder;
	}
	public String getDepartmentManager() {
		return departmentManager;
	}
	public void setDepartmentManager(String departmentManager) {
		this.departmentManager = departmentManager;
	}
	public String getDepartmentManagerSignDate() {
		return departmentManagerSignDate;
	}
	public void setDepartmentManagerSignDate(String departmentManagerSignDate) {
		this.departmentManagerSignDate = departmentManagerSignDate;
	}
	public String getCustomerLinkman() {
		return customerLinkman;
	}
	public void setCustomerLinkman(String customerLinkman) {
		this.customerLinkman = customerLinkman;
	}
	public String getVisitDate() {
		return visitDate;
	}
	public void setVisitDate(String visitDate) {
		this.visitDate = visitDate;
	}
	public String getIsSolved() {
		return isSolved;
	}
	public void setIsSolved(String isSolved) {
		this.isSolved = isSolved;
	}
	public String getVisitContent() {
		return visitContent;
	}
	public void setVisitContent(String visitContent) {
		this.visitContent = visitContent;
	}
	public String getVisitor() {
		return visitor;
	}
	public void setVisitor(String visitor) {
		this.visitor = visitor;
	}
	public String getAdviceRecorderUserFlow() {
		return adviceRecorderUserFlow;
	}
	public void setAdviceRecorderUserFlow(String adviceRecorderUserFlow) {
		this.adviceRecorderUserFlow = adviceRecorderUserFlow;
	}
	public String getDepartmentManagerUserFlow() {
		return departmentManagerUserFlow;
	}
	public void setDepartmentManagerUserFlow(String departmentManagerUserFlow) {
		this.departmentManagerUserFlow = departmentManagerUserFlow;
	}
	public String getDealTypeId() {
		return dealTypeId;
	}
	public void setDealTypeId(String dealTypeId) {
		this.dealTypeId = dealTypeId;
	}
	public String getIsCompleted() {
		return isCompleted;
	}
	public void setIsCompleted(String isCompleted) {
		this.isCompleted = isCompleted;
	}
	public String getAuditContent() {
		return auditContent;
	}
	public void setAuditContent(String auditContent) {
		this.auditContent = auditContent;
	}
	public String getDepartmentManagerAuditContent() {
		return departmentManagerAuditContent;
	}
	public void setDepartmentManagerAuditContent(
			String departmentManagerAuditContent) {
		this.departmentManagerAuditContent = departmentManagerAuditContent;
	}
	public String getConsumerAddress() {
		return consumerAddress;
	}
	public void setConsumerAddress(String consumerAddress) {
		this.consumerAddress = consumerAddress;
	}
	public String getTaskState() {
		return taskState;
	}
	public void setTaskState(String taskState) {
		this.taskState = taskState;
	}
	
}
