package com.pinde.sci.ctrl.exam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.exam.IBookManageBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.model.exam.Znode;
import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamSubject;

@Controller
@RequestMapping("/exam/manage/book")
public class BookManageController extends GeneralController{

	@Autowired
	private IBookManageBiz bookManageBiz;
	
	@RequestMapping({"/","","main"})
	public String main(Model model){
		return "exam/manage/book/main";
	}
	
	@RequestMapping("/tree")
	@ResponseBody
	public Object tree(String id ,String bookNum, String typeId){
		List<Znode> znodes = new ArrayList<Znode>();
		if(StringUtil.isBlank(id)){
			id = "0";
			Znode znode = new Znode();
			znode.setId(id);
			znode.setName("总库书目列表");
			znode.setPid("-1");
			znodes.add(znode);
		}

		ExamBook bookEmp = new ExamBook();
		bookEmp.setRecordStatus(GlobalConstant.FLAG_Y);
		bookEmp.setBookParentFlow(id);	
		bookEmp.setBookNum(bookNum);
		List<ExamBook> bookList = this.bookManageBiz.search(bookEmp);
		System.err.println(bookList.size());
		for(ExamBook book:bookList){
			Znode znode = new Znode();
			znode.setId(book.getBookFlow());
			int count = bookManageBiz.countQuestNumOfBook(book.getBookFlow());
			String name = book.getBookName()+"["+count+"]";
			if("1".equals(book.getDepth())){
				name = "["+StringUtil.defaultString(book.getBookNum())+"]"+name;
			}else{
//				name = "["+StringUtil.defaultString(book.getOrdinal()+"")+"]"+name;
			}
			znode.setName(name);
			znode.setCount(count);
			if(StringUtil.isNotBlank(book.getBookParentFlow())){
				znode.setPid(book.getBookParentFlow());	
			}else{
				znode.setPid("-1");
			}
			if(!GlobalConstant.FLAG_Y.equals(book.getLeafFlag())){
				znode.setIsParent("true");
			}
			znodes.add(znode);
		}
	
		Object jsonObject = JSON.toJSON(znodes);
		System.out.println(jsonObject);
		return jsonObject;
	}
	
	@RequestMapping("/stat")
	public String stat(String bookFlow,Model model){
		if(StringUtil.isNotBlank(bookFlow)){
			ExamBook book = bookManageBiz.read(bookFlow);
			model.addAttribute("book", book);
			
			if(StringUtil.isNotEquals(bookFlow,"0")){
				int countForTree = bookManageBiz.countForTree(bookFlow);
				model.addAttribute("countForTree", countForTree);
			}
			
			List<Map<String,Integer>> questionTypeCountMapList = bookManageBiz.countQuestNumByQuestionTypeOfBook(bookFlow);
			model.addAttribute("questionTypeCountMapList", questionTypeCountMapList);
			
//			List<Map<String,Integer>> bookCountMapList = bookManageBiz.countQuestNumByBookOfBook(bookFlow);
//			model.addAttribute("bookCountMapList", bookCountMapList);
//			System.err.print(bookCountMapList);
			
//			List<ExamBook> examBookList = bookManageBiz.searchBookByBook(bookFlow);
//			Map<String,ExamBook> examBookMap = new HashMap<String, ExamBook>();
//			for(ExamBook temp : examBookList){
//				examBookMap.put(temp.getBookFlow(), temp);
//			}
//			model.addAttribute("examBookMap", examBookMap);
			
			//List<Map<String,Integer>> subjectCountMapList = bookManageBiz.countQuestNumBySubjectOfBook(bookFlow);
			//model.addAttribute("subjectCountMapList", subjectCountMapList);
			
			List<ExamSubject> examSubjectList = bookManageBiz.findSubjectByBookFlow(bookFlow);
//			Map<String,ExamSubject> examSubjectMap = new HashMap<String, ExamSubject>();
//			for(ExamSubject subject : examSubjectList){
//				examSubjectMap.put(subject.getSubjectFlow(), subject);
//			}
//			model.addAttribute("examSubjectMap", examSubjectMap);
			model.addAttribute("examSubjectList" , examSubjectList);
		}
		return "exam/manage/book/stat";
	}
	
	@RequestMapping("/add")
	public String add(String bookParentFlow,Model model){
		if(StringUtil.isBlank(bookParentFlow)||"0".equals(bookParentFlow)){
			bookParentFlow = "0";
			ExamBook bookParent = new ExamBook();
			bookParent.setBookFlow(bookParentFlow);
			bookParent.setMemo("总库书目列表");
			model.addAttribute("bookParent", bookParent);
		}else{
			
			ExamBook bookParent = bookManageBiz.read(bookParentFlow);
			model.addAttribute("bookParent", bookParent);
			if(!"0".equals(bookParent.getBookParentFlow())){
				ExamBook topBook =  this.bookManageBiz.findBookByBookFlow(bookParentFlow);
				model.addAttribute("topBook" , topBook);
			}else{
				model.addAttribute("topBook" , bookParent);
			}
			
		}
		return "exam/manage/book/add";
	}
	
