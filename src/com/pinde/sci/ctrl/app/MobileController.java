package com.pinde.sci.ctrl.app;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import sun.misc.BASE64Decoder;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.PyUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IInspectBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.ICfgBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.util.WeixinQiYeUtil;
import com.pinde.sci.dao.base.PubPatientIeMapper;
import com.pinde.sci.dao.edc.PubProjEdcMapper;
import com.pinde.sci.enums.edc.AppResultTypeEnum;
import com.pinde.sci.enums.edc.EdcInputStatusEnum;
import com.pinde.sci.enums.edc.EdcQuerySendWayEnum;
import com.pinde.sci.enums.edc.EdcQuerySolveStatusEnum;
import com.pinde.sci.enums.edc.EdcQueryStatusEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignLabelEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignTypeEnum;
import com.pinde.sci.enums.edc.EdcSdvStatusEnum;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.edc.ProjInputTypeEnum;
import com.pinde.sci.enums.pub.PatientSourceEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.PatientVisitForm;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcPatientVisit;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcQuery;
import com.pinde.sci.model.mo.EdcQueryExample;
import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitDataEvent;
import com.pinde.sci.model.mo.EdcVisitDataEventExample;
import com.pinde.sci.model.mo.EdcVisitModule;
import com.pinde.sci.model.mo.EdcVisitModuleExample;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientIe;
import com.pinde.sci.model.mo.PubPatientIeExample;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysCfg;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.util.PicZoom;
import com.pinde.sci.util.Sign;
import com.sun.image.codec.jpeg.ImageFormatException;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

@Controller
@RequestMapping("/mobile")
public class MobileController extends GeneralController{   
	
	private static Logger logger = LoggerFactory.getLogger(MobileController.class);
	private static String ASSIGN_ROLE_FLOW = "c957155fce78452090d448fc071ca73b";
	
	@Autowired
	private IUserBiz userBiz; 
	@Autowired
	private PubProjEdcMapper pubProjEdcMapper; 
	@Autowired
	private IEdcRandomBiz randomBiz; 
	@Autowired
	private IPubPatientBiz patientBiz; 
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IVisitBiz visitBiz; 
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IEdcModuleBiz moduleBiz;
	@Autowired
	private IInputBiz inputBiz;
	@Autowired
	private IInspectBiz inspectBiz;
	@Autowired
	private ICfgBiz cfgBiz;
	@Autowired
	private IProjUserBiz projUserBiz;
	
	
	
	@RequestMapping(value={"/test"},method={RequestMethod.GET})
	public String test(){
		return "edc/app/test";
	}
	
	@RequestMapping(value={"/login"},method={RequestMethod.GET})
	public String _login(String userCode,String userPasswd,Model model,String callback){
		model.addAttribute("resultId", "200");
		model.addAttribute("resultName","Request Successful");
		model.addAttribute("callback",callback);
		if(StringUtil.isEmpty(userCode)){
			model.addAttribute("resultId","30101");
			model.addAttribute("resultName", "用户名为空");
			return "mobile/login";
		}
		if(StringUtil.isEmpty(userPasswd)){
			model.addAttribute("resultId", "30102");
			model.addAttribute("resultName","密码为空");
			return "mobile/login";
		}
		//查是否存在此用户
		SysUser user = userBiz.findByUserCode(userCode);
		if(user==null){
			user = userBiz.findByUserPhone(userCode); 
		}
		if(user==null){
			System.err.println(userCode);
			System.err.println(userPasswd);
			System.err.println(user);
			model.addAttribute("resultId", "30103");
			model.addAttribute("resultName", "用户名未找到");
		}else{
			if(UserStatusEnum.Locked.getId().equals(user.getStatusId())){
				model.addAttribute("resultId", "30104");
				model.addAttribute("resultName","用户被锁定");
				return "mobile/login";
			}
			//判断密码
			String passwd = StringUtil.defaultString(user.getUserPasswd());
			if(!passwd.equalsIgnoreCase(PasswordHelper.encryptPassword(user.getUserFlow(), userPasswd))){
				model.addAttribute("resultId", "30199");
				model.addAttribute("resultName","用户名或密码错误");
				return "mobile/login";
			}else {
//				SysUserRole userRole = new SysUserRole();
//				userRole.setUserFlow(user.getUserFlow());
//				userRole.setWsId(GlobalConstant.RES_WS_ID);
//				List<SysUserRole> userRoleList = userRoleBiz.searchUserRole(userRole);
//				if(!userRoleList.isEmpty()){
//					userRole = userRoleList.get(0);
//				}
//				
				model.addAttribute("userinfo", user);
//				
//				String roleFlow = userRole.getRoleFlow(); 
//				if (StringUtil.isNotBlank(roleFlow)){
//					SysCfg cfg =  cfgBiz.read("res_doctor_role_flow");
//					String doctorRoleFlow = cfg!=null?cfg.getCfgValue():"";
//					if (roleFlow.equals(doctorRoleFlow)) {//学员
//						model.addAttribute("roleId", "Doctor");
//						model.addAttribute("roleName", "学员");
//					}else {
//						cfg =  cfgBiz.read("res_teacher_role_flow");
//						String teacherRoleFlow = cfg!=null?cfg.getCfgValue():"";
//						if (roleFlow.equals(teacherRoleFlow)) {//带教老师
//							model.addAttribute("roleId", "Teacher");
//							model.addAttribute("roleName", "带教老师");
//						}else {
//							cfg =  cfgBiz.read("res_head_role_flow");
//							String headRoleFlow = cfg!=null?cfg.getCfgValue():"";
//							
//							if (roleFlow.equals(headRoleFlow)) {//科主任
//								model.addAttribute("roleId", "DeptHeader");
//								model.addAttribute("roleName", "科主任");
//							}
//						}
//					}
//				}
			}
		}
		return "mobile/login";
	}
	 
