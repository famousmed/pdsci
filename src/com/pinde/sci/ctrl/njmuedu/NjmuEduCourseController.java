package com.pinde.sci.ctrl.njmuedu;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseChapterBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduCollectionBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseAnswerBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseChapterBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseQuestionBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseScheduleBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduStudentCourseBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduStudyHistoryBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduUserBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.njmudu.NjmuEduCollectionTypeEnum;
import com.pinde.sci.enums.njmudu.NjmuEduQuestionStatusEnum;
import com.pinde.sci.enums.njmudu.NjmuEduStudyHistoryTypeEnum;
import com.pinde.sci.enums.njmudu.NjmuEduStudyStatusEnum;
import com.pinde.sci.enums.njmudu.NjmuEduVideoLevelEnum;
import com.pinde.sci.form.njmuedu.CourseInfoForm;
import com.pinde.sci.form.njmuedu.MajorForm;
import com.pinde.sci.form.njmuedu.SysOrgExt;
import com.pinde.sci.model.njmuedu.EduAnswerExt;
import com.pinde.sci.model.njmuedu.EduCourseChapterExt;
import com.pinde.sci.model.njmuedu.EduCourseExt;
import com.pinde.sci.model.njmuedu.EduCourseScheduleExt;
import com.pinde.sci.model.njmuedu.EduQuestionExt;
import com.pinde.sci.model.njmuedu.EduUserExt;
import com.pinde.sci.model.mo.EduAnswer;
import com.pinde.sci.model.mo.EduCollection;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysUser;
import com.sdk.utils.GloatContant;

