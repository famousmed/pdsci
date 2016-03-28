package com.pinde.sci.ctrl.inx;


import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.inx.IinxInfoManageBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.form.inx.InxInfoForm;
import com.pinde.sci.model.inx.InxInfoExt;
import com.pinde.sci.model.mo.InxInfo;
@Controller
@RequestMapping("/inx/manage/info")
public class InxInfoManageController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(InxInfoManageController.class);
	@Autowired
	private IinxInfoManageBiz infoManageBiz;
	
	/**
	 * 显示新增界面
	 * @return
	 */
	@RequestMapping(value="/add")
	public String showAdd(Model model){
		String imageBaseUrl = this.infoManageBiz.getImageBaseUrl();
		model.addAttribute("imageBaseUrl", imageBaseUrl);
		return "inx/manage/editInfo";
	}
	/**
	 * 显示编辑界面
	 * @param infoFlow
	 * @return
	 */
	@RequestMapping(value="/showEdit")
	public ModelAndView showEdit(String infoFlow,String flag){
		InxInfoExt info = null;
		if(StringUtil.isNotBlank(infoFlow)){
			info = this.infoManageBiz.getExtByFlow(infoFlow);
		}
		ModelAndView mav = new ModelAndView("inx/manage/editInfo");
		if("show".equals(flag)||"pass".equals(flag)){
			mav.setViewName("inx/manage/viewInfo");
			mav.addObject("flag", flag);
		}
		String imageBaseUrl = this.infoManageBiz.getImageBaseUrl();
		mav.addObject("imageBaseUrl", imageBaseUrl);
		mav.addObject("info", info);
		
		return mav;
	}
	
	/**
	 * 保存资讯
	 * @param info 资讯
	 * @return
	 */
	@RequestMapping(value="/save")
	public @ResponseBody String save(InxInfo info){
		if(StringUtil.isNotBlank(info.getInfoFlow())){//更新
			return updateInfo(info);
		}
		return addInfo(info);
	}
	/**
	 * 新增资讯
	 * @param info
	 * @return
	 */
	public  String addInfo(InxInfo info){
		if(checkInput(info)){
			int saveResult = this.infoManageBiz.save(info);
			if(saveResult==GlobalConstant.ONE_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 修改资讯
	 * @param info
	 * @return
	 */
	public  String updateInfo(InxInfo info){
		if(checkUpdateInput(info)){
			int updateResult = this.infoManageBiz.update(info);
			if(updateResult==GlobalConstant.ONE_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 图片上传
	 * @param file 文件
	 * @return
	 */
	@RequestMapping(value="/uploadImg")
	public @ResponseBody String uploadImg(HttpServletRequest request){
		return this.infoManageBiz.uploadImg(request, "imageFile");
	}
	
	/**
	 * 校验前端输入
	 * @param info
	 * @return
	 */
	private boolean checkInput(InxInfo info){
		if(info==null){
			return false;
		}
		if(StringUtil.isEmpty(info.getInfoTitle())||StringUtil.isBlank(info.getInfoTitle())){
			return false;
		}
		if(StringUtil.isEmpty(info.getColumnId())||StringUtil.isBlank(info.getColumnId())){
			return false;
		}
		if(StringUtil.isEmpty(info.getInfoTime())||StringUtil.isBlank(info.getInfoTime())){
			return false;
		}
		return true;
	}
	/**
	 * 校验前端输入
	 * @param info
	 * @return
	 */
	private boolean checkUpdateInput(InxInfo info){
		if(info==null){
			return false;
		}
		if(StringUtil.isEmpty(info.getInfoFlow())||StringUtil.isBlank(info.getInfoFlow())){
			return false;
		}
		if(StringUtil.isEmpty(info.getInfoTitle())||StringUtil.isBlank(info.getInfoTitle())){
			return false;
		}
		if(StringUtil.isEmpty(info.getColumnId())||StringUtil.isBlank(info.getColumnId())){
			return false;
		}
		if(StringUtil.isEmpty(info.getInfoTime())||StringUtil.isBlank(info.getInfoTime())){
			return false;
		}
		return true;
	}
	/**
	 * 资讯列表
	 * @param currentPage 当前页索引
	 * @param form 参数封装
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list")
	public String getInfoList(Integer currentPage,InxInfoForm form,HttpServletRequest request,Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<InxInfo> infoList = this.infoManageBiz.getList(form);
		model.addAttribute("infoList", infoList);
		return "inx/manage/infoList";
	}
	/**
	 * 更新记录状态
	 * @param flows
	 * @return
	 */
	@RequestMapping(value="/updateStatus")
	public @ResponseBody String updateStatus(String [] flows,String infoStatusId){
		if(flows!=null&&flows.length>0){
			List<String> infoFlows = Arrays.asList(flows);
			int delResult = this.infoManageBiz.updateInfoStatus(infoFlows,infoStatusId);
		  if(delResult>GlobalConstant.ZERO_LINE){
			  return GlobalConstant.OPRE_SUCCESSED;
		  }
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 删除标题图片
	 * @param infoFlow
	 * @return
	 */
	@RequestMapping(value="/deleteImg")
	public @ResponseBody String deleteTitleImg(String infoFlow){
		if(StringUtil.isNotBlank(infoFlow)){
		  int delResult = this.infoManageBiz.deleteTitleImg(infoFlow);
		  if(delResult==GlobalConstant.ONE_LINE){
			  return GlobalConstant.DELETE_SUCCESSED;
		  }
		}
		return GlobalConstant.DELETE_FAIL;
	}
	/**
	 * 资讯失效
	 * @param info
	 * @return
	 */
	@RequestMapping(value="/updateRecordStatus")
	public @ResponseBody String updateRecordStatus(InxInfo info){
		int updateResult =  this.infoManageBiz.update(info);
		if(updateResult==GlobalConstant.ONE_LINE){
			  return GlobalConstant.OPRE_SUCCESSED;
		  }
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 修改资讯
	 * @param info
	 * @return
	 */
	@RequestMapping(value="/modifyInxInfo")
	public @ResponseBody String modifyInxInfo(InxInfo info){
		int result =  infoManageBiz.modifyInxInfo(info);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
}
