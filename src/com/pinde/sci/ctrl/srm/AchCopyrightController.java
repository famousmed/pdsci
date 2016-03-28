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
import com.pinde.sci.biz.srm.ICopyrightAuthorBiz;
import com.pinde.sci.biz.srm.ICopyrightBiz;
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
import com.pinde.sci.model.mo.SrmAchCopyright;
import com.pinde.sci.model.mo.SrmAchCopyrightAuthor;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmAchCopyrightAuthorList;

@Controller
@RequestMapping("/srm/ach/copyright")
public class AchCopyrightController extends GeneralController{
	
	private static Logger logger = LoggerFactory.getLogger(AchCopyrightController.class);
	
	
	@Autowired
	private ICopyrightBiz copyrightBiz;
	@Autowired
	private ICopyrightAuthorBiz copyrightAuthorBiz;
	@Autowired
	private ISrmAchFileBiz srmAchFileBiz;
	@Autowired
	private ISrmAchProcessBiz srmAchProcessBiz;
    @Autowired
	private IOrgBiz orgBiz;
	
	
	@RequestMapping(value="/submitAudit")
 	@ResponseBody
 	public String submitAudit(@RequestParam(value="copyrightFlow" , required=true)String copyrightFlow,Model model){
		SrmAchCopyright copyright = copyrightBiz.readCopyright(copyrightFlow);
		copyright.setOperStatusId(AchStatusEnum.Submit.getId());
		copyright.setOperStatusName(AchStatusEnum.Submit.getName());
		
 		 SrmAchProcess process=srmAchProcessBiz.searchAchProcess(copyrightFlow, AchStatusEnum.Apply.getId()).get(0);
 		 process.setProcessFlow(PkUtil.getUUID());
 		 process.setOperStatusId(AchStatusEnum.Submit.getId());
 		 process.setOperStatusName(AchStatusEnum.Submit.getName());
 		 GeneralMethod.setRecordInfo(process, true);
 		 process.setOperateTime(process.getCreateTime());
 		 
 		 SysUser currUser = GlobalContext.getCurrentUser();
 	     process.setOperateUserFlow(currUser.getUserFlow());
 	     process.setOperateUserName(currUser.getUserName());
 	     copyrightBiz.updateCopyrightStatus(copyright, process);
 		 
 	     return GlobalConstant.OPRE_SUCCESSED_FLAG;
 	}
	
