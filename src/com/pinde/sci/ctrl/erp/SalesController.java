package com.pinde.sci.ctrl.erp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContactOrderBiz;
import com.pinde.sci.biz.erp.IErpContractBiz;
import com.pinde.sci.biz.erp.IErpContractProductBiz;
import com.pinde.sci.biz.erp.IErpContractUserBiz;
import com.pinde.sci.biz.erp.IErpContractUserRefBiz;
import com.pinde.sci.biz.erp.IErpCrmContractPayBalanceBiz;
import com.pinde.sci.biz.erp.IErpCustomerBiz;
import com.pinde.sci.biz.erp.IErpCustomerUserBiz;
import com.pinde.sci.biz.erp.IErpOAWorkOrderBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.erp.ContactOrderStatusEnum;
import com.pinde.sci.enums.erp.ContractStatusEnum;
import com.pinde.sci.enums.erp.DemandMatterEnum;
import com.pinde.sci.enums.erp.DemandStateEnum;
import com.pinde.sci.enums.erp.MaintainTypeEnum;
import com.pinde.sci.enums.erp.WorkOrderStatusEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.erp.ContactOrderAuditForm;
import com.pinde.sci.form.erp.ContactOrderDisposeForm;
import com.pinde.sci.form.erp.ContactOrderForm;
import com.pinde.sci.form.erp.ContactOrderTimeForm;
import com.pinde.sci.form.erp.ContactOrderTrackForm;
import com.pinde.sci.form.erp.ContactVisitForm;
import com.pinde.sci.form.erp.ContractTimeForm;
import com.pinde.sci.model.erp.ErpCrmContractExt;
import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractPayBalance;
import com.pinde.sci.model.mo.ErpCrmContractProduct;
import com.pinde.sci.model.mo.ErpCrmContractUserRef;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;
import com.pinde.sci.model.mo.ErpOaContactOrder;
import com.pinde.sci.model.mo.ErpOaWorkOrder;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("erp/sales")
public class SalesController extends GeneralController{ 
	@Autowired
	private IErpCustomerBiz customerBiz;
	@Autowired
	private IErpCustomerUserBiz customerUserBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IErpContractBiz contractBiz;
	@Autowired
	private IUserBiz sysUserBiz;
	@Autowired
	private IErpContractProductBiz productBiz;
	@Autowired
	private IErpContactOrderBiz contactOrderBiz;
	@Autowired
	private IErpCustomerBiz erpCustomerBiz;
	@Autowired
	private IErpCrmContractPayBalanceBiz payBalanceBiz;
	@Autowired
	private IErpContractUserRefBiz contractUserRefBiz;
	@Autowired
	private IErpContractUserBiz contractUserBiz;
	@Autowired
	private IErpOAWorkOrderBiz workOrderBiz;
	
