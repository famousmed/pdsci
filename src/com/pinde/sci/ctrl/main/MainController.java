package com.pinde.sci.ctrl.main;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.core.config.WorkStation;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.model.mo.SysUser;

@Controller
public class MainController extends GeneralController {
	
	private static Logger logger = LoggerFactory.getLogger(MainController.class);
	@Resource
	private IResDoctorBiz resDoctorBiz;
	
	/**
	 * 显示主页面，未选定工作站和模块
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/main" })
	public String main(HttpServletRequest request,Model model) {
		//清空当前选中的工作站和模块
		setSessionAttribute(GlobalConstant.CURRENT_WS_ID, null);
		setSessionAttribute(GlobalConstant.CURRENT_MODULE_ID, null);
		setSessionAttribute("currModuleView", null);	
		setSessionAttribute("mainFrameSrc", null);
		
		SysUser user = GlobalContext.getCurrentUser();
		List<String> currUserWorkStationIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST);
		if(!GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
			if (currUserWorkStationIdList != null && currUserWorkStationIdList.size() == 1) {
				return "redirect:/main/"+currUserWorkStationIdList.get(0);
			}
		}
		
		List<WorkStation> workStationList = (List<WorkStation>) request.getServletContext().getAttribute("workStationList");
		if (GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())) {
			model.addAttribute("currUserWorkStationList", workStationList);
		} else {
			if (currUserWorkStationIdList != null && currUserWorkStationIdList.size() >0) {
				//重新组织当前用户有权限的工作站
				List<WorkStation> currUserWorkStationList = new ArrayList<WorkStation>();
				if (workStationList != null && workStationList.size() > 0) {
					for (WorkStation station:workStationList) {
						if (currUserWorkStationIdList.indexOf(station.getWorkStationId())>-1) {
							currUserWorkStationList.add(station);
						}
					}
				}
				model.addAttribute("currUserWorkStationList", currUserWorkStationList);
			}
		}
		
		return "station";
	}
	
	/**
	 * 显示主页面，未选定工作站和模块
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/main/select" })
	public String select(HttpServletRequest request,Model model) {
		//清空当前选中的工作站和模块
//		setSessionAttribute(GlobalConstant.CURRENT_WS_ID, null);
//		setSessionAttribute(GlobalConstant.CURRENT_MODULE_ID, null);
//		setSessionAttribute("currModuleView", null);	
//		setSessionAttribute("mainFrameSrc", null);
		
		SysUser user = GlobalContext.getCurrentUser();
		List<String> currUserWorkStationIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST);
		List<WorkStation> workStationList = (List<WorkStation>) request.getServletContext().getAttribute("workStationList");
		if (GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())) {
			model.addAttribute("currUserWorkStationList", workStationList);
		} else {
			if (currUserWorkStationIdList != null && currUserWorkStationIdList.size() >0) {
				//重新组织当前用户有权限的工作站
				List<WorkStation> currUserWorkStationList = new ArrayList<WorkStation>();
				if (workStationList != null && workStationList.size() > 0) {
					for (WorkStation station:workStationList) {
						if (currUserWorkStationIdList.indexOf(station.getWorkStationId())>-1) {
							currUserWorkStationList.add(station);
						}
					}
				}
				model.addAttribute("currUserWorkStationList", currUserWorkStationList);
			}
		}
		return "select";
	}
	
	/**
	 * 显示主页面
	 * @param workStationId 选中的工作ID
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/main/{workStationId}" })
	public String main(@PathVariable String workStationId,HttpServletRequest request,Model model) {
		setSessionAttribute(GlobalConstant.CURRENT_WS_ID, workStationId);
		setSessionAttribute(GlobalConstant.CURRENT_MODULE_ID, null);
		setSessionAttribute("currModuleView", null);	
		setSessionAttribute("mainFrameSrc", null);
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, null);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, null);
		return "main";
	}
	
	/**
	 * 显示主页面
	 * @param workStationId 选中的工作ID
	 * @param moduleId 选中的模块ID
	 * @param request
	 * @param model
	 * @return
	 */
	
	@RequestMapping(value = {"/main/{workStationId}/{moduleId}" })
	public String main(@PathVariable String workStationId,@PathVariable String moduleId,HttpServletRequest request,Model model) {
		//换模块后，主页设置为空
		if(!moduleId.equals(getSessionAttribute(GlobalConstant.CURRENT_MODULE_ID))){
//			setSessionAttribute("currModuleView", null);				
		}
		setSessionAttribute(GlobalConstant.CURRENT_WS_ID, workStationId);
		setSessionAttribute(GlobalConstant.CURRENT_MODULE_ID, moduleId);
		setSessionAttribute("mainFrameSrc", null);	
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, null);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, null);
		
		
		return "main";
	}
	
}