	@RequestMapping("/mod")
	public String mod(String bookFlow,String bookParentFlow,Model model){
		if(StringUtil.isBlank(bookParentFlow)||"0".equals(bookParentFlow)){
			ExamBook bookParent = new ExamBook();
			bookParent.setBookFlow("0");
			bookParent.setMemo("总库科目列表");
			model.addAttribute("bookParent", bookParent);
		}else{
			ExamBook bookParent = bookManageBiz.read(bookParentFlow);
			model.addAttribute("bookParent", bookParent);
			if(!"0".equals(bookParent.getBookParentFlow())){
				ExamBook topBook =  this.bookManageBiz.findBookByBookFlow(bookParentFlow);
				model.addAttribute("topBook" , topBook);
			}else{
				model.addAttribute("topBook" , bookParent);
			}
		}
		ExamBook book = bookManageBiz.read(bookFlow);
		model.addAttribute("book", book);
		return "exam/manage/book/edit";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public String save(ExamBook book,Model model){
		ExamBook bookParent = new ExamBook();
		if(StringUtil.isBlank(book.getBookParentFlow())||"0".equals(book.getBookParentFlow())){
			bookParent.setMemo("");
			bookParent.setDepth("0");
		}else{
			bookParent = bookManageBiz.read(book.getBookParentFlow());
		}
		if(StringUtil.isBlank(book.getBookFlow())){
			String depth = StringUtil.defaultIfEmpty(bookParent.getDepth(),"0");
			int iDepth = Integer.parseInt(depth)+1;
			book.setDepth(iDepth+"");
			book.setLeafFlag(GlobalConstant.FLAG_Y);
			String memo = book.getBookName();
			if(StringUtil.isNotBlank(bookParent.getMemo())){
				memo = bookParent.getMemo()+"_"+memo;
			}
			book.setMemo(memo);
			bookManageBiz.add(book,bookParent);
		}else{
			String memo = book.getBookName();
			if(StringUtil.isNotBlank(bookParent.getMemo())){
				memo = bookParent.getMemo()+"_"+memo;
			}
			book.setMemo(memo);
			bookManageBiz.modBookAndSubBook(book);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public String del(String bookFlow,String bookParentFlow,Model model){
		bookManageBiz.del(bookFlow);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	@RequestMapping("/move")
	@ResponseBody
	public String move(String bookFlow,String bookParentFlow,Model model){
		ExamBook book = bookManageBiz.read(bookFlow);
		book.setBookParentFlow(bookParentFlow);
		bookManageBiz.mod(book);
		return GlobalConstant.SAVE_SUCCESSED;
	}

	
	@RequestMapping("/merge")
	@ResponseBody
	public String merge(String [] bookFlow,Model model){
		bookManageBiz.merge(bookFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/unRel")
	@ResponseBody
	public String unRel(String bookFlow ,ExamBook book,Model model){
		if(StringUtil.isBlank(bookFlow)){
			bookFlow = "0";
			return GlobalConstant.OPRE_FAIL;
		}

		bookManageBiz.unRel(bookFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/order")
	public String order(String bookParentFlow ,Model model){
		if(StringUtil.isBlank(bookParentFlow)){
			bookParentFlow = "0";
		}
		ExamBook bookEmp = new ExamBook();
		bookEmp.setRecordStatus(GlobalConstant.FLAG_Y);
		bookEmp.setBookParentFlow(bookParentFlow);	
		List<ExamBook> bookList = this.bookManageBiz.search(bookEmp);
		model.addAttribute("bookList", bookList);
		return "exam/manage/book/order";
	}
	
	@RequestMapping("/smartorder")
	@ResponseBody
	public String smartOrder(String bookParentFlow){
		this.bookManageBiz.smartOrder(bookParentFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/saveOrder")
	@ResponseBody
	public String saveOrder(String [] bookFlow ,Model model){
		bookManageBiz.saveOrder(bookFlow);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 删除书目和科目的关联 ， 同时删除该书目在这个科目的题目
	 * @param bookFlow
	 * @param subjectFlow
	 * @return
	 */
	@RequestMapping("/delBookAndSubjectRelation")
	@ResponseBody
	public String delBookAndSubjectRelation(String bookFlow , String subjectFlow){
		this.bookManageBiz.delBookAndSubjectRelation(bookFlow, subjectFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/rebindsubject")
	public String rebindSubject(String bookFlow , String subjectFlow , Model model){
		ExamBook book = this.bookManageBiz.read(bookFlow);
		model.addAttribute("book" , book);
		if("0".equals(book.getBookParentFlow())){
			model.addAttribute("topBook" , book);
		}else{
			ExamBook topBook = this.bookManageBiz.findBookByBookFlow(bookFlow);
			model.addAttribute("topBook" , topBook);
		}
		return "exam/manage/book/rebindsubject";
	}
	
	@RequestMapping("/bindsubject")
	@ResponseBody
	public String bindsubject(String bookFlow , String subjectFlow , String oldSubjectFlow){
		if(StringUtil.isNotBlank(oldSubjectFlow)){
			this.bookManageBiz.rebindSubject(bookFlow, subjectFlow, oldSubjectFlow);

		}else{
			this.bookManageBiz.addBindSubject(bookFlow, subjectFlow);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	
}
