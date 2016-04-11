package com.pinde.sci.ctrl.exam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.exam.IQuestionManageBiz;
import com.pinde.sci.biz.exam.ISubjectManageBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.exam.SubjectTypeEnum;
import com.pinde.sci.model.exam.ExamQuestionExt;
import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamQuestionWithBLOBs;
import com.pinde.sci.model.mo.ExamSubject;

@Controller
@RequestMapping("/exam/manage/question")
public class QuestionManageController extends GeneralController{

	@Autowired
	private IQuestionManageBiz questionManageBiz;
	
	@Autowired
	private ISubjectManageBiz subjectManageBiz;

	@RequestMapping("/viewBySubjectQuestionTypeId")
	public String viewBySubjectQuestionTypeId(String subjectFlow,String questionTypeId,Model model){
//		if(StringUtil.isNotBlank(subjectFlow)&&StringUtil.isNotBlank(questionTypeId)){
//			List<ExamQuestionWithBLOBs> examQuestionList = questionManageBiz.searchExamQuestionBySubjectQuestionType(subjectFlow,questionTypeId);
//			model.addAttribute("examQuestionList", examQuestionList);
//			
//			Map<String,List<ExamBook>> examBookMap = new HashMap<String, List<ExamBook>>();
//			for(ExamQuestionWithBLOBs question : examQuestionList){
//				String questionFlow = question.getQuestionFlow();
//				List<ExamBook> examBookList = subjectManageBiz.searchBookByQuestion(questionFlow);
//				examBookMap.put(questionFlow, examBookList);
//			}
//			model.addAttribute("examBookMap", examBookMap);
//			
//			Map<String,List<ExamSubject>> examSubjectMap = new HashMap<String, List<ExamSubject>>();
//			for(ExamQuestionWithBLOBs question : examQuestionList){
//				String questionFlow = question.getQuestionFlow();
//				List<ExamSubject> examSubjectList = subjectManageBiz.searchSubjectByQuestion(questionFlow);
//				examSubjectMap.put(questionFlow, examSubjectList);
//			}
//			model.addAttribute("examSubjectMap", examSubjectMap);
//		}
		if(StringUtil.isNotBlank(subjectFlow)&&StringUtil.isNotBlank(questionTypeId)){
			
			ExamSubject subject = subjectManageBiz.read(subjectFlow);
//			if(SubjectTypeEnum.Copy.getId().equals(subject.getSubjectTypeId())){
//				subjectFlow = subject.getSourceSubjectFlow();
//			}
			
			List<ExamQuestionExt> examQuestionList = questionManageBiz.searchExamQuestionAndSubQuestionBySubjectQuestionType(subjectFlow, questionTypeId);
			model.addAttribute("examQuestionList", examQuestionList);
		}
		return "exam/manage/question/type";
	}
	
	@RequestMapping("/viewBySubjectSubject")
	public String viewBySubjectSubject(String subjectFlow,String subjectFlow2,Model model){
		if(StringUtil.isNotBlank(subjectFlow)&&StringUtil.isNotBlank(subjectFlow2)){
			List<ExamQuestionWithBLOBs> examQuestionList = questionManageBiz.searchExamQuestionBySubjectSubject(subjectFlow,subjectFlow2);
			model.addAttribute("examQuestionList", examQuestionList);
			
			Map<String,List<ExamBook>> examBookMap = new HashMap<String, List<ExamBook>>();
			for(ExamQuestionWithBLOBs question : examQuestionList){
				String questionFlow = question.getQuestionFlow();
				List<ExamBook> examBookList = subjectManageBiz.searchBookByQuestion(questionFlow);
				examBookMap.put(questionFlow, examBookList);
			}
			model.addAttribute("examBookMap", examBookMap);
			
			Map<String,List<ExamSubject>> examSubjectMap = new HashMap<String, List<ExamSubject>>();
			for(ExamQuestionWithBLOBs question : examQuestionList){
				String questionFlow = question.getQuestionFlow();
				List<ExamSubject> examSubjectList = subjectManageBiz.searchSubjectByQuestion(questionFlow);
				examSubjectMap.put(questionFlow, examSubjectList);
			}
			model.addAttribute("examSubjectMap", examSubjectMap);
		}
		return "exam/manage/question/type_bak";
	}
	
	@RequestMapping("/viewBySubjectBook")
	public String viewBySubjectBook(String subjectFlow,String bookFlow,Model model){
		if(StringUtil.isNotBlank(subjectFlow)&&StringUtil.isNotBlank(bookFlow)){
			List<ExamQuestionWithBLOBs> examQuestionList = questionManageBiz.searchExamQuestionBySubjectBook(subjectFlow,bookFlow);
			model.addAttribute("examQuestionList", examQuestionList);
			
			Map<String,List<ExamBook>> examBookMap = new HashMap<String, List<ExamBook>>();
			for(ExamQuestionWithBLOBs question : examQuestionList){
				String questionFlow = question.getQuestionFlow();
				List<ExamBook> examBookList = subjectManageBiz.searchBookByQuestion(questionFlow);
				examBookMap.put(questionFlow, examBookList);
			}
			model.addAttribute("examBookMap", examBookMap);
			
			Map<String,List<ExamSubject>> examSubjectMap = new HashMap<String, List<ExamSubject>>();
			for(ExamQuestionWithBLOBs question : examQuestionList){
				String questionFlow = question.getQuestionFlow();
				List<ExamSubject> examSubjectList = subjectManageBiz.searchSubjectByQuestion(questionFlow);
				examSubjectMap.put(questionFlow, examSubjectList);
			}
			model.addAttribute("examSubjectMap", examSubjectMap);
		}
		return "exam/manage/question/type_bak";
	}
	
