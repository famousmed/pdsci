package com.pinde.sci.ctrl.xjgl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduCourseMajorBiz;
import com.pinde.sci.biz.edu.IEduStudentCourseBiz;
import com.pinde.sci.biz.edu.IEduUserBiz;
import com.pinde.sci.biz.sys.ICfgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.model.edu.EduCourseMajorExt;
import com.pinde.sci.model.edu.EduStudentCourseExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysCfg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/xjgl/student/course")
public class XjglStudentCourseController extends GeneralController{
	@Autowired
	private IEduStudentCourseBiz studentCourseBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IEduCourseMajorBiz courseMajorBiz;
	@Autowired
	private IEduCourseBiz courseBiz;
	@Autowired
	private IEduUserBiz eduUserBiz;
	@Autowired
	private ICfgBiz cfgBiz;
	
	
	//**********************************学员****************************************
	/**
	 * 网上选课
	 * @return
	 */
	@RequestMapping(value="/interCourse")
	public String interCourse(String userFlow, Model model){
		SysCfg chooseCourseStartTimeCfg = cfgBiz.read("choose_course_start_time");
		SysCfg chooseCourseEndTimeCfg = cfgBiz.read("choose_course_end_time");
		model.addAttribute("chooseCourseStartTimeCfg", chooseCourseStartTimeCfg);
		model.addAttribute("chooseCourseEndTimeCfg", chooseCourseEndTimeCfg);
		if(StringUtil.isBlank(userFlow)){
			SysUser currUser =  GlobalContext.getCurrentUser();
			userFlow = currUser.getUserFlow();
		}
		EduUser eduUser = eduUserBiz.readEduUser(userFlow);
		model.addAttribute("eduUser", eduUser);
		SysUser sysUser = userBiz.readSysUser(userFlow);
		model.addAttribute("sysUser", sysUser);
		return "xjgl/student/interCourse";
	}
	
	/**
	 * 加载该年度该专业所有课程选择列表
	 * @param period
	 * @param majorId
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editCourseList")
	public String chooseCourseList(String period, String majorId, String userFlow, Model model){
		String planYear = period;
		List<EduCourseMajorExt> courseMajorExtList = courseMajorBiz.searchCourseMajorExtList(planYear, majorId);
		model.addAttribute("courseMajorExtList", courseMajorExtList);
		if(courseMajorExtList != null && !courseMajorExtList.isEmpty()){
			Map<String, Object> resultMap = courseMajorBiz.extractCourseMajorMap(period, courseMajorExtList);
			model.addAttribute("resultMap", resultMap);
		}
		//根据课程类别组织该用户所选课程对应的课程Map
		Map<String, Object> chooseCourseMap = studentCourseBiz.extractStudentCourseMapByUserFlow(period, userFlow);
		model.addAttribute("chooseCourseMap", chooseCourseMap);
		return "xjgl/student/editCourseList";
	}
	
	/**
	 * 加载已选课程列表
	 * @param period
	 * @param majorId
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/courseList")
	public String courseList(String studentPeriod, String userFlow, Model model){
		if(StringUtil.isNotBlank(studentPeriod) && StringUtil.isNotBlank(userFlow)){
			//该用户选课记录
			List<EduStudentCourseExt> studentCourseExtList = studentCourseBiz.searchStudentCourseExtList(studentPeriod, userFlow);
			model.addAttribute("studentCourseExtList", studentCourseExtList);
			Map<String, List<EduStudentCourseExt>> studentCourseMap = new LinkedHashMap<String, List<EduStudentCourseExt>>();
			for(EduStudentCourseExt escExt :studentCourseExtList){
				String courseTypeId = escExt.getCourseTypeId();
				List<EduStudentCourseExt> tempList = studentCourseMap.get(courseTypeId);
				if(tempList == null){
					tempList = new ArrayList<EduStudentCourseExt>();
				}
				tempList.add(escExt);
				studentCourseMap.put(courseTypeId, tempList);
			}
			model.addAttribute("studentCourseMap", studentCourseMap);
		}
		return "xjgl/student/courseList";
	}
	
	/**
	 * 提交选课
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping(value="/saveStudentCourse")
	@ResponseBody
	public String saveStudentCourse(String studentPeriod, String majorId, String[] courseFlow, String userFlow, String replenishFlag){
		List<String> courseFlowList = null;
		if(courseFlow != null && courseFlow.length > 0){
			courseFlowList = Arrays.asList(courseFlow);
		}
		int result = studentCourseBiz.saveStudentCourseByCourseFlowList(studentPeriod, majorId, userFlow, courseFlowList, replenishFlag);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 补选
	 * @return
	 */
	@RequestMapping(value="/replenish")
	public String replenish(String period, String majorId, String userFlow, Model model){
		String planYear = period;
		List<EduCourseMajorExt> courseMajorExtList = courseMajorBiz.searchReplenishCourseMajorExtList(planYear, majorId, userFlow);
		model.addAttribute("courseMajorExtList", courseMajorExtList);
		if(courseMajorExtList !=null && !courseMajorExtList.isEmpty()){
			Map<String, Object> resultMap = courseMajorBiz.extractCourseMajorMap(period, courseMajorExtList);
			model.addAttribute("resultMap", resultMap);
		}
		return "xjgl/student/replenishCourse";
	}

