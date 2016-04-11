package com.pinde.sci.ctrl.exam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.exam.IBookImpBiz;
import com.pinde.sci.biz.exam.IBookManageBiz;
import com.pinde.sci.biz.exam.ISubjectManageBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.exam.BookImpStatusEnum;
import com.pinde.sci.enums.exam.BookRegistStatusEnum;
import com.pinde.sci.enums.exam.ExamBankTypeEnum;
import com.pinde.sci.enums.exam.QuestionTypeEnum;
import com.pinde.sci.enums.exam.SubjectTypeEnum;
import com.pinde.sci.model.exam.ExamBookImpExt;
import com.pinde.sci.model.exam.ExamBookRegistInfo;
import com.pinde.sci.model.exam.ExamQuestionExt;
import com.pinde.sci.model.exam.QuestionFileVerifyInfo;
import com.pinde.sci.model.exam.Znode;
import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamBookComposInfo;
import com.pinde.sci.model.mo.ExamBookImp;
import com.pinde.sci.model.mo.ExamBookImpDetail;
import com.pinde.sci.model.mo.ExamBookRecognizeInfo;
import com.pinde.sci.model.mo.ExamBookReloadRec;
import com.pinde.sci.model.mo.ExamBookScanInfo;
import com.pinde.sci.model.mo.ExamSubject;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/exam/manage/imp")
public class BookImpController extends GeneralController{

	@Autowired
	private IBookImpBiz bookImpBiz;
	@Autowired
	private IBookManageBiz bookManageBiz;
	@Autowired
	private ISubjectManageBiz subjectManageBiz;
	@Autowired
	private IUserBiz userBiz;
	
	@RequestMapping("/list")
	public String list(ExamBookImpExt bookImpExt , Integer currentPage ,HttpServletRequest request, Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<ExamBookImpExt> examImpList = bookImpBiz.search(bookImpExt);
		//获取顶层书号
//		for(ExamBookImpExt ebie:examImpList){
//			ExamBook topBook = this.bookManageBiz.findBookByBookFlow(ebie.getBookFlow());
//			ebie.getExamBook().setBookNum(topBook.getBookNum());
//		}
		model.addAttribute("examImpList", examImpList);
		model.addAttribute("bookImpExt", bookImpExt);
		return "exam/manage/imp/list";
	}
	
	@RequestMapping("/imp")
	public String imp(String bookFlow,Model model){
		if(StringUtil.isBlank(bookFlow)){
			bookFlow = "0";
		}
		return "exam/manage/imp/imp";
	}
	
