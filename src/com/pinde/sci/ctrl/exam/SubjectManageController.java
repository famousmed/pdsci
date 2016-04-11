package com.pinde.sci.ctrl.exam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.exam.ISubjectManageBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.exam.ExamBankTypeEnum;
import com.pinde.sci.enums.exam.SubjectTypeEnum;
import com.pinde.sci.model.exam.Znode;
import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamSubject;

@Controller
@RequestMapping("/exam/manage/subject")
public class SubjectManageController extends GeneralController{

	@Autowired
	private ISubjectManageBiz subjectManageBiz;
	
	@RequestMapping({"/main/{examBankType}"})
	public String main(@PathVariable String examBankType,Model model){
		setSessionAttribute(GlobalConstant.EXAM_BANK_TYPE, examBankType);
		setSessionAttribute(GlobalConstant.EXAM_BANK_TYPE_NAME, ExamBankTypeEnum.getNameById(examBankType));
		return "exam/manage/subject/main";
	}
	
	@RequestMapping("/tree")
	@ResponseBody
	public Object tree(String id , String typeId){
		String examBankType = (String)getSessionAttribute(GlobalConstant.EXAM_BANK_TYPE);
		List<Znode> znodes = new ArrayList<Znode>();
		if(StringUtil.isBlank(id)){
			id = examBankType;
			Znode znode = new Znode();
			znode.setId(id);
			znode.setName(ExamBankTypeEnum.getNameById(examBankType));
			znode.setPid("-1");
			znodes.add(znode);
		}

		ExamSubject subjectEmp = new ExamSubject();
		subjectEmp.setRecordStatus(GlobalConstant.FLAG_Y);
		subjectEmp.setSubjectParentFlow(id);	
		subjectEmp.setBankTypeId(examBankType);
		List<ExamSubject> subjectList = this.subjectManageBiz.search(subjectEmp);
		System.err.println(subjectList.size());
		for(ExamSubject subject:subjectList){
			Znode znode = new Znode();
			znode.setId(subject.getSubjectFlow());
			int count = 0;
			String name = subject.getSubjectName();
			if(SubjectTypeEnum.Copy.getId().equals(subject.getSubjectTypeId())){
				name = "бя"+name;
//				count = subjectManageBiz.countQuestNumOfSubject(subject.getSourceSubjectFlow());
				count = subjectManageBiz.countQuestNumOfSubject(subject.getSubjectFlow());
			}else{
				count = subjectManageBiz.countQuestNumOfSubject(subject.getSubjectFlow());
			}
			znode.setName(name+"["+count+"]");
			znode.setCount(count);
			znode.setCid(subject.getSubjectTypeId());
			if(StringUtil.isNotBlank(subject.getSubjectParentFlow())){
				znode.setPid(subject.getSubjectParentFlow());	
			}else{
				znode.setPid("-1");
			}
			if(!GlobalConstant.FLAG_Y.equals(subject.getLeafFlag())){
				znode.setIsParent("true");
			}
			znodes.add(znode);
		}
	
		Object jsonObject = JSON.toJSON(znodes);
		System.out.println(jsonObject);
		return jsonObject;
	}
	
	@RequestMapping("/treeBank0")
	@ResponseBody
	public Object treeBank0(String id , String typeId){
		List<Znode> znodes = new ArrayList<Znode>();
		if(StringUtil.isBlank(id)){
			id = ExamBankTypeEnum.Bank0.getId();
			Znode znode = new Znode();
			znode.setId(id);
			znode.setName(ExamBankTypeEnum.getNameById(ExamBankTypeEnum.Bank0.getId()));
			znode.setPid("-1");
			znodes.add(znode);
		}

		ExamSubject subjectEmp = new ExamSubject();
		subjectEmp.setRecordStatus(GlobalConstant.FLAG_Y);
		subjectEmp.setSubjectParentFlow(id);	
		subjectEmp.setBankTypeId(ExamBankTypeEnum.Bank0.getId());
		List<ExamSubject> subjectList = this.subjectManageBiz.search(subjectEmp);
		System.err.println(subjectList.size());
		for(ExamSubject subject:subjectList){
			Znode znode = new Znode();
			znode.setId(subject.getSubjectFlow());
			int count = subjectManageBiz.countQuestNumOfSubject(subject.getSubjectFlow());
			znode.setName(subject.getSubjectName()+"["+count+"]");
			znode.setCount(count);
			if(StringUtil.isNotBlank(subject.getSubjectParentFlow())){
				znode.setPid(subject.getSubjectParentFlow());	
			}else{
				znode.setPid("-1");
			}
			if(!GlobalConstant.FLAG_Y.equals(subject.getLeafFlag())){
				znode.setIsParent("true");
			}
			znodes.add(znode);
		}
	
		Object jsonObject = JSON.toJSON(znodes);
		System.out.println(jsonObject);
		return jsonObject;
	}
	
