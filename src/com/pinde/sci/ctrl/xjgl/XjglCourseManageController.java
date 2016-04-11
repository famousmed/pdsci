package com.pinde.sci.ctrl.xjgl;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.jspform.Page;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.ExcleUtile;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduCourseMajorBiz;
import com.pinde.sci.biz.hbres.IResDoctorRecruitBiz;
import com.pinde.sci.biz.sys.ICfgBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.RecruitTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.edu.CourseMajorNumForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduCourseMajorExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseMajor;
import com.pinde.sci.model.mo.SysCfg;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserDept;
import com.pinde.sci.model.res.HospitalDoctorExportInfo;
import com.pinde.sci.model.res.ResDoctorRecruitExt;

@Controller
@RequestMapping("/xjgl/course/manage")
public class XjglCourseManageController extends GeneralController{
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IDeptBiz deptBiz ;
	@Autowired
	private IEduCourseBiz eduCourseBiz;
	@Autowired
	private IResDoctorRecruitBiz doctorRecruitBiz;
	@Autowired
	private IEduCourseMajorBiz eduCourseMajorBiz;
	@Autowired
	private ICfgBiz cfgBiz;
	
	@RequestMapping(value="/courseMajor")
	public String courseMajor(Model model,EduCourse course,EduCourseMajor courseMajor,HttpServletRequest request,Integer currentPage){
		SysUser user = GlobalContext.getCurrentUser();
		List<SysUserDept> sysUserDeptFlowList=userBiz.getUserDept(user);
		String year=InitConfig.getSysCfg("xjgl_curr_year");
		String curryear=DateUtil.getCurrDateTime("yyyy");
		String time = null;
		if (StringUtil.isBlank(courseMajor.getPlanYear())) {
			if (StringUtil.isNotBlank(year)) {
				courseMajor.setPlanYear(year);
				time=year;
			}else{
				courseMajor.setPlanYear(curryear);
				time=curryear;
			}
		}
		
		//Educourse
		PageHelper.startPage(currentPage,getPageSize(request));
		List<EduCourseExt> courseMajorExtsList=eduCourseMajorBiz.courseMajorExts(course,courseMajor);
		Map<String,Map<String, Object>> majorMap=new HashMap<String, Map<String,Object>>();
		List<String> courseFlowList=new ArrayList<String>();
		List<CourseMajorNumForm> majorList=null;
		Map<String, Object> majorNumMap=null;
		List<Integer> professionalSum=new ArrayList<Integer>();
		for (EduCourseExt eduCourseMajorExt : courseMajorExtsList) {
			professionalSum.add(eduCourseMajorExt.getEduCourseMajorsList().size());
			if (!courseFlowList.contains(eduCourseMajorExt.getCourseFlow())) {
				courseFlowList.add(eduCourseMajorExt.getCourseFlow());
				majorNumMap=new HashMap<String, Object>();
				majorMap.put(eduCourseMajorExt.getCourseFlow(), majorNumMap);
			}
		}
		for (String courseFlow : courseFlowList) {
			majorList=new ArrayList<CourseMajorNumForm>();
			majorList=eduCourseMajorBiz.selectCourseMajorNum(courseFlow,courseMajor.getPlanYear());
			for (CourseMajorNumForm courseMajorNumForm : majorList) {
				majorMap.get(courseMajorNumForm.getCourseFlow()).put(courseMajorNumForm.getMajorId(), courseMajorNumForm.getNum());
			}
		}
		
		SysCfg start=cfgBiz.read("choose_course_start_time");
		SysCfg end=cfgBiz.read("choose_course_end_time");
		model.addAttribute("sysUserDeptFlowList", sysUserDeptFlowList);
		model.addAttribute("start",start);
		model.addAttribute("end",end);
		model.addAttribute("time",time);
		model.addAttribute("professionalSum",professionalSum);
		model.addAttribute("majorMap", majorMap);
		model.addAttribute("courseMajorExtsList",courseMajorExtsList);
		return "xjgl/plat/courseOverview";
	}
	
	/**
	 * 增加和修改同用一个方法
	 * */
	@RequestMapping(value="/saveCourse")
	@ResponseBody
	public String saveCourse(EduCourse eduCourse){
		int num=eduCourseBiz.saveCourse(eduCourse);
		if (num==GlobalConstant.ONE_LINE) {
			return GlobalConstant.SAVE_SUCCESSED;
		}else{
			return GlobalConstant.SAVE_FAIL;
			
		}
	   /* DictTypeEnum.DoctorStatus.getDictNameById("1");*/
	}
	
