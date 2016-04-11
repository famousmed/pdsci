package com.pinde.sci.ctrl.srm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
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
import com.pinde.sci.biz.srm.ISrmAchFileBiz;
import com.pinde.sci.biz.srm.ISrmAchProcessBiz;
import com.pinde.sci.biz.srm.IThesisAuthorBiz;
import com.pinde.sci.biz.srm.IThesisBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.srm.AchTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchThesis;
import com.pinde.sci.model.mo.SrmAchThesisAuthor;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmAchThesisAuthorList;

@Controller
@RequestMapping("/srm/ach/thesis")
public class AchThesisController extends GeneralController{
	
	@Autowired
    private IThesisBiz thesisBiz;
	@Autowired
    private IThesisAuthorBiz authorBiz;
	@Autowired
	private ISrmAchFileBiz srmAchFileBiz;
	@Autowired
	private ISrmAchProcessBiz srmAchProcessBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	
	/**
	 * 保存论文
	 * @param thesis
	 * @param request
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value={"/save"})
	@ResponseBody
    public  String save(String jsondata ,@RequestParam(value="file" , required=false)MultipartFile file,HttpServletRequest request) throws IOException{      		
		 SrmAchThesisAuthorList aList = JSON.parseObject(jsondata, SrmAchThesisAuthorList.class);
		 List<SrmAchThesisAuthor> authorList=aList.getAuthorList();
		 SrmAchThesis thesis=aList.getThesis();    
	      //枚举：根据论文相关ID枚举获得name        
		 thesis.setTypeName(DictTypeEnum.ThesisType.getDictNameById(thesis.getTypeId()));
	     thesis.setHospSignName(DictTypeEnum.OrgBelong.getDictNameById(thesis.getHospSignId()));
	     thesis.setPublishTypeName(DictTypeEnum.PublishType.getDictNameById(thesis.getPublishTypeId()));
	     thesis.setProjTypeName(DictTypeEnum.ProjType.getDictNameById(thesis.getProjTypeId()));
	     thesis.setSubjectTypeName(DictTypeEnum.SubjectType.getDictNameById(thesis.getSubjectTypeId()));
	     thesis.setPublishScopeName(DictTypeEnum.PublishScope.getDictNameById(thesis.getPublishScopeId()));
	     thesis.setProjSourceName(DictTypeEnum.ProjSource.getDictNameById(thesis.getProjSourceId()));
	     thesis.setMeetingName(DictTypeEnum.MeetingType.getDictNameById(thesis.getMeetingId()));
	     
	     SysUser currUser = GlobalContext.getCurrentUser();
	     thesis.setApplyUserFlow(currUser.getUserFlow());
	     thesis.setApplyUserName(currUser.getUserName());
	     thesis.setApplyOrgFlow(currUser.getOrgFlow());
	     thesis.setApplyOrgName(currUser.getOrgName());
	     
	     thesis.setOperStatusId(AchStatusEnum.Apply.getId());
	     thesis.setOperStatusName(AchStatusEnum.Apply.getName());
         //根据刊物类型ID分解成数组,并枚举获得刊物类型name
	     if(StringUtil.isNotBlank(thesis.getJourTypeId())){
		     String [] jti=thesis.getJourTypeId().split(",");
		     StringBuffer jtn=new StringBuffer();
		     for(int i=0;i<jti.length;i++){
		    	jtn.append(DictTypeEnum.JournalType.getDictNameById(jti[i])+",");
		     }
		     jtn.delete(jtn.length()-1, jtn.length());
		     thesis.setJourTypeName(jtn.toString());
	     } 
		 //枚举：根据论文作者相关ID枚举获得name
	     for(int i=0;i<authorList.size();i++){
	    	 authorList.get(i).setTypeName(DictTypeEnum.AuthorType.getDictNameById(authorList.get(i).getTypeId()));
	    	 authorList.get(i).setSexName(UserSexEnum.getNameById(authorList.get(i).getSexId()));
	    	 authorList.get(i).setTitleName(DictTypeEnum.UserTitle.getDictNameById(authorList.get(i).getTitleId()));
	    	 authorList.get(i).setDegreeName(DictTypeEnum.UserDegree.getDictNameById(authorList.get(i).getDegreeId()));
	    	 authorList.get(i).setEducationName(DictTypeEnum.UserEducation.getDictNameById(authorList.get(i).getEducationId()));
	    }
	     //封装附件对象
	    SrmAchFile srmAchFile = null;
	    if(file!=null && StringUtil.isNotBlank(file.getOriginalFilename())){
     	   srmAchFile =new SrmAchFile();
		   byte[] b = new byte[(int) file.getSize()]; 
		   file.getInputStream().read(b);
		   srmAchFile.setFileFlow(aList.getSrmAchFile().getFileFlow());
		   srmAchFile.setFileContent(b);
		   srmAchFile.setFileName(file.getOriginalFilename());
	       srmAchFile.setTypeId(AchTypeEnum.Thesis.getId());
	       srmAchFile.setTypeName(AchTypeEnum.Thesis.getName());
	       String[] nameArray=file.getOriginalFilename().split("\\.");
	       srmAchFile.setFileSuffix(nameArray[nameArray.length-1]);
	       srmAchFile.setFileType(nameArray[nameArray.length-1]);
     	}
		//封装成果过程对象
		SrmAchProcess srmAchProcess=new SrmAchProcess();
		srmAchProcess.setTypeId(AchTypeEnum.Thesis.getId());
		srmAchProcess.setTypeName(AchTypeEnum.Thesis.getName());
		  
		srmAchProcess.setOperateUserFlow(currUser.getUserFlow());
		srmAchProcess.setOperateUserName(currUser.getUserName());
		srmAchProcess.setOperStatusId(AchStatusEnum.Apply.getId());
		srmAchProcess.setOperStatusName(AchStatusEnum.Apply.getName());
		thesisBiz.save(thesis, authorList,srmAchFile,srmAchProcess);
		return GlobalConstant.SAVE_SUCCESSED;
    }
	
	/**
	 * 查询论文列表
	 * @param thesis
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method={RequestMethod.POST,RequestMethod.GET})
	public String list(Integer currentPage,SrmAchThesis thesis, SrmAchThesisAuthor author,HttpServletRequest request, Model model){
		 SysUser currUser = GlobalContext.getCurrentUser();
		 thesis.setApplyUserFlow(currUser.getUserFlow());
		 
		 PageHelper.startPage(currentPage, getPageSize(request));
		 
	     List<SrmAchThesis> thesitlist =thesisBiz.search(thesis, null);
	     
	     //组织关联作者的Map
	     Map<String,List<SrmAchThesisAuthor>> allAuthorMap = new LinkedHashMap<String, List<SrmAchThesisAuthor>>();
	     List<SrmAchThesisAuthor> allThesisAuthorList = authorBiz.searchAuthorList(new SrmAchThesisAuthor());
	     if(allThesisAuthorList != null && !allThesisAuthorList.isEmpty()){
	    	 for(SrmAchThesisAuthor a : allThesisAuthorList){
	    		 List<SrmAchThesisAuthor> list = allAuthorMap.get(a.getThesisFlow());
	    		 if(list == null){
	    			 list = new ArrayList<SrmAchThesisAuthor>();
	    		 }
	    		 list.add(a);
	    		 allAuthorMap.put(a.getThesisFlow(),list);
	    	 }
	     }
   		 model.addAttribute("allAuthorMap", allAuthorMap);
		 model.addAttribute("thesisList", thesitlist);
		 return "srm/ach/thesis/list";
	}

	@RequestMapping(value="/auditList/{scope}",method={RequestMethod.POST,RequestMethod.GET})
	public String auditList(@PathVariable String scope,String currentPage,SrmAchThesis thesis, SrmAchThesisAuthor author, SysOrg org,Model model,HttpServletRequest request){
    	 SysUser currUser = GlobalContext.getCurrentUser();
    	 List<SrmAchThesis> searchList=null;
    	 List<SrmAchThesis> thesisList=null;
    	 //查询当前机构下属所有级别子机构包含自身
    	 List<SysOrg> currOrgChildList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
    	 //根据orgFlow和chargeOrgFlow查询包含子机构列表和子机构的子机构的列表的Map
    	 Map<String,List<SysOrg>> resultMap=orgBiz.searchChargeAndApply(org,scope);
    	 //获取当前机构下属一级的机构
    	 List<SysOrg> firstGradeOrgList=(List<SysOrg>) resultMap.get("firstGradeOrgList");
    	 model.addAttribute("firstGradeOrgList", firstGradeOrgList);
    	 
   	 if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(scope)){
   	      //设置查询条件：科技处审核通过的成果
  		  thesis.setOperStatusId(AchStatusEnum.FirstAudit.getId()); 
 		 //如果当前登录者是卫生局，获取该单位选定的下一级机构的所有子机构
 		 List<SysOrg> secondGradeOrgList=(List<SysOrg>) resultMap.get("secondGradeOrgList");
 		 if(null!=secondGradeOrgList && !secondGradeOrgList.isEmpty()){
 			 model.addAttribute("secondGradeOrgList",secondGradeOrgList);
 		 }
 		 //如果查询条件orgFlow为空且chargeOrgFlow不为空，则查询该主管部门下所有子机构的所有成果
		 if(StringUtil.isBlank(org.getOrgFlow()) && StringUtil.isNotBlank(org.getChargeOrgFlow())){
            if(null == secondGradeOrgList || secondGradeOrgList.isEmpty()){
   		    	SysOrg sysOrg=orgBiz.readSysOrg(org.getChargeOrgFlow());
   		    	List<SysOrg> selfOrgList=new ArrayList<SysOrg>();
   		    	selfOrgList.add(sysOrg);
	   		    searchList = thesisBiz.search(thesis,selfOrgList);
   		    }else{
	   		    searchList = thesisBiz.search(thesis,secondGradeOrgList);
   		    }
		 }
   	 }else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(scope)){
   	        thesis.setOperStatusId(AchStatusEnum.FirstAudit.getId());    
   	 }else{
   		 if(StringUtil.isBlank(thesis.getOperStatusId())){
    		thesis.setOperStatusId(AchStatusEnum.Submit.getId());
    	 }
   		 else if(GlobalConstant.FLAG_Y.equals(thesis.getOperStatusId())){
   			thesis.setOperStatusId(AchStatusEnum.Submit.getId()+","+AchStatusEnum.FirstAudit.getId());
   		 }
   	 }
   //如果查询条件orgFlow不为空，则查询该org下所有成果
	 if(StringUtil.isNotBlank(org.getOrgFlow())){
		 thesis.setApplyOrgFlow(org.getOrgFlow());
   		 searchList = thesisBiz.search(thesis,null);
     }
	 //如果查询条件orgFlow和chargeOrgFlow都为空，那么查询当前登录者下所有成果
	 if(StringUtil.isBlank(org.getOrgFlow()) && StringUtil.isBlank(org.getChargeOrgFlow())){
   		 searchList = thesisBiz.search(thesis,currOrgChildList);
	 }
	 
	 Map<String, List<SrmAchThesisAuthor>> allAuthorMap = new HashMap<String, List<SrmAchThesisAuthor>>();
 	 List<SrmAchThesisAuthor> thesisAuthorList = authorBiz.searchAuthorList(new SrmAchThesisAuthor());
 	 if(thesisAuthorList != null && !thesisAuthorList.isEmpty()){
 		 for(SrmAchThesisAuthor a : thesisAuthorList){
 			 List<SrmAchThesisAuthor> authorList = allAuthorMap.get(a.getThesisFlow());
 			 if(authorList == null){
 				 authorList = new ArrayList<SrmAchThesisAuthor>();
 			 }
 			 authorList.add(a);
 			 allAuthorMap.put(a.getThesisFlow(), authorList);
 		 }
 	 }			
 		
	//过滤论文流水号
	if(StringUtil.isNotBlank(author.getAuthorName())){ 
		thesisList = new ArrayList<SrmAchThesis>();
		for(SrmAchThesis b : searchList){
			boolean addFlag = false;
			List<SrmAchThesisAuthor> authorByNameList = allAuthorMap.get(b.getThesisFlow());
			if(authorByNameList != null){
				for(SrmAchThesisAuthor na : authorByNameList){
					if(na.getAuthorName().equals(author.getAuthorName())){
						addFlag = true;
						break;
					}
				}
			}
			if(addFlag){
				thesisList.add(b);
			}
		}
	}else{
		thesisList = searchList;
	}
		 model.addAttribute("allAuthorMap", allAuthorMap);
		 model.addAttribute("thesisList", thesisList);
		 return "srm/ach/thesis/auditList"+scope;
	}
		
	/**
	 * 打开编辑页面并且获取一条论文记录的详细信息
	 * @param thesisFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit",method={RequestMethod.GET})
	public String edit(String thesisFlow, Model model)
	{   
		 SrmAchFile file = null;
		 List<SrmAchFile> fileList=null;
	     SrmAchThesis thesis=thesisBiz.readThesis(thesisFlow);
	     model.addAttribute("thesis",thesis);
	     //根据论文流水号查询其作者
	     if(StringUtil.isNotBlank(thesisFlow)){
	    	 SrmAchThesisAuthor author = new SrmAchThesisAuthor();
	    	 author.setThesisFlow(thesisFlow);
		     List<SrmAchThesisAuthor> authorList=authorBiz.searchAuthorList(author);
			 model.addAttribute("authorList", authorList);
			 
		     fileList=srmAchFileBiz.searchSrmAchFile(thesisFlow);  
		     if(fileList!=null && !fileList.isEmpty()){
		    	 file=fileList.get(0);
		    	 model.addAttribute("file", file);
		     }
	     }
		 return "srm/ach/thesis/edit";
	} 
	
	
	/**
	 * 删除一条论文记录
	 * @param thesis
	 * @return
	 */
	 @RequestMapping(value="/delete",method=RequestMethod.GET)
	 @ResponseBody
	 public String delete(String thesisFlow){
		 if(StringUtil.isNotBlank(thesisFlow)){
			 SrmAchThesis thesis = new SrmAchThesis();
			 thesis.setThesisFlow(thesisFlow);
			 thesis.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			
			 SrmAchThesisAuthor author = new SrmAchThesisAuthor();
			 author.setThesisFlow(thesisFlow);
			 List<SrmAchThesisAuthor> authorList = authorBiz.searchAuthorList(author);
			 for(SrmAchThesisAuthor a : authorList){
				 a.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			 }
			 
			 List<SrmAchFile> fileList = srmAchFileBiz.searchSrmAchFile(thesisFlow); 
			 SrmAchFile file = null;
	    	 if(fileList != null && !fileList.isEmpty()){
	    		 file = fileList.get(0);
	    		 file.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
	    	 }
	    	 
			 int result = thesisBiz.edit(thesis, authorList, file);
			 if(result == GlobalConstant.ONE_LINE){
				 return GlobalConstant.DELETE_SUCCESSED;
			 }
		 }
		 return GlobalConstant.DELETE_FAIL;
	 }
	

