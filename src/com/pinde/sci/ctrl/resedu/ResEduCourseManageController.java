package com.pinde.sci.ctrl.resedu;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduCourseChapterBiz;
import com.pinde.sci.biz.edu.IEduCoursePeriodRefBiz;
import com.pinde.sci.biz.edu.IEduCourseRequireRefBiz;
import com.pinde.sci.biz.edu.IEduCourseScoreRefBiz;
import com.pinde.sci.biz.edu.IEduCourseTestPaperBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.test.ITestPaperBiz;
import com.pinde.sci.biz.test.ITestResultBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.ctrl.edu.EduCourseManageController;
import com.pinde.sci.enums.edu.EduCourseCategoryEnum;
import com.pinde.sci.enums.edu.EduCourseStatusEnum;
import com.pinde.sci.enums.edu.PeriodUserScopeEnum;
import com.pinde.sci.enums.edu.RequiredUserScopeEnum;
import com.pinde.sci.enums.edu.ScoreUserScopeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.form.edu.ChapterForm;
import com.pinde.sci.form.edu.EduCourseForm;
import com.pinde.sci.form.edu.EduCourseSearchConditionForm;
import com.pinde.sci.form.edu.EduFileForm;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCoursePeriodRef;
import com.pinde.sci.model.mo.EduCourseRequireRef;
import com.pinde.sci.model.mo.EduCourseScoreRef;
import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.mo.TestPaper;
import com.pinde.sci.model.mo.TestResult;
import com.pinde.sci.model.sys.SysUserResDoctorExt;

@Controller
@RequestMapping("resedu/manage/course")
public class ResEduCourseManageController extends GeneralController{
	private static Logger logger = LoggerFactory.getLogger(EduCourseManageController.class);
	@Autowired
	private IEduCourseBiz courseBiz;
	@Autowired
	private ISchDeptBiz schDeptBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IEduCourseChapterBiz chapterBiz;
	@Autowired
	private IEduCourseRequireRefBiz requireRefBiz;
	@Autowired
	private IEduCourseScoreRefBiz scoreRefBiz;
	@Autowired
	private IEduCoursePeriodRefBiz periodRefBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IEduCourseTestPaperBiz eduCourseTestPaperBiz;
	@Autowired
	private ITestPaperBiz paperBiz;
	@Autowired
	private ITestResultBiz resultBiz;
	
	
	/**
	 * 跳转到试卷列表页面
	 * @return
	 */
	@RequestMapping("/testList")
	public String testList(String courseFlow,Model model){
	    //查询课程信息
		EduCourse course=this.courseBiz.readCourse(courseFlow);
		model.addAttribute("course", course);
		return "res/edu/test/testList";
	}
	
	@RequestMapping("/testTable")
	public String testTable(String chapterFlow,Model model){
		return "res/edu/test/testTable";
	}
	
	
	@RequestMapping("/loadTestList")
	public String loadTestList(String courseFlow,String chapterFlow,String selfFlag,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		List<String> courseTestPaperFlowList=new ArrayList<String>();
		if(StringUtil.isBlank(chapterFlow)){
			//查询课程与考试关联关系
			EduCourseTestPaper eduCourseTestPaper=new EduCourseTestPaper();
			eduCourseTestPaper.setCourseFlow(courseFlow);
			List<EduCourseTestPaper> courseTestPaperList=this.eduCourseTestPaperBiz.searchCourseTestPaperList(eduCourseTestPaper);
			if(courseTestPaperList!=null && !courseTestPaperList.isEmpty()){
				for(EduCourseTestPaper tp:courseTestPaperList){
					courseTestPaperFlowList.add(tp.getPaperFlow());
				}
			}
		}else{
			//查询课程与考试关联关系
			EduCourseTestPaper eduCourseTestPaper=new EduCourseTestPaper();
			eduCourseTestPaper.setChapterFlow(chapterFlow);
			List<EduCourseTestPaper> courseTestPaperList=this.eduCourseTestPaperBiz.searchCourseTestPaperList(eduCourseTestPaper);
			if(courseTestPaperList!=null && !courseTestPaperList.isEmpty()){
				for(EduCourseTestPaper tp:courseTestPaperList){
					courseTestPaperFlowList.add(tp.getPaperFlow());
				}
			}
		}
		model.addAttribute("courseTestPaperFlowList", courseTestPaperFlowList);
		//查询当前老师的所有试卷
		TestPaper testPaper=new TestPaper();
		testPaper.setPaperUserFlow(currUser.getUserFlow());
		List<TestPaper> testPaperList=null;
		if(GlobalConstant.FLAG_Y.equals(selfFlag)){
		   testPaperList=this.paperBiz.searchTestPaperList(courseFlow,chapterFlow,currUser.getUserFlow());	
		}else{
			testPaperList=this.paperBiz.searchTestPaperList("","", currUser.getUserFlow());	
		}
		model.addAttribute("testPaperList", testPaperList);
		return "res/edu/test/tests";
	}
	
