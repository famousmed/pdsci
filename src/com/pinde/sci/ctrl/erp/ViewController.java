package com.pinde.sci.ctrl.erp;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractBiz;
import com.pinde.sci.biz.erp.IErpViewBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.erp.ContactOrderStatusEnum;
import com.pinde.sci.enums.erp.PayPlanStatusEnum;
import com.pinde.sci.enums.erp.WorkOrderStatusEnum;
import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractPayPlan;
import com.pinde.sci.model.mo.ErpOaContactOrder;
import com.pinde.sci.model.mo.ErpOaWorkOrder;

@Controller
@RequestMapping("erp/view")
public class ViewController extends GeneralController{
     
	@Autowired
	private IErpViewBiz viewBiz;
	
	@RequestMapping(value="/managerMainView")
	public String managerMainView(Model model){
		String thisYear=DateUtil.getCurrDateTime("yyyy");
		model.addAttribute("thisYear", thisYear);
		String lastYear=String.valueOf(Integer.parseInt(thisYear)-1);
		model.addAttribute("lastYear", lastYear);
		String beforeYear=String.valueOf(Integer.parseInt(thisYear)-2);
		model.addAttribute("beforeYear", beforeYear);
        Map<String,Object> resultMap=new HashMap<String, Object>();
        LinkedList<Integer> yearContractList=new LinkedList<Integer>();
        //总客户数量
        int allCustomer=searchCustomerNumber(GlobalConstant.FLAG_N);
        resultMap.put("allCustomer",allCustomer);
        //合同客户数量
        int customerHasContract=searchCustomerNumber(GlobalConstant.FLAG_Y);
        resultMap.put("customerHasContract",customerHasContract);
        //无合同客户数量
        int customerHasNotContract=allCustomer-customerHasContract;
        resultMap.put("customerHasNotContract",customerHasNotContract);
        //总合同数量
        resultMap.put("allContract", searchContractNumber(""));
        for(int i=Integer.parseInt(thisYear);i>=2001;i--){
        	yearContractList.add(searchContractNumber(String.valueOf(i)));
        }
        resultMap.put("yearContractList", yearContractList);
        //合同总金额Map
        Map<String,Object> allFundMap=searchPayPlanMap("");
        resultMap.put("allMap", allFundMap);
        //合同今年金额Map
        Map<String,Object> thisYearFundMap=searchPayPlanMap(thisYear);
        resultMap.put("thisYearMap", thisYearFundMap);
        //合同去年金额Map
        Map<String,Object> lastYearFundMap=searchPayPlanMap(lastYear);
        resultMap.put("lastYearMap", lastYearFundMap);
        //合同前年金额Map
        Map<String,Object> beforeYearFundMap=searchPayPlanMap(beforeYear);
        resultMap.put("beforeYearMap", beforeYearFundMap);
        //未完成的联系单
        resultMap.put("noCompleteContact", searchContactOrderNoComplete());
        //未完成的派工单
        resultMap.put("noCompleteWork", searchWorkOrderNoComplete());
        //等待总经理审核的联系单
        resultMap.put("waitAuditContact", searchContactOrder(ContactOrderStatusEnum.ManagerAuditing.getId()));
        model.addAttribute("resultMap", resultMap);
		return "erp/view/managerMainView";
		//return "erp/view/echartsTest";
	}
	
	/**
	 * 查询客户数量
	 * @param isHaveContract
	 * @return
	 */
	public int searchCustomerNumber(String isHaveContract){
		if(GlobalConstant.FLAG_N.equals(isHaveContract)){
			return viewBiz.countCustomer(null);
		}else{
			return viewBiz.countCustomerHasContract();
		}
		
	}
	/**
	 * 查询合同数量
	 * @param year
	 * @return
	 */
	public int searchContractNumber(String year){
		ErpCrmContract contract=new ErpCrmContract();
		if(StringUtil.isNotBlank(year)){
			contract.setSignDate(year);
		}
		return viewBiz.countContract(contract);
	}
	
	public Map<String,Object> searchPayPlanMap(String year){
		Map<String,Object> map=new HashMap<String, Object>();
		BigDecimal allFund=searchContractFundNumber(year);
		BigDecimal alreadyFund=searchPayPlanFundNumber(year,PayPlanStatusEnum.Complete.getId());
		BigDecimal noFund=allFund.subtract(alreadyFund);
		map.put("all", allFund);
		map.put("already", alreadyFund);
		map.put("no", noFund);
		return map;
	}
	
	/**
	 * 查询合同金额
	 * @param year
	 * @return
	 */
	public BigDecimal searchContractFundNumber(String year){
		ErpCrmContract contract=new ErpCrmContract();
		if(StringUtil.isNotBlank(year)){
			contract.setSignDate(year);
		}
		return viewBiz.countContractFund(contract);
	} 
	
	/**
	 * 查询合同回款
	 * @param year
	 * @param statusId
	 * @return
	 */
	public BigDecimal searchPayPlanFundNumber(String year,String statusId){
		ErpCrmContract contract=new ErpCrmContract();
		if(StringUtil.isNotBlank(year)){
			contract.setSignDate(year);
		}
		ErpCrmContractPayPlan plan=new ErpCrmContractPayPlan();
		if(StringUtil.isNotBlank(statusId)){
			plan.setPlanStatusId(statusId);
		}
		return viewBiz.countPayPlanFund(contract, plan);
	}
	/**
	 * 查询联系单数量（根据状态）
	 * @param statusFlag
	 * @return
	 */
	public int searchContactOrderNoComplete(){
		List<String> statusList=new ArrayList<String>();
		for(ContactOrderStatusEnum enums:ContactOrderStatusEnum.values()){
			if(!enums.getId().equals(ContactOrderStatusEnum.Implemented.getId()) 
				&& !enums.getId().equals(ContactOrderStatusEnum.ReturnVisited.getId())
				&& !enums.getId().equals(ContactOrderStatusEnum.Closed.getId())){
				statusList.add(enums.getId());
			}
		}
		return viewBiz.countContactOrderByStatus(statusList);
	}
	/**
	 * 查询派工单数量（根据状态）
	 * @param statusFlag
	 * @return
	 */
	public int searchWorkOrderNoComplete(){
		List<String> statusList=new ArrayList<String>();
		for(WorkOrderStatusEnum enums:WorkOrderStatusEnum.values()){
			if(!enums.equals(WorkOrderStatusEnum.Passed.getId())
			    && !enums.equals(WorkOrderStatusEnum.Closed.getId())){
				statusList.add(enums.getId());
			}
		}
		return viewBiz.countWorkOrderByStatus(statusList);
	}
	
	public int searchContactOrder(String statusFlag){
		ErpOaContactOrder contactOrder=new ErpOaContactOrder();
		if(StringUtil.isNotBlank(statusFlag)){
			contactOrder.setContactStatusId(statusFlag);
		}
		return viewBiz.countContactOrder(contactOrder);
	}
}