	@RequestMapping("/stat")
	public String stat(String subjectFlow,Model model){

		String examBankType = (String)getSessionAttribute(GlobalConstant.EXAM_BANK_TYPE);
		if(StringUtil.isNotBlank(subjectFlow)){
			ExamSubject subject = subjectManageBiz.read(subjectFlow);
			model.addAttribute("subject", subject);
			
//			if(SubjectTypeEnum.Copy.getId().equals(subject.getSubjectTypeId())){
//				subjectFlow = subject.getSourceSubjectFlow();
//			}else{
//				
//			}
			
			if(StringUtil.isNotEquals(subjectFlow,examBankType)){
				int countForTree = subjectManageBiz.countForTree(subjectFlow);
				model.addAttribute("countForTree", countForTree);
			}
			
			List<Map<String,Integer>> questionTypeCountMapList = subjectManageBiz.countQuestNumByQuestionTypeOfSubject(subjectFlow);
			model.addAttribute("questionTypeCountMapList", questionTypeCountMapList);

			List<Map<String,Integer>> bookCountMapList = subjectManageBiz.countQuestNumByBookOfSubject(subjectFlow);
			model.addAttribute("bookCountMapList", bookCountMapList);
			System.err.print(bookCountMapList);
			
			List<ExamBook> examBookList = subjectManageBiz.searchBookBySubject(subjectFlow);
			Map<String,ExamBook> examBookMap = new HashMap<String, ExamBook>();
			for(ExamBook book : examBookList){
				examBookMap.put(book.getBookFlow(), book);
			}
			model.addAttribute("examBookMap", examBookMap);
			
//			List<Map<String,Integer>> subjectCountMapList = subjectManageBiz.countQuestNumBySubjectOfSubject(subjectFlow);
//			model.addAttribute("subjectCountMapList", subjectCountMapList);
//			System.err.print(subjectCountMapList);
//			
//			List<ExamSubject> examSubjectList = subjectManageBiz.searchSubjectBySubject(subjectFlow);
//			Map<String,ExamSubject> examSubjectMap = new HashMap<String, ExamSubject>();
//			for(ExamSubject temp : examSubjectList){
//				examSubjectMap.put(temp.getSubjectFlow(), temp);
//			}
//			model.addAttribute("examSubjectMap", examSubjectMap);
		}
		return "exam/manage/subject/stat";
	}
	
	@RequestMapping("/add")
	public String add(String subjectParentFlow,Model model){
		String examBankType = (String)getSessionAttribute(GlobalConstant.EXAM_BANK_TYPE);
		if(StringUtil.isBlank(subjectParentFlow)||examBankType.equals(subjectParentFlow)){
			subjectParentFlow = examBankType;
			ExamSubject subjectParent = new ExamSubject();
			subjectParent.setSubjectFlow(subjectParentFlow);
			subjectParent.setMemo(ExamBankTypeEnum.getNameById(examBankType));
			model.addAttribute("subjectParent", subjectParent);
		}else{
			ExamSubject subjectParent = subjectManageBiz.read(subjectParentFlow);
			model.addAttribute("subjectParent", subjectParent);
		}
		return "exam/manage/subject/edit";
	}
	
