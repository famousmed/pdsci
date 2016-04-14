package com.pinde.sci.ctrl.edc;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
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
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.pub.IPubPatientWindowBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.enums.edc.EdcInputStatusEnum;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.gcp.GcpProjStatusEnum;
import com.pinde.sci.enums.pub.PatientSourceEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcPatientVisit;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientWindow;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/enso")
public class EnSoController extends GeneralController{   
	
	private static Logger logger = LoggerFactory.getLogger(EnSoController.class);
	
	@Autowired
	private SysUserMapper userMapper; 
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IProjUserBiz projUserBiz;	
	@Autowired
	private IPubProjBiz projBiz;	
	@Autowired
	private NoticeBiz noticeBiz;
	@Autowired
	private IPubPatientBiz patientBiz;
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IVisitBiz visitBiz;
	@Autowired
	private IEdcModuleBiz edcModuleBiz; 
	@Autowired
	private IInputBiz inputBiz; 
	@Resource
	private IPubPatientWindowBiz patientWindowBiz;
	
	
	@RequestMapping(value={"/main"},method={RequestMethod.GET})
	public String ensoAuth(String projFlow, String roleFlow,Model model,HttpServletRequest request) throws DocumentException{
		PubProj proj = projBiz.readProject(projFlow);
		model.addAttribute("proj", proj);
		
		String projInfo = proj.getProjInfo();
		if(StringUtil.isNotBlank(projInfo)){
			Document doc = DocumentHelper.parseText(projInfo);
			ProjInfoForm projInfoForm = new ProjInfoForm();
			Element e = (Element) doc.selectSingleNode("projInfo/generalInfo");
			if(e != null){
				Element infoElement  = e.element("info");
				Element indicationElement  = e.element("indication");
				Element caseCountElement  = e.element("caseCount");
				
				projInfoForm.setInfo(infoElement == null ? "" : infoElement.getTextTrim());
				projInfoForm.setIndication(indicationElement == null ? "" : indicationElement.getTextTrim());
				projInfoForm.setCaseCount(caseCountElement == null ? "" : caseCountElement.getTextTrim());
				model.addAttribute("projInfoForm", projInfoForm);
			}
		}
		
		
		setSessionAttribute(GlobalConstant.EDC_CURR_PROJ, proj);
		
		if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
			EdcDesignForm designForm = edcModuleBiz.getCrfDescForm(projFlow);
			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
		}
		InxInfo info = new InxInfo();
		List<InxInfo> infos = this.noticeBiz.findNoticeWithBLOBs(info);
		model.addAttribute("infos",infos);
		
		
		
		SysRole role = roleBiz.read(roleFlow); 
		model.addAttribute("role",role);
		
		List<PubPatient> patients = patientBiz.searchPatientByProjFlow(proj.getProjFlow());
		List<PubPatient> orgPatientCount = patientBiz.searchPatient(proj.getProjFlow(),GlobalContext.getCurrentUser().getOrgFlow());
		
		model.addAttribute("totleCount", patients.size());
		model.addAttribute("orgPatientCount", orgPatientCount.size());
		