	@RequestMapping("/viewByBookQuestionTypeId")
	public String viewByBookQuestionTypeId(String bookFlow,String questionTypeId,Model model){
		if(StringUtil.isNotBlank(bookFlow)&&StringUtil.isNotBlank(questionTypeId)){
			List<ExamQuestionExt> examQuestionList = questionManageBiz.searchExamQuestionAndSubQuestionByBookQuestionType(bookFlow, questionTypeId);
			model.addAttribute("examQuestionList", examQuestionList);
			
//			Map<String,List<ExamBook>> examBookMap = new HashMap<String, List<ExamBook>>();
//			for(ExamQuestionWithBLOBs question : examQuestionList){
//				String questionFlow = question.getQuestionFlow();
//				List<ExamBook> examBookList = subjectManageBiz.searchBookByQuestion(questionFlow);
//				examBookMap.put(questionFlow, examBookList);
//			}
//			model.addAttribute("examBookMap", examBookMap);
//			
//			Map<String,List<ExamSubject>> examSubjectMap = new HashMap<String, List<ExamSubject>>();
//			for(ExamQuestionWithBLOBs question : examQuestionList){
//				String questionFlow = question.getQuestionFlow();
//				List<ExamSubject> examSubjectList = subjectManageBiz.searchSubjectByQuestion(questionFlow);
//				examSubjectMap.put(questionFlow, examSubjectList);
//			}
//			model.addAttribute("examSubjectMap", examSubjectMap);
		}
		return "exam/manage/question/type";
	}
	
	@RequestMapping("/viewByBookSubject")
	public String viewByBookSubject(String bookFlow,String subjectFlow,Model model){
		if(StringUtil.isNotBlank(bookFlow)&&StringUtil.isNotBlank(subjectFlow)){
			List<ExamQuestionWithBLOBs> examQuestionList = questionManageBiz.searchExamQuestionByBookSubject(bookFlow,subjectFlow);
			model.addAttribute("examQuestionList", examQuestionList);
			
			Map<String,List<ExamBook>> examBookMap = new HashMap<String, List<ExamBook>>();
			for(ExamQuestionWithBLOBs question : examQuestionList){
				String questionFlow = question.getQuestionFlow();
				List<ExamBook> examBookList = subjectManageBiz.searchBookByQuestion(questionFlow);
				examBookMap.put(questionFlow, examBookList);
			}
			model.addAttribute("examBookMap", examBookMap);
			
			Map<String,List<ExamSubject>> examSubjectMap = new HashMap<String, List<ExamSubject>>();
			for(ExamQuestionWithBLOBs question : examQuestionList){
				String questionFlow = question.getQuestionFlow();
				List<ExamSubject> examSubjectList = subjectManageBiz.searchSubjectByQuestion(questionFlow);
				examSubjectMap.put(questionFlow, examSubjectList);
			}
			model.addAttribute("examSubjectMap", examSubjectMap);
		}
		return "exam/manage/question/type_bak";
	}
	
	@RequestMapping("/viewByBookBook")
	public String viewByBookBook(String bookFlow,String bookFlow2,Model model){
		if(StringUtil.isNotBlank(bookFlow)&&StringUtil.isNotBlank(bookFlow2)){
			List<ExamQuestionWithBLOBs> examQuestionList = questionManageBiz.searchExamQuestionByBookBook(bookFlow,bookFlow2);
			model.addAttribute("examQuestionList", examQuestionList);
			
			Map<String,List<ExamBook>> examBookMap = new HashMap<String, List<ExamBook>>();
			for(ExamQuestionWithBLOBs question : examQuestionList){
				String questionFlow = question.getQuestionFlow();
				List<ExamBook> examBookList = subjectManageBiz.searchBookByQuestion(questionFlow);
				examBookMap.put(questionFlow, examBookList);
			}
			model.addAttribute("examBookMap", examBookMap);
			
			Map<String,List<ExamSubject>> examSubjectMap = new HashMap<String, List<ExamSubject>>();
			for(ExamQuestionWithBLOBs question : examQuestionList){
				String questionFlow = question.getQuestionFlow();
				List<ExamSubject> examSubjectList = subjectManageBiz.searchSubjectByQuestion(questionFlow);
				examSubjectMap.put(questionFlow, examSubjectList);
			}
			model.addAttribute("examSubjectMap", examSubjectMap);
		}
		return "exam/manage/question/type_bak";
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public String del(String questionFlow,Model model){
		if(StringUtil.isNotBlank(questionFlow)){
			questionManageBiz.del(questionFlow);
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
}
