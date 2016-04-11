package com.pinde.sci.ctrl.srm;

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
import com.pinde.sci.biz.srm.IExpertGroupBiz;
import com.pinde.sci.biz.srm.IGradeSchemeBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.srm.EvaluationWayEnum;
import com.pinde.sci.model.mo.SrmExpertGroup;

@Controller
@RequestMapping("/srm/expert/group")
public class ExpertGroupController extends GeneralController {
	
	private static Logger logger=LoggerFactory.getLogger(ExpertGroupController.class);
	
	@Autowired
	private IExpertGroupBiz expertGroupBiz;
	@Autowired
	private IGradeSchemeBiz gradeSchemeBiz;
	
	/**
	 * list页面加载显示专家组信息
	 * @param expert
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method={RequestMethod.POST,RequestMethod.GET})
	public String list(Integer currentPage , SrmExpertGroup expert,HttpServletRequest request,Model model ){
		expert.setEvaluationWayId(EvaluationWayEnum.NetWorkWay.getId());
		PageHelper.startPage(currentPage, getPageSize(request));
		List<SrmExpertGroup> expertGroupList=expertGroupBiz.searchExpertGroup(expert);
		model.addAttribute("expertGroupList",expertGroupList);
		return "srm/expert/group/list";
	}
	
	
	/**
	 * 根据流水号查找专家组,进行编辑专家组信息
	 * @param groupFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method={RequestMethod.GET})
	public String edit(String groupFlow ,Model model){
		SrmExpertGroup srmExpertGroup=expertGroupBiz.readSrmExpertGroup(groupFlow);
		model.addAttribute("srmExpertGroup",srmExpertGroup);
		return "srm/expert/group/edit";
	}
	
	
	/**
	 * 增加专家组信息(网评)
	 * @param expert
	 * @return
	 */
	@RequestMapping(value={"/save"},method={RequestMethod.POST})
	@ResponseBody
	public String save(SrmExpertGroup expertGroup){
		expertGroup.setEvaluationWayId(EvaluationWayEnum.NetWorkWay.getId());
		expertGroup.setEvaluationWayName(EvaluationWayEnum.NetWorkWay.getName());
		expertGroupBiz.saveExpertGroup(expertGroup);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	/**
	 * 删除当前的专家组信息
	 * @param expert
	 * @return
	 */
	@RequestMapping(value="/delete",method={RequestMethod.GET})
	@ResponseBody
	public String delete(SrmExpertGroup expertGroup){
		expertGroup.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		expertGroupBiz.saveExpertGroup(expertGroup);
		return GlobalConstant.DELETE_SUCCESSED;
	}
}
