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
import com.pinde.sci.biz.srm.IGradeSchemeBiz;
import com.pinde.sci.biz.srm.impl.GradeSchemeBizImpl;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.srm.EvaluationEnum;
import com.pinde.sci.model.mo.SrmGradeScheme;

@Controller
@RequestMapping("/srm/grade/scheme")
public class GradeSchemeController  extends GeneralController{
	
	private static Logger logger=LoggerFactory.getLogger(GradeSchemeBizImpl.class);
	
	@Autowired
	private IGradeSchemeBiz gradeSchemeBiz;
	/**
	 * 编辑项目方案信息
	 * @param schemeFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public String edit(String schemeFlow,Model model){
		if(StringUtil.isNotBlank(schemeFlow)){
			SrmGradeScheme srmGradeScheme=gradeSchemeBiz.readGradeScheme(schemeFlow);
			model.addAttribute("srmGradeScheme",srmGradeScheme);
		}
		return "srm/grade/scheme/edit";
	}
	/**
	 * 页面加载项目方案信息
	 * @param scheme
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method={RequestMethod.GET,RequestMethod.POST})
	public String list(SrmGradeScheme scheme,Model model){
		List<SrmGradeScheme> schemeList=gradeSchemeBiz.searchGradeScheme(scheme);
		model.addAttribute("schemeList",schemeList);
		return "srm/grade/scheme/list";
	}
	/**
	 * 添加项目方案信息
	 * @param scheme
	 * @return
	 */
	@RequestMapping(value="/saveGradeScheme",method=RequestMethod.POST)
	@ResponseBody
	public  String saveGradeScheme(SrmGradeScheme scheme){
		scheme.setEvaluationName(EvaluationEnum.getNameById(scheme.getEvaluationId()));
		gradeSchemeBiz.saveGradeScheme(scheme);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	/**
	 * 删除项目方案信息
	 * @param scheme
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	@ResponseBody
	public  String delete(SrmGradeScheme scheme){
		scheme.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		gradeSchemeBiz.saveGradeScheme(scheme);
		return GlobalConstant.DELETE_SUCCESSED;
	}
}
