package com.pinde.sci.ctrl.srm;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundBiz;
import com.pinde.sci.biz.srm.IFundInfoDetailBiz;
import com.pinde.sci.biz.srm.IFundProcessBiz;
import com.pinde.sci.biz.srm.IFundSchemeDetailBiz;
import com.pinde.sci.biz.srm.IPaymentBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.srm.ProjFundTypeEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmFundProcess;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.FundInfoExt;
import com.pinde.sci.model.srm.ProjFundDetailExt;

@Controller
@RequestMapping("/srm/payment")

public class PaymentController extends GeneralController{
	
	private static Logger logger = LoggerFactory.getLogger(AchCopyrightController.class);
	
	@Autowired
	private IPaymentBiz paymentBiz;
	@Autowired
	private IFundProcessBiz funProcessBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IFundSchemeDetailBiz fundItemBiz;
	@Autowired
	private IFundInfoDetailBiz fundInfoDetailBiz;

	
	@RequestMapping(value = "/list",method={RequestMethod.GET,RequestMethod.POST})
	public String list(PubProj proj, Model model){
		proj.setProjCategoryId(ProjCategroyEnum.Ky.getId());
		List<FundInfoExt> fundInfoList = paymentBiz.queryPaymentList(proj);
		model.addAttribute("fundInfoList", fundInfoList);
		Map<String , Integer> noApproveMap = new HashMap<String , Integer>();
		SrmProjFundDetail fundDetail = new SrmProjFundDetail();
		fundDetail.setFundTypeId(ProjFundTypeEnum.Reimburse.getId());
		fundDetail.setOperStatusId(AchStatusEnum.RollBack.getId());
		//查询该项目经费下 报销审核没通过的
		for(FundInfoExt fundInfoExt:fundInfoList){
			SrmProjFundInfo spfi = fundInfoExt.getFund();
			fundDetail.setFundFlow(spfi.getFundFlow());
			int count = this.paymentBiz.searchFundDetailNoApproveCount(fundDetail);
			noApproveMap.put(spfi.getFundFlow(), count);
		}
		model.addAttribute("noApproveMap" , noApproveMap);
		return "/srm/payment/paymentList";
	}
	
	@RequestMapping("/getDetailByFundFlow")
 	public String getDetailByFundFlow(String fundFlow ,String schemeFlow , String projFlow ,Model model){
		PubProj proj = this.projBiz.readProject(projFlow);
		model.addAttribute("proj",proj);
		List<SrmProjFundDetail> fundDetailList = paymentBiz.getDetailByFundFlow(fundFlow);
		model.addAttribute("fundFlow", fundFlow);
		//将fundDetail根据项目方案中的预算项分组
		Map<String , List<SrmProjFundDetail>> fundDetailMap = new HashMap<String, List<SrmProjFundDetail>>();
		List<SrmProjFundDetail> list = null;
		for(SrmProjFundDetail fundDetail :fundDetailList){
			String itemFlow = fundDetail.getItemFlow();
			if(fundDetailMap.containsKey(itemFlow)){
				list = fundDetailMap.get(itemFlow);
				list.add(fundDetail);
			}else{
				list = new ArrayList<SrmProjFundDetail>();
				list.add(fundDetail);
				fundDetailMap.put(itemFlow, list);
			}
		}
		model.addAttribute("fundDetailMap", fundDetailMap);
		//查询报销项目
		List<SrmFundSchemeDetail> schemeDetailList = paymentBiz.getSchemeDetailBySchemeFlow(schemeFlow);
		model.addAttribute("schemeDetailList", schemeDetailList);
		//查询经费预算
		SrmProjFundDetail fundDtl = new SrmProjFundDetail();
		fundDtl.setFundFlow(fundFlow);
		fundDtl.setFundTypeId(ProjFundTypeEnum.Budget.getId());
		List<SrmProjFundDetail> fundBudgetDtlList = fundInfoDetailBiz.searchFundDetail(fundDtl);
		Map<String , SrmProjFundDetail> budgetFundDtlMap = new HashMap<String, SrmProjFundDetail>();
		for(SrmProjFundDetail fundBudgetDtl:fundBudgetDtlList){
			budgetFundDtlMap.put(fundBudgetDtl.getItemFlow(), fundBudgetDtl);
		}
		model.addAttribute("budgetFundDtlMap", budgetFundDtlMap);
		//计算已报销比例
		Map<String , Double> yetPaymentMap = new HashMap<String, Double>();
		Set<Entry<String , List<SrmProjFundDetail>>> entrySet = fundDetailMap.entrySet();
		Iterator<Entry<String , List<SrmProjFundDetail>>> iterator = entrySet.iterator();
		while(iterator.hasNext()){
			Entry<String , List<SrmProjFundDetail>> entry = iterator.next();
			String key = entry.getKey();
			List<SrmProjFundDetail> value = entry.getValue();
			yetPaymentMap.put(key, new Double("0"));
			for(SrmProjFundDetail spfd:value){
				//if(AchStatusEnum.FirstAudit.getId().equals(spfd.getOperStatusId())){
					Double amount = yetPaymentMap.get(key);
					BigDecimal addAfterCount = spfd.getMoney().add(new BigDecimal(amount));
					yetPaymentMap.put(key, addAfterCount.doubleValue());
				//}
			}
			if(yetPaymentMap.get(key)!=null){
				BigDecimal currentAmount = new BigDecimal(yetPaymentMap.get(key));
				BigDecimal subAfter = currentAmount.subtract(budgetFundDtlMap.get(key).getMoney());
				yetPaymentMap.put(key, subAfter.doubleValue());
			}
			
		}
		model.addAttribute("yetPaymentMap", yetPaymentMap);
 		return "/srm/payment/detail";
	}
	