	//************************************** 平台  ***************************************************
	
	/**
	 * 选课管理
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/selectApproval")
	public String selectApproval(SysUser sysUser, EduUser eduUser, Integer currentPage, HttpServletRequest request, Model model){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String studentRoleFlow = InitConfig.getSysCfg("res_doctor_role_flow");//获取学员角色流水号
		/*if(StringUtil.isBlank(eduUser.getPeriod())){
			String period = InitConfig.getSysCfg("xjgl_curr_year");//当前届数
			eduUser.setPeriod(period);
		}*/
		paramMap.put("roleFlow", studentRoleFlow);
		paramMap.put("sysUser", sysUser);
		paramMap.put("eduUser", eduUser);
		PageHelper.startPage(currentPage, getPageSize(request));
		List<EduUserExt> eduUserExtList = eduUserBiz.searchEduUserExtList(paramMap);
		model.addAttribute("eduUserExtList", eduUserExtList);
		if(eduUserExtList != null && !eduUserExtList.isEmpty()){
			List<EduStudentCourseExt> studentCourseExtList = new ArrayList<EduStudentCourseExt>();
			for(EduUserExt euE : eduUserExtList){
				List<EduStudentCourseExt> tempList = studentCourseBiz.searchStudentCourseExtList(euE.getPeriod(), euE.getUserFlow());
				if(tempList != null && !tempList.isEmpty()){
					for(EduStudentCourseExt ext :tempList){
						studentCourseExtList.add(ext);
					}
				}
			}
			if(studentCourseExtList != null && !studentCourseExtList.isEmpty()){
				Map<String, Map<String, List<EduStudentCourseExt>>> studentCourseMap = new LinkedHashMap<String, Map<String, List<EduStudentCourseExt>>>();
				for(EduStudentCourseExt escExt :studentCourseExtList){
					String userFlow = escExt.getUserFlow();
					Map<String, List<EduStudentCourseExt>> tempUserCourseMap = studentCourseMap.get(userFlow);
					if(tempUserCourseMap == null){
						tempUserCourseMap = new HashMap<String, List<EduStudentCourseExt>>();
					}
					String courseTypeId = escExt.getCourseTypeId();
					List<EduStudentCourseExt> tempList = tempUserCourseMap.get(courseTypeId);
					if(tempList == null){
						tempList = new ArrayList<EduStudentCourseExt>();
					}
					tempList.add(escExt);
					tempUserCourseMap.put(courseTypeId, tempList);
					studentCourseMap.put(userFlow, tempUserCourseMap);
				}
				model.addAttribute("studentCourseMap", studentCourseMap);
			}
			
		}
		return "/xjgl/plat/selectApproval";
	}
	
	/**
	 * 课程维护
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/courseMaintain")
	public String courseMaintain(String userFlow, Model model){
		if(StringUtil.isNotBlank(userFlow)){
			EduUser eduUser = eduUserBiz.readEduUser(userFlow);
			model.addAttribute("eduUser", eduUser);
			SysUser sysUser = userBiz.readSysUser(userFlow);
			model.addAttribute("sysUser", sysUser);
		}
		return "xjgl/plat/courseMaintain";
	}
	
	/**
	 * 加载课程维护列表
	 * @param period
	 * @param majorId
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editCourseMaintain")
	public String editCourseMaintain(String period, String majorId, String userFlow, Model model){
		String planYear = period;
		List<EduCourseMajorExt> courseMajorExtList = courseMajorBiz.searchCourseMajorExtList(planYear, majorId);
		model.addAttribute("courseMajorExtList", courseMajorExtList);
		if(courseMajorExtList != null && !courseMajorExtList.isEmpty()){
			Map<String, Object> resultMap = courseMajorBiz.extractCourseMajorMap(period, courseMajorExtList);
			model.addAttribute("resultMap", resultMap);
		}
		//根据课程类别组织该用户所选课程对应的课程Map
		Map<String, Object> chooseCourseMap = studentCourseBiz.extractStudentCourseMapByUserFlow(period, userFlow);
		model.addAttribute("chooseCourseMap", chooseCourseMap);
		return "xjgl/plat/editCourseMaintain";
	}
	
	/**
	 * 保存课程维护
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveCourseMaintain")
	@ResponseBody
	public String saveCourseMaintain(EduStudentCourse studentCourse, String courseMajorRecordFlow, Model model){
		int result = studentCourseBiz.saveCourseMaintain(studentCourse, courseMajorRecordFlow);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
}
