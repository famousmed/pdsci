package com.pinde.sci.ctrl.irb;


import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbCfgBiz;
import com.pinde.sci.biz.irb.IIrbInfoBiz;
import com.pinde.sci.biz.irb.IIrbMeetingBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.IIrbResearcherBiz;
import com.pinde.sci.biz.irb.IIrbSecretaryBiz;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubProjUserBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.JspFormUtil;
import com.pinde.sci.enums.gcp.GcpProjSubTypeEnum;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.RoleLevelEnum;
import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.sys.SysUserForm;
import com.pinde.sci.model.irb.ApplyFileTemp;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.irb.ProjOrgForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbMeeting;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubProjUserExt;

@Controller
@RequestMapping("/irb/researcher")
public class IrbResearcherController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(IrbResearcherController.class);
	@Autowired
	private IIrbResearcherBiz researcherBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IIrbCfgBiz irbCfgBiz;
	@Autowired
	private IIrbRecBiz irbRecBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IIrbInfoBiz irbInfoBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IPubProjUserBiz projUserBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IProjUserBiz pjUserBiz;
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IIrbUserBiz irbUserBiz;
	@Autowired
	private IIrbSecretaryBiz secretaryBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IIrbMeetingBiz irbMeetingBiz;
	
	@RequestMapping(value={"/index"},method={RequestMethod.GET})
	public String index(Model model){
		List<IrbApply> irbList = irbApplyBiz.searchIrbList(GlobalContext.getCurrentUser().getUserFlow());
		Map<String,Integer> countMap = new HashMap<String, Integer>();
		Integer initCount = 0;
		Integer followCount = 0;
		Integer SaeCount = 0;
		Integer finishCount = 0;
		List<IrbApply> unReviewIrbs = new ArrayList<IrbApply>();
		List<IrbApply> receiveIrbs = new ArrayList<IrbApply>();
		List<IrbApply> withdrawnIrbs = new ArrayList<IrbApply>();
		List<IrbApply> archiveIrbs = new ArrayList<IrbApply>();
		List<IrbApply> trackIrbs = new ArrayList<IrbApply>();
		if(irbList != null){
			for(IrbApply apply : irbList){
				if(apply.getIrbTypeId().equals(IrbTypeEnum.Init.getId())){
					initCount++;
				}else {
					followCount++;
				}
				if(apply.getIrbTypeId().equals(IrbTypeEnum.Sae.getId())){
					SaeCount++;
				}
				if(apply.getIrbTypeId().equals(IrbTypeEnum.Finish.getId())){
					finishCount++;
				}
				
				//补充修改通知提醒
				if(IrbStageEnum.Apply.getId().equals(apply.getIrbStageId())){ 
					try {
						if(irbRecBiz.checkNotice(apply.getIrbFlow(),GlobalConstant.FLAG_Y)){
							withdrawnIrbs.add(apply);
						}
					} catch (Exception e) {
					}
				}
				//已受理未审查
				if(StringUtil.isNotBlank(apply.getIrbNo())&&IrbStageEnum.Handle.getId().equals(apply.getIrbStageId())){
					receiveIrbs.add(apply);
				}
				//已上会，未审查 提醒
				if(StringUtil.isNotBlank(apply.getMeetingFlow()) && StringUtil.isBlank(apply.getIrbDecisionId())){ 
					unReviewIrbs.add(apply);
				}
				//传达决定项目提醒
				if(IrbStageEnum.Archive.getId().equals(apply.getIrbStageId())){
					archiveIrbs.add(apply);
				}
				//跟踪审查提醒
				if(StringUtil.isNotBlank(apply.getTrackDate())){
					String trackRemaind =  InitConfig.getSysCfg("irb_track_remaind");
					if(StringUtil.isBlank(trackRemaind)){ 
						trackRemaind = GlobalConstant.IRB_DEFAULT_TRACK_REMAIND;
					}
					if(DateUtil.signDaysBetweenTowDate(apply.getTrackDate(),DateUtil.getCurrDate())<Integer.parseInt(trackRemaind)
							&& DateUtil.signDaysBetweenTowDate( apply.getTrackDate(),DateUtil.getCurrDate())>0)
							{
						trackIrbs.add(apply);
					}
				}
			}
		}
		
		countMap.put("initCount", initCount);
		countMap.put("followCount", followCount);
		countMap.put("SaeCount", SaeCount);
		countMap.put("finishCount", finishCount);
		model.addAttribute("countMap", countMap);
		
		
		model.addAttribute("withdrawnIrbs", withdrawnIrbs);
		model.addAttribute("receiveIrbs", receiveIrbs);
		model.addAttribute("unReviewIrbs", unReviewIrbs);
		model.addAttribute("archiveIrbs", archiveIrbs);
		model.addAttribute("trackIrbs", trackIrbs);
		return "irb/view/researcher";
	}
	
	
	@RequestMapping(value={"/list/{roleScope}"},method={RequestMethod.GET,RequestMethod.POST})
	public String myirb(@PathVariable String roleScope,String currentPage ,PubProj proj,String deptFlow,
			String quickDatePickType,String submitFlag,String sourse,String lastMeeting,Model model){
		
		String jsp = "irb/researcher/list";
		List<PubProj> projList = new ArrayList<PubProj>();
		Map<String,List<IrbApply>> projIrbMap = new HashMap<String, List<IrbApply>>();
		List<IrbApply> irbList = irbApplyBiz.queryIrbApply(new IrbApply());
		if(irbList!=null && irbList.size()>0){
			for(IrbApply irb : irbList){
				List<IrbApply> temp = projIrbMap.get(irb.getProjFlow());
				if(temp == null){
					temp = new ArrayList<IrbApply>();
				}
				temp.add(irb);
				projIrbMap.put(irb.getProjFlow(), temp);
			}
		}
		if(GlobalConstant.USER_LIST_LOCAL.equals(roleScope)){
			proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			proj.setApplyUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			projList = researcherBiz.searchProjList(proj);
		}else if(GlobalConstant.USER_LIST_GLOBAL.equals(roleScope)){
			if (!"init".equals(sourse)) {
				proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
				if(StringUtil.isNotBlank(deptFlow)){
					proj.setApplyDeptFlow(deptFlow);
				}
				List<PubProj> projTempList = researcherBiz.searchProjList(proj);
				if(StringUtil.isNotBlank(quickDatePickType)){  
					if(projTempList!=null && projTempList.size()>0){
						String currMonth =  DateUtil.getCurrDateTime("MM");
						for(PubProj temp : projTempList){
							List<IrbApply> irbTempList  = projIrbMap.get(temp.getProjFlow());
							if(irbTempList != null ){ 
								for(IrbApply apply : irbTempList){
									String applyMonth = DateUtil.transDateTime(apply.getIrbApplyDate(),"yyyy-MM-dd","MM");
									String acceptedMonth = DateUtil.transDateTime(apply.getIrbAcceptedDate(),"yyyy-MM-dd","MM");
									if((isApplyStage(apply)||currMonth.equals(applyMonth)|| currMonth.equals(acceptedMonth)
											)&& !projList.contains(temp)){
										projList.add(temp);
									}
								}
							}
						}
					}
				} else if ("lastMeeting".equals(lastMeeting)) {
					List<IrbMeeting> mList = this.irbMeetingBiz.searchIrbMeeting();
					if (mList != null) {
						IrbMeeting meeting = mList.get(mList.size()-1);
						String meetingDate = meeting.getMeetingDate();
						IrbApply irbApply = new IrbApply();
						irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						irbApply.setMeetingFlow(meeting.getMeetingFlow());
						List<IrbApply> list = this.irbApplyBiz.searchIrbs(irbApply);
						List<String> projFlowList = new ArrayList<String>();
						if (list != null && list.size() > 0) {
							for (IrbApply irb:list) {
								String projFlow = irb.getProjFlow();
								if (!projFlowList.contains(projFlow)) {
									projFlowList.add(projFlow);
									PubProj project = this.projBiz.readProjectNoBlogs(projFlow);
									projList.add(project);
								}
							}
						}
						model.addAttribute("meetingDate",meetingDate);
					}
				} else {
					projList.addAll(projTempList);
				}
			}
			
			SysDept sysDept = new SysDept();
			String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			sysDept.setOrgFlow(orgFlow);
			List<SysDept> sysDeptList = deptBiz.searchDept(sysDept);
			model.addAttribute("sysDeptList",sysDeptList);
			
			jsp = "irb/secretary/apply/list";
		}
		getIrbDateMap(model, projList,projIrbMap);
		model.addAttribute("projList", projList);
		model.addAttribute("roleScope", roleScope);
		return jsp;
	}
	
	private boolean isApplyStage(IrbApply apply){
		 if( IrbTypeEnum.Init.getId().equals(apply.getIrbTypeId())&& IrbStageEnum.Apply.getId().equals(apply.getIrbStageId())){
			 return true;
		 }
		return false;
	}
	
	private void getIrbDateMap(Model model, List<PubProj> projList,Map<String,List<IrbApply>> projIrbMap) {
		Map<String,String> irbDateMap = new HashMap<String, String>();
		if(projList!=null && projList.size()>0){
			for(PubProj proj : projList){
				String approveDate  = "";
				String approveValidity  = "";
				String trackDate = "";
				List<IrbApply> irbList  = projIrbMap.get(proj.getProjFlow());
				if(irbList != null){
					for(IrbApply apply : irbList){
						if(StringUtil.isNotBlank(apply.getApproveDate())){
							approveDate = StringUtil.defaultString(apply.getApproveDate());
							approveValidity = StringUtil.defaultString(apply.getApproveValidity());
						}
						trackDate = StringUtil.defaultString(apply.getTrackDate());  //默认排序取最后一次覆盖允许为空
					}
				}
				irbDateMap.put(proj.getProjFlow(), approveDate+"_"+approveValidity+"_"+trackDate);
			}
			model.addAttribute("irbDateMap", irbDateMap);
		}
	}
	@RequestMapping(value={"/applyMain"},method={RequestMethod.GET})
	public String  applyMain(String projFlow,String irbFlow,String backType,Model model){
		if(StringUtil.isBlank(projFlow)){
			setSessionAttribute(GlobalConstant.CURR_IRB, null);
		}
		if(StringUtil.isNotBlank(irbFlow)){
			setSessionAttribute(GlobalConstant.CURR_IRB, irbApplyBiz.queryByFlow(irbFlow)); 
		}
		model.addAttribute("backType", backType);
		
		return "irb/researcher/applyMain";
	}
	
	@RequestMapping(value={"/projInfo"},method={RequestMethod.GET})
	public String  projInfo(String projFlow,Model model){
		List<SysDept> deptList = researcherBiz.searchSysDept(GlobalContext.getCurrentUser().getOrgFlow());
		model.addAttribute("deptList", deptList);
		if(StringUtil.isNotBlank(projFlow)){
			ProjInfoForm projInfoForm = researcherBiz.readProjInfoForm(projFlow);
			model.addAttribute("projInfoForm", projInfoForm);
		}
		IrbInfo info = new IrbInfo();
		info.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<IrbInfo> infoList = this.irbInfoBiz.queryInfo(info);
		if (infoList != null && infoList.size() > 0) {
			IrbInfo irbInfo = infoList.get(0);
			model.addAttribute("irbInfo", irbInfo);
		}
		String roleFlow = InitConfig.getSysCfg("researcher_role_flow");
		model.addAttribute("roleFlow", roleFlow);
		
		return "irb/researcher/projInfo";
	}
	
	@RequestMapping(value={"/projOrgList"},method={RequestMethod.GET})
	public String  projOrgList(String projFlow,ProjInfoForm projInfo,Model model){
		if(StringUtil.isNotBlank(projFlow)){
			List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("projOrgList", projOrgList);
		}
		return "irb/researcher/projOrgList";
	}
	
	@RequestMapping(value={"/userMain"},method={RequestMethod.GET,RequestMethod.POST})
	public String  userMain(String deptFlow, SysUser search,String type,Model model){
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);//当前apply
		String projFlow = "";
		String researcherFlow = "";
		if (curApply != null) {
			projFlow = curApply.getProjFlow();
			
			String roleFlow = InitConfig.getSysCfg("researcher_role_flow");
			PubProjUser pjUserSearch = new PubProjUser();
			pjUserSearch.setProjFlow(projFlow);
			pjUserSearch.setRoleFlow(roleFlow);
			List<PubProjUser> pjUserList = pjUserBiz.search(pjUserSearch);
			if (pjUserList !=  null && pjUserList.size()>0) {
				researcherFlow = pjUserList.get(0).getUserFlow();
			}
		}
		model.addAttribute("researcherFlow", researcherFlow);	
		
		PubProjUser pubProjUserSearch = new PubProjUser();
		if (StringUtil.isNotBlank(projFlow)) {
			pubProjUserSearch.setProjFlow(projFlow);
		}
		List<PubProjUser> pubProjUserList = pjUserBiz.search(pubProjUserSearch);
		Map<String,List<PubProjUser>> pubProjUserMap  = new HashMap<String, List<PubProjUser>>();
		for(PubProjUser pubProjUser : pubProjUserList){
			String userFlow = pubProjUser.getUserFlow();
			if(pubProjUserMap.containsKey(userFlow)){
				List<PubProjUser> list = pubProjUserMap.get(userFlow);
				list.add(pubProjUser);
			}else{
				List<PubProjUser> list = new ArrayList<PubProjUser>();
				list.add(pubProjUser);
				pubProjUserMap.put(userFlow, list);
			}
		}			
		model.addAttribute("pubProjUserMap", pubProjUserMap);	
		
		if (StringUtil.isNotBlank(type) && type.equals("search")) {
			model.addAttribute("userName", search.getUserName());
			model.addAttribute("deptFlow", search.getDeptFlow());
		} else {
			model.addAttribute("deptFlow", deptFlow);
			search.setDeptFlow(deptFlow);
		}
		
		//如果用户没有输入查询条件
		String temp = StringUtil.defaultString(search.getUserName())
				     +StringUtil.defaultString(search.getDeptFlow());
		if(StringUtil.isNotBlank(temp)){
			search.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			List<SysUser> sysUserList=userBiz.searchUser(search);
			model.addAttribute("sysUserList",sysUserList);
		}
		
		List<SysDept> deptList = researcherBiz.searchSysDept(GlobalContext.getCurrentUser().getOrgFlow());
		model.addAttribute("deptList", deptList);
		return "irb/researcher/userMain";
	}
	
	@RequestMapping(value={"/selResearcher"},method={RequestMethod.GET})
	@ResponseBody
	public String  selResearcher(String userFlow, Model model){
		SysUser user = userBiz.readSysUser(userFlow);
		String result = user.getUserName()+"_+_"+user.getUserPhone()+"_+_"+user.getUserEmail()+"_+_";
		return result;
	}
	
	@RequestMapping(value={"/relationDeptUser"},method={RequestMethod.GET})
	@ResponseBody
	public Object  relationDeptUser(String deptFlow,Model model){
		List<SysUser> userList = researcherBiz.searchSysUserByDept(deptFlow);
		return userList;
	}
	@RequestMapping(value={"/saveProj"},method={RequestMethod.POST})
	@ResponseBody
	public  synchronized String  saveProj(PubProj proj,ProjInfoForm projInfo,Model model){
		String projFlow = PkUtil.getUUID();
		if (StringUtil.isNotBlank(proj.getProjFlow())) {
			projFlow = proj.getProjFlow();
		}
		String projSubType = proj.getProjSubTypeId();
		if (StringUtil.isNotBlank(projSubType)) {
			proj.setProjSubTypeName(GcpProjSubTypeEnum.getNameById(projSubType));
		}
		if (StringUtil.isNotBlank(proj.getProjTypeId())) {
			proj.setProjTypeName(DictTypeEnum.GcpProjType.getDictNameById(proj.getProjTypeId()));
		}
		if (StringUtil.isNotBlank(proj.getApplyDeptFlow())) {
			proj.setApplyDeptName(InitConfig.getDeptNameByFlow(proj.getApplyDeptFlow()));
		}
		
		String projCategoryId = ProjCategroyEnum.Yw.getId();
		if( GcpProjSubTypeEnum.Ky.getId().equals(projSubType)){
			projCategoryId = ProjCategroyEnum.Ky.getId();
		}else if( GcpProjSubTypeEnum.Qx.getId().equals(projSubType)){
			projCategoryId = ProjCategroyEnum.Qx.getId();
		}
		
		proj.setProjCategoryId(projCategoryId);//项目分类
		proj.setProjCategoryName(ProjCategroyEnum.getNameById(projCategoryId));
		
		//保存主要研究者
		String researchFlow = projInfo.getResearcherFlow();
		String roleFlow = InitConfig.getSysCfg("researcher_role_flow");
		String oldApplyUserFlow = "";	//原主要研究者flow
		PubProj project = researcherBiz.readPubProj(projFlow);
		if (project != null) {
			oldApplyUserFlow = StringUtil.defaultString(project.getApplyUserFlow());
		}
		
		if (StringUtil.isNotBlank(researchFlow) && !researchFlow.equals(oldApplyUserFlow)) {
			//删除原主要研究者
			PubProjUser pjUser = null;
			PubProjUser pjUserSearch = new PubProjUser();
			pjUserSearch.setProjFlow(projFlow);
			pjUserSearch.setRoleFlow(roleFlow);
			pjUserSearch.setUserFlow(oldApplyUserFlow);
			List<PubProjUser> pjUserList = pjUserBiz.search(pjUserSearch);
			if (pjUserList !=  null && pjUserList.size()>0) {
				pjUser = pjUserList.get(0);
			}
			if (pjUser != null) {
				pjUserBiz.del(pjUser);
			}
			//新增主要研究者
			SysUser user = userBiz.readSysUser(researchFlow);
			if (user != null) {
				String userName = user.getUserName();
				proj.setApplyUserFlow(researchFlow);
				proj.setApplyUserName(userName);
				//保存至pub_proj_user表
				PubProjUser projUser = new PubProjUser();
				projUser.setRecordFlow(PkUtil.getUUID());
				projUser.setProjFlow(projFlow);
				projUser.setOrgFlow(user.getOrgFlow());
				projUser.setRoleFlow(roleFlow);
				projUser.setUserFlow(user.getUserFlow());
				projUser.setAuthUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				projUser.setAuthTime(DateUtil.getCurrDateTime());
				GeneralMethod.setRecordInfo(proj, true);
				pjUserBiz.add(projUser);
			}
		}
		
		if(StringUtil.isBlank(proj.getProjFlow())){
			proj.setProjFlow(projFlow);
			//与研究者肯定隶属同一机构
			proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			proj.setApplyOrgName(GlobalContext.getCurrentUser().getOrgName());
			String content = _addProjInfo(proj.getProjInfo(),projInfo);
			proj.setProjInfo(content);
			researcherBiz.addProj(proj);
		}else {
			String content = _addProjInfo(proj.getProjInfo(),projInfo);
			proj.setProjInfo(content);
			researcherBiz.modifyProj(proj);
		}
		
		//初始化初审
		List<IrbApply> irbList = researcherBiz.searchIrbApplyList(proj.getProjFlow(),null);
		if(irbList==null || irbList.size()==0){
			IrbApply irb =  _addIrbApply(proj);
			setSessionAttribute(GlobalConstant.CURR_IRB, irb);
		}else {
			//修改关联信息
			for(IrbApply apply :irbList ){
				apply.setProjNo(proj.getProjNo());
				apply.setProjName(proj.getProjName());
				apply.setProjShortName(proj.getProjShortName());
				apply.setProjSubTypeId(proj.getProjSubTypeId());
				apply.setProjSubTypeName(proj.getProjSubTypeName());
				apply.setProjDeclarer(proj.getProjDeclarer());
				apply.setProjShortDeclarer(proj.getProjShortDeclarer());
				irbApplyBiz.modifyIrbApply(apply);
			}
			IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);//当前apply
			if (curApply != null) {
				curApply = irbApplyBiz.queryByFlow(curApply.getIrbFlow());
				setSessionAttribute(GlobalConstant.CURR_IRB, curApply);
			}
		}
		return proj.getProjFlow();
	}
	
	private IrbApply _addIrbApply(PubProj proj) {
		IrbApply apply = new IrbApply();
		apply.setIrbFlow(PkUtil.getUUID());
		apply.setProjFlow(proj.getProjFlow());
		apply.setIrbTypeId(IrbTypeEnum.Init.getId());
		apply.setIrbTypeName(IrbTypeEnum.Init.getName());
		apply.setIrbStageId(IrbStageEnum.Apply.getId());
		apply.setIrbStageName(IrbStageEnum.Apply.getName());
		
		//
		apply.setProjNo(proj.getProjNo());
		apply.setProjName(proj.getProjName());
		apply.setProjShortName(proj.getProjShortName());
		apply.setProjSubTypeId(proj.getProjSubTypeId());
		apply.setProjSubTypeName(proj.getProjSubTypeName());
		apply.setProjDeclarer(proj.getProjDeclarer());
		apply.setProjShortDeclarer(proj.getProjShortDeclarer());
		
		researcherBiz.addIrbApply(apply);
		
		//researcherBiz.handProcess(apply);
		
		return apply;
	}
	
	private String _addProjInfo(String content,ProjInfoForm projInfo) {
		if(StringUtil.isBlank(content)){ 
			content = "<projInfo/>";
		} 
		Document doc = null;
		try {
			doc = DocumentHelper.parseText(content);
			//****************一般信息****************
			Node generalInfoNode = doc.selectSingleNode("projInfo/generalInfo");
			Element generalInfoElement = null;
			if(generalInfoNode == null ){
				generalInfoElement = doc.getRootElement().addElement("generalInfo");
			}
			//注册分类
			Node registCategoryNode = generalInfoElement.selectSingleNode("registCategory");
			if (registCategoryNode == null) {
				registCategoryNode = generalInfoElement.addElement("registCategory");
			}
			registCategoryNode.setText(projInfo.getRegistCategory());
			//组长/参与
			Node isLeaderNode = generalInfoElement.selectSingleNode("isLeader");
			if (isLeaderNode == null) {
				isLeaderNode = generalInfoElement.addElement("isLeader");
			}
			isLeaderNode.setText(projInfo.getIsLeader());
			//国际多中心
			Node interMulCenterNode = generalInfoElement.selectSingleNode("interMulCenter");
			if (interMulCenterNode == null) {
				interMulCenterNode = generalInfoElement.addElement("interMulCenter");
			}
			interMulCenterNode.setText(projInfo.getInterMulCenter());
			
			//****************申办者****************
			Node declarerNode = doc.selectSingleNode("projInfo/declarer");
			Element declarerElement = null;
			if(declarerNode == null ){
				declarerElement = doc.getRootElement().addElement("declarer");
			}
			//申办者地址
			Node declarerAddressNode = declarerElement.selectSingleNode("declarerAddress");
			if (declarerAddressNode == null) {
				declarerAddressNode = declarerElement.addElement("declarerAddress");
			}
			declarerAddressNode.setText(projInfo.getDeclarerAddress());
			//申办者邮编
			Node declarerZipNode = declarerElement.selectSingleNode("declarerZip");
			if (declarerZipNode == null) {
				declarerZipNode = declarerElement.addElement("declarerZip");
			}
			declarerZipNode.setText(projInfo.getDeclarerZip());
			//申办者联系人
			Node dLinkManNode = declarerElement.selectSingleNode("dLinkMan");
			if (dLinkManNode == null) {
				dLinkManNode = declarerElement.addElement("dLinkMan");
			}
			dLinkManNode.setText(projInfo.getdLinkMan());
			//申办者联系人手机
			Node dLinkManPhoneNode = declarerElement.selectSingleNode("dLinkManPhone");
			if (dLinkManPhoneNode == null) {
				dLinkManPhoneNode = declarerElement.addElement("dLinkManPhone");
			}
			dLinkManPhoneNode.setText(projInfo.getdLinkManPhone());
			//申办者联系人邮箱
			Node dLinkManEmailNode = declarerElement.selectSingleNode("dLinkManEmail");
			if (dLinkManEmailNode == null) {
				dLinkManEmailNode = declarerElement.addElement("dLinkManEmail");
			}
			dLinkManEmailNode.setText(projInfo.getdLinkManEmail());
			
			//****************CRO****************
			Node CRONode = doc.selectSingleNode("projInfo/CRO");
			Element CROElement = null;
			if(CRONode == null ){
				CROElement = doc.getRootElement().addElement("CRO");
			}
			//CRO名称
			Node CRONameNode = CROElement.selectSingleNode("CROName");
			if (CRONameNode == null) {
				CRONameNode = CROElement.addElement("CROName");
			}
			CRONameNode.setText(projInfo.getCROName());
			//法人
			Node CROLegalRepresentNode = CROElement.selectSingleNode("CROLegalRepresent");
			if (CROLegalRepresentNode == null) {
				CROLegalRepresentNode = CROElement.addElement("CROLegalRepresent");
			}
			CROLegalRepresentNode.setText(projInfo.getCROLegalRepresent());
			//CRO地址
			Node CROAddressNode = CROElement.selectSingleNode("CROAddress");
			if (CROAddressNode == null) {
				CROAddressNode = CROElement.addElement("CROAddress");
			}
			CROAddressNode.setText(projInfo.getCROAddress());
			//CRO邮编
			Node CROZipNode = CROElement.selectSingleNode("CROZip");
			if (CROZipNode == null) {
				CROZipNode = CROElement.addElement("CROZip");
			}
			CROZipNode.setText(projInfo.getCROZip());
			//CRO联系人
			Node CROLinkManNode = CROElement.selectSingleNode("CROLinkMan");
			if (CROLinkManNode == null) {
				CROLinkManNode = CROElement.addElement("CROLinkMan");
			}
			CROLinkManNode.setText(projInfo.getCROLinkMan());
			//CRO联系人手机
			Node CROLinkManPhoneNode = CROElement.selectSingleNode("CROLinkManPhone");
			if (CROLinkManPhoneNode == null) {
				CROLinkManPhoneNode = CROElement.addElement("CROLinkManPhone");
			}
			CROLinkManPhoneNode.setText(projInfo.getCROLinkManPhone());
			//CRO联系人邮箱
			Node CROLinkManEmailNode = CROElement.selectSingleNode("CROLinkManEmail");
			if (CROLinkManEmailNode == null) {
				CROLinkManEmailNode = CROElement.addElement("CROLinkManEmail");
			}
			CROLinkManEmailNode.setText(projInfo.getCROLinkManEmail());
			
			//****************研究者信息****************
			Node researcherNode = doc.selectSingleNode("projInfo/researcher");
			Element researcherElement = null;
			if(researcherNode == null ){
				researcherElement = doc.getRootElement().addElement("researcher");
			}
			//科主任
			Node directorNode = researcherElement.selectSingleNode("director");
			if (directorNode == null) {
				directorNode = researcherElement.addElement("director");
			}
			directorNode.setText(projInfo.getDirector());
			
			//****************临床研究机构****************
			Node projOrgNode = doc.selectSingleNode("projInfo/projOrg");
			Element projOrgElement = null;
			if(projOrgNode == null ){
				projOrgElement = doc.getRootElement().addElement("projOrg");
			}
			//组长单位主要研究者
			Node leaderOrgLinkManNode = projOrgElement.selectSingleNode("leaderOrgLinkMan");
			if (leaderOrgLinkManNode == null) {
				leaderOrgLinkManNode = projOrgElement.addElement("leaderOrgLinkMan");
			}
			leaderOrgLinkManNode.setText(projInfo.getLeaderOrgLinkMan());
			//联系电话
			Node leaderOrgLinkManPhoneNode = projOrgElement.selectSingleNode("leaderOrgLinkManPhone");
			if (leaderOrgLinkManPhoneNode == null) {
				leaderOrgLinkManPhoneNode = projOrgElement.addElement("leaderOrgLinkManPhone");
			}
			leaderOrgLinkManPhoneNode.setText(projInfo.getLeaderOrgLinkManPhone());
			//邮件
			Node leaderOrgLinkManEmailNode = projOrgElement.selectSingleNode("leaderOrgLinkManEmail");
			if (leaderOrgLinkManEmailNode == null) {
				leaderOrgLinkManEmailNode = projOrgElement.addElement("leaderOrgLinkManEmail");
			}
			leaderOrgLinkManEmailNode.setText(projInfo.getLeaderOrgLinkManEmail());
			
			//组长单位伦理委员会联系人
			Node leaderOrgIrbLinkManNode = projOrgElement.selectSingleNode("leaderOrgIrbLinkMan");
			if (leaderOrgIrbLinkManNode == null) {
				leaderOrgIrbLinkManNode = projOrgElement.addElement("leaderOrgIrbLinkMan");
			}
			leaderOrgIrbLinkManNode.setText(projInfo.getLeaderOrgIrbLinkMan());
			
			// 联系电话
			Node leaderOrgIrbLinkManPhoneNode = projOrgElement.selectSingleNode("leaderOrgIrbLinkManPhone");
			if (leaderOrgIrbLinkManPhoneNode == null) {
				leaderOrgIrbLinkManPhoneNode = projOrgElement.addElement("leaderOrgIrbLinkManPhone");
			}
			leaderOrgIrbLinkManPhoneNode.setText(projInfo.getLeaderOrgIrbLinkManPhone());
			
			//邮件
			Node leaderOrgIrbLinkManEmailNode = projOrgElement.selectSingleNode("leaderOrgIrbLinkManEmail");
			if (leaderOrgIrbLinkManEmailNode == null) {
				leaderOrgIrbLinkManEmailNode = projOrgElement.addElement("leaderOrgIrbLinkManEmail");
			}
			leaderOrgIrbLinkManEmailNode.setText(projInfo.getLeaderOrgIrbLinkManEmail());
			
			return doc.asXML();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return content;
	}
	/**
	 * 显示送审文件清单
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/applyFileList")
	public String  applyFileList(Model model) throws Exception{
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);
		model.addAttribute("irbFlow", curApply.getIrbFlow());
		ApplyFileTemp applyFile = null;
		if(curApply!=null){
			//模板文件列表
			String irbFlow = curApply.getIrbFlow();
			String irbTypeId = curApply.getIrbTypeId();
			String projCategoryId = null;
			if(IrbTypeEnum.Init.getId().equals(irbTypeId)){//初始审查
				PubProj proj = this.projBiz.readProject(curApply.getProjFlow());
				if(proj!=null){
					projCategoryId = proj.getProjCategoryId();
				}
			}
			applyFile = new ApplyFileTemp();
			applyFile.setIrbType(irbTypeId);
			applyFile.setPjType(projCategoryId);
			List<ApplyFileTemp> fileList = this.irbCfgBiz.queryApplyFileList(applyFile);//模板文件列表
			
			/*已上传文件*/
			IrbRec irbRec = new IrbRec();
			irbRec.setIrbFlow(irbFlow);
			List<IrbApplyFileForm> uploadFiles = this.irbRecBiz.queryUploadFile(irbRec);
			List<String> fileFlows = new ArrayList<String>();
			Map<String, IrbApplyFileForm> rMap = new HashMap<String, IrbApplyFileForm>();
			if(uploadFiles!=null&&!uploadFiles.isEmpty()){
				for (IrbApplyFileForm uFile : uploadFiles) {
					rMap.put(uFile.getFileTempId(), uFile);
					fileFlows.add(uFile.getFileFlow());
				}
			}
			model.addAttribute("rMap", rMap);
			model.addAttribute("uploadFiles", uploadFiles);
			
			Map<String, String> fileNameMap = new HashMap<String, String>();	//上传文件附件名
			if (fileFlows.size() > 0) {
				List<PubFile> pubFiles = fileBiz.searchFile(fileFlows);
				if (pubFiles != null && pubFiles.size() > 0) {
					for (PubFile file:pubFiles) {
						fileNameMap.put(file.getFileFlow(), file.getFileName());
					}
				}
			}
			model.addAttribute("fileNameMap", fileNameMap);
			
			/*已确认文件*/
			List<IrbApplyFileForm> confirmedFile = this.irbRecBiz.queryConfirmFile(irbFlow);
			Map<String, IrbApplyFileForm> confirmMap = new HashMap<String, IrbApplyFileForm>();
			if(confirmedFile != null && !confirmedFile.isEmpty()){
				for (IrbApplyFileForm uFile : confirmedFile) {
					confirmMap.put(uFile.getFileTempId(), uFile);
				}
			}
			model.addAttribute("confirmMap", confirmMap);
			
			boolean showNotice = false;
			if(this.irbRecBiz.checkNotice(irbFlow,GlobalConstant.FLAG_Y)){//有修改通知
				showNotice = true;
				/*需补充文件*/
				List<IrbApplyFileForm> mustAddfile = this.irbRecBiz.queryApplyOrModify(irbFlow, GlobalConstant.NOTICE_TYPE_APPLY);
				/*需修改文件*/
				List<IrbApplyFileForm> mustModfile = this.irbRecBiz.queryApplyOrModify(irbFlow, GlobalConstant.NOTICE_TYPE_MODIFY);
				
				Map<String, IrbApplyFileForm> addMap = new HashMap<String, IrbApplyFileForm>();
				if(mustAddfile != null && !mustAddfile.isEmpty()){
					for (IrbApplyFileForm uFile : mustAddfile) {
						addMap.put(uFile.getFileTempId(), uFile);
					}
				}
				Map<String, IrbApplyFileForm> modMap = new HashMap<String, IrbApplyFileForm>();
				if(mustModfile != null && !mustModfile.isEmpty()){
					for (IrbApplyFileForm uFile : mustModfile) {
						modMap.put(uFile.getFileTempId(), uFile);
					}
				}
				model.addAttribute("addMap", addMap);
				model.addAttribute("modMap", modMap);
			}
			IrbApplyFileForm appForm = this.irbRecBiz.queryUploadFile(irbFlow, GlobalConstant.FLAG_N);//审查申请表
			rMap.put(GlobalConstant.FLAG_N, appForm);
			model.addAttribute("fileList", fileList);
			model.addAttribute("applyFile", applyFile);
			model.addAttribute("showNotice", showNotice);
			model.addAttribute("appForm", appForm);
			
			//判断返回时是否返回项目列表
			String backType = "list";
			List<IrbApply> allIrbList = researcherBiz.searchIrbApplyList(curApply.getProjFlow());
			if (allIrbList != null && allIrbList.size() > 1 ) {
				backType = "";
			}
			model.addAttribute("backType", backType);
		}
		return "irb/researcher/applyFileList";
	}

	/**
	 * 显示研究成员列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/projUserList")
	public String  projUserList(Model model){
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);
		if(curApply!=null){
			PubProjUserExt userExt = new PubProjUserExt();
			userExt.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			userExt.setProjFlow(curApply.getProjFlow());
			List<PubProjUserExt> userExtList = this.projUserBiz.queryExtList(userExt);
			List<PubProjUserExt> filterList = new ArrayList<PubProjUserExt>();
			for (PubProjUserExt pubProjUserExt : userExtList) {
				boolean canAdd = false;
				/*过滤一个用户多个角色*/
				for (PubProjUserExt filterUser : filterList) {
					if(pubProjUserExt.getUserFlow().equals(filterUser.getUserFlow())&&pubProjUserExt.getProjFlow().equals(filterUser.getProjFlow())){
						filterUser.getRole().setRoleName(filterUser.getRole().getRoleName()+"，"+pubProjUserExt.getRole().getRoleName());
						canAdd = false;
						break;
					}else{
						canAdd = true;
					}
				}
				if(filterList.isEmpty()||canAdd){
					filterList.add(pubProjUserExt);
				}
			}
			PubProj proj = this.projBiz.readProject(curApply.getProjFlow());
			model.addAttribute("userExtList", filterList);
			model.addAttribute("proj", proj);
		}
		return "irb/researcher/projUserList";
	}
	
	//保存或编辑元素
	@RequestMapping(value = {"/saveProjUserOrder" },method={RequestMethod.POST})
	@ResponseBody
	public String saveProjUserOrder(String [] recordFlow){		
		projUserBiz.saveProjUserOrder(recordFlow);		
		return GlobalConstant.SAVE_SUCCESSED;
	}
 
	@RequestMapping(value={"/mainResearchVitae"},method={RequestMethod.GET})
	public String  mainResearchVitae(String projFlow, Model model){
		SysUser researchUser = null;
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = researcherBiz.readPubProj(projFlow);
			if(null !=proj){
				String applyUserFlow = proj.getApplyUserFlow();
				if(StringUtil.isNotBlank(applyUserFlow)){
					researchUser = new SysUser();
					researchUser.setUserFlow(applyUserFlow);
					researchUser = userBiz.readSysUser(applyUserFlow);
					model.addAttribute("user", researchUser);
					
					IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);
					if (curApply != null) {
						model.addAttribute("irbFlow", curApply.getIrbFlow());
					}
				}
			}
		}
		return "sys/user/view";
	}
	
	@RequestMapping(value={"/responsabilidade"},method={RequestMethod.GET})
	public String  responsabilidade(Model model){
			return "irb/researcher/responsabilidade";
	}
	/**
	 * 显示上传附件
	 * @param applyFile
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/applyFile")
	public String  applyFile( ApplyFileTemp applyFile, Model model) throws Exception {
		if(applyFile!=null){
			ApplyFileTemp findApplyFile = this.irbCfgBiz.queryApplyFile(applyFile);
			IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);
			IrbApplyFileForm form = this.irbRecBiz.queryUploadFile(curApply.getIrbFlow(), applyFile.getId());
			model.addAttribute("findApplyFile", findApplyFile);
			model.addAttribute("form", form);
		}
		return "irb/researcher/file";
	}
	
	@RequestMapping(value="/saveApplyFile")
	public String  saveApplyFile(HttpServletRequest req) throws Exception {
		Map<String , String[]> dataMap = JspFormUtil.getParamMap(req);
		
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);
		String irbFlow = curApply.getIrbFlow();
		String projFlow = curApply.getProjFlow();
		String roleScope = dataMap.get("roleScope")[0];
		String operType = dataMap.get("operType")[0];
		String fileTempIds[] = dataMap.get("fileTempIds");
		if (fileTempIds != null && fileTempIds.length > 0) {
			IrbRec irbRec = new IrbRec();		//同步更新IRB_REC表的ApplyFile送审文件清单数据
			irbRec.setProjFlow(curApply.getProjFlow());
			irbRec.setIrbFlow(curApply.getIrbFlow());
			irbRec.setIrbStageId(curApply.getIrbStageId());
			irbRec.setIrbStageName(curApply.getIrbStageName());
			irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
			irbRec.setRecTypeName(IrbRecTypeEnum.ApplyFile.getName());
			
			Document dom = null;
			Element root = null;
			String content = null;
			IrbRec findIrbRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findIrbRec != null){
				irbRec.setRecFlow(findIrbRec.getRecFlow());
				content = findIrbRec.getRecContent();
			}
			if(StringUtil.isNotBlank(content)){
				//删除不属于文件模板列表的文件（适用于修改期类别的情况）
				IrbRec temp = new IrbRec();
				temp.setIrbFlow(irbFlow);
				List<IrbApplyFileForm> uploadFiles = this.irbRecBiz.queryUploadFile(temp);
				List<String> fileTempIdList = Arrays.asList(fileTempIds);
				if (uploadFiles != null && uploadFiles.size() >0) {
					for (IrbApplyFileForm form:uploadFiles) {
						String fileId = form.getFileTempId();
						if (!GlobalConstant.FLAG_N.equals(fileId) && (fileTempIdList == null || !fileTempIdList.contains(fileId))) {
							this.researcherBiz.delApplyFile(irbFlow, fileId);
						}
					}
				}
			}
			findIrbRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findIrbRec != null){
				irbRec.setRecFlow(findIrbRec.getRecFlow());
				content = findIrbRec.getRecContent();
			}
			if(StringUtil.isNotBlank(content)){
				dom = DocumentHelper.parseText(content);
				root = dom.getRootElement();
			} else {
				dom = DocumentHelper.createDocument();
				root = dom.addElement("applyFile");
			}
			
			for (int i=0;i<fileTempIds.length;i++) {
				String fileTempId = fileTempIds[i];
				String fileFlow = dataMap.get("file_"+fileTempId) == null?"":dataMap.get("file_"+fileTempId)[0];
				if (StringUtil.isBlank(fileFlow)) {	//未上传文件
					continue;
				}
				String fileName = dataMap.get("fileName_"+fileTempId) == null ?"":dataMap.get("fileName_"+fileTempId)[0];
				String fileType = dataMap.get("fileType_"+fileTempId) == null?"":dataMap.get("fileType_"+fileTempId)[0];
				String version = dataMap.get("version_"+fileTempId) == null?"":dataMap.get("version_"+fileTempId)[0];
				String versionDate = dataMap.get("versionDate_"+fileTempId) == null?"":dataMap.get("versionDate_"+fileTempId)[0];
				String showNotice = dataMap.get("showNotice_"+fileTempId) == null?"":dataMap.get("showNotice_"+fileTempId)[0];
				String url = "";
				if ("application".equals(fileTempId)) {
					url = dataMap.get("url_"+fileTempId) == null?"":dataMap.get("url_"+fileTempId)[0];
				}
				
				Element fileElement = null;
				Element findFileElement = (Element) dom.selectSingleNode("/applyFile/file[@id='"+fileTempId+"']");
				if(findFileElement != null){
					fileElement = findFileElement;
					if ("edit".equals(operType)) {	//秘书修改申请信息时，上传文件直接为确认状态
						Attribute confirmAttr = fileElement.attribute("confirm");
						if (confirmAttr != null) {
							confirmAttr.setValue("true");
						} else {
							fileElement.addAttribute("confirm", "true");
						}
					}
					if (StringUtil.isNotBlank(fileFlow)) {
						fileElement.element("fileFlow").setText(StringUtil.defaultIfEmpty(fileFlow, ""));
					}
					if(StringUtil.isNotBlank(url)){
						fileElement.element("url").setText(url);
					}
					fileElement.element("fileName").setText(StringUtil.defaultIfEmpty(fileName, ""));
					if (fileElement.selectSingleNode("fileType") == null) {
						fileElement.addElement("fileType").setText(fileType);
					} else {
						fileElement.element("fileType").setText(fileType);
					}
					if (fileElement.selectSingleNode("version") == null) {
						fileElement.addElement("version").setText(version);
					} else {
						fileElement.element("version").setText(version);
					}
					if (fileElement.selectSingleNode("versionDate") == null) {
						fileElement.addElement("versionDate").setText(versionDate);
					} else {
						fileElement.element("versionDate").setText(versionDate);
					}
					fileElement.element("showNotice").setText(StringUtil.defaultIfEmpty(showNotice, ""));
				}else{
					if (!"application".equals(fileTempId)) {
						fileElement = root.addElement("file");
						fileElement.addAttribute("id", fileTempId);
						if ("edit".equals(operType)) {	//秘书修改申请信息时，上传文件直接为确认状态
							fileElement.addAttribute("confirm", "true");
						}
						fileElement.addElement("fileFlow").setText(StringUtil.defaultIfEmpty(fileFlow, ""));
						if(StringUtil.isNotBlank(url)){
							fileElement.addElement("url").setText(url);
						}
						fileElement.addElement("fileName").setText(StringUtil.defaultIfEmpty(fileName, ""));
						fileElement.addElement("fileType").setText(fileType);
						fileElement.addElement("version").setText(version);
						fileElement.addElement("versionDate").setText(versionDate);
						fileElement.addElement("showNotice").setText(StringUtil.defaultIfEmpty(showNotice, ""));
					}
				}
				
			}
			irbRec.setRecContent(dom.asXML());
			this.irbRecBiz.edit(irbRec);
		}
		
		//判断返回时是否返回项目列表
		String backType = "list";
		List<IrbApply> allIrbList = researcherBiz.searchIrbApplyList(projFlow);
		if (allIrbList != null && allIrbList.size() > 1 ) {
			backType = "";
		}
		
		return "redirect:/irb/researcher/applyMain?projFlow="+projFlow+"&irbFlow="+irbFlow+"&from=view&roleScope="+roleScope+"&operType="+operType+"&backType="+backType;
	}
	
	/**
	 * 删除已传文件
	 * @param fileTempIds
	 * @return
	 */
	@RequestMapping(value="/delApplyFile")
	@ResponseBody
	public String delApplyFile(String[] fileIds) throws Exception{
		if(fileIds!=null&&fileIds.length>0){
			IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);
			if(curApply!=null){
				String irbFlow = curApply.getIrbFlow();
				for (String id : fileIds) {
					this.researcherBiz.delApplyFile(irbFlow, id);
				}
			}
			
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	@RequestMapping(value={"/process"},method={RequestMethod.GET})
	public String  process(String projFlow,String irbFlow,String irbTypeId,String roleScope,Model model) throws Exception{
		PubProj proj = researcherBiz.readPubProj(projFlow);
		model.addAttribute("proj", proj);
		
		IrbApply cuurApply = new IrbApply();
		
		List<IrbApply> allIrbList = researcherBiz.searchIrbApplyList(projFlow);
		List<IrbApply> irbList = new ArrayList<IrbApply>();
		if(allIrbList==null || allIrbList.size()==0){ 
			//存在项目 不存在伦理审查、直接进入申请界面,默认生成一条初审
			cuurApply = _addIrbApply(proj);
			setSessionAttribute(GlobalConstant.CURR_IRB, cuurApply);
			return "irb/researcher/applyMain"; 
		}else {
			
			if(allIrbList.size()==1 && IrbTypeEnum.Init.getId().equals(allIrbList.get(0).getIrbTypeId()) &&IrbStageEnum.Apply.getId().equals(allIrbList.get(0).getIrbStageId())){
				//初审未提交
				cuurApply = allIrbList.get(allIrbList.size()-1);
				setSessionAttribute(GlobalConstant.CURR_IRB, cuurApply);
				model.addAttribute("backType", "list");
				return "irb/researcher/applyMain";
			} else {
				List<String> irbTypeList = new ArrayList<String>();
				if(StringUtil.isBlank(irbTypeId)){
					if(StringUtil.isNotBlank(irbFlow)){ 
						irbTypeId = researcherBiz.readIrbApply(irbFlow).getIrbTypeId();
					} else {
						irbTypeId = allIrbList.get(allIrbList.size()-1).getIrbTypeId();
					}
				}
				for(IrbApply irb : allIrbList){
					if(!irbTypeList.contains(irb.getIrbTypeId())){
						irbTypeList.add(irb.getIrbTypeId());
					} 
					if((irb.getIrbTypeId().equals(irbTypeId))){
						irbList.add(irb);
					}
				}
				model.addAttribute("irbTypeList", irbTypeList);
				if(StringUtil.isBlank(irbFlow)){ 
					//默认该类别最后一条审查
					cuurApply = irbList.get(irbList.size()-1);
					setSessionAttribute(GlobalConstant.CURR_IRB, cuurApply);
				}else {
					cuurApply = researcherBiz.readIrbApply(irbFlow);
					setSessionAttribute(GlobalConstant.CURR_IRB,cuurApply);
				}
			}
			model.addAttribute("irbList", irbList);
//			List<IrbProcess> processList = researcherBiz.searchProcess(cuurApply.getIrbFlow());
//			model.addAttribute("process", processList);
			
			irbFlow = cuurApply.getIrbFlow();
			
			IrbUser user = new IrbUser();
			user.setIrbFlow(irbFlow);
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<IrbUser> irbUserList = this.irbUserBiz.queryList(user);	//主审委员/独立顾问
			model.addAttribute("irbUserList",irbUserList);
			
			Map<String,List<IrbUser>> irbCommitteeMap = new HashMap<String, List<IrbUser>>();
			for(IrbApply apply : irbList) {
				List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(apply.getIrbFlow());	//主审委员
				List<IrbUser> filterList = null;	//过滤相同的人 如：主审委员方案和知情同意为同一个人
				List<String> userFlowList = new ArrayList<String>();
				if (committeeList != null && committeeList.size() > 0) {
					for (IrbUser tem:committeeList) {
						if (!userFlowList.contains(tem.getUserFlow())) {
							if (filterList == null) {
								filterList = new ArrayList<IrbUser>();
							}
							filterList.add(tem);
							userFlowList.add(tem.getUserFlow());
						}
					}
				}
				irbCommitteeMap.put(apply.getIrbFlow(), filterList);
			}
			model.addAttribute("irbCommitteeMap",irbCommitteeMap);
			
			String fileType = this.secretaryBiz.checkFileType(cuurApply);	//判断是批件还是意件
			model.addAttribute("fileType",fileType);
			
			model.addAttribute("noticeFlag",this.irbRecBiz.checkNotice(irbFlow,""));	//判断是否有补充修改通知
			
			model.addAttribute("irbInfo", irbInfoBiz.queryInfo(cuurApply.getIrbInfoFlow()));
			
		}
		return "irb/researcher/process";
	}
	@RequestMapping(value={"/doApply"},method={RequestMethod.GET})
	public String  doApply(String projFlow,Model model){
		return "irb/researcher/doApply";
	}
	/**
	 * 提交审查
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/confirmApplyFile"},method={RequestMethod.GET})
	@ResponseBody
	public String  confirmApplyFile(Model model){
		IrbApply irb = (IrbApply) getSessionAttribute(GlobalConstant.CURR_IRB);
		if(irb != null){
			IrbRec rec = irbRecBiz.readIrbRec(irb.getIrbFlow(),IrbRecTypeEnum.ApplyFile.getId());
			if(rec != null){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 提交审查
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/submitApply"},method={RequestMethod.GET})
	@ResponseBody
	public String  submitApply(Model model){
		IrbApply irb = (IrbApply) getSessionAttribute(GlobalConstant.CURR_IRB);
		if(irb != null){
			this.researcherBiz.saveProcess(irb, null);//插入process
			irb.setIrbApplyDate(DateUtil.getCurrDate());
			irb.setIrbStageId(IrbStageEnum.Handle.getId());
			irb.setIrbStageName(IrbStageEnum.Handle.getName());
			this.irbApplyBiz.changeStage(irb);//改状态
			//改变补充修改通知状态
			IrbRec temp = new IrbRec();
			temp.setIrbFlow(irb.getIrbFlow());
			temp.setRecTypeId(IrbRecTypeEnum.AddModNotice.getId());
			temp.setRecVersion(GlobalConstant.FLAG_Y);
			IrbRec irbRec = irbRecBiz.readIrbRec(temp);
			if(irbRec!=null){
				irbRec.setRecVersion("");
				irbRecBiz.edit(irbRec);
			}
			setSessionAttribute(GlobalConstant.CURR_IRB, irb);
		
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value={"/addIrb"},method={RequestMethod.GET})
	@ResponseBody
	public String  addIrb(String projFlow,String irbTypeId,Model model){
		IrbApply apply = new IrbApply();
		apply.setIrbFlow(PkUtil.getUUID());
		apply.setProjFlow(projFlow);
		apply.setIrbTypeId(irbTypeId);
		apply.setIrbTypeName(IrbTypeEnum.getNameById(irbTypeId)); 
		
		List<IrbApply> initIrb = researcherBiz.searchIrbApplyList(projFlow, IrbTypeEnum.Init.getId());
		if(initIrb !=null && initIrb.size()>0){
			apply.setIrbInfoFlow(initIrb.get(0).getIrbInfoFlow());
		}
		apply.setIrbStageId(IrbStageEnum.Apply.getId());
		apply.setIrbStageName(IrbStageEnum.Apply.getName());
		
		PubProj proj = projBiz.readProject(projFlow);
		
		apply.setProjName(proj.getProjName());
		apply.setProjShortName(proj.getProjShortName());
		apply.setProjSubTypeId(proj.getProjSubTypeId());
		apply.setProjSubTypeName(proj.getProjSubTypeName());
		apply.setProjDeclarer(proj.getProjDeclarer());
		apply.setProjShortDeclarer(proj.getProjShortDeclarer());
		
		researcherBiz.addIrbApply(apply);
		
		//researcherBiz.handProcess(apply);
		
		return GlobalConstant.OPRE_SUCCESSED;
	}
	/**
	 * 显示添加研究人员
	 * @param deptFlow
	 * @param roleFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showAddUser")
	public String showAddUser(String deptFlow,String roleFlow,Model model){
		List<SysDept> depList = this.irbInfoBiz.queryIrbDept();//可选部门
		/*可选角色列表*/
		SysRole sysRole = new SysRole();
		sysRole.setWsId(GlobalConstant.GCP_WS_ID);
		sysRole.setRoleLevelId(RoleLevelEnum.ProjLevel.getId());
		sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysRole> roleList = roleBiz.search(sysRole);
		/*可选用户*/
		if((StringUtil.isEmpty(roleFlow)||StringUtil.isBlank(roleFlow))&&roleList!=null&&!roleList.isEmpty()){
			roleFlow = roleList.get(0).getRoleFlow();
		}
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);//当前apply
		String projFlow = curApply.getProjFlow();
		SysUserForm form = new SysUserForm();
		form.setRoleFlow(roleFlow);
		form.setProjFlow(projFlow);
		SysUser sysUser = new SysUser();
		sysUser.setDeptFlow(deptFlow);
		form.setUser(sysUser);
		List<SysUser> userList = this.researcherBiz.queryResUser(form);
		
		model.addAttribute("userList", userList);
		model.addAttribute("depList", depList);
		model.addAttribute("roleList", roleList);
		return "irb/researcher/addUser";
	}
	/**
	 * 保存研究人员
	 * @param userFlows
	 * @param roleFlow
	 * @return
	 */
	@RequestMapping(value="/saveUsers")
	@ResponseBody
	public String saveUsers(String[]userFlows,String roleFlow){
		if(userFlows!=null&&userFlows.length>0&&StringUtil.isNotBlank(roleFlow)){
			List<PubProjUser> users = new ArrayList<PubProjUser>();
			IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);//当前apply
			String projFlow = curApply.getProjFlow();
//			PubProj proj = this.projBiz.readProject(projFlow);
			
			PubProjUser user = null;
			for (String userFlow : userFlows) {
				user = new PubProjUser();
				SysUser findUser = this.userBiz.readSysUser(userFlow);
				user.setUserFlow(userFlow);
				user.setRoleFlow(roleFlow);
				user.setOrgFlow(findUser.getOrgFlow());
				user.setProjFlow(projFlow);
				user.setAuthTime(DateUtil.getCurrDateTime());
				user.setAuthUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				users.add(user);
				
//				//角色为主要研究者时，更新pub_proj表applyUserFlow和applyUserName字段
//				if (roleFlow.equals(InitConfig.getSysCfg("researcher_role_flow"))) {
//					proj.setApplyUserFlow(userFlow);
//					proj.setApplyUserName(findUser.getUserName());
//					researcherBiz.modifyProj(proj);
//				}
			}
			this.projUserBiz.editUsers(users);
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 确认删除的主要研究者是否是项目的主要研究者（applyUserFlow）
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/delResUserConfirm")
	@ResponseBody
	public String delResUserConfirm(String userFlow){
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);//当前apply
		String projFlow = curApply.getProjFlow();
		PubProj proj = this.projBiz.readProject(projFlow);
		if (proj != null) {
			String applyUserFlow = proj.getApplyUserFlow();
			if (StringUtil.isNotBlank(applyUserFlow) && applyUserFlow.equals(userFlow)) {
				return GlobalConstant.OPRE_FAIL;
			}
		}
		
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	/**
	 * 删除研究人员
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/delResUser")
	@ResponseBody
	public String delResUser(PubProjUser user){
		if(user!=null){
			int delResult = this.projUserBiz.edit(user);
			if(delResult==GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	/**
	 * 显示用户所有研究岗位
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/showAllRoleUser")
	public String showAllRoleUser(PubProjUserExt user,Model model){
		if(user!=null){
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<PubProjUserExt> userList = this.projUserBiz.queryExtList(user);
			model.addAttribute("userList",userList);
		}
		return "irb/researcher/allRoleUser";
	}
	/**
	 * 审查申请表
	 * @param user
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/irbApplication",method={RequestMethod.GET})
	public String irbApplication(String irbFlow, Model model){
		IrbApply currIrb =  (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);
		if (StringUtil.isNotBlank(irbFlow)) {
			currIrb = this.irbApplyBiz.queryByFlow(irbFlow);
			setSessionAttribute(GlobalConstant.CURR_IRB, currIrb);
		}
		if(currIrb != null){ 
			String projFlow = currIrb.getProjFlow();
			PubProj proj = researcherBiz.readPubProj(projFlow);
			model.addAttribute("proj", proj);
			String category = proj.getProjCategoryId();
			String formFileName = "";
			if(IrbTypeEnum.Init.getId().equals(currIrb.getIrbTypeId())){
				formFileName = IrbRecTypeEnum.InitApplication.getId();
			}else if(IrbTypeEnum.Retrial.getId().equals(currIrb.getIrbTypeId())){
				formFileName = IrbRecTypeEnum.RetrialApplication.getId();
			}else if(IrbTypeEnum.Revise.getId().equals(currIrb.getIrbTypeId())){
				formFileName = IrbRecTypeEnum.ReviseApplication.getId();
			}else if(IrbTypeEnum.Schedule.getId().equals(currIrb.getIrbTypeId())){
				formFileName = IrbRecTypeEnum.ScheduleApplication.getId();
			}else if(IrbTypeEnum.Sae.getId().equals(currIrb.getIrbTypeId())){
				formFileName = IrbRecTypeEnum.SaeApplication.getId();
			}else if(IrbTypeEnum.Violate.getId().equals(currIrb.getIrbTypeId())){
				formFileName = IrbRecTypeEnum.ViolateApplication.getId();
			}else if(IrbTypeEnum.Terminate.getId().equals(currIrb.getIrbTypeId())){
				formFileName = IrbRecTypeEnum.TerminateApplication.getId();
			}else if(IrbTypeEnum.Finish.getId().equals(currIrb.getIrbTypeId())){
				formFileName = IrbRecTypeEnum.FinishApplication.getId();
			}
			if(StringUtil.isNotBlank(formFileName)){ 
				String productType = InitConfig.getSysCfg("irb_form_category");
				if(StringUtil.isBlank(productType)){
					productType = GlobalConstant.IRB_FORM_PRODUCT;
				}
				String currVer = InitConfig.formRequestUtil.getVersionMap().get(formFileName);
				if(StringUtil.isBlank(currVer)){
					currVer = GlobalConstant.IRB_FORM_PRODUCT_VER;
				}
				Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
				IrbSingleForm singleForm = 	singleFormMap.get(productType+"_"+category+"_"+currVer);
				if(singleForm == null){
					logger.info("未配置该项目类型表单，默认使用药物申请表单!");
					singleForm = 	singleFormMap.get(productType+"_"+ProjCategroyEnum.Yw.getId()+"_"+currVer);
				}  
				if(singleForm == null){
					throw new RuntimeException("未发现表单 项目类别:"+proj.getProjCategoryName()+",伦理审查类别:"+IrbTypeEnum.getNameById(currIrb.getIrbTypeId())+",模版类型:"+productType+",版本号:"+currVer);
				}
				model.addAttribute("formFileName", formFileName);
				String jspPath = singleForm.getJspPath();
				//irb/form/{0}/application/init_{1}_{2}
				if(StringUtil.isNotBlank(jspPath)){
					jspPath = MessageFormat.format(jspPath,singleForm.getProductType(),singleForm.getCategory(),singleForm.getVersion());
				}
				
				Map<String,String> formDataMap = new HashMap<String, String>();
				IrbRec rec = irbRecBiz.readIrbRec(currIrb.getIrbFlow(),formFileName);
				if(rec != null){
					String content = rec.getRecContent();
					try {
						Document document = DocumentHelper.parseText(content);
						Element rootElement = document.getRootElement();
						List<Element> elements = rootElement.elements();
						if (elements != null && elements.size()>0) {
							for(Element element : elements){
								List<Node> valueNodes = element.selectNodes("value");
								if(valueNodes != null && valueNodes.size()>0){
									String value = "";
									for(Node node : valueNodes){
										if(StringUtil.isNotBlank(value)){
											value+=",";
										}
										value += node.getText();
									}
									formDataMap.put(element.getName(), value);
								}else {
									formDataMap.put(element.getName(), element.getText());
								}
							}
						}
					} catch (DocumentException e) {
						e.printStackTrace();
					}
				}
				model.addAttribute("formDataMap", formDataMap);
				return jspPath;
			}
		}
		return "error/404";
	}
	@RequestMapping(value={"/saveApplication"},method={RequestMethod.POST})
	@ResponseBody
	public String formRequest(String formFileName,HttpServletRequest req)throws Exception{
		IrbApply currIrb =  (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);
		if(currIrb != null && StringUtil.isNotBlank(formFileName)){ 
			String projFlow = currIrb.getProjFlow();
			PubProj proj = researcherBiz.readPubProj(projFlow);
			String category = proj.getProjCategoryId();
			
			String productType = InitConfig.getSysCfg("irb_form_category");
			if(StringUtil.isBlank(productType)){
				productType = GlobalConstant.IRB_FORM_PRODUCT;
			}
			String currVer = InitConfig.formRequestUtil.getVersionMap().get(formFileName);
			if(StringUtil.isBlank(currVer)){
				currVer = GlobalConstant.IRB_FORM_PRODUCT_VER;
			}
			Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
			if(singleFormMap != null){
				IrbSingleForm singleForm = 	singleFormMap.get(productType+"_"+category+"_"+currVer);
				if(singleForm == null){
					logger.info("未配置该项目类型表单，默认使用药物申请表单!");
					singleForm = 	singleFormMap.get(productType+"_"+ProjCategroyEnum.Yw.getId()+"_"+currVer);
				}  
				
				if(singleForm == null){
					throw new RuntimeException("未发现表单: 项目类别"+proj.getProjCategoryName()+",伦理审查类别:"+IrbTypeEnum.getNameById(currIrb.getIrbTypeId())+",模版类型:"+productType+",版本号:"+currVer);
				}
				logger.info(formFileName+"=="+singleForm.getItemList().size()+"==="); 
				
				String irbFlow = currIrb.getIrbFlow();
				IrbRec rec = irbRecBiz.readIrbRec(irbFlow,formFileName);
				String recContent = _getRecContent(formFileName, singleForm.getItemList(), req); 
				if(rec == null){
					rec = new IrbRec();
				}
				rec.setProjFlow(projFlow);
				rec.setIrbFlow(irbFlow);
				String irbStageId = currIrb.getIrbStageId();
				rec.setIrbStageId(irbStageId);
				String irbStageName = currIrb.getIrbStageName();
				rec.setIrbStageName(irbStageName);
				rec.setRecTypeId(formFileName);
				String nameById = IrbRecTypeEnum.getNameById(formFileName);
				rec.setRecTypeName(nameById);
				rec.setRecVersion(currVer);
				rec.setRecContent(recContent);
				irbRecBiz.edit(rec);
				/*向送审文件插入审查申请表节点*/
				IrbRec irbRec = new IrbRec();
				irbRec.setProjFlow(projFlow);
				irbRec.setIrbFlow(irbFlow);
				irbRec.setIrbStageId(irbStageId);
				irbRec.setIrbStageName(irbStageName);
				irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
				irbRec.setRecTypeName(IrbRecTypeEnum.ApplyFile.getName());
				IrbApplyFileForm form = new IrbApplyFileForm();
				form.setFileTempId(GlobalConstant.FLAG_N);
				form.setFileName(nameById);
				form.setShowNotice(GlobalConstant.FLAG_Y);
				form.setUrl(GlobalContext.getRequest().getContextPath()+"/irb/researcher/irbApplication?open="+GlobalConstant.FLAG_Y+"&irbFlow="+irbFlow);
				this.researcherBiz.saveApplyFile(null, irbRec, form  );
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	private String _getRecContent(String formName,List<Element> list,HttpServletRequest req) { 
		Element rootEle = DocumentHelper.createElement(formName);
		if(list !=null && list.size()>0){
			for(Element itemEle : list){
				String multiple = itemEle.attributeValue("multiple");
				if(GlobalConstant.FLAG_N.equals(multiple) || StringUtil.isBlank(multiple)){
					String value = req.getParameter(itemEle.attributeValue("name"));
					Element element = DocumentHelper.createElement(itemEle.attributeValue("name")); 
					if (StringUtil.isNotBlank(value)) {
						element.setText(value);
					}
					rootEle.add(element);
				}else {
					String[] values = req.getParameterValues(itemEle.attributeValue("name"));
					Element element = DocumentHelper.createElement(itemEle.attributeValue("name")); 
					if(values!=null && values.length>0){
						for(String value : values){
							Element valueEle = DocumentHelper.createElement("value"); 
							if (StringUtil.isNotBlank(value)) {
								valueEle.setText(value);
							}
							element.add(valueEle);
						}
					}
					rootEle.add(element);
				}
			}
		}
		return rootEle.asXML();
	}
	
	@RequestMapping(value={"/editProjOrg"},method={RequestMethod.GET})
	public String  editProjOrg(Model model){
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);//当前apply
		String projFlow = curApply.getProjFlow();
		List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("projOrgList", projOrgList);
		return "irb/researcher/editProjOrg";
	}
	
	@RequestMapping(value = "/saveProjOrgBatch",method={RequestMethod.POST})
	@ResponseBody
	public String saveProjOrgBatch(@RequestBody ProjOrgForm projOrgForm){
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);//当前apply
		String projFlow = curApply.getProjFlow();
		
		List<PubProjOrg> projOrgList =  projOrgForm.getProjOrgList();
		for(PubProjOrg projOrg:projOrgList){
			if(StringUtil.isBlank(projOrg.getRecordFlow())){ 
				projOrg.setProjFlow(projFlow);
				projOrgBiz.addProjOrg(projOrg);
			}else {
				projOrgBiz.mod(projOrg);
			}
		}
		
		return GlobalConstant.SAVE_SUCCESSED;	
	}
	
	@RequestMapping(value = "/delProjOrg",method={RequestMethod.GET})
	@ResponseBody
	public String delProjOrg(PubProjOrg projOrg,Model model){
		projOrg.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		projOrgBiz.del(projOrg);
		return GlobalConstant.OPERATE_SUCCESSED;	
	}
	
	@RequestMapping(value={"/showMain"},method={RequestMethod.GET})
	public String  showMain(String projFlow, String irbFlow, Model model) throws Exception{
		if(StringUtil.isBlank(projFlow)){
			setSessionAttribute(GlobalConstant.CURR_IRB, null);
		} else {
			IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);//当前apply
			if (StringUtil.isNotBlank(irbFlow)) {
				curApply = researcherBiz.readIrbApply(irbFlow);
				setSessionAttribute(GlobalConstant.CURR_IRB, curApply);
			}
			irbFlow = curApply.getIrbFlow();
			IrbUser user = new IrbUser();
			user.setIrbFlow(irbFlow);
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<IrbUser> irbUserList = this.irbUserBiz.queryList(user);
			model.addAttribute("irbUserList",irbUserList);
			
			model.addAttribute("noticeFlag",this.irbRecBiz.checkNotice(irbFlow,""));	//判断是否有补充修改通知
			
			String fileType = this.secretaryBiz.checkFileType(curApply);	//判断是批件还是意件
			model.addAttribute("fileType",fileType);
			
			PubProj proj = researcherBiz.readPubProj(projFlow);
			model.addAttribute("proj",proj);
			
		}
		
		return "irb/researcher/showMain";
	}
	
	/**
	 * 展示补充修改通知
	 */
	@RequestMapping(value="/showModifyNotice")
	public String  showModifyNotice(Model model){
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);
		if(curApply!=null){
			IrbRec modifyNoticeRec = irbRecBiz.readIrbRec(curApply.getIrbFlow(),IrbRecTypeEnum.AddModNotice.getId());
			model.addAttribute("modifyNoticeRec",modifyNoticeRec);
		}
		return "irb/researcher/modifyNotice";
	}
	
	@RequestMapping(value = "/saveInitIrbConfirm",method={RequestMethod.GET})
	@ResponseBody
	public String saveInitIrbConfirm(String projFlow,Model model){
		//校验是否已有初始审查申请
		IrbApply irb = new IrbApply();
		irb.setProjFlow(projFlow);
		irb.setIrbTypeId(IrbTypeEnum.Init.getId());
		List<IrbApply> irbList = irbApplyBiz.searchIrbApply(irb);
		if (irbList != null && irbList.size() >0) {
			return GlobalConstant.OPRE_FAIL;	
		}
		return GlobalConstant.OPRE_SUCCESSED;	
	} 
	
}

