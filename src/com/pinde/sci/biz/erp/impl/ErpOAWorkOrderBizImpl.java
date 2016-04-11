package com.pinde.sci.biz.erp.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContactOrderBiz;
import com.pinde.sci.biz.erp.IErpCustomerBiz;
import com.pinde.sci.biz.erp.IErpOAWorkOrderBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.ErpOaWorkOrderMapper;
import com.pinde.sci.dao.base.SysCfgMapper;
import com.pinde.sci.dao.erp.ErpOaWorkOrderExtMapper;
import com.pinde.sci.enums.erp.ContactOrderStatusEnum;
import com.pinde.sci.enums.erp.WorkOrderStatusEnum;
import com.pinde.sci.enums.pub.WeixinStatusEnum;
import com.pinde.sci.form.erp.ContactOrderAuditForm;
import com.pinde.sci.form.erp.WorkOrderAuditForm;
import com.pinde.sci.form.erp.WorkOrderForm;
import com.pinde.sci.model.erp.ErpOaWorkOrderExt;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;
import com.pinde.sci.model.mo.ErpOaContactOrder;
import com.pinde.sci.model.mo.ErpOaWorkOrder;
import com.pinde.sci.model.mo.ErpOaWorkOrderExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.ErpOaWorkOrderExample.Criteria;
@Service
@Transactional(rollbackFor = Exception.class)
public class ErpOAWorkOrderBizImpl implements IErpOAWorkOrderBiz {
	@Autowired
	private ErpOaWorkOrderMapper workOrderMapper;
	@Autowired
	private IErpContactOrderBiz contactOrderBiz;
	@Autowired
	private ErpOaWorkOrderExtMapper workOrderExtMapper;
	@Resource
	private SysCfgMapper sysCfgMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private IErpCustomerBiz customerBiz;
	
	
	@Override
	public int save(ErpOaWorkOrder workOrder) {
		if(StringUtil.isBlank(workOrder.getWorkFlow())){
			String contactFlow=workOrder.getContactFlow();
			ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
			synchronized(this){
				//查询该联系单有多少张派工单
				int workOrderCount=this.countWorkOrder(workOrder);
				String newNo = String.valueOf(workOrderCount+1);
				   //newNo不足三位补0
				   int length = newNo.length();
				   if (length<3) {
					   for (int i=0;i<(3-length);i++) {
						   newNo = "0" + newNo;
					   }
				   }
                 if(StringUtil.isNotBlank(workOrder.getContactFlow())){
                	 newNo=contactOrder.getContactNo()+"-"+newNo;
                	 workOrder.setWorkNo(newNo);
                 }  
			}
			workOrder.setWorkFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(workOrder, true);
			return workOrderMapper.insert(workOrder);
		}else{
			GeneralMethod.setRecordInfo(workOrder, false);
			return workOrderMapper.updateByPrimaryKeySelective(workOrder);
		}
	}

