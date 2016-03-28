package com.pinde.sci.ctrl.srm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.alibaba.fastjson.JSON;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IAchBookAuthorBiz;
import com.pinde.sci.biz.srm.IAchBookBiz;
import com.pinde.sci.biz.srm.ISrmAchFileBiz;
import com.pinde.sci.biz.srm.ISrmAchProcessBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.srm.AchTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.SrmAchBook;
import com.pinde.sci.model.mo.SrmAchBookAuthor;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmAchBookAuthorList;
@Controller
@RequestMapping("/srm/ach/book")
public class AchBookController extends GeneralController {
	
	private static Logger logger = LoggerFactory.getLogger(AchBookController.class);
	
	@Autowired
	private IAchBookBiz bookBiz;
	@Autowired
	private IAchBookAuthorBiz bookAuthorBiz;
	@Autowired
	private ISrmAchFileBiz srmAchFileBiz;
 	@Autowired
 	private ISrmAchProcessBiz srmAchProcessBiz;
 	@Autowired
	private IOrgBiz orgBiz;
	
	@RequestMapping(value={"/save"})
	@ResponseBody
	public String saveBookAndAuthor(String jsondata ,@RequestParam(value="file" , required=false) MultipartFile file,HttpServletRequest request) throws IOException{
		SrmAchBookAuthorList aList=JSON.parseObject(jsondata,SrmAchBookAuthorList.class);
		List<SrmAchBookAuthor> authorList = aList.getAuthorList();
		SrmAchBook book = aList.getBook();
		
		book.setTypeName(DictTypeEnum.AchBookType.getDictNameById(book.getTypeId()));
		//ѧ������
		book.setCategoryName(DictTypeEnum.SubjectType.getDictNameById(book.getCategoryId()));
		book.setPressLevelName(DictTypeEnum.PressLevelType.getDictNameById(book.getPressLevelId()));
		book.setPubPlaceName(DictTypeEnum.PlaceNameType.getDictNameById(book.getPubPlaceId()));
		book.setOrgBelongName(DictTypeEnum.OrgBelong.getDictNameById(book.getOrgBelongId()));
		book.setLanguageTypeName(DictTypeEnum.LanguageType.getDictNameById(book.getLanguageTypeId()));
		book.setProjSourceName(DictTypeEnum.ProjSource.getDictNameById(book.getProjSourceId()));
		
		book.setOperStatusId(AchStatusEnum.Apply.getId());
		book.setOperStatusName(AchStatusEnum.Apply.getName());
   	    //��ȡ���뵥λ��Ϣ
   	    SysUser currUser = GlobalContext.getCurrentUser();
   	    book.setApplyOrgFlow(currUser.getOrgFlow());
   	    book.setApplyOrgName(currUser.getOrgName());
   	    //��������Ϣ
		book.setApplyUserFlow(currUser.getUserFlow());
		book.setApplyUserName(currUser.getUserName());
		
		//���ݡ��������ߡ������IDö�ٻ��Name
		for(int i = 0; i<authorList.size();i++){
			//authorList.get(i).setTypeName(DictTypeEnum.AuthorType.getDictNameById(authorList.get(i).getTypeId()));//����˳��
			authorList.get(i).setWriteTypeName(DictTypeEnum.WriteNameType.getDictNameById(authorList.get(i).getWriteTypeId()));
			authorList.get(i).setSexName(UserSexEnum.getNameById(authorList.get(i).getSexId()));
			authorList.get(i).setEducationName(DictTypeEnum.UserEducation.getDictNameById(authorList.get(i).getEducationId()));
			authorList.get(i).setTitleName(DictTypeEnum.UserTitle.getDictNameById(authorList.get(i).getTitleId()));
		}
		 //��װ��������
	       SrmAchFile srmAchFile=new SrmAchFile();
	       if(file!=null && StringUtil.isNotBlank(file.getOriginalFilename())){
			   byte[] b = new byte[(int) file.getSize()]; 
			   file.getInputStream().read(b);
	 	       srmAchFile.setFileFlow(aList.getSrmAchFile().getFileFlow());
			   srmAchFile.setFileContent(b);
			   srmAchFile.setFileName(file.getOriginalFilename());
		       srmAchFile.setTypeId(AchTypeEnum.Book.getId());
		       srmAchFile.setTypeName(AchTypeEnum.Book.getName());
	           String[] nameArray=file.getOriginalFilename().split("\\.");
		       srmAchFile.setFileSuffix(nameArray[nameArray.length-1]);
		       srmAchFile.setFileType(nameArray[nameArray.length-1]);
	       }
	       //��װ�ɹ����̶���
	       SrmAchProcess srmAchProcess=new SrmAchProcess();
	       srmAchProcess.setTypeId(AchTypeEnum.Book.getId());
	       srmAchProcess.setTypeName(AchTypeEnum.Book.getName());
	       srmAchProcess.setOperateUserFlow(currUser.getUserFlow());
	       srmAchProcess.setOperateUserName(currUser.getUserName());
	       srmAchProcess.setOperStatusId(AchStatusEnum.Apply.getId());
	       srmAchProcess.setOperStatusName(AchStatusEnum.Apply.getName());
	       bookBiz.save(book, authorList, srmAchFile, srmAchProcess);
	      // return "<script>parent.callBack('"+GlobalConstant.OPRE_SUCCESSED_FLAG+"');</script>";
	       return GlobalConstant.SAVE_SUCCESSED; 
		
	}
	
	
	@RequestMapping(value="deleteAuthor",method={RequestMethod.GET})
	@ResponseBody
	public String deleteAuthor(String authorFlow){
		if(StringUtil.isNotBlank(authorFlow)){
			SrmAchBookAuthor author = new SrmAchBookAuthor();
			author.setAuthorFlow(authorFlow);
			author.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			bookAuthorBiz.editBookAthor(author);
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * ҳ�������������
	 * @param book
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method={RequestMethod.GET,RequestMethod.POST})
	public String list(Integer currentPage, SrmAchBook book,SrmAchBookAuthor author,HttpServletRequest request, Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		book.setApplyUserFlow(currUser.getUserFlow());	
		
 		PageHelper.startPage(currentPage, getPageSize(request));
 		List<SrmAchBook> achBookList = bookBiz.search(book,null);
 		
 		//��֯�������ߵ�Map
 		Map<String, List<SrmAchBookAuthor>> allAuthorMap = new LinkedHashMap<String, List<SrmAchBookAuthor>>();
 		List<SrmAchBookAuthor> allBookAuthorList = bookAuthorBiz.searchAuthorList(new SrmAchBookAuthor());
 		if(allBookAuthorList != null && !allBookAuthorList.isEmpty()){
 			for(SrmAchBookAuthor a : allBookAuthorList){
 				List<SrmAchBookAuthor> list = allAuthorMap.get(a.getBookFlow());
 				if(list == null){
 					list = new ArrayList<SrmAchBookAuthor>();
 				}
 				list.add(a);
 				allAuthorMap.put(a.getBookFlow(), list);
 			}
 		}
 		model.addAttribute("allAuthorMap", allAuthorMap);
		model.addAttribute("achBookList",achBookList);
		return "srm/ach/book/list";
	}
	
	
	/**
	 * ��ת���������޸�
	 * @param bookFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public String edit(String bookFlow, Model model){
		SrmAchFile file = null;
  	    List<SrmAchFile> fileList=null;
  	    //������Ϣ��ʾ
  	    if(StringUtil.isNotBlank(bookFlow)){
  	    	SrmAchBook book=bookBiz.readBook(bookFlow);
			model.addAttribute("book",book);
			
			SrmAchBookAuthor author = new SrmAchBookAuthor();
			author.setBookFlow(bookFlow);
			List<SrmAchBookAuthor> bookAuthorList = bookAuthorBiz.searchAuthorList(author);
			model.addAttribute("bookAuthorList",bookAuthorList);
			fileList=srmAchFileBiz.searchSrmAchFile(bookFlow);  
		}
		if(fileList!=null && !fileList.isEmpty()){
 	    	file=fileList.get(0);
 		    model.addAttribute("file", file);
 	    }
		return "srm/ach/book/edit";
	}
	
	/**
	 * ɾ��
	 * @param book
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	@ResponseBody
	public String delete(String bookFlow){
		if(StringUtil.isNotBlank(bookFlow)){
			SrmAchBook book = new SrmAchBook();
			book.setBookFlow(bookFlow);
			book.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			
		    //����
			SrmAchBookAuthor author = new SrmAchBookAuthor();
			author.setBookFlow(bookFlow);
			List<SrmAchBookAuthor> authorList = bookAuthorBiz.searchAuthorList(author);
			for(SrmAchBookAuthor a : authorList){
				a.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			}
			//����
			SrmAchFile file = null;
			List<SrmAchFile> fileList = srmAchFileBiz.searchSrmAchFile(bookFlow); 
	    	if(fileList != null && !fileList.isEmpty()){
	    		 file = fileList.get(0);
	    		 file.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
	    	}
	    	
			int result = bookBiz.edit(book, authorList, file);
			if(result == GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	
	
	 @RequestMapping(value="/saveAudit",method={RequestMethod.POST})
 	 @ResponseBody
 	public String saveAudit(@RequestParam(value="agreeFlag" , required=true)String agreeFlag,String auditContent,
 			                @RequestParam(value="bookFlow" , required=true)String bookFlow,Model model){
 		SrmAchBook book=bookBiz.readBook(bookFlow);
 		SrmAchProcess process=srmAchProcessBiz.searchAchProcess(bookFlow, AchStatusEnum.Apply.getId()).get(0);

 		if(agreeFlag.equals(GlobalConstant.FLAG_Y)){
 			 book.setOperStatusId(AchStatusEnum.FirstAudit.getId());
 			 book.setOperStatusName(AchStatusEnum.FirstAudit.getName());
 			 process.setOperStatusId(AchStatusEnum.FirstAudit.getId());
 			 process.setOperStatusName(AchStatusEnum.FirstAudit.getName());
 		}
 		else{
 			 book.setOperStatusId(AchStatusEnum.RollBack.getId());
 			 book.setOperStatusName(AchStatusEnum.RollBack.getName());
 			 process.setOperStatusId(AchStatusEnum.RollBack.getId());
 			 process.setOperStatusName(AchStatusEnum.RollBack.getName());
 		}
 		 process.setProcessFlow(PkUtil.getUUID());
 		 GeneralMethod.setRecordInfo(process, true);
 		 process.setOperateTime(process.getCreateTime());
 		 SysUser currUser = GlobalContext.getCurrentUser();
 	     process.setOperateUserFlow(currUser.getUserFlow());
 	     process.setOperateUserName(currUser.getUserName());
 	     process.setContent(auditContent);
 	     bookBiz.updateBookStatus(book, process);
 		 return GlobalConstant.OPERATE_SUCCESSED;
 	}
	 
	 
	 
	 
 	@RequestMapping(value="/submitAudit",method={RequestMethod.GET})
 	@ResponseBody
 	public String submitAudit(@RequestParam(value="bookFlow" , required=true)String bookFlow,Model model){
 		SrmAchBook book=bookBiz.readBook(bookFlow);
 		book.setOperStatusId(AchStatusEnum.Submit.getId());
 		book.setOperStatusName(AchStatusEnum.Submit.getName());
 		 
 		 SrmAchProcess process=srmAchProcessBiz.searchAchProcess(bookFlow, AchStatusEnum.Apply.getId()).get(0);
 		 process.setProcessFlow(PkUtil.getUUID());
 		 process.setOperStatusId(AchStatusEnum.Submit.getId());
 		 process.setOperStatusName(AchStatusEnum.Submit.getName());
 		 GeneralMethod.setRecordInfo(process, true);
 		 process.setOperateTime(process.getCreateTime());
 		 SysUser currUser = GlobalContext.getCurrentUser();
 	     process.setOperateUserFlow(currUser.getUserFlow());
 	     process.setOperateUserName(currUser.getUserName());
 	    bookBiz.updateBookStatus(book, process);
 		 
 	     return GlobalConstant.OPRE_SUCCESSED_FLAG;
 	}
 	
 	
 	
 	
 	  @RequestMapping(value="/auditList/{scope}",method={RequestMethod.POST,RequestMethod.GET})
 	 	public String auditList(@PathVariable String scope,String currentPage, SrmAchBook book, SrmAchBookAuthor author, SysOrg org,Model model,HttpServletRequest request){
 		    SysUser currUser = GlobalContext.getCurrentUser();
 		    List<SrmAchBook> searchList=null;
    	    List<SrmAchBook> bookList=null;
    	   //��ѯ��ǰ�����������м����ӻ�����������
    	    List<SysOrg> currOrgChildList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
    	    //����orgFlow��chargeOrgFlow��ѯ�����ӻ����б���ӻ������ӻ������б��Map
    	    Map<String,List<SysOrg>> resultMap=orgBiz.searchChargeAndApply(org,scope);
    	    //��ȡ��ǰ��������һ���Ļ���
    	    List<SysOrg> firstGradeOrgList=(List<SysOrg>) resultMap.get("firstGradeOrgList");
    	    model.addAttribute("firstGradeOrgList", firstGradeOrgList);
 	 		 //������
 	    	 if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL .equals(scope)){
 	    		//���ò�ѯ�������Ƽ������ͨ���ĳɹ�
 	     		book.setOperStatusId(AchStatusEnum.FirstAudit.getId()); 
 	    		 //�����ǰ��¼���������֣���ȡ�õ�λѡ������һ�������������ӻ���
 	    		 List<SysOrg> secondGradeOrgList=(List<SysOrg>) resultMap.get("secondGradeOrgList");
 	    		 if(null!=secondGradeOrgList && !secondGradeOrgList.isEmpty()){
 	    			 model.addAttribute("secondGradeOrgList",secondGradeOrgList);
 	    		 }
 	    		 //�����ѯ����orgFlowΪ����chargeOrgFlow��Ϊ�գ����ѯ�����ܲ����������ӻ��������гɹ�
 	 			if(StringUtil.isBlank(org.getOrgFlow()) && StringUtil.isNotBlank(org.getChargeOrgFlow())){
 	 				if(null == secondGradeOrgList || secondGradeOrgList.isEmpty()){
 		   		    	SysOrg sysOrg=orgBiz.readSysOrg(org.getChargeOrgFlow());
 		   		    	List<SysOrg> selfOrgList=new ArrayList<SysOrg>();
 		   		    	selfOrgList.add(sysOrg);
 			   		    searchList = bookBiz.search(book,selfOrgList);
 		   		    }else{
 			   		    searchList = bookBiz.search(book,secondGradeOrgList);
 		   		    }
 	 			}
 	 			  
 	    	 }else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(scope)){
 	    		book.setOperStatusId(AchStatusEnum.FirstAudit.getId());
 	    	 }else{
 	    		if(StringUtil.isBlank(book.getOperStatusId())){
 	    			book.setOperStatusId(AchStatusEnum.Submit.getId());
	     		}
	    		if(GlobalConstant.FLAG_Y.equals(book.getOperStatusId())){
	    			book.setOperStatusId(AchStatusEnum.Submit.getId()+","+AchStatusEnum.FirstAudit.getId());
	    		 }
 	    	 }
 	    	//�����ѯ����orgFlow��Ϊ�գ����ѯ��org�����гɹ�
 	    	 if(StringUtil.isNotBlank(org.getOrgFlow())){
 	    		 book.setApplyOrgFlow(org.getOrgFlow());
 	    		 searchList = bookBiz.search(book,null);
 		     }
 	    	 //�����ѯ����orgFlow��chargeOrgFlow��Ϊ�գ���ô��ѯ��ǰ��¼�������гɹ�
 	    	 if(StringUtil.isBlank(org.getOrgFlow()) && StringUtil.isBlank(org.getChargeOrgFlow())){
 		   		 searchList = bookBiz.search(book,currOrgChildList);
 	    	 }
 	    	 
 	    	 Map<String, List<SrmAchBookAuthor>> allAuthorMap = new HashMap<String, List<SrmAchBookAuthor>>();
 	    	 List<SrmAchBookAuthor> bookAuthorList = bookAuthorBiz.searchAuthorList(new SrmAchBookAuthor());
 	    	 if(bookAuthorList != null && !bookAuthorList.isEmpty()){
 	    		 for(SrmAchBookAuthor a : bookAuthorList){
 	    			 List<SrmAchBookAuthor> authorList = allAuthorMap.get(a.getBookFlow());
 	    			 if(authorList == null){
 	    				 authorList = new ArrayList<SrmAchBookAuthor>();
 	    			 }
 	    			 authorList.add(a);
 	    			 allAuthorMap.put(a.getBookFlow(), authorList);
 	    		 }
 	    	 }			
 	    		
    		//����
    		if(StringUtil.isNotBlank(author.getAuthorName())){ 
    			bookList = new ArrayList<SrmAchBook>();
    			for(SrmAchBook b : searchList){
    				boolean addFlag = false;
    				List<SrmAchBookAuthor> authorByNameList = allAuthorMap.get(b.getBookFlow());
    				if(authorByNameList != null){
	    				for(SrmAchBookAuthor na : authorByNameList){
	    					if(na.getAuthorName().equals(author.getAuthorName())){
	    						addFlag = true;
	    						break;
	    					}
	    				}
    				}
    				if(addFlag){
    					bookList.add(b);
    				}
    			}
    		}else {
    			bookList = searchList;
    		}
    		model.addAttribute("allAuthorMap", allAuthorMap);
     		model.addAttribute("bookList", bookList);
     		return "srm/ach/book/auditList"+scope;
 	 	}
 	  
 	  
 	 @RequestMapping("/audit")
 	 public String audit(@RequestParam(value="bookFlow", required=true)String bookFlow,Model model){
 		//���ݳɹ���ˮ�Ų�ѯ�����Ϣ�����ڼ������ҳ�� 
		 SrmAchFile file = null;
		 List<SrmAchFile> fileList=null;
		if(StringUtil.isNotBlank(bookFlow)){
			//��ѯ�ɹ�����
			SrmAchBook book=bookBiz.readBook(bookFlow);
			model.addAttribute("book", book);
			//��ѯ�ɹ�����
			SrmAchBookAuthor author = new SrmAchBookAuthor();
	    	author.setBookFlow(bookFlow);
		    List<SrmAchBookAuthor> bookAuthorList=bookAuthorBiz.searchAuthorList(author);
			model.addAttribute("bookAuthorList", bookAuthorList);
			//��ѯ�ɹ�����
		    fileList=srmAchFileBiz.searchSrmAchFile(bookFlow);  
		  if(fileList!=null && !fileList.isEmpty()){
		    file=fileList.get(0);
		    model.addAttribute("file", file);
		   }
		}
 	 	return "srm/ach/book/audit";
 	 }
}
