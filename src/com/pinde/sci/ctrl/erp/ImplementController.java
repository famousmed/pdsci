package com.pinde.sci.ctrl.erp;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.docx4j.openpackaging.io.SaveToZipFile;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.SessionScope;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.Docx4jUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContactOrderBiz;
import com.pinde.sci.biz.erp.IErpContractBiz;
import com.pinde.sci.biz.erp.IErpContractProductBiz;
import com.pinde.sci.biz.erp.IErpContractUserBiz;
import com.pinde.sci.biz.erp.IErpContractUserRefBiz;
import com.pinde.sci.biz.erp.IErpCustomerBiz;
import com.pinde.sci.biz.erp.IErpCustomerUserBiz;
import com.pinde.sci.biz.erp.IErpOAWorkOrderBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.erp.ContactOrderStatusEnum;
import com.pinde.sci.enums.erp.DealTypeEnum;
import com.pinde.sci.enums.erp.WorkOrderStatusEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.form.erp.ContactOrderAuditForm;
import com.pinde.sci.form.erp.ContactOrderDisposeForm;
import com.pinde.sci.form.erp.ContactOrderForm;
import com.pinde.sci.form.erp.ContactOrderTimeForm;
import com.pinde.sci.form.erp.WorkOrderAuditForm;
import com.pinde.sci.form.erp.WorkOrderForm;
import com.pinde.sci.model.erp.ErpOaWorkOrderExt;
import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractProduct;
import com.pinde.sci.model.mo.ErpCrmContractUser;
import com.pinde.sci.model.mo.ErpCrmContractUserRef;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;
import com.pinde.sci.model.mo.ErpOaContactOrder;
import com.pinde.sci.model.mo.ErpOaWorkOrder;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;
/**
 * @author tiger
 *
 */
@Controller
@RequestMapping("erp/implement")
public class ImplementController extends GeneralController{
	@Autowired
	private IUserBiz sysUserBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IErpContactOrderBiz contactOrderBiz;
	@Autowired
	private IErpCustomerBiz erpCustomerBiz;
	@Autowired
	private IErpOAWorkOrderBiz workOrderBiz;
	@Autowired
	private IErpContractBiz contractBiz;
	@Autowired
	private IErpCustomerUserBiz customerUserBiz;
	@Autowired
	private IErpContractUserBiz contractUserBiz;
	@Autowired
	private IErpContractUserRefBiz contractUserRefBiz;
	@Autowired
	private IErpContractProductBiz productBiz;
	