	@Override
	public String saveWorkOrderForm(WorkOrderForm form) throws Exception {
		Document dom = null;
		Element root = null;
		ErpOaWorkOrder workOrder = readWorkOrder(form.getWorkFlow());
		if(workOrder == null){//新增
			workOrder = new ErpOaWorkOrder();
			workOrder.setContactFlow(form.getContactFlow());
			ErpOaContactOrder contactOrder = contactOrderBiz.readContactOrder(form.getContactFlow());
			ErpCrmCustomer customer=null;
			ErpCrmCustomer consumer=null;
			//客户,最终使用方
			if(contactOrder != null){
				workOrder.setCustomerFlow(contactOrder.getCustomerFlow());
				workOrder.setCustomerName(contactOrder.getCustomerName());
				customer=this.customerBiz.readCustomer(contactOrder.getCustomerFlow());
				if(customer!=null){
					workOrder.setAliasName(customer.getAliasName());
				}
				workOrder.setConsumerFlow(contactOrder.getConsumerFlow());
				workOrder.setConsumerName(contactOrder.getConsumerName());
				consumer=this.customerBiz.readCustomer(contactOrder.getConsumerFlow());
				if(consumer!=null){
					workOrder.setConsumerAliasName(consumer.getAliasName());
				}
			}
			
			dom = DocumentHelper.createDocument();
			root = dom.addElement("info");
			Element formElement = root.addElement("form");
			//客户
			Element customerElement = formElement.addElement("customer");
			Element addressElement=customerElement.addElement("address");
			if(customer!=null){
				String address=StringUtil.defaultString(customer.getCustomerProvName());
				       address+=StringUtil.defaultString(customer.getCustomerCityName());
				       address+=StringUtil.defaultString(customer.getCustomerAreaName());
				       address+=StringUtil.defaultString(customer.getCustomerAddress());
				addressElement.setText(address);
			}
			Element consumerElement = formElement.addElement("consumer");
			Element consumerAddressElement=consumerElement.addElement("consumerAddress");
			if(consumer!=null){
				String address=StringUtil.defaultString(consumer.getCustomerProvName());
			           address+=StringUtil.defaultString(consumer.getCustomerCityName());
			           address+=StringUtil.defaultString(consumer.getCustomerAreaName());
			           address+=StringUtil.defaultString(consumer.getCustomerAddress());
				consumerAddressElement.setText(address);
			}
			Element dateElement = formElement.addElement("date");
			//日期
			dateElement.addElement("requireCompleteDate").setText(form.getRequireCompleteDate());
			dateElement.addElement("contactGenerateDate").setText(form.getContactGenerateDate());
			//联系人信息
			List<ErpCrmCustomerUser> customerUserList = form.getCustomerUserList();
			if(customerUserList != null && !customerUserList.isEmpty()){
				Element workUserElement = formElement.addElement("workUser");
				for(ErpCrmCustomerUser cu : customerUserList){
					Element userElement = workUserElement.addElement("user");
					userElement.addAttribute("userFlow",cu.getUserFlow());
					userElement.addAttribute("userName", cu.getUserName());
					userElement.addAttribute("deptName", cu.getDeptName());
					userElement.addAttribute("postName", cu.getPostName());
					userElement.addAttribute("telPhone", cu.getUserTelphone());
					userElement.addAttribute("celPhone", cu.getUserCelphone());
				}
			}
			//工作任务
			if(contactOrder != null){
				Element taskElement = formElement.addElement("task");
				Element productElement = taskElement.addElement("product");
				productElement.addAttribute("productTypeId", contactOrder.getProductTypeId());
				productElement.addAttribute("productTypeName", contactOrder.getProductTypeName());
				taskElement.addElement("remark").setText(contactOrder.getRemark()==null ? "" : contactOrder.getRemark());
				Element serviceElement = taskElement.addElement("service");
				serviceElement.addAttribute("serviceTypeId", contactOrder.getServiceTypeId());
				serviceElement.addAttribute("serviceTypeName", contactOrder.getServiceTypeName());
				//销售意见/需求
				taskElement.addElement("salesAdvice").setText(form.getSalesAdvice());
				if(StringUtil.isNotBlank(form.getTaskState())){
					taskElement.addElement("taskState").setText(form.getTaskState());
				}
			}
		}else{//编辑
			dom = DocumentHelper.parseText(workOrder.getWorkContent());
			root = dom.getRootElement();
			//联系人信息
			String workUserXpath = "//workUser";
			Element workUserElement = (Element) dom.selectSingleNode(workUserXpath);
			workUserElement.clearContent();
			List<ErpCrmCustomerUser> customerUserList = form.getCustomerUserList();
			if(customerUserList != null && !customerUserList.isEmpty()){
				for(ErpCrmCustomerUser cu : customerUserList){
					Element userElement = workUserElement.addElement("user");
					userElement.addAttribute("userFlow",cu.getUserFlow());
					userElement.addAttribute("userName", cu.getUserName());
					userElement.addAttribute("deptName", cu.getDeptName());
					userElement.addAttribute("postName", cu.getPostName());
					userElement.addAttribute("telPhone", cu.getUserTelphone());
					userElement.addAttribute("celPhone", cu.getUserCelphone());
				}
			}
			//form节点
			String formXpath="/info/form";
			Element formElement=(Element) dom.selectSingleNode(formXpath);
			if(formElement==null){
				formElement=root.addElement("form");
			}
			//工作任务节点
			String taskXpath="/info/form/task";
			Element taskElement=(Element) dom.selectSingleNode(taskXpath);
			if(taskElement==null){
				taskElement=formElement.addElement("task");
			}
			//任务说明
			String taskStateXpath="/info/form/task/taskState";
			Element taskStateElement=(Element) dom.selectSingleNode(taskStateXpath);
			if(taskStateElement==null){
				taskStateElement=taskElement.addElement("taskState");
			}
			if(StringUtil.isNotBlank(form.getTaskState())){
				taskStateElement.setText(form.getTaskState());
			}
			
		}
		
		//处理方式
		String disposeMethodXpath = "//disposeMethod";
		Node disposeMethodNode = dom.selectSingleNode(disposeMethodXpath);
		if(disposeMethodNode == null){
			String taskXpath = "//task";
			Element taskXpathElement = (Element) dom.selectSingleNode(taskXpath);
			if(taskXpathElement!= null){
				disposeMethodNode = taskXpathElement.addElement("disposeMethod");
			}
		}
		disposeMethodNode.setText(form.getDealTypeId()==null?"":form.getDealTypeId());
		workOrder.setWorkContent(dom.asXML());
		//分配工程师
		workOrder.setAssignDate(form.getAssignDate());
		if(StringUtil.isBlank(form.getAssignDeptFlow())){
			workOrder.setAssignDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
			workOrder.setAssignDeptName(GlobalContext.getCurrentUser().getDeptName());
		}else{
			workOrder.setAssignDeptFlow(form.getAssignDeptFlow());
			workOrder.setAssignDeptName(form.getAssignDeptName());
		}
		workOrder.setAssignUserFlow(form.getAssignUserFlow());
		workOrder.setAssignUserName(form.getAssignUserName());
		//派工单状态
		workOrder.setWorkStatusId(WorkOrderStatusEnum.Save.getId());
		workOrder.setWorkStatusName(WorkOrderStatusEnum.Save.getName());
		save(workOrder);
		return workOrder.getWorkFlow();
	}