	@RequestMapping("/tree")
	@ResponseBody
	public Object tree(String id , String bookNum){
		List<Znode> znodes = new ArrayList<Znode>();
		if(StringUtil.isBlank(id)){
			id = "0";
			Znode znode = new Znode();
			znode.setId(id);
			znode.setName("总库书目列表");
			znode.setPid("-1");
//			znodes.add(znode);
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
	
	@RequestMapping("/subTree/{bankTypeId}")
	@ResponseBody
	public Object subTree(String id , @PathVariable String bankTypeId){
		List<Znode> znodes = new ArrayList<Znode>();
		if(StringUtil.isBlank(id)){
			id = bankTypeId;
			Znode znode = new Znode();
			znode.setId(id);
			znode.setName(ExamBankTypeEnum.getNameById(bankTypeId));
			znode.setPid("-1");
			znodes.add(znode);
		}

		ExamSubject subjectEmp = new ExamSubject();
		subjectEmp.setRecordStatus(GlobalConstant.FLAG_Y);
		subjectEmp.setSubjectParentFlow(id);	
		subjectEmp.setBankTypeId(bankTypeId);
		List<ExamSubject> subjectList = this.subjectManageBiz.search(subjectEmp);
		System.err.println(subjectList.size());
		for(ExamSubject subject:subjectList){
			Znode znode = new Znode();
			znode.setId(subject.getSubjectFlow());
			int count = 0;
			String name = subject.getSubjectName();
			if(SubjectTypeEnum.Copy.getId().equals(subject.getSubjectTypeId())){
				name = "★"+name;
				count = subjectManageBiz.countQuestNumOfSubject(subject.getSourceSubjectFlow());
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

	@RequestMapping("/upload")
	public String upload2(String bookFlow , String subjectFlow ,@RequestParam(value="questionType") MultipartFile[] questionType , Model model , HttpServletRequest request){
		//登记校验
		ExamBook registBook = this.bookManageBiz.findBookByBookFlow(bookFlow);
		if(!BookRegistStatusEnum.Compos.getId().equals(registBook.getRegistStatusId())){
			model.addAttribute("action" , "imp");
			model.addAttribute("registInfo" , "该书目没有完成登记信息，请先填写完登记信息！");
			return "exam/manage/imp/upload";
		}
		//文件校验
		int questionFilesCount = 0;
		for(int i=0;i<questionType.length;i++){
			if(questionType[i].isEmpty()==false){
				questionFilesCount ++;
				String typeId = request.getParameter(String.valueOf(i));
				
				//该书目的该题型是上传过文件
				ExamBookImpDetail bookImpDetail = new ExamBookImpDetail();
				bookImpDetail.setQuestionTypeId(typeId);
				bookImpDetail.setBookFlow(bookFlow);
				bookImpDetail.setRecordStatus(GlobalConstant.FLAG_Y);
				List<ExamBookImpDetail> impDetails = this.bookImpBiz.searchDetail(bookImpDetail);
				if(!impDetails.isEmpty()){
					model.addAttribute("action" , "imp");
					model.addAttribute("registInfo" , "该书目下的该题型已上传过,不可再次上传");
					return "exam/manage/imp/upload";
				}
				
				QuestionFileVerifyInfo verifyInfo = this.bookImpBiz.verifyQuestionFile(typeId , questionType[i]);
				if(verifyInfo!=null){
					model.addAttribute("action" , "imp");
					model.addAttribute("verifyInfo" , verifyInfo);
					return "exam/manage/imp/upload";
				}
			}
		}
		
		if(questionFilesCount==0){
			model.addAttribute("action" , "imp");
			model.addAttribute("registInfo" , "无文件上传");
			return "exam/manage/imp/upload";
		}
		
		ExamBook book = bookManageBiz.read(bookFlow);
		ExamBookImp imp = new ExamBookImp();
		if(StringUtil.isNotBlank(subjectFlow)){
			ExamSubject subject = subjectManageBiz.read(subjectFlow);
			imp.setSubjectFlow(subjectFlow);
			imp.setSubjectMemo(subject.getMemo());
		}
		String bookImpFlow = PkUtil.getUUID();
		imp.setBookImpFlow(bookImpFlow);
		imp.setBookFlow(book.getBookFlow());
		imp.setBookName(book.getMemo());
		
		List<ExamBookImpDetail> impDetailList = new ArrayList<ExamBookImpDetail>();
		for(int i=0;i<questionType.length;i++){
			if(questionType[i].isEmpty()==false){
				String typeId = request.getParameter(String.valueOf(i));
				String typeName = QuestionTypeEnum.getNameById(typeId);
				ExamBookImpDetail detail = new ExamBookImpDetail();
				detail.setQuestionTypeId(typeId);
				detail.setQuestionTypeName(typeName);
				detail.setMemo(questionType[i].getOriginalFilename());
				detail.setBookFlow(bookFlow);
				this.bookImpBiz.parseQuestionFile(detail, questionType[i]);
				impDetailList.add(detail);
			}
			
		}
		if(impDetailList.size()>0){
			bookImpBiz.addImp(imp, impDetailList);
		}
		model.addAttribute("bookImpFlow", bookImpFlow);
		return "redirect:/exam/manage/imp/result";
	}
	

	@RequestMapping("/{action}")
	public String result(String bookImpFlow , @PathVariable String action , Model model){
		List<ExamBookImpDetail> examBookImpDetailList = bookImpBiz.searchDetail(bookImpFlow);
		Map<String,ExamBookImpDetail> examBookImpDetailMap= new HashMap<String, ExamBookImpDetail>();
		for(ExamBookImpDetail detail : examBookImpDetailList){
			examBookImpDetailMap.put(detail.getQuestionTypeId(), detail);
		}
		model.addAttribute("examBookImpDetailMap", examBookImpDetailMap);
		model.addAttribute("action" , action);
		if("audit".equals(action)){
			ExamBookImp bookImp = this.bookImpBiz.findBookImpByImpFlow(bookImpFlow);
			model.addAttribute("bookImp" , bookImp);
		}
		return "exam/manage/imp/result";
	}
	
	@RequestMapping("/showquestioncontent")
	public String showQuestionContent(String detailFlow , String questionTypeId , Model model){
		//String content = this.bookImpBiz.findQuestionContentByimpDetailFlow(detailFlow);
		//content = GeneralMethod.toHTML(content);
		ExamBookImpDetail impDetail = this.bookImpBiz.findBookImpDetailByDetailFlow(detailFlow);
		ExamBookImp imp = this.bookImpBiz.findBookImpByImpFlow(impDetail.getBookImpFlow());
		List<ExamQuestionExt> examQuestionList = this.bookImpBiz.createQuestions(impDetail, imp);
		model.addAttribute("examQuestionList", examQuestionList);
		return "exam/manage/question/type_"+questionTypeId;
	}
	
	

	@RequestMapping("/submit")
	@ResponseBody
	public String submit(String bookImpFlow,Model model){
		bookImpBiz.submit(bookImpFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/impedit")
	public String impedit(String bookImpFlow,Model model){
		ExamBookImpExt bookImpExt = this.bookImpBiz.findExamBookImpByExamBookImpFlow(bookImpFlow);
		model.addAttribute("bookImp" , bookImpExt);
		//查找到所有的导入详细列表
		List<ExamBookImpDetail> bookImpDetails = this.bookImpBiz.searchDetail(bookImpFlow);
		Map<String , ExamBookImpDetail> impDetailMap = new HashMap<String, ExamBookImpDetail>();
		for(ExamBookImpDetail detail:bookImpDetails){
			impDetailMap.put(detail.getQuestionTypeId(), detail);
		}
		model.addAttribute("bookImpDetailMap" , impDetailMap);
		return "exam/manage/imp/impedit";
	}
	
	@RequestMapping("/reupload")
	public String reupload(ExamBookImp bookImp , @RequestParam(value="questionType") MultipartFile[] questionType , Model model , HttpServletRequest request){
		//登记校验
		ExamBook registBook = this.bookManageBiz.findBookByBookFlow(bookImp.getBookFlow());
		if(!BookRegistStatusEnum.Compos.getId().equals(registBook.getRegistStatusId())){
			model.addAttribute("action" , "impedit?bookImpFlow="+bookImp.getBookImpFlow());
			model.addAttribute("registInfo" , "该书目没有完成登记信息，请先填写完登记信息！");
			return "exam/manage/imp/upload";
		}
		//文件校验
		for(int i=0;i<questionType.length;i++){
			if(questionType[i].isEmpty()==false){
				String typeId = request.getParameter(String.valueOf(i));
				QuestionFileVerifyInfo verifyInfo = this.bookImpBiz.verifyQuestionFile(typeId , questionType[i]);
				if(verifyInfo!=null){
					model.addAttribute("action" , "impedit?bookImpFlow="+bookImp.getBookImpFlow());
					model.addAttribute("verifyInfo" , verifyInfo);
					return "exam/manage/imp/upload";
				}
			}
		}
		
		String bookFlow = bookImp.getBookFlow();
		String subjectFlow = bookImp.getSubjectFlow();
		if(StringUtil.isNotBlank(subjectFlow)){
			ExamSubject subject = subjectManageBiz.read(subjectFlow);
			bookImp.setSubjectMemo(subject.getMemo());
		}
		ExamBook book = bookManageBiz.read(bookFlow);
		bookImp.setBookName(book.getMemo());
		
		List<ExamBookImpDetail> impDetailList = new ArrayList<ExamBookImpDetail>();
		for(int i=0;i<questionType.length;i++){
			if(questionType[i].isEmpty()==false){
				String typeId = request.getParameter(String.valueOf(i));
				String typeName = QuestionTypeEnum.getNameById(typeId);
				ExamBookImpDetail detail = new ExamBookImpDetail();
				detail.setQuestionTypeId(typeId);
				detail.setQuestionTypeName(typeName);
				detail.setMemo(questionType[i].getOriginalFilename());
				detail.setBookFlow(bookFlow);
				this.bookImpBiz.parseQuestionFile(detail, questionType[i]);
				impDetailList.add(detail);
			}
			
		}
	    bookImpBiz.modifyImp(bookImp, impDetailList);
		model.addAttribute("bookImpFlow", bookImp.getBookImpFlow());
		return "redirect:/exam/manage/imp/result";
	}
	
	@RequestMapping("/questionreupload")
	public String questionReupload(String bookFlow , String questionTypeId ,MultipartFile questionFile  , Model model){
		//登记信息验证
		ExamBook registBook = this.bookManageBiz.findBookByBookFlow(bookFlow);
		if(!BookRegistStatusEnum.Compos.getId().equals(registBook.getRegistStatusId())){
			model.addAttribute("registInfo" , "该书目没有完成登记信息，请先填写完登记信息！");
			return "exam/manage/imp/questionreupload";
		}
		//该书目的该题型是上传过文件
		ExamBookImpDetail bookImpDetail = new ExamBookImpDetail();
		bookImpDetail.setQuestionTypeId(questionTypeId);
		bookImpDetail.setBookFlow(bookFlow);
		bookImpDetail.setRecordStatus(GlobalConstant.FLAG_Y);
		List<ExamBookImpDetail> impDetails = this.bookImpBiz.searchDetail(bookImpDetail);
		if(impDetails==null || impDetails.isEmpty()){
			model.addAttribute("registInfo" , "该书目下的该题型没有上传过题目文件,不可重传");
			return "exam/manage/imp/questionreupload";
		}else if(impDetails.size()>1){
			model.addAttribute("registInfo" , "该书目下的该题型被上传过多次，不可重传，请联系管理员");
			return "exam/manage/imp/questionreupload";
		}else{
			//文件校验
			QuestionFileVerifyInfo verifyInfo = this.bookImpBiz.verifyQuestionFile(questionTypeId , questionFile);
			if(verifyInfo!=null){
				model.addAttribute("verifyInfo" , verifyInfo);
				return "exam/manage/imp/questionreupload";
			}
			bookImpDetail = impDetails.get(0);
			//题目入库
			this.bookImpBiz.reuploadQuestion(bookImpDetail.getImpDetailFlow(), questionFile);
			model.addAttribute("bookImpDetailFlow", bookImpDetail.getImpDetailFlow());
			return "redirect:/exam/manage/imp/reuploadresult";
		}
	}
	
	@RequestMapping("/reuploadresult")
	public String reuploadResult(String bookImpDetailFlow , Model model){
		ExamBookImpDetail bookImpDetail = new ExamBookImpDetail();
		bookImpDetail.setImpDetailFlow(bookImpDetailFlow);
		bookImpDetail.setRecordStatus(GlobalConstant.FLAG_Y);
		List<ExamBookImpDetail> examBookImpDetailList = bookImpBiz.searchDetail(bookImpDetail);
		Map<String,ExamBookImpDetail> examBookImpDetailMap= new HashMap<String, ExamBookImpDetail>();
		for(ExamBookImpDetail detail : examBookImpDetailList){
			examBookImpDetailMap.put(detail.getQuestionTypeId(), detail);
		}
		model.addAttribute("examBookImpDetailMap", examBookImpDetailMap);
		return "exam/manage/imp/result";
	}
	
	@RequestMapping("/viewReloadRec")
	public String viewReloadRec(String bookFlow , Model model){
		List<ExamBookReloadRec> reloadRecs = this.bookImpBiz.searchBookReloadRecsByBookFlow(bookFlow);
		model.addAttribute("reloadRecs" , reloadRecs);
		return "exam/manage/imp/bookReloadRecs";
	}
	
	@RequestMapping("/checkList")
	public String checkList(ExamBookImpExt bookImpExt , Model model){
		bookImpExt.setStatusId(BookImpStatusEnum.Submit.getId());
		List<ExamBookImpExt> examImpList = new ArrayList<ExamBookImpExt>(); 
		List<ExamBookImpExt> examImps = bookImpBiz.search(bookImpExt);
		//当前登陆者不能看到自己导入的
		SysUser currUser = GlobalContext.getCurrentUser();
		for(ExamBookImpExt ebie:examImps){
			if(!currUser.getUserFlow().equals(ebie.getImpUserFlow())){
				examImpList.add(ebie);
			}
		}
		//获取顶层书号
//		for(ExamBookImpExt ebie:examImpList){
//			ExamBook topBook = this.bookManageBiz.findBookByBookFlow(ebie.getBookFlow());
//			ebie.getExamBook().setBookNum(topBook.getBookNum());
//		}
		model.addAttribute("examImpList", examImpList);
		model.addAttribute("bookImpExt", bookImpExt);
		return "exam/manage/imp/checklist";
	}
	
	@RequestMapping("/auditList")
	public String auditList(ExamBookImpExt bookImpExt , Model model){
		bookImpExt.setStatusId(BookImpStatusEnum.Checked.getId());
		List<ExamBookImpExt> examImpList = new ArrayList<ExamBookImpExt>(); 
		List<ExamBookImpExt> examImps = bookImpBiz.search(bookImpExt);
		//当前登陆者看不到自己导入的，看不到自己校验的
		SysUser currUser = GlobalContext.getCurrentUser();
		for(ExamBookImpExt ebie:examImps){
			if((!currUser.getUserFlow().equals(ebie.getImpUserFlow())) 
					&& (!currUser.getUserFlow().equals(ebie.getCheckUserFlow()))){
				examImpList.add(ebie);
			}
		}
		//获取顶层书号
//		for(ExamBookImpExt ebie:examImpList){
//			ExamBook topBook = this.bookManageBiz.findBookByBookFlow(ebie.getBookFlow());
//			ebie.getExamBook().setBookNum(topBook.getBookNum());
//		}
		model.addAttribute("examImpList", examImpList);
		model.addAttribute("bookImpExt", bookImpExt);
		return "exam/manage/imp/auditlist";
	}
	
	@RequestMapping("/operate")
	@ResponseBody
	public String operate(ExamBookImp bookImp){
	    if(StringUtil.isNotBlank(bookImp.getStatusId())){
	    	try{
	    		this.bookImpBiz.operate(bookImp);
	    		return GlobalConstant.OPERATE_SUCCESSED;
	    	}catch(Exception e){
	    		return e.getMessage();
	    	}
	    }
	    return GlobalConstant.OPRE_FAIL;
		
	}
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/register")
	public String register(){
		return "exam/manage/imp/questionregister";
	}
	
	@RequestMapping("/getregisterinfo")
	public String getRegisterInfo(String bookFlow , Model model){
		ExamBookRegistInfo bookRegistInfo =  this.bookImpBiz.getBookRegistInfo(bookFlow);
		model.addAttribute("bookRegistInfo" , bookRegistInfo);
		String registStatusId = bookRegistInfo.getRegistStatusId();
		if(StringUtil.isBlank(registStatusId) || 
				BookRegistStatusEnum.Scan.getId().equals(registStatusId) || 
				BookRegistStatusEnum.Recognize.getId().equals(registStatusId)){
			SysUser sysUser = new SysUser();
			String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			sysUser.setOrgFlow(orgFlow);
			List<SysUser> users = this.userBiz.searchUser(sysUser);
			model.addAttribute("users" , users);
		}
		return "exam/manage/imp/registerinfo";
	}
	
	
	@RequestMapping("/registScanInfo")
	@ResponseBody
	public String registScanInfo(ExamBookScanInfo bookScanInfo){
		this.bookImpBiz.registBookScanInfo(bookScanInfo);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/registRecognizeInfo")
	@ResponseBody
	public String registRecognizeInfo(ExamBookRecognizeInfo recognizeInfo){
		this.bookImpBiz.registRecognizeInfo(recognizeInfo);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/registComposInfo")
	@ResponseBody
	public String registComposInfo(ExamBookComposInfo bookComposInfo){
		this.bookImpBiz.registComposInfo(bookComposInfo);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/emptyimpdetail")
	@ResponseBody
	public String emptyImpDetail(String impDetailFlow){
		this.bookImpBiz.delImpDetailByImpDetailFlow(impDetailFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
}
