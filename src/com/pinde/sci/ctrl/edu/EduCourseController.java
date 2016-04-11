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
	 * ��ת�����ֿγ�ҳ��
	 * @param eduStudentCourse
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findCourseList")
	public String findCourse(EduCourse eduCourse,String sort,Model model){
      
		return "edu/course/findCourse";
	}
	/**
	 * �鿴���пγ�
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
		//���ÿ�ſε��µ�����
		Map<String,Integer> noParentMap=new HashMap<String, Integer>();
		//���ÿ�ſνڵ�����
		Map<String,Integer> parentMap=new HashMap<String, Integer>();
		//���ѡ��ÿ�ſε�����
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
	 * ��ѯĳһ��ʦѡ��Ŀγ��������½��Լ�ѧϰ��Ϣ
	 * @param courseFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/courseDetail/{courseFlow}")
	public String tchCourseDetail(@PathVariable String courseFlow,Integer currentPage,String condition,Integer flag, Model model){
		if(flag==null){
			flag = 1;//Ĭ��ѧϰ����
		}
		EduCourseExt courseExt = this.eduCourseBiz.searchOneWithChapters(courseFlow);
		model.addAttribute("courseExt", courseExt);
		EduCourse eduCourse=eduCourseBiz.readCourse(courseFlow);
		//��ѯ����ѧϰ��һ�ſε�ѧ����Ϣ
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
		//��ѯ����ѧϰ���ſε��������Ѿ�ѧ�����ſε�����
		Map<String,Object> countUserByStatusMap=this.eduCourseBiz.countUserByStudyStatus(courseFlow); 
		model.addAttribute("countUserByStatusMap", countUserByStatusMap);
		//��ѯѡ�������ſε�����
		int countOneCourse=this.eduCourseBiz.countUserSelectOneCourse(eduCourse);
		model.addAttribute("countOneCourse", countOneCourse);
		//������ѧ����=����ѧϰ����+�Ѿ�ѧ������
		int countYetCourse=(Integer)countUserByStatusMap.get(EduStudyStatusEnum.Underway.getId())+(Integer)countUserByStatusMap.get(EduStudyStatusEnum.Finish.getId());
		model.addAttribute("countYetCourse", countYetCourse);
		
		//��ע��¼
		searchCourseCollection(courseFlow, model);
		
		return "edu/user/courseDetail";
	}
	@RequestMapping(value="/loadCourseStatistics")
	public String loadCourseStatistics(String courseFlow,Integer currentPage,String condition,Integer flag, Model model){
		if(flag==1){//ѧϰ�������
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
	        /*��������*/
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
		}else if(flag==2){//�ʴ����
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
		}else if(flag == 3){//�γ�����
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
					//����ͳ��ͼ��Ҫ������
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
	 * //��ѯ�γ̹�ע��¼
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
	 * ��ѯĳһѧ��ѡ��Ŀγ��������½��Լ�ѧϰ��Ϣ
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
		//��ѯ����ѧϰ��һ�ſε�ѧ����Ϣ
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
		//��ѯ��ǰ�γ��Ƿ񱻸�ѧ��ѡ��
		EduStudentCourse studentCourse=new EduStudentCourse();
		studentCourse.setUserFlow(currUser.getUserFlow());
		studentCourse.setCourseFlow(courseFlow);
		List<EduStudentCourse> studentCourseList=this.eduCourseBiz.searchStudentCourse(studentCourse); 
		model.addAttribute("studentCourseList", studentCourseList);
	
		//��ѯ��ѧ���ÿγ�ÿһ�½ڵ�ѧϰ���
		int finishMin=0;
		int finishSec=0;
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
					//ͳ�Ƹ�ѧ�����ſγ�ѧϰ����
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
		//��ע��¼
		searchCourseCollection(courseFlow, model);
		return "edu/user/student/courseDetail";
	}
	/**
	 * �鿴�γ�
	 * @param chapterFlow
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/chapter/{chapterFlow}",method=RequestMethod.GET)
	public String chapterDetail(@PathVariable String chapterFlow,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
			/*�����б�*/
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
			//��ѯ���½���������
			EduCourseSchedule eduCourseSchedule=new EduCourseSchedule();
			eduCourseSchedule.setChapterFlow(chapterFlow);
			List<EduCourseSchedule> scheduleList=this.eduCourseScheduleBiz.searchEvaluateList(eduCourseSchedule);
			model.addAttribute("scheduleList", scheduleList);
			EduCourseChapterExt chapterExt = this.eduCourseChapterBiz.seachOneWithExt(chapterFlow);
			if(chapterExt!=null){
				//��ѯ����ѧϰ���½ڵ��û���Ϣ
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
			//��ȡ��ǰ��¼��Ȩ���б�
			List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
			//��ȡѧ����ɫ��ˮ��
			String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
			//��ȡ��ʦ��ɫ��ˮ��
			//String teaRoleFlow=InitConfig.getSysCfg("teacher_role_flow");
			if(currRoleList!=null && !currRoleList.isEmpty()){
				if(currRoleList.contains(stuRoleFlow)){//ѧ��
					if(chapterExt!=null){
						if(StringUtil.isNotBlank(chapterExt.getCourseFlow())){
							//У����½��Ƿ���Թۿ�����ȡ���Թۿ�����ˮ��
							chapterExt=this.eduCourseChapterBiz.seachOneWithExt(chapterTrue(chapterFlow,chapterExt.getCourseFlow()));
						}
						/*�γ�ѧϰ����*/
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
				}else{//������ɫ
					if(chapterExt!=null){
						/*�γ̽���*/
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
			//��ѯ�ղؼ�¼
			EduCollection collection = new EduCollection();
			collection.setCollectionTypeId(EduCollectionTypeEnum.Chapter.getId());
			collection.setResourceFlow(chapterFlow);
			collection.setUserFlow(currUser.getUserFlow());
			collection.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<EduCollection> collectionList = collectionBiz.searchCollectionList(collection);
			model.addAttribute("collectionList", collectionList);
			//�ղ�ͳ��
			//int collectionCount = collectionBiz.searchCollectionCount(EduCollectionTypeEnum.Chapter.getId(), chapterFlow);
			//model.addAttribute("collectionCount", collectionCount);
		
		return "edu/course/chapterDetail";
	}
	
	/**
	 * �ύһ������
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
		/*����ѧϰ��¼*/
		if(result==GlobalConstant.ONE_LINE){
			//��ȡ��ǰ��¼��Ȩ���б�
			List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
			//��ȡѧ����ɫ��ˮ��
			String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
			if(currRoleList.contains(stuRoleFlow)){
				this.eduStudyHistoryBiz.save(EduStudyHistoryTypeEnum.Question.getId(), question.getQuestionFlow());
			}
		}
		return question;
	}
	
	/**
	 * �ύ��
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
		/*����ѧϰ��¼*/
		if(result==GlobalConstant.ONE_LINE){
			//��ȡ��ǰ��¼��Ȩ���б�
			List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
			//��ȡѧ����ɫ��ˮ��
			String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
			if(currRoleList.contains(stuRoleFlow)){
				this.eduStudyHistoryBiz.save(EduStudyHistoryTypeEnum.Reply.getId(), answer.getAnswerFlow());
			}
		}
		return answer;
	}

	/**
	 * �ѿγ̼���ѧϰ�б�
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
	 * �������
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
	 * �����ļ�����Json
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
	
	/**
	 * ����ѧϰ
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
	 * ��ע�γ̡��ղ��½�
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
			//��ѯ�ղء���ע��¼
			collection.setUserFlow(currUser.getUserFlow());
			collection.setResourceFlow(resourceFlow);
			collection.setCollectionTypeId(collectionTypeId);
			List<EduCollection> collectionList = collectionBiz.searchCollectionList(collection);
			//�ղ��½�
			if(EduCollectionTypeEnum.Chapter.getId().equals(collectionTypeId)){
				EduCourseChapter chapter = eduCourseChapterBiz.seachOne(resourceFlow);
				Long collectionCount = chapter.getCollectionCount();
				if(collectionCount == null){
					collectionCount = Long.valueOf(0);
				}
				if(collectionList !=null && !collectionList.isEmpty()){//�޸��ղؼ�¼
					collection = collectionList.get(0);
					if(GlobalConstant.RECORD_STATUS_Y.equals(collection.getRecordStatus())){//ȡ���ղ�
						if(collectionCount != 0){
							collectionCount--;
							chapter.setCollectionCount(collectionCount);
						}
						collection.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						int result = collectionBiz.updateChapterCollection(chapter, collection);
						if(result != GlobalConstant.ZERO_LINE){
							return GlobalConstant.FLAG_N;
						}
					}else{//��������ղ�
						collectionCount++;
						chapter.setCollectionCount(collectionCount);
						collection.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						int result = collectionBiz.updateChapterCollection(chapter, collection);
						if(result != GlobalConstant.ZERO_LINE){
							return GlobalConstant.FLAG_Y;
						}
					}
				}else{//�����ղؼ�¼
					collectionCount++;
					chapter.setCollectionCount(collectionCount);
					collection.setCollectionTypeName(EduCollectionTypeEnum.getNameById(collection.getCollectionTypeId()));
					int result = collectionBiz.updateChapterCollection(chapter, collection);
					if(result != GlobalConstant.ZERO_LINE){
						return GlobalConstant.FLAG_Y;
					}
				}
			}
			
			//��ע�γ�
			if(EduCollectionTypeEnum.Course.getId().equals(collectionTypeId)){
				if(collectionList !=null && !collectionList.isEmpty()){
					collection = collectionList.get(0);
					if(GlobalConstant.RECORD_STATUS_Y.equals(collection.getRecordStatus())){//ȡ����ע
						collection.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						int result = collectionBiz.saveCollection(collection);
						if(result != GlobalConstant.ZERO_LINE){
							return GlobalConstant.FLAG_N;
						}
					}else{//���¹�ע
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
	 * ɾ���ղ�
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
	 * ��ȡ��ǰ�γ̿��Բ��ŵ��½���ˮ��
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
		//��ѯ��ǰ�γ�ѧϰ��¼
		List<EduCourseSchedule> scheduleAllList=this.eduCourseBiz.searchScheduleList(schedule);
		//��ѯ�Ѿ�ѧ����½�
		schedule.setStudyStatusId(EduStudyStatusEnum.Finish.getId());
		List<EduCourseSchedule> scheduleFinishList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleFinishList!=null && !scheduleFinishList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleFinishList){
				playChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}
		//��ѯ����ѧϰ���½�
		schedule.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
		List<EduCourseSchedule> scheduleUnderwayList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleUnderwayList!=null && !scheduleUnderwayList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleUnderwayList){
				playChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}
		
		//��ѯδ��ʼѧϰ���½�
		/*schedule.setStudyStatusId(EduStudyStatusEnum.NotStarted.getId());
		List<EduCourseSchedule> scheduleNotStartedList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleNotStartedList!=null && !scheduleNotStartedList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleNotStartedList){
				noPlayChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}*/
		//��ѯ�ÿγ̵ĵ�һ�ں�û��ѧϰ��¼���½�
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
		//�����ǰ���ſ�ѧϰ��¼Ϊ��,���ظ��ſε�һ����ˮ��
		//���������ǰ�½���ˮ���ڿɹۿ����б���(�Ѿ�ѧ����½ں�����ѧ���½�)���򷵻ص�ǰ��ˮ��
		//�����������ѧϰ���½ڵ��б�Ϊ��,��������ѧϰ���½���ˮ��,�������ѧϰ���б�Ϊ��,�򷵻���δ��ʼѧϰ�ĵ�һ���½���ˮ��
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
		//��ѯ��ǰ�γ��Ƿ��Ѿ�����ѧϰ�б�
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
		//��ѯ��ǰ�γ�ѧϰ��¼
		List<EduCourseSchedule> scheduleAllList=this.eduCourseBiz.searchScheduleList(schedule);
		//��ѯ�Ѿ�ѧ����½�
		schedule.setStudyStatusId(EduStudyStatusEnum.Finish.getId());
		List<EduCourseSchedule> scheduleFinishList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleFinishList!=null && !scheduleFinishList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleFinishList){
				playChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}
		//��ѯ����ѧϰ���½�
		schedule.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
		List<EduCourseSchedule> scheduleUnderwayList=this.eduCourseBiz.searchScheduleList(schedule);
		if(scheduleUnderwayList!=null && !scheduleUnderwayList.isEmpty()){
			for(EduCourseSchedule eduSchedule:scheduleUnderwayList){
				playChapterFlowList.add(eduSchedule.getChapterFlow());
			}
		}
		//��ѯ�ÿγ̵ĵ�һ�ں�û��ѧϰ��¼���½�
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
	 * ѧϰ��һ�½�
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
		//����޸�״̬�ɹ�����ѯ��ǰ�½ڵ���һ��
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
	 * �γ̸ſ�-��ҳ��
	 * @param courseFlow
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value="/survey")
	public String survey(String courseFlow,String userName,String orgName,String majorName,Model model){
		return "edu/user/survey";
	}
	*//**
	 * �γ̸ſ�-ѧϰ���
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
        //��������
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
	 * �γ̸ſ�-�������
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
	 * �γ̸ſ�--�γ�����
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
		//��ȡ��ǰ��¼��Ȩ���б�
		List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
		//��ȡѧ����ɫ��ˮ��
		String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
		if(currRoleList.contains(stuRoleFlow)){
			/*����ѧϰ��¼*/
			this.eduStudyHistoryBiz.save(EduStudyHistoryTypeEnum.Course.getId(), chapterFlow);
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
}
