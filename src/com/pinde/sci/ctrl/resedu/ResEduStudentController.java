package com.pinde.sci.ctrl.resedu;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduCourseChapterBiz;
import com.pinde.sci.biz.edu.IEduCourseScheduleBiz;
import com.pinde.sci.biz.edu.IEduCourseTestPaperBiz;
import com.pinde.sci.biz.edu.IEduStudentCourseBiz;
import com.pinde.sci.biz.edu.IEduUserCenterBiz;
import com.pinde.sci.biz.edu.impl.EduCourseChapterBizImpl;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.test.ITestResultBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.ctrl.edu.EduCourseManageController;
import com.pinde.sci.enums.edu.EduCourseTypeEnum;
import com.pinde.sci.enums.edu.EduStudyStatusEnum;
import com.pinde.sci.enums.njmudu.NjmuEduStudyStatusEnum;
import com.pinde.sci.form.test.TestResultForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduCourseTestPaperExt;
import com.pinde.sci.model.edu.EduStudentCourseExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.TestResult;
import com.pinde.sci.model.test.TestResultExt;


@Controller
@RequestMapping("resedu/student")
public class ResEduStudentController extends GeneralController{

	private static Logger logger = LoggerFactory.getLogger(EduCourseManageController.class);
	
	@Autowired
	private IEduCourseBiz courseBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IEduStudentCourseBiz studentCourseBiz;
	@Autowired
	private IEduCourseChapterBiz chapterBiz;
	@Autowired
	private IEduUserCenterBiz userCenterBiz;
	@Autowired
	private IResDoctorProcessBiz doctorProcessBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private ISchDeptBiz schDeptBiz;
	@Autowired
	private IEduCourseTestPaperBiz eduCourseTestPaperBiz;
	@Autowired
	private ITestResultBiz resultBiz;
	@Autowired
	private IEduCourseScheduleBiz scheduleBiz;
	
	
	
