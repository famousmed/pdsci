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
import com.pinde.sci.biz.srm.IAchSatAuthorBiz;
import com.pinde.sci.biz.srm.ISatBiz;
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
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchSat;
import com.pinde.sci.model.mo.SrmAchSatAuthor;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmAchSatAuthorList;
/**
 * 
 * @author tiger
 *
 */
@Controller
@RequestMapping("/srm/ach/sat")
public class AchSatController extends GeneralController{
	
	
	 @Autowired
	 private ISatBiz satBiz;
	 @Autowired
	 private IAchSatAuthorBiz satAuthorBiz;
	 @Autowired
	 private ISrmAchFileBiz srmAchFileBiz;
	 @Autowired
	 private ISrmAchProcessBiz srmAchProcessBiz;
	 @Autowired
	 private IOrgBiz orgBiz;
	 
	 /**
	  * 保存论文及作者
	  * @param aList
	  * @param request
	  * @return
	 * @throws IOException 
	  */
	 @RequestMapping(value={"/save"})
	 @ResponseBody
	 public String save(String jsondata, MultipartFile file, HttpServletRequest request) throws IOException{
		 
		 SrmAchSatAuthorList aList = JSON.parseObject(jsondata, SrmAchSatAuthorList.class);
		 
		 SrmAchSat sat = aList.getSat();
		 List<SrmAchSatAuthor> authorList = aList.getAuthorList();
		 //-----枚举：根据相关的ID获得name-----
		 sat.setAchTypeName(DictTypeEnum.AchType.getDictNameById(sat.getAchTypeId()));
		 sat.setPrizedGradeName(DictTypeEnum.PrizedGrade.getDictNameById(sat.getPrizedGradeId()));
		 sat.setPrizedLevelName(DictTypeEnum.PrizedLevel.getDictNameById(sat.getPrizedLevelId()));
		 sat.setCategoryName(DictTypeEnum.SubjectType.getDictNameById(sat.getCategoryId()));
		 //所属单位
		 sat.setOrgBelongName(DictTypeEnum.OrgBelong.getDictNameById(sat.getOrgBelongId()));
		 
		 sat.setOperStatusId(AchStatusEnum.Apply.getId());
		 sat.setOperStatusName(AchStatusEnum.Apply.getName());
		 //获取申请单位信息
   	     SysUser currUser = GlobalContext.getCurrentUser();
   	     sat.setApplyOrgFlow(currUser.getOrgFlow());
   	     sat.setApplyOrgName(currUser.getOrgName());
   	     sat.setApplyUserFlow(currUser.getUserFlow());
   	     sat.setApplyUserName(currUser.getUserName());
		 
		 //根据科技作者相关的ID枚举获得相对应的Name（性别、学历、职称）
		 for(int i = 0; i<authorList.size();i++){
			// authorList.get(i).setTypeName(DictTypeEnum.AuthorType.getDictNameById(authorList.get(i).getTypeId()));
			 authorList.get(i).setSexName(UserSexEnum.getNameById(authorList.get(i).getSexId()));
			 authorList.get(i).setEducationName(DictTypeEnum.UserEducation.getDictNameById(authorList.get(i).getEducationId()));
			 authorList.get(i).setTitleName(DictTypeEnum.UserTitle.getDictNameById(authorList.get(i).getTitleId()));
			 authorList.get(i).setDegreeName(DictTypeEnum.UserDegree.getDictNameById(authorList.get(i).getDegreeId()));
		 }
		 
		 SrmAchFile srmAchFile = null;
		 if(file != null && StringUtil.isNotBlank(file.getOriginalFilename())){
		     //封装附件对象
	         srmAchFile = new SrmAchFile();
		     byte[] bytes = new byte[(int)file.getSize()]; 
		     file.getInputStream().read(bytes);
		     
	         srmAchFile.setFileFlow(aList.getSrmAchFile().getFileFlow());
		     srmAchFile.setFileContent(bytes);
		     srmAchFile.setFileName(file.getOriginalFilename());
		     
	         srmAchFile.setTypeId(AchTypeEnum.Sat.getId());
	         srmAchFile.setTypeName(AchTypeEnum.Sat.getName());
	         
	         String[] nameArray = file.getOriginalFilename().split("\\.");
		     srmAchFile.setFileSuffix(nameArray[nameArray.length-1]);
		     srmAchFile.setFileType(nameArray[nameArray.length-1]);
	   	  }
	       //封装成果过程对象
	       SrmAchProcess srmAchProcess=new SrmAchProcess();
	       
	       srmAchProcess.setTypeId(AchTypeEnum.Sat.getId());
	       srmAchProcess.setTypeName(AchTypeEnum.Sat.getName());
	       
	       srmAchProcess.setOperateUserFlow(currUser.getUserFlow());
	       srmAchProcess.setOperateUserName(currUser.getUserName());
	       
	       srmAchProcess.setOperStatusId(AchStatusEnum.Apply.getId());
	       srmAchProcess.setOperStatusName(AchStatusEnum.Apply.getName());
	       
	       int reslut = satBiz.save(sat, authorList, srmAchFile, srmAchProcess); 
	       if(reslut == GlobalConstant.ONE_LINE){
	    	   return GlobalConstant.SAVE_SUCCESSED;
	       }
	       return GlobalConstant.SAVE_FAIL;
	 }
	 
	 
	 @RequestMapping(value="/submitAudit",method={RequestMethod.GET})
	 @ResponseBody
	 public String submitAudit(@RequestParam(value="satFlow", required = true)String satFlow, Model model){
		 if(StringUtil.isNotBlank(satFlow)){
		 	SrmAchSat sat = satBiz.readSat(satFlow);
		 	sat.setOperStatusId(AchStatusEnum.Submit.getId());
	 		sat.setOperStatusName(AchStatusEnum.Submit.getName());
	 		
	 		SrmAchProcess process=srmAchProcessBiz.searchAchProcess(satFlow, AchStatusEnum.Apply.getId()).get(0);
	 		process.setProcessFlow(PkUtil.getUUID());
	 		process.setOperStatusId(AchStatusEnum.Submit.getId());
	 		process.setOperStatusName(AchStatusEnum.Submit.getName());
	 		GeneralMethod.setRecordInfo(process, true);
	 		process.setOperateTime(process.getCreateTime());
	 		
	 		SysUser currUser = GlobalContext.getCurrentUser();
	 		process.setOperateUserFlow(currUser.getUserFlow());
	 		process.setOperateUserName(currUser.getUserName());
	 		
	 		int result = satBiz.updateSatStatus(sat, process);
	 		if(result == GlobalConstant.ONE_LINE){
	 			return GlobalConstant.OPRE_SUCCESSED_FLAG;
 			}
	 	}
	 	return GlobalConstant.OPRE_FAIL_FLAG;
 	 }
	 
	 
	 //删除科技作者
	 @RequestMapping(value="/deleteAuthor",method={RequestMethod.GET})
	 @ResponseBody
	 public String deleteAuthor(String authorFlow){
		 if(StringUtil.isNotBlank(authorFlow)){
			 SrmAchSatAuthor author = new SrmAchSatAuthor();
			 author.setAuthorFlow(authorFlow);
			 author.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			 int result = satAuthorBiz.editSatAuthor(author);
			 if(result == GlobalConstant.ONE_LINE){
				 return GlobalConstant.DELETE_SUCCESSED;
			 }
		 }
		 return GlobalConstant.DELETE_FAIL;
	 }
	 
	
	 /**
	  * 加载科技列表
	  * @param achSat
	  * @param model
	  * @return
	  */
	 @RequestMapping(value="/list",method={RequestMethod.GET,RequestMethod.POST})
     public String list(SrmAchSat sat,Integer currentPage,HttpServletRequest request, Model model){
		 
		 SysUser currUser = GlobalContext.getCurrentUser();
		 sat.setApplyUserFlow(currUser.getUserFlow());
		 
		 PageHelper.startPage(currentPage, getPageSize(request));
		 
    	 List<SrmAchSat> satList=satBiz.search(sat, null);
    	 
    	 Map<String,List<SrmAchSatAuthor>> allAuthorMap = new LinkedHashMap<String, List<SrmAchSatAuthor>>();
    	 List<SrmAchSatAuthor> allAuthorList  = satAuthorBiz.searchAuthorList(new SrmAchSatAuthor());
    	 for(SrmAchSatAuthor a : allAuthorList){
    		 List<SrmAchSatAuthor> list =  allAuthorMap.get(a.getSatFlow());
    		 if(list == null){
    			 list = new ArrayList<SrmAchSatAuthor>();
    		 }
    		 list.add(a);
    		 allAuthorMap.put(a.getSatFlow(), list);
    	 }
    	 model.addAttribute("satList",satList);
    	 model.addAttribute("allAuthorMap", allAuthorMap);
		 return "srm/ach/sat/list";
     }
	 