	/**
	 * 查询试卷的考试情况
	 * @param testResult
	 * @param currentPage
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/testResultInfo")
	public String testResultList(TestResult testResult,Integer currentPage,HttpServletRequest request,Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<TestResult> results=this.resultBiz.searchTestResultList(testResult);
		model.addAttribute("results", results);
		return "res/edu/test/testResultInfo";
	}
	/**
	 * 跳转到出题页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/addTestPaper")
	public String addTestPaper(Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
	    String url=InitConfig.getSysCfg("res_edu_test_i")+"manager/InterfaceHandler.ashx?UserName="+currUser.getUserCode()+"&RealName="+currUser.getUserName();
		model.addAttribute("url", url);
		return "res/edu/test/testSystem";
	}
	
	
	/**
	 * 添加或删除课程试卷绑定
	 * @param paperFlow
	 * @param courseFlow
	 * @param type
	 * @param statusId
	 * @return
	 */
	@RequestMapping("/changePaperBind")
	@ResponseBody
	public int changePaperBind(String paperFlow,String courseFlow,String chapterFlow,String type,String statusId){
		TestPaper testPaper=this.paperBiz.readTestPaper(paperFlow);
		if (type.equals("add")) {
	    	int i=eduCourseTestPaperBiz.testProvingMany(courseFlow,chapterFlow);
	    	if (i==0) {
		    }else{
		    	return GlobalConstant.CAN_NOT_BIND_FLAG;
		    }
		}
	    if(StringUtil.isBlank(chapterFlow)){
	    	EduCourse eduCourse=this.courseBiz.readCourse(courseFlow);
			if(testPaper!=null && eduCourse!=null ){
		    	return this.eduCourseTestPaperBiz.addAndDeleteCourseTestPaper(courseFlow,chapterFlow,paperFlow, type);
			}
	    }else{
	    	EduCourseChapter chapter=this.chapterBiz.seachOne(chapterFlow);
			if(testPaper!=null && chapter!=null ){
		    	return this.eduCourseTestPaperBiz.addAndDeleteCourseTestPaper(chapter.getCourseFlow(),chapterFlow,paperFlow, type);
			}
	    }
		return GlobalConstant.ZERO_LINE;
	}
	