	/**
	 * ��ת��ѧԱѧϰ������ҳ��
	 * @param model
	 * @return
	 */
	@RequestMapping("/main")
	public String studentMain(Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, "student");
		return "res/edu/student/main";
	}
	/**
	 * ��ѯ��ǰ�γ̵������Ծ�
	 * @param model
	 * @return
	 */
	@RequestMapping("/loadCourseExam")
	public String loadCourseExam(String courseFlow,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		List<EduCourseTestPaperExt> eduCourseTestPaperExts=this.eduCourseTestPaperBiz.searchCourseTestPaperExt(courseFlow);
		List<EduCourseTestPaperExt> eduCourseTestPaperExtsd=new ArrayList<EduCourseTestPaperExt>();
		if(eduCourseTestPaperExts != null && !eduCourseTestPaperExts.isEmpty()){
			List<String> chapterFlowList=null;
			List<String> paperFlowList = new ArrayList<String>();
			Map<String, List<String>> chapterMap=new HashMap<String, List<String>>();
			List<EduCourseChapter> chapterList = null ;
			for(EduCourseTestPaperExt ext :eduCourseTestPaperExts){
				if (!paperFlowList.contains(ext.getPaperFlow())) {
					eduCourseTestPaperExtsd.add(ext);
					paperFlowList.add(ext.getPaperFlow());
					chapterFlowList = new ArrayList<String>();
					chapterMap.put(ext.getPaperFlow(), chapterFlowList);
				}
				chapterMap.get(ext.getPaperFlow()).add(ext.getChapterFlow());
			}
			Map<String, Object> eduCourseChapterMap = new HashMap<String, Object>();
			for (Entry<String, List<String>> map:chapterMap.entrySet()) {
				chapterList  = chapterBiz.searchChapterListByChapterFlowList(map.getValue());
				if(chapterList != null && !chapterList.isEmpty()){
					eduCourseChapterMap.put(map.getKey(),chapterList);
				}
			}
			
			
			model.addAttribute("eduCourseTestPaperExts", eduCourseTestPaperExtsd);
			Map<String, Object> paramMap = new HashMap<String, Object>();
			Map<String, String> chapterFinshMap = new HashMap<String, String>();
			Map<String, String> examPassMap = new HashMap<String, String>();
			for(EduCourseTestPaperExt ext :eduCourseTestPaperExts){
				paramMap.put("userFlow", currUser.getUserFlow());
				paramMap.put("chapterFlowList", chapterMap.get(ext.getPaperFlow()));
				List<EduCourseSchedule> courseScheduleList =  scheduleBiz.searchEduCourseScheduleList(paramMap);
				if(courseScheduleList != null && !courseScheduleList.isEmpty()){
					for (EduCourseSchedule eduCourseSchedule : courseScheduleList) {
						if (GlobalConstant.FLAG_Y.equals(eduCourseSchedule.getChapterFinishFlag())) {
							chapterFinshMap.put(ext.getPaperFlow(), GlobalConstant.FLAG_Y);
						}
						if (GlobalConstant.FLAG_Y.equals(eduCourseSchedule.getExamPassFlag())) {
							examPassMap.put(ext.getPaperFlow(), GlobalConstant.FLAG_N);
						}
					}
				}
					
			}
			model.addAttribute("eduCourseChapterMap", eduCourseChapterMap);
			model.addAttribute("chapterFinshMap", chapterFinshMap);
			model.addAttribute("examPassMap", examPassMap);
	
		Map<String,Object> map=new HashMap<String, Object>();
		for (EduCourseTestPaperExt eduCourseTestPaperExt : eduCourseTestPaperExts) {
			TestResult test=new  TestResult();
			test.setPaperFlow(eduCourseTestPaperExt.getPaperFlow());
			test.setUserFlow(currUser.getUserFlow());
			test.setPassFlag(GlobalConstant.FLAG_Y);
			List<TestResult> list=resultBiz.searchTestResultList(test);
			if (list!=null&& !list.isEmpty()) {
				map.put(eduCourseTestPaperExt.getPaperFlow(),GlobalConstant.FLAG_Y);
			}else{
				map.put(eduCourseTestPaperExt.getPaperFlow(),GlobalConstant.FLAG_N);
			}
		}
		model.addAttribute("map", map);
		}
		return "res/edu/student/courseExam";
		
	}
	
	@RequestMapping("/reasonTestreRultChaTestPaper")
	public String reasonTestreRultChaTestPaper(String courseFlow,String userFlow,Model model,TestResultForm testResult,Integer currentPage, HttpServletRequest request){
		if (userFlow!=null) {
			
		}else{
			SysUser curruser=GlobalContext.getCurrentUser();
			userFlow=curruser.getUserFlow();
		}
		
		PageHelper.startPage(currentPage,getPageSize(request));
		testResult.setTestTime(DateUtil.transDateTime(testResult.getTestTime(), "yyyy-MM-dd HH:mm", "yyyyMMddHHmmss"));
		testResult.setTestTimeTwo(DateUtil.transDateTime(testResult.getTestTimeTwo(), "yyyy-MM-dd HH:mm", "yyyyMMddHHmmss"));
		List<TestResultExt> list=resultBiz.reasonTestreRultChaTestPaper(courseFlow,userFlow, testResult);
		model.addAttribute("list", list);
		return "res/edu/student/testDetail";
	}
	
	@RequestMapping("/studyDetail")
	public String studyDetail(String courseFlow, Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		EduCourseChapter chapter = new EduCourseChapter();
		chapter.setCourseFlow(courseFlow);
		List<EduCourseChapter> chapterList = chapterBiz.searchCourseChapterList(chapter, "CREATE_TIME DESC", GlobalConstant.FLAG_Y);
		
		model.addAttribute("chapterList", chapterList);
		EduCourseSchedule schedule = new EduCourseSchedule();
		schedule.setUserFlow(currUser.getUserFlow());
		schedule.setCourseFlow(courseFlow);
		List<EduCourseSchedule> scheduleList = scheduleBiz.searchEduCourseScheduleList(schedule);
		if(scheduleList != null && !scheduleList.isEmpty()){
			Map<String, EduCourseSchedule> chapterScheduleMap =  new HashMap<String, EduCourseSchedule>();
			for(EduCourseSchedule s :scheduleList){
				chapterScheduleMap.put(s.getChapterFlow(), s);
			}
			model.addAttribute("chapterScheduleMap", chapterScheduleMap);
		}
		return "res/edu/student/studyDetail";
	}
	
	@RequestMapping("/startTest")
	public String startTest(String paperFlow,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
	    String url=InitConfig.getSysCfg("res_edu_test_i")+"DepartmentalExaminationHandler.ashx?UserName="+currUser.getUserCode()+"&SoluID="+paperFlow+"&RealName="+currUser.getUserName();
		model.addAttribute("url", url);
		return "res/edu/student/testPaper";
	}
	
	
	@RequestMapping("/loadMyTestHistory")
	public String loadMyTestHistory(String paperFlow,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		TestResult testResult=new TestResult();
		testResult.setUserFlow(currUser.getUserFlow());
		testResult.setPaperFlow(paperFlow);
		List<TestResult> resultList=this.resultBiz.searchTestResultList(testResult);
		model.addAttribute("resultList", resultList);
		return "res/edu/student/myTestHistory";
	}
	
	/**
	 * ��ѯ�ҵĿγ�	
	 * @param eduCourse
	 * @param studyStatus
	 * @param courseTypeId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showStuCourse")
	public String showCourse(EduCourse eduCourse,String studyStatus,String courseTypeId,Model model){
		eduCourse.setCourseTypeId("");
		SysUser currUser=GlobalContext.getCurrentUser();
		//��ѯ��ѧ����ǰ��ת����
				ResDoctorSchProcess process=this.doctorProcessBiz.searchCurrDept(currUser);
				//����ѧ����Ҫ���޵�û��ѡ��Ŀγ̲������ѡ�α�
				if(process!=null){
					this.studentCourseBiz.saveStudentRequiredCourse(currUser,process.getSchDeptFlow());
				}else{
					this.studentCourseBiz.saveStudentRequiredCourse(currUser,null);
				}
		//���ѧϰ״̬Ϊ�գ�Ĭ������ѧϰ
		List<String> studyStatusIdList=null;
		if(StringUtil.isBlank(studyStatus)){
			studyStatusIdList=new ArrayList<String>();
			studyStatusIdList.add(EduStudyStatusEnum.NotStarted.getId());
			studyStatusIdList.add(EduStudyStatusEnum.Underway.getId());
		}else if(EduStudyStatusEnum.Underway.getId().equals(studyStatus)){
			studyStatusIdList=new ArrayList<String>();
			studyStatusIdList.add(EduStudyStatusEnum.NotStarted.getId());
			studyStatusIdList.add(EduStudyStatusEnum.Underway.getId());
		}else{
			studyStatusIdList=new ArrayList<String>();
			studyStatusIdList.add(studyStatus);
		}
		//��֯�γ����Ͳ�ѯ����
		List<String> courseTypeIdList=null;
		if(EduCourseTypeEnum.Required.getId().equals(courseTypeId)){
			courseTypeIdList=new ArrayList<String>();
			courseTypeIdList.add(EduCourseTypeEnum.Required.getId());
		}
		if("Other".equals(courseTypeId)){
			courseTypeIdList=new ArrayList<String>();
			for(EduCourseTypeEnum enu:EduCourseTypeEnum.values()){
				if(!EduCourseTypeEnum.Required.getId().equals(enu.getId())){
					courseTypeIdList.add(enu.getId());
				}
			}
		}
		//��ѯ����ѧ��ѡ������пγ�
		List<EduStudentCourseExt> studentCourseExtList=studentCourseBiz.searchStuCourses(eduCourse, currUser,studyStatusIdList,courseTypeIdList);
		model.addAttribute("studentCourseExtList", studentCourseExtList);
		//��ѯ��ѧ��ÿ�ſν���
		EduCourseSchedule schedule=null;
	    Map<String,Object> scheduleMap=new HashMap<String, Object>();
		if(null!=studentCourseExtList && !studentCourseExtList.isEmpty()){
			for(EduStudentCourseExt eduCourseExt:studentCourseExtList){
				schedule=new EduCourseSchedule();
				schedule.setUserFlow(currUser.getUserFlow());
				schedule.setCourseFlow(eduCourseExt.getCourseFlow());
				schedule.setStudyStatusId(NjmuEduStudyStatusEnum.Finish.getId());
				int parent=this.chapterBiz.countParentChapterByCourseFlow(eduCourseExt.getCourse());
				List<EduCourseSchedule> finishScheduleList=this.courseBiz.searchScheduleList(schedule);
				if(finishScheduleList!=null && !finishScheduleList.isEmpty()){
					BigDecimal allScheduleSize=new BigDecimal(parent);
					BigDecimal finishScheduleSize=new BigDecimal(finishScheduleList.size());
					BigDecimal countSchedule=finishScheduleSize.divide(allScheduleSize, 2 , BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal("100")).setScale(0,BigDecimal.ROUND_HALF_UP);
					scheduleMap.put(eduCourseExt.getCourseFlow(), countSchedule);
				}
			}
		 }
		 model.addAttribute("scheduleMap", scheduleMap);
		return "res/edu/student/courseList";
	}
	
	/**
	 * ����ѧϰ��ͼ
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/loadStudyInfo")
	public String loadStudyInfo(String schDeptFlow,Model model){
		SchDept schDept=this.schDeptBiz.readSchDept(schDeptFlow);
		SysUser currUser=GlobalContext.getCurrentUser();
		Map<String,Integer> countUserCourseMap=null;
		Map<String,Integer> countUserCourseFinishMap=null;
		//��ѯ��ѧ�����޿�,ѡ�޿�������������
		countUserCourseMap=this.userCenterBiz.countUserCourse(currUser.getUserFlow(),null,schDept.getDeptFlow());
		model.addAttribute("countUserCourseMap", countUserCourseMap);
		//��ѯ��ѧ�����޿�,ѡ�޿���������ѧ�꣩
		countUserCourseFinishMap=this.userCenterBiz.countUserCourse(currUser.getUserFlow(),EduStudyStatusEnum.Finish.getId(),schDept.getDeptFlow());
		model.addAttribute("countUserCourseFinishMap", countUserCourseFinishMap);
		//��ѯ��ѧ�����ѧ��������ú�δ��ã�
		Map<String,Object> sumUserCreditMap=this.studentCourseBiz.searchUserCreditMap(currUser,schDept.getDeptFlow());
		model.addAttribute("sumUserCreditMap", sumUserCreditMap);
		//��ѯ��ѧ������ѧϰ�Ŀγ�
		EduCourse course=new EduCourse();
		course.setDeptFlow(schDept.getDeptFlow());
		PageHelper.startPage(1, 3);
		List<EduStudentCourseExt> studentCourseExtList=this.studentCourseBiz.searchStuCourses(course, currUser, null, null);
		model.addAttribute("studentCourseExtList", studentCourseExtList);
		return "res/edu/student/studyInfo";
	}
	
	/**
	 * ���ط��ֿγ�
	 * @param eduCourse
	 * @param order
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findCourse")
	public String findCourse(EduCourse eduCourse,String order,Integer currentPage,HttpServletRequest request,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		if(StringUtil.isBlank(order)){
			order="new";
		}
		//��ѯ��ѧ����ǰ��ת����
		ResDoctorSchProcess process=this.doctorProcessBiz.searchCurrDept(currUser);
		String schDeptFlow=null;
		if(process!=null){
			schDeptFlow=process.getSchDeptFlow();
		}
		ResDoctor resDoctor=this.resDoctorBiz.readDoctor(currUser.getUserFlow());
		PageHelper.startPage(currentPage, 20);
		List<EduCourseExt> courseExtList=this.studentCourseBiz.searchFindCoursePersonal(currUser,resDoctor, schDeptFlow, order, eduCourse);
		model.addAttribute("courseExtList", courseExtList);
		return "res/edu/student/findCourse";
	}
	
	/**
	 * ���ط��ֿγ�(��ͨҽʦ)
	 * @param eduCourse
	 * @param order
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/loadFindCourse")
	public String loadFindCourse(EduCourse eduCourse,String checkSchDeptFlow,String isCredit,String isPeriod,
			                     Integer currentPage,HttpServletRequest request,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		PageHelper.startPage(currentPage, 20);
		List<EduCourseExt> courseExtList=this.studentCourseBiz.searchFindCourseNoDoctor(currUser, null, null, checkSchDeptFlow, isCredit, isPeriod, eduCourse);
		model.addAttribute("courseExtList", courseExtList);
		return "res/edu/student/findCourse";
	}
	
	/**
	 * ����ѧϰ��¼
	 * @param eduCourse
	 * @param order
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/studyRecord")
	public String studyRecord(EduCourse eduCourse,String studyStatusId,String courseTypeId,
			                  Integer currentPage,HttpServletRequest request,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		List<String> studyStatusIdList=new ArrayList<String>();
		if(StringUtil.isNotBlank(studyStatusId)){
			studyStatusIdList.add(studyStatusId);
		}
		List<String> courseTypeIdList=new ArrayList<String>();
		if(StringUtil.isNotBlank(courseTypeId)){
			courseTypeIdList.add(courseTypeId);
		}
		//��ѯѧ����ѡ��Ŀγ̼�¼
		List<EduStudentCourseExt> eduStudentCourseExtList=studentCourseBiz.searchStuCourses(eduCourse, currUser,studyStatusIdList,courseTypeIdList);
        model.addAttribute("eduStudentCourseExtList", eduStudentCourseExtList);
        //��ѯ��ǰ��������
        List<SysDept> deptList=this.deptBiz.searchDeptByOrg(currUser.getOrgFlow());
        model.addAttribute("deptList", deptList);
		return "res/edu/student/studyRecord";
	}
	
	/**
	 * ѧϰ������ͼ
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/studyCenter")
	public String studyCenter(Model model){
		//��ѯ��ǰ������ת����
		SysUser currUser=GlobalContext.getCurrentUser();
		List<SchDept> schDeptList=searchSchDeptList(currUser.getOrgFlow());
		model.addAttribute("schDeptList", schDeptList);
		return "res/edu/studyCenter";
	}
	
	@RequestMapping(value="/loadUserInfo")
	public String loadUserInfo(Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		Map<String,Integer> countUserCourseMap=null;
		Map<String,Integer> countUserCourseFinishMap=null;
		//��ѯ��ѧ�����޿�,ѡ�޿�������������
		countUserCourseMap=this.userCenterBiz.countUserCourse(currUser.getUserFlow(),null,null);
		model.addAttribute("countUserCourseMap", countUserCourseMap);
		//��ѯ��ѧ�����޿�,ѡ�޿���������ѧ�꣩
		countUserCourseFinishMap=this.userCenterBiz.countUserCourse(currUser.getUserFlow(),EduStudyStatusEnum.Finish.getId(),null);
		model.addAttribute("countUserCourseFinishMap", countUserCourseFinishMap);
		//��ѯ��ѧ�����޿�,ѡ�޿�������δѧ�꣩
		int requireNotFinish=countUserCourseMap.get(EduCourseTypeEnum.Required.getId())-countUserCourseFinishMap.get(EduCourseTypeEnum.Required.getId());
		int optionalNotFinish=countUserCourseMap.get(EduCourseTypeEnum.Optional.getId())-countUserCourseFinishMap.get(EduCourseTypeEnum.Optional.getId());
		model.addAttribute("requireNotFinish", requireNotFinish);
		model.addAttribute("optionalNotFinish", optionalNotFinish);
		//��ѯ��ѧ�����ѧ��������ú�δ��ã�
		Map<String,Object> sumUserCreditMap=this.studentCourseBiz.searchUserCreditMap(currUser,null);
		model.addAttribute("sumUserCreditMap", sumUserCreditMap);
		//��ѯ��ѧ������ѧϰ�Ŀγ�
		PageHelper.startPage(1, 3);
		List<EduStudentCourseExt> studentCourseExtList=this.studentCourseBiz.searchStuCourses(null, currUser, null, null);
		model.addAttribute("studentCourseExtList", studentCourseExtList);
		return "res/edu/userInfo";
	}
	
	
//======================================================================================	
	/**
	 * ��ʱ���ʽ���֣��룩ת��Ϊ��
	 * @param time
	 * @return
	 */
	public int timeTranSec(String time){
		if(StringUtil.isBlank(time)){
			time="00:00";
		}
		//�ѵ�ǰ��Ƶʱ�䰴���ָ�ɷ���
    	String [] currTimeArray=time.split(":");
    	//��ǰ��
    	int currTimeMin=Integer.parseInt(currTimeArray[0]);
    	//��ǰ��
    	int currTimeSec=Integer.parseInt(currTimeArray[1]);
    	int currSec=currTimeMin*60+currTimeSec;
		return currSec;
	}
	
	@RequestMapping(value="/personalCenter")
	public String personalCenter(Model model){
		return "res/edu/student/personalCenter";
	}
	
	/**
	 * ��ѯ��ת����
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
}
