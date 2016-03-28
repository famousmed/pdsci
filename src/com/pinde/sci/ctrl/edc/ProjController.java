package com.pinde.sci.ctrl.edc;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcProjBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IInspectBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.util.LoginUtil;
import com.pinde.sci.enums.edc.ProjInputTypeEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.pub.ProjOrgTypeEnum;
import com.pinde.sci.enums.sys.RoleLevelEnum;
import com.pinde.sci.form.pub.ProjFileForm;
import com.pinde.sci.model.edc.RandomInfo;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/edc/proj")
public class ProjController extends GeneralController {	
	private static Logger logger=LoggerFactory.getLogger(ProjController.class);
	
	@Autowired
	private IEdcProjBiz projBiz;	
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IProjUserBiz projUserBiz;	
	@Autowired
	private IRoleBiz roleBiz; 
	@Autowired
	private IEdcRandomBiz randomBiz;
	@Autowired
	private IPubPatientBiz patientBiz;
	@Autowired
	private IInspectBiz inspectBiz;
	@Autowired
	private IVisitBiz visitBiz;
	@Autowired
	private IInputBiz inputBiz; 
	
	
	@RequestMapping(value="/list",method={RequestMethod.POST,RequestMethod.GET})
	public String list(PubProj proj,Model model){
		proj.setRecordStatus("Y");
		List<PubProj> projList=projBiz.search(proj);
		model.addAttribute("projList",projList);
		return "edc/proj/list";
	}
	@RequestMapping(value="/applyList",method={RequestMethod.POST,RequestMethod.GET})
	public String applyList(PubProj proj,Model model){
		proj.setRecordStatus("Y");
		List<PubProj> projList=projBiz.search(proj);
		model.addAttribute("projList",projList);
		return "edc/proj/applyList";
	}
	
	
	@RequestMapping(value = "/edit",method={RequestMethod.GET})
	public String edit(String projFlow,Model model){
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj=projBiz.read(projFlow);
			model.addAttribute("proj", proj);
		}
		return "edc/proj/edit";
	} 
	
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	@ResponseBody
	public String save(PubProj proj,HttpServletRequest request){
		projBiz.save(proj);
		return GlobalConstant.SAVE_SUCCESSED;		
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	@ResponseBody
	public String delete(String projFlow,String recordStatus,PubProj proj){
		proj.setProjFlow(projFlow);
		proj.setRecordStatus(recordStatus);
		projBiz.del(proj);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping(value="/userProjList",method={RequestMethod.POST,RequestMethod.GET})
	public String userProjList(PubProj proj,Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		String userFlow = currUser.getUserFlow();
		if(GlobalConstant.ROOT_USER_CODE.equals(currUser.getUserCode())){
			proj.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<PubProj> projList=projBiz.search(proj);	
			model.addAttribute("projList",projList);		
		}else{	
			List<PubProj> projList=projBiz.searchForUser(proj,userFlow);
			model.addAttribute("projList",projList);				
		}
		return "edc/proj/userProjList";
	}
	
	@RequestMapping(value="/setCurrProj",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String setCurrProj(String projFlow,HttpServletRequest request,Model model){
		//设置当前项目
		PubProj proj = projBiz.read(projFlow);		
		setSessionAttribute(GlobalConstant.EDC_CURR_PROJ, proj);
		
		EdcProjParam projParam = projBiz.readProjParam(projFlow);
		setSessionAttribute(GlobalConstant.EDC_CURR_PROJ_PARAM, projParam);
		
		//注销projDescForm
		setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, null);

		SysUser currUser = GlobalContext.getCurrentUser();
		String userFlow = currUser.getUserFlow();
		//加载项目权限
		LoginUtil.loadEDCProjRole(userFlow, projFlow, projUserBiz, roleBiz);
		//重置原先项目选择的模块
//		setSessionAttribute(GlobalConstant.CURRENT_MODULE_ID, null);
		return GlobalConstant.SELECT_SUCCESSED;	
	}
	
	@RequestMapping(value="/goCurrProj",method={RequestMethod.POST,RequestMethod.GET})
	public String goCurrProj(HttpServletRequest request,Model model){
		return "edc/proj/goCurrProj";	
	}
	
	@RequestMapping(value = "/showInfo",method={RequestMethod.GET})
	public String showInfo(HttpServletRequest request,Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		PubProj proj = projBiz.read(edcCurrProj.getProjFlow());
		model.addAttribute("proj", proj);
		
//		projParam
		EdcProjParam projParam = projBiz.readProjParam(edcCurrProj.getProjFlow());
		model.addAttribute("projParam", projParam);
		return "edc/proj/showInfo";
	} 
	
	@RequestMapping(value={"/saveInfo"},method=RequestMethod.POST)
	@ResponseBody
	public String saveInfo(PubProj proj,HttpServletRequest request){
		projBiz.save(proj);
		proj = projBiz.read(proj.getProjFlow());
		setSessionAttribute(GlobalConstant.EDC_CURR_PROJ, proj);
		return GlobalConstant.SAVE_SUCCESSED;		
	}
	
	@RequestMapping(value = "/assignPM",method={RequestMethod.GET,RequestMethod.POST})
	public String assignPM(String projFlow,SysUser search,Model model){		
		
		PubProjUser pubProjUserSearch = new PubProjUser();
		pubProjUserSearch.setProjFlow(projFlow);
		List<PubProjUser> pubProjUserList = projUserBiz.search(pubProjUserSearch);
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
		
		//如果用户没有输入查询条件
		String temp = StringUtil.defaultString(search.getUserName())
				     +StringUtil.defaultString(search.getIdNo())
				     +StringUtil.defaultString(search.getUserPhone())
				     +StringUtil.defaultString(search.getUserEmail())
				     +StringUtil.defaultString(search.getOrgFlow());
		if(StringUtil.isNotBlank(temp)){
			List<SysUser> sysUserList=userBiz.searchUser(search);
			model.addAttribute("sysUserList",sysUserList);
		}	
		return "edc/proj/assignPM";
	}
	
	@RequestMapping(value = "/saveAssign",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String saveAssign(String projFlow,String userFlow,String orgFlow,Model model,HttpServletRequest request){
		String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		
		SysRole sysRole = new SysRole();
		sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
		sysRole.setRoleLevelId(RoleLevelEnum.ProjLevel.getId());
		sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysRole> sysRoleList = roleBiz.search(sysRole);
		String [] roleFlows = new String[sysRoleList.size()];
		int i=0;
		for(SysRole role : sysRoleList){
			roleFlows[i++] = role.getRoleFlow();
		}
		projUserBiz.saveAllot(projFlow,userFlow,orgFlow,wsId,roleFlows);
		return GlobalConstant.SAVE_SUCCESSED;		
	}
	
	@RequestMapping(value = "/editProjParam",method={RequestMethod.GET})
	public String editProjParam(String projFlow,Model model){
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj=projBiz.read(projFlow);
			model.addAttribute("proj", proj);
			EdcProjParam projParam = projBiz.readProjParam(projFlow);
			model.addAttribute("projParam", projParam);
		}
		return "edc/proj/editProjParam";
	} 
	
	@RequestMapping(value={"/modProjParam"},method={RequestMethod.GET})
	@ResponseBody
	public String modProjParam(EdcProjParam param ){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = projBiz.readProjParam(projFlow); 
		param.setProjFlow(projFlow);
		if(StringUtil.isBlank(param.getRandomLock())){
			param.setRandomLock(GlobalConstant.FLAG_N);
		}
		if(StringUtil.isBlank(param.getDesignLock())){
			param.setDesignLock(GlobalConstant.FLAG_N);
		}
		if(StringUtil.isBlank(param.getInputLock())){
			param.setInputLock(GlobalConstant.FLAG_N);
		}
		if(StringUtil.isBlank(param.getInspectLock())){
			param.setInspectLock(GlobalConstant.FLAG_N);
		}
		if(StringUtil.isBlank(param.getProjLock())){
			param.setProjLock(GlobalConstant.FLAG_N);
		}
		if(StringUtil.isNotBlank(param.getInputTypeId())){
			param.setInputTypeName(ProjInputTypeEnum.getNameById(param.getInputTypeId()));
		}
		if(projParam == null){
			projBiz.addProjParam(param);
		}else {
			projBiz.modify(param);
		}
		
		//更新session中项目参数信息		
		projParam = projBiz.readProjParam(projFlow);
		setSessionAttribute(GlobalConstant.EDC_CURR_PROJ_PARAM, projParam);
		
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value={"/view"},method={RequestMethod.GET})
	public String view(Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(edcCurrProj != null){
			String projFlow = edcCurrProj.getProjFlow();
			
			List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("projOrgList", projOrgList);
			
			Map<String,EdcProjOrg> edcProjOrgMap = randomBiz.getEdcPropOrgMap(projFlow);
			model.addAttribute("edcProjOrgMap", edcProjOrgMap);
			
			Map<String,String> inDateMap = patientBiz.getOrgInDateMap(projFlow);
			model.addAttribute("inDateMap", inDateMap);
			
			Map<String,Integer> queryMap = inspectBiz.searchEdcQuery(projFlow);
			model.addAttribute("queryMap",queryMap);
			
			//入组情况
			Map<String,List<PubPatient>> finishCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.Finish.getId()); 
			model.addAttribute("finishCountMap", finishCountMap);
			
			Map<String,List<PubPatient>> offCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.Off.getId()); 
			model.addAttribute("offCountMap", offCountMap);
		}
		return "edc/view/proj";
	}
	
	@RequestMapping(value={"/saveProjOrgLock"},method={RequestMethod.POST})
	@ResponseBody
	public String saveProjOrgLock(String orgFlow,Model model,String lockType){
		if(StringUtil.isNotBlank(orgFlow)){
			PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			String projFlow = edcCurrProj.getProjFlow();
			EdcProjOrg edcProjOrg = projOrgBiz.readEdcProjOrg(projFlow,orgFlow);
			if(edcProjOrg != null){
				if("randomLock".equals(lockType)){
					if(GlobalConstant.LOCK_STATUS_Y.equals(edcProjOrg.getRandomLock())){
						edcProjOrg.setRandomLock(GlobalConstant.LOCK_STATUS_N);
					}else{
						edcProjOrg.setRandomLock(GlobalConstant.LOCK_STATUS_Y);
					}
				}else{
					if(GlobalConstant.LOCK_STATUS_Y.equals(edcProjOrg.getInputLock())){
						edcProjOrg.setInputLock(GlobalConstant.LOCK_STATUS_N);
					}else{
						edcProjOrg.setInputLock(GlobalConstant.LOCK_STATUS_Y);
					}
				}
			}else{
				edcProjOrg = new EdcProjOrg();
				edcProjOrg.setProjFlow(projFlow);
				edcProjOrg.setOrgFlow(orgFlow);
				if("randomLock".equals(lockType)){
					edcProjOrg.setRandomLock(GlobalConstant.LOCK_STATUS_Y);
				}else{
					edcProjOrg.setInputLock(GlobalConstant.LOCK_STATUS_Y);
				}
			}
			int result = projOrgBiz.saveProjOrgLock(edcProjOrg);
			if(result != GlobalConstant.ZERO_LINE){
				 return GlobalConstant.SAVE_SUCCESSED;
			 }
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 入组情况详情
	 * */
	@RequestMapping(value={"/inDetailMain"},method={RequestMethod.GET})
	public String inDetailMain(Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(edcCurrProj != null){
			String projFlow = edcCurrProj.getProjFlow();
			List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("pubProjOrgList",pubProjOrgList);
		}
		
		return "edc/view/inDetailMain";
	}
	
	@RequestMapping(value={"/inDetailList"},method={RequestMethod.GET})
	public String inDetailList(String orgFlow,Model model){
		if(StringUtil.isNotBlank(orgFlow)){
			PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			String projFlow = edcCurrProj.getProjFlow();
			List<PubPatient> patientList = patientBiz.searchPatient(projFlow, orgFlow);
			model.addAttribute("patientList", patientList);
		}
		return "edc/view/inDetailList";
	}
	@RequestMapping(value={"/view/{scope}"},method={RequestMethod.GET})
	public String orgView(@PathVariable String scope,Model model) throws Exception{
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		
		if(edcCurrProj != null){
			/*基本信息*/
			String projFlow = edcCurrProj.getProjFlow();
			PubProj proj = projBiz.read(projFlow);
			model.addAttribute("proj", proj);
			
			/*研究方案*/
			SysUser currUser = GlobalContext.getCurrentUser();
			String orgFlow = currUser.getOrgFlow();
			PubProjOrg projOrg = projOrgBiz.readProjOrg(projFlow, orgFlow);
			model.addAttribute("projOrg", projOrg);
			//项目参数
			EdcProjParam projParam = projBiz.readProjParam(edcCurrProj.getProjFlow());
			model.addAttribute("projParam", projParam);
			//访视次数（is_visit:Y）
			List<EdcVisit> visitList = visitBiz.searchVisitList(projFlow,GlobalConstant.FLAG_Y);
			model.addAttribute("visitNum", visitList==null?0:visitList.size());
			
			Map<String,String> inDateMap = patientBiz.getOrgInDateMap(projFlow);
			Map<String,List<PubPatient>> inCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.In.getId());
			Map<String,List<PubPatient>> finishCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.Finish.getId());
			Map<String,List<PubPatient>> offCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.Off.getId());
			
			//最新入组病例
			String org = "";
			if (scope.equals(GlobalConstant.USER_LIST_LOCAL)) {
				org = orgFlow;
			}
			PubPatient newPatient = patientBiz.searchMaxInDatePatient(projFlow, org);
			model.addAttribute("newPatient", newPatient);
			String newDrugPack = "";
			if (newPatient != null) {
				String patientFlow = newPatient.getPatientFlow();
				RandomInfo info = randomBiz.getRandomInfo(patientFlow);
				if (info != null) {
					if (info.getRandomRec() != null) {
						newDrugPack = info.getRandomRec().getDrugPack();
					}
				}
			}
			model.addAttribute("newDrugPack", newDrugPack);
			
			/*附件*/
			List<ProjFileForm> fileList = projBiz.searchProjFiles(projFlow);
			model.addAttribute("fileList", fileList);
			
			/*疑问管理*/
			Map<String,Integer> queryMap = inspectBiz.searchEdcQuery(projFlow);
			model.addAttribute("queryMap",queryMap);
			//录入情况
			Map<String,String> inputMap = inputBiz.searchEdcPatientVistMap(projFlow);
			model.addAttribute("inputMap",inputMap);
			//sdv核查概况
			Map<String,String> sdvStatusMap = inspectBiz.searchSdvStatus(projFlow);
			model.addAttribute("sdvStatusMap",sdvStatusMap);
			
			if (scope.equals(GlobalConstant.USER_LIST_LOCAL)) {
				/*实施进展*/
				Map<String,String> implemenMap = new HashMap<String,String>();
				implemenMap.put("minInDate",inDateMap.get(orgFlow+"_Min"));
				implemenMap.put("inCount",inDateMap.get(orgFlow+"_Count"));
				implemenMap.put("inNum",inCountMap.get(orgFlow)==null?"0":inCountMap.get(orgFlow).size()+"");
				implemenMap.put("finishCount",finishCountMap.get(orgFlow)==null?"0":finishCountMap.get(orgFlow).size()+"");
				implemenMap.put("offCount",offCountMap.get(orgFlow)==null?"0":offCountMap.get(orgFlow).size()+"");
				model.addAttribute("implemenMap", implemenMap);
				
				/*权限分配*/
				Map<String,List<PubProjUser>> projUserMap = new HashMap<String,List<PubProjUser>>();
				PubProjUser tem = new PubProjUser();
				tem.setProjFlow(projFlow);
				tem.setOrgFlow(orgFlow);
				tem.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				List<PubProjUser> projUserList = projUserBiz.search(tem);
				if (projUserList != null) {
					for (PubProjUser projUser:projUserList) {
						String userFlow = projUser.getUserFlow();
						String userName = "";
						if (StringUtil.isNotBlank(userFlow)) {
							SysUser user = userBiz.readSysUser(userFlow);
							if (user != null) {
								userName = 	user.getUserName();
							}
						}
						projUser.setCreateUserFlow(userName);
						String authUserFlow = projUser.getAuthUserFlow();
						String authUserName = "";
						if (StringUtil.isNotBlank(authUserFlow)) {
							SysUser authUser = userBiz.readSysUser(authUserFlow);
							if (authUser != null) {
								authUserName = authUser.getUserName();
							}
						}
						projUser.setAuthUserFlow(authUserName);
						List<PubProjUser> temp = projUserMap.get(projUser.getRoleFlow());
						if (temp == null) {
							temp = new ArrayList<PubProjUser>();
						}
						temp.add(projUser);
						projUserMap.put(projUser.getRoleFlow(), temp);
					}
				}
				model.addAttribute("projUserMap", projUserMap);
				SysRole sysRole = new SysRole();
				sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
				sysRole.setRoleLevelId(RoleLevelEnum.ProjLevel.getId());
				sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				List<SysRole> sysRoleList = roleBiz.search(sysRole);
				model.addAttribute("sysRoleList", sysRoleList);
				
				/*联系方式*/
				//组长单位
				PubProjOrg leaderOrg = null;
				PubProjOrg orgTemp = new PubProjOrg();
				orgTemp.setProjFlow(projFlow);
				orgTemp.setOrgTypeId(ProjOrgTypeEnum.Leader.getId());
				List<PubProjOrg> projOrgs = projOrgBiz.searchProjOrg(orgTemp);
				if (projOrgs != null && projOrgs.size() >0) {
					leaderOrg = projOrgs.get(0);
				}
				model.addAttribute("leaderOrg", leaderOrg);
			} else if (scope.equals(GlobalConstant.USER_LIST_GLOBAL)) {
				/*参与机构*/
				List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
				model.addAttribute("projOrgList",projOrgList);
				model.addAttribute("inDateMap", inDateMap);
				model.addAttribute("inCountMap", inCountMap);
				model.addAttribute("finishCountMap", finishCountMap);
				model.addAttribute("offCountMap", offCountMap);
			}
		}
		model.addAttribute("scope", scope);
		return "edc/view/proj";
	}
	
	/**
	 * 编辑附件
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editProjFile")
	public String editProjFile(String projFlow, Model model) throws Exception{
		List<ProjFileForm> fileList = projBiz.searchProjFiles(projFlow);
		model.addAttribute("fileList", fileList);
		return "edc/proj/editProjFile";
	}
	
	@RequestMapping(value = "/savePubFile",method={RequestMethod.POST})
	@ResponseBody
	public String savePubFile(@RequestParam(value="file", required=false)MultipartFile[] files,String fileFlow[],String projFlow) throws Exception{
		if(projBiz.savePubFile(files,projFlow) != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value={"/modPubFile"},method={RequestMethod.GET})
	@ResponseBody
	public String modPubFile(String fileFlow,String isShared,String recordStatus,String projFlow) throws Exception{
		if(projBiz.modPubFile(fileFlow,isShared,recordStatus,projFlow) != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value = "/saveProjConfirm",method={RequestMethod.GET})
	@ResponseBody
	public String saveProjConfirm(String projFlow,String projNo, Model model){
		if (StringUtil.isNotBlank(projNo)) {
			//校验项目编号是否重复
			PubProj proj = new PubProj();
			proj.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			proj.setProjNo(projNo);
			List<PubProj> projList = projBiz.search(proj);
			if (projList != null && projList.size() >0) {
				for (PubProj temp:projList) {
					String projNoTemp = temp.getProjNo();
					if ((projNo.equals(projNoTemp)) && (!temp.getProjFlow().equals(projFlow))) {
						return GlobalConstant.OPRE_FAIL; 
					}
				}
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;	
	} 
	
}