	@RequestMapping(value="/updateCourse")
	@ResponseBody
	public String updateCourse(String courseFlow,String courseUserCount){
		EduCourse course= eduCourseBiz.readCourse(courseFlow);
		course.setCourseUserCount(courseUserCount);
		int num=eduCourseBiz.saveCourse(course);
		if (num!=GlobalConstant.ONE_LINE) {
			return GlobalConstant.UPDATE_FAIL;
		}else{
			return GlobalConstant.UPDATE_SUCCESSED;
		}
	}
	@RequestMapping(value="/sysCfgUpdate")
	@ResponseBody
	public String sysCfgUpdate(String startCode,String startValue,String endCode,String endValue){
		List<SysCfg> cfgList = new ArrayList<SysCfg>();
		SysCfg start=new SysCfg();
		start.setCfgCode(startCode);
		start.setCfgValue(startValue);
		cfgList.add(start);
		
		SysCfg end=new SysCfg();
		end.setCfgCode(endCode);
		end.setCfgValue(endValue);
		cfgList.add(end);
		
		cfgBiz.save(cfgList);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	
	//查询courseList
	@RequestMapping(value="/courseList")
	public String courseList(Model model,Integer currentPage, HttpServletRequest request,EduCourse course){
		PageHelper.startPage(currentPage,getPageSize(request));
		List<EduCourse> coursesList=eduCourseBiz.searchCourseList(course);
		model.addAttribute("coursesList",coursesList);
		return "xjgl/plat/courseInfoMaintain";
	}
	/**
	 * 查询course
	 * */
	@RequestMapping(value="/currCourse")
	public String currCourse(Model model,String courseFlow){
		if (StringUtil.isNotBlank(courseFlow)) {
			EduCourse course=eduCourseBiz.readCourse(courseFlow);
			model.addAttribute("course",course);
		}
		SysUser user = GlobalContext.getCurrentUser();
		List<SysDept> deptList=  deptBiz.searchDeptByOrg(user.getOrgFlow()); 
				//userBiz.getUserDept(user);
		model.addAttribute("deptList",deptList);
		return "xjgl/plat/courseInfoAdd";
	}
	//删除
	@RequestMapping(value="/courseDelete")
	@ResponseBody
	public String courseDelete(String courseFlow){
		int num=eduCourseBiz.delCourse(courseFlow);
		if (num!=GlobalConstant.ONE_LINE) {
			return GlobalConstant.DELETE_FAIL;
		}else{
			return GlobalConstant.DELETE_SUCCESSED;
		}
	}
	/**
	 * 导入课程
	 * @param deptFlow
	 * @return
	 */
	@RequestMapping(value="/importCourse")
	public String importCourse(String deptFlow){
		return "xjgl/plat/courseDaoRu";
	}
	
	/**
	 * 导入课程
	 * @param deptFlow
	 * @return
	 */
	@RequestMapping(value="/importCourseFromExcel")
	@ResponseBody
	public String importCourseFromExcel(MultipartFile file){
		if(file.getSize() > 0){
			try{
				int result = eduCourseBiz.importCourseFromExcel(file);
				if(GlobalConstant.ZERO_LINE != result){
					return GlobalConstant.UPLOAD_SUCCESSED + "导入"+result+"条记录！";
				}else{
					return GlobalConstant.UPLOAD_FAIL;
				}
			}catch(RuntimeException re){
				re.printStackTrace();
				return re.getMessage();
			}
			
		}
		return GlobalConstant.UPLOAD_FAIL;
	}
	/**
	 * 判断课程代码是否存在
	 * */
	@RequestMapping(value="/courseCodeOk")
	@ResponseBody
	public String courseCodeOk(String courseCode){
		
		EduCourse course=new EduCourse();
		List<EduCourse> coursesList=eduCourseBiz.searchCourseList(course);
		List<String> courseCodeList=new ArrayList<String>();
		for (EduCourse eduCourse : coursesList) {
			courseCodeList.add(eduCourse.getCourseCode());
		}
		if (courseCodeList.contains(courseCode)) {
			return GlobalConstant.COURSE_COURSECODE_EXIST;
		}else{
			return GlobalConstant.COURSE_COURSECODE_SUCCESSED;
		}
		
	}
	/**
	 * 课程导出
	 * */
	@RequestMapping("/courseExport")
	public void courseExport(HttpServletResponse response,EduCourse course) throws IOException, Exception{
		String[] titles = new String[]{
				"courseCode:代码",
				"courseName:中文名称",
				"gradationName:授课层次",
				"courseTypeName:课程类别",
				"courseNameEn:英文名称",
				"courseCredit:学分",
				"coursePeriod:总学时",
				"coursePeriodTeach:讲授学时",
				"coursePeriodExper:实验学时",
				"coursePeriodMachine:上机学时",
				"coursePeriodOther:其他学时"
		};
		List<EduCourse> coursesList=eduCourseBiz.searchCourseList(course);
	    String fileName = "课程信息名单.xls";
	    fileName = URLEncoder.encode(fileName, "UTF-8");
	    ExcleUtile.exportSimpleExcleByObjs(titles, coursesList, response.getOutputStream());
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.setContentType("application/octet-stream;charset=UTF-8");  
		
	}
	
}
