package com.pinde.sci.ctrl.edu;

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
import com.pinde.sci.biz.edu.IEduCollectionBiz;
import com.pinde.sci.biz.edu.IEduCourseAnswerBiz;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduCourseChapterBiz;
import com.pinde.sci.biz.edu.IEduCourseQuestionBiz;
import com.pinde.sci.biz.edu.IEduCourseScheduleBiz;
import com.pinde.sci.biz.edu.IEduStudentCourseBiz;
import com.pinde.sci.biz.edu.IEduStudyHistoryBiz;
import com.pinde.sci.biz.edu.IEduUserBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.edu.EduCollectionTypeEnum;
import com.pinde.sci.enums.edu.EduQuestionStatusEnum;
import com.pinde.sci.enums.edu.EduStudyHistoryTypeEnum;
import com.pinde.sci.enums.edu.EduStudyStatusEnum;
import com.pinde.sci.form.edu.CourseInfoForm;
import com.pinde.sci.form.edu.MajorForm;
import com.pinde.sci.form.edu.SysOrgExt;
import com.pinde.sci.model.edu.EduAnswerExt;
import com.pinde.sci.model.edu.EduCourseChapterExt;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduCourseScheduleExt;
import com.pinde.sci.model.edu.EduQuestionExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduAnswer;
import com.pinde.sci.model.mo.EduCollection;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("edu/course")
public class EduCourseController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(EduCourseController.class);
	
	@Autowired
	private IEduCourseBiz eduCourseBiz;
	@Autowired
	private IEduCourseChapterBiz eduCourseChapterBiz;
	@Autowired
	private IEduCourseQuestionBiz questionBiz;
	@Autowired
	private IEduCourseAnswerBiz answerBiz;
	@Autowired
	private IEduCourseScheduleBiz eduCourseScheduleBiz;
	@Autowired
	private IEduCollectionBiz collectionBiz;
	@Autowired
	private IEduUserBiz eduUserBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IEduStudentCourseBiz eduStudentCourseBiz;
	@Autowired
	private IEduCourseScheduleBiz courseScheduleBiz;
	@Autowired
	private IEduStudyHistoryBiz eduStudyHistoryBiz;
	
	/**
	 * 挑转到发现课程页面
	 * @param eduStudentCourse
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findCourseList")
	public String findCourse(EduCourse eduCourse,String sort,Model model){
      
		return "edu/course/findCourse";
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
		return "edu/course/showCourse";
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
			List<SysUser> userList=this.eduCourseBiz.userSelectOneCourseList(courseFlow);
			model.addAttribute("userList", userList);
			for(SysUser user:userList){
				EduUser eduUser=this.eduUserBiz.readEduUser(user.getUserFlow());
				if(eduUser!=null){
					eduUserMap.put(eduUser.getUserFlow(), eduUser);
				}
				
			}
			model.addAttribute("eduUserMap", eduUserMap);
		}
		//查询正在学习这门课的人数和已经学完这门课的人数
		Map<String,Object> countUserByStatusMap=this.eduCourseBiz.countUserByStudyStatus(courseFlow); 
		model.addAttribute("countUserByStatusMap", countUserByStatusMap);
		//查询选择了这门课的人数
		int countOneCourse=this.eduCourseBiz.countUserSelectOneCourse(eduCourse);
		model.addAttribute("countOneCourse", countOneCourse);
		//计算已学人数=正在学习人数+已经学完人数
		int countYetCourse=(Integer)countUserByStatusMap.get(EduStudyStatusEnum.Underway.getId())+(Integer)countUserByStatusMap.get(EduStudyStatusEnum.Finish.getId());
		model.addAttribute("countYetCourse", countYetCourse);
		
		//关注记录
		searchCourseCollection(courseFlow, model);
		
		return "edu/user/courseDetail";
	}
	@RequestMapping(value="/loadCourseStatistics")
	public String loadCourseStatistics(String courseFlow,Integer currentPage,String condition,Integer flag, Model model){
		if(flag==1){//学习进度情况
			String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
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
	        countMap.put(EduStudyStatusEnum.NotStarted.getId(), notStartedCount);
	        countMap.put(EduStudyStatusEnum.Underway.getId(), underwayCount);
	        countMap.put(EduStudyStatusEnum.Finish.getId(), finishCount);
	        PageHelper.startPage(currentPage, 4);
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
			String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
			Map<String,Object> paramMap=new HashMap<String, Object>();
			paramMap.put("courseFlow", courseFlow);
			if(StringUtil.isNotBlank(condition)){
				paramMap.put("condition", "%"+condition+"%");
			}
			paramMap.put("roleFlow",stuRoleFlow);
			List<EduUserExt> eduUserExtList=this.eduUserBiz.searchEduUserForCourseDetail(paramMap);
			model.addAttribute("eduUserExtList", eduUserExtList);
		}else if(flag==5){
			String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
			Map<String,Object> paramMap=new HashMap<String, Object>();
			paramMap.put("courseFlow", courseFlow);
			if(StringUtil.isNotBlank(condition)){
				paramMap.put("condition", "%"+condition+"%");
			}
			paramMap.put("roleFlow",stuRoleFlow);
			List<EduUserExt> eduUserExtList=this.eduUserBiz.searchEduUserForCourseDetail(paramMap);
			model.addAttribute("eduUserExtList", eduUserExtList);
			if(StringUtil.isNotBlank(courseFlow)){
				Map<String,Object> userAndCourseCreditMap=this.eduStudentCourseBiz.searchCourseCreditForm(courseFlow);
				model.addAttribute("userAndCourseCreditMap", userAndCourseCreditMap);
			}
		}
		model.addAttribute("flag", flag);
		return "edu/user/courseStatistics";
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
			collection.setCollectionTypeId(EduCollectionTypeEnum.Course.getId());
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
		//查询正在学习这一门课的学生信息
		if(null!=eduCourse){
			List<SysUser> userList=this.eduCourseBiz.userSelectOneCourseList(courseFlow);
			//int countOneCourse=eduCourseBiz.countUserSelectOneCourse(eduCourse);
			model.addAttribute("userList", userList);
			//model.addAttribute("countOneCourse", countOneCourse);
			Map<String,Object> eduUserMap=new HashMap<String, Object>();
			for(SysUser user:userList){
				EduUser eduUser=this.eduUserBiz.readEduUser(user.getUserFlow());
				if(eduUser!=null){
					eduUserMap.put(eduUser.getUserFlow(), eduUser);
				}
				
			}
			model.addAttribute("eduUserMap", eduUserMap);
			
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
		//存放该课程中所有子章节
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
					//统计该学生该门课程学习进度
					if(null!=eduCourseSchedule){
						if(EduStudyStatusEnum.Finish.getId().equals(eduCourseSchedule.getStudyStatusId())
						   && StringUtil.isNotBlank(chapter.getChapterTime())){
							String [] minAndSec= chapter.getChapterTime().split(":");
							finishMin=finishMin+Integer.parseInt(minAndSec[0]);
							finishSec=finishSec+Integer.parseInt(minAndSec[1]);
						}
					}
				}
			}
			String allMin="";
			String allSec="";
			if(courseExt.getCoursePeriod()!=null && StringUtil.isNotBlank(courseExt.getCoursePeriod())){
				String [] minAndSec= courseExt.getCoursePeriod().split(":");
				allMin=minAndSec[0];
				allSec=minAndSec[1];
				
			}
			int finishCarryBit=finishSec/60;
			finishSec=finishSec%60;
	        finishMin=finishMin+finishCarryBit;
			model.addAttribute("finishMin", finishMin);
			model.addAttribute("finishSec", finishSec);
			model.addAttribute("allMin", allMin);
			model.addAttribute("allSec", allSec);
		}
		model.addAttribute("scheduleMap", scheduleMap);
		model.addAttribute("courseFlow", courseFlow);
		model.addAttribute("sonChapterFlowList", sonChapterFlowList);
		//关注记录
		searchCourseCollection(courseFlow, model);
		return "edu/user/student/courseDetail";
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
			if(qList!=null&&!qList.isEmpty()){
				for (EduQuestionExt qExt : qList) {
					EduUser qEduUser = this.eduUserBiz.readEduUser(qExt.getUser().getUserFlow());
					qEduUserMap.put(qExt.getUser().getUserFlow(), qEduUser);
					for (EduAnswerExt answer : qExt.getAnswerList()) {
						EduUser aEduUser = this.eduUserBiz.readEduUser(answer.getUser().getUserFlow());
						qEduUserMap.put(answer.getUser().getUserFlow(), aEduUser);
					}
				}
			}
			model.addAttribute("qEduUserMap", qEduUserMap);
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
			String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
			//获取教师角色流水号
			//String teaRoleFlow=InitConfig.getSysCfg("teacher_role_flow");
			if(currRoleList!=null && !currRoleList.isEmpty()){
				if(currRoleList.contains(stuRoleFlow)){//学生
					if(chapterExt!=null){
						if(StringUtil.isNotBlank(chapterExt.getCourseFlow())){
							//校验该章节是否可以观看，获取可以观看的流水号
							chapterExt=this.eduCourseChapterBiz.seachOneWithExt(chapterTrue(chapterFlow,chapterExt.getCourseFlow()));
						}
						/*课程学习进度*/
						EduCourseSchedule sch = new EduCourseSchedule();
						sch.setChapterFlow(chapterFlow);
						sch.setUserFlow(currUser.getUserFlow());
						EduCourseSchedule findSch = this.eduCourseScheduleBiz.searchOne(sch);
						if(findSch==null){
							sch.setCourseFlow(chapterExt.getCourseFlow());
							sch.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
							sch.setStudyStatusName(EduStudyStatusEnum.Underway.getName());
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
			collection.setCollectionTypeId(EduCollectionTypeEnum.Chapter.getId());
			collection.setResourceFlow(chapterFlow);
			collection.setUserFlow(currUser.getUserFlow());
			collection.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<EduCollection> collectionList = collectionBiz.searchCollectionList(collection);
			model.addAttribute("collectionList", collectionList);
			//收藏统计
			//int collectionCount = collectionBiz.searchCollectionCount(EduCollectionTypeEnum.Chapter.getId(), chapterFlow);
			//model.addAttribute("collectionCount", collectionCount);
		
		return "edu/course/chapterDetail";
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
		question.setQuestionStatusId(EduQuestionStatusEnum.Unanswered.getId());
		question.setQuestionStatusName(EduQuestionStatusEnum.Unanswered.getName());
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
			String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
			if(currRoleList.contains(stuRoleFlow)){
				this.eduStudyHistoryBiz.save(EduStudyHistoryTypeEnum.Question.getId(), question.getQuestionFlow());
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
			String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
			if(currRoleList.contains(stuRoleFlow)){
				this.eduStudyHistoryBiz.save(EduStudyHistoryTypeEnum.Reply.getId(), answer.getAnswerFlow());
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
	public Map<String,Object> chapterDataJson(String chapterFlow){
		Map<String,Object> dataMap=new HashMap<String, Object>();
		EduCourseChapter chapter=this.eduCourseChapterBiz.seachOne(chapterFlow);
		dataMap.put("chapter", chapter);
		if(chapter!=null){
			EduCourse course=this.eduCourseBiz.readCourse(chapter.getCourseFlow());
			dataMap.put("course", course);
		}
		return dataMap;
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
		if(currUser != null && StringUtil.isNotBlank(courseFlow)){
			EduCourseSchedule searchSchedule = new EduCourseSchedule();
			searchSchedule.setCourseFlow(courseFlow);
			searchSchedule.setUserFlow(currUser.getUserFlow());
			searchSchedule.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
			List<EduCourseSchedule> scheduleList = eduCourseBiz.searchScheduleList(searchSchedule);
			if(scheduleList != null && !scheduleList.isEmpty()){
				EduCourseSchedule schedule = scheduleList.get(0);
				return "redirect:/edu/course/chapter/"+ schedule.getChapterFlow();
			}else{
				EduCourseExt courseExt = eduCourseBiz.searchOneWithChapters(courseFlow);
				if(courseExt != null){
					List<EduCourseChapter> courseChapterList = courseExt.getChapterList();
					if(courseChapterList != null && !courseChapterList.isEmpty()){
						EduCourseChapter chapter = courseChapterList.get(1);
						return "redirect:/edu/course/chapter/"+ chapter.getChapterFlow();
					}
				}
			}
		}
		return null;
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
			if(EduCollectionTypeEnum.Chapter.getId().equals(collectionTypeId)){
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
					collection.setCollectionTypeName(EduCollectionTypeEnum.getNameById(collection.getCollectionTypeId()));
					int result = collectionBiz.updateChapterCollection(chapter, collection);
					if(result != GlobalConstant.ZERO_LINE){
						return GlobalConstant.FLAG_Y;
					}
				}
			}
			
			//关注课程
			if(EduCollectionTypeEnum.Course.getId().equals(collectionTypeId)){
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
					collection.setCollectionTypeName(EduCollectionTypeEnum.getNameById(collection.getCollectionTypeId()));
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
	
	/**
	 * 获取当前课程可以播放的章节流水号
	 * @param nowChapterFlow
	 * @param courseFlow
	 * @return
	 */
	public String chapterTrue(String chapterFlow,String courseFlow){
		SysUser currUser=GlobalContext.getCurrentUser();
		List<String> playChapterFlowList=new ArrayList<String>();
		EduCourseSchedule schedule=new EduCourseSchedule();
		schedule.setUserFlow(currUser.getUserFlow());
		schedule.setCourseFlow(courseFlow);
		//查询当前课程学习记录
		List<EduCourseSchedule> scheduleAllList=this.eduCourseBiz.searchScheduleList(schedule);
		//查询已经学完的章节
		schedule.setStudyStatusId(EduStudyStatusEnum.Finish.getId());
		List<EduCourseSchedule> scheduleFinishList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleFinishList!=null && !scheduleFinishList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleFinishList){
				playChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}
		//查询正在学习的章节
		schedule.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
		List<EduCourseSchedule> scheduleUnderwayList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleUnderwayList!=null && !scheduleUnderwayList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleUnderwayList){
				playChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}
		
		//查询未开始学习的章节
		/*schedule.setStudyStatusId(EduStudyStatusEnum.NotStarted.getId());
		List<EduCourseSchedule> scheduleNotStartedList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleNotStartedList!=null && !scheduleNotStartedList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleNotStartedList){
				noPlayChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}*/
		//查询该课程的第一节和没有学习记录的章节
		String firstChapterFlow="";
		List<String> noStartedChapterFlowList=new ArrayList<String>();
		EduCourseExt courseExt = this.eduCourseBiz.searchOneWithChapters(courseFlow);
		if(courseExt!=null){
			List<EduCourseChapter> chapterList=courseExt.getChapterList();
			if(chapterList!=null && !chapterList.isEmpty()){
				firstChapterFlow=chapterList.get(1).getChapterFlow();
				for(EduCourseChapter chapter:chapterList){
					if(!playChapterFlowList.contains(chapter.getChapterFlow()) && StringUtil.isNotBlank(chapter.getChapterFile())){
						noStartedChapterFlowList.add(chapter.getChapterFlow());
					}
				}
			}
		}
		//如果当前这门课学习记录为空,返回该门课第一节流水号
		//否则如果当前章节流水号在可观看的列表中(已经学完的章节和正在学的章节)，则返回当前流水号
		//否则如果正在学习的章节的列表不为空,返回正在学习的章节流水号,如果正在学习的列表为空,则返回尚未开始学习的第一个章节流水号
		if(scheduleAllList==null || scheduleAllList.isEmpty()){
			return firstChapterFlow;
		}
		else if(playChapterFlowList.contains(chapterFlow)){
			return chapterFlow;
		}else{
			if(!scheduleUnderwayList.isEmpty()){
			  return scheduleUnderwayList.get(0).getChapterFlow();
			}else{
				return noStartedChapterFlowList.get(0);
			}
		}
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
		EduCourseSchedule schedule=new EduCourseSchedule();
		schedule.setUserFlow(currUser.getUserFlow());
		schedule.setCourseFlow(courseFlow);
		//查询当前课程学习记录
		List<EduCourseSchedule> scheduleAllList=this.eduCourseBiz.searchScheduleList(schedule);
		//查询已经学完的章节
		schedule.setStudyStatusId(EduStudyStatusEnum.Finish.getId());
		List<EduCourseSchedule> scheduleFinishList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleFinishList!=null && !scheduleFinishList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleFinishList){
				playChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}
		//查询正在学习的章节
		schedule.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
		List<EduCourseSchedule> scheduleUnderwayList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleUnderwayList!=null && !scheduleUnderwayList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleUnderwayList){
				playChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}
		//查询该课程的第一节和没有学习记录的章节
		String firstChapterFlow="";
		EduCourseExt courseExt = this.eduCourseBiz.searchOneWithChapters(courseFlow);
		if(courseExt!=null){
			List<EduCourseChapter> chapterList=courseExt.getChapterList();
			if(chapterList!=null && !chapterList.isEmpty()){
				firstChapterFlow=chapterList.get(1).getChapterFlow();
			}
		}
		if((scheduleAllList==null || scheduleAllList.isEmpty()) && firstChapterFlow.equals(chapterFlow)){
			return firstChapterFlow;
		}
		else if(playChapterFlowList.contains(chapterFlow)){
			return chapterFlow;
		}else{
			return GlobalConstant.SOME_CHAPTER_NO_FINISH;
		}
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
	 * 学习下一章节
	 * @param courseFlow
	 * @return
	 */
	@RequestMapping(value="/nextChapter")
	@ResponseBody
	public String nextChapter(String nowChapterFlow,String courseFlow){
		SysUser currUser = GlobalContext.getCurrentUser();
		EduCourseSchedule schedule=new EduCourseSchedule();
		schedule.setUserFlow(currUser.getUserFlow());
		schedule.setChapterFlow(nowChapterFlow);
		EduCourseSchedule nowSchedule=this.eduCourseScheduleBiz.searchOne(schedule);
		nowSchedule.setStudyStatusId(EduStudyStatusEnum.Finish.getId());
		nowSchedule.setStudyStatusName(EduStudyStatusEnum.Finish.getName());
		int result=this.eduCourseScheduleBiz.edit(nowSchedule);
		//如果修改状态成功，查询当前章节的下一节
		if(GlobalConstant.ONE_LINE == result){
			List<String> sonChapterList=new ArrayList<String>();
			EduCourseExt courseExt = this.eduCourseBiz.searchOneWithChapters(courseFlow);
			if(courseExt!=null){
				List<EduCourseChapter> chapterList=courseExt.getChapterList();
				if(chapterList!=null && !chapterList.isEmpty()){
					for(EduCourseChapter chapter:chapterList){
						if(StringUtil.isNotBlank(chapter.getChapterFile())){
							sonChapterList.add(chapter.getChapterFlow());
						}
					}
				}
				if(sonChapterList.get(sonChapterList.size()-1).equals(nowChapterFlow)){
					EduStudentCourse eduStudentCourse=new EduStudentCourse();
					eduStudentCourse.setUserFlow(currUser.getUserFlow());
					eduStudentCourse.setCourseFlow(courseFlow);
					List<EduStudentCourse> eduStudentCourseList=this.eduCourseBiz.searchStudentCourse(eduStudentCourse);
					if(eduStudentCourseList!=null && !eduStudentCourseList.isEmpty()){
						eduStudentCourse=eduStudentCourseList.get(0);
						eduStudentCourse.setStudyStatusId(EduStudyStatusEnum.Finish.getId());
						eduStudentCourse.setStudyStatusName(EduStudyStatusEnum.Finish.getName());
						int studentCourseResult=this.eduStudentCourseBiz.save(eduStudentCourse);
						if(studentCourseResult!=GlobalConstant.ONE_LINE){
							return GlobalConstant.NOT_NORMAL_FINISH_COURSE;
						}
					}
					return GlobalConstant.LAST_CHAPTER;
				}else{
					int nowIndex=sonChapterList.indexOf(nowChapterFlow);
					String nextChapterFlow=sonChapterList.get(nowIndex+1);
					return nextChapterFlow;
				}
				
			}
				
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
		return "edu/user/survey";
	}
	*//**
	 * 课程概况-学习情况
	 * @param courseFlow
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value="/studySurvey")
	public String studySurvey(Integer currentPage,String courseFlow,String condition,Model model){
		String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
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
        countMap.put(EduStudyStatusEnum.NotStarted.getId(), notStartedCount);
        countMap.put(EduStudyStatusEnum.Underway.getId(), underwayCount);
        countMap.put(EduStudyStatusEnum.Finish.getId(), finishCount);
        model.addAttribute("countMap",countMap);
        PageHelper.startPage(currentPage, 4);
        List<EduUserExt> eduUserExtListTable=this.eduUserBiz.searchEduUserForCourseDetail(paramMap);
        Map<String, Map<String, Object>> studySurveyMapTable=this.eduCourseScheduleBiz.searchUserScheduleMap(eduUserExtListTable,courseFlow);
        model.addAttribute("eduUserExtList", eduUserExtListTable);
        model.addAttribute("studySurveyMap", studySurveyMapTable);
        return "edu/user/survey/studySurvey";
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
		return "edu/user/survey/questionSurvey";
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
		return "edu/user/survey/evaluateSurvey";
	}*/
	
	@RequestMapping(value="/searchCourseSchedule")
	public String searchCourseSchedule(String userFlow, String courseFlow, String orgFlow, String majorId, String condition,Model model){
		if(StringUtil.isNotBlank(userFlow)){
			Map<String,Object> paramMap=new HashMap<String, Object>();
			//paramMap.put("userFlow", userFlow);
			paramMap.put("courseFlow", courseFlow);
			paramMap.put("orgFlow", orgFlow);
			paramMap.put("majorId", majorId);
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
		return "edu/user/survey/evaluateList";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/saveCourseHistory",method=RequestMethod.GET)
	@ResponseBody
	public String saveCourseHistory(String chapterFlow){
		//获取当前登录者权限列表
		List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
		//获取学生角色流水号
		String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
		if(currRoleList.contains(stuRoleFlow)){
			/*插入学习记录*/
			this.eduStudyHistoryBiz.save(EduStudyHistoryTypeEnum.Course.getId(), chapterFlow);
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
}
