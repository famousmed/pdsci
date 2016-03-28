package com.pinde.sci.ctrl.resedu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduStudentCourseBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.ILogBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.edu.EduCourseTypeEnum;
import com.pinde.sci.enums.edu.EduStudyStatusEnum;
import com.pinde.sci.enums.sys.OperTypeEnum;
import com.pinde.sci.form.edu.EduStudentCourseForm;
import com.pinde.sci.form.edu.StudentCourseNumForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserDept;

@Controller
@RequestMapping("resedu/report")
public class ResEduReportController extends GeneralController{

	@Autowired
	private IEduCourseBiz courseBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IEduStudentCourseBiz studentCourseBiz;
	@Autowired
	private ILogBiz logBiz;
	@Autowired
	private IResDoctorBiz doctorBiz;
	@Autowired
	private IDeptBiz deptBiz;

		
	@RequestMapping("/studentStatistics/{roleFlag}")
	public String studentStatistics(@PathVariable String roleFlag,Model model,EduCourse eduCourse,ResDoctor resDoctor,SysUser sysUser,Integer currentPage, HttpServletRequest request){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, roleFlag);
		SysUser user = GlobalContext.getCurrentUser();
		List<String> deptList=new ArrayList<String>();
		List<SysDept> orgFlowdeptList=null;
		List<EduCourseExt> eduCourseList=null;
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			
		}
		if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			deptList.add(user.getDeptFlow());
		}
		if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(roleFlag)){
			List<SysUserDept> sysUserDeptFlowList=userBiz.getUserDept(user);
			for (SysUserDept sysUserDept : sysUserDeptFlowList) {
				deptList.add(sysUserDept.getDeptFlow());
			}
			orgFlowdeptList=deptBiz.searchDeptByFlows(deptList);
		}
		if(GlobalConstant.RES_ROLE_SCOPE_ADMIN.equals(roleFlag)){
			orgFlowdeptList=deptBiz.searchDeptByOrg(user.getOrgFlow());
			for (SysDept sysDept : orgFlowdeptList) {
				deptList.add(sysDept.getDeptFlow());
			}
		}
		
		PageHelper.startPage(currentPage,getPageSize(request));
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			eduCourseList=courseBiz.selectCourseList(user.getUserFlow(),deptList,eduCourse,resDoctor,sysUser);
		}else{
			eduCourseList=courseBiz.selectCourseList(null,deptList,eduCourse,resDoctor,sysUser);
		}
		Map<String,Map<String,Object>> studentCourseMap=studentCourseBiz.courseFlowStudentCourseMap(eduCourseList);
		Map<String,Map<String,Object>> sysUserMap=userBiz.courseFlowSysUserMap(eduCourseList);
		Map<String,Map<String,Object>> resdoctorMap=doctorBiz.courseFlowResDoctorMap(eduCourseList);
		model.addAttribute("orgFlowdeptList",orgFlowdeptList);
		model.addAttribute("resdoctorMap",resdoctorMap);
		model.addAttribute("sysUserMap",sysUserMap);
		model.addAttribute("eduCourseList",eduCourseList);
		model.addAttribute("studentCourseMap",studentCourseMap);
		return "res/edu/report/studentStatistics";
	}
	
	
	
	/**
	 *课程情况统计
	 */
	@RequestMapping("/courseStatistics/{roleFlag}")
	public String courseStatistics(@PathVariable String roleFlag,Integer currentPage,EduCourse course,String startDate,String endDate,
			HttpServletRequest request,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, roleFlag);
		SysUser user = GlobalContext.getCurrentUser();
		List<String> courseFlowList=new ArrayList<String>();
		List<String> deptFlow=new ArrayList<String>();
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			
		}
		if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			deptFlow.add(user.getDeptFlow());
		}
		if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(roleFlag)){
			deptFlow.clear();
			List<SysUserDept> sysUserDeptFlowList=userBiz.getUserDept(user);
			for (SysUserDept sysUserDept : sysUserDeptFlowList) {
				deptFlow.add(sysUserDept.getDeptFlow());
			}
		}
		if(GlobalConstant.RES_ROLE_SCOPE_ADMIN.equals(roleFlag)){
			deptFlow.clear();
			List<SysDept> orgFlowdeptList=deptBiz.searchDeptByOrg(user.getOrgFlow());
			for (SysDept sysDept : orgFlowdeptList) {
				deptFlow.add(sysDept.getDeptFlow());
			}
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		List<EduCourse> selectCourse=null;
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			selectCourse=courseBiz.selectCourse(user.getUserFlow(),course,deptFlow);
			for (EduCourse educourse : selectCourse) {
				courseFlowList.add(educourse.getCourseFlow());
			}
		}else{
			selectCourse=courseBiz.selectCourse(null,course,deptFlow);
			for (EduCourse educourse : selectCourse) {
				courseFlowList.add(educourse.getCourseFlow());
			}
		}
		
		
		if (courseFlowList != null && !courseFlowList.isEmpty()) {
			Map<String, Map<String, Object>> studentCourseMap = studentCourseBiz.studentCourseListMap(courseFlowList);
			model.addAttribute("eduCourseList", selectCourse);
			model.addAttribute("studentCourseMap", studentCourseMap);
		}
		return "res/edu/report/courseStatistics";
	}
	
	/**
	 * 课程历史修改记录
	 */
	@RequestMapping("/updateLog")
	public String sysLog(String courseFlow,Model model){
		EduCourse course = courseBiz.readCourse(courseFlow);
		model.addAttribute("course",course);
		
		SysLog log = new SysLog();
		log.setResourceFlow(courseFlow);
		List<SysLog> logs = logBiz.searcherLog(log);
		model.addAttribute("logs",logs);
		
		return "res/edu/report/updateLog";
	}
	
	@RequestMapping("/scoreDetail")
	public String scoreDetail(String courseFlow,Model model){
		EduCourse course = courseBiz.readCourse(courseFlow);
		model.addAttribute("course",course);
		
		EduStudentCourse stc = new EduStudentCourse();
		stc.setCourseFlow(courseFlow);
		stc.setCourseTypeId(EduCourseTypeEnum.Required.getId());//只查看必须人员的考试情况
		stc.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<EduStudentCourse> stuCourses = studentCourseBiz.searchStudentCourseList(stc);
		model.addAttribute("stuCourses",stuCourses);
		
		if (stuCourses != null && stuCourses.size() >0 ) {
			//组织学生基本信息Map
			Map<String,SysUser> userMap = new HashMap<String, SysUser>();
			Map<String,ResDoctor> doctorMap = new HashMap<String, ResDoctor>();
			
			List<String> userFlowList = new ArrayList<String>();
			for (EduStudentCourse temp:stuCourses) {
				if (userFlowList.indexOf(temp.getUserFlow())<0) {
					userFlowList.add(temp.getUserFlow());
				}
			}
			List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlowList);
			if (doctorList != null && doctorList.size() >0) {
				for (ResDoctor doc:doctorList) {
					doctorMap.put(doc.getDoctorFlow(), doc);
				}
			}
			List<SysUser> userList = userBiz.searchSysUserByuserFlows(userFlowList);
			if (userList != null && userList.size() >0) {
				for (SysUser user:userList) {
					userMap.put(user.getUserFlow(), user);
				}
			}
			model.addAttribute("userMap",userMap);
			model.addAttribute("doctorMap",doctorMap);
		}
		
		return "res/edu/report/scoreDetail";
	}
	
	/**
	 * 操作日志
	 */
	@RequestMapping("/sysLog")
	public String sysLog(Integer currentPage, Model model,String logTime,SysLog log,HttpServletRequest request) {
		List<SysDept> deptList=searchDeptList();
		model.addAttribute("deptList", deptList);
		
		PageHelper.startPage(currentPage, getPageSize(request));
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("deptFlow", StringUtil.defaultString(log.getDeptFlow()));
		logTime = StringUtil.defaultString(logTime);
		model.addAttribute("logTime",logTime);
		if (StringUtil.isNotBlank(logTime)) {
			logTime = DateUtil.transDateTime(logTime,"yyyy-MM","yyyyMM");
		}
		paramMap.put("logTime", StringUtil.defaultString(logTime));
		List<String> wsIds = new ArrayList<String>();
		wsIds.add(GlobalConstant.SYS_WS_ID);
		wsIds.add(GlobalContext.getCurrentWsId());
		paramMap.put("wsIds", wsIds);
		
		List<String> operIds = new ArrayList<String>();
		operIds.add(OperTypeEnum.LogIn.getId());
		operIds.add(OperTypeEnum.LogOut.getId());
		paramMap.put("operIds", operIds);
		List<SysLog> logs = logBiz.searchLog(paramMap);
		
		List<String> userFlowList = new ArrayList<String>();
		List<SysLog> newLogs = new ArrayList<SysLog>();
		Map<String,Object> parMap = new HashMap<String, Object>();
		if (logs != null && logs.size() > 0) {
			for (SysLog temp:logs) {
				String userFlow = temp.getUserFlow();
				String logNum = (String)parMap.get("logNum_"+userFlow);
				if (StringUtil.isNotBlank(logNum)) {
					logNum = Integer.parseInt(logNum)+1+"";
					//去除重复的log
					SysLog tem = new SysLog();
					tem.setUserFlow(userFlow);
					newLogs.remove(tem);
				}
				parMap.put("logNum_"+userFlow, logNum);
				temp.setLogDesc(logNum);	//用来放登录次数
				newLogs.add(temp);
				
				if (userFlowList.indexOf(userFlow)<0) {
					userFlowList.add(userFlow);
				}
			}
		}
		
		model.addAttribute("logs",newLogs);
		
		return "res/edu/report/sysLog";
	}
	
	/**
	 * 查询当前登录者所在机构的部门
	 * @param model
	 * @return
	 */
	public List<SysDept> searchDeptList(){
		SysDept dept=new SysDept();
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList=this.deptBiz.searchDept(dept);
		return deptList;
	}
	
}
