package com.pinde.sci.ctrl.gcp;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.gcp.IGcpCfgBiz;
import com.pinde.sci.biz.gcp.IGcpDrugBiz;
import com.pinde.sci.biz.gcp.IGcpFinBiz;
import com.pinde.sci.biz.gcp.IGcpProjBiz;
import com.pinde.sci.biz.gcp.IGcpQcRecordBiz;
import com.pinde.sci.biz.gcp.IGcpRecBiz;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.biz.pub.IPubMeetingBiz;
import com.pinde.sci.biz.pub.IPubPatientAeBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.pub.IPubTrainBiz;
import com.pinde.sci.biz.pub.IPubTrainUserBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.gcp.GcpDrugStoreStatusEnum;
import com.pinde.sci.enums.gcp.GcpDrugTypeEnum;
import com.pinde.sci.enums.gcp.GcpProjStageEnum;
import com.pinde.sci.enums.gcp.GcpProjStatusEnum;
import com.pinde.sci.enums.gcp.GcpProjSubTypeEnum;
import com.pinde.sci.enums.gcp.GcpQcTypeEnum;
import com.pinde.sci.enums.gcp.GcpRecTypeEnum;
import com.pinde.sci.enums.irb.IrbDecisionEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.form.gcp.GCPMonitorForm;
import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.form.gcp.GcpEvaluationForm;
import com.pinde.sci.form.gcp.GcpIrbForm;
import com.pinde.sci.model.gcp.GcpContractExt;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.irb.ProjOrgForm;
import com.pinde.sci.model.mo.GcpContract;
import com.pinde.sci.model.mo.GcpDrug;
import com.pinde.sci.model.mo.GcpDrugIn;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.GcpQcRecord;
import com.pinde.sci.model.mo.GcpQcRemind;
import com.pinde.sci.model.mo.GcpRec;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubMeeting;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientAe;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjProcessExample;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.PubTrain;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubProjUserExt;
@Controller
@RequestMapping("/gcp/proj")
public class GcpProjController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(GcpProjController.class);
	private static Integer DEFAULT_PAGE_SIZE = 15;//默认分页数大小
	@Autowired
	private IProjUserBiz projUserBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IIrbUserBiz irbUserBiz;
	@Autowired
	private IGcpProjBiz gcpProjBiz;
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IGcpCfgBiz gcpCfgBiz;
	@Autowired
	private IPubMeetingBiz pubMeetingBiz;
	@Autowired
	private IPubTrainUserBiz trainUserBiz;
	@Autowired
	private IGcpFinBiz gcpFinBiz;
	@Autowired
	private IPubPatientBiz patientBiz;
	@Autowired
	private IEdcRandomBiz randomBiz;
	@Autowired
	private IPubPatientBiz pubPatientBiz;
	@Autowired
	private IPubTrainBiz pubTrainBiz;
	@Autowired
	private IGcpDrugBiz gcpDrugBiz;
	@Autowired
	private IGcpRecBiz gcpRecBiz;
	@Autowired
	private IGcpQcRecordBiz qcRecordBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IPubPatientAeBiz patientAeBiz;
	
	/**
	 * 机构项目查询列表
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(PubProj proj, Model model) throws Exception{
		proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
		List<PubProj> projList =  gcpProjBiz.searchProjList(proj);
		model.addAttribute("projList", projList);
		return "gcp/proj/main/list";
	}
	
	/**
	 * 研究者项目列表
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/applyList")
	public String applyList(Model model) throws Exception{
		SysUser currUser = GlobalContext.getCurrentUser();
		PubProj proj = new PubProj();
		proj.setApplyUserFlow(currUser.getUserFlow());
		List<PubProj> projList =  gcpProjBiz.searchProjList(proj);
		model.addAttribute("projList", projList);
		return "gcp/proj/researcher/list";
	}
	
	/**
	 * 项目审核列表
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/checkList")
	public String checkList(PubProj proj, Model model) throws Exception{
		proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		proj.setProjStatusId(GcpProjStatusEnum.Passing.getId());
		List<ProjInfoForm> formList = gcpProjBiz.searchProjFormList(proj);
		model.addAttribute("formList", formList);
		return "gcp/proj/check/list";
	}
	
	
	/**
	 * 跳转到编辑项目信息页面
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public String edit(String projFlow, Model model,String roleScope) throws Exception{
		
		if(StringUtil.isNotBlank(projFlow)){
			ProjInfoForm projInfoForm = gcpProjBiz.searchGeneralInfo(projFlow);
			model.addAttribute("projInfoForm", projInfoForm);
		}
		
		SysDept sysDept = new SysDept();
		sysDept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		List<SysDept> sysDeptList = deptBiz.searchDept(sysDept);
		model.addAttribute("sysDeptList", sysDeptList);
		
		String defalutOrgFlow = InitConfig.getSysCfg("gcp_default_org");
		model.addAttribute("defalutOrgFlow", defalutOrgFlow);
		return "gcp/proj/baseInfo/editProj";
	}

	/**
	 * 机构主界面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/main")
	public String main(Model model){
		/*所有角色*/
		SysUser currentUser = GlobalContext.getCurrentUser();
		List<SysRole> roleList = this.roleBiz.search(currentUser.getUserFlow(), GlobalConstant.GCP_WS_ID);
		StringBuilder sb = new StringBuilder();
		if(roleList!=null&&!roleList.isEmpty()){
			for (SysRole sysRole : roleList) {
				sb.append(sysRole.getRoleName()).append("、");
			}
			sb = sb.deleteCharAt(sb.length()-1);
		}
		model.addAttribute("role", sb.toString());
		/*项目类别*/
		Map<String,Integer> projCountMap = this.gcpProjBiz.countOrgProj(currentUser.getOrgFlow());
		model.addAttribute("projCountMap", projCountMap);
		/*项目概况、机构余额*/
		Map<String,Object> dataMap = this.gcpProjBiz.countOrgData(currentUser.getOrgFlow());
		model.addAttribute("dataMap", dataMap);
		/*项目质控提醒数量*/
		List<GcpQcRemind> qcRemindList = qcRecordBiz.searchQcRemind(currentUser.getOrgFlow());
		if(qcRemindList!=null && qcRemindList.size()>0){
			Map<String,Integer> qcCountMap = new HashMap<String, Integer>();
			for(GcpQcRemind qcRemind : qcRemindList){
				if(qcCountMap.get(qcRemind.getQcTypeId())==null){
					qcCountMap.put(qcRemind.getQcTypeId(),1);
				}else{
					qcCountMap.put(qcRemind.getQcTypeId(),qcCountMap.get(qcRemind.getQcTypeId())+1);
				}
			}
			model.addAttribute("qcCountMap", qcCountMap);
		}
		return "gcp/proj/main/main";
	}

	/**
	 * 项目主界面
	 * @param projFlow
	 * @param view
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/projInfo")
	public String projInfo(String projFlow,String view,Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			//项目基本信息
			PubProj proj = gcpProjBiz.readProject(projFlow);
			model.addAttribute("proj", proj);
			if(proj!=null){
				SysUser applyUser = userBiz.readSysUser(proj.getApplyUserFlow());
				model.addAttribute("applyUser", applyUser);
			}
			//项目进展、总经费
			Map<String,Object> patientCountMap = this.gcpProjBiz.searchPatientCount(projFlow,GlobalContext.getCurrentUser().getOrgFlow());
			PubPatientAe patientAe = new PubPatientAe();
			patientAe.setProjFlow(projFlow);
			patientAe.setOrgFlow(orgFlow);
			patientAe.setIsSae(GlobalConstant.FLAG_Y);
			List<PubPatientAe> patientAeList = patientAeBiz.searchPatientAeList(patientAe);
			patientCountMap.put("saeNum", patientAeList==null?0:patientAeList.size());
			model.addAttribute("patientCountMap", patientCountMap);
			//项目进度
			GcpEvaluationForm evalForm = gcpRecBiz.searchEvaluation(projFlow);
			model.addAttribute("evalForm", evalForm);
			//合同列表
			GcpContract contract = new GcpContract();
			contract.setProjFlow(projFlow);
			List<GcpContractExt> contList = this.gcpFinBiz.searchContractList(proj, contract);
			model.addAttribute("contList", contList);
			//药物信息
			GcpDrug gcpDrug=new GcpDrug();
			gcpDrug.setDrugTypeId(GcpDrugTypeEnum.ExamDrug.getId());
			gcpDrug.setProjFlow(projFlow);
			List<GcpDrug> drugList=gcpDrugBiz.searchDrugList(gcpDrug);
			if(drugList != null && drugList.size() > 0){
				GcpDrug drug = drugList.get(0);
				GcpDrugStoreRec temp = new GcpDrugStoreRec();
				temp.setProjFlow(projFlow);
				temp.setDurgFlow(drug.getDrugFlow());
				temp.setDrugStatusId(GcpDrugStoreStatusEnum.UnSend.getId());
				List<GcpDrugStoreRec> drugRecList = 
				gcpDrugBiz.searchDrugStoreRec(temp);
				int drugPackNum = drugRecList==null?0:drugRecList.size();
				model.addAttribute("drug", drug);
				model.addAttribute("drugPackNum", drugPackNum);
			}
			//伦理列表
			IrbApply apply = new IrbApply();
			apply.setProjFlow(projFlow);
			List<IrbApply> irbList = this.irbApplyBiz.queryIrbApply(apply);
			if (irbList != null && irbList.size() > 3) {	//多于3条，展示第1、2和最后一条
				List<IrbApply> irbs = new ArrayList<IrbApply>();
				irbs.add(irbList.get(0));
				irbs.add(irbList.get(1));
				irbs.add(irbList.get(irbList.size()-1));
				irbList = irbs;
				model.addAttribute("irbFlag", GlobalConstant.FLAG_Y);
			}
			model.addAttribute("irbList", irbList);
			//判断是否有质控提醒
			Map<String,Boolean> qcMap = new HashMap<String,Boolean>();
			List<GcpQcRemind> qcRemindList = qcRecordBiz.searchQcRemind(orgFlow,projFlow,GcpQcTypeEnum.Dept.getId());
			qcMap.put(GlobalConstant.ROLE_SCOPE_RESEARCHER, qcRemindList!= null && qcRemindList.size()>0?true:false);
			qcRemindList = qcRecordBiz.searchQcRemind(orgFlow,projFlow,GcpQcTypeEnum.Org.getId());
			qcMap.put(GlobalConstant.ROLE_SCOPE_GO, qcRemindList!= null && qcRemindList.size()>0?true:false);
			model.addAttribute("qcMap", qcMap);
		}
		
		return "gcp/proj/main/projInfo";
	}
	
	/**
	 * 加载 基本信息
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/loadProcess")
	public String loadProcess(String projFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			List<PubProjProcess> processList = gcpProjBiz.searchProjProcess(projFlow);
			model.addAttribute("processList", processList);
		}
		return "gcp/proj/baseInfo/process";
	}
	
	/**
	 * 加载 基本信息
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/baseInfo")
	public String baseInfo(String projFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			//项目信息
			ProjInfoForm projInfoForm = gcpProjBiz.searchGeneralInfo(projFlow);
			model.addAttribute("projInfoForm", projInfoForm);
			//项目来源/CRO
			ProjInfoForm projInfoForm2 =gcpProjBiz.searchDeclarerAndCRO(projFlow);
			model.addAttribute("projInfoForm2", projInfoForm2);
			//加载监督者
			List<GCPMonitorForm> monitorFormList = gcpProjBiz.searchMonitor(projFlow);
			model.addAttribute("monitorFormList", monitorFormList);
			//临床研究单位
			ProjOrgForm projOrgForm = gcpProjBiz.searchLeader(projFlow);
			List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
			projOrgForm.setProjOrgList(projOrgList);
			model.addAttribute("projOrgForm", projOrgForm);
		}
		return "gcp/proj/baseInfo/baseInfo";
	}
	
	
	/**
	 * 跳转至编辑项目来源/CRO页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/editSponsor")
	public String editSponsor(String projFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			ProjInfoForm projInfoForm =gcpProjBiz.searchDeclarerAndCRO(projFlow);
			model.addAttribute("projInfoForm", projInfoForm);
		}
		return "gcp/proj/baseInfo/editSponsor";
	}
	
	/**
	 * 跳转至编辑临床研究单位页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/editOrg")
	public String editOrg(String projFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			ProjOrgForm projOrgForm = gcpProjBiz.searchLeader(projFlow);
			List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
			projOrgForm.setProjOrgList(projOrgList);
			model.addAttribute("projOrgForm", projOrgForm);
		}
		return "gcp/proj/baseInfo/editOrg";
	}
	
	
	/**
	 * 保存临床研究单位
	 * @return
	 */
	@RequestMapping(value="/saveResearchOrg")
	@ResponseBody
	public String saveResearchOrg(@RequestBody ProjOrgForm projOrgForm, String projFlow){
		int result = gcpProjBiz.addResearchOrg(projOrgForm, projFlow);
		if(result == GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 删除辑临床研究单位
	 * @return
	 */
	@RequestMapping(value="/delProjOrgByRecordFlows")
	@ResponseBody
	public String delProjOrgByRecordFlows(String[] recordFlow){
		if(recordFlow != null && recordFlow.length > 0){
			List<String> recordFlowList = Arrays.asList(recordFlow);
			int result = projOrgBiz.delProjOrgByRecordFlows(recordFlowList);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * 加载 研究团队信息
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/projUser")
	public String projUser(String projFlow, Model model) throws Exception{
		if (StringUtil.isNotBlank(projFlow)) {
			//加载主要研究者
			PubProj proj = gcpProjBiz.readProject(projFlow);
			if(proj != null && StringUtil.isNotBlank(proj.getApplyUserFlow())){
				SysUser researcherUser = userBiz.readSysUser(proj.getApplyUserFlow());
				model.addAttribute("researcherUser", researcherUser);
			}
			model.addAttribute("proj", proj);
			
			//加载项目成员
			PubProjUserExt searchProjUserExt = new PubProjUserExt();
			searchProjUserExt.setProjFlow(projFlow);
			searchProjUserExt.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<PubProjUserExt> projUserExtList = projUserBiz.search(searchProjUserExt);
			model.addAttribute("projUserExtList", projUserExtList);
						
			List<PubProjUserExt> filterList = new ArrayList<PubProjUserExt>();//过滤一个用户多个角色
			//SysUser sysUser = null;
			for(PubProjUserExt projUserExt : projUserExtList){
				//String userFlow = projUserExt.getUserFlow();
				//sysUser = userBiz.readSysUser(userFlow);
				//projUserExt.setUser(sysUser);
				String roleName = projUserExt.getRole().getRoleName();
				projUserExt.setAllRoleName(roleName);
				boolean canAdd = false;
				//过滤一个用户多个角色
				for(PubProjUserExt filterUser : filterList){
					if(projUserExt.getUserFlow().equals(filterUser.getUserFlow())){
						filterUser.setAllRoleName(filterUser.getAllRoleName() +"、"+ roleName);
						canAdd = false;
						break;
					}else{
						canAdd = true;
					}
				}
				if(filterList.isEmpty() || canAdd){
					filterList.add(projUserExt);
				}
			}
			model.addAttribute("filterList", filterList);
			
			SysUser searchSysUser = new SysUser();
			searchSysUser.setOrgFlow(InitConfig.getSysCfg("gcp_default_org"));
			List<SysUser> sysUserList = userBiz.searchUser(searchSysUser);
			Map<String,String> trainDateMap = this.gcpProjBiz.searchGcpTrainDate(sysUserList);//GCP培训日期
			model.addAttribute("trainDateMap", trainDateMap);
		}
		return "gcp/proj/projUser/list";
	}
	@RequestMapping(value="/editResearcher")
	public String editResearcher(){
		return "gcp/proj/projUser/editResearcher";
	}
	
	/**
	 * 跳转至 编辑编辑监督员页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/editInspector")
	public String editInspector(String projFlow, Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			List<GCPMonitorForm> monitorFormList = gcpProjBiz.searchMonitor(projFlow);
			model.addAttribute("monitorFormList", monitorFormList);
		}
		return "gcp/proj/baseInfo/editInspector";
	}
	
	/**
	 * 保存 监督员
	 * @param monitorFormList
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveMonitor")
	@ResponseBody
	public String saveMonitor(@RequestBody List<GCPMonitorForm> monitorFormList, String projFlow) throws Exception{
		if (monitorFormList != null && !monitorFormList.isEmpty() && StringUtil.isNotBlank(projFlow)) {
			int result = gcpProjBiz.saveMonitor(monitorFormList, projFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 删除 监督员
	 * @param id
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/delMonitor")
	@ResponseBody
	public String delMonitor(String[] id, String projFlow) throws Exception{
		if(id.length > 0 && StringUtil.isNotBlank(projFlow)){
			int result = gcpProjBiz.delMonitorByIds(id, projFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	
	/**
	 * 跳转至 编辑项目成员 页面
	 * @param sysUser
	 * @param projFlow
	 * @param roleFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editTeamer")
	public String editTeamer(SysUser sysUser, String projFlow, String roleFlow, Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		String orgFlow = currUser.getOrgFlow();
		SysDept sysDept = new SysDept();
		sysDept.setOrgFlow(InitConfig.getSysCfg("gcp_default_org"));
		List<SysDept> sysDeptList = deptBiz.searchDept(sysDept);
		model.addAttribute("sysDeptList", sysDeptList);
		
		SysUser searchUser = new SysUser();
		searchUser.setOrgFlow(orgFlow);
		searchUser.setDeptFlow(sysUser.getDeptFlow());
		searchUser.setUserName(sysUser.getUserName());
		List<SysUser> userList = userBiz.searchUser(searchUser);//查询同机构下所有成员
		Map<String,String> trainDateMap = this.gcpProjBiz.searchGcpTrainDate(userList);//GCP培训日期
		model.addAttribute("userList", userList);
		model.addAttribute("trainDateMap", trainDateMap);
		
		Map<String,PubProjUser> projUserMap = new HashMap<String, PubProjUser>();//已选中岗位
		if (StringUtil.isNotBlank(projFlow)) {
			PubProjUser searchProjUser = new PubProjUser();
			searchProjUser.setProjFlow(projFlow);
			if(StringUtil.isBlank(roleFlow)){//默认搜索 主要研究者
				roleFlow = InitConfig.getSysCfg(GlobalConstant.RESEARCHER_ROLE_FLOW);
			}
			searchProjUser.setRoleFlow(roleFlow);
			List<PubProjUser> projUserList = projUserBiz.search(searchProjUser);
			if(projUserList != null && !projUserList.isEmpty()){
				for(PubProjUser pu : projUserList){
					for(SysUser su :userList){
						if(su.getUserFlow().equals(pu.getUserFlow())){
							projUserMap.put(pu.getUserFlow(), pu);
						}
					}
				}
			}
			model.addAttribute("projUserMap", projUserMap);
			
			PubProj proj = gcpProjBiz.readProject(projFlow);
			model.addAttribute("proj", proj);
		}
		return "gcp/proj/projUser/editTeamer";
	}
	
	/**
	 * 显示项目审核界面
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/check")
	public String check(String projFlow,Model model)throws Exception{
		ProjInfoForm projForm = gcpProjBiz.searchGeneralInfo(projFlow);
		model.addAttribute("form", projForm);
		return "gcp/proj/check/check";
	}
	
	/**
	 * 选择主要研究者(编辑项目信息)
	 * @param sysUser
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/chooseUser")
	public String chooseUser(SysUser sysUser, String projFlow,Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		String orgFlow = currUser.getOrgFlow();
		SysDept sysDept = new SysDept();
		sysDept.setOrgFlow(orgFlow);
		List<SysDept> sysDeptList = deptBiz.searchDept(sysDept);
		model.addAttribute("sysDeptList", sysDeptList);
		
		SysUser searchUser = new SysUser();
		searchUser.setOrgFlow(orgFlow);
		String deptFlow = sysUser.getDeptFlow();
		if (StringUtil.isNotBlank(projFlow)) {
			PubProj proj = gcpProjBiz.readProject(projFlow);
			if(proj!=null&&(StringUtil.isEmpty(deptFlow)||StringUtil.isBlank(deptFlow))){
				deptFlow = proj.getApplyDeptFlow();
			}
			model.addAttribute("proj", proj);
		}
		searchUser.setDeptFlow(deptFlow);
		searchUser.setUserName(sysUser.getUserName());
		if(StringUtil.isNotBlank(deptFlow)){
			List<SysUser> userList = userBiz.searchUser(searchUser);
			model.addAttribute("userList", userList);
		}
		return "gcp/proj/baseInfo/chooseUser";
	}
	
	/**
	 * 保存主要研究者
	 * @return
	 */
	@RequestMapping(value="/saveResearcher")
	@ResponseBody
	public String saveResearcher(String userFlow,String projFlow,String deptFlow){
		if(StringUtil.isNotBlank(userFlow)&&StringUtil.isNotBlank(projFlow)&&StringUtil.isNotBlank(deptFlow)){
			int result = this.gcpProjBiz.saveResearcher(userFlow, projFlow, deptFlow);
			if(result == GlobalConstant.ONE_LINE ){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value="/irbCheck")
	public String irbCheck(){
		return "gcp/proj/irb/info";
	}
	@RequestMapping(value="/editExpenditure")
	public String editExpenditure(){
		return "gcp/proj/fund/editExpenditure";
	}
	@RequestMapping(value="/editTransfer")
	public String editTransfer(){
		return "gcp/proj/fund/editTransfer";
	}
	@RequestMapping(value ="/qualityControl")
	public String qualityControl(String roleScope,String projFlow,Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		if(StringUtil.isNotBlank(projFlow) && StringUtil.isNotBlank(orgFlow)){
			List<GcpQcRecord> qcRecordList = qcRecordBiz.searchQcRecord(orgFlow, projFlow);
			model.addAttribute("qcRecordList",qcRecordList);
		}
		if(StringUtil.isNotBlank(roleScope)){
			List<GcpQcRemind> qcRemindList = null;
			if(GlobalConstant.ROLE_SCOPE_RESEARCHER.equals(roleScope)){
				qcRemindList = qcRecordBiz.searchQcRemind(orgFlow,projFlow,GcpQcTypeEnum.Dept.getId());
			}else if(GlobalConstant.ROLE_SCOPE_GO.equals(roleScope)){
				qcRemindList = qcRecordBiz.searchQcRemind(orgFlow,projFlow,GcpQcTypeEnum.Org.getId());
			}
			model.addAttribute("qcRemindList",qcRemindList);
		}
		return "gcp/proj/qc/qcRecordList";
	}
	@RequestMapping(value ="/editQC")
	public String editQC(){
		return "gcp/proj/qc/edit";
	}
	@RequestMapping(value="/patientRecord")
	public String patientRecord(String projFlow,Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		if(StringUtil.isNotBlank(projFlow) && StringUtil.isNotBlank(orgFlow)){
			PubPatient temp = new PubPatient();
			temp.setProjFlow(projFlow);
			temp.setOrgFlow(orgFlow);
			temp.setInDate(GlobalConstant.FLAG_N);//查询入组的
			List<PubPatient> patientList = patientBiz.searchPatientList(temp);
			if(patientList!=null && patientList.size()>0){
				//药物编码Map
				List<String> patientFlows = new ArrayList<String>();
				for(PubPatient patient : patientList){
					patientFlows.add(patient.getPatientFlow());
				}
				Map<String,List<String>> patientDrugPackMap = gcpDrugBiz.getPatientDrugPackMap(patientFlows);
				model.addAttribute("patientDrugPackMap",patientDrugPackMap);
				model.addAttribute("patientList",patientList);
			}
		}
		return "gcp/patient/record";
	}
	
	/**
	 * 临床试验项目
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/clinicalTestList")
	public String clinicalTestList(PubProj proj, Integer currentPage,HttpServletRequest request, Model model) throws Exception{
		//承担科室
		SysDept sysDept = new SysDept();
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		sysDept.setOrgFlow(orgFlow);
		sysDept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> sysDeptList = deptBiz.searchDept(sysDept);
		model.addAttribute("sysDeptList",sysDeptList);
		
		//类别 
		List<String> projCategoryIdList = new ArrayList<String>();
		if(StringUtil.isNotBlank(proj.getProjCategoryId())){
			String[] projCategoryIds  = proj.getProjCategoryId().split(",");
			projCategoryIdList = Arrays.asList(projCategoryIds);
			model.addAttribute("projCategoryIdList", projCategoryIdList);
		}
		
		PageHelper.startPage(currentPage, getPageSize(request));
		proj.setApplyOrgFlow(orgFlow);
		proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
		List<PubProj> projList = gcpProjBiz.searchProjList(proj);
		Map<String,ProjInfoForm> projInfoFormMap = gcpProjBiz.projInfoFormMap(projList);
		model.addAttribute("projList", projList);
		model.addAttribute("projInfoFormMap", projInfoFormMap);
		return "gcp/proj/search/list";
	}
	
	/**
	 * 未实施/终止项目
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/terminateList")
	public String terminateList(PubProj proj, Integer currentPage,HttpServletRequest request, Model model) throws Exception{
		//承担科室
		SysDept sysDept = new SysDept();
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		sysDept.setOrgFlow(orgFlow);
		sysDept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> sysDeptList = deptBiz.searchDept(sysDept);
		model.addAttribute("sysDeptList",sysDeptList);
		
		//类别  
		List<String> projCategoryIdList = new ArrayList<String>();
		if(StringUtil.isNotBlank(proj.getProjCategoryId())){
			String[] projCategoryIds  = proj.getProjCategoryId().split(",");
			projCategoryIdList = Arrays.asList(projCategoryIds);
			model.addAttribute("projCategoryIdList", projCategoryIdList);
		}
		
		PageHelper.startPage(currentPage, getPageSize(request));
		List<PubProj> projList = null;
		if(proj != null && StringUtil.isBlank(proj.getProjStatusId()) && StringUtil.isBlank(proj.getProjStageId())){
			projList = gcpProjBiz.queryTerminateProjList();
		}else{
			projList = gcpProjBiz.searchProjList(proj);
		}
		Map<String,ProjInfoForm> projInfoFormMap = gcpProjBiz.projInfoFormMap(projList);
		model.addAttribute("projList", projList);
		model.addAttribute("projInfoFormMap", projInfoFormMap);
		return "gcp/proj/search/terminateList";
	}
	
	/**
	 * 保存研究者和项目
	 * @param proj
	 * @param projInfoForm
	 * @return
	 */
	@RequestMapping(value="/saveProj")
	@ResponseBody
	public String saveProj(PubProj proj,ProjInfoForm projInfoForm,String roleScope){
		String projSubTypeId = proj.getProjSubTypeId();//期类别
		proj.setProjSubTypeName(GcpProjSubTypeEnum.getNameById(projSubTypeId));
		//项目分类
		String projCategoryId = ProjCategroyEnum.Yw.getId();
		if(GcpProjSubTypeEnum.Ky.getId().equals(projSubTypeId)){
			projCategoryId = ProjCategroyEnum.Ky.getId();
		}else if(GcpProjSubTypeEnum.Qx.getId().equals(projSubTypeId)){
			projCategoryId = ProjCategroyEnum.Qx.getId();
		}
		proj.setProjCategoryId(projCategoryId);
		proj.setProjCategoryName(ProjCategroyEnum.getNameById(projCategoryId));
		
		//项目类别（字典）
		proj.setProjTypeName(DictTypeEnum.GcpProjType.getDictNameById(proj.getProjTypeId()));
		//GCP阶段、状态
		proj.setProjStageId(GcpProjStageEnum.Apply.getId());
		proj.setProjStageName(GcpProjStageEnum.getNameById(ProjStageEnum.Apply.getId()));
		proj.setProjStatusId(GcpProjStatusEnum.Edit.getId());
		proj.setProjStatusName(GcpProjStatusEnum.getNameById(GcpProjStatusEnum.Edit.getId()));
		proj.setProjYear(DateUtil.getYear());//项目年份
		
		//其他字段存入proj.projInfo
		String projInfo = gcpProjBiz.addProjInfo(proj, projInfoForm);
		proj.setProjInfo(projInfo);
		
		//主要研究者 
		PubProjUser projUser = null;
		SysUser currUser = GlobalContext.getCurrentUser();
		if (!GlobalConstant.ROLE_SCOPE_DECLARER.equals(roleScope)) {
			String projFlow = proj.getProjFlow();
			String roleFlow = InitConfig.getSysCfg(GlobalConstant.RESEARCHER_ROLE_FLOW);
			if (StringUtil.isNotBlank(projFlow)) {//修改研究者
				PubProj searchProj = gcpProjBiz.readProject(projFlow);
				if (searchProj != null) {
					String oldApplyUserFlow = searchProj.getApplyUserFlow();
					//根据原先的applyUserFlow去查找原先的PubProjUser
					PubProjUser searchProjUser = new PubProjUser();
					searchProjUser.setProjFlow(projFlow);
					searchProjUser.setRoleFlow(roleFlow);
					searchProjUser.setUserFlow(oldApplyUserFlow);
					List<PubProjUser> projUserList = projUserBiz.search(searchProjUser);
					if (projUserList !=  null && !projUserList.isEmpty()) {
						projUser = projUserList.get(0);
						//研究者流水号
						projUser.setUserFlow(proj.getApplyUserFlow());
					}
				}
			}else{//新增
				proj.setApplyOrgFlow(currUser.getOrgFlow());
				proj.setApplyOrgName(currUser.getOrgName());
				proj.setApplyDeptFlow(currUser.getDeptFlow());//承担科室
				proj.setApplyDeptName(currUser.getDeptName());
				proj.setApplyUserFlow(currUser.getUserFlow());//项目负责人
				proj.setApplyUserName(currUser.getUserName());

				//研究者流水号
				projUser = new PubProjUser();
				projUser.setRoleFlow(roleFlow);
				projUser.setUserFlow(currUser.getUserFlow());
				projUser.setOrgFlow(currUser.getOrgFlow());
			}
			projUser.setAuthUserFlow(currUser.getUserFlow());//授权人流水号（当前用户）
			projUser.setAuthTime(DateUtil.getCurrDateTime());//授权时间
		} else {
			String defalutOrgFlow = InitConfig.getSysCfg("gcp_default_org");
			if (StringUtil.isNotBlank(defalutOrgFlow)) {
				proj.setApplyOrgFlow(defalutOrgFlow);
				proj.setApplyOrgName(InitConfig.getOrgNameByFlow(defalutOrgFlow));
			}
		}
		
		int result = gcpProjBiz.saveProjAndProjUser(proj, projUser);
		if(result == GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 保存 项目来源/CRO
	 * @param proj
	 * @param projInfoForm
	 * @return
	 */
	@RequestMapping(value="/saveSponsor")
	@ResponseBody
	public String saveSponsor(PubProj proj,ProjInfoForm projInfoForm){
		int result = gcpProjBiz.addSponsor(proj, projInfoForm);
		if(result == GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}

	@RequestMapping(value="/editDrugIn")
	public String editDrug(String projFlow,String drugFlow,String recordFlow,Model model){
		if(StringUtil.isNotBlank(drugFlow)){
			GcpDrug gcpDrug=gcpDrugBiz.readDrugInfo(drugFlow);
			model.addAttribute("drug", gcpDrug);
		}
		 model.addAttribute("projFlow", projFlow);
		 if(StringUtil.isNotBlank(recordFlow)){
			 GcpDrugIn gcpDrugIn=gcpDrugBiz.readDrugIn(recordFlow);
			 model.addAttribute("drugIn", gcpDrugIn);
		 }
		return "gcp/drug/editDrugIn";
	}
	/**
	 * 提交伦理审查
	 * @param projFlow
	 * @return
	 */
	@RequestMapping(value="/submitIrb")
	@ResponseBody
	public String submitIrb(String projFlow){
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = this.gcpProjBiz.readProject(projFlow);
			if(proj!=null){
				IrbApply apply = new IrbApply();
				apply.setProjFlow(projFlow);
				apply.setIrbTypeId(IrbTypeEnum.Init.getId());
				apply.setIrbTypeName(IrbTypeEnum.Init.getName());
				apply.setIrbStageId(IrbStageEnum.Apply.getId());
				apply.setIrbStageName(IrbStageEnum.Apply.getName());
				apply.setProjNo(proj.getProjNo());
				apply.setProjName(proj.getProjName());
				apply.setProjShortName(proj.getProjShortName());
				apply.setProjSubTypeId(proj.getProjSubTypeId());
				apply.setProjSubTypeName(proj.getProjSubTypeName());
				apply.setProjDeclarer(proj.getProjDeclarer());
				apply.setProjShortDeclarer(proj.getProjShortDeclarer());
				int result = this.irbApplyBiz.edit(apply);
				if(result == GlobalConstant.ONE_LINE){
					return GlobalConstant.OPRE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 伦理详细添加/查看
	 * @param irbFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showAddIrb")
	public String showAddIrb(String irbFlow,Model model){
		if(StringUtil.isNotBlank(irbFlow)){
			IrbApply irb = this.irbApplyBiz.queryByFlow(irbFlow);
			List<IrbUser> irbUserList = irbUserBiz.searchCommitteeList(irbFlow);
			StringBuilder committee = new StringBuilder()  ;	//过滤相同的人 如：主审委员方案和知情同意为同一个人
			List<String> userFlowList = new ArrayList<String>();
			if (irbUserList != null && irbUserList.size() > 0) {
				for (IrbUser user:irbUserList) {
					if (!userFlowList.contains(user.getUserFlow())) {
						committee.append(user.getUserName()).append("、");
						userFlowList.add(user.getUserFlow());
					}
				}
			}
			if(committee.length()>0){
				committee.deleteCharAt(committee.length()-1);
			}
			model.addAttribute("irb", irb);
			model.addAttribute("committee", committee.toString());
		}
		return "gcp/proj/irb/add";
	}
	/**
	 * 添加伦理
	 * @param irb
	 * @return
	 */
	@RequestMapping(value="/addIrb")
	@ResponseBody
	public String addIrb(GcpIrbForm form){
		int result = this.gcpProjBiz.saveIrb(form);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 审查决定列表
	 * @param irbTypeId 伦理类别
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/irbDecisionList")
	public String irbDecisionList(String irbTypeId,Model model){
		if(StringUtil.isNotBlank(irbTypeId)){
			List<IrbDecisionEnum>decisionList = new ArrayList<IrbDecisionEnum>();
			for (IrbDecisionEnum irbDecisionEnum : IrbDecisionEnum.values()) {
				if(irbDecisionEnum.getIrbTypeId().contains(irbTypeId)){
					decisionList.add(irbDecisionEnum);
				}
			}
			model.addAttribute("decisionList", decisionList);
		}
		return "gcp/proj/irb/add";
	}
	/**
	 * 修改项目状态或阶段
	 * @param proj
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/changeProj")
	@ResponseBody
	public String changeProj(PubProjProcess process,String remark,HttpServletRequest req) throws Exception{
		
		process.setRecTypeId("Audit");
		if(GcpProjStatusEnum.Passing.getId().equals(process.getProjStatusId())){
			//提交审核
			process.setRecTypeName("基本信息");
			process.setProcessRemark("提交审核");
			
		}else if(GcpProjStatusEnum.Passed.getId().equals(process.getProjStatusId())){
			//审核通过
			process.setRecTypeName("基本信息");
			process.setProcessRemark(GcpProjStatusEnum.Passed.getName());
		}
		else {
			//审核操作
			String auditContent = remark;
			List<GcpCfgFileForm> fileList = gcpRecBiz.searchApplyFiles(process.getProjFlow());
			for(GcpCfgFileForm file : fileList){ 
				String fileFlow = file.getFileFlow();
				String fileRemark = req.getParameter(fileFlow+"_remark"); 
				if(StringUtil.isNotBlank(fileRemark)){
					String fileName = file.getFileName(); 
					String fileVer = StringUtil.defaultIfEmpty(file.getVersion(),"");
					String fileVerDate = StringUtil.defaultIfEmpty(file.getVersionDate(),"");
					System.err.println("fileRemark"+fileFlow+"_"+fileRemark);;
					if(StringUtil.isNotBlank(auditContent)){
						auditContent+="<br/>";
					}
					if(StringUtil.isNotBlank(fileRemark)){
						auditContent+="["+fileName+"("+fileVer+" "+fileVerDate+")] "+fileRemark;
					}
				}
			}
			process.setAuditContent(auditContent);
			process.setRecTypeName("基本信息");
			process.setProcessRemark(GcpProjStatusEnum.NoPassed.getName());
		}
		int result = this.gcpProjBiz.changeProj(process);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 删除项目
	 * @param projFlow
	 * @return
	 */
	@RequestMapping(value="/delProj",method=RequestMethod.POST)
	@ResponseBody
	public String delProj(String projFlow){
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = new PubProj();
			proj.setProjFlow(projFlow);
			proj.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = gcpProjBiz.modifyProj(proj);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	/**
	 * 审核意见列表
	 * @param projFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/optionList")
	public String optionList(String projFlow,Model model){
		if(StringUtil.isNotBlank(projFlow)){
			List<PubProjProcess> processList = this.gcpProjBiz.optionList(projFlow);
			model.addAttribute("processList", processList);
		}
		return "gcp/proj/researcher/optionList";
	}
	
	@RequestMapping(value="/saveProjMember")
	@ResponseBody
	public String saveProjMember(String[] userFlow, String projFlow, String deptFlow, String roleFlow){
		if(StringUtil.isNotBlank(projFlow)&&StringUtil.isNotBlank(roleFlow)){
			PubProjUserExt userExt = new PubProjUserExt();
			userExt.setProjFlow(projFlow); 
			userExt.setRoleFlow(roleFlow);
			userExt.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			SysUser su = new SysUser();
			su.setDeptFlow(deptFlow);
			userExt.setUser(su);
			List<PubProjUserExt> oldProjUserList = projUserBiz.search(userExt);//获取原先保存的项目成员
			//记录需要删除的
			Map<String,PubProjUser> oldUserMap = new HashMap<String, PubProjUser>();
			/*if(null == oldProjUserList){
				oldProjUserList = new ArrayList<PubProjUser>();
			}*/
			for(PubProjUser pu : oldProjUserList){
				oldUserMap.put(pu.getUserFlow(), pu);
			}
			
			PubProjUser projUser = null;
			if(userFlow != null && userFlow.length > 0){
				for(String flow : userFlow){
					boolean add = true;
					for(PubProjUser oldUser : oldProjUserList){
						if(oldUser.getUserFlow().equals(flow)){
							add = false;//不添加并移除
							if(oldUserMap.size() >0){
								oldUserMap.remove(flow);
							}
							break;
						}
					}
					//新增研究者
					if(add){
						PubProjUser search = new PubProjUser();
						search.setProjFlow(projFlow);
						search.setUserFlow(flow);
						search.setRoleFlow(roleFlow);
						List<PubProjUser> tempList = projUserBiz.search(search);
						if(tempList != null && !tempList.isEmpty()){
							//projUser = projUserBiz.search(search).get(0);
						}else{
							SysUser sysUser = userBiz.readSysUser(flow);
							projUser = new PubProjUser();
							projUser.setProjFlow(projFlow);
							projUser.setUserFlow(flow);
							projUser.setRoleFlow(roleFlow);
							projUser.setOrgFlow(sysUser.getOrgFlow());
							projUser.setAuthTime(DateUtil.getCurrDateTime());
							
							SysUser currUser = GlobalContext.getCurrentUser();
							projUser.setAuthUserFlow(currUser.getUserFlow());
							projUserBiz.editUser(projUser);
						}
					}
				}
			}
			//删除研究者
			if(oldUserMap.size() > 0){
				for(Map.Entry<String, PubProjUser> entry : oldUserMap.entrySet()){
					PubProjUser delUser = entry.getValue();
					delUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
					projUserBiz.editUser(delUser);
				}
			}
			//
			PubProjProcessExample example = new PubProjProcessExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeNameEqualTo("研究团队")
			.andProjFlowEqualTo(projFlow);
			List<PubProjProcess> processList = gcpProjBiz.searchProjProcessExample(example);
			if(processList.size()==0){
				PubProjProcess process = new PubProjProcess();
				process.setProcessFlow(PkUtil.getUUID());
				process.setProjFlow(projFlow);
				process.setProjStageId(GcpProjStageEnum.Apply.getId());
				process.setProjStageName(GcpProjStageEnum.Apply.getName());
				process.setRecTypeName("研究团队");
				process.setProjStatusId("Y");
				process.setProcessRemark("已保存");
				process.setProjStatusName("已保存");
				SysUser currUser = GlobalContext.getCurrentUser();
				process.setOperUserFlow(currUser.getUserFlow());
				process.setOperUserName(currUser.getUserName());
				process.setOperOrgFlow(currUser.getOrgFlow());
				process.setOperOrgName(currUser.getOrgName());
				process.setOperTime(DateUtil.getCurrDateTime());
				process.setRecTypeId("Process");
				GeneralMethod.setRecordInfo(process, true);
				gcpProjBiz.saveProcess(process);
			}
			return GlobalConstant.SAVE_SUCCESSED;
		}
		
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 入组情况详情
	 * */
	@RequestMapping(value={"/inDetailList"},method={RequestMethod.GET})
	public String inDetailList(String orgFlow,String projFlow,Model model){
		if(StringUtil.isNotBlank(orgFlow) && StringUtil.isNotBlank(projFlow)){
			PubPatient temp = new PubPatient();
			temp.setProjFlow(projFlow);
			temp.setOrgFlow(orgFlow);
			temp.setInDate(GlobalConstant.FLAG_N);//查询入组的
			List<PubPatient> patientList = patientBiz.searchPatientList(temp);
			model.addAttribute("patientList", patientList);
		}
		return "gcp/proj/main/inDetailList";
	}
	/**
	 * 机构主界面入组记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/orgInDetailList"},method={RequestMethod.GET})
	public String orgInDetailList(Model model){
		PubPatient patient = new PubPatient();
		patient.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		patient.setInDate(GlobalConstant.FLAG_Y);
		patient.setPatientTypeId(PatientTypeEnum.Real.getId());
		PageHelper.startPage(1, Integer.valueOf(InitConfig.getSysCfg("gcp_org_info_count")));
		List<PubPatient> patientList = pubPatientBiz.searchPatient(patient);
		Map<String,PubProj> projMap = null;
		if(patientList!=null&&!patientList.isEmpty()){
			//药物编码Map
			List<String> patientFlows = new ArrayList<String>();
			projMap =new HashMap<String, PubProj>();
			for (PubPatient pat : patientList) {
				patientFlows.add(pat.getPatientFlow());
				PubProj proj = this.gcpProjBiz.readProject(pat.getProjFlow());
				projMap.put(pat.getPatientFlow(), proj);
			}
			Map<String,List<String>> patientDrugPackMap = gcpDrugBiz.getPatientDrugPackMap(patientFlows);
			model.addAttribute("patientDrugPackMap",patientDrugPackMap);
		}
		model.addAttribute("patientList", patientList);
		model.addAttribute("projMap", projMap);
		return "gcp/proj/main/patientList";
	}
	/**
	 * 机构主界面质控记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/qcRecordList"},method={RequestMethod.GET})
	public String qcRecordList(Model model){
		PageHelper.startPage(1, Integer.valueOf(InitConfig.getSysCfg("gcp_org_info_count")));
		List<GcpQcRecord> qcRecordList = qcRecordBiz.searchQcRecord(GlobalContext.getCurrentUser().getOrgFlow(),null);
		if(qcRecordList!=null && qcRecordList.size()>0){
			Map<String,PubProj> projMap = new HashMap<String, PubProj>();
			for(GcpQcRecord qcRecord : qcRecordList){
				PubProj proj = this.gcpProjBiz.readProject(qcRecord.getProjFlow());
				projMap.put(qcRecord.getQcFlow(), proj);
			}
			model.addAttribute("projMap", projMap);
		}
		model.addAttribute("qcRecordList", qcRecordList);
		return "gcp/proj/main/qcRecordList";
	}
	/**
	 * 机构主界面会议记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/orgMeetingList"},method={RequestMethod.GET})
	public String orgMeetingList(Model model){
		PageHelper.startPage(1, Integer.valueOf(InitConfig.getSysCfg("gcp_org_info_count")));
		List<PubMeeting> meetingList = this.pubMeetingBiz.searchPubMeeting();
		model.addAttribute("meetingList", meetingList);
		return "gcp/proj/main/meetingList";
	}
	/**
	 * 机构主界面培训记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/orgTrainList"},method={RequestMethod.GET})
	public String orgTrainList(Model model){
		PageHelper.startPage(1, Integer.valueOf(InitConfig.getSysCfg("gcp_org_info_count")));
		List<PubTrain> trainList = this.pubTrainBiz.searchList(null);
		model.addAttribute("trainList", trainList);
		return "gcp/proj/main/trainList";
	}
	/**
	 * 按条件查询项目Json
	 * @param projExt
	 * @return
	 */
	@RequestMapping(value="/seachProjListJson")
	@ResponseBody
	public List<PubProj> seachProjListJson(){
		PubProj proj = new PubProj();
		proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		return gcpProjBiz.searchProjList(proj);
	}
	/**
	 * 机构主视图-项目类别查看
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/orgProjList")
	public String orgProjList(PubProj proj,Model model) throws Exception{
		proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
		List<PubProj> projList =  gcpProjBiz.searchProjList(proj);
		model.addAttribute("projList", projList);
		return "gcp/proj/main/orgProjList";
	}
	
	@RequestMapping("/doIrbApply")
	public String doIrbApply(){
		return "/gcp/proj/irb/doApply";
	}
	
	@RequestMapping(value="/declarerMain",method={RequestMethod.POST,RequestMethod.GET})
	public String declarerMain(SysOrg org,Model model){
		org.setOrgTypeId(OrgTypeEnum.Declare.getId());
		List<SysOrg> orgList = orgBiz.searchSysOrg(org);
		model.addAttribute("orgList",orgList);
		
		if(orgList != null && orgList.size()>0){
			Map<String,Map<String,String>> orgInfoFormMap = new HashMap<String,Map<String,String>>();
			for(SysOrg orgTemp : orgList){
				String orgInfo = orgTemp.getOrgInfo();
				Map<String,String> orgInfoMap = getOrgInfo(orgInfo);
				orgInfoFormMap.put(orgTemp.getOrgFlow(),orgInfoMap);
			}
			model.addAttribute("orgInfoFormMap",orgInfoFormMap);
		}
		return "gcp/proj/baseInfo/declarerMain";
	}
	
	/** 
	 * orgInfo内元素
	 * */
	private Map<String,String> getOrgInfo(String orgInfo){
		Map<String,String> orgInfoMap = null;
		if(StringUtil.isNotBlank(orgInfo)){
			try{
				Document dom = DocumentHelper.parseText(orgInfo);
				String xpath = "/orgInfo/info";
				Element headInfoElement = (Element)dom.selectSingleNode(xpath);
				Element headNameElement = null;
				Element headPhoneElement = null;
				if(headInfoElement != null){
					orgInfoMap = new HashMap<String, String>();
					Element value = null;
					headNameElement = (Element)headInfoElement.selectSingleNode("item[@name='orgInfo.name']");
					headPhoneElement = (Element)headInfoElement.selectSingleNode("item[@name='orgInfo.phone']");
					if(headNameElement != null){
						value = (Element)headNameElement.selectSingleNode("value");
						orgInfoMap.put("orgInfo.name",value.getText());
					}
					if(headPhoneElement != null){
						value = (Element)headPhoneElement.selectSingleNode("value");
						orgInfoMap.put("orgInfo.phone",value.getText());
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return orgInfoMap;
	}
	
	@RequestMapping(value="/saveOrg",method={RequestMethod.POST})
	@ResponseBody
	public String saveOrg(SysOrg org,HttpServletRequest request){
		if(org != null){
			org.setOrgTypeId(OrgTypeEnum.Declare.getId());
			org.setOrgTypeName(OrgTypeEnum.Declare.getName());
			String orgInfo = "<orgInfo/>";
			Map<String,String[]> tabMap = request.getParameterMap();
			String headName = (tabMap.get("orgInfo.name"))[0];
			String headPhone = (tabMap.get("orgInfo.phone"))[0];
			try{
				if(StringUtil.isNotBlank(org.getOrgFlow())){
					SysOrg tempOrg = orgBiz.readSysOrg(org.getOrgFlow());
					if(tempOrg != null && StringUtil.isNotBlank(tempOrg.getOrgInfo())){
						orgInfo = tempOrg.getOrgInfo();
					}
				}
				Document dom = DocumentHelper.parseText(orgInfo);
				Element root = dom.getRootElement();
				String xpath = "/orgInfo/info";
				Element headInfoElement = (Element)dom.selectSingleNode(xpath);
				Element headNameElement = null;
				Element headPhoneElement = null;
				Element nameValue = null;
				Element phoneValue = null;
				if(null != headInfoElement){
					headInfoElement = root.element("info");
					headNameElement = (Element)headInfoElement.selectSingleNode("item[@name='orgInfo.name']");
					if(headNameElement != null){
						headNameElement.detach();
					}
					headPhoneElement = (Element)headInfoElement.selectSingleNode("item[@name='orgInfo.phone']");
					if(headPhoneElement != null){
						headPhoneElement.detach();
					}
				}else{
					headInfoElement = root.addElement("info");
				}
				headNameElement = headInfoElement.addElement("item");
				headNameElement.addAttribute("name","orgInfo.name");
				headPhoneElement = headInfoElement.addElement("item");
				headPhoneElement.addAttribute("name","orgInfo.phone");
				nameValue = headNameElement.addElement("value");
				phoneValue = headPhoneElement.addElement("value");
				nameValue.setText(StringUtil.isNotBlank(headName)?headName:"");
				phoneValue.setText(StringUtil.isNotBlank(headPhone)?headPhone:"");
				orgInfo = dom.asXML();
				org.setOrgPhone(headPhone);
			}catch(Exception e){
				e.printStackTrace();
			}
			org.setOrgInfo(orgInfo);
			orgBiz.saveOrg(org);
			return org.getOrgFlow();
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value = {"/editStartConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String editStartConfirm(String projFlow) throws Exception{
		GcpEvaluationForm evalForm = gcpRecBiz.searchEvaluation(projFlow);
		if (evalForm !=null) {
			if (GlobalConstant.FLAG_Y.equals(evalForm.getAgree())) {
				return GlobalConstant.OPRE_SUCCESSED;
			} else {
				return GlobalConstant.OPRE_FAIL_FLAG;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	@RequestMapping(value = {"/loadIrbProv" },method={RequestMethod.GET})
	public String loadIrbProv(String projFlow,Model model) throws Exception{
		IrbApply irb = new IrbApply();
		irb.setProjFlow(projFlow);
		List<IrbApply> irbList = irbApplyBiz.searchIrbApply(irb);
		for(IrbApply irbProv : irbList){
			if(StringUtil.isNotBlank(irbProv.getApproveDate())){
				model.addAttribute("irbProv", irbProv);
				break;
			}
		}
		return "gcp/proj/main/irbProv";
	}
	
}
