package com.pinde.sci.ctrl.srm;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundItemBiz;
import com.pinde.sci.biz.srm.IFundSchemeBiz;
import com.pinde.sci.biz.srm.IFundSchemeDetailBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.srm.FundItemInfo;
@Controller
@RequestMapping("/srm/fund/scheme/detail")
public class FundSchemeDetailController extends GeneralController {
	private static Logger logger=LoggerFactory.getLogger(FundSchemeDetailController.class);
	
	@Autowired
	private IFundItemBiz fundItemBiz;
	@Autowired
	private IFundSchemeBiz fundSchemeBiz;
	@Autowired
	private IFundSchemeDetailBiz fundSchemeDetailBiz;
	
	
	/**
	 * 查询未加入的经费项目
	 * @param schemeFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addFundItem",method={RequestMethod.GET})
	public String addFundItem(String schemeFlow,Model model){
		SrmFundScheme scheme =  this.fundSchemeBiz.readFundScheme(schemeFlow);
		List<FundItemInfo> fundItemInfoList = fundSchemeDetailBiz.searchSrmFundItemNotInBySchemeFlow(schemeFlow);
		model.addAttribute("fundItemInfoList",fundItemInfoList);
		model.addAttribute("scheme" , scheme);
		return "srm/fund/scheme/detail/addFundItem";
	}
	/**
	 * 查询对应的经费方案信息
	 */
	@RequestMapping(value="/list",method={RequestMethod.GET,RequestMethod.POST})
	public String list(SrmFundSchemeDetail fundSchemeDetail,Model model){
		SrmFundScheme fundScheme=new SrmFundScheme();
		List<SrmFundScheme> fundSchemeList=fundSchemeBiz.searchFundScheme(fundScheme);
		model.addAttribute("fundSchemeList",fundSchemeList);
		if(StringUtil.isNotBlank(fundSchemeDetail.getSchemeFlow())){
			SrmFundSchemeDetail srmFundSchemeDetail=new SrmFundSchemeDetail();
			srmFundSchemeDetail.setSchemeFlow(fundSchemeDetail.getSchemeFlow());
			List<FundItemInfo> fundItemInfoList=fundSchemeDetailBiz.searchFundSchemeDetailInfo(fundSchemeDetail);
			model.addAttribute("fundItemInfoList",fundItemInfoList);
		}
		return "srm/fund/scheme/detail/list";
	}
	
	
	@RequestMapping(value="/list2",method={RequestMethod.GET,RequestMethod.POST})
	public String list2(SrmFundScheme fundScheme , Model model){
		SrmFundScheme scheme =  this.fundSchemeBiz.readFundScheme(fundScheme.getSchemeFlow());
		List<SrmFundSchemeDetail> itemList = null;
		if(StringUtil.isNotBlank(fundScheme.getSchemeFlow())){
				SrmFundSchemeDetail schemeDtl=new SrmFundSchemeDetail();
				schemeDtl.setSchemeFlow(fundScheme.getSchemeFlow());
				itemList = fundSchemeDetailBiz.searchFundSchemeDetail(schemeDtl);
							
		}
		model.addAttribute("itemList" , itemList);
		model.addAttribute("scheme" , scheme);
		return "srm/fund/scheme/detail/list";
	}
}
