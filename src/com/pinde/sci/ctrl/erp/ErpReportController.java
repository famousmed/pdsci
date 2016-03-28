package com.pinde.sci.ctrl.erp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractBiz;
import com.pinde.sci.biz.erp.IErpCustomerBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.DateTrans;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.form.erp.InputReportForm;
import com.pinde.sci.model.erp.ErpCrmContractExt;

@Controller
@RequestMapping("erp/report")
public class ErpReportController extends GeneralController{ 
	@Autowired
	private IErpCustomerBiz customerBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IErpContractBiz contractBiz;
	
	//客户录入情况统计
	@RequestMapping(value="/crmInputReport")
	public String crmInputReport(String startDate,String endDate,String pickType,Model model){
		if (StringUtil.isBlank(startDate)) {
			startDate = DateUtil.getCurrDate2();
		}
		if (StringUtil.isBlank(endDate)) {
			endDate = DateUtil.getCurrDate2();
		}
		startDate = DateUtil.getDate(startDate) + "000000";
		endDate = DateUtil.getDate(endDate) + "235959";
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);
		List<InputReportForm> formList = customerBiz.searchCrmInput(paramMap);
		model.addAttribute("formList", formList);
		model.addAttribute("startDate", DateUtil.transDate(startDate));
		model.addAttribute("endDate", DateUtil.transDate(endDate));
		model.addAttribute("pickType", StringUtil.defaultString(pickType));
		
		return "erp/report/crmInput";
	}
	
	@RequestMapping(value="/crmInputReportPick")
	public String crmInputReportPick(String pickType,Model model){
		String startDate = DateUtil.getCurrDate();
		String endDate = DateUtil.getCurrDate();
		if (StringUtil.isNotBlank(pickType)) {
			if ("week".equals(pickType)) {
				startDate = DateUtil.addDate(startDate, -6);
			} else if ("month".equals(pickType)) {
				startDate = DateTrans.newDateOfAddMonths(startDate, -1);
			}
		}
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("pickType", pickType);
		return "redirect:/erp/report/crmInputReport";
	}
	
	//合同维护到期日提醒
	@RequestMapping(value="/contractDateRemind")
	public String contractDateRemind(String startDate,String endDate,String pickType,Integer currentPage,HttpServletRequest request,Model model){
		if (StringUtil.isBlank(pickType)) {
			String currDate = DateUtil.getCurrDate();
			startDate = DateUtil.addDate(currDate, -7);
			endDate = DateUtil.addDate(currDate, 7);
		}
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);
		paramMap.put("currDate", DateUtil.getCurrDate());
		PageHelper.startPage(currentPage, getPageSize(request));
		List<ErpCrmContractExt> contractList = contractBiz.searchContracts(paramMap);
		model.addAttribute("contractList", contractList);
		model.addAttribute("startDate", DateUtil.transDate(startDate));
		model.addAttribute("endDate", DateUtil.transDate(endDate));
		model.addAttribute("pickType", StringUtil.defaultString(pickType));
		
		return "erp/report/contractDateRemind";
	}
	
	@RequestMapping(value="/contractDatePick")
	public String contractDatePick(String pickType,Model model){
		String currDate = DateUtil.getCurrDate();
		String startDate = "";
		String endDate = "";
		if (StringUtil.isNotBlank(pickType)) {
			if ("week".equals(pickType)) {
				startDate = DateUtil.addDate(currDate, -7);
				endDate = DateUtil.addDate(currDate, 7);
			} else if ("month".equals(pickType)) {
				startDate = DateTrans.newDateOfAddMonths(currDate, -1);
				endDate = DateTrans.newDateOfAddMonths(currDate, 1);
			} else if ("season".equals(pickType)) {
				startDate = DateTrans.newDateOfAddMonths(currDate, -3);
				endDate = DateTrans.newDateOfAddMonths(currDate, 3);
			}else if ("halfYear".equals(pickType)) {
				startDate = DateTrans.newDateOfAddMonths(currDate, -6);
				endDate = DateTrans.newDateOfAddMonths(currDate, 6);
			}
		}
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("pickType", pickType);
		return "redirect:/erp/report/contractDateRemind";
	}
}