	@Override
	public ErpOaWorkOrder readWorkOrder(String workFlow) {
		return workOrderMapper.selectByPrimaryKey(workFlow);
	}

	@Override
	public List<ErpOaWorkOrder> searchWorkOrderList(ErpOaWorkOrder workOrder){
		ErpOaWorkOrderExample example = new ErpOaWorkOrderExample();
		com.pinde.sci.model.mo.ErpOaWorkOrderExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(workOrder.getContactFlow())){
			criteria.andContactFlowEqualTo(workOrder.getContactFlow());
		}
		if(StringUtil.isNotBlank(workOrder.getWorkStatusId())){
			criteria.andWorkStatusIdEqualTo(workOrder.getWorkStatusId());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return workOrderMapper.selectByExampleWithBLOBs(example);
	}

	@Override
	public List<ErpOaWorkOrderExt> searchWorkOrderList(Map<String, Object> paramMap) {
		return workOrderExtMapper.searchWorkOrderList(paramMap);
	}
	
	@Override
	public List<ErpOaWorkOrderExt> applyWorkOrderList(
			Map<String, Object> paramMap) {
		return workOrderExtMapper.applyWorkOrderList(paramMap);
	}

	@Override
	public int completeWorkOrder(WorkOrderForm workForm) throws Exception {
		ErpOaWorkOrder workOrder = readWorkOrder(workForm.getWorkFlow());
		if(workOrder != null){
			Document dom = DocumentHelper.parseText(workOrder.getWorkContent());
			String taskXpath = "//task";
			Element taskElement = (Element) dom.selectSingleNode(taskXpath);
			if(taskElement != null){
				//具体内容、到达时间、完成时间
				Element completeElement = taskElement.element("complete");
				if(completeElement == null){
					completeElement = taskElement.addElement("complete");
				}
				Element isCompletedElement = completeElement.element("isCompleted");
				if(isCompletedElement == null){
					isCompletedElement = completeElement.addElement("isCompleted");
				}
				isCompletedElement.setText(workForm.getIsCompleted());
				
				Element contentElement = completeElement.element("content");
				if(contentElement == null){
					contentElement = completeElement.addElement("content");
				}
				contentElement.setText(workForm.getContent());
				
				Element arriveDateElement = completeElement.element("arriveDate");
				if(arriveDateElement == null){
					arriveDateElement = completeElement.addElement("arriveDate");
				}
				arriveDateElement.setText(workForm.getArriveDate());
				
				Element completeDateElement = completeElement.element("completeDate");
				if(completeDateElement == null){
					completeDateElement = completeElement.addElement("completeDate");
				}
				completeDateElement.setText(workForm.getCompleteDate());
				
				workOrder.setWorkContent(dom.asXML());
				workOrder.setWorkStatusId(WorkOrderStatusEnum.Implemented.getId());
				workOrder.setWorkStatusName(WorkOrderStatusEnum.Implemented.getName());
				save(workOrder);
				//给实施部门助理发消息，提醒审核
				Map<String,Object> paramMap=new HashMap<String, Object>();
				paramMap.put("menuId", "erp-ssgl-lxdgl-lxdpg");
				paramMap.put("deptFlow", GlobalContext.getCurrentUser().getDeptFlow());
				List<SysUser> userList=this.userBiz.searchUserByMenu(paramMap);
				if(userList!=null && !userList.isEmpty()){
					for(SysUser user:userList){
						  if(!GlobalContext.getCurrentUser().getUserFlow().equals(user.getUserFlow())){
							  String content=user.getUserName()+"您好，派工单（单号："+workOrder.getWorkNo()+"）实施完成等待您的审核！";
								msgBiz.addEmailMsg(user.getUserEmail(), content, content);
								if(WeixinStatusEnum.Status1.getId().equals(user.getWeiXinStatusId())){
								msgBiz.addWeixinMsg(user.getUserFlow(), content, content);  
						    }
					      }
					}
				}
				
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int implementedAudit(WorkOrderForm workOrderForm) throws Exception {
		ErpOaWorkOrder workOrder = readWorkOrder(workOrderForm.getWorkFlow());
		if(workOrder != null){
			Document dom = DocumentHelper.parseText(workOrder.getWorkContent());
			String formXpath = "//form";
			Element formElement = (Element) dom.selectSingleNode(formXpath);
			Map<String,Object> paramMap=new HashMap<String, Object>();
			List<SysUser> userList=null;
			String content2=null;
			WorkOrderAuditForm auditForm=new WorkOrderAuditForm();
			if(formElement != null){
				if(WorkOrderStatusEnum.CompletePassed.getId().equals(workOrderForm.getWorkStatusId())){
					//客户意见
					Element customerAdviceElement = formElement.addElement("customerAdvice");
					customerAdviceElement.addElement("isSatisfied").setText(workOrderForm.getIsSatisfied()==null?"":workOrderForm.getIsSatisfied());
					customerAdviceElement.addElement("advice").setText(workOrderForm.getAdvice()==null?"":workOrderForm.getAdvice());
					customerAdviceElement.addElement("signUser").setText(workOrderForm.getSignUser()==null?"":workOrderForm.getSignUser());
					customerAdviceElement.addElement("signDate").setText(workOrderForm.getSignDate()==null?"":workOrderForm.getSignDate());
					//公司审核
					Element companyAuditElement = formElement.addElement("companyAudit");
					companyAuditElement.addElement("adviceRecorder").addAttribute("userFlow", workOrderForm.getAdviceRecorderUserFlow()).setText(workOrderForm.getAdviceRecorder());
					workOrder.setWorkContent(dom.asXML());
					workOrder.setWorkStatusId(WorkOrderStatusEnum.CompletePassed.getId());
					workOrder.setWorkStatusName(WorkOrderStatusEnum.CompletePassed.getName());
					auditForm.setAuditStatusId(WorkOrderStatusEnum.CompletePassed.getId());
					auditForm.setAuditStatusName(WorkOrderStatusEnum.CompletePassed.getName());
				    //审核通过给实施部门经理发消息提醒
					paramMap.put("menuId", "erp-ssgl-lxdgl-lxdpg");
					paramMap.put("deptFlow", GlobalContext.getCurrentUser().getDeptFlow());
					userList=this.userBiz.searchUserByMenu(paramMap);
					content2="派工单（单号："+workOrder.getWorkNo()+"）实施完成审核通过，现在等待您的审核！";
				}else{
					//审核不通过给派工单实施人员发消息提醒
					workOrder.setWorkStatusId(WorkOrderStatusEnum.CompleteUnPassed.getId());
					workOrder.setWorkStatusName(WorkOrderStatusEnum.CompleteUnPassed.getName());
					auditForm.setAuditStatusId(WorkOrderStatusEnum.CompletePassed.getId());
					auditForm.setAuditStatusName(WorkOrderStatusEnum.CompletePassed.getName());
					userList=new ArrayList<SysUser>();
					SysUser user=this.userBiz.readSysUser(workOrder.getAssignUserFlow());
					userList.add(user);
					content2="派工单（单号："+workOrder.getWorkNo()+"）实施完成审核不通过，请修改！";
				}
				auditForm.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				auditForm.setUserName(GlobalContext.getCurrentUser().getUserName());
				auditForm.setAuditDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
				auditForm.setAuditDeptName(GlobalContext.getCurrentUser().getDeptName());
				auditForm.setAuditDate(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
				auditForm.setAuditContent(workOrderForm.getAuditContent());
				String xmlContent=workOrderAuditFormToXml(auditForm, workOrder);
				workOrder.setWorkContent(xmlContent);
				save(workOrder);
				if(userList!=null && !userList.isEmpty()){
					for(SysUser user:userList){
							String content=user.getUserName()+"您好，"+content2;
							msgBiz.addEmailMsg(user.getUserEmail(), content, content);
							if(WeixinStatusEnum.Status1.getId().equals(user.getWeiXinStatusId())){
							msgBiz.addWeixinMsg(user.getUserFlow(), content, content);
							}
					}
				}
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int managerAudit(WorkOrderForm workOrderForm,String flag) throws Exception {
		ErpOaWorkOrder workOrder = readWorkOrder(workOrderForm.getWorkFlow());
		if(workOrder != null){
			//把派工单完成时间同步到联系单完成时间
			changeContactCompleteTime(workOrder);
			ErpOaContactOrder contact=this.contactOrderBiz.readContactOrder(workOrder.getContactFlow());
			//修改联系单状态
			if(GlobalConstant.FLAG_Y.equals(flag)){
				String contactNo=changeContactStatus(workOrder.getContactFlow());
				//审核通过给销售发消息提醒回访
				List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
				Map<String,String> saleMenuMap=new HashMap<String, String>();
				saleMenuMap.put("menuId", "erp-xsgl-crmxsgzl-lxdhf");
				menuMapList.add(saleMenuMap);
				String msgTitle="工作联系单（单号："+contactNo+"）实施完成等待回访！";
				this.contactOrderBiz.contactAndWorkInformationTemplate(contact, menuMapList, msgTitle);
			}
			Document dom = DocumentHelper.parseText(workOrder.getWorkContent());
			String companyAuditXpath = "//companyAudit";
			Element companyAuditElement = (Element) dom.selectSingleNode(companyAuditXpath);
			if(companyAuditElement != null){
				//部门经理审核
				companyAuditElement.addElement("departmentManager").addAttribute("userFlow", workOrderForm.getDepartmentManagerUserFlow()).setText(workOrderForm.getDepartmentManager());
				companyAuditElement.addElement("departmentManagerAuditContent").setText(workOrderForm.getDepartmentManagerAuditContent());
				companyAuditElement.addElement("departmentManagerSignDate").setText(workOrderForm.getDepartmentManagerSignDate());
				workOrder.setWorkContent(dom.asXML());
				workOrder.setWorkStatusId(WorkOrderStatusEnum.Passed.getId());
				workOrder.setWorkStatusName(WorkOrderStatusEnum.Passed.getName());
				save(workOrder);
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
    
	@Override
	public String changeContactStatus(String contactFlow) throws Exception {
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		if(contactOrder!=null){
			contactOrder.setContactStatusId(ContactOrderStatusEnum.Implemented.getId());
			contactOrder.setContactStatusName(ContactOrderStatusEnum.Implemented.getName());
		    String result=this.contactOrderBiz.saveContactOrder(contactOrder);
		    if(result!=GlobalConstant.SAVE_FAIL){
		    	return contactOrder.getContactNo();
		    }
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@Override
	public int changeContactCompleteTime(ErpOaWorkOrder workOrder) throws Exception{
		if(workOrder!=null){
			WorkOrderForm form=this.parseWorkOrderFromXML(workOrder);
			String contactFlow=workOrder.getContactFlow();
			String workCompleteDate=form.getCompleteDate();
		    ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		    contactOrder.setCompleteTime(workCompleteDate);
		    String result=this.contactOrderBiz.saveContactOrder(contactOrder);
		    if(!result.equals(GlobalConstant.SAVE_FAIL)){
		    	return GlobalConstant.ONE_LINE;
		    }
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public int saveVisit(WorkOrderForm workOrderForm) throws Exception {
		ErpOaWorkOrder workOrder = readWorkOrder(workOrderForm.getWorkFlow());
		if(workOrder != null){
			Document dom = DocumentHelper.parseText(workOrder.getWorkContent());
			String formXpath = "//form";
			Element formElement = (Element) dom.selectSingleNode(formXpath);
			if(formElement != null){
				Element customerVisitElement = formElement.addElement("customerVisit");
				customerVisitElement.addElement("customerLinkman").setText(workOrderForm.getCustomerLinkman());
				customerVisitElement.addElement("visitDate").setText(workOrderForm.getVisitDate());
				customerVisitElement.addElement("isSolved").setText(workOrderForm.getIsSolved());
				customerVisitElement.addElement("visitContent").setText(workOrderForm.getVisitContent());
				customerVisitElement.addElement("visitor").setText(workOrderForm.getVisitor());
				workOrder.setWorkContent(dom.asXML());
				workOrder.setWorkStatusId(WorkOrderStatusEnum.Closed.getId());
				workOrder.setWorkStatusName(WorkOrderStatusEnum.Closed.getName());
				if(GlobalConstant.RECORD_STATUS_Y.equals(workOrderForm.getIsSolved())){
					//已解决问题
					if(StringUtil.isNotBlank(workOrder.getContactFlow())){
						ErpOaContactOrder contactOrder = new ErpOaContactOrder();
						contactOrder.setContactFlow(workOrder.getContactFlow());
						contactOrder.setContactStatusId(ContactOrderStatusEnum.Implemented.getId());
						contactOrder.setContactStatusName(ContactOrderStatusEnum.Implemented.getName());
						contactOrderBiz.saveContactOrder(contactOrder);
					}
					return save(workOrder);
				}else{
					save(workOrder);
					//未解决问题-->新增派工单
					ErpOaWorkOrder newWorkOrder = new ErpOaWorkOrder();
					newWorkOrder.setWorkNo(workOrder.getWorkNo());
					newWorkOrder.setContactFlow(workOrder.getContactFlow());
					ErpOaContactOrder contactOrder = contactOrderBiz.readContactOrder(workOrder.getContactFlow());
					//客户
					if(contactOrder != null){
						newWorkOrder.setCustomerFlow(contactOrder.getCustomerFlow());
						newWorkOrder.setCustomerName(contactOrder.getCustomerName());
					}
					String completeXpath = "//complete";
					Element completeElement = (Element) dom.selectSingleNode(completeXpath);
					completeElement.getParent().remove(completeElement);
					String customerAdviceXpath = "//customerAdvice";
					Element customerAdviceElement = (Element) dom.selectSingleNode(customerAdviceXpath);
					customerAdviceElement.getParent().remove(customerAdviceElement);
					String companyAuditXpath = "//companyAudit";
					Element companyAuditElement = (Element) dom.selectSingleNode(companyAuditXpath);
					companyAuditElement.getParent().remove(companyAuditElement);
					customerVisitElement.getParent().remove(customerVisitElement);
					//newWorkOrder.setAssignDate(DateUtil.getCurrDate());
					newWorkOrder.setWorkContent(dom.asXML());
					newWorkOrder.setWorkStatusId(WorkOrderStatusEnum.Save.getId());
					newWorkOrder.setWorkStatusName(WorkOrderStatusEnum.Save.getName());
					return save(newWorkOrder);
				}
			} 
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int implementing(ErpOaWorkOrder workOrder) throws Exception {
		if(workOrder!=null){
			workOrder.setWorkStatusId(WorkOrderStatusEnum.Implementing.getId());
			workOrder.setWorkStatusName(WorkOrderStatusEnum.Implementing.getName());
			//修改关联联系单状态
			ErpOaContactOrder contactOrder = contactOrderBiz.readContactOrder(workOrder.getContactFlow());
			if(contactOrder != null){
				if(!ContactOrderStatusEnum.Implementing.getId().equals(contactOrder.getContactStatusId())){
					contactOrder.setContactStatusId(ContactOrderStatusEnum.Implementing.getId());
					contactOrder.setContactStatusName(ContactOrderStatusEnum.Implementing.getName());
					contactOrderBiz.saveContactOrder(contactOrder);
					//给联系单申请人反馈联系单正在实施中
					List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
					Map<String,String> implementMenuMap=new HashMap<String, String>();
					implementMenuMap.put("menuId", "erp-ssgl-lxdgl-lxdpg");
					implementMenuMap.put("deptFlow",contactOrder.getReceiveDeptFlow());
					menuMapList.add(implementMenuMap);
					String msgTitle="工作联系单（单号："+contactOrder.getContactNo()+"）正在实施中！";
					this.contactOrderBiz.contactAndWorkInformationTemplate(contactOrder, menuMapList, msgTitle);
				}
			}
			 save(workOrder);
			  //给派工目标发消息提醒
			 List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
			 String msgTitle="派工单（单号："+workOrder.getWorkNo()+"）等待实施！";
			 this.contactOrderBiz.contactAndWorkInformationTemplate(workOrder, menuMapList, msgTitle);
			 return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int countWorkOrder(ErpOaWorkOrder workOrder) {
		ErpOaWorkOrderExample example=new ErpOaWorkOrderExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(workOrder.getContactFlow())){
			criteria.andContactFlowEqualTo(workOrder.getContactFlow());
		}
		return workOrderMapper.countByExample(example);
	}

	@SuppressWarnings("unchecked")
	@Override
	public WorkOrderForm parseWorkOrderFromXML(ErpOaWorkOrder workOrder) throws Exception {
		WorkOrderForm workOrderForm = null;
		if(workOrder != null && StringUtil.isNotBlank(workOrder.getWorkContent())){
			workOrderForm = new WorkOrderForm();
			Document dom = DocumentHelper.parseText(workOrder.getWorkContent());
			String taskStateXpath = "//taskState";
			Node taskStateNode=dom.selectSingleNode(taskStateXpath);
			if(taskStateNode!=null){
				workOrderForm.setTaskState(taskStateNode.getText());
			}
			String addressXpath = "//address";
			Node addressNode = dom.selectSingleNode(addressXpath);
			if(addressNode != null){
				workOrderForm.setCustomerAddress(addressNode.getText());
			}
			String consumerAddressXpath = "//consumerAddress";
			Node consumerAddressNode = dom.selectSingleNode(consumerAddressXpath);
			if(consumerAddressNode != null){
				workOrderForm.setConsumerAddress(consumerAddressNode.getText());
			}
			String requireCompleteDateXpath = "//requireCompleteDate";
			Node requireCompleteDateNode = dom.selectSingleNode(requireCompleteDateXpath);
			if(requireCompleteDateNode != null){
				workOrderForm.setRequireCompleteDate(requireCompleteDateNode.getText());
			}
			String contactGenerateDateXpath = "//contactGenerateDate";
			Node contactGenerateDateNode = dom.selectSingleNode(contactGenerateDateXpath);
			if(requireCompleteDateNode != null){
				workOrderForm.setContactGenerateDate(contactGenerateDateNode.getText());
			}
			String userXpath = "//user";
			List<Element> userElementList = dom.selectNodes(userXpath);
			if(userElementList != null && !userElementList.isEmpty()){
				List<ErpCrmCustomerUser> customerUserList = new ArrayList<ErpCrmCustomerUser>();
				for(Element ue : userElementList){
					ErpCrmCustomerUser customerUser = new ErpCrmCustomerUser();
					customerUser.setUserFlow(ue.attributeValue("userFlow"));
					customerUser.setUserName(ue.attributeValue("userName"));
					customerUser.setDeptName(ue.attributeValue("deptName"));
					customerUser.setPostName(ue.attributeValue("postName"));
					customerUser.setUserTelphone(ue.attributeValue("telPhone"));
					customerUser.setUserCelphone(ue.attributeValue("celPhone"));
					customerUserList.add(customerUser);
				}
				workOrderForm.setCustomerUserList(customerUserList);
			}
			//处理方式
			String disposeMethodXpath = "//disposeMethod";
			Node disposeMethodNode = dom.selectSingleNode(disposeMethodXpath);
			if(disposeMethodNode != null){
				workOrderForm.setDealTypeId(disposeMethodNode.getText());
			}
			//销售意见/需求
			String salesAdviceXpath = "//salesAdvice";
			Node salesAdviceNode = dom.selectSingleNode(salesAdviceXpath);
			if(salesAdviceNode != null){
				workOrderForm.setSalesAdvice(salesAdviceNode.getText());
			}
			//完成任务详情
			String contentXpath = "//content";
			Node contentNode = dom.selectSingleNode(contentXpath);
			if(contentNode != null){
				workOrderForm.setContent(contentNode.getText());
			}
			String completeXpath = "//complete";
			Element completeElement = (Element) dom.selectSingleNode(completeXpath);
			if(completeElement != null){
				workOrderForm.setIsCompleted(completeElement.element("isCompleted")==null ? "" :completeElement.element("isCompleted").getText());
				workOrderForm.setContent(completeElement.element("content")==null ? "" :completeElement.element("content").getText());
				workOrderForm.setArriveDate(completeElement.element("arriveDate")==null ? "" :completeElement.element("arriveDate").getText());
				workOrderForm.setCompleteDate(completeElement.element("completeDate")==null ? "" :completeElement.element("completeDate").getText());
			}
			//实施完成审核通过详情
			String customerAdviceXpath = "//customerAdvice";
			Element customerAdviceElement = (Element) dom.selectSingleNode(customerAdviceXpath);
			if(customerAdviceElement != null){
				workOrderForm.setIsSatisfied(customerAdviceElement.element("isSatisfied")==null ? "" :customerAdviceElement.element("isSatisfied").getText());
				workOrderForm.setAdvice(customerAdviceElement.element("advice")==null ? "" :customerAdviceElement.element("advice").getText());
				workOrderForm.setSignUser(customerAdviceElement.element("signUser")==null ? "" :customerAdviceElement.element("signUser").getText());
				workOrderForm.setSignDate(customerAdviceElement.element("signDate")==null ? "" :customerAdviceElement.element("signDate").getText());
			}
			//公司审核、部门经理审核
			String companyAuditXpath = "//companyAudit";
			Element companyAuditElement = (Element) dom.selectSingleNode(companyAuditXpath);
			if(companyAuditElement != null){
				workOrderForm.setAdviceRecorder(companyAuditElement.element("adviceRecorder")==null ? "" :companyAuditElement.element("adviceRecorder").getText());
				workOrderForm.setDepartmentManager(companyAuditElement.element("departmentManager")==null ? "" :companyAuditElement.element("departmentManager").getText());
				workOrderForm.setDepartmentManagerSignDate(companyAuditElement.element("departmentManagerSignDate")==null ? "" :companyAuditElement.element("departmentManagerSignDate").getText());
				workOrderForm.setDepartmentManagerAuditContent(companyAuditElement.element("departmentManagerAuditContent")==null ? "" :companyAuditElement.element("departmentManagerAuditContent").getText());
			}
			//客户回访
			String customerVisitXpath = "//customerVisit";
			Element customerVisitElement = (Element) dom.selectSingleNode(customerVisitXpath);
			if(customerVisitElement != null){
				workOrderForm.setCustomerLinkman(customerVisitElement.element("customerLinkman") == null ? "" : customerVisitElement.element("customerLinkman").getText());
				workOrderForm.setVisitDate(customerVisitElement.element("visitDate") == null ? "" : customerVisitElement.element("visitDate").getText());
				workOrderForm.setIsSolved(customerVisitElement.element("isSolved") == null ? "" : customerVisitElement.element("isSolved").getText());
				workOrderForm.setVisitContent(customerVisitElement.element("visitContent") == null ? "" : customerVisitElement.element("visitContent").getText());
				workOrderForm.setVisitor(customerVisitElement.element("visitor") == null ? "" : customerVisitElement.element("visitor").getText());
			}
		}
		return workOrderForm;
	}

	@Override
	public String workOrderApplyAudit(ErpOaWorkOrder workOrder) throws Exception {
		if(workOrder!=null){
			save(workOrder);
			//非本部门处理派工单改派本部门审核，发送消息给实施部门经理提醒
			List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
			Map<String,String> implementMenuMap=new HashMap<String, String>();
			implementMenuMap.put("menuId", "erp-ssgl-shgl-pgdsqsh");
			implementMenuMap.put("deptFlow", GlobalContext.getCurrentUser().getDeptFlow());
			Map<String,String> developMenuMap=new HashMap<String, String>();
			developMenuMap.put("menuId", "erp-yfgl-shgl-pgdsqsh");
			developMenuMap.put("deptFlow", GlobalContext.getCurrentUser().getDeptFlow());
			menuMapList.add(developMenuMap);
			String msgTitle="派工单（单号："+workOrder.getWorkNo()+"）申请非本部门处理，等待审核！";
			menuMapList.add(implementMenuMap);
			return this.contactOrderBiz.contactAndWorkInformationTemplate(workOrder, menuMapList, msgTitle);
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@Override
	public String workOrderApplyTargetAudit(ErpOaWorkOrder workOrder) throws Exception {
		if(workOrder!=null){
			save(workOrder);
			//非本部门处理派工单改派本部门审核，发送消息给实施部门经理提醒
			List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
			Map<String,String> developMenuMap=new HashMap<String, String>();
			developMenuMap.put("menuId", "erp-yfgl-shgl-pgdjssh");
			developMenuMap.put("deptFlow", workOrder.getAssignDeptFlow());
			Map<String,String> implementMenuMap=new HashMap<String, String>();
			implementMenuMap.put("menuId", "erp-ssgl-shgl-pgdjssh");
			implementMenuMap.put("deptFlow", workOrder.getAssignDeptFlow());
			String msgTitle="派工单（单号："+workOrder.getWorkNo()+"）改派"+workOrder.getAssignDeptName()+"处理，等待审核！";
			menuMapList.add(developMenuMap);
			menuMapList.add(implementMenuMap);
			return this.contactOrderBiz.contactAndWorkInformationTemplate(workOrder, menuMapList, msgTitle);
		}
		return GlobalConstant.OPRE_FAIL;
	}
    
	@Override
	public String workOrderApplyTargetUnPassed(ErpOaWorkOrder workOrder) throws Exception{
	if(workOrder!=null){
		//非本部门处理派工单改派本部门审核，发送消息给实施部门经理提醒
		List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
		Map<String,String> developMenuMap=new HashMap<String, String>();
		developMenuMap.put("menuId", "erp-yfgl-lxdgl-lxdpg");
		developMenuMap.put("deptFlow", workOrder.getAssignDeptFlow());
		Map<String,String> implementMenuMap=new HashMap<String, String>();
		implementMenuMap.put("menuId", "erp-ssgl-lxdgl-lxdpg");
		implementMenuMap.put("deptFlow", workOrder.getAssignDeptFlow());
		String msgTitle="派工单（单号："+workOrder.getWorkNo()+"）"+workOrder.getAssignDeptName()+"审核不通过，不接受改派！";
		menuMapList.add(developMenuMap);
		menuMapList.add(implementMenuMap);
		workOrder.setAssignUserFlow("");
		workOrder.setAssignUserName("");
		workOrder.setAssignDeptFlow("");
		workOrder.setAssignDeptName("");
		save(workOrder);
		return this.contactOrderBiz.contactAndWorkInformationTemplate(workOrder, menuMapList, msgTitle);
	}
	return GlobalConstant.OPRE_FAIL;
	}

	@Override
	public String deleteWorkOrder(ErpOaWorkOrder workOrder) {
		workOrder.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		int result=save(workOrder);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.DELETE_SUCCESSED;
		}else{
			return GlobalConstant.DELETE_FAIL;
		}
		 
	}

	@Override
	public String workOrderAuditFormToXml(WorkOrderAuditForm form,
			ErpOaWorkOrder workOrder) throws DocumentException {
		if(workOrder!=null){
			if(StringUtil.isNotBlank(workOrder.getWorkContent())){
				  Document dom = DocumentHelper.parseText(workOrder.getWorkContent());
				  Element rootElement=dom.getRootElement();
				  String auditsXpath="/info/audits";
				  Element auditsElement=(Element) dom.selectSingleNode(auditsXpath);
				  if(auditsElement==null){
					  auditsElement=rootElement.addElement("audits");
				  } 
				  Element auditElement=auditsElement.addElement("audit");
				  Element auditUserElement=auditElement.addElement("auditUser");
		    	  auditUserElement.addAttribute("userFlow", form.getUserFlow());
		    	  auditUserElement.addAttribute("userName", form.getUserName());
		    	  Element auditDeptElement=auditElement.addElement("auditDept");
		    	  auditDeptElement.addAttribute("deptFlow", form.getAuditDeptFlow());
		    	  auditDeptElement.addAttribute("deptName", form.getAuditDeptName());
		    	  Element auditDateElement=auditElement.addElement("auditDate");
		    	  auditDateElement.setText(form.getAuditDate());
		    	  Element auditResultElement=auditElement.addElement("auditResult");
		    	  auditResultElement.addAttribute("id", form.getAuditStatusId());
		    	  auditResultElement.addAttribute("name", form.getAuditStatusName());
		    	  auditResultElement.setText(form.getAuditContent());
		    	  return dom.asXML();
			}
		}
		return null;
	}

	@Override
	public List<WorkOrderAuditForm> xmlToWorkOrderAuditFormList(
			ErpOaWorkOrder workOrder) throws DocumentException {
		List<WorkOrderAuditForm> auditFormList=new ArrayList<WorkOrderAuditForm>();
	    if(workOrder!=null){
	    	if(StringUtil.isNotBlank(workOrder.getWorkContent())){
	    		Document dom = DocumentHelper.parseText(workOrder.getWorkContent());
	    		String auditsXpath="/info/audits";
				  Element auditsElement=(Element) dom.selectSingleNode(auditsXpath);
				  if(auditsElement==null){
					  return auditFormList;
				  }else{
					  String auditXpath="//audit";
					  List<Element> auditElementList=dom.selectNodes(auditXpath);
					  if(auditElementList!=null && !auditElementList.isEmpty()){
						  WorkOrderAuditForm form=null;
						  for(Element audit:auditElementList){
							  form=new WorkOrderAuditForm();
							  Element auditUserElement=(Element) audit.selectSingleNode("auditUser");
							  if(auditUserElement!=null){
								  form.setUserFlow(auditUserElement.attributeValue("userFlow"));
								  form.setUserName(auditUserElement.attributeValue("userName"));
							  }
							  Element auditDeptElement=(Element) audit.selectSingleNode("auditDept");
							  if(auditDeptElement!=null){
								  form.setAuditDeptFlow(auditDeptElement.attributeValue("deptFlow"));
								  form.setAuditDeptName(auditDeptElement.attributeValue("deptName"));
							  }
							  Element auditDateElement=(Element) audit.selectSingleNode("auditDate");
							  if(auditDateElement!=null){
								  form.setAuditDate(auditDateElement.getText());
							  }
							  Element auditResultElement=(Element) audit.selectSingleNode("auditResult");
							  if(auditResultElement!=null){
								  form.setAuditStatusId(auditResultElement.attributeValue("id"));
								  form.setAuditStatusName(auditResultElement.attributeValue("name"));
								  form.setAuditContent(auditResultElement.getText());
							  }
							  auditFormList.add(form);
						  }
					  }
				  }
	    	}
	    }
		return auditFormList;
	}



	

	
	

	
}
