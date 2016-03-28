package com.pinde.sci.ctrl.resedu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduCourseChapterBiz;
import com.pinde.sci.biz.edu.IEduCourseFileBiz;
import com.pinde.sci.biz.edu.IEduCourseNoticeBiz;
import com.pinde.sci.biz.edu.IEduCoursePeriodRefBiz;
import com.pinde.sci.biz.edu.IEduCourseScheduleBiz;
import com.pinde.sci.biz.edu.IEduCourseScoreRefBiz;
import com.pinde.sci.biz.edu.IEduCourseTestPaperBiz;
import com.pinde.sci.biz.edu.IEduStudentCourseBiz;
import com.pinde.sci.biz.edu.IEduUserBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.test.ITestResultBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.edu.EduCourseTypeEnum;
import com.pinde.sci.enums.edu.EduStudyStatusEnum;
import com.pinde.sci.enums.njmudu.NjmuEduStudyStatusEnum;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduCourseNoticeExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseFile;
import com.pinde.sci.model.mo.EduCourseNotice;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.TestResult;

@Controller
@RequestMapping("resedu/course")
public class ResEduCourseController extends GeneralController{

	@Autowired
	private IEduCourseBiz courseBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IEduStudentCourseBiz studentCourseBiz;
	@Autowired
	private IEduCourseChapterBiz chapterBiz;
	@Autowired
	private IEduCourseNoticeBiz courseNoticeBiz;
	@Autowired
	private IEduCourseFileBiz courseFileBiz;
	@Autowired
	private IEduCourseScoreRefBiz scoreRefBiz;
	@Autowired
	private IEduCoursePeriodRefBiz periodRefBiz;
	@Autowired
	private IEduUserBiz eduUserBiz;
	@Autowired
	private IEduCourseScheduleBiz eduCourseScheduleBiz;
	@Autowired
	private ITestResultBiz testResultBiz;
	@Autowired
	private IEduCourseTestPaperBiz courseTestPaperBiz;
	@Autowired
	private IResDoctorProcessBiz doctorProcessBiz;
	/**
	 * ��ת��ѧϰ������ҳ��
	 * @param model
	 * @return
	 */
	@RequestMapping("/courseMain")
	public String courseMain(String courseFlow,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		//��ѯ�γ̻�����Ϣ
		EduCourseExt courseExt = this.courseBiz.searchOneWithChapters(courseFlow);
		model.addAttribute("courseExt", courseExt);
		EduCourse course = this.courseBiz.readCourse(courseFlow);
		model.addAttribute("course", course);
		//��ѯѡ�μ�¼
		EduStudentCourse eduStudentCourse=new EduStudentCourse();
		eduStudentCourse.setCourseFlow(courseFlow);
		eduStudentCourse.setUserFlow(currUser.getUserFlow());
		eduStudentCourse.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<EduStudentCourse> studentCourseList=this.studentCourseBiz.searchStudentCourseList(eduStudentCourse);
		if(studentCourseList!=null && !studentCourseList.isEmpty()){
			model.addAttribute("studentCourse", studentCourseList.get(0));
		}
		//��ѯ���½��б�
		List<String> sonChapterFlowList=new ArrayList<String>();
		//��ѯ�½�ѧϰ״̬
		EduCourseSchedule schedule=null;
		Map<String,EduCourseSchedule> scheduleMap=new HashMap<String, EduCourseSchedule>();
		//��ѯ�ڿ���ʦ
		List<String> teacherFlowList=new ArrayList<String>();
		if(null!=courseExt){
			if(null!=courseExt.getChapterList() && !courseExt.getChapterList().isEmpty()){
				for(EduCourseChapter chapter:courseExt.getChapterList()){
					if(StringUtil.isNotBlank(chapter.getTeacherId())){
						teacherFlowList.add(chapter.getTeacherId());
					}
					if(StringUtil.isNotBlank(chapter.getChapterFile())){
						sonChapterFlowList.add(chapter.getChapterFlow());
					}
					schedule=new EduCourseSchedule();
					schedule.setChapterFlow(chapter.getChapterFlow());
					schedule.setUserFlow(currUser.getUserFlow());
					EduCourseSchedule eduCourseSchedule=eduCourseScheduleBiz.searchOne(schedule);
					if(eduCourseSchedule!=null){
						scheduleMap.put(chapter.getChapterFlow(), eduCourseSchedule);
					}
				}
			}
		}
		model.addAttribute("scheduleMap", scheduleMap);
		model.addAttribute("sonChapterFlowList", sonChapterFlowList);
		if(teacherFlowList!=null && !teacherFlowList.isEmpty()){
			List<EduUserExt> teacherList=this.eduUserBiz.searchEduUserByFlows(teacherFlowList);
			model.addAttribute("teacherList", teacherList);
		}
		//��ѯѡ������
		int chooseCount=this.courseBiz.countUserSelectOneCourse(course);
		model.addAttribute("chooseCount", chooseCount);
		//��ѯͬѧ��Ϣ
		List<SysUser> userList=null;
	    userList=this.courseBiz.userSelectOneCourseList(courseFlow);
		model.addAttribute("userList", userList);
		return "res/edu/student/courseMain";
	}
	
