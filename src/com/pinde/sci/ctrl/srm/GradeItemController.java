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
import org.springframework.web.servlet.ModelAndView;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IGradeItemBiz;
import com.pinde.sci.biz.srm.IGradeSchemeBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.model.mo.SrmGradeItem;
import com.pinde.sci.model.mo.SrmGradeScheme;

@Controller
@RequestMapping("/srm/grade/item")
public class GradeItemController extends GeneralController {
	
	private static Logger logger=LoggerFactory.getLogger(GradeItemController.class);
	
	@Autowired
	private IGradeItemBiz gradeItemBiz;
	
	@Autowired 
	private IGradeSchemeBiz gradeSchemeBiz;
	/**
	 * 根据流水号编辑当前方案名称下的评分信息
	 * @param itemFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public String edit(String itemFlow, Model model){
		if(StringUtil.isNotBlank(itemFlow)){ 
			SrmGradeItem srmGradeItem=gradeItemBiz.readGradeItem(itemFlow);
			model.addAttribute("srmGradeItem",srmGradeItem);
		}
		return "srm/grade/item/edit";
	}
	
	@RequestMapping(value="/list2",method={RequestMethod.GET,RequestMethod.POST})
	public String list2(SrmGradeItem item , Model model){
		if(StringUtil.isNotBlank(item.getSchemeFlow())){
			SrmGradeScheme scheme =  this.gradeSchemeBiz.readGradeScheme(item.getSchemeFlow());
			SrmGradeItem gradeItem=new SrmGradeItem();
			gradeItem.setSchemeFlow(item.getSchemeFlow());
			List<SrmGradeItem> itemList = gradeItemBiz.searchGradeItem(item);
							
			model.addAttribute("itemList" , itemList);
			model.addAttribute("scheme" , scheme);
		}
		return "srm/grade/item/greadItemList";
	}
	
	
	/**
	 * 显示当前方案名称
	 * 获取当前下的方案名下的评分信息
	 * @param item
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method={RequestMethod.GET,RequestMethod.POST})
	public String list(SrmGradeItem item,Model model){
		SrmGradeScheme srmGradeScheme=new SrmGradeScheme();
		List<SrmGradeScheme> schemeList=gradeSchemeBiz.searchGradeScheme(srmGradeScheme);
		model.addAttribute("schemeList",schemeList);
		
		if(StringUtil.isNotBlank(item.getSchemeFlow())){
				SrmGradeItem gradeItem=new SrmGradeItem();
				gradeItem.setSchemeFlow(item.getSchemeFlow());
				List<SrmGradeItem> itemList = gradeItemBiz.searchGradeItem(item);
				model.addAttribute("itemList",itemList);			
		}
		return "srm/grade/item/list";
	}
	
	/**
	 * 增加方案下的评分信息
	 * @param item
	 * @return
	 */
	@RequestMapping(value="/saveItem",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String saveItem(SrmGradeItem item){
		//数据类型判断
		if(item.getItemScore()==null){
			return "评分项分值不能为空";
		}
		gradeItemBiz.saveGradeItem(item);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	/**
	 * 删除方案下的评分信息
	 * @param item
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	@ResponseBody
	public String delete(SrmGradeItem item){
		item.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		gradeItemBiz.saveGradeItem(item);
		return GlobalConstant.DELETE_SUCCESSED;
	}
}