	/**
	 * 工作联系单接收列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/contactOrderReceiveList/{userListScope}")
	public String auditWorkContactList(@PathVariable String userListScope, ErpOaContactOrder contactOrder, Integer currentPage,
        HttpServletRequest request,ContactOrderTimeForm orderTimeForm,Model model){
	    setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
	    Map<String,Object> paramMap=new HashMap<String, Object>();
	    if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){
	    	paramMap.put("currDeptFlowFlag", GlobalContext.getCurrentUser().getDeptFlow());
	    }
	    if(GlobalConstant.USER_LIST_PERSONAL.equals(userListScope)){
	    	paramMap.put("currDeptFlow", GlobalContext.getCurrentUser().getDeptFlow());
	    }
	    paramMap.put("receiveFlag", "true");
	    paramMap.put("contactOrder", contactOrder);
	    paramMap.put("orderTimeForm",orderTimeForm);
	    PageHelper.startPage(currentPage, getPageSize(request));
		List<ErpOaContactOrder> contactOrderList=this.contactOrderBiz.searchContactOrderList(paramMap);
	    model.addAttribute("contactOrderList", contactOrderList);
		return "erp/implement/contactOrder/receiveList";
	}
	
	@RequestMapping(value="/delWorkOrder")
	@ResponseBody
	public String delWorkOrder(String workFlow){
		ErpOaWorkOrder workOrder=this.workOrderBiz.readWorkOrder(workFlow);
		if(workOrder!=null){
			return this.workOrderBiz.deleteWorkOrder(workOrder);
		}
		return GlobalConstant.DELETE_FAIL;
	}
	/**
	 * 工作联系单接收
	 * @param model
	 * @return
	 * @throws DocumentException 
	 */
	@RequestMapping(value="/contactOrderReceive")
	public String auditWorkContact(String contactFlow,Model model) throws DocumentException{
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		if(contactOrder!=null){
			ContactOrderForm form=this.contactOrderBiz.xmlToContactOrder(contactOrder.getContactContent());
			//销售意见/需求
			List<ContactOrderAuditForm> auditFormList=this.contactOrderBiz.searchContactOrderAuditForm(contactFlow);
			//form.setAuditList(auditFormList);
			if(auditFormList != null && !auditFormList.isEmpty()){
				ContactOrderAuditForm auditForm = null;
				ContactOrderAuditForm businessAuditForm = null;
				ContactOrderAuditForm managerAuditForm = null;
				for(int i=auditFormList.size()-1; i>=0;i--){
					//总经理意见
					if(ContactOrderStatusEnum.ManagerPassed.getName().equals(auditFormList.get(i).getAuditStatusName())){
						managerAuditForm = auditFormList.get(i);
						model.addAttribute("managerAuditForm", managerAuditForm);
						continue;
					}
					//商务审核意见
					if(ContactOrderStatusEnum.BusinessPassed.getName().equals(auditFormList.get(i).getAuditStatusName())
							||ContactOrderStatusEnum.ManagerAuditing.getName().equals(auditFormList.get(i).getAuditStatusName())){
						businessAuditForm = auditFormList.get(i);
						model.addAttribute("businessAuditForm", businessAuditForm);
						continue;
					}
					//销售意见/需求
					if(ContactOrderStatusEnum.SalePassed.getName().equals(auditFormList.get(i).getAuditStatusName())){
						auditForm = auditFormList.get(i);
						model.addAttribute("auditForm", auditForm);
						break;
					}
				}
			}
			/*ContactOrderDisposeForm disposeForm=this.contactOrderBiz.searchDisposeForm(contactFlow);
			form.setDisposeForm(disposeForm);*/
		    model.addAttribute("contactOrderForm", form);
		    //如果该联系单选择了合同查询合同信息以及该合同所有联系单
		    ErpCrmContract erpContract=null;
		    List<ErpOaContactOrder> contactOrderList=null;
		    if(StringUtil.isNotBlank(contactOrder.getContractFlow())){
		    	erpContract=this.contractBiz.readContract(contactOrder.getContractFlow());
		    	ErpOaContactOrder newContactOrder=new ErpOaContactOrder();
		    	newContactOrder.setContractFlow(contactOrder.getContractFlow());
		    	contactOrderList=this.contactOrderBiz.searchContactOrderList(newContactOrder, null);
		    }
		    if(contactOrderList!=null && !contactOrderList.isEmpty()){
		    	model.addAttribute("lastContactOrder", contactOrderList.get(0));
		    }
		    model.addAttribute("erpContract", erpContract);
		    model.addAttribute("contactOrder", contactOrder);
		 }
			SysDept dept=this.deptBiz.readSysDept(GlobalContext.getCurrentUser().getDeptFlow());
			model.addAttribute("dept", dept);
		return "erp/implement/contactOrder/receiveWorkContact";
	}
	/**
	 * 打开工作联系单改派页面
	 * @param contractFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/reassign")
	public String reassign(String contactFlow,Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		if(StringUtil.isNotBlank(orgFlow)){
			SysDept sysDept = new SysDept();
			sysDept.setOrgFlow(orgFlow);
			sysDept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<SysDept> deptList = deptBiz.searchDept(sysDept);
			if (deptList != null) {
				String deptFlow = GlobalContext.getCurrentUser().getDeptFlow();
				if (StringUtil.isNotBlank(deptFlow)) {
					for (int i=0;i<deptList.size();i++) {
						SysDept temp = deptList.get(i);
						if (temp.getDeptFlow().equals(deptFlow)) {
							deptList.remove(temp);
							i--;
						}
					}
				}
			}
			model.addAttribute("deptList", deptList);
			model.addAttribute("contactFlow", contactFlow);
		}
		return "erp/implement/contactOrder/reassign";
	}
	
	/**
	 * 保存联系单接收或改派
	 * @param contactFlow
	 * @param deptFlow
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveReassign")
	@ResponseBody
	public String saveReassign(ContactOrderDisposeForm form,String deptFlow,String contactFlow,String receiveFlag) throws Exception{
		String result=null;
		if(StringUtil.isBlank(deptFlow)){
			deptFlow=GlobalContext.getCurrentUser().getDeptFlow();
		}
	    SysDept dept=this.deptBiz.readSysDept(deptFlow);
	    ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
	    contactOrder.setContactContent(this.contactOrderBiz.contactOrderDisposeToXml(form, contactFlow));
	    contactOrder.setReceiveDeptFlow(dept.getDeptFlow());
	    contactOrder.setReceiveDeptName(dept.getDeptName());
	    result=this.contactOrderBiz.saveContactReassign(contactOrder,receiveFlag);
		return result;
	}
	
	/**
	 * 工作联系单
	 * @param contactOrder
	 * @param orderTimeForm
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/contactOrders")
	public String contactOrders(ErpOaContactOrder contactOrder, ContactOrderTimeForm orderTimeForm,
			                    String sortCondition,String sortType,
								Integer currentPage, HttpServletRequest request, Model model){
		if(StringUtil.isBlank(sortType)){
			sortType="asc";
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(StringUtil.isBlank(contactOrder.getContactStatusId())){
			List<String> contactStatusIdList = new ArrayList<String>();
			contactStatusIdList.add(ContactOrderStatusEnum.Received.getId());
			contactStatusIdList.add(ContactOrderStatusEnum.Implementing.getId());
			contactStatusIdList.add(ContactOrderStatusEnum.Implemented.getId());
			paramMap.put("contactStatusIdList", contactStatusIdList);
		}
		if(StringUtil.isNotBlank(sortType)){
			paramMap.put("sortType", sortType);
		}
		if(StringUtil.isNotBlank(sortCondition)){
			paramMap.put("sortCondition", sortCondition);
		}
		paramMap.put("contactOrder", contactOrder);
		paramMap.put("orderTimeForm", orderTimeForm);
		paramMap.put("orderTimeForm", orderTimeForm);
		paramMap.put("currDeptFlow", GlobalContext.getCurrentUser().getDeptFlow());
		PageHelper.startPage(currentPage, getPageSize(request));
		List<ErpOaContactOrder> contactOrderList = contactOrderBiz.searchContactOrderList(paramMap);
		model.addAttribute("contactOrderList", contactOrderList);
		return "erp/implement/contactOrder/list";
	}

	@RequestMapping(value="/workOrders")
	public String workOrders(Model model){
		return "erp/implement/contactOrder/workOrders";
	}
	
	
	/**
	 * 派工单派工列表
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/assignList")
	public String assignList(ErpOaWorkOrder workOrder, String type, Model model) throws Exception{
		if(StringUtil.isNotBlank(workOrder.getContactFlow())){
			List<ErpOaWorkOrder> workOrderList = workOrderBiz.searchWorkOrderList(workOrder);
			model.addAttribute("workOrderList", workOrderList);
			if(StringUtil.isNotBlank(type) && "load".equals(type)){
				Map<String, String> isSolvedMap = new HashMap<String, String>();
				if(workOrderList!=null && !workOrderList.isEmpty()){
					for(ErpOaWorkOrder wo : workOrderList){
						String content = wo.getWorkContent();
					    if (StringUtil.isNotBlank(content)) {
					    	Document dom = DocumentHelper.parseText(content);
					    	String customerVisitXpath = "//customerVisit";
					    	Element customerVisitElement = (Element) dom.selectSingleNode(customerVisitXpath);
					    	if(customerVisitElement != null){
					    		isSolvedMap.put(wo.getWorkFlow(), customerVisitElement.element("isSolved") == null ? "" : customerVisitElement.element("isSolved").getText());
					    	}
					    }
					}
				}
				model.addAttribute("isSolvedMap", isSolvedMap);
				return "erp/sales/contactOrder/workOrderList";
			}
		}
		return "erp/implement/contactOrder/assignList";
	}
	
	/**
	 * 保存联系单派工
	 * @param workOrderForm
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveWorkOrder")
	@ResponseBody
	public String saveWorkOrder(@RequestBody WorkOrderForm workOrderForm) throws Exception{
		String workFlow = workOrderBiz.saveWorkOrderForm(workOrderForm);
		if(StringUtil.isNotBlank(workFlow)){
			return workFlow;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value="/workOrderProduct")
	public String workOrderProduct(String contactFlow,String workFlow,Model model){
		if(StringUtil.isNotBlank(workFlow)){
			ErpOaWorkOrder workOrder=this.workOrderBiz.readWorkOrder(workFlow);
			model.addAttribute("workOrder", workOrder);
		}
		if(StringUtil.isNotBlank(contactFlow)){
			ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
			model.addAttribute("contactOrder", contactOrder);
			if(contactOrder!=null){
				//产品列表
				if(StringUtil.isNotBlank(contactOrder.getContractFlow())){
					Map<String,Object> productInsMap=new HashMap<String, Object>();
					ErpCrmContractProduct product=new ErpCrmContractProduct();
					product.setContractFlow(contactOrder.getContractFlow());
				    List<ErpCrmContractProduct> productList=this.productBiz.searchContactProductList(product);
				    model.addAttribute("productList", productList);
				    if(productList!=null && !productList.isEmpty()){
				    	for(ErpCrmContractProduct pro:productList){
				    		productInsMap.put(pro.getProductTypeName(), pro);
				    	}
				    }
				    model.addAttribute("productInsMap", productInsMap);
				}
				if(StringUtil.isNotBlank(contactOrder.getProductTypeName())){
					List<String> productNameList=new ArrayList<String>();
					String [] productTypeNameArray =contactOrder.getProductTypeName().split("、");
					for(String str:productTypeNameArray){
						productNameList.add(str);
					}
				    model.addAttribute("productNameList", productNameList);
				}
			}
			}
		return "erp/implement/contactOrder/product";
	}
	
	
	/**
	 * 新增、编辑联系单派工
	 * @param contactFlow
	 * @param customerFlow
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/editWorkOrder")
	public String editWorkOrder(String contactFlow, String customerFlow, String workFlow, String type, Model model) throws Exception{
		ErpOaContactOrder contactOrder = contactOrderBiz.readContactOrder(contactFlow);
		model.addAttribute("contactOrder", contactOrder);
		if(contactOrder!=null){
			//查询客户联系人标记
			Map<String,String> userCategoryMap=this.contractUserBiz.searchUserCategoryMap(contactOrder.getContractFlow());
			model.addAttribute("userCategoryMap", userCategoryMap);
			Map<String,Object> userRefMap=searchUserRefMap(contactOrder.getContactFlow());
			model.addAttribute("userRefMap", userRefMap);
			//产品列表
			if(StringUtil.isNotBlank(contactOrder.getContractFlow())){
				Map<String,String> productInsMap=new HashMap<String, String>();
				ErpCrmContractProduct product=new ErpCrmContractProduct();
				product.setContractFlow(contactOrder.getContractFlow());
			    List<ErpCrmContractProduct> productList=this.productBiz.searchContactProductList(product);
			    model.addAttribute("productList", productList);
			    if(productList!=null && !productList.isEmpty()){
			    	for(ErpCrmContractProduct pro:productList){
			    		productInsMap.put(pro.getProductTypeName(), pro.getInstallPlace());
			    	}
			    }
			    model.addAttribute("productInsMap", productInsMap);
			}
			if(StringUtil.isNotBlank(contactOrder.getProductTypeName())){
				List<String> productNameList=new ArrayList<String>();
				String [] productTypeNameArray =contactOrder.getProductTypeName().split("、");
				for(String str:productTypeNameArray){
					productNameList.add(str);
				}
			    model.addAttribute("productNameList", productNameList);
			}
		}
		//查询该联系单下是否有未实施经理审核通过的联系单
		ErpOaWorkOrder searchWork=new ErpOaWorkOrder();
		searchWork.setContactFlow(contactFlow);
		List<ErpOaWorkOrder> workList=this.workOrderBiz.searchWorkOrderList(searchWork);
		String completeFlag=GlobalConstant.FLAG_Y;
		if(workList!=null && workList.size()>1){
			for(ErpOaWorkOrder work: workList){
				if(!work.getWorkStatusId().equals(WorkOrderStatusEnum.Passed.getId())){
					completeFlag=GlobalConstant.FLAG_N;
				}
			}
		}
		model.addAttribute("completeFlag", completeFlag);
		if(StringUtil.isNotBlank(workFlow)){
			ErpOaWorkOrder workOrder = workOrderBiz.readWorkOrder(workFlow);
			model.addAttribute("workOrder", workOrder);
			if(workOrder != null){//编辑
				WorkOrderForm workOrderForm =workOrderBiz.parseWorkOrderFromXML(workOrder);
				model.addAttribute("workOrderForm", workOrderForm);
				//审核信息
				List<WorkOrderAuditForm> auditFormList=this.workOrderBiz.xmlToWorkOrderAuditFormList(workOrder);
				model.addAttribute("auditFormList", auditFormList);
				if(auditFormList!=null && !auditFormList.isEmpty()){
					for(int i=auditFormList.size()-1; i>=0;i--){
						if(WorkOrderStatusEnum.Implementing.getId().equals(auditFormList.get(i).getAuditStatusId())
						   || WorkOrderStatusEnum.ApplyTargetUnPassed.getId().equals(auditFormList.get(i).getAuditStatusId())){
							model.addAttribute("applyTargetAuditForm", auditFormList.get(i));
						}
						if(WorkOrderStatusEnum.ApplyTargetAudit.getId().equals(auditFormList.get(i).getAuditStatusId())){
							model.addAttribute("applyAuditForm", auditFormList.get(i));
							break;
						}
					}
					for(int i=auditFormList.size()-1; i>=0;i--){
						if(WorkOrderStatusEnum.CompletePassed.getId().equals(auditFormList.get(i).getAuditStatusId())
								   || WorkOrderStatusEnum.CompleteUnPassed.getId().equals(auditFormList.get(i).getAuditStatusId())){
							model.addAttribute("completeAuditForm", auditFormList.get(i));
							break;
						}
					}
				}
				//联系人
				if(workOrderForm.getCustomerUserList() != null && !workOrderForm.getCustomerUserList().isEmpty()){
					ErpCrmCustomerUser orderCustomerUser = workOrderForm.getCustomerUserList().get(0);
					model.addAttribute("orderCustomerUser", orderCustomerUser);
				}
				if(StringUtil.isNotBlank(type) && "load".equals(type)){//末次更新时间加载派工单信息
					return "erp/implement/contactOrder/workOrderInfo";
				}
				List<SysUser> userList=searchOwnUser(GlobalContext.getCurrentUser().getDeptFlow());
				model.addAttribute("userList", userList);
			}
		}else{//新增
			if(contactOrder != null){
				//地址
				ContactOrderForm contactOrderForm = contactOrderBiz.xmlToContactOrder(contactOrder.getContactContent());
				model.addAttribute("contactOrderForm", contactOrderForm);
				//联系单生成时间:关联联系单审核完成时间contactGenerateDate
				if(StringUtil.isNotBlank(contactOrder.getContactContent())){
					Document dom = DocumentHelper.parseText(contactOrder.getContactContent());
					String managerPassedXpath = "//auditResult[@name='"+ ContactOrderStatusEnum.ManagerPassed.getName() +"']";
					Node managerPassedNode = dom.selectSingleNode(managerPassedXpath);
					Element auditDateElement = null;
					if(managerPassedNode != null){
						auditDateElement = managerPassedNode.getParent().element("auditDate");
					}else{
						String businessPassedXpath = "//auditResult[@name='"+ ContactOrderStatusEnum.BusinessPassed.getName() +"']";
						List<Node> businessPassedNodeList = dom.selectNodes(businessPassedXpath);
						if(businessPassedNodeList != null && !businessPassedNodeList.isEmpty()){
							Node businessPassedNode = businessPassedNodeList.get(0);
							auditDateElement = businessPassedNode.getParent().element("auditDate");
						}
					}
					if(auditDateElement != null){
						model.addAttribute("contactGenerateDate", auditDateElement.getText());
					}
				}
				//处理方式
				ContactOrderDisposeForm contactOrderDisposeForm = contactOrderBiz.searchDisposeForm(contactFlow);
				model.addAttribute("contactOrderDisposeForm", contactOrderDisposeForm);
			}
		}
		SysUser sysUser = new SysUser();
		sysUser.setDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
		sysUser.setStatusId(UserStatusEnum.Activated.getId());
		List<SysUser> userList = sysUserBiz.searchUser(sysUser);
		model.addAttribute("userList", userList);
		
		List<ErpCrmCustomerUser> customerUserList = null;
		if(StringUtil.isNotBlank(customerFlow)){
			ErpCrmCustomerUser user = new ErpCrmCustomerUser();
			user.setCustomerFlow(customerFlow);
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			customerUserList =  customerUserBiz.searchCustomerUserList(user);
		}
		model.addAttribute("customerUserList", customerUserList);
		return "erp/implement/contactOrder/editWorkOrder";
	}
	
	/**
	 * 加载部门
	 * @param orgFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/getDept"})
	@ResponseBody
	public List<SysDept> getDept(String orgFlow,Model model){
		SysDept sysDept = new SysDept();
		sysDept.setOrgFlow(orgFlow);
		sysDept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		return deptBiz.searchDept(sysDept);
	}
	
	/**
	 * 加载分配工程师
	 * @param deptFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/getDeptUsers"})
	@ResponseBody
	public List<SysUser> getDeptUsers(String deptFlow,Model model){
		SysUser sysUser = new SysUser();
		sysUser.setDeptFlow(deptFlow);
		sysUser.setStatusId(UserStatusEnum.Activated.getId());
		List<SysUser> userList =  sysUserBiz.searchUser(sysUser);
		return userList;
	}
	
	/**
	 * 本部门派工
	 * @param workFlow
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/implementing"})
	@ResponseBody
	public String implementing(String workFlow,String assignUserFlow) throws Exception{
			ErpOaWorkOrder workOrder=this.workOrderBiz.readWorkOrder(workFlow);
			if(workOrder!=null){
				if(StringUtil.isBlank(workOrder.getAssignUserFlow())){
					SysUser assignUser=this.sysUserBiz.readSysUser(assignUserFlow);
					if(assignUser!=null){
						workOrder.setAssignUserFlow(assignUser.getUserFlow());
						workOrder.setAssignUserName(assignUser.getUserName());
					}
				}
				    int result = workOrderBiz.implementing(workOrder);
					if(GlobalConstant.ZERO_LINE != result){
						return GlobalConstant.OPRE_SUCCESSED;
					}
			}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 查看派工单单审核意见
	 * @param model
	 * @return
	 * @throws DocumentException 
	 */
	@RequestMapping(value="/workOrderAuditOpinion")
	public String workOrderAuditOpinion(String workFlow,Model model) throws DocumentException{
		ErpOaWorkOrder workOrder=this.workOrderBiz.readWorkOrder(workFlow);
		if(workOrder!=null){
			List<WorkOrderAuditForm> auditFormList=this.workOrderBiz.xmlToWorkOrderAuditFormList(workOrder);
			model.addAttribute("auditFormList", auditFormList);
		}
		return "erp/implement/contactOrder/auditOpinion";
	}
	
