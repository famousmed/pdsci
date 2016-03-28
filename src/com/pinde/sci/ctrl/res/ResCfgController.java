package com.pinde.sci.ctrl.res;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResAssessCfgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.form.res.ResAssessCfgForm;
import com.pinde.sci.form.res.ResAssessCfgItemForm;
import com.pinde.sci.form.res.ResAssessCfgTitleForm;
import com.pinde.sci.model.mo.ResAssessCfg;
import com.pinde.sci.model.mo.SysUser;
/**
 * 
 * @author tiger
 *
 */
@Controller
@RequestMapping("/res/cfg")
public class ResCfgController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(ResCfgController.class);
	
	@Resource
	private IResAssessCfgBiz assessCfgBiz;
	
	/**
	 * 跳转至考核指标配置
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/assessCfg")
	public String assessCfg(String cfgCodeId,Model model) throws Exception{
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser != null && StringUtil.isNotBlank(cfgCodeId)){
			ResAssessCfg search = new ResAssessCfg();
			search.setCfgCodeId(cfgCodeId);
			search.setOrgFlow(currUser.getOrgFlow());
			List<ResAssessCfg> assessCfgList = assessCfgBiz.searchAssessCfgList(search);
			if(assessCfgList != null && !assessCfgList.isEmpty()){
				ResAssessCfg assessCfg = assessCfgList.get(0);
				Document dom = DocumentHelper.parseText(assessCfg.getCfgBigValue());
				String titleXpath = "//title";
				List<Element> titleElementList = dom.selectNodes(titleXpath);
				if(titleElementList != null && !titleElementList.isEmpty()){
					List<ResAssessCfgTitleForm> titleFormList = new ArrayList<ResAssessCfgTitleForm>();
					for(Element te :titleElementList){
						ResAssessCfgTitleForm titleForm = new ResAssessCfgTitleForm();
						titleForm.setId(te.attributeValue("id"));
						titleForm.setName(te.attributeValue("name"));
						List<Element> itemElementList = te.elements("item");
						List<ResAssessCfgItemForm> itemFormList = null;
						if(itemElementList != null && !itemElementList.isEmpty()){
							itemFormList = new ArrayList<ResAssessCfgItemForm>();
							for(Element ie : itemElementList){
								ResAssessCfgItemForm itemForm = new ResAssessCfgItemForm();
								itemForm.setId(ie.attributeValue("id"));
								itemForm.setName(ie.element("name") == null ? "" : ie.element("name").getTextTrim());
								itemForm.setScore(ie.element("score") == null ? "" : ie.element("score").getTextTrim());
								itemFormList.add(itemForm);
							}
						}
						titleForm.setItemList(itemFormList);
						titleFormList.add(titleForm);
					}
					model.addAttribute("titleFormList", titleFormList);
				}
				model.addAttribute("assessCfg", assessCfg);
			}
		}
		return "res/cfg/assessCfg";
	}
	
	/**
	 * 保存考核指标标题
	 * @param cfgCodeId
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveAssessTitle")
	@ResponseBody
	public String saveAssessTitle(ResAssessCfg assessCfg, ResAssessCfgTitleForm titleForm) throws Exception{
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser != null){
			int result = assessCfgBiz.editAssessCfgTitle(assessCfg, titleForm);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 删除考核指标标题
	 * @param cfgFlow
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteTitle")
	@ResponseBody
	public String deleteTitle(String cfgFlow, String id) throws Exception{
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser != null){
			int result = assessCfgBiz.deleteTitle(cfgFlow, id);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	//*********************************************************************
	
	/**
	 * 保存考核指标列表
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveAssessItemList")
	@ResponseBody
	public String saveAssessItemList(@RequestBody ResAssessCfgForm form) throws Exception{
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser != null){
			int result = assessCfgBiz.saveAssessItemList(form);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 修改考试指标
	 * @param cfgFlow
	 * @param itemForm
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/modifyItem")
	@ResponseBody
	public String modifyItem(String cfgFlow, ResAssessCfgItemForm itemForm) throws Exception{
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser != null){
			int result = assessCfgBiz.modifyItem(cfgFlow, itemForm);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 删除考试指标
	 * @param cfgFlow
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteItem")
	@ResponseBody
	public String deleteItem(String cfgFlow, String id) throws Exception{
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser != null){
			int result = assessCfgBiz.deleteItem(cfgFlow, id);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
}