	/**
	 * 加载课程列表
	 * @param course
	 * @param model
	 * @return
	 */
	@RequestMapping("/courseList/{userListScope}")
	public String courseList(@PathVariable String userListScope,EduCourse course,EduCourseSearchConditionForm form, Integer currentPage,HttpServletRequest request, Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
	    SysUser currUser=GlobalContext.getCurrentUser();
	    List<String> courseStatusIdList=new ArrayList<String>();
		if(GlobalConstant.USER_LIST_PERSONAL.equals(userListScope)){
			course.setCreateUserFlow(currUser.getUserFlow());
		}
		if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){
			courseStatusIdList.add(EduCourseStatusEnum.NoPublish.getId());
			courseStatusIdList.add(EduCourseStatusEnum.Publish.getId());
			courseStatusIdList.add(EduCourseStatusEnum.Disabled.getId());
			form.setCourseStatusIdList(courseStatusIdList);
		}
		PageHelper.startPage(currentPage, getPageSize(request));
		List<EduCourse> courseList = courseBiz.searchCourseList(course,form);
		model.addAttribute("courseList", courseList);
		//查询当前机构科室
		List<SysDept> deptList=this.deptBiz.searchDeptByOrg(currUser.getOrgFlow());
		model.addAttribute("deptList", deptList);
		return "res/edu/teacher/courseList";
	}
	
	/**
	 * 带教老师课程列表
	 * @param course
	 * @param currentPage
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/courseView")
	public String courseView(EduCourse course, Integer currentPage,HttpServletRequest request, Model model){
		//查询带教老师所参与的全部课程
		SysUser currUser=GlobalContext.getCurrentUser();
		List<EduCourse> courseList=this.courseBiz.searchTchCourseList(course, currUser);
		model.addAttribute("courseList", courseList);
		return "res/edu/teacher/courseView";
	}
	
	/**
	 * 加载章节列表
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/loadChapterList")
	public String loadChapterList(String courseFlow, Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		EduCourseChapter chapter=new EduCourseChapter();
		chapter.setCourseFlow(courseFlow);
		chapter.setTeacherId(currUser.getUserFlow());
	    List<EduCourseChapter> chapterList=this.chapterBiz.searchCourseChapterList(chapter, "", "");
	    model.addAttribute("chapterList", chapterList);
	    Map<String,Object> map=new HashMap<String, Object>();
	    if(chapterList!=null && !chapterList.isEmpty()){
	    	EduCourseTestPaper courseTestPaper=null;
	    	for(EduCourseChapter courseChapter:chapterList){
	    		courseTestPaper=new EduCourseTestPaper();
	    		courseTestPaper.setChapterFlow(courseChapter.getChapterFlow());
	    		List<EduCourseTestPaper> courseTestPapers=this.eduCourseTestPaperBiz.searchCourseTestPaperList(courseTestPaper);
	    		if(courseTestPapers!=null && !courseTestPapers.isEmpty()){
	    			map.put(courseChapter.getChapterFlow(), GlobalConstant.FLAG_Y);
	    		}else{
	    			map.put(courseChapter.getChapterFlow(), GlobalConstant.FLAG_N);
	    		}
	    	}
	    }
	    model.addAttribute("map", map);
		return "res/edu/teacher/chapterList";
	}
	
	/**
	 * 修改课程状态
	 * @param courseFlow
	 * @param statusId
	 * @return
	 */
	@RequestMapping("/changeCourseStatus")
	@ResponseBody
	public String changeCourseStatus(String courseFlow,String statusId){
		SysUser currUser=GlobalContext.getCurrentUser();
		EduCourse course=this.courseBiz.readCourse(courseFlow);
		if(course!=null){
			course.setCourseStatusId(statusId);
			course.setCourseStatusName(EduCourseStatusEnum.getNameById(statusId));
			this.courseBiz.changeCourseStatus(course, currUser,statusId);
			return GlobalConstant.OPERATE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 新增编辑课程页面
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/editCourse")
	public String editCourse(String courseFlow, Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		if(StringUtil.isNotBlank(courseFlow)){
			//查询课程信息
		    EduCourse course=this.courseBiz.readCourse(courseFlow);
		    model.addAttribute("course", course);
		    Map<String,Object> refMap=this.courseBiz.searchEduCourseRefMap(courseFlow,"edit");
		    model.addAttribute("refMap", refMap);
		}
		//查询轮转科室
		List<SchDept> schDeptList=searchSchDeptList(currUser.getOrgFlow());
		model.addAttribute("schDeptList", schDeptList);
		//查询职能科室
		List<SysDept> deptList=this.deptBiz.searchDeptByOrg(currUser.getOrgFlow());
		model.addAttribute("deptList", deptList);
		return "res/edu/teacher/editCourse";
	}
	
	@RequestMapping("/courseInfo")
	public String courseInfo(String courseFlow, Model model){
		//查询课程信息
	    EduCourse course=this.courseBiz.readCourse(courseFlow);
	    model.addAttribute("course", course);
	    //查询必修人员范围（按专业）
	    Map<String,Object> refMap=this.courseBiz.searchEduCourseRefMap(courseFlow,"show");
	    model.addAttribute("refMap", refMap);
	    return "res/edu/teacher/courseInfo";
	}
	
	/**
	 * 查看章节
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping("/chapterList")
	public String lookChapter(String courseFlow, Model model){
		EduCourse course = courseBiz.readCourse(courseFlow);
		BigDecimal allChapterCredit=chapterBiz.getAllChapterCredit(courseFlow);
		model.addAttribute("allChapterCredit", allChapterCredit.toString());
		model.addAttribute("course", course);
		return "res/edu/chapter/tree";
	}
	
	@RequestMapping("/chapterInfo")
	public String chapterInfo(String chapterFlow, Model model){
		EduCourseChapter chapter=this.chapterBiz.seachOne(chapterFlow);
		model.addAttribute("chapter", chapter);
		if(chapter!=null && StringUtil.isNotBlank(chapter.getTeacherId())){
			SysUser teacher=this.userBiz.readSysUser(chapter.getTeacherId());
			model.addAttribute("teacherName", teacher.getUserName());
		}
		return "res/edu/chapter/chapterInfo";
	}
	
	/**
	 * 编辑章节
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/editChapter")
	public String editChapter(String chapterFlow,String level,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
	    EduCourseChapter chapter = chapterBiz.seachOne(chapterFlow);
	    model.addAttribute("chapter", chapter);
	    if(Integer.parseInt(level)==2){
	    	String teacherRoleFlow=InitConfig.getSysCfg("res_teacher_role_flow");
	    	List<SysUser> userList=this.userBiz.findUserByRoleFlow(currUser.getOrgFlow(),teacherRoleFlow);
	    	model.addAttribute("userList", userList);
	    	return "res/edu/chapter/editChapterL2";
	    }else{
	    	return "res/edu/chapter/editChapterL1";
	    }
		
	}
	
	/**
	 * 添加章节
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/addChapter")
	public String addChapter(String chapterFlow,String level,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
	    if(Integer.parseInt(level)>=1){
	    	String teacherRoleFlow=InitConfig.getSysCfg("res_teacher_role_flow");
	    	List<SysUser> userList=this.userBiz.findUserByRoleFlow(currUser.getOrgFlow(),teacherRoleFlow);
	    	model.addAttribute("userList", userList);
	    	model.addAttribute("parentChapterFlow", chapterFlow);
	    	return "res/edu/chapter/editChapterL2";
	    }else{
	    	return "res/edu/chapter/editChapterL1";
	    }
		
	}
	
	/**
	 * 保存章节信息
	 * @param subject
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveChapter")
	@ResponseBody
	public String saveChapter(EduCourseChapter chapter){
		String result=this.chapterBiz.saveChapterReturnFlow(chapter);
		return result;
	}
	
	/**
	 * 获取课程全部章节
	 * @return 指定格式的json
	 */
	@RequestMapping(value="/getAllDataJson")
	@ResponseBody
	public String getAllDataJson(String courseFlow){
		if(StringUtil.isNotBlank(courseFlow)){
			List<EduCourseChapter> chapterList = chapterBiz.getAllChapter(courseFlow);
			StringBuilder sb = new StringBuilder();
			sb.append("[");
			sb.append("{\"id\":\"0\", \"pId\":\"-1\", \"name\":\"课程章节\",\"open\":true,\"t\":\"\"},");
			for (EduCourseChapter chapter : chapterList) {
				sb.append("{");
				sb.append("\"id\":").append("\""+chapter.getChapterFlow()+"\"").append(",");
				sb.append("\"pId\":").append("\""+StringUtil.replaceNull(chapter.getParentChapterFlow(),"0")+"\"").append(",");
				sb.append("\"name\":").append("\"").append(chapter.getChapterName()).append("\",");
				sb.append("\"t\":").append("\"\"");
				sb.append("},");
			}
			sb.deleteCharAt(sb.length()-1);
			sb.append("]");
			return sb.toString();
		}
		return null;
	}
	/**
	 * 保存视频
	 * @param video
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value="/saveCourseVideo")
	@ResponseBody
	public EduFileForm saveCourseVideo(MultipartFile file) throws Exception{
		EduFileForm fileForm=null;
		if(GlobalConstant.FILE_SIZE_PASS_SCOPE.equals(checkFileSize(file,"video"))){
			fileForm=new EduFileForm();
			fileForm.setFileSize(file.getSize());
			return fileForm;
		}
		String fileName=file.getOriginalFilename();
		fileForm=this.courseBiz.saveFile(file, "reseduCourseVideo");
		if(fileForm!=null){
			fileForm.setFileName(fileName);
		}
		return fileForm;
	}
	/**
	 * 保存图片
	 * @param file
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value="/saveCourseImg")
	@ResponseBody
	public EduFileForm saveCourseImg(MultipartFile file) throws  Exception{
		if(GlobalConstant.FILE_SIZE_PASS_SCOPE.equals(checkFileSize(file,"img"))){
			return null;
		}
		String fileName=file.getOriginalFilename();
		EduFileForm fileForm=this.courseBiz.saveFile(file, "reseduCourseImg");
		if(fileForm!=null){
			fileForm.setFileName(fileName);
		}
		return fileForm;
	}
	
	/**
	 * 查询文件名
	 * @param url
	 * @return
	 */
	public String searchFileName(String url){
		if(StringUtil.isNotBlank(url)){
			String fileName=url.substring(url.indexOf(".")+1);
			return fileName;
		}else{
			return "";
		}
    		
	}
	
	/**
	 * 检查文件大小
	 * @return
	 */
	public String checkFileSize(MultipartFile file,String type){
		int fileScope=0;
		if(type=="video"){
			fileScope=Integer.parseInt((String) InitConfig.getSysCfg("res_edu_chapter_file_size"));
		}
		if(type=="img"){
			fileScope=Integer.parseInt((String) InitConfig.getSysCfg("res_edu_course_img_size"));
		}
		long fileScopeb=fileScope*1024*1024;
		if(file.getSize()>fileScopeb){
			return GlobalConstant.FILE_SIZE_PASS_SCOPE;
		}
		return "";
	}
	
	/**
	 * 查询轮转科室
	 * @param orgFlow
	 * @return
	 */
	public List<SchDept> searchSchDeptList(String orgFlow){
		List<SchDept> schDept=null;
		if(StringUtil.isNotBlank(orgFlow)){
			schDept=this.schDeptBiz.searchSchDeptList(orgFlow);
		}
		return schDept;
	}
	
	//查询培训专业(编辑)
    @RequestMapping(value="/searchMajor")
    public String searchMajor(Model model){
    	return "res/edu/teacher/majorList";
    }
	
	//查询轮转科室(编辑)
    @RequestMapping(value="/searchSchDept")
    public String searchSchDept(Model model){
    	SysUser currUser=GlobalContext.getCurrentUser();
    	List<SchDept> schDeptList=searchSchDeptList(currUser.getOrgFlow());
    	model.addAttribute("schDeptList", schDeptList);
    	return "res/edu/teacher/schDeptList";
    }
	
	//查询人员(编辑)
	@RequestMapping(value="/searchUser")
	public String searchUser(Integer currentPage,HttpServletRequest request,
			                 SysUserResDoctorExt userDoctorExt,ResDoctor resDoctor,String schDeptFlow,
			                 String no,Model model,String [] requiredUserFlow,String [] periodUserFlow,String [] scoreUserFlow){
		SysUser currUser=GlobalContext.getCurrentUser();
		List<String> checkUserFlowList=new ArrayList<String>();
		List<SysUserResDoctorExt> sysUserResDoctorExtList=null;
		if(requiredUserFlow!=null && requiredUserFlow.length>0){
			for(String str:requiredUserFlow){
				checkUserFlowList.add(str);
			}
		}
		if(scoreUserFlow!=null && scoreUserFlow.length>0){
			for(String str:scoreUserFlow){
				checkUserFlowList.add(str);
			}
		}
		if(periodUserFlow!=null && periodUserFlow.length>0){
			for(String str:periodUserFlow){
				checkUserFlowList.add(str);
			}
		}
		if(!"first".equals(no)){
			userDoctorExt.setOrgFlow(currUser.getOrgFlow());
			userDoctorExt.setDoctor(resDoctor);
			//PageHelper.startPage(currentPage, getPageSize(request));
			if(!checkUserFlowList.isEmpty()){
				sysUserResDoctorExtList=this.resDoctorBiz.searchSysUserAndResDoctor(userDoctorExt,checkUserFlowList,schDeptFlow);
			}else{
				sysUserResDoctorExtList=this.resDoctorBiz.searchSysUserAndResDoctor(userDoctorExt,null,schDeptFlow);
			}
			model.addAttribute("sysUserResDoctorExtList", sysUserResDoctorExtList);
		}
		//查询当前机构所有轮转科室
		List<SchDept> schDeptList=searchSchDeptList(currUser.getOrgFlow());
		model.addAttribute("schDeptList", schDeptList);
		//查询当前机构所有职能科室
		List<SysDept> sysDeptList=this.deptBiz.searchDeptByOrg(currUser.getOrgFlow());
		model.addAttribute("sysDeptList", sysDeptList);
		return "res/edu/teacher/userList";
	}
	//查询人员(查看)
	@RequestMapping(value="/searchUserInfo")
	public String searchUserInfo(Integer currentPage,HttpServletRequest request,
			                     SysUserResDoctorExt userDoctorExt,ResDoctor resDoctor,String schDeptFlow,
			                     String no,String type,String courseFlow,Model model){
		 List<String> checkUserFlowList=new ArrayList<String>();
		 if("required".equals(type)){
			 EduCourseRequireRef requireUser=new EduCourseRequireRef();
			 requireUser.setCourseFlow(courseFlow);
			 requireUser.setRefTypeId(RequiredUserScopeEnum.User.getId());
			 List<EduCourseRequireRef> requireUserList=requireRefBiz.searchRequireRefs(requireUser);
			 if(requireUserList!=null && !requireUserList.isEmpty()){
				 for(EduCourseRequireRef ref:requireUserList){
					 checkUserFlowList.add(ref.getRefFlow());
				 }
			 }
		 }else if("score".equals(type)){
			 EduCourseScoreRef scoreUser=new EduCourseScoreRef();
			 scoreUser.setCourseFlow(courseFlow);
			 scoreUser.setRefTypeId(ScoreUserScopeEnum.User.getId());
			 List<EduCourseScoreRef> scoreUserList=scoreRefBiz.searchScoreRefs(scoreUser);
			 if(scoreUserList!=null && !scoreUserList.isEmpty()){
				 for(EduCourseScoreRef ref:scoreUserList){
					 checkUserFlowList.add(ref.getRefFlow());
				 }
			 }
		 }else if("period".equals(type)){
			 EduCoursePeriodRef periodUser=new EduCoursePeriodRef();
			 periodUser.setCourseFlow(courseFlow);
			 periodUser.setRefTypeId(PeriodUserScopeEnum.User.getId());
			 List<EduCoursePeriodRef> periodUserList=periodRefBiz.searchPeriodRefs(periodUser);
			 if(periodUserList!=null && !periodUserList.isEmpty()){
				 for(EduCoursePeriodRef ref:periodUserList){
					 checkUserFlowList.add(ref.getRefFlow());
				 }
			 }
		 }
		 SysUser currUser=GlobalContext.getCurrentUser();
		 userDoctorExt.setDoctor(resDoctor);
		 //PageHelper.startPage(currentPage, getPageSize(request));
		 List<SysUserResDoctorExt> sysUserResDoctorExtList=this.resDoctorBiz.searchSysUserAndResDoctor(userDoctorExt,checkUserFlowList,schDeptFlow);
		 model.addAttribute("sysUserResDoctorExtList", sysUserResDoctorExtList);
		 //查询当前机构所有轮转科室
		 List<SchDept> schDeptList=searchSchDeptList(currUser.getOrgFlow());
		 model.addAttribute("schDeptList", schDeptList);
		 //查询当前机构所有职能科室
		 List<SysDept> sysDeptList=this.deptBiz.searchDeptByOrg(currUser.getOrgFlow());
		 model.addAttribute("sysDeptList", sysDeptList);
		 return "res/edu/teacher/userList";
	}
	/**
	 * 保存课程信息
	 * @param course
	 * @param chapter
	 * @param form
	 * @return
	 */
	@RequestMapping(value="/saveCourse")
	public String saveCourse(EduCourse course,EduCourseChapter chapter,String type,String tip,EduCourseForm form){
		//组织课程数据
		course=replenishCourse(course);
		//组织必修人员范围数据
		form.setRequiredDoctorTrainingSpeList(replenishRequiredDoctorTrainingSpe(form));
        form.setRequiredSchDeptList(replenishRequiredSchDept(form));
        form.setRequiredUserFlowList(replenishRequiredUserFlow(form));
        //组织计分人员范围数据
        form.setScoreDoctorTrainingSpeList(replenishScoreDoctorTrainingSpe(form));
        form.setScoreSchDeptList(replenishScoreSchDept(form));
        form.setScoreUserFlowList(replenishScoreUserFlow(form));
        //组织计学时人员范围数据
        form.setPeriodDoctorTrainingSpeList(replenishPeriodDoctorTrainingSpe(form));
        form.setPeriodSchDeptList(replenishPeriodSchDept(form));
        form.setPeriodUserFlowList(replenishPeriodUserFlow(form));
        String courseFlow=this.courseBiz.saveResEduCourse(course, chapter, form);
		return "redirect:editCourse?courseFlow="+courseFlow+"&type="+type+"&tip="+tip;
	}
	/**
	 * 跳转到视频预览页面
	 * @param chapterFlow
	 * @return
	 */
	@RequestMapping(value="/previewCourseVideo")
	public String saveCourse(String chapterFlow,Model model){
		EduCourseChapter chapter=this.chapterBiz.seachOne(chapterFlow);
		model.addAttribute("chapter", chapter);
		return "res/edu/manage/courseVideo";
	}	
	
	
	
	
	
	
	
	
//======================组织数据==============================
	
	/**
	 * 组织课程数据
	 * @param course
	 * @return
	 */
	public EduCourse replenishCourse(EduCourse course){
		SysUser currUser=GlobalContext.getCurrentUser();
		if(StringUtil.isBlank(course.getCourseFlow())){
			course.setCourseStatusId(EduCourseStatusEnum.NoPublish.getId());
			course.setCourseStatusName(EduCourseStatusEnum.NoPublish.getName());
			course.setUploadTime(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
			course.setCourseCategoryId(EduCourseCategoryEnum.GeneraTrain.getId());
			course.setCreateUserName(currUser.getUserName());
			SysDept sysDept=this.deptBiz.readSysDept(course.getDeptFlow());
			if(sysDept!=null){
				course.setDeptName(sysDept.getDeptName());
			}
		}
		course.setCourseCategoryName(EduCourseCategoryEnum.getNameById(course.getCourseCategoryId()));
		return course;
	}
	/**
	 * 组织必修人员范围(按专业)数据
	 * @param form
	 * @return
	 */
	public List<EduCourseRequireRef> replenishRequiredDoctorTrainingSpe(EduCourseForm form){
		List<EduCourseRequireRef> refList=new ArrayList<EduCourseRequireRef>();
		String [] requiredDoctorTrainingSpeArray=form.getRequiredDoctorTrainingSpe();
		EduCourseRequireRef ref=null;
		if(requiredDoctorTrainingSpeArray!=null){
			for(String refFlow:requiredDoctorTrainingSpeArray){
			   String refName=DictTypeEnum.DoctorTrainingSpe.getDictNameById(refFlow);
			   ref=new EduCourseRequireRef();
			   ref.setRefTypeId(RequiredUserScopeEnum.Major.getId());
			   ref.setRefTypeName(RequiredUserScopeEnum.Major.getName());
			   ref.setRefFlow(refFlow);
			   ref.setRefName(refName);
			   refList.add(ref);
			}
		}
		return  refList;
	}
	
	/**
	 * 组织必修人员范围(按科室)数据
	 * @param form
	 * @return
	 */
	public List<EduCourseRequireRef> replenishRequiredSchDept(EduCourseForm form){
		List<EduCourseRequireRef> refList=new ArrayList<EduCourseRequireRef>();
		String [] requiredSchDeptArray=form.getRequiredSchDept();
		EduCourseRequireRef ref=null;
		if(requiredSchDeptArray!=null){
			for(String refFlow:requiredSchDeptArray){
			   SchDept dept=this.schDeptBiz.readSchDept(refFlow);
			   ref=new EduCourseRequireRef();
			   ref.setRefTypeId(RequiredUserScopeEnum.Dept.getId());
			   ref.setRefTypeName(RequiredUserScopeEnum.Dept.getName());
			   if(dept!=null){
				   ref.setRefFlow(dept.getSchDeptFlow());
				   ref.setRefName(dept.getSchDeptName());
			   }
			   refList.add(ref);
			}
		}
		return  refList;
	}
	
	/**
	 * 组织必修人员范围(按人员)数据
	 * @param form
	 * @return
	 */
	public List<EduCourseRequireRef> replenishRequiredUserFlow(EduCourseForm form){
		List<EduCourseRequireRef> refList=new ArrayList<EduCourseRequireRef>();
		String [] requiredUserFlowArray=form.getRequiredUserFlow();
		EduCourseRequireRef ref=null;
		if(requiredUserFlowArray!=null){
			for(String refFlow:requiredUserFlowArray){
			   SysUser user=this.userBiz.readSysUser(refFlow);
			   ref=new EduCourseRequireRef();
			   ref.setRefTypeId(RequiredUserScopeEnum.User.getId());
			   ref.setRefTypeName(RequiredUserScopeEnum.User.getName());
			   if(user!=null){
				   ref.setRefFlow(user.getUserFlow());
				   ref.setRefName(user.getUserName());
			   }
			   refList.add(ref);
			}
		}
		return  refList;
	}
	
	/**
	 * 组织计分人员范围(按专业)数据
	 * @param form
	 * @return
	 */
	public List<EduCourseScoreRef> replenishScoreDoctorTrainingSpe(EduCourseForm form){
		List<EduCourseScoreRef> refList=new ArrayList<EduCourseScoreRef>();
		String [] scoreDoctorTrainingSpeArray=form.getScoreDoctorTrainingSpe();
		EduCourseScoreRef ref=null;
		if(scoreDoctorTrainingSpeArray!=null){
			for(String refFlow:scoreDoctorTrainingSpeArray){
			   String refName=DictTypeEnum.DoctorTrainingSpe.getDictNameById(refFlow);
			   ref=new EduCourseScoreRef();
			   ref.setRefTypeId(ScoreUserScopeEnum.Major.getId());
			   ref.setRefTypeName(ScoreUserScopeEnum.Major.getName());
			   ref.setRefFlow(refFlow);
			   ref.setRefName(refName);
			   refList.add(ref);
			}
		}
		return  refList;
	}
	
	/**
	 * 组织计分人员范围(按科室)数据
	 * @param form
	 * @return
	 */
	public List<EduCourseScoreRef> replenishScoreSchDept(EduCourseForm form){
		List<EduCourseScoreRef> refList=new ArrayList<EduCourseScoreRef>();
		String [] scoreSchDeptArray=form.getScoreSchDept();
		EduCourseScoreRef ref=null;
		if(scoreSchDeptArray!=null){
			for(String refFlow:scoreSchDeptArray){
			   SchDept dept=this.schDeptBiz.readSchDept(refFlow);
			   ref=new EduCourseScoreRef();
			   ref.setRefTypeId(ScoreUserScopeEnum.Dept.getId());
			   ref.setRefTypeName(ScoreUserScopeEnum.Dept.getName());
			   if(dept!=null){
				   ref.setRefFlow(dept.getSchDeptFlow());
				   ref.setRefName(dept.getSchDeptName());
			   }
			   refList.add(ref);
			}
		}
		return  refList;
	}
	
	/**
	 * 组织计分人员范围(按人员)数据
	 * @param form
	 * @return
	 */
	public List<EduCourseScoreRef> replenishScoreUserFlow(EduCourseForm form){
		List<EduCourseScoreRef> refList=new ArrayList<EduCourseScoreRef>();
		String [] scoreUserFlowArray=form.getScoreUserFlow();
		EduCourseScoreRef ref=null;
		if(scoreUserFlowArray!=null){
			for(String refFlow:scoreUserFlowArray){
			   SysUser user=this.userBiz.readSysUser(refFlow);
			   ref=new EduCourseScoreRef();
			   ref.setRefTypeId(ScoreUserScopeEnum.User.getId());
			   ref.setRefTypeName(ScoreUserScopeEnum.User.getName());
			   if(user!=null){
				   ref.setRefFlow(user.getUserFlow());
				   ref.setRefName(user.getUserName());
			   }
			   refList.add(ref);
			}
		}
		return  refList;
	}
	/**
	 * 组织计学时人员范围(按专业)数据
	 * @param form
	 * @return
	 */
	public List<EduCoursePeriodRef> replenishPeriodDoctorTrainingSpe(EduCourseForm form){
		List<EduCoursePeriodRef> refList=new ArrayList<EduCoursePeriodRef>();
		String [] periodDoctorTrainingSpeArray=form.getPeriodDoctorTrainingSpe();
		EduCoursePeriodRef ref=null;
		if(periodDoctorTrainingSpeArray!=null){
			for(String refFlow:periodDoctorTrainingSpeArray){
			   String refName=DictTypeEnum.DoctorTrainingSpe.getDictNameById(refFlow);
			   ref=new EduCoursePeriodRef();
			   ref.setRefTypeId(PeriodUserScopeEnum.Major.getId());
			   ref.setRefTypeName(PeriodUserScopeEnum.Major.getName());
			   ref.setRefFlow(refFlow);
			   ref.setRefName(refName);
			   refList.add(ref);
			}
		}
		return  refList;
	}
	
	/**
	 * 组织记学时人员范围(按科室)数据
	 * @param form
	 * @return
	 */
	public List<EduCoursePeriodRef> replenishPeriodSchDept(EduCourseForm form){
		List<EduCoursePeriodRef> refList=new ArrayList<EduCoursePeriodRef>();
		String [] periodSchDeptArray=form.getPeriodSchDept();
		EduCoursePeriodRef ref=null;
		if(periodSchDeptArray!=null){
			for(String refFlow:periodSchDeptArray){
			   SchDept dept=this.schDeptBiz.readSchDept(refFlow);
			   ref=new EduCoursePeriodRef();
			   ref.setRefTypeId(PeriodUserScopeEnum.Dept.getId());
			   ref.setRefTypeName(PeriodUserScopeEnum.Dept.getName());
			   if(dept!=null){
				   ref.setRefFlow(dept.getSchDeptFlow());
				   ref.setRefName(dept.getSchDeptName());
			   }
			   refList.add(ref);
			}
		}
		return  refList;
	}
	
	/**
	 * 组织计学时人员范围(按人员)数据
	 * @param form
	 * @return
	 */
	
	public List<EduCoursePeriodRef> replenishPeriodUserFlow(EduCourseForm form){
		List<EduCoursePeriodRef> refList=new ArrayList<EduCoursePeriodRef>();
		String [] periodUserFlowArray=form.getPeriodUserFlow();
		EduCoursePeriodRef ref=null;
		if(periodUserFlowArray!=null){
			for(String refFlow:periodUserFlowArray){
			   SysUser user=this.userBiz.readSysUser(refFlow);
			   ref=new EduCoursePeriodRef();
			   ref.setRefTypeId(PeriodUserScopeEnum.User.getId());
			   ref.setRefTypeName(PeriodUserScopeEnum.User.getName());
			   if(user!=null){
				   ref.setRefFlow(user.getUserFlow());
				   ref.setRefName(user.getUserName());
			   }
			   refList.add(ref);
			}
		}
		return  refList;
	}
	
}