	@RequestMapping(value={"/projList"},method={RequestMethod.GET})
	public String _projList(String userFlow, Model model,String callback) {
//		List<PubProj> projList =  pubProjEdcMapper.selectUserProjListForAssign(userFlow, ASSIGN_ROLE_FLOW);
		Map<String,String> paramMap = new HashMap<String, String>();
		paramMap.put("userFlow", userFlow);
		List<PubProj> projList = pubProjEdcMapper.selectUserProjListForMobile(paramMap); 
		model.addAttribute("projList", projList);
		
		Map<String,Map<String,String>> projMap = new HashMap<String, Map<String,String>>();
		Map<String,List<PubProjOrg>> projOrgMap  = new HashMap<String, List<PubProjOrg>>();
		Map<String,Map<String,Integer>> projOrgCountMap = new HashMap<String, Map<String,Integer>>();
		for(PubProj proj : projList){
			String projFlow =  proj.getProjFlow();
			EdcProjParam projParam = randomBiz.readProjParam(projFlow);
			Map<String,String> dataMap = projMap.get(projFlow);
			Map<String,Integer> orgMap = projOrgCountMap.get(projFlow);
			if(dataMap==null){
				dataMap = new HashMap<String, String>();
			}
			if(orgMap==null){
				orgMap = new HashMap<String, Integer>();
			}
			if(projOrgMap==null){
				projOrgMap = new HashMap<String, List<PubProjOrg>>();
			}
			if(projParam!=null){
				dataMap.put("randomTypeName", GlobalConstant.FLAG_Y.equals(projParam.getIsRandom())?projParam.getRandomTypeName():"非随机"); 
				dataMap.put("blindTypeName",projParam.getBlindTypeName()); 
			}
			List<EdcVisit> visitList = visitBiz.searchVisitList(projFlow,GlobalConstant.FLAG_Y);
			dataMap.put("visitNum", visitList==null?"0":visitList.size()+"");
			
			
			//角色判断
			SysUser user = userBiz.readSysUser(userFlow);
			PubProjUser pubProjUserSearch = new PubProjUser();
			pubProjUserSearch.setProjFlow(projFlow);
			pubProjUserSearch.setUserFlow(userFlow);
			pubProjUserSearch.setOrgFlow(user.getOrgFlow());
			List<PubProjUser> pubProjUserList = projUserBiz.search(pubProjUserSearch);
			boolean PiFlag = false;
			for(PubProjUser pjuser : pubProjUserList){
				String roleFlow = pjuser.getRoleFlow();
				//项目管理员 or 系统管理员
				if("1c4117a2af404d008e800c0550da6084".equals(roleFlow) || "817cf2c8cb5b4dceb689015359d5c209".equals(roleFlow)){
					PiFlag = true;
					break;
				}
			}
			
			List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
			
			Integer totalPatientCount = 0;
			Integer totalInSum = 0;
			Map<String,List<PubPatient>> inCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.In.getId());
			
			List<PubProjOrg> temp = new ArrayList<PubProjOrg>();
			for(PubProjOrg org : projOrgList){
					
					if(PiFlag){
						temp.add(org);
						
						Integer inCount = inCountMap.get(org.getOrgFlow())!=null?inCountMap.get(org.getOrgFlow()).size():0;
						totalInSum+=inCount ;
						orgMap.put(org.getOrgFlow(), inCount);
						
						if(org.getPatientCount()!=null){
							totalPatientCount+= Integer.parseInt(org.getPatientCount());
						}
					}else {
						if(org.getOrgFlow().equals(user.getOrgFlow())){
							temp.add(org);
							
							Integer inCount = inCountMap.get(org.getOrgFlow())!=null?inCountMap.get(org.getOrgFlow()).size():0;
							totalInSum+=inCount ;
							orgMap.put(org.getOrgFlow(), inCount);
							
							if(org.getPatientCount()!=null){
								totalPatientCount+= Integer.parseInt(org.getPatientCount());
							}
						}
					}
			}
			projOrgMap.put(projFlow, temp);
			dataMap.put("totalPatientCount", totalPatientCount+"");
			dataMap.put("totalInSum", totalInSum+"");
			projMap.put(projFlow, dataMap);
			projOrgCountMap.put(projFlow, orgMap);
		}
		model.addAttribute("projMap", projMap);
		model.addAttribute("projOrgMap", projOrgMap);
		model.addAttribute("projOrgCountMap",projOrgCountMap);
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		model.addAttribute("callback",callback);
		return "mobile/projList";
	}
	@RequestMapping(value={"/patientList"},method={RequestMethod.GET})
	public String _patientList(String projFlow,String orgFlow,String userFlow, Model model,String callback) {
		PubProj proj = projBiz.readProject(projFlow);
		SysOrg org = orgBiz.readSysOrg(orgFlow);
		
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow)
		.andOrgFlowEqualTo(orgFlow).andPatientStageIdEqualTo(PatientStageEnum.In.getId()).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId());
		example.setOrderByClause("patient_seq");
		List<PubPatient> patientList =  patientBiz.searchPatient(example);
		
		List<EdcRandomRec> randomList = randomBiz.searchPatientRandom(projFlow, orgFlow);
		Map<String,EdcRandomRec> randomMap = new HashMap<String, EdcRandomRec>(); 
		for(EdcRandomRec rec : randomList){
			randomMap.put(rec.getPatientFlow(), rec);
		}
		
		
		model.addAttribute("patientList", patientList);
		model.addAttribute("randomMap", randomMap);
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		model.addAttribute("callback",callback);
		model.addAttribute("projFlow",projFlow);
		model.addAttribute("projName",proj.getProjName());
		model.addAttribute("orgFlow",orgFlow);
		model.addAttribute("orgName",org.getOrgName());
		return "mobile/patientList";
	}
	@RequestMapping(value={"/savePatient"},method={RequestMethod.POST})
	public String _savePatient(PubPatient patient,HttpServletResponse response,Model model) {
		response.setHeader("Access-Control-Allow-Origin", "*"); //允许哪些url可以跨域请求到本域
		response.setHeader("Access-Control-Allow-Methods","POST"); //允许的请求方法，一般是GET,POST,PUT,DELETE,OPTIONS
		response.setHeader("Access-Control-Allow-Headers","x-requested-with,content-type"); //允许哪些请求头可以跨域
		
		
		String patientName = patient.getPatientName();
		if(StringUtil.isNotBlank(patientName)){
			patient.setPatientNamePy(PyUtil.getFirstSpell(patientName).toUpperCase());
		}
		if(StringUtil.isNotBlank(patient.getSexId())){ 
			patient.setSexName(UserSexEnum.getNameById(patient.getSexId()));
		}
		patient.setPatientStageId(PatientStageEnum.In.getId());
		patient.setPatientStageName(PatientStageEnum.In.getName());
		patient.setPatientTypeId(PatientTypeEnum.Real.getId());
		patient.setPatientTypeName(PatientTypeEnum.Real.getName());
		if(StringUtil.isNotBlank(patient.getPatientSourceId())){
			patient.setPatientSourceName(PatientSourceEnum.getNameById(patient.getPatientSourceId()));
		}
		if(StringUtil.isNotBlank(patient.getInDate())){
			patient.setInDate(DateUtil.transDate(patient.getInDate()));
		}
		PubPatient patientSearch = new PubPatient();
		patientSearch.setProjFlow(patient.getProjFlow());
		patientSearch.setOrgFlow(patient.getOrgFlow());
		patientSearch.setPatientTypeId(PatientTypeEnum.Real.getId());
		List<PubPatient> patientList = patientBiz.searchPatient(patientSearch);
		int patientSeq = 0;
		if(patientList != null && patientList.size()>0){
			for(PubPatient patientTemp : patientList){
				if(patientTemp.getPatientSeq() != null){
					if(patientTemp.getPatientSeq()>patientSeq){
						patientSeq = patientTemp.getPatientSeq();
					}
				}
			}
		}
		patient.setPatientSeq(patientSeq+1);
		patient.setPatientCode(patientSeq+1+"");
		patientBiz.savePatient(patient);
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/savePatient";
	}
	@RequestMapping(value={"/assignPatient"},method={RequestMethod.POST})
	public String _assginPatient(PubPatient patient,String userFlow,HttpServletResponse response,Model model) {
		response.setHeader("Access-Control-Allow-Origin", "*"); //允许哪些url可以跨域请求到本域
		response.setHeader("Access-Control-Allow-Methods","POST"); //允许的请求方法，一般是GET,POST,PUT,DELETE,OPTIONS
		response.setHeader("Access-Control-Allow-Headers","x-requested-with,content-type"); //允许哪些请求头可以跨域
		
		String resultId = AppResultTypeEnum.Success.getId();
		String resultName = AppResultTypeEnum.Success.getName();
		
		String projFlow = patient.getProjFlow();
		String orgFlow = patient.getOrgFlow(); 
		System.err.println("userFlow="+userFlow);
		SysUser user = userBiz.readSysUser(userFlow);
		String patientName = patient.getPatientName();
		
		boolean repeatFlag = _checkRepeatAssign(projFlow,orgFlow,patientName);
		if(repeatFlag){
			resultId = "0324";
			resultName = patientName +"  已存在入组记录,请确认是否重复入组!";
		}else {
			EdcProjParam projParam = randomBiz.readProjParam(projFlow); 
			
			EdcProjOrg projOrg = randomBiz.getEdcPropOrgMap(projFlow).get(orgFlow);
			
			if(_randomLock(projParam,projOrg)){
				resultId = AppResultTypeEnum.RandomLock.getId();
				resultName = AppResultTypeEnum.RandomLock.getName();
			}else {
				List<PubPatient> unAssignPatientList = patientBiz.getUnAssignPatientList(projFlow,orgFlow);
				if(unAssignPatientList.size()>0){
					PubPatient currPatient = patientBiz.readPatient(unAssignPatientList.get(0).getPatientFlow()); 
					currPatient.setPatientBirthday(patient.getPatientBirthday());
					currPatient.setPatientName(patient.getPatientName());
					currPatient.setPatientNamePy(PyUtil.getFirstSpell(patient.getPatientName()).toUpperCase());
					currPatient.setSexId(patient.getSexId());
					currPatient.setSexName(UserSexEnum.getNameById(patient.getSexId()));
					
					
					String callBack = randomBiz.assign(null,projParam,EdcRandomAssignLabelEnum.First.getId(),currPatient,null,EdcRandomAssignTypeEnum.App.getId(),user); 
					
					if(GlobalConstant.RANDOM_FAIL_CFG.equals(callBack)){
						resultId = AppResultTypeEnum.CfgNotFound.getId();
						resultName = AppResultTypeEnum.CfgNotFound.getName();
						
					}else if(GlobalConstant.RANDOM_FAIL_RREC.equals(callBack)){
						
						resultId = AppResultTypeEnum.RecNotFound.getId();
						resultName = AppResultTypeEnum.RecNotFound.getName();
						
					}else if(GlobalConstant.RANDOM_FAIL_DRUG.equals(callBack)){
						resultId = AppResultTypeEnum.DrugNotFound.getId();
						resultName = AppResultTypeEnum.DrugNotFound.getName();
						
					}else if(StringUtil.isNotBlank(callBack) && callBack.indexOf(GlobalConstant.RANDOM_SUCCESSED)>-1){
						model.addAttribute("callBack", callBack);
						
						resultId = AppResultTypeEnum.Success.getId();
						resultName = AppResultTypeEnum.Success.getName();
					}
					
				}else {
					resultId = AppResultTypeEnum.PatientNotFound.getId();
					resultName = AppResultTypeEnum.PatientNotFound.getName();
				}
			}
		}
		model.addAttribute("resultId", resultId);
		model.addAttribute("resultName",resultName);
		return "mobile/assignPatient";
	}
	
	private boolean _checkRepeatAssign(String projFlow, String orgFlow,
			String patientName) {
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andPatientNameEqualTo(patientName).andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		Integer count = patientBiz.count(example);
		return count>=1;
	}

	@RequestMapping(value={"/visitList"},method={RequestMethod.GET})
	private String visitList(String projFlow,String patientFlow,String userFlow,String callback, Model model) {
		model.addAttribute("callback",callback);
		List<EdcVisit> visitList = visitBiz.searchVisitList(projFlow);
		model.addAttribute("visitList", visitList);
		
		EdcVisitModuleExample vmExample = new EdcVisitModuleExample();
		vmExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		List<EdcVisitModule> moduleList = visitBiz.searchVisitModule(vmExample);
		Map<String,List<EdcVisitModule>> visitModuleListMap = new HashMap<String, List<EdcVisitModule>>();
		for(EdcVisitModule vm : moduleList){
			List<EdcVisitModule> temp = visitModuleListMap.get(vm.getVisitFlow());
			if(temp == null){
				temp = new ArrayList<EdcVisitModule>();
			}
			temp.add(vm);
			visitModuleListMap.put(vm.getVisitFlow(), temp);
		}
		 
		List<PubPatientVisit> patientVisit = inputBiz.searchPatientVisit(projFlow, null, patientFlow);
		Map<String,EdcPatientVisit> edcVisitMap = new HashMap<String, EdcPatientVisit>();
		for(PubPatientVisit visit : patientVisit ){
			edcVisitMap.put(visit.getVisitFlow(), inputBiz.readEdcPatientVisit(visit.getRecordFlow())); 
		}
		System.err.println(edcVisitMap);
		model.addAttribute("edcVisitMap",edcVisitMap);
		model.addAttribute("userFlow",userFlow);
		model.addAttribute("visitModuleListMap",visitModuleListMap);
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		
		return "mobile/visitList";
	}
	@RequestMapping(value={"/submitVisit"},method={RequestMethod.GET})
	private String submitVisit(String projFlow,String visitFlow,String patientFlow,String userFlow,String callback, Model model) {
		model.addAttribute("callback",callback);
		
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
		EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
		if(EdcInputStatusEnum.Submit.getId().equals(edcPatientVisit.getInputOper1StatusId())
				||EdcInputStatusEnum.Submit.getId().equals(edcPatientVisit.getInputOper2StatusId())){
			model.addAttribute("resultId", "09003");
			model.addAttribute("resultName","已有录入员进行提交，请保存数据后至Web端核对数据提交!");
			return "mobile/submitVisit";
		}
		//项目参数
		EdcProjParam projParam = inputBiz.readProjParam(projFlow);
		SysUser user = userBiz.readSysUser(userFlow);
		
		setOper(projParam,edcPatientVisit,user,EdcInputStatusEnum.Submit.getId());
		if(userFlow.equals(edcPatientVisit.getInputOper1Flow())||userFlow.equals(edcPatientVisit.getInputOper2Flow())){
			inputBiz.modifyEdcPatientVisit(edcPatientVisit);
		}else {
			model.addAttribute("resultId", "09003");
			model.addAttribute("resultName","无法提交,您不是该访视录入员!");
			return "mobile/submitVisit";
		}
		model.addAttribute("callback",callback);
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		
		return "mobile/submitVisit";
	}
	
	@RequestMapping(value={"/input"},method={RequestMethod.GET})
	private String input(String userFlow,String projFlow,String visitFlow,String moduleCode,String patientFlow,String callback, Model model) {
		model.addAttribute("callback",callback);
		EdcProjParam param = randomBiz.readProjParam(projFlow);
		if(param!=null){
			PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
			if(pateintVisit!=null){
				EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
				if(ProjInputTypeEnum.Single.getId().equals(param)){
					if(pateintVisit!=null&&!edcPatientVisit.getInputOper1Flow().equals(userFlow)){
						model.addAttribute("resultId","09002");
						model.addAttribute("resultName","单份录入,已有录入员  "+edcPatientVisit.getInputOper1Name()+"录入");
						return "mobile/input";
					}
				}else {
					//双份录入
					String inputOperStatusId = edcPatientVisit.getInputOperStatusId();
					if (EdcInputStatusEnum.Checked.getId().equals(inputOperStatusId)) {	//录入完成
						model.addAttribute("inputStatusId", EdcInputStatusEnum.Checked.getId());
						model.addAttribute("oper", "oper3");
					} else {
						if (userFlow.equals(edcPatientVisit.getInputOper1Flow())) {
							model.addAttribute("oper", "oper1");
							model.addAttribute("inputStatusId", edcPatientVisit.getInputOper1StatusId());
						} else if(userFlow.equals(edcPatientVisit.getInputOper2Flow())||StringUtil.isBlank(edcPatientVisit.getInputOper2Flow())){
							model.addAttribute("oper", "oper2");
							model.addAttribute("inputStatusId", edcPatientVisit.getInputOper2StatusId());
						}else {
							model.addAttribute("resultId","09002");
							model.addAttribute("resultName","已存在两位录入员："+edcPatientVisit.getInputOper1Name()+"、"+edcPatientVisit.getInputOper2Name());
							
							return "mobile/input";
						}
					}
				}
				
				
				//页面使用，单次，多次 通用
				Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = 	inputBiz.getelementSerialSeqValueMap(pateintVisit.getRecordFlow());
				model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
			}
			 
			
			EdcModule module = moduleBiz.readEdcModule(projFlow, moduleCode);
			EdcDesignForm projDescForm = moduleBiz.getDescForm(projFlow);
			
			
			model.addAttribute("visitFlow", visitFlow);
			model.addAttribute("module", module);
			model.addAttribute("projDescForm", projDescForm);
			model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
			model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		}else {
			model.addAttribute("resultId","09001");
			model.addAttribute("resultName","项目参数未设置!");
		}
		return "mobile/input";
	}
	
	@RequestMapping(value={"/serialInput"},method={RequestMethod.GET})
	private String serialInput(String userFlow,String projFlow,String visitFlow,String moduleCode,String elementCode,String serialNum, String patientFlow,String callback, Model model) {
		model.addAttribute("callback",callback);
		EdcProjParam param = randomBiz.readProjParam(projFlow);
		if(param!=null){
			PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
			if(pateintVisit!=null){
				EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
				if(ProjInputTypeEnum.Single.getId().equals(param)){
					if(pateintVisit!=null&&!edcPatientVisit.getInputOper1Flow().equals(userFlow)){
						model.addAttribute("resultId","09002");
						model.addAttribute("resultName","单份录入,已有录入员  "+edcPatientVisit.getInputOper1Name()+"录入");
						return "mobile/input";
					}
				}else {
					//双份录入
					String inputOperStatusId = edcPatientVisit.getInputOperStatusId();
					if (EdcInputStatusEnum.Checked.getId().equals(inputOperStatusId)) {	//录入完成
						model.addAttribute("inputStatusId", EdcInputStatusEnum.Checked.getId());
						model.addAttribute("oper", "oper3");
					} else {
						if (userFlow.equals(edcPatientVisit.getInputOper1Flow())) {
							model.addAttribute("oper", "oper1");
							model.addAttribute("inputStatusId", edcPatientVisit.getInputOper1StatusId());
						} else if(userFlow.equals(edcPatientVisit.getInputOper2Flow())||StringUtil.isBlank(edcPatientVisit.getInputOper2Flow())){
							model.addAttribute("oper", "oper2");
							model.addAttribute("inputStatusId", edcPatientVisit.getInputOper2StatusId());
						}else {
							model.addAttribute("resultId","09002");
							model.addAttribute("resultName","已存在两位录入员："+edcPatientVisit.getInputOper1Name()+"、"+edcPatientVisit.getInputOper2Name());
							return "mobile/input";
						}
					}
				}
				//页面使用，单次，多次 通用
				Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = 	inputBiz.getelementSerialSeqValueMap(pateintVisit.getRecordFlow());
				model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
				
				System.err.println(elementSerialSeqValueMap); 
			}
			 
			
			EdcModule module = moduleBiz.readEdcModule(projFlow, moduleCode);
			EdcDesignForm projDescForm = moduleBiz.getDescForm(projFlow);
			
			
			model.addAttribute("visitFlow", visitFlow);
			model.addAttribute("module", module);
			model.addAttribute("elementCode", elementCode);
			model.addAttribute("serialNum", serialNum);
			model.addAttribute("projDescForm", projDescForm);
			model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
			model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		}else {
			model.addAttribute("resultId","09001");
			model.addAttribute("resultName","项目参数未设置!");
		}
		return "mobile/serialInput";
	}
	
	
	@RequestMapping(value={"/saveData"},method={RequestMethod.POST})
	private String saveData(Model model,HttpServletRequest request) {
		Map<String,String> paramMap = new HashMap<String,String>();
		_putAll(paramMap, request);
		System.err.println(paramMap); 
		
		String projFlow = paramMap.get("projFlow");
		String moduleCode = paramMap.get("moduleCode");
		String patientFlow = paramMap.get("patientFlow");
		String visitFlow = paramMap.get("visitFlow");
		String userFlow = paramMap.get("userFlow");
		String elementSerialSeq = paramMap.get("serialNum");
		
		List<String> exceptKey = new ArrayList<String>();
		exceptKey.add("projFlow");
		exceptKey.add("moduleCode");
		exceptKey.add("patientFlow");
		exceptKey.add("visitFlow");
		exceptKey.add("userFlow");
		exceptKey.add("serialNum");
		
		EdcVisit visit = inputBiz.readVisit(visitFlow);
		PubPatient patient = patientBiz.readPatient(patientFlow);
		
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
		EdcPatientVisit edcPatientVisit = null;
		EdcPatientVisitData data = null;
		SysUser currUser = userBiz.readSysUser(userFlow);
		
		if(pateintVisit == null){
			pateintVisit =  _addPatientVisit(patientFlow, visitFlow, projFlow, patient, visit);
			inputBiz.addPatientVisit(pateintVisit);
		}
		
		edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
		if(edcPatientVisit == null ){
			edcPatientVisit = _addEdcPatientVisit(pateintVisit.getRecordFlow());
			setOper(projParam,edcPatientVisit,currUser,EdcInputStatusEnum.Save.getId());
			inputBiz.addEdcPatientVisit(edcPatientVisit);
		}else {
			setOper(projParam,edcPatientVisit,currUser,EdcInputStatusEnum.Save.getId());
			inputBiz.modifyEdcPatientVisit(edcPatientVisit);
		}
		if(StringUtil.isBlank(elementSerialSeq)){ 
			elementSerialSeq = "1"; 
		}
		for(Map.Entry<String, String> entry : paramMap.entrySet()){
			if(!exceptKey.contains(entry.getKey())){
				String attrCode = entry.getKey();
				String value = entry.getValue();
				List<EdcPatientVisitData> visitData = inputBiz.searchPatientVisitData(pateintVisit.getRecordFlow(),attrCode,elementSerialSeq);
				if(visitData!=null && visitData.size()>0){
					data = visitData.get(0);
					setDataValueAndTip(value, currUser, edcPatientVisit, projParam, projParam.getInputTypeId(), data);
					inputBiz.modifyVisitData(data);
				}else {
					EdcAttribute attr = moduleBiz.readAttribute(projFlow, attrCode); 
					data = _addVisitData(visitFlow, patientFlow,
							entry.getKey(), entry.getValue(), elementSerialSeq, currUser, projFlow,
							edcPatientVisit, attr, projParam);
					setDataValueAndTip(value, currUser, edcPatientVisit, projParam, projParam.getInputTypeId(), data);
					inputBiz.addVisitData(data);
				}
				
				inputBiz.modifyVisitData(data);
			}
		}
		
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/saveData";
	}
	@RequestMapping(value={"/sdv"},method={RequestMethod.GET})
	private String sdv(String patientFlow,String visitFlow,String callback, Model model) {
		model.addAttribute("callback",callback);
		model.addAttribute("visitFlow", visitFlow);
		if(StringUtil.isNotBlank(visitFlow)){ 
			PubPatient patient = patientBiz.readPatient(patientFlow);
			String projFlow = patient.getProjFlow();
			
			//页面使用，单次，多次 通用
			PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
			if(pateintVisit!=null){
				EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
				if(EdcInputStatusEnum.Checked.getId().equals(edcPatientVisit.getInputOperStatusId())){
					Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = 	inputBiz.getelementSerialSeqValueMap(pateintVisit.getRecordFlow());
					model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
					EdcDesignForm projDescForm = moduleBiz.getDescForm(projFlow);
					
					model.addAttribute("edcPatientVisit", edcPatientVisit);
					model.addAttribute("projDescForm", projDescForm);
				}else {
					model.addAttribute("resultId","151013");
					model.addAttribute("resultName","该访视未录入完成,无法核查!");
					return "mobile/sdv";
				}
			}else {
				model.addAttribute("resultId","151013");
				model.addAttribute("resultName","该访视未录入完成,无法核查!");
				return "mobile/sdv";
			}
		}
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		
		return "mobile/sdv";
	}
	@RequestMapping(value={"/serialSdv"},method={RequestMethod.GET})
	private String serialSdv(String projFlow,String serialNum,String patientFlow,String visitFlow,String moduleCode,String elementCode,String callback, Model model) {
		model.addAttribute("callback",callback);
			PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
			EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
			//页面使用，单次，多次 通用
			Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = 	inputBiz.getelementSerialSeqValueMap(pateintVisit.getRecordFlow());
			model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
			
			EdcModule module = moduleBiz.readEdcModule(projFlow, moduleCode);
			EdcDesignForm projDescForm = moduleBiz.getDescForm(projFlow);
			
			
			model.addAttribute("visitFlow", visitFlow);
			model.addAttribute("recordFlow", edcPatientVisit.getRecordFlow());
			model.addAttribute("module", module);
			model.addAttribute("elementCode", elementCode);
			model.addAttribute("elementName", projDescForm.getElementMap().get(elementCode).getElementName());
			model.addAttribute("serialNum", serialNum);
			model.addAttribute("projDescForm", projDescForm);
			model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
			model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		
		return "mobile/serialSdv";
	}
	
	@RequestMapping(value={"/auditVisit"},method={RequestMethod.GET})
	private String auditVisit(String recordFlow,String userFlow,String callback, Model model) {
		model.addAttribute("callback",callback);
		if(StringUtil.isNotBlank(recordFlow)){ 
			EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(recordFlow);
			if(edcPatientVisit!=null){
				if(EdcSdvStatusEnum.Sdved.getId().equals(edcPatientVisit.getSdvOperStatusId())){
					model.addAttribute("resultId","151014");
					model.addAttribute("resultName","该访视已核查!");
					return "mobile/auditVisit";
				}else {
					edcPatientVisit.setSdvOperStatusId(EdcSdvStatusEnum.Sdved.getId());
					edcPatientVisit.setSdvOperStatusName(EdcSdvStatusEnum.Sdved.getName());
					edcPatientVisit.setSdvOperFlow(userFlow);
					edcPatientVisit.setSdvOperName(userBiz.readSysUser(userFlow).getUserName());
					edcPatientVisit.setSdvOperTime(DateUtil.getCurrDateTime());
					inputBiz.modifyEdcPatientVisit(edcPatientVisit);
					model.addAttribute("edcPatientVisit", edcPatientVisit);
				}
			}
		}
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		
		return "mobile/auditVisit";
	}
	
	@RequestMapping(value={"/sendQuery"},method={RequestMethod.GET})
	private String sendQuery(String recordFlow,String userFlow,String callback, Model model) {
		model.addAttribute("callback",callback);
		if(StringUtil.isNotBlank(recordFlow)){ 
			EdcPatientVisitData visitData = inputBiz.readEdcPatientVisitData(recordFlow);
			//检测未录入数据属性重复发送疑问问题
			if (visitData == null) {
				String[] keys = StringUtil.split(recordFlow, "_");
				if (keys != null && keys.length>4) {
					String visitRecordFlow = keys[0];
					String elementSerialSeq = keys[3];
					String attrCode = keys[4];
					
					List<EdcPatientVisitData> visitDataList = inputBiz.searchPatientVisitData(visitRecordFlow,attrCode,elementSerialSeq);
					if (visitDataList != null && visitDataList.size() > 0) {
						visitData = visitDataList.get(0);
					}
				}
			}
			if (visitData != null) {
				recordFlow = visitData.getRecordFlow();	
				List<EdcQuery> queryList = inspectBiz.searchUnSolveSdvQuery(recordFlow);
				if(queryList!=null && queryList.size()>0){
					model.addAttribute("resultId", "10142212");
					model.addAttribute("resultName","该数据存在未解决疑问,无发重复发送!");
					return "mobile/sendQuery"; 
				}
			}
			if(visitData==null){
				visitData = _addEmptyVisitData(recordFlow);
			}
				
			EdcDesignForm designForm = moduleBiz.getDescForm(visitData.getProjFlow());
			String visitName = designForm.getVisitMap().get(visitData.getVisitFlow()).getVisitName();
			String moduleName = designForm.getModuleMap().get(visitData.getModuleCode()).getModuleName();
			String elementName = designForm.getElementMap().get(visitData.getElementCode()).getElementName();
			String attrName = designForm.getAttrMap().get(visitData.getAttrCode()).getAttrName();
			PubPatient patient = patientBiz.readPatient(visitData.getPatientFlow());
			SysUser user = userBiz.readSysUser(userFlow);
			String queryContent = visitName+"."+moduleName+"."+elementName+"."+attrName;
			
			EdcQuery query = _addQuery(patient,EdcQuerySendWayEnum.Sdv.getId(),EdcQuerySendWayEnum.Sdv.getName(),GlobalConstant.QUERY_TYPE_SDV,queryContent
					,user);
			
			EdcVisitDataEvent dataEvent = _addDataEvent(designForm,patient,visitData,query);
			
			//修改sdv审核中状态
			EdcPatientVisit patientVisit = inputBiz.readEdcPatientVisit(visitData.getVisitRecordFlow());
			if(StringUtil.isBlank(patientVisit.getSdvOperStatusId())){ 
				patientVisit.setSdvOperStatusId(EdcSdvStatusEnum.Sdving.getId());
				patientVisit.setSdvOperStatusName(EdcSdvStatusEnum.Sdving.getName());
				patientVisit.setSdvOperTime(DateUtil.getCurrDateTime());
				patientVisit.setSdvOperFlow(user.getUserFlow());
				patientVisit.setSdvOperName(user.getUserName());
				inputBiz.modifyEdcPatientVisit(patientVisit);
			}
			
			inspectBiz.addEdcQuery(query,dataEvent);
		}
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/sendQuery";
	}
	
	@RequestMapping(value={"/querylist"},method={RequestMethod.GET})
	private String querylist(String projFlow,String visitFlow,String patientFlow,String callback, Model model) {
		model.addAttribute("callback",callback);
		
		EdcQueryExample example = new EdcQueryExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andPatientFlowEqualTo(patientFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("SEND_TIME");
		List<EdcQuery> queryList = inspectBiz.searchEdcQuery(example);
		model.addAttribute("queryList", queryList);
		
		Map<String,List<EdcVisitDataEvent>> queryEventMap = new HashMap<String, List<EdcVisitDataEvent>>();
		for(EdcQuery query :queryList){
			EdcVisitDataEventExample eventExample = new EdcVisitDataEventExample();
			eventExample.createCriteria().andQueryFlowEqualTo(query.getQueryFlow());
			List<EdcVisitDataEvent> temp = inspectBiz.searchEdcDataVisitEvent(eventExample);
			queryEventMap.put(query.getQueryFlow(), temp);
		}
		model.addAttribute("queryEventMap", queryEventMap);
		
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/queryList";
	}
	@RequestMapping(value={"/patientCase"},method={RequestMethod.GET})
	private String patientCase(String callback,String patientFlow,String visitFlow, Model model) {
		model.addAttribute("callback",callback);
		PubPatient patient = patientBiz.readPatient(patientFlow);
		List<Map<String,String>> dataList = new ArrayList<Map<String,String>>(); 
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(patient.getProjFlow(),visitFlow,patient.getPatientFlow());
		if(pateintVisit!=null && StringUtil.isNotBlank(pateintVisit.getVisitInfo())){
			try {
				Document doc = DocumentHelper.parseText(pateintVisit.getVisitInfo());
				Element rootEle = doc.getRootElement();
				Element PatientCase = rootEle.element("PatientCase");
				if(PatientCase!=null){ 
					List<Element> images = PatientCase.elements("image");
					for(Element ele : images){
						Map<String,String> map = new HashMap<String, String>();
						map.put("imageFlow", ele.attributeValue("imageFlow"));
						map.put("imageUrl", ele.elementText("imageUrl"));
						map.put("thumbUrl", ele.elementText("thumbUrl"));
						map.put("time", ele.elementText("time"));
						map.put("note", ele.elementText("note"));
						dataList.add(map);
					}
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		model.addAttribute("dataList",dataList);
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/patientCase";
	}
	@RequestMapping(value={"/uploadPatientCase"},method={RequestMethod.POST})
	private String uploadPatientCase(String photoData,String patientFlow,String visitFlow, Model model) {
		SysCfg cfg = cfgBiz.read("upload_base_dir");
		String dateString = DateUtil.getCurrDate2();
		String newDir = cfg.getCfgValue()+File.separator+"visitFile"+File.separator +dateString;
		String preffix = DateUtil.getCurrDateTime();
		String suffix = ".jpg";//后缀名
		String fileName = preffix+suffix;
		File fileDir = new File(newDir);
		if(!fileDir.exists()){
			fileDir.mkdirs();
		}
		logger.debug("photoData="+photoData);
		if(StringUtil.isBlank(photoData)){
			model.addAttribute("resultId", "10220852");
			model.addAttribute("resultName","上传失败.图片处理异常.");
			return "mobile/uploadPatientCase";
		}
		try {
			
			BASE64Decoder decoder = new BASE64Decoder();  
            // Base64解码  
        	byte []data = decoder.decodeBuffer(photoData);  
            for (int i = 0; i < data.length; ++i) {  
                if (data[i] < 0) {// 调整异常数据  
                	data[i] += 256;  
                }  
            }  
			File imageFile = new File(fileDir,fileName);  
			FileOutputStream fos = new FileOutputStream(imageFile);
			fos.write(data);
			fos.flush();
			fos.close();
	        //处理缩略图...
			String thumbFileName = preffix+"_thumb"+suffix;
	        File thumbFile = new File(fileDir,thumbFileName); 
	        FileOutputStream thumbfos = new FileOutputStream(thumbFile);
            //调用PicZoom类的静态方法zoom对原始图像进行缩放。   
            BufferedImage buffImg = PicZoom.zoom(data);  
            //创建JPEG图像编码器，用于编码内存中的图像数据到JPEG数据输出流。  
            JPEGImageEncoder jpgEncoder = JPEGCodec.createJPEGEncoder(thumbfos);  
            //编码BufferedImage对象到JPEG数据输出流。  
            jpgEncoder.encode(buffImg);  
            thumbfos.flush();
            thumbfos.close();  
	        //
            addPatientCrfPhoto(patientFlow,visitFlow, dateString, fileName,thumbFileName);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		catch (IOException e) {
			e.printStackTrace(); 
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/uploadPatientCase";
	}

	private void addPatientCrfPhoto(String patientFlow,String visitFlow, String dateString,
			String fileName,  String thumbFileName)
			throws DocumentException {
		String fileFlow = PkUtil.getUUID();
		PubPatient patient = patientBiz.readPatient(patientFlow);
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(patient.getProjFlow(),visitFlow,patientFlow);
		
		Document doc = null;
		SysCfg urlCfg = cfgBiz.read("upload_base_url");
		if(pateintVisit!=null){
			if(StringUtil.isBlank(pateintVisit.getVisitInfo())){
				doc = DocumentHelper.parseText("<visitInfo/>");
			}else {
				doc = DocumentHelper.parseText(pateintVisit.getVisitInfo());
			}
			
			Element rootEle = doc.getRootElement();
			
			Element patientCase = rootEle.element("PatientCase");
			if(patientCase==null){
				patientCase = DocumentHelper.createElement("PatientCase");
				rootEle.add(patientCase);
			}
			Element imgEle = DocumentHelper.createElement("image");
			
			imgEle.addAttribute("imageFlow",fileFlow);
			
			Element imageUrl =  DocumentHelper.createElement("imageUrl");
			imageUrl.setText(urlCfg.getCfgValue()+"/visitFile/"+dateString+"/"+fileName);
			Element thumbUrl =  DocumentHelper.createElement("thumbUrl");
			thumbUrl.setText(urlCfg.getCfgValue()+"/visitFile/"+dateString+"/"+thumbFileName);
			Element time =  DocumentHelper.createElement("time");
			time.setText(DateUtil.transDate(DateUtil.getCurrDateTime(), "yyyy-MM-dd HH:mm:ss"));
			
			imgEle.add(imageUrl);
			imgEle.add(thumbUrl);
			imgEle.add(time);
			
			patientCase.add(imgEle);
			pateintVisit.setVisitInfo(rootEle.asXML());
			inputBiz.modifyPatientVisit(pateintVisit);
		}else {
			pateintVisit = new PubPatientVisit();
			pateintVisit.setProjFlow(patient.getProjFlow());
			pateintVisit.setPatientFlow(patientFlow);
			pateintVisit.setOrgFlow(patient.getOrgFlow());
			pateintVisit.setVisitFlow(visitFlow);
			pateintVisit.setVisitName(visit.getVisitName());
			pateintVisit.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			
			Element rootEle = DocumentHelper.createElement("visitInfo");
			Element patientCaseEle =  rootEle.addElement("PatientCaseEle");
			
			Element imgEle = DocumentHelper.createElement("image");
			imgEle.addAttribute("imageFlow",fileFlow);
			
			Element imageUrl =  DocumentHelper.createElement("imageUrl");
			imageUrl.setText(urlCfg.getCfgValue()+"/visitFile/"+dateString+"/"+fileName);
			Element thumbUrl =  DocumentHelper.createElement("thumbUrl");
			thumbUrl.setText(urlCfg.getCfgValue()+"/visitFile/"+dateString+"/"+thumbFileName);
			Element time =  DocumentHelper.createElement("time");
			time.setText(DateUtil.transDate(DateUtil.getCurrDateTime(), "yyyy-MM-dd HH:mm:ss"));
			
			imgEle.add(imageUrl);
			imgEle.add(thumbUrl);
			imgEle.add(time);
			
			patientCaseEle.add(imgEle);
			pateintVisit.setVisitInfo(rootEle.asXML());
			inputBiz.addPatientVisit(pateintVisit);
		}
	}
	
	@RequestMapping(value={"/savePhotoNote"},method={RequestMethod.POST})
	private String savePhotoNote(String patientFlow,String visitFlow,String imgFlow,String note, Model model) {
		PubPatient patient = patientBiz.readPatient(patientFlow);
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(patient.getProjFlow(),visitFlow,patient.getPatientFlow());
		if(pateintVisit!=null && StringUtil.isNotBlank(pateintVisit.getVisitInfo())){
			try {
				Document doc = DocumentHelper.parseText(pateintVisit.getVisitInfo());
				Element rootEle = doc.getRootElement();
			
				Element ele = (Element)rootEle.selectSingleNode("/visitInfo/PatientCase/image[@imageFlow='"+imgFlow+"']");
				
				Element noteEle =  ele.element("note");
				if(noteEle == null){
					noteEle = DocumentHelper.createElement("note");
					noteEle.setText(note);
					ele.add(noteEle);
				}else {
					noteEle.setText(note);
				}
				pateintVisit.setVisitInfo(rootEle.asXML());
				inputBiz.modifyPatientVisit(pateintVisit);
				
			} catch (DocumentException e) {
				// TODO Auto-generated catch block 
				e.printStackTrace();
			} 
		}
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/savePhotoNote"; 
	}
	
	@RequestMapping(value={"/getSign"},method={RequestMethod.GET})
	private String getTicket(String url,String callback,Model model) {
		String ticket = WeixinQiYeUtil.getjsApiTicket();
		Map<String, String> sign = Sign.sign(ticket, url);
		System.err.println("sign="+sign); 
		model.addAttribute("sign", sign); 
		model.addAttribute("callback",callback);
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/getSign"; 
	}
	
	@RequestMapping(value={"/deletePhoto"},method={RequestMethod.GET})
	private String deletePhoto(String patientFlow,String visitFlow,String callback,String imageFlow,Model model) {
		model.addAttribute("callback",callback);
		PubPatient patient = patientBiz.readPatient(patientFlow);
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(patient.getProjFlow(),visitFlow,patient.getPatientFlow());
		System.err.println(pateintVisit); 
		if(pateintVisit!=null && StringUtil.isNotBlank(pateintVisit.getVisitInfo())){
			try {
				Document doc = DocumentHelper.parseText(pateintVisit.getVisitInfo());
				Element rootEle = doc.getRootElement();
			
				Element ele = (Element)rootEle.selectSingleNode("/visitInfo/PatientCase/image[@imageFlow='"+imageFlow+"']");
				System.err.println(ele); 
				if(ele!=null){
					ele.detach();
				}
				pateintVisit.setVisitInfo(rootEle.asXML());
				inputBiz.modifyPatientVisit(pateintVisit);
				
			} catch (DocumentException e) {
				// TODO Auto-generated catch block 
				e.printStackTrace();
			} 
		}
		
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/deletePhoto";
	}
	
	
	@RequestMapping(value={"/pullPhoto"},method={RequestMethod.GET})
	private String pullPhoto(String patientFlow,String visitFlow,String callback,String serverId,Model model) {
		SysCfg cfg = cfgBiz.read("upload_base_dir");
		String dateString = DateUtil.getCurrDate2();
		String newDir = cfg.getCfgValue()+File.separator+"visitFile"+File.separator +dateString;
		File fileDir = new File(newDir);
		if(!fileDir.exists()){
			fileDir.mkdirs();
		}
		
		String mediaUrl = WeixinQiYeUtil.getMediaUrl(serverId);
		logger.info("=============="+mediaUrl+"=========="+serverId);
		String preffix = PkUtil.getUUID();
		String suffix = ".jpg";//后缀名
		String fileName = preffix+suffix;
		File imageFile = new File(fileDir,fileName);  
		
        httpRequestToFile(imageFile, mediaUrl, "GET", null);
    		
        //处理缩略图...
		String thumbFileName = preffix+"_thumb"+suffix;
        File thumbFile = new File(fileDir,thumbFileName); 
        FileOutputStream thumbfos;
		try {
			thumbfos = new FileOutputStream(thumbFile);
			 //调用PicZoom类的静态方法zoom对原始图像进行缩放。   
	        BufferedImage buffImg = PicZoom.zoom(imageFile.getPath());  
	        //创建JPEG图像编码器，用于编码内存中的图像数据到JPEG数据输出流。  
	        JPEGImageEncoder jpgEncoder = JPEGCodec.createJPEGEncoder(thumbfos);  
	        //编码BufferedImage对象到JPEG数据输出流。  
	        jpgEncoder.encode(buffImg);  
	        thumbfos.flush();
	        thumbfos.close();  
	        
	        addPatientCrfPhoto( patientFlow,visitFlow,  dateString, fileName,   thumbFileName);
		} catch (FileNotFoundException e) {
			e.printStackTrace(); 
		} catch (ImageFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace();
		}
		
        
		model.addAttribute("callback",callback);
		model.addAttribute("resultId", AppResultTypeEnum.Success.getId());
		model.addAttribute("resultName",AppResultTypeEnum.Success.getName());
		return "mobile/pullPhoto"; 
	}
	
	 public static void httpRequestToFile(File imageFile,String path, String method, String body) {
	        if(imageFile==null||path==null||method==null){
	            return ;
	        }
	        HttpURLConnection conn = null;
	        InputStream inputStream = null;
	        FileOutputStream fileOut = null;
	        try {
	            URL url = new URL(path);
	            conn = (HttpURLConnection) url.openConnection();
	            conn.setDoOutput(true);
	            conn.setDoInput(true);
	            conn.setUseCaches(false);
	            conn.setRequestMethod(method);
	            if (null != body) {
	                OutputStream outputStream = conn.getOutputStream();
	                outputStream.write(body.getBytes("UTF-8"));
	                outputStream.close();
	            }
	            inputStream = conn.getInputStream();
//	            if(inputStream!=null){
//	                file = new File(fileName);
//	            }else{
//	                return file;
//	            }

	            //写入到文件
	            fileOut = new FileOutputStream(imageFile);
	            if(fileOut!=null){
	                int c = inputStream.read();
	                while(c!=-1){
	                    fileOut.write(c);
	                    c = inputStream.read();
	                }
	            }
	        } catch (Exception e) {
	            logger.debug("error="+e);
	        }finally{
	            if(conn!=null){
	                conn.disconnect();
	            }
	            /*
	             * 必须关闭文件流
	             * 否则JDK运行时，文件被占用其他进程无法访问
	             */
	            try {
	                inputStream.close();
	                fileOut.close();
	            } catch (IOException execption) {
	                logger.debug("error="+execption.toString());
	            }
	        }
	    }


	
	private EdcPatientVisitData _addEmptyVisitData(String emptyDataKey) {
		EdcPatientVisitData visitData = new EdcPatientVisitData();
		
		String[] keys = StringUtil.split(emptyDataKey, "_");
		String visitRecordFlow = keys[0];
		String moduleCode = keys[1];
		String elementCode = keys[2];
		String elementSerialSeq = keys[3];
		String attrCode = keys[4];
		
		PatientVisitForm patientVisit = inputBiz.selectPatientVisit(visitRecordFlow);
		visitData.setRecordFlow(PkUtil.getUUID());
		visitData.setVisitRecordFlow(visitRecordFlow);
		visitData.setProjFlow(patientVisit.getPatientVisit().getProjFlow());
		visitData.setPatientFlow(patientVisit.getPatientVisit().getPatientFlow());
		visitData.setVisitFlow(patientVisit.getPatientVisit().getVisitFlow());
		visitData.setModuleCode(moduleCode);
		visitData.setElementCode(elementCode);
		visitData.setElementSerialSeq(elementSerialSeq);
		visitData.setAttrCode(attrCode);
		visitData.setAttrValueTip(GlobalConstant.INPUT_TIP_BLANK);
		
		inputBiz.addVisitData(visitData);
		return visitData;
	}
	private EdcVisitDataEvent _addDataEvent(EdcDesignForm designForm,PubPatient patient,EdcPatientVisitData visitData,EdcQuery query) {
		EdcVisitDataEvent event = new EdcVisitDataEvent();
		event.setRecordFlow(PkUtil.getUUID());
		event.setProjFlow(query.getProjFlow());
		event.setOrgFlow(query.getOrgFlow());
		
		event.setPatientFlow(query.getPatientFlow());
		event.setPatientCode(patient.getPatientCode());
		event.setDataRecordFlow(visitData.getRecordFlow());
		
		String visitFlow = visitData.getVisitFlow();
		event.setVisitFlow(visitFlow);
		event.setVisitName(designForm.getVisitMap().get(visitFlow).getVisitName()); 
		
		String moduleCode = visitData.getModuleCode();
		event.setModuleCode(moduleCode);
		event.setModuleName(designForm.getModuleMap().get(moduleCode).getModuleName());
		
		String elementCode = visitData.getElementCode();
		event.setElementCode(elementCode);
		event.setElementName(designForm.getElementMap().get(elementCode).getElementName());
		
		event.setElementSerialSeq(visitData.getElementSerialSeq());
		
		String attrCode = visitData.getAttrCode();
		event.setAttrCode(attrCode);
		event.setAttrName(designForm.getAttrMap().get(attrCode).getAttrName());
		
		
		event.setEventSeq("");
		event.setAttrValue(visitData.getAttrValue());
		event.setQueryFlow(query.getQueryFlow());
		return event;
	}
	private EdcQuery _addQuery(PubPatient patient,String sendWayId,String sendWayName,String queryTypeId,String queryContent,SysUser user) {
		
		EdcQuery query = new EdcQuery();
		query.setQueryFlow(PkUtil.getUUID());
		query.setProjFlow(patient.getProjFlow());
		query.setOrgFlow(patient.getOrgFlow());
		query.setPatientFlow(patient.getPatientFlow());
		query.setPatientCode(patient.getPatientCode());
		
		Integer seq = inspectBiz.searchQuerySeq(patient);
		query.setQuerySeq(++seq);
		query.setQueryStatusId(EdcQueryStatusEnum.Sended.getId());
		query.setQueryStatusName(EdcQueryStatusEnum.Sended.getName());
		query.setSendUserFlow(user.getUserFlow());
		query.setSendUserName(user.getUserName());
		query.setSendTime(DateUtil.getCurrDateTime());
		query.setSendWayId(sendWayId);
		query.setSendWayName(sendWayName);
		query.setQueryTypeId(queryTypeId);
		query.setQueryTypeName(DictTypeEnum.QueryType.getDictNameById(queryTypeId)); 
		query.setQueryContent(queryContent);
		query.setSolveStatusId(EdcQuerySolveStatusEnum.UnSolve.getId());
		query.setSolveStatusName(EdcQuerySolveStatusEnum.UnSolve.getName());
		
		return query;
	}
	
	private EdcPatientVisitData _addVisitData(String visitFlow, String patientFlow,
			String attrCode, String attrValue, String elementSerialSeq,
			SysUser currUser, String projFlow, EdcPatientVisit edcPatientVisit,
			EdcAttribute attr,EdcProjParam param) {
		EdcPatientVisitData data  = new EdcPatientVisitData();
		data.setRecordFlow(PkUtil.getUUID());
		data.setVisitRecordFlow(edcPatientVisit.getRecordFlow());
		data.setVisitFlow(edcPatientVisit.getRecordFlow());
		data.setProjFlow(projFlow);
		data.setPatientFlow(patientFlow);
		data.setVisitFlow(visitFlow);
		data.setModuleCode(attr.getModuleCode());
		data.setElementCode(attr.getElementCode());
		data.setElementSerialSeq(elementSerialSeq);
		data.setAttrCode(attrCode);
		return data;
	}
	private void setDataValueAndTip(String attrValue, SysUser currUser,
			EdcPatientVisit edcPateintVisit, EdcProjParam param,String inputType,
			EdcPatientVisitData data) {
//		String attrValueTip = getAttrValueTip(data,attrValue);
		if(EdcInputStatusEnum.Checked.getId().equals(edcPateintVisit.getInputOperStatusId())){
			data.setAttrValue(attrValue);
//			data.setAttrValueTip(attrValueTip);
			return;
		}
		if(GeneralMethod.isSingleInput(param) || ProjInputTypeEnum.Single.getId().equals(inputType)){
			data.setAttrValue1(attrValue);
			data.setAttrValue2(attrValue);
			data.setAttrValue(attrValue);
//			data.setAttrValue1Tip(attrValueTip);
//			data.setAttrValue2Tip(attrValueTip);
//			data.setAttrValueTip(attrValueTip);
		}else {
			if(currUser.getUserFlow().equals(edcPateintVisit.getInputOper1Flow())){ 
				data.setAttrValue1(attrValue);
//				data.setAttrValue1Tip(attrValueTip);
			}else if(StringUtil.isBlank(edcPateintVisit.getInputOper2Flow())||currUser.getUserFlow().equals(edcPateintVisit.getInputOper2Flow())){
				data.setAttrValue2(attrValue);
//				data.setAttrValue2Tip(attrValueTip);
			}
		}
	}
	
	private void setOper(EdcProjParam projParam,EdcPatientVisit pateintVisit, SysUser currUser,String status) {
		if(EdcInputStatusEnum.Checked.getId().equals(pateintVisit.getInputOperStatusId())){
			return;
		}
		String statusId = EdcInputStatusEnum.Save.getId().equals(status)? EdcInputStatusEnum.Save.getId():EdcInputStatusEnum.Submit.getId();
		String statusName = EdcInputStatusEnum.Save.getId().equals(status)? EdcInputStatusEnum.Save.getName():EdcInputStatusEnum.Submit.getName();
		String time = DateUtil.getCurrDateTime();
		if(GeneralMethod.isSingleInput(projParam) || ProjInputTypeEnum.Single.getId().equals(projParam.getInputTypeId())){
			pateintVisit.setInputOper1Flow(currUser.getUserFlow());
			pateintVisit.setInputOper1Name(currUser.getUserName());
			pateintVisit.setInputOper1StatusId(statusId);
			pateintVisit.setInputOper1StatusName(statusName);
			pateintVisit.setInputOper1Time(time);
			
			pateintVisit.setInputOper2Flow(currUser.getUserFlow());
			pateintVisit.setInputOper2Name(currUser.getUserName());
			pateintVisit.setInputOper2StatusId(statusId);
			pateintVisit.setInputOper2StatusName(statusName);
			pateintVisit.setInputOper2Time(time);
			
			pateintVisit.setInputOperFlow(currUser.getUserFlow());
			pateintVisit.setInputOperName(currUser.getUserName());
			if(EdcInputStatusEnum.Submit.getId().equals(statusId)){
				pateintVisit.setInputOperStatusId(EdcInputStatusEnum.Checked.getId());
				pateintVisit.setInputOperStatusName(EdcInputStatusEnum.Checked.getName());
			}else {
				pateintVisit.setInputOperStatusId(statusId);
				pateintVisit.setInputOperStatusName(statusName);
			}
			pateintVisit.setInputOperTime(time);
			
			
			
		}else {
			if(StringUtil.isBlank(pateintVisit.getInputOper1Flow())){
				pateintVisit.setInputOper1Flow(currUser.getUserFlow());
				pateintVisit.setInputOper1Name(currUser.getUserName());
				pateintVisit.setInputOper1StatusId(statusId);
				pateintVisit.setInputOper1StatusName(statusName);
				pateintVisit.setInputOper1Time(time);
				
			}else {
				if(currUser.getUserFlow().equals(pateintVisit.getInputOper1Flow())){ 
					pateintVisit.setInputOper1StatusId(statusId);
					pateintVisit.setInputOper1StatusName(statusName);
					pateintVisit.setInputOper1Time(time);
				}else if(currUser.getUserFlow().equals(pateintVisit.getInputOper2Flow())||StringUtil.isBlank(pateintVisit.getInputOper2Flow())){
					pateintVisit.setInputOper2Flow(currUser.getUserFlow());
					pateintVisit.setInputOper2Name(currUser.getUserName());
					pateintVisit.setInputOper2StatusId(statusId);
					pateintVisit.setInputOper2StatusName(statusName);
					pateintVisit.setInputOper2Time(time);
				}
			}
			//提交一份数据后 将 核对录入字段标记为 2  另外一份提交判断核对
			if(EdcInputStatusEnum.Submit.getId().equals(statusId)){
				pateintVisit.setInputOperStatusId(statusId);
				pateintVisit.setInputOperStatusName(statusName);
			}
		} 
	}
	private EdcPatientVisit _addEdcPatientVisit(String recordFlow) {
		EdcPatientVisit visit = new EdcPatientVisit();
		visit.setRecordFlow(recordFlow);
		return visit;
	}
	private PubPatientVisit _addPatientVisit(String patientFlow, String visitFlow,
			String projFlow,
			PubPatient patient, EdcVisit visit) {
		PubPatientVisit pateintVisit = new PubPatientVisit();
		pateintVisit.setRecordFlow(PkUtil.getUUID());
		pateintVisit.setProjFlow(projFlow);
		pateintVisit.setPatientFlow(patientFlow);
		pateintVisit.setOrgFlow(patient.getOrgFlow());
		pateintVisit.setVisitFlow(visitFlow);
		pateintVisit.setVisitName(visit.getVisitName());
		return pateintVisit;
	}
	
	private void _putAll(Map<String,String> paramMap,HttpServletRequest request){
		Enumeration<String> paramNames = request.getParameterNames();
		while(paramNames.hasMoreElements()){
			String paramName = paramNames.nextElement();
			String paramValue = request.getParameter(paramName);
			paramMap.put(paramName, paramValue);
		}
	}
	
	private boolean _randomLock(EdcProjParam param,EdcProjOrg projOrg){
		if(param != null && GlobalConstant.FLAG_Y.equals(param.getRandomLock())){
			return true ;
		}
		if(projOrg != null && GlobalConstant.FLAG_Y.equals(projOrg.getRandomLock())){
			return true ;
		}
		return false;
	}
	
}