@Controller
@RequestMapping("njmuedu/course")
public class NjmuEduCourseController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(NjmuEduCourseController.class);
	
	@Autowired
	private INjmuEduCourseBiz eduCourseBiz;
	@Autowired
	private INjmuEduCourseChapterBiz eduCourseChapterBiz;
	@Autowired
	private INjmuEduCourseQuestionBiz questionBiz;
	@Autowired
	private INjmuEduCourseAnswerBiz answerBiz;
	@Autowired
	private INjmuEduCourseScheduleBiz eduCourseScheduleBiz;
	@Autowired
	private INjmuEduCollectionBiz collectionBiz;
	@Autowired
	private INjmuEduUserBiz eduUserBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private INjmuEduStudentCourseBiz eduStudentCourseBiz;
	@Autowired
	private INjmuEduCourseScheduleBiz courseScheduleBiz;
	@Autowired
	private INjmuEduStudyHistoryBiz eduStudyHistoryBiz;
	@Autowired
	private IEduCourseChapterBiz chapterBiz;
	
	/**
	 * 挑转到发现课程页面
	 * @param eduStudentCourse
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findCourseList")
	public String findCourse(EduCourse eduCourse,String sort,Model model){
      
		return "njmuedu/course/findCourse";
	}
	
	/**
	 * 查看所有课程
	 * @param eduStudentCourse
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showCourse")
	public String showCourse(EduCourse eduCourse,String sort,Model model){
        if(StringUtil.isBlank(sort)){
        	sort="create_time";
        }
		List<EduCourse> stuCourseList=eduCourseBiz.searchAllCourseList(eduCourse,sort);
		model.addAttribute("stuCourseList", stuCourseList);
		//存放每门课的章的数量
		Map<String,Integer> noParentMap=new HashMap<String, Integer>();
		//存放每门课节的数量
		Map<String,Integer> parentMap=new HashMap<String, Integer>();
		//存放选修每门课的人数
		Map<String,Integer> countOneCourseMap=new HashMap<String, Integer>();
		if(null!=stuCourseList && !stuCourseList.isEmpty()){
			for(EduCourse course:stuCourseList){
				int noParent=eduCourseChapterBiz.countNoParentChapterByCourseFlow(course);
				int parent=eduCourseChapterBiz.countParentChapterByCourseFlow(course);
				int countOneCourse=eduCourseBiz.countUserSelectOneCourse(course);
				noParentMap.put(course.getCourseFlow(), noParent);
				parentMap.put(course.getCourseFlow(), parent);
				countOneCourseMap.put(course.getCourseFlow(), countOneCourse);
			}
		}
		model.addAttribute("noParentMap", noParentMap);
		model.addAttribute("parentMap", parentMap);
		model.addAttribute("countOneCourseMap", countOneCourseMap);
		model.addAttribute("sort", sort);
		return "njmuedu/course/showCourse";
	}
	
	/**
	 * 查询某一老师选择的课程下所有章节以及学习信息
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/courseDetail/{courseFlow}")
	public String tchCourseDetail(@PathVariable String courseFlow,Integer currentPage,String condition,Integer flag, Model model){
		if(flag==null){
			flag = 1;//默认学习进度
		}
		EduCourseExt courseExt = this.eduCourseBiz.searchOneWithChapters(courseFlow);
		model.addAttribute("courseExt", courseExt);
		EduCourse eduCourse=eduCourseBiz.readCourse(courseFlow);
		//查询正在学习这一门课的学生信息
		if(null!=eduCourse){
			Map<String,Object> eduUserMap=new HashMap<String, Object>();
			Map<String,Object> sysUserMap=new HashMap<String, Object>();
			List<SysUser> userList=this.eduCourseBiz.userSelectOneCourseList(courseFlow);
			model.addAttribute("userList", userList);
			for(SysUser user:userList){
				sysUserMap.put(user.getUserFlow(), user);
				EduUser eduUser=this.eduUserBiz.readEduUser(user.getUserFlow());
				if(eduUser!=null){
					eduUserMap.put(eduUser.getUserFlow(), eduUser);
				}
				
			}
			model.addAttribute("eduUserMap", eduUserMap);
			model.addAttribute("sysUserMap", sysUserMap);
		}
		//查询正在学习这门课的人数和已经学完这门课的人数
		Map<String,Object> countUserByStatusMap=this.eduCourseBiz.countUserByStudyStatus(courseFlow); 
		model.addAttribute("countUserByStatusMap", countUserByStatusMap);
		//查询选择了这门课的人数
		int countOneCourse=this.eduCourseBiz.countUserSelectOneCourse(eduCourse);
		model.addAttribute("countOneCourse", countOneCourse);
		//计算已学人数=正在学习人数+已经学完人数
		int countYetCourse=(Integer)countUserByStatusMap.get(NjmuEduStudyStatusEnum.Underway.getId())+(Integer)countUserByStatusMap.get(NjmuEduStudyStatusEnum.Finish.getId());
		model.addAttribute("countYetCourse", countYetCourse);
		
		//关注记录
		searchCourseCollection(courseFlow, model);
		
		return "njmuedu/user/courseDetail";
	}
	@RequestMapping(value="/loadCourseStatistics")
	public String loadCourseStatistics(String courseFlow,Integer currentPage,String condition,Integer flag, Model model){
		if(flag==1){//学习进度情况
			String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
			Map<String,Object> paramMap=new HashMap<String, Object>();
			paramMap.put("courseFlow", courseFlow);
			if(StringUtil.isNotBlank(condition)){
				paramMap.put("condition", "%"+condition+"%");
			}
			paramMap.put("roleFlow",stuRoleFlow);
	        List<EduUserExt> eduUserExtList=this.eduUserBiz.searchEduUserForCourseDetail(paramMap);
	        model.addAttribute("eduUserExtList", eduUserExtList);
	        Map<String, Map<String, Object>> studySurveyMap=this.eduCourseScheduleBiz.searchUserScheduleMap(eduUserExtList,courseFlow);
	        model.addAttribute("studySurveyMap", studySurveyMap);
	        /*报表数据*/
	        long notStartedCount = 0;
	        long underwayCount = 0;
	        long finishCount = 0;
	        Map<String,Long> countMap = new HashMap<String,Long>();
	        for (EduUserExt userExt : eduUserExtList) {
	      
	        	Integer point = (Integer) studySurveyMap.get("pointMap").get(userExt.getUserFlow()) ;
	        	if(point!=null){
	        		if(point==0){
						notStartedCount++;
					}else if(point==100){
						finishCount++;
					}else{
						underwayCount++;
					}
	        	}
			}
	        countMap.put(NjmuEduStudyStatusEnum.NotStarted.getId(), notStartedCount);
	        countMap.put(NjmuEduStudyStatusEnum.Underway.getId(), underwayCount);
	        countMap.put(NjmuEduStudyStatusEnum.Finish.getId(), finishCount);
	        PageHelper.startPage(currentPage,20);
	        List<EduUserExt> eduUserExtListTable=this.eduUserBiz.searchEduUserForCourseDetail(paramMap);
	        Map<String, Map<String, Object>> studySurveyMapTable=this.eduCourseScheduleBiz.searchUserScheduleMap(eduUserExtListTable,courseFlow);
	        model.addAttribute("eduUserExtList", eduUserExtListTable);
	        model.addAttribute("studySurveyMap", studySurveyMapTable);
	        model.addAttribute("countMap",countMap);
		}else if(flag==2){//问答情况
			Map<String,Object> paramCountQuestionMap=new HashMap<String, Object>();
			paramCountQuestionMap.put("courseFlow", courseFlow);
			Map<String,Object> paramSearchOrgMap=new HashMap<String, Object>();
			paramSearchOrgMap.put("courseFlow", courseFlow);
			if(StringUtil.isNotBlank(condition)){
			paramSearchOrgMap.put("condition", "%"+condition+"%");
			}
			List<SysOrgExt> orgList=this.questionBiz.searchOrgOfQuestion(paramSearchOrgMap);
			model.addAttribute("orgList", orgList);
			Map<String,Map<String, Map<String, Integer>>> questionCountFormMap=this.questionBiz.questionCountMap(orgList,paramCountQuestionMap);
			model.addAttribute("questionCountFormMap",questionCountFormMap);
		}else if(flag == 3){//课程评价
			SysUser currUser = GlobalContext.getCurrentUser();
			if(currUser != null){
				Map<String,Object> oparamMap = new HashMap<String, Object>();
				oparamMap.put("courseFlow",courseFlow);
				oparamMap.put("condition",condition);
				List<SysOrgExt> orgExtList = courseScheduleBiz.selectOrgOfSchedule(oparamMap);
				model.addAttribute("orgExtList", orgExtList);
				//Map<orgFlow, Map<orgFlow ,Map<String, Object>>>
				if(orgExtList != null && !orgExtList.isEmpty()){
					Map<String, Map<String, Object>> resultMap=new HashMap<String, Map<String,Object>>();
					Map<String, Object> majorMap=null;//?
					CourseInfoForm form=null;
					Map<String,Object> paramMap=new HashMap<String, Object>();
					
					if(orgExtList!=null && !orgExtList.isEmpty()){
						for(SysOrgExt soE : orgExtList){
							majorMap = new HashMap<String,Object>();
							paramMap.put("orgFlow",soE.getOrgFlow());
							List<MajorForm> majorFormList = soE.getMajorFormList();
							if(majorFormList != null && !majorFormList.isEmpty()){
								majorMap = new HashMap<String,Object>();
								for(MajorForm major: majorFormList){
									paramMap.put("majorId", major.getMajorId());
									paramMap.put("courseFlow", courseFlow);
									paramMap.put("praise","praise");
									paramMap.put("collection","collection");
									paramMap.put("leaveMessage","leaveMessage");
									form=this.courseScheduleBiz.countInfoOfTeacher(paramMap);
									majorMap.put(major.getMajorId(), form);
								}
							}
							resultMap.put(soE.getOrgFlow(), majorMap);
						}
					}
					model.addAttribute("resultMap", resultMap);
					//计算统计图需要的数据
					int praiseCount=0;
					int collectionCount=0;
					int highScoreCount=0;
					int middleScoreCount=0;
					int lowScoreCount=0;
					int leaveMessageCount=0;
					for(Entry<String, Map<String,Object>> orgMapCount:resultMap.entrySet()){
						for(Entry<String, Object> majorMapCount:orgMapCount.getValue().entrySet()){
							form=(CourseInfoForm)majorMapCount.getValue();
							praiseCount=praiseCount+Integer.parseInt(form.getPraiseCount());
							collectionCount=collectionCount+Integer.parseInt(form.getCollectionCount());
							highScoreCount=highScoreCount+Integer.parseInt(form.getHighScoreCount());
							middleScoreCount=middleScoreCount+Integer.parseInt(form.getMiddleScoreCount());
							lowScoreCount=lowScoreCount+Integer.parseInt(form.getLowScoreCount());
							leaveMessageCount=leaveMessageCount+Integer.parseInt(form.getLeaveMessageCount());
						}
					}
					model.addAttribute("praiseCount",praiseCount );
					model.addAttribute("collectionCount",collectionCount );
					model.addAttribute("highScoreCount", highScoreCount);
					model.addAttribute("middleScoreCount", middleScoreCount);
					model.addAttribute("lowScoreCount", lowScoreCount);
					model.addAttribute("leaveMessageCount", leaveMessageCount);
					
				}
			}
			
		}else if(flag==4){
			String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
			Map<String,Object> paramMap=new HashMap<String, Object>();
			paramMap.put("courseFlow", courseFlow);
			if(StringUtil.isNotBlank(condition)){
				paramMap.put("condition", "%"+condition+"%");
			}
			paramMap.put("roleFlow",stuRoleFlow);
			List<EduUserExt> eduUserExtList=this.eduUserBiz.searchEduUserForCourseDetail(paramMap);
			model.addAttribute("eduUserExtList", eduUserExtList);
		}else if(flag==5){
			String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
			Map<String,Object> paramMap=new HashMap<String, Object>();
			paramMap.put("courseFlow", courseFlow);
			if(StringUtil.isNotBlank(condition)){
				paramMap.put("condition", "%"+condition+"%");
			}
			paramMap.put("roleFlow",stuRoleFlow);
			PageHelper.startPage(currentPage,20);
			List<EduUserExt> eduUserExtList=this.eduUserBiz.searchEduUserForCourseDetail(paramMap);
			model.addAttribute("eduUserExtList", eduUserExtList);
			if(StringUtil.isNotBlank(courseFlow)){
				Map<String,Object> userAndCourseCreditMap=this.eduStudentCourseBiz.searchCourseCreditForm(courseFlow);
				model.addAttribute("userAndCourseCreditMap", userAndCourseCreditMap);
			}
		}
		model.addAttribute("flag", flag);
		return "njmuedu/user/courseStatistics";
	}
	/**
	 * //查询课程关注记录
	 * @param resourceFlow
	 * @param model
	 * @return
	 */
	public String searchCourseCollection(String courseFlow, Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser != null){
			EduCollection collection = new EduCollection();
			collection.setCollectionTypeId(NjmuEduCollectionTypeEnum.Course.getId());
			collection.setResourceFlow(courseFlow);
			collection.setUserFlow(currUser.getUserFlow());
			collection.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<EduCollection> collectionList = collectionBiz.searchCollectionList(collection);
			model.addAttribute("collectionList", collectionList);
		}
		return null;
	}
	/**
	 * 查询某一学生选择的课程下所有章节以及学习信息
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/stuCourseDetail/{courseFlow}")
	public String stuCourseDetail(@PathVariable String courseFlow,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		EduCourseExt courseExt = this.eduCourseBiz.searchOneWithChapters(courseFlow);
		model.addAttribute("courseExt", courseExt);
		EduCourse eduCourse=eduCourseBiz.readCourse(courseFlow);
		model.addAttribute("eduCourse", eduCourse);
		//查询正在学习这一门课的学生信息
		if(null!=eduCourse){
			List<SysUser> userList=this.eduCourseBiz.userSelectOneCourseList(courseFlow);
			//int countOneCourse=eduCourseBiz.countUserSelectOneCourse(eduCourse);
			model.addAttribute("userList", userList);
			//model.addAttribute("countOneCourse", countOneCourse);
			Map<String,Object> eduUserMap=new HashMap<String, Object>();
			Map<String,Object> sysUserMap=new HashMap<String, Object>();
			for(SysUser user:userList){
				sysUserMap.put(user.getUserFlow(), user);
				EduUser eduUser=this.eduUserBiz.readEduUser(user.getUserFlow());
				if(eduUser!=null){
					eduUserMap.put(eduUser.getUserFlow(), eduUser);
				}
			}
			model.addAttribute("eduUserMap", eduUserMap);
			model.addAttribute("sysUserMap", sysUserMap);
		}
		//查询当前课程是否被该学生选择
		EduStudentCourse studentCourse=new EduStudentCourse();
		studentCourse.setUserFlow(currUser.getUserFlow());
		studentCourse.setCourseFlow(courseFlow);
		List<EduStudentCourse> studentCourseList=this.eduCourseBiz.searchStudentCourse(studentCourse); 
		model.addAttribute("studentCourseList", studentCourseList);
	
		//查询该学生该课程每一章节的学习情况
		int finishMin=0;
		int finishSec=0;
		EduCourseSchedule schedule=null;
		Map<String,EduCourseSchedule> scheduleMap=new HashMap<String, EduCourseSchedule>();
		//存放该课程中所有子章节和授课老师
		List<String> sonChapterFlowList=new ArrayList<String>();
		//存放授课老师id
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
					//统计该学生该门课程学习进度
					if(null!=eduCourseSchedule){
						if(NjmuEduStudyStatusEnum.Finish.getId().equals(eduCourseSchedule.getStudyStatusId())
						   && StringUtil.isNotBlank(chapter.getChapterTime())){
							String [] minAndSec= chapter.getChapterTime().split(":");
							finishMin=finishMin+Integer.parseInt(minAndSec[0]);
							finishSec=finishSec+Integer.parseInt(minAndSec[1]);
						}
					}
				}
			}
			int finishCarryBit=finishSec/60;
			finishSec=finishSec%60;
	        finishMin=finishMin+finishCarryBit;
			model.addAttribute("finishMin", finishMin);
			model.addAttribute("finishSec", finishSec);
		}
		if(teacherFlowList!=null && !teacherFlowList.isEmpty()){
			List<EduUserExt> teacherList=this.eduUserBiz.searchEduUserByFlows(teacherFlowList);
			model.addAttribute("teacherList", teacherList);
		}
		model.addAttribute("scheduleMap", scheduleMap);
		model.addAttribute("courseFlow", courseFlow);
		model.addAttribute("sonChapterFlowList", sonChapterFlowList);
		//关注记录
		searchCourseCollection(courseFlow, model);
		return "njmuedu/user/student/courseDetail";
	}
	@RequestMapping(value="/nextChapters")
	@ResponseBody
	public String nextChapters(String chapterFlow,String courseFlow){
		String chapters= eduCourseScheduleBiz.nextChapter(chapterFlow,courseFlow);
		return chapters;
	}
	/**
	 * 查看课程
	 * @param chapterFlow
	 * @param model
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/chapter/{chapterFlow}",method=RequestMethod.GET)
	public String chapterDetail(@PathVariable String chapterFlow,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
			/*提问列表*/
			EduQuestion question = new EduQuestion();
			question.setChapterFlow(chapterFlow);
			List<EduQuestionExt> qList = questionBiz.searchQuestionsListWithAnswer(question);
			Map<String,EduUser> qEduUserMap = new HashMap<String,EduUser>();
			Map<String,SysUser> qSysUserMap = new HashMap<String,SysUser>();
			if(qList!=null&&!qList.isEmpty()){
				for (EduQuestionExt qExt : qList) {
					SysUser qSysUser = this.userBiz.readSysUser(qExt.getUser().getUserFlow());
					EduUser qEduUser = this.eduUserBiz.readEduUser(qExt.getUser().getUserFlow());
					qSysUserMap.put(qExt.getUser().getUserFlow(), qSysUser);
					qEduUserMap.put(qExt.getUser().getUserFlow(), qEduUser);
					for (EduAnswerExt answer : qExt.getAnswerList()) {
						EduUser aEduUser = this.eduUserBiz.readEduUser(answer.getUser().getUserFlow());
						qEduUserMap.put(answer.getUser().getUserFlow(), aEduUser);
					}
				}
			}
			model.addAttribute("qEduUserMap", qEduUserMap);
			model.addAttribute("qSysUserMap", qSysUserMap);
			//查询该章节所有评价
			EduCourseSchedule eduCourseSchedule=new EduCourseSchedule();
			eduCourseSchedule.setChapterFlow(chapterFlow);
			List<EduCourseSchedule> scheduleList=this.eduCourseScheduleBiz.searchEvaluateList(eduCourseSchedule);
			model.addAttribute("scheduleList", scheduleList);
			EduCourseChapterExt chapterExt = this.eduCourseChapterBiz.seachOneWithExt(chapterFlow);
			if(chapterExt!=null){
				//查询所有学习该章节的用户信息
			   Map<String,Object> sysUserMap=new HashMap<String, Object>();
			   Map<String,Object> eduUserMap=new HashMap<String, Object>();
			   if(scheduleList!=null && !scheduleList.isEmpty()){
				   for(EduCourseSchedule schedule:scheduleList){
					   EduUser eduUser=this.eduUserBiz.readEduUser(schedule.getUserFlow());
					   if(eduUser!=null){
						   eduUserMap.put(eduUser.getUserFlow(), eduUser);
					   }			   
					   SysUser sysUser=this.userBiz.readSysUser(schedule.getUserFlow());
					   if(sysUser!=null){
						   sysUserMap.put(sysUser.getUserFlow(), sysUser);
					   }
					   
				   }
			   }
			   model.addAttribute("sysUserMap", sysUserMap);
			   model.addAttribute("eduUserMap", eduUserMap);
				
			}
			//获取当前登录者权限列表
			List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
			//获取学生角色流水号
			String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
			//获取教师角色流水号
			//String teaRoleFlow=InitConfig.getSysCfg("njmuedu_teacher_role_flow");
			if(currRoleList!=null && !currRoleList.isEmpty()){
				if(currRoleList.contains(stuRoleFlow)){//学生
					if(chapterExt!=null){
						if(StringUtil.isNotBlank(chapterExt.getCourseFlow())){
							if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("njmuedu_force_order_play"))){
								//校验该章节是否可以观看，获取可以观看的流水号
								if (checkChapter(chapterFlow,chapterExt.getCourseFlow())==GlobalConstant.COURSE_LIST_NO_CONTAINS 
										|| checkChapter(chapterFlow,chapterExt.getCourseFlow())==GlobalConstant.SOME_CHAPTER_NO_FINISH) {
									return "njmuedu/user/student/chapterNotFound";
								}
							}
						}
						/*课程学习进度*/
						EduCourseSchedule sch = new EduCourseSchedule();
						sch.setChapterFlow(chapterFlow);
						sch.setUserFlow(currUser.getUserFlow());
						EduCourseSchedule findSch = this.eduCourseScheduleBiz.searchOne(sch);
						if(findSch==null){
							sch.setCourseFlow(chapterExt.getCourseFlow());
							sch.setStudyStatusId(NjmuEduStudyStatusEnum.Underway.getId());
							sch.setStudyStatusName(NjmuEduStudyStatusEnum.Underway.getName());
							sch.setPraiseStatus(GlobalConstant.FLAG_N);
							int result = this.eduCourseScheduleBiz.edit(sch);
							if(result ==GlobalConstant.ONE_LINE){
								findSch = sch;
							}
						}
						model.addAttribute("sch", findSch);
						
					}
				}else{//其他角色
					if(chapterExt!=null){
						/*课程进度*/
						EduCourseSchedule sch = new EduCourseSchedule();
						sch.setChapterFlow(chapterFlow);
						sch.setUserFlow(currUser.getUserFlow());
						EduCourseSchedule findSch = this.eduCourseScheduleBiz.searchOne(sch);
						if(findSch==null){
							sch.setCourseFlow(chapterExt.getCourseFlow());
							sch.setPraiseStatus(GlobalConstant.FLAG_N);
							int result = this.eduCourseScheduleBiz.edit(sch);
							if(result ==GlobalConstant.ONE_LINE){
								findSch = sch;
							}
						}
						model.addAttribute("sch", findSch);
					}
				}
			}
			model.addAttribute("chapterExt", chapterExt);
			model.addAttribute("qList", qList);
			//查询收藏记录
			EduCollection collection = new EduCollection();
			collection.setCollectionTypeId(NjmuEduCollectionTypeEnum.Chapter.getId());
			collection.setResourceFlow(chapterFlow);
			collection.setUserFlow(currUser.getUserFlow());
			collection.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<EduCollection> collectionList = collectionBiz.searchCollectionList(collection);
			model.addAttribute("collectionList", collectionList);
			//收藏统计
			//int collectionCount = collectionBiz.searchCollectionCount(njmueduCollectionTypeEnum.Chapter.getId(), chapterFlow);
			//model.addAttribute("collectionCount", collectionCount);
		
		return "njmuedu/course/chapterDetail";
	}
	
	/**
	 * 提交一个问题
	 * @param question
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/submitQuestion")
	@ResponseBody
	public EduQuestion submitQuestion(EduQuestion question){
		SysUser currUser=GlobalContext.getCurrentUser();
		question.setUserFlow(currUser.getUserFlow());
		question.setQuestionStatusId(NjmuEduQuestionStatusEnum.Unanswered.getId());
		question.setQuestionStatusName(NjmuEduQuestionStatusEnum.Unanswered.getName());
		question.setQuestionTime(DateUtil.getCurrDateTime());
		if(StringUtil.isBlank(question.getSubmitTeacher())){
			question.setSubmitTeacher(GlobalConstant.FLAG_N);
		}
		int result = questionBiz.saveQuestion(question);
		/*插入学习记录*/
		if(result==GlobalConstant.ONE_LINE){
			//获取当前登录者权限列表
			List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
			//获取学生角色流水号
			String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
			if(currRoleList.contains(stuRoleFlow)){
				this.eduStudyHistoryBiz.save(NjmuEduStudyHistoryTypeEnum.Question.getId(), question.getQuestionFlow());
			}
		}
		return question;
	}
	
	/**
	 * 提交答案
	 * @param answer
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/submitAnswer")
	@ResponseBody
	public EduAnswer submitAnswer(EduAnswer answer){
		SysUser currUser=GlobalContext.getCurrentUser();
		answer.setAnswerUserFlow(currUser.getUserFlow());		
		answer.setAnswerTime(DateUtil.getCurrDateTime());
		int result = answerBiz.saveAnswer(answer);
		/*插入学习记录*/
		if(result==GlobalConstant.ONE_LINE){
			//获取当前登录者权限列表
			List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
			//获取学生角色流水号
			String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
			if(currRoleList.contains(stuRoleFlow)){
				this.eduStudyHistoryBiz.save(NjmuEduStudyHistoryTypeEnum.Reply.getId(), answer.getAnswerFlow());
			}
		}
		return answer;
	}

	/**
	 * 把课程加入学习列表
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping(value="/joinMyCourseList")
	@ResponseBody
	public String joinMyCourseList(String courseFlow){
		SysUser currUser=GlobalContext.getCurrentUser();
		int result=this.eduCourseBiz.chooseCourse(currUser.getUserFlow(), courseFlow);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 保存点赞
	 * @param schedule
	 * @return
	 */
	@RequestMapping(value="/savePraise")
	@ResponseBody
	public String savePraise(String recordFlow){
		EduCourseSchedule schedule = this.eduCourseScheduleBiz.seachOne(recordFlow);
		String praiseStatus = null;
		if(schedule!=null){
			praiseStatus = schedule.getPraiseStatus();
		}
		this.eduCourseScheduleBiz.savePraise(schedule);
		return praiseStatus;
	}
	/**
	 * 播放文件数据Json
	 * @param chapterFlow
	 * @return
	 */
	@RequestMapping(value="/chapterData")
	@ResponseBody
	public Map<String, Object> chapterDataJson(String chapterFlow,String level){
		String second="";
		String point="";
		Map<String,Object> map=new HashMap<String, Object>();
		 
		if (StringUtil.isNotBlank(chapterFlow)) {
			SysUser curruser=GlobalContext.getCurrentUser();
			EduCourseSchedule eduCourseSchedule =new EduCourseSchedule();
			eduCourseSchedule.setUserFlow(curruser.getUserFlow());
			eduCourseSchedule.setChapterFlow(chapterFlow);
			eduCourseSchedule.setCourseFlow(eduCourseSchedule.getCourseFlow());
			List<EduCourseSchedule> CurrentTimeList=eduCourseBiz.searchScheduleList(eduCourseSchedule);
			EduCourseChapter eduCourseChapter=eduCourseChapterBiz.seachOne(chapterFlow);
			String fileName=eduCourseChapter.getChapterFile().substring(0,eduCourseChapter.getChapterFile().lastIndexOf("."));
			for(NjmuEduVideoLevelEnum enu:NjmuEduVideoLevelEnum.values()){
				if(enu.getId().equals(level)){
					String suffix=InitConfig.getSysCfgDesc("njmuedu_video_level_"+level);
					if(StringUtil.isNotBlank(suffix)){
						eduCourseChapter.setChapterFile(fileName+"_"+suffix+".mp4");
					}
				}
			}
			
		if(CurrentTimeList!=null && !CurrentTimeList.isEmpty()){
			if (CurrentTimeList.get(0).getCurrentTime()!=null) {
				 BigDecimal total=new BigDecimal(CurrentTimeList.get(0).getCurrentTime());//整数时间
				 BigDecimal minute=new BigDecimal(60);//商
				 BigDecimal consult=total.divide(minute,0,RoundingMode.FLOOR);//分
				 BigDecimal surplus= total.remainder(minute);//余【秒】
				 second =consult.toString();//string类型的分
				 point=surplus.toString();//string类型的秒
				  if (second.length()==1) {
					  second="0"+second;
					}
				  if (point.length()==1) {
					  point="0"+point;
					}
			}else{
				String time=CurrentTimeList.get(0).getCurrentTime();
				second="00";
				time="00";
				point=time;
				
			}
			map.put("CurrentTimeSecond",point);
			map.put("CurrentTimeMinutes",second);
			map.put("CurrentTime",CurrentTimeList.get(0).getCurrentTime());
			}
			map.put("eduCourseChapter",eduCourseChapter);
		}
		
		return map;
		
	}
	
	@RequestMapping(value="/loadChapterVideo")
	public String loadChapterVideo(String chapterFlow,String level,Model model){
		model.addAttribute("chapterFlow", chapterFlow);
		model.addAttribute("level", level);
		return "/njmuedu/course/chapterVideo";
	}
	
	@RequestMapping(value="/updateChapterFinishFlag")
	@ResponseBody
	//修改视频是否看完的状态同时将当前播放时间清空
	public String updateChapterFinishFlag(String chapterFlow,String chapterFinishFlag){
		SysUser curruser=GlobalContext.getCurrentUser();
		EduCourseSchedule eduCourseSchedule =new EduCourseSchedule();
		eduCourseSchedule.setUserFlow(curruser.getUserFlow());
		eduCourseSchedule.setChapterFlow(chapterFlow);
		EduCourseSchedule eduCourseFlow= eduCourseScheduleBiz.searchOne(eduCourseSchedule);
		eduCourseSchedule.setCourseFlow(eduCourseFlow.getCourseFlow());
		List<EduCourseSchedule> CurrentTimeList=eduCourseBiz.searchScheduleList(eduCourseSchedule);
		if (StringUtil.isNotBlank(chapterFinishFlag)) {
			if (CurrentTimeList!=null && !CurrentTimeList.isEmpty()) {
				EduCourseSchedule courseSchedule=CurrentTimeList.get(0);
				courseSchedule.setCurrentTime("");
				courseSchedule.setChapterFinishFlag(chapterFinishFlag);
				courseSchedule.setStudyStatusId(NjmuEduStudyStatusEnum.Finish.getId());
				courseSchedule.setStudyStatusName(NjmuEduStudyStatusEnum.getNameById(courseSchedule.getStudyStatusId()));
				eduCourseScheduleBiz.nextChapterEdit(courseSchedule);
			}
		}else{
			EduCourseSchedule courseSchedule=CurrentTimeList.get(0);
			courseSchedule.setCurrentTime("");
			eduCourseScheduleBiz.edit(courseSchedule);
		}
		
		return GlobalConstant.SAVE_SUCCESSED;
		
	}
	@RequestMapping(value="/zongTime")
	@ResponseBody
	public void zongTime(String chapterFlow,String time){
		
		/* time=time.substring(0, 2);
		 int chapterTime=Integer.parseInt(time)+1;*/
		 //获得余
		 BigDecimal total=new BigDecimal(time).setScale(0, RoundingMode.UP);//整数时间
		 BigDecimal minute=new BigDecimal(60);//商
		 BigDecimal consult=total.divide(minute,0,RoundingMode.FLOOR);//分
		 BigDecimal surplus= total.remainder(minute);//余【秒】
		 time=surplus.toString();
		 String timeMinutes=consult.toString();
		 if (time.length()==1) {
			 time="0"+time;
		 }if (timeMinutes.length()==1) {
			timeMinutes="0"+timeMinutes;
		 }
		 String zongTime=timeMinutes+":"+time;
		 EduCourseChapter courseChapter=new EduCourseChapter();
		 courseChapter=eduCourseChapterBiz.seachOne(chapterFlow);
		 EduCourseChapter Chapter=courseChapter;
		 Chapter.setChapterTime(zongTime);
		 eduCourseChapterBiz.saveChapter(Chapter);
		
	}
	
	@RequestMapping(value="/updateTime")
	@ResponseBody
	//修改当前播放时间
	public  String updateTime(String chapterFlow,String nowSecond,String nowMinutes){
		String TimeSums="";
			if (!nowMinutes.equals("00")) {
				    BigDecimal timeNowMinutes = new BigDecimal(nowMinutes); //分
					BigDecimal minute=new BigDecimal(60);	//成数
					BigDecimal timeNowSecond = new BigDecimal(nowSecond);  //秒
					BigDecimal timeMinute=timeNowMinutes.multiply(minute);//分转秒
					BigDecimal TimeSum=timeNowSecond.add(timeMinute); //总秒数
					TimeSums=TimeSum.toString();//string类型的秒
			}else{
				 BigDecimal timeNowSecond = new BigDecimal(nowSecond);  //秒
				 TimeSums=timeNowSecond.toString();
			}
		SysUser currUser=GlobalContext.getCurrentUser();
		EduCourseSchedule eduCourseSchedule =new EduCourseSchedule();
		eduCourseSchedule.setUserFlow(currUser.getUserFlow());
		eduCourseSchedule.setChapterFlow(chapterFlow);
		eduCourseSchedule.setCourseFlow(eduCourseSchedule.getCourseFlow());
		List<EduCourseSchedule> CurrentTimeList=eduCourseBiz.searchScheduleList(eduCourseSchedule);
		if (CurrentTimeList!=null && !CurrentTimeList.isEmpty()) {
			EduCourseSchedule courseSchedule=CurrentTimeList.get(0);
			courseSchedule.setCurrentTime(TimeSums);
			eduCourseScheduleBiz.edit(courseSchedule);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	/**
	 * 校验视频播放时的随机验证码
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
	
	/**
	 * 继续学习
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping(value="/continueStudy")
	public String continueStudy(String courseFlow){
			SysUser currUser = GlobalContext.getCurrentUser();
			EduCourseExt courseExt = this.eduCourseBiz.searchOneWithChapters(courseFlow);
			List<EduCourseChapter> chapterList=courseExt.getChapterList();
			List<String> playChapterFlowList=new ArrayList<String>();
			List<String> sonChapterList=new ArrayList<String>();
			if(courseExt!=null){
				if(chapterList!=null && !chapterList.isEmpty()){
						for (EduCourseChapter chapter : chapterList) {
							if(StringUtil.isNotBlank(chapter.getChapterFile())){
							sonChapterList.add(chapter.getChapterFlow());
						}
						for (String sonChapter : sonChapterList) {
						EduCourseSchedule eduCourseSchedule=new EduCourseSchedule();
						eduCourseSchedule.setChapterFlow(sonChapter);
						eduCourseSchedule.setUserFlow(currUser.getUserFlow());
						EduCourseSchedule courseScheduleRecord=eduCourseScheduleBiz.searchOne(eduCourseSchedule);
						if (courseScheduleRecord!=null) {
							if (NjmuEduStudyStatusEnum.Underway.getId().equals(courseScheduleRecord.getStudyStatusId())) {
									playChapterFlowList.add(sonChapter);
								}
							}
						}
						
						
					}
				}
			}
		
		return "redirect:/njmuedu/course/chapter/"+ playChapterFlowList.get(0);
	}
	
	/**
	 * 关注课程、收藏章节
	 * @param collection
	 * @return
	 */
	@RequestMapping(value="/collection")
	@ResponseBody
	public String collection(EduCollection collection){
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser != null){
			String resourceFlow = collection.getResourceFlow();
			String collectionTypeId = collection.getCollectionTypeId();
			//查询收藏、关注记录
			collection.setUserFlow(currUser.getUserFlow());
			collection.setResourceFlow(resourceFlow);
			collection.setCollectionTypeId(collectionTypeId);
			List<EduCollection> collectionList = collectionBiz.searchCollectionList(collection);
			//收藏章节
			if(NjmuEduCollectionTypeEnum.Chapter.getId().equals(collectionTypeId)){
				EduCourseChapter chapter = eduCourseChapterBiz.seachOne(resourceFlow);
				Long collectionCount = chapter.getCollectionCount();
				if(collectionCount == null){
					collectionCount = Long.valueOf(0);
				}
				if(collectionList !=null && !collectionList.isEmpty()){//修改收藏记录
					collection = collectionList.get(0);
					if(GlobalConstant.RECORD_STATUS_Y.equals(collection.getRecordStatus())){//取消收藏
						if(collectionCount != 0){
							collectionCount--;
							chapter.setCollectionCount(collectionCount);
						}
						collection.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						int result = collectionBiz.updateChapterCollection(chapter, collection);
						if(result != GlobalConstant.ZERO_LINE){
							return GlobalConstant.FLAG_N;
						}
					}else{//重新添加收藏
						collectionCount++;
						chapter.setCollectionCount(collectionCount);
						collection.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						int result = collectionBiz.updateChapterCollection(chapter, collection);
						if(result != GlobalConstant.ZERO_LINE){
							return GlobalConstant.FLAG_Y;
						}
					}
				}else{//新增收藏记录
					collectionCount++;
					chapter.setCollectionCount(collectionCount);
					collection.setCollectionTypeName(NjmuEduCollectionTypeEnum.getNameById(collection.getCollectionTypeId()));
					int result = collectionBiz.updateChapterCollection(chapter, collection);
					if(result != GlobalConstant.ZERO_LINE){
						return GlobalConstant.FLAG_Y;
					}
				}
			}
			
			//关注课程
			if(NjmuEduCollectionTypeEnum.Course.getId().equals(collectionTypeId)){
				if(collectionList !=null && !collectionList.isEmpty()){
					collection = collectionList.get(0);
					if(GlobalConstant.RECORD_STATUS_Y.equals(collection.getRecordStatus())){//取消关注
						collection.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						int result = collectionBiz.saveCollection(collection);
						if(result != GlobalConstant.ZERO_LINE){
							return GlobalConstant.FLAG_N;
						}
					}else{//重新关注
						collection.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						int result = collectionBiz.saveCollection(collection);
						if(result != GlobalConstant.ZERO_LINE){
							return GlobalConstant.FLAG_Y;
						}
					}
				}else{
					collection.setCollectionTypeName(NjmuEduCollectionTypeEnum.getNameById(collection.getCollectionTypeId()));
					int result = collectionBiz.saveCollection(collection);
					if(result != GlobalConstant.ZERO_LINE){
						return GlobalConstant.FLAG_Y;
					}
				}
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	/**
	 * 删除收藏
	 * @param col
	 * @return
	 */
	@RequestMapping(value="/delCollection",method=RequestMethod.POST)
	@ResponseBody
	public String delCollection(EduCollection col){
		col.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		List<EduCollection> colList = this.collectionBiz.searchCollectionList(col);
		if(colList!=null&&!colList.isEmpty()){
			EduCollection findCol = colList.get(0);
			findCol.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = this.collectionBiz.saveCollection(findCol);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	
	
	@RequestMapping(value="/checkChapter")
	@ResponseBody
	public String checkChapter(String chapterFlow,String courseFlow){
		SysUser currUser=GlobalContext.getCurrentUser();
		//查询当前课程是否已经加入学习列表
		 EduStudentCourse studentCourse=new EduStudentCourse();
		 studentCourse.setUserFlow(currUser.getUserFlow());
		 studentCourse.setCourseFlow(courseFlow);
		List<EduStudentCourse> studentCourseList=this.eduCourseBiz.searchStudentCourse(studentCourse); 
		if(studentCourseList==null || studentCourseList.isEmpty()){
			return GlobalConstant.COURSE_LIST_NO_CONTAINS;
		}
		List<String> playChapterFlowList=new ArrayList<String>();
		//查询该课程的第一节和没有学习记录的章节
		EduCourseExt courseExt = this.eduCourseBiz.searchOneWithChapters(courseFlow);
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
							if (NjmuEduStudyStatusEnum.Underway.getId().equals(courseScheduleRecord.getStudyStatusId()) ||
									NjmuEduStudyStatusEnum.Finish.getId().equals(courseScheduleRecord.getStudyStatusId())) {
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
						eduCourseSchedule.setStudyStatusId(NjmuEduStudyStatusEnum.Underway.getId());
						eduCourseSchedule.setStudyStatusName(NjmuEduStudyStatusEnum.getNameById(eduCourseSchedule.getStudyStatusId()));
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

	
	@RequestMapping(value="/submitEvaluate")
	@ResponseBody
	public Map<String,Object> submitEvaluate(EduCourseSchedule schedule){
		Map<String,Object> resultMap=new HashMap<String, Object>();
		SysUser currUser = GlobalContext.getCurrentUser();
		schedule.setUserFlow(currUser.getUserFlow());
		EduCourseSchedule eduCourseSchedule=this.eduCourseScheduleBiz.searchOne(schedule);
		eduCourseSchedule.setEvaluate(schedule.getEvaluate());
		eduCourseSchedule.setEvaluateTime(DateUtil.getCurrDateTime());
		eduCourseSchedule.setScore(schedule.getScore());
		int result=this.eduCourseScheduleBiz.edit(eduCourseSchedule);
		if(GlobalConstant.ONE_LINE == result){
			int avgScore=this.eduCourseScheduleBiz.saveChapterScore(eduCourseSchedule);
			if(GlobalConstant.ONE_LINE == avgScore){
				EduCourseChapter chapter=this.eduCourseChapterBiz.seachOne(schedule.getChapterFlow());
				resultMap.put("chapter",chapter);
				resultMap.put("eduCourseSchedule", eduCourseSchedule);
			}
			return resultMap;
		}
		return null;
	}
	
	
	
	/**
	 * 课程概况-主页面
	 * @param courseFlow
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value="/survey")
	public String survey(String courseFlow,String userName,String orgName,String majorName,Model model){
		return "njmuedu/user/survey";
	}
	*//**
	 * 课程概况-学习情况
	 * @param courseFlow
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value="/studySurvey")
	public String studySurvey(Integer currentPage,String courseFlow,String condition,Model model){
		String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("courseFlow", courseFlow);
		if(StringUtil.isNotBlank(condition)){
			paramMap.put("condition", "%"+condition+"%");
		}
		paramMap.put("roleFlow",stuRoleFlow);
        List<EduUserExt> eduUserExtList=this.eduUserBiz.searchEduUserForCourseDetail(paramMap);
        //model.addAttribute("eduUserExtList", eduUserExtList);
        Map<String, Map<String, Object>> studySurveyMap=this.eduCourseScheduleBiz.searchUserScheduleMap(eduUserExtList,courseFlow);
        //model.addAttribute("studySurveyMap", studySurveyMap);
        //报表数据
        long notStartedCount = 0;
        long underwayCount = 0;
        long finishCount = 0;
        Map<String,Long> countMap = new HashMap<String,Long>();
        for (EduUserExt userExt : eduUserExtList) {
        	int point = (Integer) studySurveyMap.get("pointMap").get(userExt.getUserFlow());
			if(point==0){
				notStartedCount++;
			}else if(point==100){
				finishCount++;
			}else{
				underwayCount++;
			}
		}
        countMap.put(njmueduStudyStatusEnum.NotStarted.getId(), notStartedCount);
        countMap.put(njmueduStudyStatusEnum.Underway.getId(), underwayCount);
        countMap.put(njmueduStudyStatusEnum.Finish.getId(), finishCount);
        model.addAttribute("countMap",countMap);
        PageHelper.startPage(currentPage, 4);
        List<EduUserExt> eduUserExtListTable=this.eduUserBiz.searchEduUserForCourseDetail(paramMap);
        Map<String, Map<String, Object>> studySurveyMapTable=this.eduCourseScheduleBiz.searchUserScheduleMap(eduUserExtListTable,courseFlow);
        model.addAttribute("eduUserExtList", eduUserExtListTable);
        model.addAttribute("studySurveyMap", studySurveyMapTable);
        return "njmuedu/user/survey/studySurvey";
	}*/
/*	*//**
	 * 课程概况-问题情况
	 * @param courseFlow
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value="/questionSurvey")
	public String questionSurvey(String courseFlow,String condition,Model model){
		Map<String,Object> paramCountQuestionMap=new HashMap<String, Object>();
		paramCountQuestionMap.put("courseFlow", courseFlow);
		Map<String,Object> paramSearchOrgMap=new HashMap<String, Object>();
		paramSearchOrgMap.put("courseFlow", courseFlow);
		if(StringUtil.isNotBlank(condition)){
		paramSearchOrgMap.put("condition", "%"+condition+"%");
		}
		List<SysOrgExt> orgList=this.questionBiz.searchOrgOfQuestion(paramSearchOrgMap);
		model.addAttribute("orgList", orgList);
		Map<String,Map<String, Map<String, Integer>>> questionCountFormMap=this.questionBiz.questionCountMap(orgList,paramCountQuestionMap);
		model.addAttribute("questionCountFormMap",questionCountFormMap);
		return "njmuedu/user/survey/questionSurvey";
	}*/
	

	/**
	 * 课程概况--课程评价
	 * @param courseFlow
	 * @param condition
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value="/courseEvaluateSurvey")
	public String courseEvaluateSurvey(String courseFlow,String condition,Model model){
		return "njmuedu/user/survey/evaluateSurvey";
	}*/
	
	@RequestMapping(value="/searchCourseSchedule")
	public String searchCourseSchedule(String userFlow, String courseFlow, String orgFlow, String majorId, String condition,Model model,Integer currentPage){
		if(StringUtil.isNotBlank(userFlow)){
			Map<String,Object> paramMap=new HashMap<String, Object>();
			//paramMap.put("userFlow", userFlow);
			paramMap.put("courseFlow", courseFlow);
			paramMap.put("orgFlow", orgFlow);
			paramMap.put("majorId", majorId);
			PageHelper.startPage(currentPage,10);
			if("middleScoreCount".equals(condition)){
				paramMap.put("middleScoreCount", "middleScoreCount");
			}
			if("lowScoreCount".equals(condition)){
				paramMap.put("lowScoreCount", "lowScoreCount");
			}
			if("leaveMessageCount".equals(condition)){
				paramMap.put("leaveMessageCount", "leaveMessageCount");
			}
			List<EduCourseScheduleExt> scheduleExtList = courseScheduleBiz.searchCourseSchedule(paramMap);
			model.addAttribute("scheduleExtList", scheduleExtList);
		}
		return "njmuedu/user/survey/evaluateList";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/saveCourseHistory",method=RequestMethod.GET)
	@ResponseBody
	public String saveCourseHistory(String chapterFlow){
		//获取当前登录者权限列表
		List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
		//获取学生角色流水号
		String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
		if(currRoleList.contains(stuRoleFlow)){
			/*插入学习记录*/
			this.eduStudyHistoryBiz.save(NjmuEduStudyHistoryTypeEnum.Course.getId(), chapterFlow);
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
}
