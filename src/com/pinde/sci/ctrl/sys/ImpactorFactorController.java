package com.pinde.sci.ctrl.sys;

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

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IImpactorFactorBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.PubImpactorFactor;
/**
 * 
 * @author tiger
 *
 */
@Controller
@RequestMapping("/sys/impactorFactor")
public class ImpactorFactorController extends GeneralController{
	private static Logger logger=LoggerFactory.getLogger(ImpactorFactorController.class);
	
	@Autowired
   	private IImpactorFactorBiz impactorFactorBiz;
   
	@RequestMapping(value={"/importExcel"},method={RequestMethod.POST})
	@ResponseBody
	public String importExcel(PubFileForm fileForm , PubImpactorFactor factor,Model model){
		
		try {
			impactorFactorBiz.importExcel(fileForm,factor);
			return GlobalConstant.UPLOAD_SUCCESSED;
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
	
	@RequestMapping(value={"/list"},method={RequestMethod.GET,RequestMethod.POST})
	public String list(Integer currentPage,PubImpactorFactor factor,HttpServletRequest request,Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		
		List<PubImpactorFactor> impactorFactorList= impactorFactorBiz.queryImpactorFactorList(factor);
		model.addAttribute("impactorFactorList", impactorFactorList);

		return "sys/impactorFactor/list";
	}
	
	@RequestMapping(value={"/addImport"})
	public String addImport(){
		return "sys/impactorFactor/import";
	}
	
	@RequestMapping(value={"/getImpactorFactorByISSN"},method={RequestMethod.GET})
	@ResponseBody
	public PubImpactorFactor getImpactorFactorByISSN(String issn){
		List<PubImpactorFactor> factorList = impactorFactorBiz.getImpactorFactorByISSN(issn);
		if(factorList!=null && !factorList.isEmpty() ){
			return factorList.get(0);
		}
		return null;
	}
	
	@RequestMapping(value={"/getImpactorFactorByISSN2"},method={RequestMethod.GET})
	public String getImpactorFactorByISSN2(String issn,Model model){
		if(StringUtil.isNotBlank(issn)){
			List<PubImpactorFactor> factorList = impactorFactorBiz.getImpactorFactorByISSN(issn);
			model.addAttribute("factorList", factorList);
		}
		return "srm/ach/thesis/impactorFactor";
	}

}