		if (GlobalConstant.PI_ROLE_FLOW.equals(roleFlow)) {//项目管理员
			return "/enso/pi/index";
		} else if (GlobalConstant.REACHER_ROLE_FLOW.equals(roleFlow)) {//研究者
			return "/enso/reacher/index";
		}else if (GlobalConstant.CRC_ROLE_FLOW.equals(roleFlow)) {//CRC
			return "/enso/crc/index";
		}
		model.addAttribute("loginErrorMessage","登录失败,未发现角色!");
		return "inx/enso/index"; 
	}
	
	@RequestMapping(value={"/followRemind"},method={RequestMethod.GET})
	public String followRemind(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ); 
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		
		List<PubPatientWindow> windowList = patientWindowBiz.searchRemaind(proj.getProjFlow(),orgFlow);
		Map<String,PubPatientWindow > patientVisitMap = new HashMap<String, PubPatientWindow>();
		Map<String,PubPatient> patientMap = new HashMap<String, PubPatient>();
		for(PubPatientWindow window : windowList){
			if(!patientVisitMap.containsKey(window.getPatientFlow())){
				patientVisitMap.put(window.getPatientFlow(), window);
				patientMap.put(window.getPatientFlow(), patientBiz.readPatient(window.getPatientFlow())); 
			}
		}
		model.addAttribute("patientMap",patientMap);
		model.addAttribute("patientVisitMap",patientVisitMap);
		return "enso/reacher/followRemind";
	}
	
	@RequestMapping("/noticelist")
	public String noticeList(Integer currentPage , Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(currentPage,10);
		List<InxInfo> infos = this.noticeBiz.findNotice(info);
		model.addAttribute("infos",infos);
		return "enso/noticelist";
	}
	@RequestMapping(value="/noticeview")
	public String message(Model model,String infoFlow) throws Exception{
		model.addAttribute("msg", noticeBiz.findNoticByFlow(infoFlow));
		return "enso/message";
	}
	@RequestMapping(value="/projlist")
	public String projlist(Model model,String infoFlow) throws Exception{
		
		List<PubProj> projList = projBiz.searchProjListWithBlob(new PubProj());
		
		List<ProjInfoForm> ProjInfoFormList = new ArrayList<ProjInfoForm>();
		for(PubProj proj : projList){
			ProjInfoForm projInfoForm = new ProjInfoForm();
			projInfoForm.setProj(proj);
			String projInfo = proj.getProjInfo();
			if (StringUtil.isNotBlank(projInfo)) {
				System.err.println(proj.getProjFlow());
				Document doc = DocumentHelper.parseText(projInfo);
				Element e = (Element) doc.selectSingleNode("projInfo/generalInfo");
				if(e != null){
					Element infoElement  = e.element("info");
					Element indicationElement  = e.element("indication");
					Element caseCountElement  = e.element("caseCount");
					
					projInfoForm.setInfo(infoElement == null ? "" : infoElement.getTextTrim());
					projInfoForm.setIndication(indicationElement == null ? "" : indicationElement.getTextTrim());
					projInfoForm.setCaseCount(caseCountElement == null ? "" : caseCountElement.getTextTrim());
					model.addAttribute("projInfoForm", projInfoForm);
				}
			}
			ProjInfoFormList.add(projInfoForm);
		}
		
		
		PubProjUser projUser = new PubProjUser();
		projUser.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		List<PubProjUser> projUserList = projUserBiz.search(projUser);
		final Map<String,String> roleMap = new HashMap<String,String>();
		for(PubProjUser pjuser : projUserList){
			roleMap.put(pjuser.getProjFlow(), pjuser.getRoleFlow());
		}
		//排序
		Collections.sort(ProjInfoFormList, new Comparator<ProjInfoForm>() {
			

			@Override
			public int compare(ProjInfoForm p1, ProjInfoForm p2) {
				if(roleMap.containsKey(p1.getProj().getProjFlow()) && roleMap.containsKey(p2.getProj().getProjFlow())){
					return 0;
				}
				if(roleMap.containsKey(p1.getProj().getProjFlow()) && !roleMap.containsKey(p2.getProj().getProjFlow())){
					return -1;
				}
				if(!roleMap.containsKey(p1.getProj().getProjFlow()) && roleMap.containsKey(p2.getProj().getProjFlow())){
					return 1;
				}
				return 0;
			}
			
		});
		
		model.addAttribute("ProjInfoFormList", ProjInfoFormList);
		model.addAttribute("roleMap", roleMap);
		
		//注销edc design
		setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, null);
		
		return "enso/proj";
	}
	@RequestMapping(value="/joinProj")
	@ResponseBody
	public String joinProj(Model model,String projFlow) throws Exception{
		
		PubProjUser pjuser = new PubProjUser();
		pjuser.setProjFlow(projFlow);
		pjuser.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		pjuser.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		pjuser.setRoleFlow(GlobalConstant.REACHER_ROLE_FLOW);
		pjuser.setAuthTime(com.pinde.core.util.DateUtil.getCurrDateTime());
		pjuser.setAuthUserFlow("enso");
		projUserBiz.add(pjuser);
		return  GlobalConstant.SAVE_SUCCESSED;
	}
	@RequestMapping(value="/addPatient")
	public String addPatient(Model model,String projFlow) throws Exception{
		return "enso/reacher/addPatient";
	}
	@RequestMapping(value="/savePatient")
	@ResponseBody
	public String savePatient(Model model,PubPatient patient) throws Exception{
		PubProj proj  = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		patient.setProjFlow(proj.getProjFlow());
		patient.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		patient.setPatientTypeId(PatientTypeEnum.Real.getId());
		patient.setPatientTypeName(PatientTypeEnum.Real.getName());
		if(StringUtil.isNotBlank(patient.getPatientSourceId())){
			patient.setPatientSourceName(PatientSourceEnum.getNameById(patient.getPatientSourceId())); 
		}
		if(StringUtil.isNotBlank(patient.getSexId())){
			patient.setSexName(UserSexEnum.getNameById(patient.getSexId())); 
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
		patient.setPatientStageId(PatientStageEnum.In.getId());
		patient.setPatientStageName(PatientStageEnum.In.getName());
		patient.setInDate(DateUtil.transDate(DateUtil.getCurrDate2(),"yyyy-MM-dd"));
		patient.setInDoctorFlow(GlobalContext.getCurrentUser().getUserFlow());
		patient.setInDoctorName(GlobalContext.getCurrentUser().getUserName());
		patient.setPatientSeq(patientSeq+1);
		patientBiz.savePatient(patient);
		
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	
	
	@RequestMapping(value="/patientList")
	public String patientList( Integer currentPage,Model model,String projFlow,String orgFlow,HttpServletRequest request) throws Exception{
		PageHelper.startPage(currentPage, getPageSize(request));
		
		List<PubPatient> patientList = patientBiz.searchPatient(projFlow,orgFlow);
		model.addAttribute("patientList", patientList);
		model.addAttribute("currentPage", currentPage);
		return "enso/reacher/patientList";
	}
	@RequestMapping(value="/patientInfo")
	public String patientInfo(Model model,String patientFlow) throws Exception{
		PubPatient patient = patientBiz.readPatient(patientFlow);
		model.addAttribute("patient", patient);
		
		String patientCode = patient.getPatientCode();
		
		Map<String,PubProj> projMap = new HashMap<String, PubProj>();
		List<PubPatient> patientList = projBiz.searchPubProjListByPatientCode(patient.getProjFlow(), patientCode,projMap);
		model.addAttribute("patientList", patientList);
		model.addAttribute("projMap", projMap);
		
		return "enso/reacher/patientInfo";
	}
	@RequestMapping(value="/orgList")
	public String orgList(Integer currentPage,Model model,HttpServletRequest request,String orgName,String orgCode) throws Exception{
		PubProj proj  = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		PageHelper.startPage(currentPage, getPageSize(request));
		PubProjOrg pjorg = new PubProjOrg();
		pjorg.setProjFlow(proj.getProjFlow());
		pjorg.setOrgName(orgName);
		List<PubProjOrg> orgList = projOrgBiz.searchProjOrg(pjorg);
		model.addAttribute("orgList", orgList);
		model.addAttribute("orgName", orgName);
		
		List<PubPatient> patients = patientBiz.searchPatientByProjFlow(proj.getProjFlow());
		Integer totleCount = patients.size() ;
		Map<String,Integer> orgPatientCountMap = new HashMap<String, Integer>();
		for(PubPatient patient : patients){
			Integer count  = orgPatientCountMap.get(patient.getOrgFlow());
			if(count == null){
				count = 0;
			}
			orgPatientCountMap.put(patient.getOrgFlow(), ++count);
		}
		model.addAttribute("totleCount", totleCount);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("orgPatientCountMap", orgPatientCountMap);
		return "enso/pi/orgList";
	}
	@RequestMapping(value="/overview")
	public String overview(Integer currentPage,Model model,HttpServletRequest request,String orgName,String orgCode) throws Exception{
		
		return "enso/pi/overview";
	}
	@RequestMapping(value="/visit")
	public String visit(Model model,HttpServletRequest request,String patientFlow,String patientCode) throws Exception{
		System.err.println(patientFlow+"=="+patientCode);
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = patientBiz.readPatient(patientFlow);
			setSessionAttribute(GlobalConstant.EDC_CURR_PATIENT, patient);
		}else if(StringUtil.isNotBlank(patientCode)){
			
			PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			PubPatient patient = patientBiz.readPatientByCode(proj.getProjFlow(),patientCode);
			setSessionAttribute(GlobalConstant.EDC_CURR_PATIENT, patient);
		}
		
		return "enso/reacher/visit";
	}
	@RequestMapping(value="/datainput")
	public String datainput(Model model,HttpServletRequest request,String visitFlow,String operUserFlow) throws Exception{
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		List<EdcVisit> visitList = visitBiz.searchVisitList(proj.getProjFlow());
		model.addAttribute("visitList", visitList);
		
		EdcProjParam param = inputBiz.readProjParam(proj.getProjFlow());
		boolean isSingle = GeneralMethod.isSingleInput(param);
		model.addAttribute("isSingle", isSingle);
		
		
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		setSessionAttribute(GlobalConstant.EDC_CURR_VISIT,visit);
		
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		
		SysUser user = GlobalContext.getCurrentUser();
		if(patient!=null){
			PubPatientVisit pateintVisit = inputBiz.readPatientVisit(proj.getProjFlow(),visitFlow,patient.getPatientFlow());
			if(pateintVisit != null ){
				EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
				model.addAttribute("edcPatientVisit", edcPatientVisit);
				
				
				//页面使用，单次，多次 通用
				Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = 	inputBiz.getelementSerialSeqValueMap(pateintVisit.getRecordFlow());
				model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
	
				if(StringUtil.isBlank(operUserFlow)){
					if(user.getUserFlow().equals(edcPatientVisit.getInputOper1Flow())){
						operUserFlow = edcPatientVisit.getInputOper1Flow();
					}else if(user.getUserFlow().equals(edcPatientVisit.getInputOper2Flow())){
						operUserFlow = edcPatientVisit.getInputOper2Flow();
					}else {
						operUserFlow = edcPatientVisit.getInputOper1Flow();
					}
					
				}
				model.addAttribute("operUserFlow", operUserFlow);
				
				
				//访视窗
				PubPatientWindow window = patientWindowBiz.readPatientWindow(patient.getPatientFlow(), visitFlow);
				model.addAttribute("visitWindow", window);
			}
		
		}
		
		
		
		return "enso/reacher/datainput";
	}
	@RequestMapping(value="/drug")
	public String drug(Model model,HttpServletRequest request) throws Exception{
		
		return "enso/drug/list";
	}
	@RequestMapping(value="/saveData")
	@ResponseBody
	public String saveData(@RequestBody List<EdcPatientVisitData> datas,Model model,HttpServletRequest request,String status,String operUserFlow,String visitDate,String visitWindow) throws Exception{
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = inputBiz.readProjParam(projFlow);
		EdcDesignForm designForm = (EdcDesignForm) getSessionAttribute(GlobalConstant.PROJ_DESC_FORM);
		
		SysUser operUser = userMapper.selectByPrimaryKey(operUserFlow);
		if(operUser == null){
			operUser = GlobalContext.getCurrentUser();
		}
		
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		
		EdcVisit visit = (EdcVisit) getSessionAttribute(GlobalConstant.EDC_CURR_VISIT);
		String visitFlow = visit.getVisitFlow();
		
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
		EdcPatientVisit edcPatientVisit = null;
		EdcPatientVisitData data = null;
		
		if(pateintVisit == null){
			pateintVisit =  _addPatientVisit(patientFlow, visitFlow, projFlow, patient, visit);
			pateintVisit.setVisitDate(visitDate);
			inputBiz.addPatientVisit(pateintVisit);
		}else {
			pateintVisit.setVisitDate(visitDate);
			inputBiz.modifyPatientVisit(pateintVisit);
		}
		
		
		//添加访视窗
		if(StringUtil.isNotBlank(visitWindow)){
			PubPatientWindow window = patientWindowBiz.readPatientWindow(patientFlow,visitFlow);
			String leftWindow = StringUtil.split(visitWindow, "~")[0];
			String rightWindow = StringUtil.split(visitWindow, "~")[1];
			if(window!=null){
				window.setVisitDate(visitDate);
				window.setWindowVisitLeft(leftWindow);
				window.setWindowVisitRight(rightWindow);
				patientWindowBiz.savePatientWindow(window);
			}else {
				window = new PubPatientWindow();
				window.setProjFlow(projFlow);
				window.setOrgFlow(patient.getOrgFlow());
				window.setPatientFlow(patientFlow);
				window.setPatientName(patient.getPatientName());
				window.setPatientCode(patient.getPatientCode());
				window.setInDate(patient.getInDate());
				window.setVisitFlow(visitFlow);
				window.setVisitName(visit.getVisitName());
				window.setVisitDate(visitDate);
				window.setWindowVisitLeft(leftWindow);
				window.setWindowVisitRight(rightWindow);
				patientWindowBiz.savePatientWindow(window);
			}
		}
		edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
		if(edcPatientVisit == null ){
			edcPatientVisit = _addEdcPatientVisit(pateintVisit.getRecordFlow());
			setOper(projParam,edcPatientVisit,operUser,status);
			inputBiz.addEdcPatientVisit(edcPatientVisit);
		}else {
			setOper(projParam,edcPatientVisit,operUser,status );
			inputBiz.modifyEdcPatientVisit(edcPatientVisit);
		}
		
		if(datas!=null && datas.size()>0){
			for(EdcPatientVisitData temp : datas){
				List<EdcPatientVisitData> visitData = inputBiz.searchPatientVisitData(pateintVisit.getRecordFlow(),temp.getAttrCode(),
						temp.getElementSerialSeq()); 
				if(visitData!=null && visitData.size()>0){
					data = visitData.get(0);
					
					setDataValueAndTip(temp.getAttrValue(), operUser, edcPatientVisit, projParam,  data,status);
					inputBiz.modifyVisitData(data);
				}else {
					EdcAttribute attr = designForm.getAttrMap().get(temp.getAttrCode());
					data = _addVisitData(visitFlow, patientFlow,
							temp.getAttrCode(), temp.getAttrValue(), temp.getElementSerialSeq(), operUser, projFlow,
							edcPatientVisit, attr, projParam);
					setDataValueAndTip(temp.getAttrValue(), operUser, edcPatientVisit, projParam,  data,status);
					inputBiz.addVisitData(data);
				}
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
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
	private EdcPatientVisit _addEdcPatientVisit(String recordFlow) {
		EdcPatientVisit visit = new EdcPatientVisit();
		visit.setRecordFlow(recordFlow);
		return visit;
	}
	private void setOper(EdcProjParam projParam,  EdcPatientVisit pateintVisit, SysUser currUser,String status) {
		
		String statusId = EdcInputStatusEnum.Save.getId().equals(status)? EdcInputStatusEnum.Save.getId():EdcInputStatusEnum.Submit.getId();
		String statusName = EdcInputStatusEnum.Save.getId().equals(status)? EdcInputStatusEnum.Save.getName():EdcInputStatusEnum.Submit.getName();
		String time = DateUtil.getCurrDateTime();
		if(GeneralMethod.isSingleInput(projParam)){
			pateintVisit.setInputOper1Flow(currUser.getUserFlow());
			pateintVisit.setInputOper1Name(currUser.getUserName());
			pateintVisit.setInputOper1StatusId(EdcInputStatusEnum.Save.getId());
			pateintVisit.setInputOper1StatusName(EdcInputStatusEnum.Save.getName());
			pateintVisit.setInputOper1Time(time);
			
//			pateintVisit.setInputOper2Flow(currUser.getUserFlow());
//			pateintVisit.setInputOper2Name(currUser.getUserName());
//			pateintVisit.setInputOper2StatusId(EdcInputStatusEnum.Save.getId());
//			pateintVisit.setInputOper2StatusName(EdcInputStatusEnum.Save.getName());
//			pateintVisit.setInputOper2Time(time);
			
			
			if(EdcInputStatusEnum.Submit.getId().equals(statusId)){
				pateintVisit.setInputOperStatusId(EdcInputStatusEnum.Submit.getId());
				pateintVisit.setInputOperStatusName(EdcInputStatusEnum.Submit.getName());
				pateintVisit.setInputOperFlow(currUser.getUserFlow());
				pateintVisit.setInputOperName(currUser.getUserName());
				pateintVisit.setInputOperTime(time);
			}
		}else {
			if(StringUtil.isBlank(pateintVisit.getInputOper1Flow())){
				if(StringUtil.isBlank(pateintVisit.getInputOper1Flow())){ 
					pateintVisit.setInputOper1Flow(currUser.getUserFlow());
					pateintVisit.setInputOper1Name(currUser.getUserName());
				}
				pateintVisit.setInputOper1StatusId(EdcInputStatusEnum.Save.getId());
				pateintVisit.setInputOper1StatusName(EdcInputStatusEnum.Save.getName());
				pateintVisit.setInputOper1Time(time);
				
			}else {
				if(currUser.getUserFlow().equals(pateintVisit.getInputOper1Flow())){
					pateintVisit.setInputOper1Time(time);
				}else if(currUser.getUserFlow().equals(pateintVisit.getInputOper2Flow())||StringUtil.isBlank(pateintVisit.getInputOper2Flow())){
					if(StringUtil.isBlank(pateintVisit.getInputOper2Flow())){ 
						pateintVisit.setInputOper2Flow(currUser.getUserFlow());
						pateintVisit.setInputOper2Name(currUser.getUserName());
					}
					pateintVisit.setInputOper2StatusId(EdcInputStatusEnum.Save.getId());
					pateintVisit.setInputOper2StatusName(EdcInputStatusEnum.Save.getName());
					pateintVisit.setInputOper2Time(time);
				}
			}
			if(EdcInputStatusEnum.Submit.getId().equals(statusId)){
				pateintVisit.setInputOperStatusId(statusId);
				pateintVisit.setInputOperStatusName(statusName);
				pateintVisit.setInputOperFlow(currUser.getUserFlow());
				pateintVisit.setInputOperName(currUser.getUserName());
				pateintVisit.setInputOperTime(time);
			}
		} 
	}
	private void setDataValueAndTip(String attrValue, SysUser currUser,
			EdcPatientVisit edcPateintVisit, EdcProjParam param,
			EdcPatientVisitData data,String statusId) {
		if(GeneralMethod.isSingleInput(param)){
			data.setAttrValue1(attrValue);
			//data.setAttrValue2(attrValue);
			data.setAttrValue(attrValue);
		}else {
			if(currUser.getUserFlow().equals(edcPateintVisit.getInputOper1Flow())){ 
				data.setAttrValue1(attrValue);
			}else if(StringUtil.isBlank(edcPateintVisit.getInputOper2Flow())||currUser.getUserFlow().equals(edcPateintVisit.getInputOper2Flow())){
				data.setAttrValue2(attrValue);
			}
			if(EdcInputStatusEnum.Submit.getId().equals(statusId)){
				data.setAttrValue(attrValue);
			}
		}
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
	
	@RequestMapping(value={"/checkSubmit"},method={RequestMethod.GET})
	@ResponseBody
	public String checkSubmit(Model model,HttpServletRequest request) throws Exception{
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		
		EdcVisit visit = (EdcVisit) getSessionAttribute(GlobalConstant.EDC_CURR_VISIT);
		String visitFlow = visit.getVisitFlow();
		
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
		if(pateintVisit==null){
			return "录二还未保存数据,无法提交";
		}
		EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
		if(edcPatientVisit == null || StringUtil.isBlank(edcPatientVisit.getInputOper2Flow())){
			return "录二还未保存数据,无法提交";
		}else {
			int diffCount = 0;
			List<EdcPatientVisitData> visitData = inputBiz.searchPatientVisitData(pateintVisit.getRecordFlow());
			for(EdcPatientVisitData data : visitData){
				String value1 = data.getAttrValue1();
				String value2 = data.getAttrValue2();
				if(StringUtil.isNotEquals(value1, value2)){
					diffCount++;
				}
			}
			if(diffCount>0){
				return "双份录入存在  "+diffCount+"  处不同,请修改一致后提交";
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
}

