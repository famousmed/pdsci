package com.pinde.sci.ctrl.edu;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduCourseQuestionBiz;
import com.pinde.sci.biz.edu.IEduStudyHistoryBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.form.edu.EduQuestionForm;
import com.pinde.sci.model.edu.EduAnswerExt;
import com.pinde.sci.model.edu.EduQuestionExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.EduStudyHistory;

@Controller
@RequestMapping("/edu/studyHistory")
public class EduStudyHistoryController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(EduStudyHistoryController.class);
	
	@Autowired
	private IEduCourseQuestionBiz eduCourseQuestionBiz;
	@Autowired
	private IEduCourseBiz eduCourseBiz;
	@Autowired
	private IEduStudyHistoryBiz eduStudyHistoryBiz;
	
	private static Integer DEFAULT_START_PAGE_INDEX = 1;//默认起始分页索引
	/**
	 * 学习记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showHistory",method={RequestMethod.GET,RequestMethod.POST})
	public String showHistory(String currentPage,String isLoad, Model model){
		currentPage = StringUtil.defaultIfEmpty(currentPage, String.valueOf(DEFAULT_START_PAGE_INDEX));
		int pageSize = 4;
		if(String.valueOf(DEFAULT_START_PAGE_INDEX).equals(currentPage)){
			pageSize = 8;
		}
		PageHelper.startPage(Integer.parseInt(currentPage), pageSize);
		List<EduStudyHistory> historyList = this.eduStudyHistoryBiz.searchList();
		Map<String,Object> dataMap = this.eduStudyHistoryBiz.searchExtData(historyList);
		model.addAttribute("historyList", historyList);
		model.addAttribute("dataMap", dataMap);
		if(GlobalConstant.FLAG_Y.equals(isLoad)){
			return "edu/user/student/studyHistoryLoad";
		}
		return "edu/user/student/studyHistory";
	}

	/**
	 * 我的问答
	 * @param form
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/questionList",method={RequestMethod.GET,RequestMethod.POST})
	public String questionList( EduQuestionForm form , Model model){
		EduQuestion question = new EduQuestion();
		question.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		form.setQuestion(question);
		List<EduQuestionExt> qList = this.eduCourseQuestionBiz.searchExtList(form);
		model.addAttribute("qList", qList);
		return "edu/user/student/questionList";
	}
	/**
	 * 问题的所有回复
	 * @param questionFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/answerDetail",method=RequestMethod.GET)
	public String answerDetail(String questionFlow,Model model){
		if(StringUtil.isNotBlank(questionFlow)){
			List<EduAnswerExt> answerList = this.eduCourseQuestionBiz.searchAnswers(questionFlow);
			EduQuestion question = this.eduCourseQuestionBiz.readEduQuestion(questionFlow);
			model.addAttribute("answerList", answerList);
			model.addAttribute("question", question);
		}
		return "edu/user/student/answerDetail";
	}
	/**
	 * 我的学分
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/myCredit",method=RequestMethod.GET)
	public String myCredit(Model model){
		List<EduCourse> courseList = this.eduCourseBiz.searchStudentCreditCourses(GlobalContext.getCurrentUser().getUserFlow());
		model.addAttribute("courseList", courseList);
		return "edu/user/student/myCredit";
	}
	@RequestMapping(value="/myTest",method=RequestMethod.GET)
	public String myTest(Model model){
		return "edu/user/student/myTest";
	}
}