	@RequestMapping(value = "/deleteAuthor",method={RequestMethod.GET})
	@ResponseBody
	public  String deleteAuthor(String authorFlow){
		if(StringUtil.isNotBlank(authorFlow)){
			SrmAchThesisAuthor author = new SrmAchThesisAuthor();
			author.setAuthorFlow(authorFlow);
			author.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result =  authorBiz.editAuthor(author);
			if(result == GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}   
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping("/audit")
	public String audit(@RequestParam(value="thesisFlow" , required=true)String thesisFlow,Model model){
		//根据成果流水号查询相关信息，用于加载审核页面 
		 SrmAchFile file = null;
		 List<SrmAchFile> fileList=null;
		if(StringUtil.isNotBlank(thesisFlow)){
			//查询成果本身
			SrmAchThesis thesis=thesisBiz.readThesis(thesisFlow);
			model.addAttribute("thesis",thesis);
			//查询成果作者
			SrmAchThesisAuthor author = new SrmAchThesisAuthor();
	    	author.setThesisFlow(thesisFlow);
		    List<SrmAchThesisAuthor> authorList=authorBiz.searchAuthorList(author);
			model.addAttribute("authorList", authorList);
			//查询成果附件
		    fileList=srmAchFileBiz.searchSrmAchFile(thesisFlow);  
		  if(fileList!=null && !fileList.isEmpty()){
		    file=fileList.get(0);
		    model.addAttribute("file", file);
		   }
		}
		return "srm/ach/thesis/audit";
	}
	
	@RequestMapping(value="/saveAudit",method={RequestMethod.POST})
	@ResponseBody
	public String saveAudit(@RequestParam(value="agreeFlag" , required=true)String agreeFlag,String auditContent,
			                @RequestParam(value="thesisFlow" , required=true)String thesisFlow,Model model){
		SrmAchThesis thesis=thesisBiz.readThesis(thesisFlow);
		SrmAchProcess process=srmAchProcessBiz.searchAchProcess(thesisFlow, AchStatusEnum.Apply.getId()).get(0);

		if(agreeFlag.equals(GlobalConstant.FLAG_Y)){
			 thesis.setOperStatusId(AchStatusEnum.FirstAudit.getId());
			 thesis.setOperStatusName(AchStatusEnum.FirstAudit.getName());
			 process.setOperStatusId(AchStatusEnum.FirstAudit.getId());
			 process.setOperStatusName(AchStatusEnum.FirstAudit.getName());
		}else{
			 thesis.setOperStatusId(AchStatusEnum.RollBack.getId());
			 thesis.setOperStatusName(AchStatusEnum.RollBack.getName());
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
		thesisBiz.updateThesisStatus(thesis,process);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping(value="/submitAudit",method={RequestMethod.GET})
	@ResponseBody
	public String submitAudit(@RequestParam(value="thesisFlow" , required=true)String thesisFlow, Model model){
		if(StringUtil.isNotBlank(thesisFlow)){
			SrmAchThesis thesis=thesisBiz.readThesis(thesisFlow);
			thesis.setOperStatusId(AchStatusEnum.Submit.getId());
			thesis.setOperStatusName(AchStatusEnum.Submit.getName());
			
			SrmAchProcess process=srmAchProcessBiz.searchAchProcess(thesisFlow, AchStatusEnum.Apply.getId()).get(0);
			process.setProcessFlow(PkUtil.getUUID());
			process.setOperStatusId(AchStatusEnum.Submit.getId());
			process.setOperStatusName(AchStatusEnum.Submit.getName());
			GeneralMethod.setRecordInfo(process, true);
			process.setOperateTime(process.getCreateTime());
			SysUser currUser = GlobalContext.getCurrentUser();
			process.setOperateUserFlow(currUser.getUserFlow());
			process.setOperateUserName(currUser.getUserName());
			thesisBiz.updateThesisStatus(thesis,process);
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL;
	}
}
