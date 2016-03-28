package com.pinde.sci.ctrl.erp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;

@Controller
@RequestMapping("erp/business")
public class BusinessController extends GeneralController{
	@Autowired
	private IDeptBiz deptBiz;
	
	//开票审核列表
	@RequestMapping(value="/auditBillList/{userListScope}")
	public String auditBillList(@PathVariable String userListScope,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		return "erp/business/audit/auditBillList";
	}
	//开票审核详情
	@RequestMapping(value="/auditBill")
	public String auditBill(Model model){
		return "erp/business/audit/auditBill";
	}
	//到账确认列表
	@RequestMapping(value="/auditPayList/{userListScope}")
	public String auditPayList(@PathVariable String userListScope,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		return "erp/business/audit/auditPayList";
	}
	
	//到账确认详情
    @RequestMapping(value="/auditPay")
    public String auditPay(Model model){
		return "erp/business/audit/auditPay";
	}
		
	@RequestMapping(value="/auditFinishContactOrders")
	public String auditFinishContactOrders(Model model){
		return "erp/business/audit/auditFinishContactOrder";
	}
	
	@RequestMapping(value="/payPlanInfo")
	public String payPlanInfo(Model model){
		return "erp/business/audit/payPlanInfo";
	}
	
	@RequestMapping(value="/payPlanList")
	public String payPlanList(Model model){
		return "erp/contract/payPlanList";
	}
	
}

