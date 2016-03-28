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
import com.pinde.sci.model.mo.SrmFundItem;
import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmGradeItem;
import com.pinde.sci.model.mo.SrmGradeScheme;

@Controller
@RequestMapping("/srm/fund/item")
public class FundItemControrller extends GeneralController {
	
	private static Logger logger=LoggerFactory.getLogger(FundItemControrller.class);
	
	@Autowired
	private IFundItemBiz fundItemBiz;
	@Autowired
	private IFundSchemeBiz fundSchemeBiz;
	@Autowired
	private IFundSchemeDetailBiz fundSchemeDtlBiz;
	/**
	 * 编辑评分经费信息
	 * @param itemFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public String edit(String itemFlow,Model model){
		SrmFundItem srmFundItem=fundItemBiz.readFundItem(itemFlow);
		model.addAttribute("srmFundItem",srmFundItem);
		return "srm/fund/item/edit";
	}
	/**
	 * 页面加载评分经费信息
	 * @param item
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method={RequestMethod.GET,RequestMethod.POST})
	public String list(SrmFundItem item,Model model){
		List<SrmFundItem> fundItemList=fundItemBiz.searchFundItem(item);
		model.addAttribute("fundItemList",fundItemList);
		return "srm/fund/item/list";
	}
	/**
	 * 添加评分经费信息
	 * @param item
	 * @return
	 */
	@RequestMapping(value="/saveFund",method=RequestMethod.POST)
	@ResponseBody
	public  String saveFund(SrmFundItem item){
		fundItemBiz.saveFundItem(item);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	/**
	 * 删除评分评分信息
	 * @param item
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	@ResponseBody
	public  String delete(SrmFundItem item){
		item.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		fundItemBiz.saveFundItem(item);
		return GlobalConstant.DELETE_SUCCESSED;
	} 
	
	
	
}