	/**
	 * 报销
	 * @param fundDetail
	 * @return
	 */
	@RequestMapping(value="/reimburse")
	public String reimburse(SrmProjFundDetail fundDetail){
		this.paymentBiz.reimburse(fundDetail);
		SrmProjFundInfo fundInfo = this.paymentBiz.getFundInfoByFundFlow(fundDetail.getFundFlow());
		return "redirect:/srm/payment/getDetailByFundFlow?fundFlow="+fundDetail.getFundFlow()+"&schemeFlow="+fundInfo.getSchemeFlow();
	}
	
	@RequestMapping(value={"/saveDetailList"},method=RequestMethod.POST)
	@ResponseBody
	public String saveDetailList(String fundFlow , @RequestBody List<SrmProjFundDetail> detailList , Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		for(SrmProjFundDetail detail :detailList){
			//经费类型-->报销
			detail.setFundTypeId(ProjFundTypeEnum.Reimburse.getId());
			detail.setFundTypeName(ProjFundTypeEnum.Reimburse.getName());
			//操作-->提交
			detail.setOperStatusId(AchStatusEnum.Submit.getId());
			detail.setOperStatusName(AchStatusEnum.Submit.getName());
		}
		
		//封装过程对象
		SrmFundProcess fundProcess=new SrmFundProcess();
		fundProcess.setFundFlow(fundFlow);
		
		fundProcess.setOperStatusId(AchStatusEnum.Submit.getId());
		fundProcess.setOperStatusName(AchStatusEnum.Submit.getName());
		
		fundProcess.setOperateUserFlow(currUser.getUserFlow());
		fundProcess.setOperateUserName(currUser.getUserName());
		
 	    paymentBiz.saveDetailList(fundFlow,detailList,fundProcess);
 	     
 	    return GlobalConstant.OPRE_SUCCESSED;
	}
	
	 //报销审核列表
	 @RequestMapping("/auditList")
	 public String auditList(ProjFundDetailExt fundDetailExt , Model model){
		List<ProjFundDetailExt> fundDetailList=paymentBiz.queryFundDetailAuditList(fundDetailExt);
    	Map<String , SrmProjFundDetail> budgetMap = new HashMap<String , SrmProjFundDetail>();
    	//已报销总计
    	BigDecimal total=new BigDecimal(0.0) ;
 		for(SrmProjFundDetail detail :fundDetailList){
 			budgetMap.put(detail.getFundDetailFlow(), this.paymentBiz.searchBudgetDetail(detail.getFundFlow(), detail.getItemFlow()));
			if(AchStatusEnum.FirstAudit.getId().equals(detail.getOperStatusId())){
				BigDecimal money = detail.getMoney();
				total = total.add(money);
			}
 		}
 		model.addAttribute("total", total);
 		model.addAttribute("fundDetailList", fundDetailList);
 		model.addAttribute("budgetMap", budgetMap);
 		model.addAttribute("fundDetailExt" , fundDetailExt);
		return "/srm/payment/auditList";
	 }
	 