	 @RequestMapping(value="/auditList/{scope}",method={RequestMethod.POST,RequestMethod.GET})
 	 public String auditList(@PathVariable String scope, String auditStatus, SrmAchCopyright copyright, SrmAchCopyrightAuthor author, SysOrg org,Model model,HttpServletRequest request){
		 SysUser currUser = GlobalContext.getCurrentUser();
		 List<SrmAchCopyright> searchList=null;
    	 List<SrmAchCopyright> copyrightList=null;
    	 //查询当前机构下属所有级别子机构包含自身
    	 List<SysOrg> currOrgChildList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
    	 //根据orgFlow和chargeOrgFlow查询包含子机构列表和子机构的子机构的列表的Map
    	 Map<String,List<SysOrg>> resultMap=orgBiz.searchChargeAndApply(org,scope);
    	 //获取当前机构下属一级的机构
    	 List<SysOrg> firstGradeOrgList=(List<SysOrg>) resultMap.get("firstGradeOrgList");
    	 model.addAttribute("firstGradeOrgList", firstGradeOrgList);
    	 if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(scope)){
    		//设置查询条件：科技处审核通过的成果
      		copyright.setOperStatusId(AchStatusEnum.FirstAudit.getId()); 
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
 		   		    searchList = copyrightBiz.search(copyright, selfOrgList);
 	   		    }else{
 		   		    searchList = copyrightBiz.search(copyright, secondGradeOrgList);
 	   		    }
  			}
  			
    	 }else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(scope)){
    		copyright.setOperStatusId(AchStatusEnum.FirstAudit.getId()); 
    	 }else{
    		 if(StringUtil.isBlank(copyright.getOperStatusId())){
    			 copyright.setOperStatusId(AchStatusEnum.Submit.getId());
     		 }
    		 if(GlobalConstant.FLAG_Y.equals(copyright.getOperStatusId())){
    			copyright.setOperStatusId(AchStatusEnum.Submit.getId()+","+AchStatusEnum.FirstAudit.getId());
    		 }
    	 }
    	//如果查询条件orgFlow不为空，则查询该org下所有成果
    	 if(StringUtil.isNotBlank(org.getOrgFlow())){
    		 copyright.setApplyOrgFlow(org.getOrgFlow());
	   		 searchList = copyrightBiz.search(copyright,null);
	     }
    	 //如果查询条件orgFlow和chargeOrgFlow都为空，那么查询当前登录者下所有成果
    	 if(StringUtil.isBlank(org.getOrgFlow()) && StringUtil.isBlank(org.getChargeOrgFlow())){
	   		 searchList = copyrightBiz.search(copyright, currOrgChildList);
    	 }
    	 
    	 
    	 Map<String, List<SrmAchCopyrightAuthor>> allAuthorMap = new HashMap<String, List<SrmAchCopyrightAuthor>>();
	    	 List<SrmAchCopyrightAuthor> copyrightAuthorList = copyrightAuthorBiz.searchAuthorList(new SrmAchCopyrightAuthor());
	    	 if(copyrightAuthorList != null && !copyrightAuthorList.isEmpty()){
	    		 for(SrmAchCopyrightAuthor a : copyrightAuthorList){
	    			 List<SrmAchCopyrightAuthor> authorList = allAuthorMap.get(a.getCopyrightFlow());
	    			 if(authorList == null){
	    				 authorList = new ArrayList<SrmAchCopyrightAuthor>();
	    			 }
	    			 authorList.add(a);
	    			 allAuthorMap.put(a.getCopyrightFlow(), authorList);
	    		 }
	    	 }			
	    		
		//过滤
		if(StringUtil.isNotBlank(author.getAuthorName())){ 
			copyrightList = new ArrayList<SrmAchCopyright>();
			for(SrmAchCopyright b : searchList){
				boolean addFlag = false;
				List<SrmAchCopyrightAuthor> authorByNameList = allAuthorMap.get(b.getCopyrightFlow());
				if(authorByNameList != null){
    				for(SrmAchCopyrightAuthor na : authorByNameList){
    					if(na.getAuthorName().equals(author.getAuthorName())){
    						addFlag = true;
    						break;
    					}
    				}
				}
				if(addFlag){
					copyrightList.add(b);
				}
			}
		}else {
			copyrightList = searchList;
		}
		 model.addAttribute("allAuthorMap", allAuthorMap);
		 model.addAttribute("copyrightList", copyrightList);
 		 return "/srm/ach/copyright/auditList"+scope;
	 }
	
	 //审核
	 @RequestMapping("/audit")
 	 public String audit(@RequestParam(value="copyrightFlow", required=true)String copyrightFlow,Model model){
		//根据成果流水号查询相关信息，用于加载审核页面 
		 SrmAchFile file = null;
		 List<SrmAchFile> fileList=null;
		if(StringUtil.isNotBlank(copyrightFlow)){
			//查询成果本身
			SrmAchCopyright copyright=copyrightBiz.readCopyright(copyrightFlow);
			model.addAttribute("copyright", copyright);
			//查询成果作者
			SrmAchCopyrightAuthor author = new SrmAchCopyrightAuthor();
	    	author.setCopyrightFlow(copyrightFlow);
		    List<SrmAchCopyrightAuthor> copyrightAuthorList=copyrightAuthorBiz.searchAuthorList(author);
			model.addAttribute("copyrightAuthorList", copyrightAuthorList);
			//查询成果附件
		    fileList=srmAchFileBiz.searchSrmAchFile(copyrightFlow);  
		  if(fileList!=null && !fileList.isEmpty()){
		    file=fileList.get(0);
		    model.addAttribute("file", file);
		   }
		}
 		return "srm/ach/copyright/audit";
	 }
	
	
	 @RequestMapping(value="/saveAudit",method={RequestMethod.POST})
 	 @ResponseBody
 	 public String saveAudit(@RequestParam(value="agreeFlag" , required=true)String agreeFlag,String auditContent,
 			                @RequestParam(value="copyrightFlow" , required=true)String copyrightFlow,Model model){
		 
		SrmAchCopyright copyright = copyrightBiz.readCopyright(copyrightFlow);
		 
 		SrmAchProcess process=srmAchProcessBiz.searchAchProcess(copyrightFlow, AchStatusEnum.Apply.getId()).get(0);

 		if(agreeFlag.equals(GlobalConstant.FLAG_Y)){
 			copyright.setOperStatusId(AchStatusEnum.FirstAudit.getId());
 			copyright.setOperStatusName(AchStatusEnum.FirstAudit.getName());
 			 process.setOperStatusId(AchStatusEnum.FirstAudit.getId());
 			 process.setOperStatusName(AchStatusEnum.FirstAudit.getName());
 		}
 		else{
 			copyright.setOperStatusId(AchStatusEnum.RollBack.getId());
 			copyright.setOperStatusName(AchStatusEnum.RollBack.getName());
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
 	     
 	    copyrightBiz.updateCopyrightStatus(copyright, process);
 		return GlobalConstant.OPERATE_SUCCESSED;
	 	}
	
	@RequestMapping(value = "/list",method={RequestMethod.GET,RequestMethod.POST})
	public String list(Integer currentPage, SrmAchCopyright copyright,HttpServletRequest request, Model model){
		
		SysUser currUser = GlobalContext.getCurrentUser();
		copyright.setApplyUserFlow(currUser.getUserFlow());
		
		PageHelper.startPage(currentPage, getPageSize(request));
		List<SrmAchCopyright> copyrightList = copyrightBiz.search(copyright, null);
		
		Map<String,List<SrmAchCopyrightAuthor>> allAuthorMap = new LinkedHashMap<String, List<SrmAchCopyrightAuthor>>();
		List<SrmAchCopyrightAuthor> allAopyrightAuthorList = copyrightAuthorBiz.searchAuthorList(new SrmAchCopyrightAuthor());
		for(SrmAchCopyrightAuthor cAuthor : allAopyrightAuthorList){
			List<SrmAchCopyrightAuthor> list = allAuthorMap.get(cAuthor.getCopyrightFlow());
			if(list == null){
				list = new ArrayList<SrmAchCopyrightAuthor>();
			}
			list.add(cAuthor);
			allAuthorMap.put(cAuthor.getCopyrightFlow(), list);
		}
		
		model.addAttribute("allAuthorMap", allAuthorMap);
		model.addAttribute("copyrightList", copyrightList);
		return "srm/ach/copyright/list";
	}
	
	@RequestMapping(value="/edit", method={RequestMethod.GET})
	public String edit(String copyrightFlow, Model model){
		SrmAchFile file = null;
		List<SrmAchFile> fileList=null; 
		SrmAchCopyright copyright = copyrightBiz.readCopyright(copyrightFlow);
		model.addAttribute("copyright", copyright);
		 //根据copyrightFlow查询作者
		if(StringUtil.isNotBlank(copyrightFlow)){
			SrmAchCopyrightAuthor author = new SrmAchCopyrightAuthor();
			author.setCopyrightFlow(copyrightFlow);
			List<SrmAchCopyrightAuthor> copyrightAuthorList=copyrightAuthorBiz.searchAuthorList(author);
			model.addAttribute("copyrightAuthorList",copyrightAuthorList);
			
			fileList=srmAchFileBiz.searchSrmAchFile(copyrightFlow);  
		}
	    if(fileList!=null && !fileList.isEmpty()){
 	    	 file=fileList.get(0);
 		     model.addAttribute("file", file);
 	    }

		return "srm/ach/copyright/edit";
	}
	
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	@ResponseBody
	public String save(String jsondata ,@RequestParam(value="file" , required=false)MultipartFile file,HttpServletRequest request) throws IOException{
	
		SrmAchCopyrightAuthorList cList = JSON.parseObject(jsondata,SrmAchCopyrightAuthorList.class);
		SrmAchCopyright copyright = cList.getCopyright();
		List<SrmAchCopyrightAuthor> authorList = cList.getAuthorList();
		
		copyright.setCopyrightTypeName(DictTypeEnum.CopyrightType.getDictNameById(copyright.getCopyrightTypeId()));
		//学科门类
		copyright.setSubjectTypeName(DictTypeEnum.SubjectType.getDictNameById(copyright.getSubjectTypeId()));
		//所属单位
		copyright.setBelongOrgName(DictTypeEnum.OrgBelong.getDictNameById(copyright.getBelongOrgId()));
		//申报单位
		SysUser currUser = GlobalContext.getCurrentUser();
		copyright.setApplyOrgFlow(currUser.getOrgFlow());
		copyright.setApplyOrgName(currUser.getOrgName());
		//申请人信息
		copyright.setApplyUserFlow(currUser.getUserFlow());
		copyright.setApplyUserName(currUser.getUserName());
		//状态
		copyright.setOperStatusId(AchStatusEnum.Apply.getId());
		copyright.setOperStatusName(AchStatusEnum.Apply.getName());
		
		//---------------作者----------------
		//根据相关的ID枚举获取相对应的Name（作者类型、性别、学历、学位、职称）
		for(int i = 0; i < authorList.size(); i++){
			//authorList.get(i).setTypeName(DictTypeEnum.AuthorType.getDictNameById(authorList.get(i).getTypeId()));
			authorList.get(i).setSexName(UserSexEnum.getNameById(authorList.get(i).getSexId()));
			authorList.get(i).setEducationName(DictTypeEnum.UserEducation.getDictNameById(authorList.get(i).getEducationId()));
			authorList.get(i).setDegreeName(DictTypeEnum.UserDegree.getDictNameById(authorList.get(i).getDegreeId()));
			authorList.get(i).setTitleName(DictTypeEnum.UserTitle.getDictNameById(authorList.get(i).getTitleId()));
		}
		
		
		  //封装附件对象
	     SrmAchFile srmAchFile=new SrmAchFile();
	     if(file!=null && StringUtil.isNotBlank(file.getOriginalFilename())){
			 byte[] b = new byte[(int) file.getSize()]; 
			 file.getInputStream().read(b);
		     srmAchFile.setFileFlow(cList.getSrmAchFile().getFileFlow());
			 srmAchFile.setFileContent(b);
			 srmAchFile.setFileName(file.getOriginalFilename());
		     srmAchFile.setTypeId(AchTypeEnum.Copyright.getId());
		     srmAchFile.setTypeName(AchTypeEnum.Copyright.getName());
		     String[] nameArray=file.getOriginalFilename().split("\\.");
		     srmAchFile.setFileSuffix(nameArray[nameArray.length-1]);
		     srmAchFile.setFileType(nameArray[nameArray.length-1]);
	     }
	       //封装成果过程对象
	     SrmAchProcess srmAchProcess=new SrmAchProcess();
	     srmAchProcess.setTypeId(AchTypeEnum.Copyright.getId());
	     srmAchProcess.setTypeName(AchTypeEnum.Copyright.getName());
	     srmAchProcess.setOperateUserFlow(currUser.getUserFlow());
	     srmAchProcess.setOperateUserName(currUser.getUserName());
	     srmAchProcess.setOperStatusId(AchStatusEnum.Apply.getId());
	     srmAchProcess.setOperStatusName(AchStatusEnum.Apply.getName());
	     copyrightBiz.save(copyright, authorList, srmAchFile, srmAchProcess);
	     return GlobalConstant.SAVE_SUCCESSED;
	 }
	
	
	 @RequestMapping(value="/delCopyright",method=RequestMethod.GET)
	 @ResponseBody
	 public String delCopyright(String copyrightFlow){
		 if(StringUtil.isNotBlank(copyrightFlow)){
			 SrmAchCopyright copyright = new SrmAchCopyright();
			 copyright.setCopyrightFlow(copyrightFlow);
			 copyright.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			 //作者
			 SrmAchCopyrightAuthor author = new SrmAchCopyrightAuthor();
			 author.setCopyrightFlow(copyrightFlow);
			 List<SrmAchCopyrightAuthor> authorList = copyrightAuthorBiz.searchAuthorList(author);
			 for(SrmAchCopyrightAuthor cAuthor : authorList){
				 cAuthor.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			 }
			 //附件
			 SrmAchFile file = null;
			 List<SrmAchFile> fileList = srmAchFileBiz.searchSrmAchFile(copyrightFlow); 
	    	 if(fileList != null && !fileList.isEmpty()){
		 		file = fileList.get(0);
		 		file.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
	    	 }
	    	 int result = copyrightBiz.edit(copyright, authorList, file);
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
			SrmAchCopyrightAuthor author = new SrmAchCopyrightAuthor();
			author.setAuthorFlow(authorFlow);
			author.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			copyrightAuthorBiz.editAuthor(author);
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
}