	@RequestMapping("/mod")
	public String mod(String subjectFlow,String subjectParentFlow,Model model){
		String examBankType = (String)getSessionAttribute(GlobalConstant.EXAM_BANK_TYPE);
		if(StringUtil.isBlank(subjectParentFlow)||examBankType.equals(subjectParentFlow)){
			ExamSubject subjectParent = new ExamSubject();
			subjectParent.setSubjectFlow(examBankType);
			subjectParent.setMemo(ExamBankTypeEnum.getNameById(examBankType));
			model.addAttribute("subjectParent", subjectParent);
		}else{
			ExamSubject subjectParent = subjectManageBiz.read(subjectParentFlow);
			model.addAttribute("subjectParent", subjectParent);
		}
		ExamSubject subject = subjectManageBiz.read(subjectFlow);
		model.addAttribute("subject", subject);
		return "exam/manage/subject/edit";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public String save(ExamSubject subject,Model model){
		String examBankType = (String)getSessionAttribute(GlobalConstant.EXAM_BANK_TYPE);
		ExamSubject subjectParent = new ExamSubject();
		if(StringUtil.isBlank(subject.getSubjectParentFlow())||examBankType.equals(subject.getSubjectParentFlow())){
			subjectParent.setMemo("");
			subjectParent.setDepth("0");
		}else{
			subjectParent = subjectManageBiz.read(subject.getSubjectParentFlow());
		}
		
		try{
			if(StringUtil.isBlank(subject.getSubjectFlow())){
				String depth = StringUtil.defaultIfEmpty(subjectParent.getDepth(),"0");
				int iDepth = Integer.parseInt(depth)+1;
				subject.setDepth(iDepth+"");
				subject.setLeafFlag(GlobalConstant.FLAG_Y);
				String memo = subject.getSubjectName();
				if(StringUtil.isNotBlank(subjectParent.getMemo())){
					memo = subjectParent.getMemo()+"_"+memo;
				}
				subject.setMemo(memo);
				subject.setBankTypeId(examBankType);
				subject.setBankTypeName(ExamBankTypeEnum.getNameById(examBankType));
				subject.setSubjectTypeId(SubjectTypeEnum.Create.getId());
				subject.setSubjectTypeName(SubjectTypeEnum.Create.getName());
				subjectManageBiz.add(subject,subjectParent);
			}else{
				subjectManageBiz.mod(subject);
			}
			return GlobalConstant.SAVE_SUCCESSED;
			
		}catch(RuntimeException re){
			re.printStackTrace();
			return re.getMessage();
		}
		
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public String del(String subjectFlow,String subjectParentFlow,Model model){
		subjectManageBiz.del(subjectFlow);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	@RequestMapping("/move")
	@ResponseBody
	public String move(String subjectFlow,String subjectParentFlow,Model model){
		ExamSubject subject = subjectManageBiz.read(subjectFlow);
		subject.setSubjectParentFlow(subjectParentFlow);
		subjectManageBiz.mod(subject);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping("/order")
	public String order(String subjectParentFlow ,Model model){

		String examBankType = (String)getSessionAttribute(GlobalConstant.EXAM_BANK_TYPE);
		if(StringUtil.isBlank(subjectParentFlow)){
			subjectParentFlow = examBankType;
		}
		ExamSubject subjectEmp = new ExamSubject();
		subjectEmp.setRecordStatus(GlobalConstant.FLAG_Y);
		subjectEmp.setSubjectParentFlow(subjectParentFlow);	
		List<ExamSubject> subjectList = this.subjectManageBiz.search(subjectEmp);
		model.addAttribute("subjectList", subjectList);
		return "exam/manage/subject/order";
	}
	
	@RequestMapping("/saveOrder")
	@ResponseBody
	public String saveOrder(String [] subjectFlow ,Model model){
		subjectManageBiz.saveOrder(subjectFlow);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping("/merge")
	@ResponseBody
	public String merge(String [] subjectFlow,Model model){
		subjectManageBiz.merge(subjectFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/unRel")
	@ResponseBody
	public String unRel(String subjectFlow,Model model){
		String examBankType = (String)getSessionAttribute(GlobalConstant.EXAM_BANK_TYPE);
		if(StringUtil.isBlank(subjectFlow)){
			subjectFlow = examBankType;
			return GlobalConstant.OPRE_FAIL;
		}

		subjectManageBiz.unRel(subjectFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/delQuestionSubject")
	@ResponseBody
	public String delQuestionSubject(String subjectFlow ,String questionFlow ,Model model){
		if(StringUtil.isBlank(questionFlow)){
			return GlobalConstant.OPRE_FAIL;
		}
		if(StringUtil.isBlank(subjectFlow)){
			return GlobalConstant.OPRE_FAIL;
		}
		subjectManageBiz.delQuestionSubject(subjectFlow,questionFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/copy")
	@ResponseBody
	public String copy(String targetSubjectFlow,String sourceSubjectFlow,Model model){
		String examBankType = (String)getSessionAttribute(GlobalConstant.EXAM_BANK_TYPE);
		subjectManageBiz.copy(examBankType,targetSubjectFlow,sourceSubjectFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/extract")
	@ResponseBody
	public String extract(String targetSubjectFlow,String sourceSubjectFlow,Model model){
		String examBankType = (String)getSessionAttribute(GlobalConstant.EXAM_BANK_TYPE);
		subjectManageBiz.extract(examBankType,targetSubjectFlow,sourceSubjectFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
}