	@RequestMapping("/audit")
	 public String audit(String fundDetailFlow,Model model){
		ProjFundDetailExt detailExt = this.fundInfoDetailBiz.selectProjFundDetailExt(fundDetailFlow);
		SrmProjFundDetail budget = this.paymentBiz.searchBudgetDetail(detailExt.getFundFlow(), detailExt.getItemFlow());
		model.addAttribute("fundDetailFlow", fundDetailFlow);
		model.addAttribute("detailExt", detailExt);
		model.addAttribute("budget", budget);
		return "/srm/payment/audit";
	 }
	
	
	 @RequestMapping(value="/saveAudit",method={RequestMethod.POST})
 	 @ResponseBody
 	 public String saveAudit(String agreeFlag , String content,String fundDetailFlow , Model model){
			SrmProjFundDetail fundDetail = paymentBiz.getDetailByDetailFlow(fundDetailFlow);
			SrmFundProcess fundProcess = new SrmFundProcess();
			if(agreeFlag.equals(GlobalConstant.FLAG_Y)){
				fundDetail.setOperStatusId(AchStatusEnum.FirstAudit.getId());
				fundDetail.setOperStatusName(AchStatusEnum.FirstAudit.getName());
				
				fundProcess.setOperStatusId(AchStatusEnum.FirstAudit.getId());
				fundProcess.setOperStatusName(AchStatusEnum.FirstAudit.getName());
	 		}else{
	 			fundDetail.setOperStatusId(AchStatusEnum.RollBack.getId());
	 			fundDetail.setOperStatusName(AchStatusEnum.RollBack.getName());
	 			fundProcess.setOperStatusId(AchStatusEnum.RollBack.getId());
	 			fundProcess.setOperStatusName(AchStatusEnum.RollBack.getName());
	 		}
			fundProcess.setFundProcessFlow(PkUtil.getUUID());
			fundProcess.setFundFlow(fundDetail.getFundFlow());
			GeneralMethod.setRecordInfo(fundProcess, true);
			
			fundProcess.setOperateTime(DateUtil.getCurrDateTime());
			fundProcess.setContent(content);
			SysUser currUser = GlobalContext.getCurrentUser();
			fundProcess.setOperateUserFlow(currUser.getUserFlow());
			fundProcess.setOperateUserName(currUser.getUserName());
			
			paymentBiz.updateDetailStatus(fundDetail,fundProcess);

 		return GlobalConstant.OPERATE_SUCCESSED;

	}
	 /**
	  * 更新报销详细
	 * @param detail
	 * @return
	 */
	@RequestMapping(value="/updateDetail")
	 @ResponseBody
	 public String updateDetail(SrmProjFundDetail detail){
		 if(detail!=null){
			 this.fundInfoDetailBiz.updateFundDetail(detail);
			 return GlobalConstant.OPRE_SUCCESSED;
		 }
		 return GlobalConstant.OPRE_FAIL;
	 }
	/**
	 * 删除报销明细
	 * @param fundDetailFlow
	 * @return
	 */
	@RequestMapping(value="/deleteDetail")
	@ResponseBody
	public String deleteDetail(String fundDetailFlow){
		if(StringUtil.isNotBlank(fundDetailFlow)){
			int deleteResult = this.fundInfoDetailBiz.deleteFundDetail(fundDetailFlow);
			if(deleteResult==1){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping(value="/showPaymentAudit")
	public String showPaymentAudit(SrmFundProcess process , Model model){
		List<SrmFundProcess> processList = this.funProcessBiz.searchFundProcesses(process);
		model.addAttribute("processList" , processList);
		return "/srm/payment/processInfo";
	}
}