	/**
	 * �γ��½ڣ�ѧ����
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/studentChapter")
	public String studentChapter(String courseFlow, Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		EduCourseExt courseExt = courseBiz.searchOneWithChapters(courseFlow);
		model.addAttribute("courseExt", courseExt);
		//��ѯ��ѧ���ÿγ�ÿһ�½ڵ�ѧϰ���
				EduCourseSchedule schedule=null;
				Map<String,EduCourseSchedule> scheduleMap=new HashMap<String, EduCourseSchedule>();
				//��Ÿÿγ����������½�
				List<String> sonChapterFlowList=new ArrayList<String>();
				if(null!=courseExt){
					if(null!=courseExt.getChapterList() && !courseExt.getChapterList().isEmpty()){
						for(EduCourseChapter chapter:courseExt.getChapterList()){
							if(StringUtil.isNotBlank(chapter.getChapterFile())){
								sonChapterFlowList.add(chapter.getChapterFlow());
							}
							schedule=new EduCourseSchedule();
							schedule.setChapterFlow(chapter.getChapterFlow());
							schedule.setUserFlow(currUser.getUserFlow());
							EduCourseSchedule eduCourseSchedule=eduCourseScheduleBiz.searchOne(schedule);
							if(eduCourseSchedule!=null){
								scheduleMap.put(chapter.getChapterFlow(), eduCourseSchedule);
							}
						}
					}
				}
				model.addAttribute("scheduleMap", scheduleMap);
		return "res/edu/student/chapterList";
	}
	
	/**
	 * ����ѧϰ
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping(value="/continueStudy")
	public String continueStudy(String courseFlow){
		SysUser currUser = GlobalContext.getCurrentUser();
		//ѧϰ��¼
		List<EduCourseSchedule> scheduleList=null;
		//��ɵ��½��б�
		List<String> finishChapterFlows=new ArrayList<String>();
		EduCourseExt courseExt = this.courseBiz.searchOneWithChapters(courseFlow);
		List<EduCourseChapter> chapterList=courseExt.getChapterList();
		List<String> sonChapterList=new ArrayList<String>();
		//��ѯ��ѧ�����ſ�����ɵ�ѧϰ��¼
		if(currUser != null && StringUtil.isNotBlank(courseFlow)){
			EduCourseSchedule searchSchedule = new EduCourseSchedule();
			searchSchedule.setCourseFlow(courseFlow);
			searchSchedule.setUserFlow(currUser.getUserFlow());
			searchSchedule.setStudyStatusId(EduStudyStatusEnum.Finish.getId());
			scheduleList = courseBiz.searchScheduleList(searchSchedule);
			//�ѽ����е��½���ˮ�ż���ѧϰ��list
			if(scheduleList != null && !scheduleList.isEmpty()){
				for(EduCourseSchedule schedule:scheduleList){
						finishChapterFlows.add(schedule.getChapterFlow());
				}
			}
		}
		//��ѯ���½ڣ������½���ˮ�ŷ���List
		if(courseExt!=null){
			if(chapterList!=null && !chapterList.isEmpty()){
					for (EduCourseChapter chapter : chapterList) {
						if(StringUtil.isNotBlank(chapter.getChapterFile())){
							sonChapterList.add(chapter.getChapterFlow());
					}
				}
			}
		}
		for(String chapterFlow:sonChapterList){
			if(!finishChapterFlows.contains(chapterFlow)){
				return "redirect:chapterDetail?chapterFlow="+ chapterFlow;
			}
		}
		return null;
	}
	
	@RequestMapping(value="/checkChapter")
	@ResponseBody
	public String checkChapter(String chapterFlow,String courseFlow){
		SysUser currUser=GlobalContext.getCurrentUser();
		//��ѯ��ǰ�γ��Ƿ��Ѿ�����ѧϰ�б�
		 EduStudentCourse studentCourse=new EduStudentCourse();
		 studentCourse.setUserFlow(currUser.getUserFlow());
		 studentCourse.setCourseFlow(courseFlow);
		List<EduStudentCourse> studentCourseList=this.courseBiz.searchStudentCourse(studentCourse); 
		if(studentCourseList==null || studentCourseList.isEmpty()){
			return GlobalConstant.COURSE_LIST_NO_CONTAINS;
		}
		List<String> playChapterFlowList=new ArrayList<String>();
		//��ѯ�ÿγ̵ĵ�һ�ں�û��ѧϰ��¼���½�
		EduCourseExt courseExt = this.courseBiz.searchOneWithChapters(courseFlow);
		List<EduCourseChapter> chapterList=courseExt.getChapterList();
		List<String> sonChapterList=new ArrayList<String>();
		if(courseExt!=null){
			if(chapterList!=null && !chapterList.isEmpty()){
					for (EduCourseChapter chapter : chapterList) {
						if(StringUtil.isNotBlank(chapter.getChapterFile())){
							sonChapterList.add(chapter.getChapterFlow());
						}
					}
					for (String eduCourseChapter : sonChapterList) {
						EduCourseSchedule eduCourseSchedule=new EduCourseSchedule();
						eduCourseSchedule.setChapterFlow(eduCourseChapter);
						EduCourseSchedule courseScheduleRecord=eduCourseScheduleBiz.searchOne(eduCourseSchedule);
						if (courseScheduleRecord!=null) {
							if (EduStudyStatusEnum.Underway.getId().equals(courseScheduleRecord.getStudyStatusId()) ||
									EduStudyStatusEnum.Finish.getId().equals(courseScheduleRecord.getStudyStatusId())) {
									playChapterFlowList.add(eduCourseChapter);
							}
						}
					}
					String isChapter;
					
					if (!playChapterFlowList.isEmpty()) {
						isChapter=playChapterFlowList.get(playChapterFlowList.size()-1);
					}else{
						isChapter=chapterFlow;
					}
					if(playChapterFlowList.contains(chapterFlow)){
						return chapterFlow;
					}
					EduCourseSchedule eduCourseSchedule=new EduCourseSchedule();
					eduCourseSchedule.setChapterFlow(chapterFlow);
					EduCourseSchedule courseScheduleRecord=eduCourseScheduleBiz.searchOne(eduCourseSchedule);
					if (sonChapterList.indexOf(chapterFlow)<=sonChapterList.indexOf(isChapter) && courseScheduleRecord==null) {
						eduCourseSchedule.setCourseFlow(courseFlow);
						eduCourseSchedule.setUserFlow(currUser.getUserFlow());
						eduCourseSchedule.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
						eduCourseSchedule.setStudyStatusName(EduStudyStatusEnum.getNameById(eduCourseSchedule.getStudyStatusId()));
						eduCourseScheduleBiz.edit(eduCourseSchedule);
						return eduCourseSchedule.getChapterFlow();
					}
					else{
						return GlobalConstant.SOME_CHAPTER_NO_FINISH;
					}
					
				}
			
		}
		return null;
	}
	
	/**
	 * ����γ�
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/joinMyCourseList")
	@ResponseBody
	public String joinMyCourseList(String courseFlow,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		EduCourse course=this.courseBiz.readCourse(courseFlow);
		//��ѯ���ſ��Ƿ��ѧ��
		String scoreBl=this.scoreRefBiz.searchScoreJurisdiction("", currUser.getUserFlow(), "", course.getCourseFlow());
		//��ѯ���ſ��Ƿ��ѧʱ
		String periodBl=this.periodRefBiz.searchPeriodJurisdiction("", currUser.getUserFlow(), "", course.getCourseFlow());
		//��ѯ��ǰ�û���ת����
		ResDoctorSchProcess process=this.doctorProcessBiz.searchCurrDept(currUser);
		EduStudentCourse studentCourse=new EduStudentCourse();
		studentCourse.setUserFlow(currUser.getUserFlow());
		studentCourse.setCourseFlow(course.getCourseFlow());
		studentCourse.setStudyStatusId(EduStudyStatusEnum.NotStarted.getId());
		studentCourse.setStudyStatusName(EduStudyStatusEnum.NotStarted.getName());
		studentCourse.setCourseTypeId(EduCourseTypeEnum.Optional.getId());
		studentCourse.setCourseTypeName(EduCourseTypeEnum.Optional.getName());
		studentCourse.setChooseTime(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
		if(process!=null){
			studentCourse.setSchDeptFlow(process.getSchDeptFlow());
			studentCourse.setSchDeptName(process.getSchDeptName());
		}
		if(GlobalConstant.FLAG_Y.equals(scoreBl)){
			studentCourse.setCourseCredit(course.getCourseCredit());
		}else{
			studentCourse.setCourseCredit("0");
		}
		if(GlobalConstant.FLAG_Y.equals(periodBl)){
			studentCourse.setCoursePeriod(course.getCoursePeriod());
		}else{
			studentCourse.setCoursePeriod("0");
		}
		int result=this.studentCourseBiz.saveCourseAnnualTrain(studentCourse, course, currUser);
		if(result!=GlobalConstant.ONE_LINE){
			return GlobalConstant.OPRE_FAIL;
		}
		return courseFlow;
	}
	
	/**
	 * ��ʱ������Ƶ���Ž���
	 * @param nowMinutes
	 * @param nowSecond
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping("/saveVideoTime")
	@ResponseBody
	public String saveVideoTime(String nowMinutes,String nowSecond,String chapterFlow){
		SysUser currUser=GlobalContext.getCurrentUser();
		EduCourseSchedule eduCourseSchedule=new EduCourseSchedule();
		eduCourseSchedule.setUserFlow(currUser.getUserFlow());
		eduCourseSchedule.setChapterFlow(chapterFlow);
		EduCourseSchedule courseSchedule=this.eduCourseScheduleBiz.searchOne(eduCourseSchedule);
		if(courseSchedule!=null){
			if(StringUtil.isNotBlank(nowMinutes) && StringUtil.isNotBlank(nowSecond)
			  && !"undefined".equals(nowMinutes) && !"undefined".equals(nowSecond)){
				String currTime=nowMinutes+":"+nowSecond;
				courseSchedule.setCurrentTime(currTime);
			    int result=this.eduCourseScheduleBiz.edit(courseSchedule);
			    if(result==GlobalConstant.ONE_LINE){
			    	return GlobalConstant.OPERATE_SUCCESSED;
			    }
			}
			
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * ��Ƶ������ɺ�
	 * @param nowMinutes
	 * @param nowSecond
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping("/completeVideo")
	@ResponseBody
	public String completeVideo(String chapterFlow){
		SysUser currUser=GlobalContext.getCurrentUser();
		int result=this.eduCourseScheduleBiz.modifyScheduleForFinishVideo(currUser.getUserFlow(), chapterFlow);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.OPERATE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * �½���ϸ��Ϣ
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/chapterDetail")
	public String courseDetail(String chapterFlow,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		EduCourse course=null; 
		//��ѯ��Ƶ��Ϣ
		EduCourseChapter chapter=this.chapterBiz.seachOne(chapterFlow);
		if(chapter!=null){
			model.addAttribute("chapter", chapter);
			//��ѯ�ڿ���ʦ
			SysUser teacher=this.userBiz.readSysUser(chapter.getTeacherId());
		    model.addAttribute("teacher", teacher);
		  //��ѯ�γ���Ϣ
			course=this.courseBiz.readCourse(chapter.getCourseFlow());
			model.addAttribute("course", course);
		}
		if(chapter!=null && course!=null){
		//��ѯѧϰ��¼
		EduStudentCourse eduStudentCourse=new EduStudentCourse();
		eduStudentCourse.setCourseFlow(course.getCourseFlow());
		eduStudentCourse.setUserFlow(currUser.getUserFlow());
		eduStudentCourse.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<EduStudentCourse> studentCourseList=this.studentCourseBiz.searchStudentCourseList(eduStudentCourse);
		//ѡ�μ�¼
		if(studentCourseList!=null && !studentCourseList.isEmpty()){
			EduStudentCourse studentCourse=studentCourseList.get(0);
			if(StringUtil.isBlank(studentCourse.getStartStudyTime())){
				studentCourse.setStartStudyTime(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
			}
			if(chapter!=null){
			studentCourse.setCurrentChapterFlow(chapter.getChapterFlow());
			}
			if(EduStudyStatusEnum.NotStarted.getId().equals(studentCourse.getStudyStatusId())){
				studentCourse.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
				studentCourse.setStudyStatusName(EduStudyStatusEnum.Underway.getName());
			}
			this.studentCourseBiz.save(studentCourse);
			model.addAttribute("studentCourse", studentCourse);
		//�½�ѧϰ��¼
		 EduCourseSchedule schedule=new EduCourseSchedule();
		 schedule.setUserFlow(currUser.getUserFlow());
		 schedule.setChapterFlow(chapter.getChapterFlow());
		 schedule.setCourseFlow(course.getCourseFlow());
		 EduCourseSchedule eduCourseSchedule= eduCourseScheduleBiz.searchOne(schedule);
		 if(eduCourseSchedule==null){
			 schedule.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
			 schedule.setStudyStatusName(EduStudyStatusEnum.Underway.getName());
			 this.eduCourseScheduleBiz.edit(schedule);
		 }else{
			 if(!EduStudyStatusEnum.Underway.getId().equals(eduCourseSchedule.getStudyStatusId())
			    && !EduStudyStatusEnum.Finish.getId().equals(eduCourseSchedule.getStudyStatusId())){
				 schedule.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
				 schedule.setStudyStatusName(EduStudyStatusEnum.Underway.getName());
				 this.eduCourseScheduleBiz.edit(schedule);
			 }
		 }
		 //��ѯ���½ڰ󶨵��Ծ�
		 EduCourseTestPaper eduCourseTestPaper=new EduCourseTestPaper();
		 eduCourseTestPaper.setChapterFlow(chapterFlow);
		 List<EduCourseTestPaper> courseTestPaperList=courseTestPaperBiz.searchCourseTestPaperList(eduCourseTestPaper);
		 if(courseTestPaperList!=null && !courseTestPaperList.isEmpty()){
			model.addAttribute("paperFlow", courseTestPaperList.get(0).getPaperFlow());
		 }
	     //��ѯ�Ƿ���ʾ��ʼ���԰�ť
		 List<TestResult> resultList=this.testResultBiz.searchPassResult(currUser.getUserFlow(), chapterFlow);
		 model.addAttribute("resultList", resultList);
		}
		}
		return "res/edu/student/courseDetail";
	}
    
	/**
	 * �����ļ�����Json
	 * @param chapterFlow
	 * @return
	 */
	@RequestMapping(value="/chapterData")
	@ResponseBody
	public Map<String,Object> chapterDataJson(String chapterFlow){
		SysUser currUser=GlobalContext.getCurrentUser();
		Map<String,Object> dataMap=new HashMap<String, Object>();
		EduCourseChapter chapter=this.chapterBiz.seachOne(chapterFlow);
		dataMap.put("chapter", chapter);
		if(chapter!=null){
			EduCourseSchedule eduCourseSchedule=new EduCourseSchedule();
			eduCourseSchedule.setUserFlow(currUser.getUserFlow());
			eduCourseSchedule.setChapterFlow(chapterFlow);
			EduCourseSchedule courseSchedule=this.eduCourseScheduleBiz.searchOne(eduCourseSchedule);
			if(courseSchedule!=null){
				String currentChapterTime=courseSchedule.getCurrentTime();
				String nowMinutes="";
				String nowSecond="";
				int currTime=0;
				if(currentChapterTime==null || StringUtil.isBlank(currentChapterTime)){
					currentChapterTime="0";
					nowMinutes="00";
					nowSecond="00";
				} else {
					String [] timeArray=currentChapterTime.split(":");
					nowMinutes=timeArray[0];
					nowSecond=timeArray[1];
					currTime=Integer.parseInt(nowMinutes)*60+Integer.parseInt(nowSecond);
				}
				dataMap.put("nowMinutes", nowMinutes);
				dataMap.put("nowSecond", nowSecond);
				dataMap.put("currTime", currTime);
			}
		}
		return dataMap;
	}
	