	/**
	 * 工作联系单列表
	 * @param customerFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/contactOrderList/{userListScope}")
	public String contactOrderList(@PathVariable String userListScope,ErpOaContactOrder contactOrder, Integer currentPage,
			                       HttpServletRequest request,ContactOrderTimeForm orderTimeForm,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		model.addAttribute("scope", userListScope);
	    Map<String,Object> paramMap=new HashMap<String, Object>();
        if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)
        	|| GlobalConstant.BUSINESS_DEPT_FLAG.equals(userListScope)){
        	paramMap.put("deptFlow", GlobalContext.getCurrentUser().getDeptFlow());
        	List<SysUser> userList=searchOwnUser(GlobalContext.getCurrentUser().getDeptFlow());
        	model.addAttribute("userList", userList);
	    }
        if(GlobalConstant.USER_LIST_PERSONAL.equals(userListScope) 
           || GlobalConstant.MANAGER_FLAG.equals(userListScope)
           || GlobalConstant.BUSINESS_FLAG.equals(userListScope)){
        	contactOrder.setApplyUserFlow(GlobalContext.getCurrentUser().getUserFlow());
	    }
        if(GlobalConstant.USER_LIST_GLOBAL.equals(userListScope)){
        	model.addAttribute("deptList", searchOwnDept(GlobalContext.getCurrentUser().getOrgFlow()));
        	List<String> contactStatusIdList = new ArrayList<String>();
        	for(ContactOrderStatusEnum status:ContactOrderStatusEnum.values()){
        		contactStatusIdList.add(status.getId());
        	}
        	/*contactStatusIdList.add(ContactOrderStatusEnum.Submit.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.SalePassed.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.BusinessPassed.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.ManagerAuditing.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.ManagerPassed.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.Received.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.Implementing.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.Implemented.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.ReturnVisited.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.Closed.getId());*/
        	paramMap.put("contactStatusIdList", contactStatusIdList);
        	List<String> contactStatusNameNotList = new ArrayList<String>();
        	contactStatusNameNotList.add(ContactOrderStatusEnum.Save.getName());
        	paramMap.put("contactStatusNameNotList", contactStatusNameNotList);
        }
	    paramMap.put("contactOrder", contactOrder);
	    paramMap.put("orderTimeForm",orderTimeForm);
	    PageHelper.startPage(currentPage, getPageSize(request));
		List<ErpOaContactOrder> contactOrderList=this.contactOrderBiz.searchContactOrderList(paramMap);
	    model.addAttribute("contactOrderList", contactOrderList);
		return "erp/sales/contactOrder/list";
	}
	
	/**
	 * 编辑工作联系单
	 * @param customerFlow
	 * @param model
	 * @return
	 * @throws DocumentException 
	 */
	@RequestMapping(value="/editContactOrder")
	public String editContactOrder(String contactFlow,String type,Model model) throws DocumentException{
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		model.addAttribute("contactOrder", contactOrder);
		if(contactOrder!=null){
			Map<String,String> userCategoryMap=this.contractUserBiz.searchUserCategoryMap(contactOrder.getContractFlow());
			model.addAttribute("userCategoryMap", userCategoryMap);
			ContactOrderForm form=this.contactOrderBiz.xmlToContactOrder(contactOrder.getContactContent());
		    model.addAttribute("contactOrderForm", form);
		    //查询该客户的所有合同
		    List<ErpCrmContract> contractList=searchContractJson(contactOrder.getCustomerFlow());
		    model.addAttribute("contractList", contractList);
		    //查询该客户的联系人
		    ErpCrmCustomerUser customerUser=new ErpCrmCustomerUser();
		    customerUser.setCustomerFlow(contactOrder.getCustomerFlow());
		    List<ErpCrmCustomerUser> customerUserList=this.customerUserBiz.searchCustomerUserList(customerUser);
		    model.addAttribute("customerUserList", customerUserList);
		    //查询合同产品
		    if(StringUtil.isNotBlank(contactOrder.getContractFlow())){
		    	 ErpCrmContractProduct product=new ErpCrmContractProduct();
			     product.setContractFlow(contactOrder.getContractFlow());
				 List<ErpCrmContractProduct> productList=this.productBiz.searchContactProductList(product);
				 model.addAttribute("productList", productList);
		    }
		    //拆分服务类型和产品名称
		    String [] serviceTypeArray=contactOrder.getServiceTypeId().split(",");
		    List<String> serviceTypeList=Arrays.asList(serviceTypeArray);
		    model.addAttribute("serviceTypeList", serviceTypeList);
		    if(StringUtil.isNotBlank(contactOrder.getProductTypeId()) && StringUtil.isNotBlank(contactOrder.getProductTypeName())){
		    	 String [] productTypeIdArray =contactOrder.getProductTypeId().split(",");
				 String [] productTypeNameArray =contactOrder.getProductTypeName().split("、");
				 List<String> productTypeNameList=new ArrayList<String>();
				 List<String> productNameList=new ArrayList<String>();
				 Map<String,Object> checkMap=new HashMap<String, Object>();
				 for(int i = 0 ; i<productTypeIdArray.length ;i++){
					 productNameList.add(productTypeNameArray[i]);
					 if(GlobalConstant.FLAG_N.equals(productTypeIdArray[i])){
						 productTypeNameList.add(productTypeNameArray[i]);
					 }else{
						 checkMap.put(productTypeIdArray[i], productTypeNameArray[i]);
					 }
				 }
				 model.addAttribute("productTypeNameList", productTypeNameList);
				 model.addAttribute("checkMap", checkMap);
				 model.addAttribute("productNameList", productNameList);
		    }
		}
		if(StringUtil.isNotBlank(GlobalContext.getCurrentUser().getDeptFlow())){
			SysUser sysUser=new SysUser();
			sysUser.setDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
			sysUser.setStatusId(UserStatusEnum.Activated.getId());
			List<SysUser> userList=this.sysUserBiz.searchUser(sysUser);
	        model.addAttribute("userList", userList);
		}
	    return "erp/sales/contactOrder/edit";
	}
	/**
	 * 联系单详情页面
	 * @param contactFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/contactOrderInfo")
	public String contactOrderInfo(String contactFlow,Model model){
		model.addAttribute("contactFlow", contactFlow);
		return "erp/sales/audit/detailInfo";
	}
	@RequestMapping(value="/contactInfo")
	public String contactInfo(String contactFlow,Model model){
		model.addAttribute("contactFlow", contactFlow);
		return "erp/sales/contactOrder/info";
	}
	/**
	 * 保存工作联系单
	 * @param contactOrder
	 * @param form
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveContactOrder")
	@ResponseBody
	public String saveContactOrder(@RequestBody ContactOrderForm form) throws Exception{
		String contactStatusName = form.getContactStatusName();
		form=replenishContactOrderForm(form);
		if(contactStatusName.equals("销售审核不通过")){
			form.getContactOrder().setContactStatusName(contactStatusName);
		}
		if(form!=null){
			if(form.getContactOrder()!=null){
				if(StringUtil.isBlank(form.getContactOrder().getContractFlow())){
					form.getContactOrder().setContractName("");
				}
				form.getContactOrder().setContactContent(this.contactOrderBiz.contactOrderToXml(form));
				ErpCrmCustomer customer=this.customerBiz.readCustomer(form.getContactOrder().getCustomerFlow());
				if(customer!=null){
					form.getContactOrder().setAliasName(customer.getAliasName());
				}
				String result=this.contactOrderBiz.saveContactOrder(form.getContactOrder());
				return result;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 设置form中需要通过枚举或者字典获取的name
	 * @param form
	 * @return
	 */
	public ContactOrderForm replenishContactOrderForm(ContactOrderForm form){
		if(form!=null){
			if(form.getContactOrder()!=null){
				//设置需求事项name
				if(StringUtil.isNotBlank(form.getContactOrder().getDemandMatterId())){
					form.getContactOrder().setDemandMatterName(DemandMatterEnum.getNameById(form.getContactOrder().getDemandMatterId()));
				}
				//设置服务类型name
				if(StringUtil.isNotBlank(form.getContactOrder().getServiceTypeId())){
					String [] serviceTypeArray=form.getContactOrder().getServiceTypeId().split(",");
					String serviceTypeNames="";
					String serviceTypeName="";
					for(int i=0;i<serviceTypeArray.length;i++){
						if("PreSalesSupport".equals(form.getContactOrder().getDemandMatterId())){
							serviceTypeName=DictTypeEnum.PreSalesSupport.getDictNameById(serviceTypeArray[i]);
						}
						if("SalesImplement".equals(form.getContactOrder().getDemandMatterId())){
							serviceTypeName=DictTypeEnum.SalesImplement.getDictNameById(serviceTypeArray[i]);
						}
						if("Service".equals(form.getContactOrder().getDemandMatterId())){
							serviceTypeName=DictTypeEnum.Service.getDictNameById(serviceTypeArray[i]);
						}
						if(i==serviceTypeArray.length-1){
							serviceTypeNames+=serviceTypeName;
						}else{
							serviceTypeNames+=serviceTypeName+"、";
						}	
					}
					form.getContactOrder().setServiceTypeName(serviceTypeNames);
				}
				//设置产品名称name
				if(StringUtil.isNotBlank(form.getContactOrder().getProductTypeId())){
					String [] productTypeArray=form.getContactOrder().getProductTypeId().split(",");
					String productTypeNames="";
					String productTypeName="";
					String productTypeIds="";
					for(int i=0;i<productTypeArray.length;i++){
						productTypeName=DictTypeEnum.ProductType.getDictNameById(productTypeArray[i]);
						if(StringUtil.isBlank(productTypeName)){
							productTypeName=productTypeArray[i];
							if(i==productTypeArray.length-1){
								productTypeIds+=GlobalConstant.FLAG_N;
							}else{
								productTypeIds+=GlobalConstant.FLAG_N+",";
							}	
						}else{
							if(i==productTypeArray.length-1){
								productTypeIds+=productTypeArray[i];
							}else{
								productTypeIds+=productTypeArray[i]+",";
							}	
						}
						if(i==productTypeArray.length-1){
							productTypeNames+=productTypeName;
						}else{
							productTypeNames+=productTypeName+"、";
						}	
					}
					form.getContactOrder().setProductTypeName(productTypeNames);
					form.getContactOrder().setProductTypeId(productTypeIds);
				}
				//设置需求状态name
				if(StringUtil.isNotBlank(form.getContactOrder().getDemandStatusId())){
					form.getContactOrder().setDemandStatusName(DemandStateEnum.getNameById(form.getContactOrder().getDemandStatusId()));
				}
				//设置工作联系单状态
				if(StringUtil.isNotBlank(form.getContactOrder().getContactStatusId())){
					form.getContactOrder().setContactStatusName(ContactOrderStatusEnum.getNameById(form.getContactOrder().getContactStatusId()));
				}else{
					form.getContactOrder().setContactStatusId(ContactOrderStatusEnum.Save.getId());
					form.getContactOrder().setContactStatusName(ContactOrderStatusEnum.Save.getName());
				}
			}
			//设置合同状态name
			if(StringUtil.isNotBlank(form.getContractStatusId())){
				form.setContractStatusName(ContractStatusEnum.getNameById(form.getContractStatusId()));
			}
		}
		
		return form;
	}
	/**
	 * 加载联系单基本信息
	 * @param contactFlow
	 * @return
	 * @throws DocumentException 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/loadContactOrderContent")
	public String loadContactOrderContent(String contactFlow,Model model) throws DocumentException{
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		model.addAttribute("contactOrder", contactOrder);
		if(contactOrder!=null){
			Map<String,String> userCategoryMap=this.contractUserBiz.searchUserCategoryMap(contactOrder.getContractFlow());
			model.addAttribute("userCategoryMap", userCategoryMap);
		}
		//判断是否显示审核记录
		int auditCount = 0;
		if(contactOrder!=null){
			String content = contactOrder.getContactContent();
		    if (StringUtil.isBlank(content)) {
		    	content = "<info/>";
		    }
		    Document dom = DocumentHelper.parseText(content);
			Element auditsElement=(Element) dom.selectSingleNode("/info/audits");
			if (auditsElement != null) {
				//销售意见/需求
				List<Element> salePassedElements = auditsElement.selectNodes("audit/auditResult[@name='"+ContactOrderStatusEnum.SalePassed.getName()+"']");
				List<Element> saleUnPassedElements = auditsElement.selectNodes("audit/auditResult[@name='"+ContactOrderStatusEnum.SaleUnPassed.getName()+"']");
				if (salePassedElements != null) {
					auditCount = salePassedElements.size();
				}
				if (saleUnPassedElements != null) {
					auditCount += saleUnPassedElements.size();
				}
			}
			ContactOrderForm form=this.contactOrderBiz.xmlToContactOrder(contactOrder.getContactContent());
			model.addAttribute("contactOrderForm", form);
		}
		model.addAttribute("auditCount", auditCount);
		return "erp/sales/contactOrder/content";
	}
	
	@RequestMapping(value="/editTrackInfo")
	public String editTrackInfo(String contactFlow,Model model){
	    return "erp/sales/audit/editTrackInfo";
	}
	
	
	@RequestMapping(value="/trackOpinionContent")
	public String trackOpinionContent(String contactFlow,Model model) throws DocumentException{
		List<ContactOrderTrackForm> trackFormList=this.contactOrderBiz.searchTrackForm(contactFlow);
		model.addAttribute("trackFormList", trackFormList);
		return "erp/sales/audit/trackOpinionContent";
	}
	
	@RequestMapping(value="/loadContactOrderAudit")
	public String loadContactOrderAudit(String contactFlow,Model model) throws DocumentException{
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		model.addAttribute("contactOrder", contactOrder);
		if(contactOrder!=null){
			//维护到期日
			ErpCrmContract erpContract=this.contractBiz.readContract(contactOrder.getContractFlow());
			model.addAttribute("erpContract", erpContract);
			ErpOaContactOrder newContactOrder=new ErpOaContactOrder();
			newContactOrder.setContractFlow(contactOrder.getContractFlow());
	    	List<ErpOaContactOrder> contactOrderList=this.contactOrderBiz.searchContactOrderList(newContactOrder, null);
		    if(contactOrderList!=null && contactOrderList.size()>1){
		    	model.addAttribute("lastContactOrder", contactOrderList.get(1));
		    }
			ContactOrderForm form=this.contactOrderBiz.xmlToContactOrder(contactOrder.getContactContent());
			//处理进度意见
		    if(ContactOrderStatusEnum.Received.getId().equals(contactOrder.getContactStatusId())){
		    	ContactOrderDisposeForm disposeForm=this.contactOrderBiz.searchDisposeForm(contactFlow);
		    	form.setDisposeForm(disposeForm);
		    }
		    model.addAttribute("contactOrderForm", form);
		    List<ContactOrderAuditForm> auditFormList=this.contactOrderBiz.searchContactOrderAuditForm(contactFlow);
		    //form.setAuditList(auditFormList);
			if(auditFormList != null && !auditFormList.isEmpty()){
				ContactOrderAuditForm auditForm = null;
				ContactOrderAuditForm businessAuditForm = null;
				ContactOrderAuditForm managerAuditForm = null;
				for(int i=auditFormList.size()-1; i>=0;i--){
					//总经理意见,
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
		}
		return "erp/sales/contactOrder/auditInfo";
	} 
	
	/**
	 * 删除工作联系单
	 * @param contactFlow
	 * @return
	 */
	@RequestMapping(value="/deleteContactOrder")
	@ResponseBody
	public String deleteContactOrder(String contactFlow){
		return this.contactOrderBiz.deleteContactOrder(contactFlow);
	}
	
	/**
	 * 提交联系单申请
	 * @param contactFlow
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/submitContactOrder")
	@ResponseBody
	public String submitContactOrder(String contactFlow) throws Exception{
		String result = null;
		ErpOaContactOrder oaContactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		if(oaContactOrder!=null){
			oaContactOrder.setContactStatusId(ContactOrderStatusEnum.Submit.getId());
			oaContactOrder.setContactStatusName(ContactOrderStatusEnum.Submit.getName());
			result=this.contactOrderBiz.submitContactOrderApply(oaContactOrder);
		}
		return result;
	}
	/**
	 * 查看工作联系单审核意见
	 * @param model
	 * @return
	 * @throws DocumentException 
	 */
	@RequestMapping(value="/contactOrderAuditOpinion")
	public String contactOrderAuditOpinion(String contactFlow,Model model) throws DocumentException{
		List<ContactOrderAuditForm> auditFormList=this.contactOrderBiz.searchContactOrderAuditForm(contactFlow);
		model.addAttribute("auditFormList", auditFormList);
		return "erp/sales/contactOrder/auditOpinion";
	}

	@RequestMapping(value="/contactOrderVisitOpinion")
	public String contactOrderVisitOpinion(String contactFlow,Model model) throws DocumentException{
		List<ContactVisitForm> visitFormList=this.contactOrderBiz.searchVisitForm(contactFlow);
		model.addAttribute("visitFormList", visitFormList);
		return "erp/sales/audit/visitOpinion";
	}
	
	@RequestMapping(value="/contactOrderTrackOpinion")
	public String contactOrderTrackOpinion(String contactFlow,Model model) throws DocumentException{
		List<ContactOrderTrackForm> trackFormList=this.contactOrderBiz.searchTrackForm(contactFlow);
		model.addAttribute("trackFormList", trackFormList);
		return "erp/sales/audit/trackOpinion";
	}
	
	/**
	 * 工作联系单审核列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/auditWorkContactList/{userListScope}")
	public String auditWorkContactList(@PathVariable String userListScope,ErpOaContactOrder contactOrder, Integer currentPage,
        HttpServletRequest request,ContactOrderTimeForm orderTimeForm,Model model){
	    setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
	    Map<String,Object> paramMap=new HashMap<String, Object>();
	    List<String> contactStatusIdList = new ArrayList<String>();
	    if(GlobalConstant.USER_LIST_PERSONAL.equals(userListScope)){
	    	contactStatusIdList.add(ContactOrderStatusEnum.Submit.getId());
	    	paramMap.put("deptFlow", GlobalContext.getCurrentUser().getDeptFlow());
	    }
        if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){
        	contactStatusIdList.add(ContactOrderStatusEnum.SalePassed.getId());
        	//contactStatusIdList.add(ContactOrderStatusEnum.Implemented.getId());
        	contactStatusIdList.add(ContactOrderStatusEnum.ReturnVisited.getId());
	    }
        if(GlobalConstant.USER_LIST_GLOBAL.equals(userListScope)){
        	contactStatusIdList.add(ContactOrderStatusEnum.ManagerAuditing.getId());
	    }
        paramMap.put("contactStatusIdList", contactStatusIdList);
	    paramMap.put("contactOrder", contactOrder);
	    paramMap.put("orderTimeForm",orderTimeForm);
	    PageHelper.startPage(currentPage, getPageSize(request));
		List<ErpOaContactOrder> contactOrderList=this.contactOrderBiz.searchContactOrderList(paramMap);
	    model.addAttribute("contactOrderList", contactOrderList);
		return "erp/sales/audit/workContactList";
	}
	
	/**
	 * 联系单回访列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/returnBackContactList/{userListScope}")
	public String returnBackContactList(@PathVariable String userListScope,ErpOaContactOrder contactOrder, Integer currentPage,
        HttpServletRequest request,ContactOrderTimeForm orderTimeForm,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
	    Map<String,Object> paramMap=new HashMap<String, Object>();
	    if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){
	    	contactOrder.setApplyDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
	    }
	    List<String> contactStatusIdList = new ArrayList<String>();
	    contactStatusIdList.add(ContactOrderStatusEnum.Implementing.getId());
        contactStatusIdList.add(ContactOrderStatusEnum.Implemented.getId());
        contactStatusIdList.add(ContactOrderStatusEnum.ReturnVisited.getId());
        contactStatusIdList.add(ContactOrderStatusEnum.Closed.getId());
        paramMap.put("contactStatusIdList", contactStatusIdList);
	    paramMap.put("contactOrder", contactOrder);
	    paramMap.put("orderTimeForm",orderTimeForm);
	    PageHelper.startPage(currentPage, getPageSize(request));
		List<ErpOaContactOrder> contactOrderList=this.contactOrderBiz.searchContactOrderList(paramMap);
	    model.addAttribute("contactOrderList", contactOrderList);
		return "erp/sales/audit/returnVisitContactList";
	}
	
	/**
	 * 联系单质控列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/trackContactList")
	public String trackContactList(ErpOaContactOrder contactOrder, Integer currentPage,
        HttpServletRequest request,ContactOrderTimeForm orderTimeForm,Model model){
	    Map<String,Object> paramMap=new HashMap<String, Object>();
	    List<String> contactStatusIdList = new ArrayList<String>();
        contactStatusIdList.add(ContactOrderStatusEnum.Implementing.getId());
        contactStatusIdList.add(ContactOrderStatusEnum.Implemented.getId());
        contactStatusIdList.add(ContactOrderStatusEnum.ReturnVisited.getId());
        paramMap.put("contactStatusIdList", contactStatusIdList);
	    paramMap.put("contactOrder", contactOrder);
	    paramMap.put("orderTimeForm",orderTimeForm);
	    PageHelper.startPage(currentPage, getPageSize(request));
		List<ErpOaContactOrder> contactOrderList=this.contactOrderBiz.searchContactOrderList(paramMap);
	    model.addAttribute("contactOrderList", contactOrderList);
		return "erp/sales/audit/returnVisitContactList";
	}
	/**
	 * 跳转到联系单回访页面
	 * @param contactFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/returnVisitContact")
	public String returnVisitContact(String contactFlow,Model model){
		return "erp/sales/audit/detailInfo";
	}
	
	/**
	 * 跳转到联系单跟踪页面
	 * @param contactFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/trackContact")
	public String trackContact(String contactFlow,Model model){
		return "erp/sales/audit/detailInfo";
	}
	
	/**
	 * 加载联系单回访信息
	 * @param contactFlow
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/editVisitInfo")
	public String editVisitInfo(String contactFlow,Model model) throws Exception{
		//查询回访记录
		List<ContactVisitForm> visitFormList=this.contactOrderBiz.searchVisitForm(contactFlow);
		model.addAttribute("visitFormList", visitFormList);
		List<String> userFlowList=new ArrayList<String>();
		//查询联系单和派工单中的联系人
		List<ErpCrmCustomerUser> userList=new ArrayList<ErpCrmCustomerUser>();
		ErpOaContactOrder contact=this.contactOrderBiz.readContactOrder(contactFlow);
		if(contact!=null){
			//查询联系单联系人
			ContactOrderForm contactOrderForm=this.contactOrderBiz.xmlToContactOrder(contact.getContactContent());
		    if(contactOrderForm!=null){
		    	ErpCrmCustomerUser user=this.customerUserBiz.readCustomerUser(contactOrderForm.getUserFlow());
		    	if(user!=null){
		    		userList.add(user);
		    		userFlowList.add(user.getUserFlow());
		    	}
		    }
		}
		ErpOaWorkOrder workOrder=new ErpOaWorkOrder();
		workOrder.setContactFlow(contactFlow);
		List<ErpOaWorkOrder> workOrderList=this.workOrderBiz.searchWorkOrderList(workOrder);
		//查询该联系单下所有派工单联系人
		List<ErpCrmCustomerUser> workUserList=null;
		if(workOrderList!=null && !workOrderList.isEmpty()){
			for(ErpOaWorkOrder work:workOrderList){
				workUserList=this.workOrderBiz.parseWorkOrderFromXML(work).getCustomerUserList();
				if(workUserList!=null && workUserList.isEmpty()){
					for(ErpCrmCustomerUser user:workUserList){
						if(!userFlowList.contains(user.getUserFlow())){
							userFlowList.add(user.getUserFlow());
							userList.add(user);
						}
					}
				}
			}
		}
	    model.addAttribute("userList", userList);
		return "erp/sales/audit/editVisitInfo";
	}
	
	@RequestMapping(value="/saveVisitInfo")
	@ResponseBody
	public String saveVisitInfo(String contactFlow,ContactVisitForm visitForm,Model model) throws Exception{
		String result = null;
		if(StringUtil.isNotBlank(contactFlow)){
			ErpOaContactOrder contact=this.contactOrderBiz.readContactOrder(contactFlow);
			List<ContactVisitForm> formList=this.contactOrderBiz.searchVisitForm(contactFlow);
			if((formList!=null && formList.isEmpty()) 
			   || (!ContactOrderStatusEnum.ReturnVisited.getId().equals(contact.getContactStatusId()) 
				   && !ContactOrderStatusEnum.Closed.getId().equals(contact.getContactStatusId()))){
				contact.setContactStatusId(ContactOrderStatusEnum.ReturnVisited.getId());
				contact.setContactStatusName(ContactOrderStatusEnum.ReturnVisited.getName());
			}
		    ErpCrmCustomerUser user=this.customerUserBiz.readCustomerUser(visitForm.getCustomerLinkManFlow());
		    if(user!=null){
		    	visitForm.setCustomerLinkMan(user.getUserName());
		    }
			String content=this.contactOrderBiz.contactVisitFormToXml(visitForm, contactFlow);
			if(contact!=null){
				contact.setContactContent(content);
			}
			result=this.contactOrderBiz.saveVisitResult(contact);
		}
		return result;
	}
	
	@RequestMapping(value="/saveTrackInfo")
	@ResponseBody
	public String saveTrackInfo(String contactFlow,ContactOrderTrackForm trackForm,Model model) throws Exception{
		String result = null;
		if(StringUtil.isNotBlank(contactFlow)){
			ErpOaContactOrder contact=this.contactOrderBiz.readContactOrder(contactFlow);
			String content=this.contactOrderBiz.contactTrackFormToXml(trackForm, contactFlow);
			if(contact!=null){
				contact.setContactContent(content);
			}
			result=this.contactOrderBiz.saveTrackResult(contact);
		}
		return result;
	}
	
	/**
	 * 工作联系单审核	
	 * @param model
	 * @return
	 * @throws DocumentException 
	 */
	@RequestMapping(value="/auditWorkContact")
	public String auditWorkContact(String contactFlow,Model model) throws DocumentException{
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		if(contactOrder!=null){
			ContactOrderForm form=this.contactOrderBiz.xmlToContactOrder(contactOrder.getContactContent());
			model.addAttribute("contactOrderForm", form);
			
			List<ContactOrderAuditForm> auditFormList=this.contactOrderBiz.searchContactOrderAuditForm(contactFlow);
			//form.setAuditList(auditFormList);
			if(auditFormList != null && !auditFormList.isEmpty()){
				ContactOrderAuditForm auditForm = null;
				ContactOrderAuditForm businessAuditForm = null;
				for(int i=auditFormList.size()-1; i>=0;i--){
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
		    	for(int i = 0; i < contactOrderList.size(); i++){
		    		if(contactOrderList.get(i).getContactFlow().equals(contactFlow) && i!=contactOrderList.size()-1){
		    			if(null != contactOrderList.get(i+1)){
		    				model.addAttribute("lastContactOrder", contactOrderList.get(i+1));
		    			}
		    		}
		    	}
		    }
		    model.addAttribute("erpContract", erpContract);
		    model.addAttribute("contactOrder", contactOrder);
		 }
		    SysUser user=this.sysUserBiz.readSysUser(contactOrder.getApplyUserFlow());
		    if(user!=null){
		    	SysDept dept=this.deptBiz.readSysDept(user.getDeptFlow());
				model.addAttribute("dept", dept);
		    }
		    return "erp/sales/audit/auditWorkContact";
	}
	
	@RequestMapping(value="/historyContact")
	public String historyContact(String contactFlow,Model model){
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		if(contactOrder!=null){
			String customerFlow=contactOrder.getCustomerFlow();
			ErpOaContactOrder contact=new ErpOaContactOrder();
			contact.setCustomerFlow(customerFlow);
			contact.setContactStatusId(ContactOrderStatusEnum.Save.getId());
			List<ErpOaContactOrder> contactOrderList=this.contactOrderBiz.searchHistoryContactOrderList(contact,null);
			model.addAttribute("contactOrderList", contactOrderList);
		}
		return "erp/sales/contactOrder/historyContactList";
	}
	
	/**
	 * 末次工作联系单详情
	 * @return
	 */
	@RequestMapping(value="/lastContactOrder")
	public String lastContactOrder(){
		return "erp/sales/audit/detailInfo";
	}
	
	@RequestMapping(value="/saveContactOrderAudit")
	@ResponseBody
	public String saveContactOrderAudit(String status,String contactFlow,ContactOrderAuditForm form) throws Exception{
		    String scope=(String) GlobalContext.getSessionAttribute(GlobalConstant.USER_LIST_SCOPE);
			if(GlobalConstant.MANAGER_FLAG.equals(GlobalContext.getSessionAttribute(GlobalConstant.USER_LIST_SCOPE))){
				scope=GlobalConstant.USER_LIST_GLOBAL;
			}
			if(GlobalConstant.BUSINESS_FLAG.equals(GlobalContext.getSessionAttribute(GlobalConstant.USER_LIST_SCOPE))
				|| GlobalConstant.BUSINESS_DEPT_FLAG.equals(GlobalContext.getSessionAttribute(GlobalConstant.USER_LIST_SCOPE))){
				scope=GlobalConstant.USER_LIST_LOCAL;
			}
		    ErpOaContactOrder oaContactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
			if(oaContactOrder!=null){
		    	form.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		    	form.setUserName(GlobalContext.getCurrentUser().getUserName());
		    	form.setAuditDate(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
		    }
		return this.contactOrderBiz.saveContactApplyAudit(oaContactOrder,form,status,scope);
	}
	/**
	 * 查询该联系单合同维护到期日是否为空
	 * @param contactFlow
	 * @return
	 */
	@RequestMapping(value="/checkContractMaintainDueDate")
	@ResponseBody
	public ErpCrmContract checkContractMaintainDueDate(String contactFlow){
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		if(contactOrder!=null){
			String contractFlow=contactOrder.getContractFlow();
			if(StringUtil.isNotBlank(contractFlow)){
				ErpCrmContract contract=this.contractBiz.readContract(contractFlow);
				return contract;
			}
		}
		return null;
	}
	/**
	 * 跳转到选择维护到期日界面
	 * @param contactFlow
	 * @return
	 */
	@RequestMapping(value="/computeMaintainDueDate")
	public String computeMaintainDueDate(String contactFlow, Model model){
		if(StringUtil.isNotBlank(contactFlow)){
			 ErpOaContactOrder contactOrder = contactOrderBiz.readContactOrder(contactFlow);
			 model.addAttribute("contactOrder", contactOrder);
		}
		return "erp/sales/contactOrder/computeMaintainDueDate";
	}
	
	
	/**
	 * 修改维护到期日
	 * @param contactFlow
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/modifyMaintainDueDate")
	@ResponseBody
	public String modifyMaintainDueDate(String contractFlow,String contactFlow, String maintainDueDate, Model model) throws Exception{
		if(StringUtil.isNotBlank(contractFlow)){
			ErpCrmContract contract = new ErpCrmContract();
			contract.setContractFlow(contractFlow);
			contract.setMaintainDueDate(maintainDueDate);
			String result = contractBiz.saveContract(contract, null);
			if(!GlobalConstant.SAVE_FAIL.equals(result)){
				result = closeContactOrder(contactFlow);
				if(!GlobalConstant.SAVE_FAIL.equals(result)){
					return GlobalConstant.OPRE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 撤回工作联系单
	 * @param contactFlow
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/recall")
	@ResponseBody
	public String recall(String contactFlow) throws Exception{
		String result=null;
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		if(contactOrder!=null){
			contactOrder.setContactStatusId(ContactOrderStatusEnum.Implementing.getId());
			contactOrder.setContactStatusName(ContactOrderStatusEnum.Implementing.getName());
		    contactOrder.setCompleteTime("");
			result=this.contactOrderBiz.recallContact(contactOrder);
		}
		return result;
	}
	@RequestMapping(value="/closeContact")
	@ResponseBody
	public String closeContact(String contactFlow) throws Exception{
		ErpOaContactOrder contactOrder=this.contactOrderBiz.readContactOrder(contactFlow);
		if(contactOrder!=null){
			//查询联系单下是否有未完成的派工单
			ErpOaWorkOrder searchWork=new ErpOaWorkOrder();
			searchWork.setContactFlow(contactFlow);
			List<ErpOaWorkOrder> workList=this.workOrderBiz.searchWorkOrderList(searchWork);
			String completeFlag=GlobalConstant.FLAG_Y;
			if(workList!=null && workList.size()>1){
				for(ErpOaWorkOrder work: workList){
					if(!work.getWorkStatusId().equals(WorkOrderStatusEnum.Passed.getId())){
						completeFlag=GlobalConstant.FLAG_N;
						return completeFlag;
					}
				}
			}
            contactOrder.setCompleteTime(DateUtil.getCurrDateTime("yyyy-MM-dd HH:mm"));
            contactOrder.setContactStatusId(ContactOrderStatusEnum.Implemented.getId());
            contactOrder.setContactStatusName(ContactOrderStatusEnum.Implemented.getName());
            return this.contactOrderBiz.closeContactOrder(contactOrder);
		}
		return GlobalConstant.OPRE_SUCCESSED;
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
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		List<SysDept> deptList=this.deptBiz.searchDept(dept);
		return deptList;
	}
	//*******************************************************
	
	
	/**
	 * 开票申请
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/contractList")
	public String billContractList(ErpCrmCustomer customer, ErpCrmContract contract, ContractTimeForm timeForm, Integer currentPage, Model model){
		SysDept dept=new SysDept();
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		List<SysDept> deptList = deptBiz.searchDept(dept);
		model.addAttribute("deptList", deptList);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("customer", customer);
		paramMap.put("contract", contract);
		if(StringUtil.isNotBlank(timeForm.getSignDateStart())){
			paramMap.put("signDateStart", timeForm.getSignDateStart());
		}
		if(StringUtil.isNotBlank(timeForm.getSignDateEnd())){
			paramMap.put("signDateEnd", timeForm.getSignDateEnd());
		}
		if(StringUtil.isNotBlank(timeForm.getMaintainDueDateStart())){
			paramMap.put("maintainDueDateStart", timeForm.getMaintainDueDateStart());
		}
		if(StringUtil.isNotBlank(timeForm.getMaintainDueDateEnd())){
			paramMap.put("maintainDueDateEnd", timeForm.getMaintainDueDateEnd());
		}
		if(StringUtil.isNotBlank(timeForm.getContractDueDateStart())){
			paramMap.put("contractDueDateStart", timeForm.getContractDueDateStart());
		}
		if(StringUtil.isNotBlank(timeForm.getContractDueDateEnd())){
			paramMap.put("contractDueDateEnd", timeForm.getContractDueDateEnd());
		}
		PageHelper.startPage(currentPage, GlobalConstant.DEFAULT_PAGE_SIZE);
		List<ErpCrmContractExt> contractListExt = contractBiz.searchErpContractListByCondition(paramMap);
		model.addAttribute("contractListExt", contractListExt);
		return "erp/sales/bill/contractList";
	}
	
	/**
	 * 开票
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/billList")
	public String billList(String contractFlow, Model model){
		return "erp/sales/bill/list";
	}
		
	@RequestMapping(value="/editBill")
	public String editBill(Model model){
		return "erp/sales/bill/edit";
	} 
		
	@RequestMapping(value="/billInfo")
	public String billInfo(Model model){
		return "erp/sales/bill/billInfo";
	}
		
	@RequestMapping(value="/auditOpinion")
	public String auditOpinion(Model model){
		return "erp/sales/bill/auditOpinion";
	}
	
	/**
	 * 新增到账
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addIn")
	public String addIn(Model model){
		return "erp/sales/bill/addIn";
	} 
	
	/**
	 * 保存到账
	 * @param balance
	 * @return
	 */
	@RequestMapping(value="/saveBalance")
	@ResponseBody
	public String saveBalance(ErpCrmContractPayBalance balance){
		int result = payBalanceBiz.saveBalance(balance);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	} 
	
	
	/**
	 * 关单
	 * @param contactFlow
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/closeContactOrder")
	@ResponseBody
	public String closeContactOrder(String contactFlow) throws Exception{
		return contactOrderBiz.closeContactAndWorkOrder(contactFlow);
	} 
	
	/**
	 * 查询客户的所有合同信息,联系单专用
	 * @return
	 */
	@RequestMapping(value="/searchContractJson")
	@ResponseBody
	public List<ErpCrmContract> searchContractJson(String customerFlow){
		SysUser currUser=GlobalContext.getCurrentUser();
		ErpCrmContract contract = new ErpCrmContract();
		contract.setCustomerFlow(customerFlow);
		//判断是部门联系单还是我的联系单
		String userListScope=(String) GlobalContext.getSessionAttribute(GlobalConstant.USER_LIST_SCOPE);
		if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){
			contract.setSignDeptFlow(currUser.getDeptFlow());
			//查询本部门人员信息
			/*SysUser sysUser=new SysUser();
			sysUser.setDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
			sysUser.setStatusId(UserStatusEnum.Activated.getId());
			List<SysUser> userList=this.sysUserBiz.searchUser(sysUser);*/
			/*List<String> userFlowList=new ArrayList<String>();
			if(userList!=null && !userList.isEmpty()){
				for(SysUser user:userList){
					userFlowList.add(user.getUserFlow());
				}
			}*/
			List<ErpCrmContract> contractList=this.contractBiz.searchErpContracts(contract);
			/*List<ErpCrmContract> contracts=new ArrayList<ErpCrmContract>();*/
			/*if(contractList!=null && !contractList.isEmpty()){
				for(ErpCrmContract erpCrmContract:contractList){
					if(userFlowList.contains(erpCrmContract.getChargeUserFlow())){
						contracts.add(erpCrmContract);
					}
				}
			}*/
			return contractList;
		}else if(GlobalConstant.USER_LIST_PERSONAL.equals(userListScope)){
			contract.setChargeUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			return this.contractBiz.searchErpContractList(contract);
		}else if(GlobalConstant.MANAGER_FLAG.equals(userListScope)
				|| GlobalConstant.BUSINESS_FLAG.equals(userListScope)
				|| GlobalConstant.BUSINESS_DEPT_FLAG.equals(userListScope)){
			return this.contractBiz.searchErpContractList(contract);
		}
		return null;
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
	
	/**
	 * 查询客户的所有联系人信息
	 * @param customerFlow
	 * @return
	 */
	@RequestMapping(value="/searchCustomerUserJson")
	@ResponseBody
	public Map<String,Object> searchCustomerUserJson(String customerFlow,String contractFlow){
		Map<String,Object> map = new HashMap<String, Object>();
		List<ErpCrmCustomerUser> customerUserList = null;
		if(StringUtil.isNotBlank(customerFlow)){
			ErpCrmCustomerUser user = new ErpCrmCustomerUser();
			user.setCustomerFlow(customerFlow);
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			customerUserList =  customerUserBiz.searchCustomerUserList(user);
			map.put("customerUserList", customerUserList);
			if(StringUtil.isNotBlank(contractFlow)){
				Map<String,String> userCategoryMap=this.contractUserBiz.searchUserCategoryMap(contractFlow);
				map.put("userCategoryMap",userCategoryMap);
			}
		}
		return map;
	}
	
	@RequestMapping(value="/demandResponseList/{userListScope}")
	public String searchDemandResponseList(@PathVariable String userListScope,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		return "erp/sales/response/list";
	}
	
	@RequestMapping(value="/editResponse")
	public String editResponse(String responseFlow,Model model){
		
		return "erp/sales/response/edit";
	}
}

