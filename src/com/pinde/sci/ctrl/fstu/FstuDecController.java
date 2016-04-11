package com.pinde.sci.ctrl.fstu;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.fstu.IFstuCreditBiz;
import com.pinde.sci.biz.fstu.IFstuProjBiz;
import com.pinde.sci.biz.fstu.IFstuStudyBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.fstu.DeclarationResultEnum;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.FstuCredit;
import com.pinde.sci.model.mo.FstuProj;
import com.pinde.sci.model.mo.FstuStudy;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/fstu/dec")
public class FstuDecController extends GeneralController{
	@Resource
	private IFstuProjBiz fstuProjBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Resource
	private IFstuStudyBiz fstuStudyBiz;
	@Resource
	private IUserBiz userBiz;
	@Resource
	private IFstuCreditBiz fstuCreditBiz;
	
	/**
	 * FstuProj查询
	 * @param model
	 * @param proj
	 * @return
	 */
	@RequestMapping(value="/projList/{roleFlag}")
	public String projList(@PathVariable String roleFlag,Model model,FstuProj proj,Integer currentPage,HttpServletRequest request){
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		model.addAttribute("roleFlag", roleFlag);
		List<FstuProj> projList=null;
		if(GlobalConstant.USER_LIST_CHARGE.equals(roleFlag)){
			projList=fstuProjBiz.search(proj);
		}else{
			SysUser user = GlobalContext.getCurrentUser();
			String userOrgFlow= user.getOrgFlow();
			proj.setOrgFlow(userOrgFlow);
			projList=fstuProjBiz.search(proj);
		}
		model.addAttribute("projList", projList);
		return "/fstu/dec/proj/projList";
	}
	/**
	 * FstuProj编辑
	 * @param flow
	 * @param model
	 * @return
	 */
	@RequestMapping("/add")
	public String add(String flow,Model model){
		if(StringUtil.isNotBlank(flow)){
			FstuProj proj=fstuProjBiz.findByFlow(flow);
			model.addAttribute("proj", proj);
			PubFile file=fileBiz.readFile(proj.getDeclarationFormFlow());
			model.addAttribute("file", file);
		}
		return "/fstu/dec/proj/edit";
	}
	@RequestMapping("/save")
	@ResponseBody
	public String save(FstuProj proj,@RequestParam(value="file",required=false) MultipartFile file) throws IOException{
		String success = GlobalConstant.SAVE_SUCCESSED;
		String fail = GlobalConstant.SAVE_FAIL;
		if(GlobalConstant.RECORD_STATUS_N.equals(proj.getRecordStatus())){
			success = GlobalConstant.DELETE_SUCCESSED;
			fail = GlobalConstant.DELETE_FAIL;
		}
		if(StringUtil.isNotBlank(proj.getDeclarationResultId())){
			proj.setDeclarationResultName(DeclarationResultEnum.getNameById(proj.getDeclarationResultId()));
		}
		if(StringUtil.isNotBlank(proj.getProjLevelId())){
			proj.setProjLevelName(DictTypeEnum.FstuType.getDictNameById(proj.getProjLevelId()));
		}
		int projFlow=fstuProjBiz.saveProjAndFile(proj,file);
		if(projFlow==GlobalConstant.ZERO_LINE){
			return fail;
		}else{
			return success;
		}
	}
	
