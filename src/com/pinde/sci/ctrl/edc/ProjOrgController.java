package com.pinde.sci.ctrl.edc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;

@Controller
@RequestMapping("/edc/projOrg")
public class ProjOrgController extends GeneralController {	
	private static Logger logger=LoggerFactory.getLogger(ProjOrgController.class);
	
	@Autowired
	private IProjOrgBiz projOrgBiz;
	
	@RequestMapping(value = "/list",method={RequestMethod.GET})
	public String listLocal(HttpServletRequest request,Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = edcCurrProj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.search(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		return "edc/projOrg/list";
	}
	
	@RequestMapping(value = "/edit",method={RequestMethod.GET})
	public String edit(String recordFlow,Model model){
		if(StringUtil.isNotBlank(recordFlow)){
			PubProjOrg projOrg=projOrgBiz.read(recordFlow);
			model.addAttribute("projOrg", projOrg);
		}
		return "edc/projOrg/edit";
	} 
	
	
	@RequestMapping(value = "/saveOrgConfirm",method={RequestMethod.GET})
	@ResponseBody
	public String saveOrgConfirm(String recordFlow, String orgFlow, int centerNo, Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = edcCurrProj.getProjFlow();
		//校验机构是否重复添加	
		PubProjOrg  projOrg = projOrgBiz.readProjOrg(projFlow,orgFlow);
		if(projOrg != null && !recordFlow.equals(projOrg.getRecordFlow())){
			return "orgError"; 
		}
		//校验中心号是否重复
		List<PubProjOrg> projOrgList = projOrgBiz.search(projFlow);
		if (projOrgList != null) {
			for (PubProjOrg temp:projOrgList) {
				int centerNoTemp = temp.getCenterNo();
				if ((centerNoTemp == centerNo) && (orgFlow != null && !orgFlow.equals(temp.getOrgFlow()))) {
					return "centerNoError"; 
				}
			}
		}
		
		
		return GlobalConstant.OPRE_SUCCESSED;	
	} 
	
	@RequestMapping(value = "/save",method={RequestMethod.POST})
	@ResponseBody
	public String save(PubProjOrg projOrg,Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = edcCurrProj.getProjFlow();
		projOrg.setProjFlow(projFlow);
		projOrg.setOrgName(InitConfig.getOrgNameByFlow(projOrg.getOrgFlow()));	
		if(StringUtil.isBlank(projOrg.getRecordFlow())){
			projOrgBiz.add(projOrg);
		}else{
			projOrgBiz.mod(projOrg);
		}
		return GlobalConstant.SAVE_SUCCESSED;	
	} 
	
	@RequestMapping(value = "/del",method={RequestMethod.GET})
	@ResponseBody
	public String orgDel(PubProjOrg projOrg,Model model){

		projOrgBiz.del(projOrg);
		return GlobalConstant.OPERATE_SUCCESSED;	
	} 
}