	/**
	 * 跨部门派工
	 * @param workFlow
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/crossImplementing"})
	@ResponseBody
	public String crossImplementing(String workFlow,String assignUserFlow,WorkOrderAuditForm auditForm) throws Exception{
			ErpOaWorkOrder workOrder=this.workOrderBiz.readWorkOrder(workFlow);
			if(workOrder!=null){
				auditForm.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				auditForm.setUserName(GlobalContext.getCurrentUser().getUserName());
				auditForm.setAuditDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
				auditForm.setAuditDeptName(GlobalContext.getCurrentUser().getDeptName());
				auditForm.setAuditDate(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
				auditForm.setAuditStatusId(WorkOrderStatusEnum.Implementing.getId());
				auditForm.setAuditStatusName(GlobalContext.getCurrentUser().getDeptName()+"审核通过");
				String workContent=this.workOrderBiz.workOrderAuditFormToXml(auditForm, workOrder);
				workOrder.setWorkContent(workContent);
				SysUser assignUser=this.sysUserBiz.readSysUser(assignUserFlow);
					if(assignUser!=null){
						workOrder.setAssignUserFlow(assignUser.getUserFlow());
						workOrder.setAssignUserName(assignUser.getUserName());
					}
				    int result = workOrderBiz.implementing(workOrder);
					if(GlobalConstant.ZERO_LINE != result){
						return GlobalConstant.OPRE_SUCCESSED;
					}
			}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value={"/recallWorkOrder"})
	@ResponseBody
    public int recallWorkOrder(String workFlow,String statusId){
		ErpOaWorkOrder workOrder=this.workOrderBiz.readWorkOrder(workFlow);
		if(workOrder!=null){
			workOrder.setWorkStatusId(statusId);
			workOrder.setWorkStatusName(WorkOrderStatusEnum.getNameById(workOrder.getWorkStatusId()));
			workOrder.setAssignUserFlow("");
			workOrder.setAssignUserName("");
			int result = this.workOrderBiz.save(workOrder);
			if(result==GlobalConstant.ONE_LINE){
			 return result;	
			}
		}
    	return GlobalConstant.ZERO_LINE;
    }
	
	/**
	 * 派工单改派本送本部门审核
	 * @param workFlow
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/applyAudit"})
	@ResponseBody
	public String applyAudit(String workFlow) throws Exception{
			ErpOaWorkOrder workOrder = this.workOrderBiz.readWorkOrder(workFlow);
			if(workOrder!=null){
				workOrder.setWorkFlow(workFlow);
				workOrder.setWorkStatusId(WorkOrderStatusEnum.ApplyAudit.getId());
				workOrder.setWorkStatusName(WorkOrderStatusEnum.ApplyAudit.getName());
				this.workOrderBiz.workOrderApplyAudit(workOrder);
				return GlobalConstant.OPRE_SUCCESSED;
			}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 派工单改派本送目标部门审核
	 * @param workFlow
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/applyTargetAudit"})
	@ResponseBody
	public String applyTargetAudit(WorkOrderAuditForm auditForm,String workFlow) throws Exception{
			ErpOaWorkOrder workOrder = this.workOrderBiz.readWorkOrder(workFlow);
			if(workOrder!=null && auditForm!=null){
				workOrder.setWorkFlow(workFlow);
				workOrder.setWorkStatusId(WorkOrderStatusEnum.ApplyTargetAudit.getId());
				workOrder.setWorkStatusName(WorkOrderStatusEnum.ApplyTargetAudit.getName());
				auditForm.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				auditForm.setUserName(GlobalContext.getCurrentUser().getUserName());
				auditForm.setAuditDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
				auditForm.setAuditDeptName(GlobalContext.getCurrentUser().getDeptName());
				auditForm.setAuditDate(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
				auditForm.setAuditStatusId(WorkOrderStatusEnum.ApplyTargetAudit.getId());
				auditForm.setAuditStatusName(WorkOrderStatusEnum.ApplyTargetAudit.getName());
				String workContent=this.workOrderBiz.workOrderAuditFormToXml(auditForm, workOrder);
				workOrder.setWorkContent(workContent);
				this.workOrderBiz.workOrderApplyTargetAudit(workOrder);
				return GlobalConstant.OPRE_SUCCESSED;
			}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value={"/applyTargetUnPassed"})
	@ResponseBody
	public String applyTargetUnPassed(WorkOrderAuditForm auditForm,String workFlow) throws Exception{
			ErpOaWorkOrder workOrder = this.workOrderBiz.readWorkOrder(workFlow);
			if(workOrder!=null && auditForm!=null){
				workOrder.setWorkFlow(workFlow);
				workOrder.setWorkStatusId(WorkOrderStatusEnum.ApplyTargetUnPassed.getId());
				workOrder.setWorkStatusName(WorkOrderStatusEnum.ApplyTargetUnPassed.getName());
				auditForm.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				auditForm.setUserName(GlobalContext.getCurrentUser().getUserName());
				auditForm.setAuditDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
				auditForm.setAuditDeptName(GlobalContext.getCurrentUser().getDeptName());
				auditForm.setAuditDate(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
				auditForm.setAuditStatusId(WorkOrderStatusEnum.ApplyTargetUnPassed.getId());
				auditForm.setAuditStatusName(WorkOrderStatusEnum.ApplyTargetUnPassed.getName());
				String workContent=this.workOrderBiz.workOrderAuditFormToXml(auditForm, workOrder);
				workOrder.setWorkContent(workContent);
				this.workOrderBiz.workOrderApplyTargetUnPassed(workOrder);
				return GlobalConstant.OPRE_SUCCESSED;
			}
		return GlobalConstant.OPRE_FAIL;
	}
	
	
	
	//**********************我的派工单***********************
	
	/**
	 * 我的派工单
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/myWorkOrders/{userListScope}")
	public String myWorkOrders(@PathVariable String userListScope,ErpOaWorkOrder workOrder, ErpOaContactOrder contactOrder, ContactOrderTimeForm orderTimeForm,
								Integer currentPage, HttpServletRequest request, Model model) throws Exception{
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(StringUtil.isBlank(workOrder.getWorkStatusId())){
			List<String> workStatusIdList = new ArrayList<String>();
			workStatusIdList.add(WorkOrderStatusEnum.Implementing.getId());
			workStatusIdList.add(WorkOrderStatusEnum.Implemented.getId());
			workStatusIdList.add(WorkOrderStatusEnum.CompletePassed.getId());
			workStatusIdList.add(WorkOrderStatusEnum.CompleteUnPassed.getId());
			workStatusIdList.add(WorkOrderStatusEnum.Passed.getId());
			workStatusIdList.add(WorkOrderStatusEnum.Closed.getId());
			paramMap.put("workStatusIdList", workStatusIdList);
		}
		if(GlobalConstant.USER_LIST_PERSONAL.equals(userListScope)){
			workOrder.setAssignUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		}
		if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){
			workOrder.setAssignDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
		    List<SysUser> userList=searchOwnUser(GlobalContext.getCurrentUser().getDeptFlow());
		    model.addAttribute("userList", userList);
		}
		if(GlobalConstant.USER_LIST_GLOBAL.equals(userListScope)){
			model.addAttribute("deptList", searchOwnDept(GlobalContext.getCurrentUser().getOrgFlow()));
		}
		paramMap.put("workOrder", workOrder);
		paramMap.put("contactOrder", contactOrder);
		paramMap.put("orderTimeForm", orderTimeForm);
		PageHelper.startPage(currentPage, getPageSize(request));
		searchWorkOrderList(model, paramMap);
		return "erp/implement/contactOrder/myWorkOrders";
	}
	
	/**
	 * 完成工作任务
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/completeWorkOrder")
	@ResponseBody
	public String completeWorkOrder(WorkOrderForm workForm, Model model) throws Exception{
		int result = workOrderBiz.completeWorkOrder(workForm);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 完成任务审核
	 * @param workForm
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/implementedAudit")
	@ResponseBody
	public String implementedAudit(WorkOrderForm workForm) throws Exception{
		int result = workOrderBiz.implementedAudit(workForm);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 查询本部门已激活人员
	 * @return
	 */
	@RequestMapping(value="/searchOwnUser")
	@ResponseBody
	public List<SysUser> searchOwnUser(String deptFlow){
		SysUser sysUser=new SysUser();
		sysUser.setDeptFlow(deptFlow);
		sysUser.setStatusId(UserStatusEnum.Activated.getId());
		List<SysUser> userList=this.sysUserBiz.searchUser(sysUser);
		return userList;
	}
	