	 /**
	  * 编辑科技信息
	  * @param satFlow
	  * @param author
	  * @param model
	  * @return
	  */
	 @RequestMapping(value="/edit",method=RequestMethod.GET)
     public String edit(String satFlow, Model model){
		 SrmAchFile file = null;
		 List<SrmAchFile> fileList = null;
		 if(StringUtil.isNotBlank(satFlow)){
			 SrmAchSat sat=satBiz.readSat(satFlow);
			 model.addAttribute("sat", sat);
			 //查询科技作者信息
	    	 SrmAchSatAuthor author = new SrmAchSatAuthor();
	    	 author.setSatFlow(satFlow);
			 List<SrmAchSatAuthor> satAuthorList=satAuthorBiz.searchAuthorList(author);
			 model.addAttribute("satAuthorList",satAuthorList);
			 fileList = srmAchFileBiz.searchSrmAchFile(satFlow);
			 if(null != fileList && !fileList.isEmpty()){
				 file = fileList.get(0);
			 }
	     }
	     model.addAttribute("file", file);
    	 return "srm/ach/sat/edit";
     }
	 
	 
	 @RequestMapping(value="/auditList/{scope}",method={RequestMethod.POST,RequestMethod.GET})
	 public String auditList(@PathVariable String scope, String currentPage, SrmAchSat sat, SrmAchSatAuthor author, SysOrg org, Model model, HttpServletRequest request){
		 SysUser currUser = GlobalContext.getCurrentUser();
		 List<SrmAchSat> searchList=null;
    	 List<SrmAchSat> satList=null;
    	 //查询当前机构下属所有级别子机构包含自身
    	 List<SysOrg> currOrgChildList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
    	 //根据orgFlow和chargeOrgFlow查询包含子机构列表和子机构的子机构的列表的Map
    	 Map<String,List<SysOrg>> resultMap=orgBiz.searchChargeAndApply(org,scope);
    	 //获取当前机构下属一级的机构
    	 List<SysOrg> firstGradeOrgList=(List<SysOrg>) resultMap.get("firstGradeOrgList");
    	 model.addAttribute("firstGradeOrgList", firstGradeOrgList);
		 if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(scope)){
			//设置查询条件：科技处审核通过的成果
	     		sat.setOperStatusId(AchStatusEnum.FirstAudit.getId()); 
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
			   		    searchList = satBiz.search(sat,selfOrgList);
		   		    }else{
			   		    searchList = satBiz.search(sat,secondGradeOrgList);
		   		    }
	 			}
			 	
		 }else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(scope)){
			 sat.setOperStatusId(AchStatusEnum.FirstAudit.getId()); 
		 }else{
			 //审核状态： 审核通过、待审核、全部
			 if(StringUtil.isBlank(sat.getOperStatusId())){
				 sat.setOperStatusId(AchStatusEnum.Submit.getId());
			 }
			 if(GlobalConstant.FLAG_Y.equals(sat.getOperStatusId())){
				 sat.setOperStatusId(AchStatusEnum.Submit.getId()+","+AchStatusEnum.FirstAudit.getId());
			 }
		 }
		//如果查询条件orgFlow不为空，则查询该org下所有成果
    	 if(StringUtil.isNotBlank(org.getOrgFlow())){
    		 sat.setApplyOrgFlow(org.getOrgFlow());
	   		 searchList = satBiz.search(sat, null);
	     }
    	 //如果查询条件orgFlow和chargeOrgFlow都为空，那么查询当前登录者下所有成果
    	 if(StringUtil.isBlank(org.getOrgFlow()) && StringUtil.isBlank(org.getChargeOrgFlow())){
	   		 searchList = satBiz.search(sat, currOrgChildList);
    	 }
		 
    	 Map<String, List<SrmAchSatAuthor>> allAuthorMap = new HashMap<String, List<SrmAchSatAuthor>>();
	    	 List<SrmAchSatAuthor> satAuthorList = satAuthorBiz.searchAuthorList(new SrmAchSatAuthor());
	    	 if(satAuthorList != null && !satAuthorList.isEmpty()){
	    		 for(SrmAchSatAuthor a : satAuthorList){
	    			 List<SrmAchSatAuthor> authorList = allAuthorMap.get(a.getSatFlow());
	    			 if(authorList == null){
	    				 authorList = new ArrayList<SrmAchSatAuthor>();
	    			 }
	    			 authorList.add(a);
	    			 allAuthorMap.put(a.getSatFlow(), authorList);
	    		 }
	    	 }			
	    		
		//过滤
		if(StringUtil.isNotBlank(author.getAuthorName())){ 
			satList = new ArrayList<SrmAchSat>();
			for(SrmAchSat b : searchList){
				boolean addFlag = false;
				List<SrmAchSatAuthor> authorByNameList = allAuthorMap.get(b.getSatFlow());
				if(authorByNameList != null){
    				for(SrmAchSatAuthor na : authorByNameList){
    					if(na.getAuthorName().equals(author.getAuthorName())){
    						addFlag = true;
    						break;
    					}
    				}
				}
				if(addFlag){
					satList.add(b);
				}
			}
		}else {
			satList = searchList;
		}
		 model.addAttribute("satList", satList);
		 model.addAttribute("allAuthorMap", allAuthorMap);
		 return "srm/ach/sat/auditList"+scope;
	 }
	 
	 
	 /**
	  * 跳转到审核界面
	  * @param satFlow
	  * @param model
	  * @return
	  */
	 @RequestMapping("/audit")
	 public String audit(@RequestParam(value="satFlow", required=true)String satFlow, Model model){
		//根据成果流水号查询相关信息，用于加载审核页面 
		 SrmAchFile file = null;
		 List<SrmAchFile> fileList=null;
		if(StringUtil.isNotBlank(satFlow)){
			//查询成果本身
			SrmAchSat sat=satBiz.readSat(satFlow);
			model.addAttribute("sat", sat);
			//查询成果作者
			SrmAchSatAuthor author = new SrmAchSatAuthor();
	    	author.setSatFlow(satFlow);
		    List<SrmAchSatAuthor> satAuthorList=satAuthorBiz.searchAuthorList(author);
			model.addAttribute("satAuthorList", satAuthorList);
			//查询成果附件
		    fileList=srmAchFileBiz.searchSrmAchFile(satFlow);  
		  if(fileList!=null && !fileList.isEmpty()){
		    file=fileList.get(0);
		    model.addAttribute("file", file);
		   }
		}
		 SrmAchSat sat=satBiz.readSat(satFlow);
	 	model.addAttribute("sat", sat);
	 	return "srm/ach/sat/audit";
	 }
	 
	 /**
	  * 保存审核结果
	  * @param agreeFlag
	  * @param auditContent
	  * @param satFlow
	  * @param model
	  * @return
	  */
	 @RequestMapping(value="/saveAudit",method={RequestMethod.POST})
 	 @ResponseBody
 	 public String saveAudit(@RequestParam(value="agreeFlag", required=true)String agreeFlag,String auditContent,
 			                @RequestParam(value="satFlow", required=true)String satFlow,Model model){
	     SrmAchSat sat=satBiz.readSat(satFlow);
	     SrmAchProcess process=srmAchProcessBiz.searchAchProcess(satFlow, AchStatusEnum.Apply.getId()).get(0);

	     if(agreeFlag.equals(GlobalConstant.FLAG_Y)){
	    	 sat.setOperStatusId(AchStatusEnum.FirstAudit.getId());
	    	 sat.setOperStatusName(AchStatusEnum.FirstAudit.getName());
 			 process.setOperStatusId(AchStatusEnum.FirstAudit.getId());
 			 process.setOperStatusName(AchStatusEnum.FirstAudit.getName());
 		 }
 		 else{
 			 sat.setOperStatusId(AchStatusEnum.RollBack.getId());
		 	 sat.setOperStatusName(AchStatusEnum.RollBack.getName());
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
 	     satBiz.updateSatStatus(sat, process);
 		 return GlobalConstant.OPERATE_SUCCESSED;
 	 }
	 
	 /**
	  * 删除科技信息
	  * @param achSat
	  * @return
	  */
	 @RequestMapping(value="/delete",method=RequestMethod.GET)
	 @ResponseBody
	 public String delete(String satFlow){
		 if(StringUtil.isNotBlank(satFlow)){
			 SrmAchSat sat = new SrmAchSat();
			 sat.setSatFlow(satFlow);
			 sat.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			 
			 SrmAchSatAuthor temp = new SrmAchSatAuthor();
			 temp.setSatFlow(satFlow);
			 List<SrmAchSatAuthor> authorList = satAuthorBiz.searchAuthorList(temp);
			 for(SrmAchSatAuthor author : authorList){
				 author.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			 }
			 
			 SrmAchFile file = null;
			 List<SrmAchFile> fileList = srmAchFileBiz.searchSrmAchFile(satFlow); 
	    	 if(fileList != null && !fileList.isEmpty()){
	    		 file = fileList.get(0);
	    		 file.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
	    	 }

			 int result = satBiz.edit(sat, authorList, file);
			 if(result == GlobalConstant.ONE_LINE){
				 return GlobalConstant.DELETE_SUCCESSED;
			 }
		 }
		 return GlobalConstant.DELETE_FAIL;
	 }
}
