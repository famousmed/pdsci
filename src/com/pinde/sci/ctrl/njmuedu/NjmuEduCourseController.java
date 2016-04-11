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
	 * ��ת�����ֿγ�ҳ��
	 * @param eduStudentCourse
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/findCourseList")
	public String findCourse(EduCourse eduCourse,String sort,Model model){
      
		return "njmuedu/course/findCourse";
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
		return "njmuedu/course/showCourse";
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
		//��ѯ����ѧϰ���ſε��������Ѿ�ѧ�����ſε�����
		Map<String,Object> countUserByStatusMap=this.eduCourseBiz.countUserByStudyStatus(courseFlow); 
		model.addAttribute("countUserByStatusMap", countUserByStatusMap);
		//��ѯѡ�������ſε�����
		int countOneCourse=this.eduCourseBiz.countUserSelectOneCourse(eduCourse);
		model.addAttribute("countOneCourse", countOneCourse);
		//������ѧ����=����ѧϰ����+�Ѿ�ѧ������
		int countYetCourse=(Integer)countUserByStatusMap.get(NjmuEduStudyStatusEnum.Underway.getId())+(Integer)countUserByStatusMap.get(NjmuEduStudyStatusEnum.Finish.getId());
		model.addAttribute("countYetCourse", countYetCourse);
		
		//��ע��¼
		searchCourseCollection(courseFlow, model);
		
		return "njmuedu/user/courseDetail";
	}
	@RequestMapping(value="/loadCourseStatistics")
	public String loadCourseStatistics(String courseFlow,Integer currentPage,String condition,Integer flag, Model model){
		if(flag==1){//ѧϰ�������
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
	        countMap.put(NjmuEduStudyStatusEnum.NotStarted.getId(), notStartedCount);
	        countMap.put(NjmuEduStudyStatusEnum.Underway.getId(), underwayCount);
	        countMap.put(NjmuEduStudyStatusEnum.Finish.getId(), finishCount);
	        PageHelper.startPage(currentPage,20);
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
	 * //��ѯ�γ̹�ע��¼
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
		model.addAttribute("eduCourse", eduCourse);
		//��ѯ����ѧϰ��һ�ſε�ѧ����Ϣ
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
		//��Ÿÿγ����������½ں��ڿ���ʦ
		List<String> sonChapterFlowList=new ArrayList<String>();
		//����ڿ���ʦid
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
					//ͳ�Ƹ�ѧ�����ſγ�ѧϰ����
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
		//��ע��¼
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
			String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
			//��ȡ��ʦ��ɫ��ˮ��
			//String teaRoleFlow=InitConfig.getSysCfg("njmuedu_teacher_role_flow");
			if(currRoleList!=null && !currRoleList.isEmpty()){
				if(currRoleList.contains(stuRoleFlow)){//ѧ��
					if(chapterExt!=null){
						if(StringUtil.isNotBlank(chapterExt.getCourseFlow())){
							if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("njmuedu_force_order_play"))){
								//У����½��Ƿ���Թۿ�����ȡ���Թۿ�����ˮ��
								if (checkChapter(chapterFlow,chapterExt.getCourseFlow())==GlobalConstant.COURSE_LIST_NO_CONTAINS 
										|| checkChapter(chapterFlow,chapterExt.getCourseFlow())==GlobalConstant.SOME_CHAPTER_NO_FINISH) {
									return "njmuedu/user/student/chapterNotFound";
								}
							}
						}
						/*�γ�ѧϰ����*/
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
			collection.setCollectionTypeId(NjmuEduCollectionTypeEnum.Chapter.getId());
			collection.setResourceFlow(chapterFlow);
			collection.setUserFlow(currUser.getUserFlow());
			collection.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<EduCollection> collectionList = collectionBiz.searchCollectionList(collection);
			model.addAttribute("collectionList", collectionList);
			//�ղ�ͳ��
			//int collectionCount = collectionBiz.searchCollectionCount(njmueduCollectionTypeEnum.Chapter.getId(), chapterFlow);
			//model.addAttribute("collectionCount", collectionCount);
		
		return "njmuedu/course/chapterDetail";
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
		question.setQuestionStatusId(NjmuEduQuestionStatusEnum.Unanswered.getId());
		question.setQuestionStatusName(NjmuEduQuestionStatusEnum.Unanswered.getName());
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
			String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
			if(currRoleList.contains(stuRoleFlow)){
				this.eduStudyHistoryBiz.save(NjmuEduStudyHistoryTypeEnum.Question.getId(), question.getQuestionFlow());
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
			String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
			if(currRoleList.contains(stuRoleFlow)){
				this.eduStudyHistoryBiz.save(NjmuEduStudyHistoryTypeEnum.Reply.getId(), answer.getAnswerFlow());
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
				 BigDecimal total=new BigDecimal(CurrentTimeList.get(0).getCurrentTime());//����ʱ��
				 BigDecimal minute=new BigDecimal(60);//��
				 BigDecimal consult=total.divide(minute,0,RoundingMode.FLOOR);//��
				 BigDecimal surplus= total.remainder(minute);//�ࡾ�롿
				 second =consult.toString();//string���͵ķ�
				 point=surplus.toString();//string���͵���
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
	//�޸���Ƶ�Ƿ����״̬ͬʱ����ǰ����ʱ�����
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
		 //�����
		 BigDecimal total=new BigDecimal(time).setScale(0, RoundingMode.UP);//����ʱ��
		 BigDecimal minute=new BigDecimal(60);//��
		 BigDecimal consult=total.divide(minute,0,RoundingMode.FLOOR);//��
		 BigDecimal surplus= total.remainder(minute);//�ࡾ�롿
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
	//�޸ĵ�ǰ����ʱ��
	public  String updateTime(String chapterFlow,String nowSecond,String nowMinutes){
		String TimeSums="";
			if (!nowMinutes.equals("00")) {
				    BigDecimal timeNowMinutes = new BigDecimal(nowMinutes); //��
					BigDecimal minute=new BigDecimal(60);	//����
					BigDecimal timeNowSecond = new BigDecimal(nowSecond);  //��
					BigDecimal timeMinute=timeNowMinutes.multiply(minute);//��ת��
					BigDecimal TimeSum=timeNowSecond.add(timeMinute); //������
					TimeSums=TimeSum.toString();//string���͵���
			}else{
				 BigDecimal timeNowSecond = new BigDecimal(nowSecond);  //��
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
			if(NjmuEduCollectionTypeEnum.Chapter.getId().equals(collectionTypeId)){
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
					collection.setCollectionTypeName(NjmuEduCollectionTypeEnum.getNameById(collection.getCollectionTypeId()));
					int result = collectionBiz.updateChapterCollection(chapter, collection);
					if(result != GlobalConstant.ZERO_LINE){
						return GlobalConstant.FLAG_Y;
					}
				}
			}
			
			//��ע�γ�
			if(NjmuEduCollectionTypeEnum.Course.getId().equals(collectionTypeId)){
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
		//��ѯ�ÿγ̵ĵ�һ�ں�û��ѧϰ��¼���½�
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
	 * �γ̸ſ�-��ҳ��
	 * @param courseFlow
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value="/survey")
	public String survey(String courseFlow,String userName,String orgName,String majorName,Model model){
		return "njmuedu/user/survey";
	}
	*//**
	 * �γ̸ſ�-ѧϰ���
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
		return "njmuedu/user/survey/questionSurvey";
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
		//��ȡ��ǰ��¼��Ȩ���б�
		List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
		//��ȡѧ����ɫ��ˮ��
		String stuRoleFlow=InitConfig.getSysCfg("njmuedu_student_role_flow");
		if(currRoleList.contains(stuRoleFlow)){
			/*����ѧϰ��¼*/
			this.eduStudyHistoryBiz.save(NjmuEduStudyHistoryTypeEnum.Course.getId(), chapterFlow);
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
}