	/**
	 * 查询本机构所有部门
	 */
	@RequestMapping(value="/searchOwnDept")
	@ResponseBody
	public List<SysDept> searchOwnDept(String orgFlow){
		SysDept dept=new SysDept();
		dept.setOrgFlow(orgFlow);
		List<SysDept> deptList=this.deptBiz.searchDept(dept);
		return deptList;
	}
	//********************审核管理********************
	
	/**
	 * 派工单完成审核
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/auditWorkOrders/{typeScope}")
	public String auditWorkOrders(@PathVariable String typeScope,ErpOaWorkOrder workOrder, ErpOaContactOrder contactOrder, ContactOrderTimeForm orderTimeForm,
			Integer currentPage, HttpServletRequest request, Model model) throws Exception{
	    setSessionAttribute(GlobalConstant.TYPE_SCOPE, typeScope);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(GlobalConstant.ASSISTANT_AUDIT.equals(typeScope)){
			workOrder.setWorkStatusId(WorkOrderStatusEnum.Implemented.getId());
			paramMap.put("currDeptFlow", GlobalContext.getCurrentUser().getDeptFlow());
		}
		if(GlobalConstant.MANAGER_AUDIT.equals(typeScope)){
			workOrder.setWorkStatusId(WorkOrderStatusEnum.CompletePassed.getId());
			paramMap.put("currDeptFlow", GlobalContext.getCurrentUser().getDeptFlow());
		}
		if(GlobalConstant.APPLY_AUDIT.equals(typeScope)){
			workOrder.setWorkStatusId(WorkOrderStatusEnum.ApplyAudit.getId());
			paramMap.put("currDeptFlow", GlobalContext.getCurrentUser().getDeptFlow());
		}
		if(GlobalConstant.APPLY_TARGET_AUDIT.equals(typeScope)){
			workOrder.setWorkStatusId(WorkOrderStatusEnum.ApplyTargetAudit.getId());
			workOrder.setAssignDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
			paramMap.put("workOrder", workOrder);
			paramMap.put("contactOrder", contactOrder);
			paramMap.put("orderTimeForm", orderTimeForm);
			PageHelper.startPage(currentPage, getPageSize(request));
			List<ErpOaWorkOrderExt> workOrderExtList = workOrderBiz.applyWorkOrderList(paramMap);
			model.addAttribute("workOrderExtList", workOrderExtList);
			return "erp/implement/audit/workOrders";
		}
		paramMap.put("workOrder", workOrder);
		paramMap.put("contactOrder", contactOrder);
		paramMap.put("orderTimeForm", orderTimeForm);
		PageHelper.startPage(currentPage, getPageSize(request));
		searchWorkOrderList(model, paramMap);
		return "erp/implement/audit/workOrders";
	}

	/**
	 * 查询派工单
	 * @param model
	 * @param paramMap
	 * @throws DocumentException
	 */
	private void searchWorkOrderList(Model model, Map<String, Object> paramMap)throws DocumentException {
		List<ErpOaWorkOrderExt> workOrderExtList = workOrderBiz.searchWorkOrderList(paramMap);
		if(workOrderExtList != null && !workOrderExtList.isEmpty()){
			Map<String, String> completeDateMap = new HashMap<String, String>();
			for(ErpOaWorkOrderExt wo : workOrderExtList){
				if(StringUtil.isNotBlank(wo.getWorkContent())){
					Document dom = DocumentHelper.parseText(wo.getWorkContent());
					String completeDateXpath = "//completeDate";
					Node completeDateNode = dom.selectSingleNode(completeDateXpath);
					if(completeDateNode != null){
						completeDateMap.put(wo.getWorkFlow(), completeDateNode.getText());
					}
				}
			}
			model.addAttribute("completeDateMap", completeDateMap);
		}
 		model.addAttribute("workOrderExtList", workOrderExtList);
	}
	
