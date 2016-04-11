package com.pinde.sci.ctrl.erp;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractBiz;
import com.pinde.sci.biz.erp.IErpContractPayPlanBiz;
import com.pinde.sci.biz.erp.IErpContractProductBiz;
import com.pinde.sci.biz.erp.IErpContractRefBiz;
import com.pinde.sci.biz.erp.IErpContractUserBiz;
import com.pinde.sci.biz.erp.IErpContractUserRefBiz;
import com.pinde.sci.biz.erp.IErpCustomerBiz;
import com.pinde.sci.biz.erp.IErpCustomerUserBiz;
import com.pinde.sci.biz.erp.IErpUserRegionPopedomBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.erp.CompanyNameEnum;
import com.pinde.sci.enums.erp.ContractCategoryEnum;
import com.pinde.sci.enums.erp.ContractStatusEnum;
import com.pinde.sci.enums.erp.ContractTypeEnum;
import com.pinde.sci.enums.erp.CustomerTypeEnum;
import com.pinde.sci.enums.erp.UserCategoryEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.erp.ContractForm;
import com.pinde.sci.form.erp.ContractTimeForm;
import com.pinde.sci.form.erp.CustomerUserForm;
import com.pinde.sci.model.erp.ErpCrmContractExt;
import com.pinde.sci.model.erp.ErpCrmContractRefExt;
import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractPayPlan;
import com.pinde.sci.model.mo.ErpCrmContractProduct;
import com.pinde.sci.model.mo.ErpCrmContractRef;
import com.pinde.sci.model.mo.ErpCrmContractUser;
import com.pinde.sci.model.mo.ErpCrmContractUserRef;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;
import com.pinde.sci.model.mo.ErpUserRegionPopedom;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("erp/crm")
public class CrmController extends GeneralController{ 
	@Autowired
	private IErpCustomerBiz customerBiz;
	@Autowired
	private IErpCustomerUserBiz customerUserBiz;
	@Autowired
	private IErpContractBiz contractBiz;
	@Autowired
	private IErpContractProductBiz productBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IErpContractPayPlanBiz payPlanBiz;
	@Autowired
	private IErpContractRefBiz refBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IUserBiz sysUserBiz;
	@Autowired
	private IErpContractUserBiz contractUserBiz;
	@Autowired
	private IErpContractUserRefBiz userRefBiz;
	@Autowired
	private IErpUserRegionPopedomBiz popedomBiz;
	
