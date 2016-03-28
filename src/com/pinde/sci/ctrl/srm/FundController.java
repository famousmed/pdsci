package com.pinde.sci.ctrl.srm;

import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.FundInfoExt;
import com.pinde.sci.model.srm.FundSum;

/**
 *项目经费
 */
@Controller
@RequestMapping("/srm/fund")
public class FundController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(FundController.class);
	@Autowired
	private IFundBiz fundBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;
	
	/**
	 * 到账列表
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/accountsList/{projListScope}")
	public String accountsList(PubProj proj,Model model,@PathVariable(value="projListScope") String projListScope, String currentPage) {
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, ProjCategroyEnum.Ky.getId());//暂时加上的
		SysUser currUser = GlobalContext.getCurrentUser();
		if(GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL.equals(projListScope)){
			proj.setApplyUserFlow(currUser.getUserFlow());
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
			proj.setApplyOrgFlow(currUser.getOrgFlow());
		}
		
		List<FundInfoExt> funds = this.fundBiz.getList(proj);
		model.addAttribute("funds", funds);
		return "srm/fund/accountsList";
	}
	/**
	 * 经费列表
	 * @param proj
	 * @param flag
	 * @param model
	 * @param currentPage
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list/{projListScope}")
	public String list(PubProj proj,@PathVariable(value="projListScope") String projListScope,Model model,String currentPage){
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		SysUser currUser = GlobalContext.getCurrentUser();
		if(GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL.equals(projListScope)){
			proj.setApplyUserFlow(currUser.getUserFlow());
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
			proj.setApplyOrgFlow(currUser.getOrgFlow());
		}
		List<FundInfoExt> funds = this.fundBiz.getList(proj);
		FundSum fundSum = this.fundBiz.getFundSum(funds);//经费总计
		model.addAttribute("funds", funds);
		model.addAttribute("fundSum", fundSum);
		return "srm/fund/fundList";
	}
	/**
	 * 到账明细
	 * @param fundFlow 经费流水号
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/details")
	public String details(String fundFlow ,String projFlow ,Model model){
		if(StringUtil.isNotBlank(fundFlow)){
			List<SrmProjFundDetail> details = this.fundBiz.getDetails(fundFlow);
			model.addAttribute("details", details);
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			model.addAttribute("proj" , proj);
			
		}
		return "srm/fund/accountsDetails";
	}
	/**
	 * 保存到账明细
	 * @param details
	 * @return
	 */
	@RequestMapping(value="/saveDetail")
	public @ResponseBody String saveDetail(@RequestBody List<SrmProjFundDetail> details ){
		if(details!=null){
			for (int i = 0; i < details.size(); i++) {
				this.fundBiz.saveDetail(details.get(i));
			}
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value="/delDetail")
	@ResponseBody
	public String delDetail(String fundDetailFlow){
		this.fundBiz.delDetailByFundDetailFlow(fundDetailFlow);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	@RequestMapping(value="/getDetail")
	public String getDetail(String fundFlow, Model model){
		FundInfoExt fundExt =  this.fundBiz.getFundExt(fundFlow);
		model.addAttribute("fundExt", fundExt);
		return "srm/fund/fundDetail";
	}
}
