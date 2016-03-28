package com.pinde.sci.ctrl.njmuedu;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseQuestionBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduStudyHistoryBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.form.njmuedu.EduQuestionForm;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.EduStudyHistory;
import com.pinde.sci.model.njmuedu.EduAnswerExt;
import com.pinde.sci.model.njmuedu.EduQuestionExt;

@Controller
@RequestMapping("/njmuedu/studyHistory")
public class NjmuEduStudyHistoryController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(NjmuEduStudyHistoryController.class);
	
	@Autowired
	private INjmuEduCourseQuestionBiz eduCourseQuestionBiz;
	@Autowired
	private INjmuEduCourseBiz eduCourseBiz;
	@Autowired
	private INjmuEduStudyHistoryBiz eduStudyHistoryBiz;
	
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
			return "njmuedu/user/student/studyHistoryLoad";
		}
		return "njmuedu/user/student/studyHistory";
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
		return "njmuedu/user/student/questionList";
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
		return "njmuedu/user/student/answerDetail";
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
		return "njmuedu/user/student/myCredit";
	}
	@RequestMapping(value="/myTest",method=RequestMethod.GET)
	public String myTest(Model model){
		return "njmuedu/user/student/myTest";
	}
}