	/**
	 * 跳转至编辑客户页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addCustomer/{userListScope}")
	public String addCustomer(@PathVariable String userListScope,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		SysUser user = GlobalContext.getCurrentUser();
		List<ErpUserRegionPopedom> erpUserRegionPopedomList = userRoleBiz.getErpUserRegionByUserFlow(user.getUserFlow());
		model.addAttribute("erpUserRegionPopedomList", erpUserRegionPopedomList);
		return "erp/crm/customer/add";
	}
	
	/**
	 * 保存客户及联系人
	 * @param jsondata
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveCustomerAndUser")
	@ResponseBody
	public String saveCustomerAndUser(@RequestBody CustomerUserForm form){
		int result = customerBiz.saveCustomerAndUser(form);
		if(result != GlobalConstant.ZERO_LINE){
			return form.getCustomer().getCustomerFlow();
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 客户查询
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/searchCustomer/{userListScope}")
	public String searchCustomer(@PathVariable String userListScope,ErpCrmCustomer customer,String bigRegionValue, Integer currentPage, String checkedFlow,String hosGradeFlag,HttpServletRequest request,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		model.addAttribute("checkedFlow", checkedFlow);
		SysUser currUser = GlobalContext.getCurrentUser();
		//医院类型
		List<String> hospitalTypeIdList = new ArrayList<String>();
		if(StringUtil.isNotBlank(customer.getHospitalTypeId())){
			String[] typeIds = customer.getHospitalTypeId().split(",");
			hospitalTypeIdList = Arrays.asList(typeIds);
			model.addAttribute("hospitalTypeIdList", hospitalTypeIdList);
			//重新组织医院类型
			if (typeIds != null && typeIds.length >0) {
				String hospitalTypeId = "";
				for (int i=0;i<typeIds.length;i++) {
					hospitalTypeId += "%" + typeIds[i] + "%";
				}
				customer.setHospitalTypeId(hospitalTypeId);
			}
		}
		PageHelper.startPage(currentPage, getPageSize(request));
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("customer", customer);
		paramMap.put("currUser", currUser);
		paramMap.put("userListScope", userListScope);
		paramMap.put("bigRegionValue", bigRegionValue);
		paramMap.put("hosGradeFlag", StringUtil.defaultString(hosGradeFlag));
		List<ErpCrmCustomer> customerList = customerBiz.searchCustomerList(paramMap);
		model.addAttribute("customerList", customerList);
		
		List<ErpUserRegionPopedom> erpUserRegionPopedomList = userRoleBiz.getErpUserRegionByUserFlow(currUser.getUserFlow());
		model.addAttribute("erpUserRegionPopedomList", erpUserRegionPopedomList);
		return "erp/crm/customer/list";
	}
	
	/**
	 * 保存客户备注
	 * @param customer
	 * @return
	 */
	@RequestMapping(value="/modCustomerRemark")
	@ResponseBody
	public String modCustomerRemark(ErpCrmCustomer customer){
		int result = customerBiz.saveCustomer(customer);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 查看客户信息
	 */
	@RequestMapping(value="/customerInfo")
	public String customerInfo(){
		return "erp/crm/customer/view";
	}
	
	/**
	 * 加载客户
	 * @param customerFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/customer")
	public String customer(String customerFlow, Model model){
		if(StringUtil.isNotBlank(customerFlow)){
			ErpCrmCustomer customer = customerBiz.readCustomer(customerFlow);
			model.addAttribute("customer", customer);
		}
		return "erp/crm/customer/customer";
	}
	
	/**
	 * 加载联系人信息
	 */
	@RequestMapping(value="/customerUserList")
	public String customerUserList(ErpCrmCustomerUser customerUser, Model model){
		if(StringUtil.isNotBlank(customerUser.getCustomerFlow())){
			List<ErpCrmCustomerUser> customerUserList =  customerUserBiz.searchCustomerUserList(customerUser);
			model.addAttribute("customerUserList", customerUserList);
			//技服只能编辑人员类别为“技术负责人”的联系人
			if (GlobalConstant.USER_LIST_PERSONAL.equals(getSessionAttribute(GlobalConstant.USER_LIST_SCOPE))) {
				Map<String,Boolean> userCategoryMap = new HashMap<String,Boolean>();
				ErpCrmContractUser temp = new ErpCrmContractUser();
				if (customerUserList != null && customerUserList.size() >0) {
					for (ErpCrmCustomerUser user:customerUserList) {
						temp.setUserFlow(user.getUserFlow());
						temp.setUserCategoryId(UserCategoryEnum.Technical.getId());
						List<ErpCrmContractUser> userList = contractUserBiz.searchContractUserList(temp);
						if (userList != null && userList.size() > 0) {
							userCategoryMap.put(user.getUserFlow(), true);
						} else {
							userCategoryMap.put(user.getUserFlow(), false);
						}
					}
				}
				model.addAttribute("userCategoryMap", userCategoryMap);
			}
		}
		return "erp/crm/customer/customerUser";
	}
	
	/**
	 * 跳转至编辑客户信息
	 * @param customerFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editCustomer")
	public String editCustomer(String customerFlow, Model model){
		if(StringUtil.isNotBlank(customerFlow)){
			ErpCrmCustomer customer = customerBiz.readCustomer(customerFlow);
			if(customer != null && StringUtil.isNotBlank(customer.getHospitalTypeId())){
				String hospitalTypeId = customer.getHospitalTypeId();
				String[] hospitalTypeIds = hospitalTypeId.split(",");
				List<String> hospitalTypeIdList = Arrays.asList(hospitalTypeIds);
				model.addAttribute("hospitalTypeIdList", hospitalTypeIdList);
			}
			model.addAttribute("customer", customer);

			SysUser user = GlobalContext.getCurrentUser();
			List<ErpUserRegionPopedom> erpUserRegionPopedomList = userRoleBiz.getErpUserRegionByUserFlow(user.getUserFlow());
			model.addAttribute("erpUserRegionPopedomList", erpUserRegionPopedomList);
		}
		return "erp/crm/customer/editCustomer";
	}
	
	/**
	 * 跳转至编辑联系人信息列表
	 * @param customerFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editCustomerUserList")
	public String editCustomerUserList(String customerFlow, Model model){
		if(StringUtil.isNotBlank(customerFlow)){
			ErpCrmCustomerUser customerUser = new ErpCrmCustomerUser();
			customerUser.setCustomerFlow(customerFlow);
			customerUser.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<ErpCrmCustomerUser> customerUserList =  customerUserBiz.searchCustomerUserList(customerUser);
			model.addAttribute("customerUserList", customerUserList);
		}
		model.addAttribute("customerFlow", customerFlow);
		return "erp/crm/customer/editCustomerUserList";
	}
	
	/**
	 * 保存客户
	 * @param customer
	 * @return
	 */
	@RequestMapping(value="/saveCustomer")
	@ResponseBody
	public String saveCustomer(ErpCrmCustomer customer){
		int result = customerBiz.EditCustomer(customer);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 保存联系人列表
	 * @param form
	 * @param customerFlow
	 * @return
	 */
	@RequestMapping(value="/saveCustomerUserList")
	@ResponseBody
	public String saveCustomerUserList(@RequestBody CustomerUserForm form, String customerFlow){
		List<ErpCrmCustomerUser> userList = form.getCustomerUserList();
		int result = customerUserBiz.saveCustomerUserList(userList, customerFlow);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 校验客户联系人姓名重复问题
	 * @param customerUser
	 * @return
	 */
	@RequestMapping(value="/customerUserNameConfirm")
	@ResponseBody
	public String customerUserNameConfirm(ErpCrmCustomerUser user){
		String customerFlow = user.getCustomerFlow();
		List<ErpCrmCustomerUser> userList = customerBiz.searchCustomerUsers(customerFlow,user.getUserName());
		if (userList != null) {
			for (ErpCrmCustomerUser temp:userList) {
				if (!temp.getUserFlow().equals(user.getUserFlow())) {
					return GlobalConstant.OPRE_FAIL;	
				}
			} 
		}
		return GlobalConstant.OPRE_SUCCESSED;	
	}
	
	/**
	 * 校验合同联系人姓名重复问题
	 * @param customerUser
	 * @return
	 */
	@RequestMapping(value="/contractUserNameConfirm")
	@ResponseBody
	public String contractUserNameConfirm(ErpCrmContractUser user){ 
		//验证合同联系人是否已存在
		String contractFlow = user.getContractFlow();
		List<ErpCrmContractUser> contractUserList = contractUserBiz.searchContractUsers(contractFlow,user.getUserName());
		if (contractUserList != null) {
			for (ErpCrmContractUser temp:contractUserList) {
				if (!temp.getRecordFlow().equals(user.getRecordFlow())) {
					return "contractExsit";	
				}
			} 
		}
		//验证客户联系人是否已存在
		ErpCrmContract contract = contractBiz.readContract(contractFlow);
		String customerFlow = contract.getCustomerFlow();
		List<ErpCrmCustomerUser> userList = customerBiz.searchCustomerUsers(customerFlow,user.getUserName());
		if (userList != null) {
			for (ErpCrmCustomerUser temp:userList) {
				if (!temp.getUserFlow().equals(user.getUserFlow()) && !temp.getUserFlow().equals(user.getRecordFlow())) {
					return "customerExsit";	
				}
			} 
		}
		return GlobalConstant.OPRE_SUCCESSED;	
	}
	
	/**
	 * 保存单个联系人
	 * @param customerUser
	 * @return
	 */
	@RequestMapping(value="/saveCustomerUser")
	@ResponseBody
	public String saveCustomerUser(ErpCrmCustomerUser customerUser){
		if(StringUtil.isNotBlank(customerUser.getSexId())){
			customerUser.setSexName(UserSexEnum.getNameById(customerUser.getSexId()));
		}else{
			customerUser.setSexName("");
		}
		int result = customerUserBiz.saveCustomerUser(customerUser);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 删除单个联系人
	 * @param customerUser
	 * @return
	 */
	@RequestMapping(value="/deleteCustomerUser")
	@ResponseBody
	public String deleteCustomerUser(String userFlow){
		return this.customerUserBiz.deleteCustomerUser(userFlow);
	}
	
	
	/**
	 * 停用、启用联系人
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/disableUser")
	@ResponseBody
	public String disableUser(String userFlow, String recordStatus){
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordStatus)){
			ErpCrmCustomerUser customerUser = new ErpCrmCustomerUser();
			customerUser.setUserFlow(userFlow);
			customerUser.setRecordStatus(recordStatus);
			int result = customerUserBiz.updateCustomerUser(customerUser);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPERATE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 联系人详细信息
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editCustomerUser")
	public String editCustomerUser(String userFlow, Model model){
		if(StringUtil.isNotBlank(userFlow)){
			ErpCrmCustomerUser customerUser = customerUserBiz.readCustomerUser(userFlow);
			model.addAttribute("customerUser", customerUser);
		}
		return "erp/crm/customer/editCustomerUser";
	}
	
	/**
	 * 验证客户唯一
	 * @param customer
	 * @param userFlow
	 * @return
	 */
	@RequestMapping(value="/checkCustomer")
	@ResponseBody
	public String checkCustomer(ErpCrmCustomer customer){
		ErpCrmCustomer existCustomer = null;
		String customerName = customer.getCustomerName();
		if(StringUtil.isNotBlank(customerName)){
			existCustomer = customerBiz.findCustomerByCustomerName(customerName);
			if(existCustomer != null){
				String customerFlow = customer.getCustomerFlow();
				if(StringUtil.isNotBlank(customerFlow)){
					if(!existCustomer.getCustomerFlow().equals(customerFlow)){
						return GlobalConstant.CRM_CUSTOMER_NAME_EXIST;
					}
				}else{
					return GlobalConstant.CRM_CUSTOMER_NAME_EXIST;
				}
			}
		}
		return GlobalConstant.FLAG_Y;
	}
	
	/**
	 * 删除客户
	 * @param customerFlow
	 * @return
	 */
	@RequestMapping(value="/deleteCustomer")
	@ResponseBody
	public String deleteCustomer(String customerFlow){
		if(StringUtil.isNotBlank(customerFlow)){
			ErpCrmContract contract = new ErpCrmContract();
			contract.setCustomerFlow(customerFlow);
			List<ErpCrmContract> contractList = contractBiz.searchErpContractList(contract);
			if(contractList != null && !contractList.isEmpty()){
				return GlobalConstant.FLAG_N;
			}else{
				ErpCrmCustomer customer = new ErpCrmCustomer();
				customer.setCustomerFlow(customerFlow);
				customer.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				int result = customerBiz.saveCustomer(customer);
				if(result != GlobalConstant.ZERO_LINE){
					return GlobalConstant.DELETE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	//*************************************************************************************
	/**
	 * 合同新增页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editContract")
	public String editContract(Model model){
		List<SysDept> deptList=searchDeptList();
		model.addAttribute("deptList", deptList);
		List<ErpCrmCustomer> consumerList=searchCustomerJsonByType();
		model.addAttribute("consumerList", consumerList);
		return "erp/crm/contract/edit";
	}
	
	
	@RequestMapping(value="/updateToCustomerUser")
	@ResponseBody
	public String updateToCustomerUser(String recordFlow,String customerFlow){
		ErpCrmContractUser contractUser=this.contractUserBiz.readContractUser(recordFlow);
		if(contractUser!=null){
			ErpCrmCustomerUser customerUser=new ErpCrmCustomerUser();
			customerUser.setUserFlow(contractUser.getRecordFlow());
			customerUser.setUserName(contractUser.getUserName());
			customerUser.setCustomerFlow(customerFlow);
			if(StringUtil.isNotBlank(contractUser.getSexId())){
				customerUser.setSexName(UserSexEnum.getNameById(contractUser.getSexId()));
			}
			customerUser.setIdNo(contractUser.getIdNo());
			customerUser.setBirthday(contractUser.getBirthday());
			customerUser.setDeptName(contractUser.getDeptName());
			customerUser.setPostName(contractUser.getPostName());
			customerUser.setUserTelphone(contractUser.getUserTelphone());
			customerUser.setUserCelphone(contractUser.getUserCelphone());
			customerUser.setUserEmail(contractUser.getUserEmail());
			customerUser.setUserQq(contractUser.getUserQq());
			customerUser.setRemark(contractUser.getRemark());
			customerUser.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			int result=this.customerUserBiz.saveCustomerUser(customerUser);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.OPERATE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 查询类型为企业的客户
	 * @param userFlows
	 * @return
	 */
	@RequestMapping(value="/searchCustomerJsonByType")
	@ResponseBody
	public List<ErpCrmCustomer> searchCustomerJsonByType(){
		ErpCrmCustomer customer=new ErpCrmCustomer();
		customer.setCustomerTypeId(CustomerTypeEnum.Enterprise.getId());
		List<ErpCrmCustomer> customerList=this.customerBiz.searchCustomer(customer);
		return customerList;
	}
	
	
	/**
	 * 关联客户联系人页面
	 * @param customerFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/searchCustomerLinkManList")
	public String searchCustomerLinkManList(String customerFlow,Model model){
		if(StringUtil.isNotBlank(customerFlow)){
			ErpCrmCustomerUser customerUser = new ErpCrmCustomerUser();
			customerUser.setCustomerFlow(customerFlow);
			customerUser.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<ErpCrmCustomerUser> customerUserList =  customerUserBiz.searchCustomerUserList(customerUser);
			model.addAttribute("customerUserList", customerUserList);
		}
		return "erp/crm/contract/customerUserList";
	}
	/**
	 * 根据联系人流水号查询客户联系人
	 * @param userFlows
	 * @return
	 */
	@RequestMapping(value="/searchCustomerUserByUserFlows")
	@ResponseBody
	public List<ErpCrmCustomerUser> searchCustomerUserByUserFlows(String userFlows){
		List<ErpCrmCustomerUser> userList=this.customerUserBiz.searchUsersByUserFlows(userFlows);
		return userList;
	}
	
	/**
	 * 保存封装过的合同联系人
	 * @param userFlows
	 * @param contractFlow
	 * @return
	 */
	@RequestMapping(value="/searchAndSaveCustomerUserByUserFlows")
	@ResponseBody
	public String searchAndSaveCustomerUserByUserFlows(String userFlows,String contractFlow){
		List<ErpCrmCustomerUser> userList=this.customerUserBiz.searchUsersByUserFlows(userFlows);
		String result=this.contractUserBiz.saveCustomerAndContractUser(userList, contractFlow);
		if(!GlobalConstant.SAVE_SUCCESSED.equals(result)){
			return GlobalConstant.SAVE_FAIL;
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 查询当前登录者所在机构的部门
	 * @param model
	 * @return
	 */
	public List<SysDept> searchDeptList(){
		SysDept dept=new SysDept();
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList=this.deptBiz.searchDept(dept);
		return deptList;
	}
	/**
	 * 保存合同及其相关信息
	 * @param jsondata
	 * @param file
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value="/saveContractInfo")
	@ResponseBody
	public String saveContract(String jsondata ,String refType,@RequestParam(value="file" , required=false)MultipartFile file,HttpServletRequest request) throws IOException{
		if(!checkFileSize(file)){
			return GlobalConstant.FILE_BEYOND_LIMIT;
		}
		ContractForm contractForm = JSON.parseObject(jsondata, ContractForm.class);
		ErpCrmContract contract=contractForm.getContract();
		List<ErpCrmContractProduct> productList=contractForm.getProductList();
		List<ErpCrmCustomerUser> userList=contractForm.getUserList();
		List<ErpCrmContractPayPlan> payPlanList=contractForm.getPayPlanList();
		List<ErpCrmContractRef> refList=contractForm.getRefList();
		if(StringUtil.isNotBlank(refType) && GlobalConstant.RECORD_STATUS_Y.equals(refType)){
			String result=this.refBiz.updateOneContractRef(contract.getContractFlow());
			if(!GlobalConstant.SAVE_SUCCESSED.equals(result)){
				return GlobalConstant.SAVE_FAIL;
			}
		}
		String contractFlow=this.contractBiz.saveContractInfo(replenishContract(contract), replenishContractProduct(productList), replenishCustomerUser(userList),file, payPlanList,refList);
		return contractFlow;
	}
	
	@RequestMapping(value="/saveContractUsers")
	@ResponseBody
	public String saveContractUsers(String jsondata,HttpServletRequest request){
		ContractForm contractForm = JSON.parseObject(jsondata, ContractForm.class);
		ErpCrmContract contract=contractForm.getContract();
		List<ErpCrmCustomerUser> userList=contractForm.getUserList();
		return this.contractUserBiz.saveCustomerAndContractUser(replenishCustomerUser(userList),contract.getContractFlow());
	}
	
	/**
	 * 设置合同中需要枚举的字段name
	 * @param contract
	 * @return
	 */
	public ErpCrmContract replenishContract(ErpCrmContract contract){
		if(contract!=null){
			if(StringUtil.isNotBlank(contract.getConsumerFlow())){
				ErpCrmCustomer customer=this.customerBiz.readCustomer(contract.getConsumerFlow());
				contract.setConsumerName(customer.getCustomerName());
			}
			if(StringUtil.isNotBlank(contract.getContractCategoryId())){
				contract.setContractOwnName(CompanyNameEnum.getNameById(contract.getContractOwnId()));
			}
			if(StringUtil.isNotBlank(contract.getContractCategoryId())){
				contract.setContractCategoryName(ContractCategoryEnum.getNameById(contract.getContractCategoryId()));
				//如果合同类别是经销合同则调换经销商和客户
				if(!ContractCategoryEnum.Sell.getId().equals(contract.getContractCategoryId())){
					contract.setConsumerFlow("");
					contract.setConsumerName("");
				}else{
					ErpCrmCustomer userCustomer=this.customerBiz.readCustomer(contract.getCustomerFlow());
		            String useCustomerName = null;
		            if(userCustomer!=null){
		            	useCustomerName=userCustomer.getCustomerName();
		            }
		            String tempFlow=contract.getCustomerFlow();
		            String tempName=useCustomerName;
		            contract.setCustomerFlow(contract.getConsumerFlow());
		            contract.setConsumerFlow(tempFlow);
		            contract.setConsumerName(tempName);
				}
			}
			if(StringUtil.isNotBlank(contract.getContractStatusId())){
				contract.setContractStatusName(ContractStatusEnum.getNameById(contract.getContractStatusId()));
			}
			if(StringUtil.isNotBlank(contract.getContractTypeId())){
				contract.setContractTypeName(ContractTypeEnum.getNameById(contract.getContractTypeId()));
			}
		}
		return contract;
	}
	/**
	 * 设置合同产品中需要枚举的字段name
	 * @param productList
	 * @return
	 */
	public List<ErpCrmContractProduct> replenishContractProduct(List<ErpCrmContractProduct> productList){
		if(productList!=null && !productList.isEmpty()){
			for(ErpCrmContractProduct product:productList){
				if(StringUtil.isNotBlank(product.getProductTypeId())){
					product.setProductTypeName(DictTypeEnum.ProductType.getDictNameById(product.getProductTypeId()));
				}else{
					product.setProductTypeId("");
				}
			}
		}	
		return productList;
	}
	/**
	 * 设置合同联系人中需要枚举的字段name
	 * @param userList
	 * @return
	 */
	public List<ErpCrmCustomerUser> replenishCustomerUser(List<ErpCrmCustomerUser> userList){
		if(userList!=null && !userList.isEmpty()){
			for(ErpCrmCustomerUser contractUser:userList){
				if(StringUtil.isNotBlank(contractUser.getSexId())){
					contractUser.setSexName(UserSexEnum.getNameById(contractUser.getSexId()));
				}
			}
		}
		return userList;
	}
    /**
     * 校验文件大小
     * @param file
     * @return
     */
	public Boolean checkFileSize(MultipartFile file){
		long fileLength=100*1024*1024;
		if(file!=null){
			if(file.getSize()>=fileLength){
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 查询所有客户信息
	 * @return
	 */
	@RequestMapping(value="/searchCustomerJson")
	@ResponseBody
	public List<ErpCrmCustomer> searchCustormerJson(){
		Map<String,Object> paramMap=new HashMap<String, Object>();
		return this.customerBiz.searchCustomerList(paramMap);
	}
	/**
	 * 查询当前部门的人员信息
	 * @return
	 */
	@RequestMapping(value="/searchDeptUserJson")
	@ResponseBody
	public List<SysUser> searchDeptUserJson(String deptFlow){
		if(StringUtil.isNotBlank(deptFlow)){
			SysUser sysUser=new SysUser();
			sysUser.setDeptFlow(deptFlow);
			//sysUser.setStatusId(UserStatusEnum.Activated.getId());
			List<SysUser> userList=this.sysUserBiz.searchUser(sysUser);
		    return userList;
		}
		return null;
	}
	
	@RequestMapping(value="/searchPopdom")
	@ResponseBody
	public List<String> searchPopdom(){
		SysUser currUser=GlobalContext.getCurrentUser();
		ErpUserRegionPopedom popdom=new ErpUserRegionPopedom();
		popdom.setUserFlow(currUser.getUserFlow());
		List<String> provIdList=new ArrayList<String>();
		List<ErpUserRegionPopedom> popdomList=this.popedomBiz.searchRegionPopList(popdom);
		if(popdomList!=null && !popdomList.isEmpty()){
			for(ErpUserRegionPopedom pop:popdomList){
				provIdList.add(pop.getProvId());
			}
		}
		return provIdList;
	}
	
	/**
	 * 查询合同列表
	 * @param currentPage
	 * @param contract
	 * @param customerName
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/searchContract/{userListScope}")
	public String searchContract(@PathVariable String userListScope,Integer currentPage,ErpCrmContract contract,ErpCrmCustomer customer,String bigRegionTypeId,ContractTimeForm timeForm,String noSecond,String maintainDue,HttpServletRequest request,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		List<String> bigRegionTypeIdList=new ArrayList<String>();
		Map<String,Object> paramMap=new HashMap<String, Object>();
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
		if(StringUtil.isNotBlank(bigRegionTypeId) && !"00".equals(bigRegionTypeId)){
			if("01".equals(bigRegionTypeId)){
				bigRegionTypeIdList.add("310000");
				bigRegionTypeIdList.add("320000");
				bigRegionTypeIdList.add("330000");
				bigRegionTypeIdList.add("340000");
				bigRegionTypeIdList.add("350000");
				bigRegionTypeIdList.add("360000");
				bigRegionTypeIdList.add("370000");
			} else if("02".equals(bigRegionTypeId)){
				bigRegionTypeIdList.add("440000");
				bigRegionTypeIdList.add("450000");
				bigRegionTypeIdList.add("460000");
			} else if("03".equals(bigRegionTypeId)){
				bigRegionTypeIdList.add("110000");
				bigRegionTypeIdList.add("120000");
				bigRegionTypeIdList.add("130000");
				bigRegionTypeIdList.add("140000");
				bigRegionTypeIdList.add("150000");
				bigRegionTypeIdList.add("210000");
				bigRegionTypeIdList.add("220000");
				bigRegionTypeIdList.add("230000");
			} else if("04".equals(bigRegionTypeId)){
				bigRegionTypeIdList.add("410000");
				bigRegionTypeIdList.add("420000");
				bigRegionTypeIdList.add("430000");
				bigRegionTypeIdList.add("500000");
				bigRegionTypeIdList.add("510000");
				bigRegionTypeIdList.add("520000");
				bigRegionTypeIdList.add("530000");
				bigRegionTypeIdList.add("540000");
				bigRegionTypeIdList.add("610000");
				bigRegionTypeIdList.add("620000");
				bigRegionTypeIdList.add("630000");
				bigRegionTypeIdList.add("640000");
				bigRegionTypeIdList.add("650000");
			}
			paramMap.put("bigRegionTypeIdList", bigRegionTypeIdList);
		}
		if(GlobalConstant.USER_LIST_GLOBAL.equals(userListScope) || GlobalConstant.USER_LIST_CHARGE.equals(userListScope)){
			List<SysDept> deptList=searchDeptList();
			model.addAttribute("deptList", deptList);
		}
		if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){
			contract.setSignDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
		}
		if(GlobalConstant.USER_LIST_PERSONAL.equals(userListScope)){
			contract.setSignDeptFlow(GlobalContext.getCurrentUser().getDeptFlow());
			contract.setChargeUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		}
		paramMap.put("contract", contract);
		paramMap.put("customer", customer);
		paramMap.put("noSecond", StringUtil.defaultString(noSecond));
		paramMap.put("maintainDue", StringUtil.defaultString(maintainDue));
		paramMap.put("currDate", DateUtil.getCurrDate());
		PageHelper.startPage(currentPage, getPageSize(request));
		List<ErpCrmContractExt> contractListExt=this.contractBiz.searchErpContractListByCondition(paramMap);
		model.addAttribute("contractListExt", contractListExt);
		model.addAttribute("noSecond", StringUtil.defaultString(noSecond));
		model.addAttribute("maintainDue", StringUtil.defaultString(maintainDue));
		return "erp/crm/contract/list";
	}
	
	
	/**
	 * 查询单个合同详细信息
	 * @param contractFlow
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/contractInfo")
	public String contractInfo(String contractFlow,ErpCrmCustomerUser user,Model model){
		Map<String,Object> resultMap=this.contractBiz.readContractExt(contractFlow,user);
		model.addAttribute("resultMap", resultMap);
		return "erp/crm/contract/contractInfo";
	}
	/**
	 * 编辑合同信息
	 * @param contractFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editContractInfo")
	public String editContractInfo(String contractFlow,Model model){
		 List<SysDept> deptList=searchDeptList();
		 model.addAttribute("deptList", deptList);
		 Map<String,Object> paramMap=new HashMap<String, Object>();
		 ErpCrmContract contract=new ErpCrmContract();
		 contract.setContractFlow(contractFlow);
		 paramMap.put("contract", contract);
		 List<ErpCrmContractExt> contractList=this.contractBiz.searchContracts(paramMap);
		 if(contractList!=null && !contractList.isEmpty()){
			 if(ContractCategoryEnum.Sell.getId().equals(contractList.get(0).getContractCategoryId())){
					ErpCrmCustomer userCustomer=this.customerBiz.readCustomer(contractList.get(0).getCustomerFlow());
		            String useCustomerName = null;
		            if(userCustomer!=null){
		            	useCustomerName=userCustomer.getCustomerName();
		            }
		            String tempFlow=contractList.get(0).getCustomerFlow();
		            String tempName=useCustomerName;
		            contractList.get(0).setCustomerFlow(contractList.get(0).getConsumerFlow());
		            contractList.get(0).getCustomer().setCustomerFlow(contractList.get(0).getConsumerFlow());
		            contractList.get(0).getCustomer().setCustomerName(contractList.get(0).getConsumerName());
		            contractList.get(0).setConsumerFlow(tempFlow);
		            contractList.get(0).setConsumerName(tempName);
				}
			 model.addAttribute("contractExt", contractList.get(0));
			 PubFile file=this.fileBiz.readFile(contractList.get(0).getContractFileFlow());
			 model.addAttribute("file", file);
			//查询关联主合同信息
			List<ErpCrmContractRefExt> mainRefExtList=this.refBiz.searchContractListByRef(contractFlow,null);
		    model.addAttribute("refExtList", mainRefExtList);
		    List<ErpCrmCustomer> customerList=new ArrayList<ErpCrmCustomer>();
		    List<String> customerFlowList=new ArrayList<String>();
		    Map<String,Object> contractMap=new HashMap<String, Object>();
		    if(mainRefExtList!=null && !mainRefExtList.isEmpty()){
		    	for(ErpCrmContractRefExt refExt:mainRefExtList){
		    		ErpCrmCustomer customer=this.customerBiz.readCustomer(refExt.getContract().getCustomerFlow());
		    		if(!customerFlowList.contains(customer.getCustomerFlow())){
		    			customerList.add(customer);
		    			customerFlowList.add(customer.getCustomerFlow());
		    		}
		    		List<ErpCrmContract> contracts=this.contractBiz.searchMainContact(customer.getCustomerFlow(), contractFlow);
		    		contractMap.put(customer.getCustomerFlow(), contracts);
		    	}
		    }
		    model.addAttribute("customerList", customerList);
		    model.addAttribute("contractMap", contractMap);
		    //查询该合同是否被其它合同关联
		    ErpCrmContractRef ref=new ErpCrmContractRef();
		    ref.setContractFlow(contractFlow);
		    List<ErpCrmContractRef> refList=this.refBiz.searchRefList(ref);
		    if(refList!=null && !refList.isEmpty()){
		    	model.addAttribute("refFlag", GlobalConstant.FLAG_Y);
		    }
		    List<ErpCrmCustomer> consumerList=searchCustomerJsonByType();
			model.addAttribute("consumerList", consumerList);
		 }
		 return "erp/crm/contract/editContractInfo";
	}
    /**
     * 列表页面子合同
     * @param contractFlow
     * @param checkContractFlow
     * @param model
     * @return
     */
	@RequestMapping(value="/appendList")
	public String appendList(String contractFlow,String checkContractFlow,String signDeptFlow,Model model){
		List<ErpCrmContractRefExt> refExtList=this.refBiz.searchContractListByRef(null,contractFlow);
		List<String> refContractFlowList=new ArrayList<String>();
		Map<String,Object> paramMap=new HashMap<String, Object>();
		if(refExtList!=null && !refExtList.isEmpty()){
			for(ErpCrmContractRefExt ref:refExtList){
				refContractFlowList.add(ref.getContract().getContractFlow());
				}
			}
		    paramMap.put("refContractFlowList", refContractFlowList);
		    List<ErpCrmContractExt> contractExtList=this.contractBiz.searchErpContractListByCondition(paramMap);
			model.addAttribute("contractExtList", contractExtList);
			model.addAttribute("contractFlow", contractFlow);
			model.addAttribute("checkContractFlow", checkContractFlow);
			model.addAttribute("signDeptFlow", signDeptFlow);
		
		return "erp/crm/contract/appendList";
	}
	/**
	 * 编辑合同产品
	 * @param contractFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editProduct")
	public String editProduct(String contractFlow,Model model){
		ErpCrmContractProduct product=new ErpCrmContractProduct();
		product.setContractFlow(contractFlow);
		List<ErpCrmContractProduct> productList=this.productBiz.searchContactProductList(product);
		model.addAttribute("productList", productList);
		ErpCrmContract contract=this.contractBiz.readContract(contractFlow);
		model.addAttribute("contract", contract);
		return "erp/crm/contract/editProduct";
	}
	/**
	 * 删除合同产品
	 * @param productFlows
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/delProduct")
	@ResponseBody
	public String delProduct(String productFlows,Model model){
		return this.productBiz.deleteContractProduct(productFlows);
	}
	
	/**
	 * 编辑合同联系人信息
	 * @param contractFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editLinkMan")
	public String editLinkMan(String contractFlow,Model model){
		ErpCrmContract contract=this.contractBiz.readContract(contractFlow);
		ErpCrmContractUser contractUser=new ErpCrmContractUser();
		contractUser.setContractFlow(contractFlow);
		contractUser.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<ErpCrmContractUser> userList=this.contractUserBiz.searchContractUserList(contractUser);
		Map<String,Object> customerUserMap=new HashMap<String, Object>();
		List<String> contractUserFlowList=new ArrayList<String>();
		if(userList!=null && !userList.isEmpty()){
			for(ErpCrmContractUser user:userList){
				contractUserFlowList.add(user.getUserFlow());
			}
		}
		List<ErpCrmCustomerUser> customerUsers=this.customerUserBiz.searchCustomerUserList(contractUserFlowList);
		if(customerUsers!=null && !customerUsers.isEmpty()){
			for(ErpCrmCustomerUser user:customerUsers){
				customerUserMap.put(user.getUserFlow(), user);
			}
		}
		model.addAttribute("customerFlow", contract.getCustomerFlow());
		model.addAttribute("customerUserMap", customerUserMap);
		model.addAttribute("userList", userList);
		return "erp/crm/contract/editLinkMan";
	}
	/**
	 * 跳转合同单个联系人编辑页面
	 * @param userFlow
	 * @param contractFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/readLinkMan")
	public String readLinkMan(String recordFlow,String contractFlow,Model model){
		 ErpCrmContractUser contractUser=this.contractUserBiz.readContractUser(recordFlow);
		 if(contractUser!=null){
			 ErpCrmCustomerUser customerUser=this.customerUserBiz.readCustomerUser(contractUser.getUserFlow());
		     model.addAttribute("customerUser", customerUser);
		     String userCategoryId=contractUser.getUserCategoryId();
		     List<String> userCategoryList=new ArrayList<String>();
		     if(StringUtil.isNotBlank(userCategoryId)){
		    	 String [] categoryArray=userCategoryId.split(",");
		    	 for(String categoryId:categoryArray){
		    		 userCategoryList.add(categoryId);
		    	 }
		     }
		     model.addAttribute("userCategoryList", userCategoryList);
		 }
		 model.addAttribute("contractUser", contractUser);
		 model.addAttribute("contractFlow", contractFlow);
		return "erp/crm/contract/userDetail";
	}
	/**
	 * 保存合同单个联系人信息
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveLinkMan")
	@ResponseBody
	public String saveLinkMan(ErpCrmContractUser contractUser,ErpCrmCustomerUser customerUser,Model model){
		 if(StringUtil.isNotBlank(contractUser.getSexId())){
			 contractUser.setSexName(UserSexEnum.getNameById(contractUser.getSexId()));
		 }
		 if(StringUtil.isNotBlank(customerUser.getSexId())){
			 customerUser.setSexName(UserSexEnum.getNameById(contractUser.getSexId()));
		 }
		 int result=this.contractUserBiz.saveOneContractUser(contractUser,customerUser);
		 if(result==GlobalConstant.ONE_LINE){
			 return GlobalConstant.SAVE_SUCCESSED;
		 }
		 return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 编辑合同回款计划
	 * @param contractFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editPayPlan")
	public String editPayPlan(String contractFlow,Model model){
		ErpCrmContractPayPlan payPlan=new ErpCrmContractPayPlan();
		payPlan.setContractFlow(contractFlow);
		List<ErpCrmContractPayPlan> payPlanList=this.payPlanBiz.searchContractPayPlanList(payPlan);
		model.addAttribute("payPlanList", payPlanList);
		return "erp/crm/contract/editPayPlan";
	}
	/**
	 * 改变合同联系人状态
	 * @param userFlow
	 * @param flag
	 * @return
	 */
	@RequestMapping(value="/changeContractUserStatus")
	@ResponseBody
	public String changeContractUserStatus(String recordFlow,String flag){
		ErpCrmContractUser user=this.contractUserBiz.readContractUser(recordFlow);
		if(user!=null){
			user.setRecordStatus(flag);
			int result=this.contractUserBiz.saveContractUser(user);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.OPERATE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value="/deleteContract")
	@ResponseBody
	public String deleteContractUser(String contractFlow){
		int result=this.contractBiz.deleteContract(contractFlow);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	//合同新增：关联主合同
	@RequestMapping(value="/searchMainContact")
	@ResponseBody
	public Map<String,Object> searchMainContact(String customerFlow,String contractFlow){
		Map<String,Object> map=new HashMap<String, Object>();
		ErpCrmCustomer customer=this.customerBiz.readCustomer(customerFlow);
		List<ErpCrmContract> contractList = this.contractBiz.searchMainContact(customerFlow,contractFlow);
		map.put("customer", customer);
		map.put("contractList", contractList);
		return map;
	}
	/**
	 * 关联主合同-查询主合同及其产品列表
	 * @param contractFlow
	 * @return
	 */
	@RequestMapping(value="/searchContactProduct")
	@ResponseBody
	public Map<String,Object> searchContactProduct(String contractFlow){
		Map<String,Object> resultMap=new HashMap<String, Object>();
		ErpCrmContractProduct product = new ErpCrmContractProduct();
		product.setContractFlow(contractFlow);
		List<ErpCrmContractProduct> productList=this.productBiz.searchContactProductList(product);
		ErpCrmContract contract=this.contractBiz.readContract(contractFlow);
		resultMap.put("contract", contract);
		resultMap.put("productList", productList);
		return resultMap;
	}
	
	
	
	
	/**
	 * 查询客户的所有联系人信息
	 * @param customerFlow
	 * @return
	 */
	@RequestMapping(value="/searchCustomerUserJson")
	@ResponseBody
	public List<ErpCrmCustomerUser> searchCustomerUserJson(String customerFlow){
		List<ErpCrmCustomerUser> customerUserList = null;
		if(StringUtil.isNotBlank(customerFlow)){
			ErpCrmCustomerUser user = new ErpCrmCustomerUser();
			user.setCustomerFlow(customerFlow);
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			customerUserList =  customerUserBiz.searchCustomerUserList(user);
		}
		return customerUserList;
	}
	
	
	/**
	 * 查询合同产品
	 * @param contractFlow
	 * @return
	 */
	@RequestMapping(value="/searchContractProductJson")
	@ResponseBody
	public List<ErpCrmContractProduct> searchContractProductJson(String contractFlow){
		ErpCrmContractProduct product = new ErpCrmContractProduct();
		product.setContractFlow(contractFlow);
		return this.productBiz.searchContactProductList(product);
	}
	
	@RequestMapping(value="/delContractUsers")
	@ResponseBody
	public String delContractUsers(@RequestBody String[] recordFlows){
		if (recordFlows != null && recordFlows.length>0) {
			return this.contractUserBiz.updateContractUsers(recordFlows);
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping(value="/markUser")
	public String markUser(String userFlow,String customerFlow,Model model){
		ErpCrmCustomerUser customerUser = customerUserBiz.readCustomerUser(userFlow);
		model.addAttribute("customerUser", customerUser);
		
		ErpCrmContractUser user = new ErpCrmContractUser();
		user.setUserFlow(userFlow);
		List<ErpCrmContractUser> contractUserList = contractUserBiz.searchContractUserList(user);
		Map<String,Object> contractUserMap=new HashMap<String, Object>();
		if(contractUserList!=null && !contractUserList.isEmpty()){
			for(ErpCrmContractUser contractUser:contractUserList){
				contractUserMap.put(contractUser.getContractFlow(), contractUser);
			}
		}
		model.addAttribute("contractUserMap", contractUserMap);
		
		ErpCrmContract temp = new ErpCrmContract();
		temp.setCustomerFlow(customerFlow);
		List<ErpCrmContract> contractList = contractBiz.searchErpContractList(temp);
		model.addAttribute("contractList", contractList);
		Map<String,ErpCrmContract> contractMap = new HashMap<String,ErpCrmContract>();
		Map<String,List<ErpCrmContractProduct>> productMap = new HashMap<String,List<ErpCrmContractProduct>>();
		ErpCrmContractProduct product=new ErpCrmContractProduct();
		if (contractList != null && contractList.size() > 0) {
			for (ErpCrmContract contract:contractList) {
				String contractFlow = contract.getContractFlow();
				contractMap.put(contractFlow, contract);
				//查询产品信息
				product.setContractFlow(contractFlow);
				List<ErpCrmContractProduct> productList=this.productBiz.searchContactProductList(product);
				productMap.put(contractFlow, productList);
			}
		}
		model.addAttribute("contractMap", contractMap);
		model.addAttribute("productMap", productMap);
		//人员类别和产品的关联
		ErpCrmContractUserRef tem = new ErpCrmContractUserRef();
		tem.setUserFlow(userFlow);
		List<ErpCrmContractUserRef> userRefList = userRefBiz.searchContractUserRefList(tem);
		Map<String,String> userRefMap = new HashMap<String,String>();
		if (userRefList != null && userRefList.size() > 0) {
			for (ErpCrmContractUserRef ref:userRefList) {
				userRefMap.put(ref.getUserRecordFlow()+"_"+ref.getUserCategoryId()+"_"+ref.getProductFlow(), ref.getRecordFlow());
			}
		}
		model.addAttribute("userRefMap", userRefMap);
		return "erp/crm/customer/markUser";
	}
	
	@RequestMapping(value="/updateUser")
	@ResponseBody
	public String updateUser(String userCategory,String operFlag,String isSingle,
			ErpCrmContractUserRef userRef,Model model){
		String userFlow = userRef.getUserFlow();
		String contractFlow = userRef.getContractFlow();
		ErpCrmContractUser user = null;
		ErpCrmContractUser userTemp = new ErpCrmContractUser();
		userTemp.setUserFlow(userFlow);
		userTemp.setContractFlow(contractFlow);
		List<ErpCrmContractUser> contractUserList=this.contractUserBiz.searchContractUserList(userTemp);
		if(contractUserList!=null && !contractUserList.isEmpty()){
			user = contractUserList.get(0);
		}
		Boolean newUser = false;
		if(user==null){
			newUser = true;
			user = new ErpCrmContractUser();
			user.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(user, true);
			user.setUserFlow(userFlow);
			user.setContractFlow(contractFlow);
		}
		if (user != null) {
			ErpCrmContractUserRef contractUserRef = null;
			List<ErpCrmContractUserRef> userRefList = null;
			if (GlobalConstant.FLAG_Y.equals(operFlag)) {//增加人员类别
				String categoryId = StringUtil.defaultString(user.getUserCategoryId());
				String categoryName = StringUtil.defaultString(user.getUserCategoryName());
				if (StringUtil.isNotBlank(categoryId)) {
					categoryId += ",";
					categoryName += ",";
				}
				user.setUserCategoryId(categoryId+userCategory);
				user.setUserCategoryName(categoryName+UserCategoryEnum.getNameById(userCategory));
				 //使用人：若只有一个产品/项目，则默认选中该产品/项目
				if (UserCategoryEnum.User.getId().equals(userCategory) && GlobalConstant.FLAG_Y.equals(isSingle)) {
					contractUserRef = new ErpCrmContractUserRef();
					contractUserRef.setUserRecordFlow(user.getRecordFlow());
					contractUserRef.setUserFlow(StringUtil.defaultString(user.getUserFlow()));
					contractUserRef.setUserCategoryId(userCategory);
					contractUserRef.setUserCategoryName(UserCategoryEnum.getNameById(userCategory));
					contractUserRef.setContractFlow(user.getContractFlow());
					ErpCrmContractProduct productTemp = new ErpCrmContractProduct();
					productTemp.setContractFlow(user.getContractFlow());
					List<ErpCrmContractProduct> productList = productBiz.searchContactProductList(productTemp);
					if (productList != null && productList.size() > 0) {
						ErpCrmContractProduct product = productList.get(0);
						contractUserRef.setProductFlow(product.getProductFlow());
						contractUserRef.setProductTypeId(StringUtil.defaultString(product.getProductTypeId()));
						contractUserRef.setProductTypeName(StringUtil.defaultString(product.getProductTypeName()));
					}
				}
			} else {//删除人员类别
				String userCategoryId = StringUtil.defaultString(user.getUserCategoryId());
				String userCategoryName = StringUtil.defaultString(user.getUserCategoryName());
				String userCateName = UserCategoryEnum.getNameById(userCategory);
				if (StringUtil.contains(userCategoryId, userCategory+",")) {
					userCategoryId = userCategoryId.replace(userCategory+",", "");
					userCategoryName = userCategoryName.replace(userCateName+",", "");
				} else if (StringUtil.contains(userCategoryId, userCategory)) {
					userCategoryId = userCategoryId.replace(userCategory, "");
					userCategoryName = userCategoryName.replace(userCateName, "");
					if (StringUtil.isNotBlank(userCategoryId)) {
						userCategoryId = userCategoryId.substring(0, userCategoryId.length()-1);
						userCategoryName = userCategoryName.substring(0, userCategoryName.length()-1);
					}
				}
				user.setUserCategoryId(userCategoryId);
				user.setUserCategoryName(userCategoryName);
				//使用人：删除关联的产品/项目
				if (UserCategoryEnum.User.getId().equals(userCategory)) {
					ErpCrmContractUserRef temp = new ErpCrmContractUserRef();
					temp.setUserRecordFlow(user.getRecordFlow());
					temp.setUserCategoryId(UserCategoryEnum.User.getId());
					userRefList = userRefBiz.searchContractUserRefList(temp);
				}
			}
			this.contractUserBiz.updateUser(user,newUser,contractUserRef,userRefList);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value="/updateUserRef")
	@ResponseBody
	public String updateUserRef(ErpCrmContractUserRef userRef,String operFlag,Model model){
		ErpCrmContractUser user = new ErpCrmContractUser();
		user.setUserFlow(userRef.getUserFlow());
		user.setContractFlow(userRef.getContractFlow());
		List<ErpCrmContractUser> contractUserList=this.contractUserBiz.searchContractUserList(user);
		if(contractUserList!=null && !contractUserList.isEmpty()){
			user = contractUserList.get(0);
		}
		if (user != null) {
			ErpCrmContractProduct product = productBiz.readContractProduct(userRef.getProductFlow());
			if (GlobalConstant.FLAG_Y.equals(operFlag)) {//增加关联产品/项目
				userRef.setUserRecordFlow(user.getRecordFlow());
				userRef.setUserFlow(StringUtil.defaultString(user.getUserFlow()));
				userRef.setUserCategoryName(UserCategoryEnum.getNameById(userRef.getUserCategoryId()));
				userRef.setContractFlow(user.getContractFlow());
				if (product != null) {
					userRef.setProductTypeId(StringUtil.defaultString(product.getProductTypeId()));
					userRef.setProductTypeName(StringUtil.defaultString(product.getProductTypeName()));
				}
			} else {//删除关联产品/项目
				if(StringUtil.isBlank(userRef.getRecordFlow())){
					ErpCrmContractUserRef ref=new ErpCrmContractUserRef();
					ref.setUserFlow(user.getUserFlow());
					ref.setContractFlow(user.getContractFlow());
					ref.setProductFlow(product.getProductFlow());
					ref.setUserCategoryId(UserCategoryEnum.User.getId());
					List<ErpCrmContractUserRef> refList=this.userRefBiz.searchContractUserRefList(ref);
					if(refList!=null && refList.isEmpty()){
						userRef=refList.get(0);
					}
				}
				userRef.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			}
			this.userRefBiz.saveContractUserRef(userRef);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
}