	/**
	 * 部门经理审核
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/managerAudit")
	@ResponseBody
	public String managerAudit(WorkOrderForm workForm,String flag) throws Exception{
		int result = workOrderBiz.managerAudit(workForm,flag);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	

	
	/**
	 * 查询合同联系人在派工单中是否是使用人
	 * @param contractFlow
	 * @return
	 */
	public Map<String,Object> searchUserRefMap(String contactFlow){
		Map<String,Object> userRefMap=new HashMap<String, Object>();
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		if(contactOrder!=null){
		    ErpCrmContract contract=this.contractBiz.readContract(contactOrder.getContractFlow());
		    if(contract!=null){
		    	ErpCrmContractUserRef contractUserRef=new ErpCrmContractUserRef();
		    	contractUserRef.setContractFlow(contract.getContractFlow());
		    	List<ErpCrmContractUserRef> refList=this.contractUserRefBiz.searchContractUserRefList(contractUserRef);
		    	List<String> productIdList=new ArrayList<String>();
		    	String [] productIdArray=contactOrder.getProductTypeId().split(",");
		    	for(String str:productIdArray){
		    		if(!str.equals(GlobalConstant.FLAG_N)){
		    			productIdList.add(str);
		    		}
		    	}
		    	if(refList!=null && !refList.isEmpty()){
		    		for(ErpCrmContractUserRef ref:refList){
		    		   if(productIdList.contains(ref.getProductTypeId())){
		    			   userRefMap.put(ref.getUserFlow(), ref.getUserCategoryName());
		    		   }
		    		}
		    	}
		    }
		}
		return userRefMap;
	}
	