	/**
	 * У����Ƶ����ʱ�������֤��
	 * @param verifyCode
	 * @return
	 */
	@RequestMapping(value="/checkVerifyCode")
	@ResponseBody
	public String checkVerifyCode(String verifyCode){
		if(StringUtil.isNotBlank(verifyCode)){
			if(verifyCode.equals(String.valueOf(GlobalContext.getSessionAttribute("verifyCode")))){
				return GlobalConstant.FLAG_Y;
			}
		}
		return GlobalConstant.FLAG_N;
	}
	
	@RequestMapping(value="/nextChapters")
	@ResponseBody
	public String nextChapters(String chapterFlow,String courseFlow){
		String chapters= eduCourseScheduleBiz.nextChapter(chapterFlow,courseFlow);
		return chapters;
	}
//===================================֪ͨ====================================	
	/**
	 * ����֪ͨ����ʦ��
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/loadNotice")
	public String loadNotice(String courseFlow, Model model){
		EduCourse course=this.courseBiz.readCourse(courseFlow);
		model.addAttribute("course", course);
		EduCourseNotice courseNotice = new EduCourseNotice();
		courseNotice.setCourseFlow(courseFlow);
		List<EduCourseNoticeExt> eduCourseNoticeExtList = courseNoticeBiz.searchCourseNoticeListByCourseFlowRes(courseFlow);
		model.addAttribute("eduCourseNoticeExtList", eduCourseNoticeExtList);
		return "res/edu/student/noticeList";
	}
	
	/**
	 * ����֪ͨ����ʦ��
	 * @param courseNotice
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveNotice")
	@ResponseBody
	public String saveNotice(EduCourseNotice courseNotice, Model model){
		if(StringUtil.isNotBlank(courseNotice.getNoticeTitle())){
			SysUser currUser = GlobalContext.getCurrentUser();
			courseNotice.setUserFlow(currUser.getUserFlow());
			courseNotice.setUserName(currUser.getUserName());
			int result = courseNoticeBiz.save(courseNotice);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.RELEASE_SUCCESSED;
			}
		}
		return GlobalConstant.RELEASE_FAIL;
	}
	
	/**
	 * �༭֪ͨ
	 * @param courseNotice
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editNotice")
	@ResponseBody
	public EduCourseNotice editNotice(String noticeFlow, Model model){
		if(StringUtil.isNotBlank(noticeFlow)){
			EduCourseNotice courseNotice = courseNoticeBiz.readCourseNotice(noticeFlow);
			return courseNotice;
		}
		return null;
	}
	
	/**
	 * ɾ��֪ͨ����ʦ��
	 * @param noticeFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/delNotice")
	@ResponseBody
	public String delNotice(String noticeFlow, Model model){
		if(StringUtil.isNotBlank(noticeFlow)){
			EduCourseNotice courseNotice = new EduCourseNotice();
			courseNotice.setNoticeFlow(noticeFlow);
			courseNotice.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = courseNoticeBiz.save(courseNotice);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}

//===================================�γ�����===================================
	/**
	 * �γ����ϣ���ʦ��
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping(value="/loadCourseFile")
	public String loadCourseFile(String courseFlow,Model model){
		EduCourse course=this.courseBiz.readCourse(courseFlow);
		model.addAttribute("course", course);
		EduCourseFile courseFile=new EduCourseFile();
		courseFile.setCourseFlow(courseFlow);
		List<EduCourseFile> courseFileList = courseFileBiz.searchCourseFileList(courseFile);
		model.addAttribute("courseFileList", courseFileList);
		return "res/edu/student/fileList";
	}
	
	/**
	 * ����γ����ϣ���ʦ��
	 * @param file
	 * @param courseFile
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/saveCourseFile"})
	@ResponseBody
	public String saveCourseFile(MultipartFile file, String courseFlow) throws Exception{
		if(file.getSize() > 0){
			String checkResult = checkFile(file);
			if(checkResult != GlobalConstant.FLAG_Y){
				return checkResult;
			}
		}
		int result = courseFileBiz.operateFile(file, courseFlow);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.UPLOAD_SUCCESSED;
		}
		return GlobalConstant.UPLOAD_FAIL;
	}
	
	/**
	 * ����ļ���С������
	 * @param file
	 * @return
	 */
	private String checkFile(MultipartFile file) {
		//����ļ���С������
		if(file.getSize() > 10*1024*1024){
			return GlobalConstant.VALIDATE_FILE_FAIL ;
		}
		return GlobalConstant.FLAG_Y;//��ִ�б���
	}
	
	/**
	 * ɾ���γ�����
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/delCourseFile")
	@ResponseBody
	public String delCourseFile(String recordFlow, Model model){
		if(StringUtil.isNotBlank(recordFlow)){
			int result = courseFileBiz.delCourseFile(recordFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
}