	@RequestMapping("/delPro")
	@ResponseBody
	public String delPro(FstuProj proj){
		int result=fstuProjBiz.save(proj);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
	/**
	 * fstuStudy查询
	 * @param roleFlag
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/fstuStudy/{roleFlag}")
	public String fstuStudy(@PathVariable String roleFlag,SysUser user,Model model,Integer currentPage,HttpServletRequest request){
		
		model.addAttribute("roleFlag", roleFlag);
		List<SysUser> userList=null; 
		List<String> auditList=null;
		//判断是否是卫生局
		if(GlobalConstant.USER_LIST_CHARGE.equals(roleFlag)){
			userList=userBiz.searchUser(user);
			auditList=new ArrayList<String>();
			auditList.add(AchStatusEnum.Submit.getId());
			auditList.add(AchStatusEnum.FirstAudit.getId());
		}else{
			SysUser sysUser = GlobalContext.getCurrentUser();
			String userOrgFlow= sysUser.getOrgFlow();
			user.setOrgFlow(userOrgFlow);
			userList=userBiz.searchUser(user);
		}
		if(userList!=null&& !userList.isEmpty()){
			Map<String, SysUser> sysUserMap = new HashMap<String, SysUser>();
			List<String> flowList=new ArrayList<String>();
			for(SysUser s:userList){
				String userFlow=s.getUserFlow();
				sysUserMap.put(userFlow, s);
				flowList.add(userFlow);
			}
			if(currentPage==null){
				currentPage=1;
			}
			PageHelper.startPage(currentPage,getPageSize(request));
			model.addAttribute("sysUserMap", sysUserMap);
			List<FstuStudy> studyList=fstuStudyBiz.searchByUserFlows(flowList,auditList);
			model.addAttribute("studyList", studyList);
		}
		return "/fstu/dec/study/list";
	}
	/**
	 * 编辑
	 * @param flow
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit")
	public String edit(String flow,Model model){
		String userFlow = "";
		if(StringUtil.isNotBlank(flow)){
			FstuStudy study=fstuStudyBiz.findByFlow(flow);
			if(study!=null){
				userFlow = study.getUserFlow();
				model.addAttribute("study", study);
			}
		}
		SysUser currUser=GlobalContext.getCurrentUser();
		List<FstuStudy> studyList = fstuStudyBiz.searchStudys();
		List<String> userFlows = new ArrayList<String>();
		if(studyList!=null && studyList.size()>0){
			for(FstuStudy stu : studyList){
				String studyUserFlow = stu.getUserFlow();
				if(!studyUserFlow.equals(userFlow)){
					userFlows.add(studyUserFlow);
				}
			}
		}
		List<SysUser> userList=userBiz.searchUserNotInUserFlows(currUser.getOrgFlow(),userFlows);
		model.addAttribute("userList", userList);
		return "/fstu/dec/study/edit";
	}
	/**
	 * 
	 * @param study
	 * @return
	 */
	@RequestMapping("/saveStudy")
	@ResponseBody
	public String save(FstuStudy study){
		
		String success = GlobalConstant.SAVE_SUCCESSED;
		String fail = GlobalConstant.SAVE_FAIL;
		if(GlobalConstant.RECORD_STATUS_N.equals(study.getRecordStatus())){
			success = GlobalConstant.DELETE_SUCCESSED;
			fail = GlobalConstant.DELETE_FAIL;
		}
		if(StringUtil.isNotBlank(study.getAuditStatusId())){
			success = GlobalConstant.OPRE_SUCCESSED;
			fail = GlobalConstant.OPRE_FAIL;
		}
		if(StringUtil.isNotBlank(study.getAuditStatusId())){
			study.setAuditStatusName(AchStatusEnum.getNameById(study.getAuditStatusId()));
		}
		String userFlow = study.getUserFlow();
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user = userBiz.readSysUser(userFlow);
			if(user!=null){
				study.setUserName(user.getUserName());
				study.setOrgFlow(user.getOrgFlow());
				study.setOrgName(user.getOrgName());
			}
		}
		int studyFlow=fstuStudyBiz.saveOrEdit(study);
		if(studyFlow==GlobalConstant.ZERO_LINE){
			return fail;
		}else{
			return success;
		}
	}
	/**
	 * 自动读值
	 * @param userFlow
	 * @return
	 */
	@RequestMapping(value="/readUser",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public SysUser readUser(String userFlow){
		SysUser user = userBiz.readSysUser(userFlow);
		return user;
	}
	/**
	 * SysUser查询
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping("/creditList/{roleFlag}")
	public String userList(@PathVariable String roleFlag,SysUser user,Model model,Integer currentPage,HttpServletRequest request){
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		model.addAttribute("roleFlag", roleFlag);
		List<SysUser> userList=null;
		if(GlobalConstant.USER_LIST_CHARGE.equals(roleFlag)){
			userList=userBiz.searchUser(user);
		}else{
			SysUser currsysUser = GlobalContext.getCurrentUser();
			String userOrgFlow= currsysUser.getOrgFlow();
			user.setOrgFlow(userOrgFlow);
			userList=userBiz.searchUser(user);
		}
		model.addAttribute("userList", userList);
		return "/fstu/dec/credit/list";
	}
	
	@RequestMapping("/editCredit")
	public String editCredit(String userFlow,Model model){
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user=userBiz.readSysUser(userFlow);
			model.addAttribute("user", user);
			List<FstuCredit> credit=fstuCreditBiz.searchCreditByUserFlow(userFlow);
			model.addAttribute("credit", credit);
		}
		return "/fstu/dec/credit/edit";
	}
	@RequestMapping("/saveCredit")
	@ResponseBody
	public String saveCredit(@RequestBody List<FstuCredit> credits){
		
		int result=fstuCreditBiz.saveCreditList(credits);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping("/delCredit")
	@ResponseBody
	public String delCredit(FstuCredit credit){
		int result=fstuCreditBiz.edit(credit);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
}