	public Map<String,Object> searchCustomerUserMap(String customerFlow){
		Map<String,Object> customerUserMap=new HashMap<String, Object>();
		ErpCrmCustomerUser customerUser=new ErpCrmCustomerUser();
		customerUser.setCustomerFlow(customerFlow);
		List<ErpCrmCustomerUser> customerUserList=this.customerUserBiz.searchCustomerUserList(customerUser);
		if(customerUserList!=null && customerUserList.isEmpty()){
			for(ErpCrmCustomerUser user:customerUserList){
				customerUserMap.put(user.getUserFlow(), user);
			}
		}
		return customerUserMap;
	}
	/**
	 * 回访
	 * @param workForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveVisit")
	@ResponseBody
	public String saveVisit(WorkOrderForm workOrderForm) throws Exception{
		int result = workOrderBiz.saveVisit(workOrderForm);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	//客户维护查询
	@RequestMapping(value="/maintainList")
	public String maintainList(Model model){
		return "erp/implement/maintain/list";
	}
	
	@RequestMapping(value="/maintianImplement")
	public String maintianImplement(Model model){
		return "erp/implement/maintain/implementList";
	}
	
	@RequestMapping(value="/finishImplement")
	public String finishImplement(Model model){
		return "erp/implement/maintain/finish";
	}
	
	//*********************打印*****************
	
	@RequestMapping("/printInfo")
	public void printInfo(String workFlow, Model model,HttpServletRequest request, HttpServletResponse response) throws Exception{
		if(StringUtil.isNotBlank(workFlow)){
			ErpOaWorkOrder workOrder = workOrderBiz.readWorkOrder(workFlow);
			if(workOrder != null){
				String content = workOrder.getWorkContent();
				if(StringUtil.isNotBlank(content)){
					Map<String, Object> dataMap = new HashMap<String, Object>();
					String fileName = "派工单 ";
					WorkOrderForm workOrderForm =workOrderBiz.parseWorkOrderFromXML(workOrder);
					dataMap.put("workNo", StringUtil.defaultString(workOrder.getWorkNo()));
					dataMap.put("customerName", StringUtil.defaultString(workOrder.getConsumerName()));
					String assignDate = workOrder.getAssignDate();
					if(StringUtil.isNotBlank(assignDate)){
						String assignYear = assignDate.substring(0,4);
						String assignMonth = assignDate.substring(5,7);
						String assignDay = assignDate.substring(8,10);
						dataMap.put("assignYear", assignYear);
						dataMap.put("assignMonth", assignMonth);
						dataMap.put("assignDay", assignDay);
					}
					dataMap.put("customerAddress", StringUtil.defaultString(workOrderForm.getConsumerAddress()));
					dataMap.put("requireCompleteDate", StringUtil.defaultString(workOrderForm.getRequireCompleteDate()));
					dataMap.put("contactGenerateDate", StringUtil.defaultString(workOrderForm.getContactGenerateDate()));
					//联系人
					if(workOrderForm.getCustomerUserList() != null && !workOrderForm.getCustomerUserList().isEmpty()){
						ErpCrmCustomerUser customerUser = workOrderForm.getCustomerUserList().get(0);
						dataMap.put("userName", StringUtil.defaultString(customerUser.getUserName()));
						dataMap.put("deptName", StringUtil.defaultString(customerUser.getDeptName()));
						dataMap.put("postName", StringUtil.defaultString(customerUser.getPostName()));
						dataMap.put("userTelphone", StringUtil.defaultString(customerUser.getUserTelphone()));
						dataMap.put("userCelphone", StringUtil.defaultString(customerUser.getUserCelphone()));
						if(workOrderForm.getCustomerUserList().size()>1){
							ErpCrmCustomerUser customerUser2 = workOrderForm.getCustomerUserList().get(1);
							dataMap.put("userName2", StringUtil.defaultString(customerUser2.getUserName()));
							dataMap.put("deptName2", StringUtil.defaultString(customerUser2.getDeptName()));
							dataMap.put("postName2", StringUtil.defaultString(customerUser2.getPostName()));
							dataMap.put("userTelphone2", StringUtil.defaultString(customerUser2.getUserTelphone()));
							dataMap.put("userCelphone2", StringUtil.defaultString(customerUser2.getUserCelphone()));
						}
					}
					
					//工作任务，产品
					if(StringUtil.isNotBlank(workOrder.getContactFlow())){
						ErpOaContactOrder contactOrder = contactOrderBiz.readContactOrder(workOrder.getContactFlow());
						/*Map<String,String> productInsMap=new HashMap<String, String>();
						if(StringUtil.isNotBlank(contactOrder.getProductTypeName())){
							String [] productTypeNameArray =contactOrder.getProductTypeName().split("、");
							for(String str:productTypeNameArray){
								
							}
						}*/
						dataMap.put("contactNo", StringUtil.defaultString(contactOrder.getContactNo()));
						dataMap.put("productTypeName", StringUtil.defaultString(contactOrder.getProductTypeName()));
						String remark = StringUtil.defaultString(contactOrder.getRemark());
						if (StringUtil.isNotBlank(remark) && remark.indexOf("\n")<0) {
							remark += "\n";
				    	}
						dataMap.put("remark", remark);
						dataMap.put("serviceTypeName", StringUtil.defaultString(contactOrder.getServiceTypeName()));
					}
					dataMap.put("salesAdvice", StringUtil.defaultString(workOrderForm.getSalesAdvice()));
					String dealTypeName = "";
					if(StringUtil.isNotBlank(workOrderForm.getDealTypeId())){
						dealTypeName = DealTypeEnum.getNameById(workOrderForm.getDealTypeId());
					}
					if(StringUtil.isNotBlank(workOrderForm.getTaskState())){
						dataMap.put("taskState",workOrderForm.getTaskState());
					}
					dataMap.put("dealTypeName", dealTypeName);
					String thisDept = "是";
					if(!workOrder.getAssignDeptFlow().equals(GlobalContext.getCurrentUser().getDeptFlow())){
						thisDept = "否";
						dataMap.put("assignDeptName", StringUtil.defaultString(workOrder.getAssignDeptName()+"："));
					}		
					dataMap.put("thisDept", thisDept);
					dataMap.put("assignUserName", StringUtil.defaultString(workOrder.getAssignUserName()));
									
					String path = "/jsp/erp/print/workOrder.docx";
					ServletContext context =  request.getServletContext();
					String watermark = GeneralMethod.getWatermark(GlobalConstant.FLAG_N);
					WordprocessingMLPackage temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
					if(temeplete!=null){
						response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
						String name = fileName+"（单号："+workOrder.getWorkNo()+"）"+".docx";
						response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
						ServletOutputStream out = response.getOutputStream ();
						(new SaveToZipFile (temeplete)).save (out);
						out.flush ();
					}
				}
			}
		}
	}
}

