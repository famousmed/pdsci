package com.pinde.sci.ctrl.medroad;

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
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.PyUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IEdcProjBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IInspectBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.gcp.IGcpDrugBiz;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.pub.IPubPatientRecipeBiz;
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
import com.pinde.sci.enums.pub.PatientRecipeStatusEnum;
import com.pinde.sci.enums.pub.PatientSourceEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.form.pub.ProjFileForm;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcPatientVisit;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitDataEvent;
import com.pinde.sci.model.mo.GcpDrug;
import com.pinde.sci.model.mo.GcpDrugIn;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientRecipe;
import com.pinde.sci.model.mo.PubPatientRecipeDrug;
import com.pinde.sci.model.mo.PubPatientRecipeExample;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientWindow;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/medroad")
public class MedRoadController extends GeneralController{   
	
	private static Logger logger = LoggerFactory.getLogger(MedRoadController.class);
	
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
	private IEdcProjBiz edcProjBiz;	
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
	@Resource
	private IMsgBiz messageBiz;
	@Autowired
	private IEdcRandomBiz randomBiz;
	@Autowired
	private IGcpDrugBiz gcpDrugBiz;
	@Autowired
	private IPubPatientRecipeBiz recipeBiz;
	@Autowired
	private IInspectBiz inspectBiz; 
	
	@RequestMapping(value={"/main"},method={RequestMethod.GET})
	public String main(String projFlow, String roleFlow,Model model,HttpServletRequest request) throws DocumentException{
		
		return "medroad/main";
	}
	
	@RequestMapping(value={"/index"},method={RequestMethod.GET})
	public String index(String projFlow, String roleFlow,Model model,HttpServletRequest request) throws DocumentException{
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
			return "medroad/edc/pi/index";
		} else if (GlobalConstant.REACHER_ROLE_FLOW.equals(roleFlow)) {//研究者
			//echart
			
			
			Map<String,Object> assignMap = randomBiz.getOrgAssignMap(projFlow,GlobalContext.getCurrentUser().getOrgFlow());
			model.addAttribute("assignMap", assignMap);
			
			
			return "medroad/edc/index";
		}else if (GlobalConstant.CRC_ROLE_FLOW.equals(roleFlow)) {//CRC
			return "medroad/edc/crc/index";
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
		return "medroad/edc/followup/list";
	}
	
	@RequestMapping("/noticelist")
	public String noticeList(Integer currentPage , Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(currentPage,10);
		List<InxInfo> infos = this.noticeBiz.findNotice(info);
		model.addAttribute("infos",infos);
		return "medroad/noticelist";
	}
	@RequestMapping(value="/noticeview")
	public String message(Model model,String infoFlow) throws Exception{
		model.addAttribute("msg", noticeBiz.findNoticByFlow(infoFlow));
		return "medroad/message";
	}
	@RequestMapping(value="/projlist")
	public String projlist(Model model) throws Exception{
		
		List<PubProj> projList = projBiz.searchProjListWithBlob(new PubProj());
		
		List<ProjInfoForm> ProjInfoFormList = new ArrayList<ProjInfoForm>();
		for(PubProj proj : projList){
			ProjInfoForm projInfoForm = new ProjInfoForm();
			projInfoForm.setProj(proj);
			String projInfo = proj.getProjInfo();
			if (StringUtil.isNotBlank(projInfo)) {
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
		
		return "medroad/edc/proj/list";
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
	@RequestMapping(value="proj/info")
	public String projInfo(Model model) throws Exception{
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		model.addAttribute("proj", proj);
		ProjInfoForm projInfoForm = new ProjInfoForm();
		projInfoForm.setProj(proj);
		String projInfo = proj.getProjInfo();
		if (StringUtil.isNotBlank(projInfo)) {
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
		
		return "medroad/edc/proj/info";
	}
	@RequestMapping(value="/addPatient")
	public String addPatient(Model model,String projFlow) throws Exception{
		return "medroad/edc/reacher/addPatient";
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
		patient.setPatientNamePy(PyUtil.getFirstSpell(patient.getPatientName()).toUpperCase());
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
	public String patientList( Integer currentPage,Model model,PubPatient patient,HttpServletRequest request) throws Exception{
		PageHelper.startPage(currentPage, getPageSize(request));
		
		List<PubPatient> patientList = patientBiz.searchPatientExt(patient);
		
		model.addAttribute("patientList", patientList);
		model.addAttribute("currentPage", currentPage);
		return "medroad/edc/reacher/patientList";
	}
	@RequestMapping(value="/patientInfo")
	public String patientInfo(Model model,String patientFlow) throws Exception{
		PubPatient patient = patientBiz.readPatient(patientFlow);
		model.addAttribute("patient", patient);
		
		String patientCode = patient.getPatientCode();
		
		Map<String,ProjInfoForm> projMap = new HashMap<String, ProjInfoForm>();
		List<PubPatient> patientList = projBiz.searchPubProjListByPatientCode(patient.getProjFlow(), patientCode,projMap);
		model.addAttribute("patientList", patientList);
		model.addAttribute("projMap", projMap);
		
		return "medroad/edc/reacher/patientInfo";
	}
	@RequestMapping(value="/proj/path")
	public String path(Model model,String patientFlow) throws Exception{
		return "medroad/edc/proj/path";
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
		return "medroad/edc/pi/orgList";
	}
	@RequestMapping(value="/overview")
	public String overview(Integer currentPage,Model model,HttpServletRequest request,String orgName,String orgCode) throws Exception{
		
		return "medroad/edc/pi/overview";
	}
	@RequestMapping(value="/visit")
	public String visit(Model model,HttpServletRequest request,String patientFlow,String patientCode) throws Exception{
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = patientBiz.readPatient(patientFlow);
			setSessionAttribute(GlobalConstant.EDC_CURR_PATIENT, patient);
		}else if(StringUtil.isNotBlank(patientCode)){
			
			PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			PubPatient patient = patientBiz.readPatientByCode(proj.getProjFlow(),patientCode);
			setSessionAttribute(GlobalConstant.EDC_CURR_PATIENT, patient);
		}
		
		return "medroad/edc/reacher/visit";
	}
	@RequestMapping(value="/datainput")
	public String datainput(Model model,HttpServletRequest request,String visitFlow,String operUserFlow) throws Exception{
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		List<EdcVisit> visitList = visitBiz.searchVisitList(proj.getProjFlow());
		model.addAttribute("visitList", visitList);
		
		EdcProjParam param = inputBiz.readProjParam(proj.getProjFlow());
		if(param!=null){
			boolean isSingle = GeneralMethod.isSingleInput(param);
			model.addAttribute("isSingle", isSingle);
		}
		
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		setSessionAttribute(GlobalConstant.EDC_CURR_VISIT,visit);
		
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		
		SysUser user = GlobalContext.getCurrentUser();
		if(patient!=null){
			PubPatientVisit pateintVisit = inputBiz.readPatientVisit(proj.getProjFlow(),visitFlow,patient.getPatientFlow());
			if(pateintVisit != null ){
				EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
				if(edcPatientVisit!=null){
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
				}
				
				//访视窗
				PubPatientWindow window = patientWindowBiz.readPatientWindow(patient.getPatientFlow(), visitFlow);
				model.addAttribute("visitWindow", window);
			}
		
		}
		
		
		
		return "medroad/edc/reacher/datainput";
	}
	@RequestMapping(value="/drug")
	public String drug(Model model,HttpServletRequest request) throws Exception{
		return "medroad/edc/drug/list";
	}
	@RequestMapping(value="/saveData")
	@ResponseBody
	public String saveData(@RequestBody List<EdcPatientVisitData> datas,Model model,HttpServletRequest request,String status,String operUserFlow) throws Exception{
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
			inputBiz.addPatientVisit(pateintVisit);
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
							edcPatientVisit, attr);
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
			EdcAttribute attr) {
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
	public String checkSubmit(Model model,HttpServletRequest request) {
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
	
	@RequestMapping(value="/recipe/list")
	public String recipe(Model model,HttpServletRequest request) throws Exception{
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		List<EdcVisit> visitList = visitBiz.searchVisitList(proj.getProjFlow());
		model.addAttribute("visitList", visitList);
		
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		List<PubPatientVisit> patientVisitList = inputBiz.searchPatientVisit(proj.getProjFlow(), patient.getOrgFlow(), patient.getPatientFlow());
		Map<String,PubPatientVisit> patientVisitMap = new HashMap<String, PubPatientVisit>();
		for(PubPatientVisit patientVisit : patientVisitList){
			patientVisitMap.put(patientVisit.getVisitFlow(),patientVisit);
		}
		
		model.addAttribute("patientVisitMap", patientVisitMap);
		
		//访视窗
		List<PubPatientWindow> windows = patientWindowBiz.searchPatientWindowByPatientFlows(proj.getProjFlow(), patient.getPatientFlow());
		Map<String,PubPatientWindow> windowMap = new HashMap<String, PubPatientWindow>();
		for(PubPatientWindow window : windows){
			windowMap.put(window.getVisitFlow(), window);
		}
		model.addAttribute("windowMap", windowMap);
		return "medroad/edc/recipe/list";
	}
	@RequestMapping(value="/recipeContent")
	public String recipeContent(String visitFlow,Model model,HttpServletRequest request){
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		model.addAttribute("visit", visit);
		
		
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		
		//访视
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(patient.getProjFlow(),visitFlow,patientFlow);
		if(pateintVisit!=null){
			Map<String,Object> visitInfoMap = inputBiz.createVisitInfoMap(pateintVisit.getVisitInfo());
			if(visitInfoMap!=null){
				model.addAttribute("visitInfoMap",visitInfoMap);
			}
		}
		
		PubPatientWindow visitWindow = patientWindowBiz.readPatientWindow(patientFlow, visitFlow);
		model.addAttribute("visitWindow",visitWindow);
		
		//
		List<GcpDrug> drugList = gcpDrugBiz.searchDrugByProj(patient.getProjFlow());
		model.addAttribute("drugList",drugList);
		Map<String,GcpDrug> drugMap = new HashMap<String, GcpDrug>();
		for(GcpDrug drug : drugList){
			drugMap.put(drug.getDrugFlow(), drug);
		}
		model.addAttribute("drugMap",drugMap);
		
		Map<String,Map<String,Integer>> drugLotMap = new HashMap<String, Map<String,Integer>>();
		for(GcpDrug drug : drugList){
			Map<String, Integer> drugLotSurplusCountMap = getSurplusDrugCountMap(drug.getDrugFlow(), patient.getProjFlow(),patient.getOrgFlow());
			drugLotMap.put(drug.getDrugFlow(), drugLotSurplusCountMap);
		}
		model.addAttribute("drugLotMap",drugLotMap);
		//
		PubPatientRecipe patientRecipe = new PubPatientRecipe();
		patientRecipe.setPatientFlow(patientFlow);
		patientRecipe.setVisitFlow(visitFlow);
		List<PubPatientRecipe> recipeList = recipeBiz.searchPatientRecipeByPatientRecipe(patientRecipe);
		
		model.addAttribute("recipeList",recipeList);
		Map<String,List<PubPatientRecipeDrug>> recipeDrugMap = new HashMap<String, List<PubPatientRecipeDrug>>();
		for(PubPatientRecipe recipe : recipeList){
			recipeDrugMap.put(recipe.getRecipeFlow(), recipeBiz.searchPatientRecipeDrug(recipe.getRecipeFlow())); 
		}
		model.addAttribute("recipeDrugMap",recipeDrugMap);
		return "medroad/edc/recipe/content";
	}
	@RequestMapping(value="/saveVisitDate")
	@ResponseBody
	public String saveVisitDate(String drugFlow,String drugAmount,String visitFlow,String doctorExplain,String visitDate,String visitWindow,HttpServletRequest request) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		
		SysUser user = GlobalContext.getCurrentUser();
		
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
		
	
		
		String visitInfo = "";
		
		if(pateintVisit == null){
			pateintVisit = _addPatientVisit(patientFlow, visitFlow, projFlow, patient, visit);
			pateintVisit.setVisitDate(visitDate);
			
			visitInfo = inputBiz.createVisitInfoXml(pateintVisit.getVisitInfo(),"doctorExplain",doctorExplain,null,true);
			pateintVisit.setVisitInfo(visitInfo);
			inputBiz.addPatientVisit(pateintVisit); 
		}else {
			pateintVisit.setVisitDate(visitDate);
			visitInfo = inputBiz.createVisitInfoXml(pateintVisit.getVisitInfo(),"doctorExplain",doctorExplain,null,true);
			pateintVisit.setVisitInfo(visitInfo);
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
		//处方发药
		if(StringUtil.isNotBlank(drugFlow)){
			String flow = StringUtil.split(drugFlow, "_")[0];
			String lot = StringUtil.split(drugFlow, "_")[1];
			
			PubPatientRecipe patientRecipe = new PubPatientRecipe();
			patientRecipe.setPatientFlow(patientFlow);
			patientRecipe.setVisitFlow(visitFlow);
			patientRecipe.setPatientCode(patient.getPatientCode());
			patientRecipe.setPatientNamePy(patient.getPatientNamePy());
			patientRecipe.setOrgFlow(user.getOrgFlow());
			patientRecipe.setProjFlow(proj.getProjFlow());
			patientRecipe.setRecipeDate(DateUtil.getCurrDateTime());
			patientRecipe.setRecipeDoctorFlow(user.getUserFlow());
			patientRecipe.setRecipeDoctorName(user.getUserName());
			patientRecipe.setRecipeStatusId(PatientRecipeStatusEnum.Dispensed.getId());
			patientRecipe.setRecipeStatusName(PatientRecipeStatusEnum.Dispensed.getName());
			gcpDrugBiz.saveRecipe(patientRecipe, flow, lot,drugAmount);
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	
	@RequestMapping(value="/userRecipeFile")
	@ResponseBody
	public String userRecipeFile(String visitFlow,String filetype,MultipartFile recipeFile){
		 if(recipeFile!=null && recipeFile.getSize() > 0){
			 PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			 String projFlow = proj.getProjFlow();
			 PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		     String patientFlow = patient.getPatientFlow();
			 PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
			 EdcVisit visit = visitBiz.readVisit(visitFlow);
			if(pateintVisit == null){
				pateintVisit = _addPatientVisit(patientFlow, visitFlow, projFlow, patient, visit);
				inputBiz.uploadPatientVisitFile(pateintVisit,filetype,recipeFile);
				inputBiz.addPatientVisit(pateintVisit); 
			}else {
				inputBiz.uploadPatientVisitFile(pateintVisit,filetype,recipeFile);
				inputBiz.modifyPatientVisit(pateintVisit);
			}
        }
        return GlobalConstant.UPLOAD_SUCCESSED;
	}
	@RequestMapping(value="/delRecipeFile")
	@ResponseBody
	public String delRecipeFile(String visitFlow,String type,String url){
			 PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			 String projFlow = proj.getProjFlow();
			 PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		     String patientFlow = patient.getPatientFlow();
			 PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
			
			inputBiz.delRecipeFile(pateintVisit,type,url);
			return GlobalConstant.OPERATE_SUCCESSED;
	}
	@RequestMapping(value="/followup")
	public String followup(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ); 
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		List<PubPatientWindow> windowList = patientWindowBiz.searchRemaind(proj.getProjFlow(),orgFlow);
		model.addAttribute("windowList", windowList);
		
		PubPatient patientSearch = new PubPatient();
		patientSearch.setProjFlow(proj.getProjFlow());
		patientSearch.setOrgFlow(orgFlow);
		patientSearch.setPatientTypeId(PatientTypeEnum.Real.getId());
		List<PubPatient> patientList = patientBiz.searchPatient(patientSearch);
		Map<String,PubPatient> patientMap = new HashMap<String, PubPatient>();
		for(PubPatient patient : patientList){
			patientMap.put(patient.getPatientFlow(), patient);
		}
		model.addAttribute("patientMap", patientMap);
		return "medroad/edc/followup/main";
	}
	@RequestMapping(value="/sendFollowSms")
	@ResponseBody
	public String sendFollowSms(String recordFlow,String patientPhone,String msgContent){
		PubPatientWindow window = patientWindowBiz.readPatientWindow(recordFlow);
		PubPatient patient = patientBiz.readPatient(window.getPatientFlow());
		if(patient!=null && StringUtil.isNotBlank(patient.getPatientPhone())){
			messageBiz.addSmsMsg(patient.getPatientPhone(), msgContent);
			window.setIsNotice(GlobalConstant.FLAG_Y);
			patientWindowBiz.savePatientWindow(window);
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	@RequestMapping(value="/proj/file")
	public String projFile(Model model) throws Exception{ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ); 
		List<ProjFileForm> fileList = edcProjBiz.searchProjFiles(proj.getProjFlow());
		model.addAttribute("fileList", fileList);
		
		return "medroad/edc/proj/file";
	}
	@RequestMapping(value="/drug/list")
	public String drugList(Model model) throws Exception{ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ); 
		List<GcpDrug> drugList = gcpDrugBiz.searchDrugByProj(proj.getProjFlow());
		model.addAttribute("drugList", drugList);
		return "medroad/edc/drug/list";
	}
	@RequestMapping(value="/drug/info")
	public String drugInfo(String drugFlow,Model model) throws Exception{ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ); 
		String projFlow = proj.getProjFlow();
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		GcpDrug drug = gcpDrugBiz.readDrugInfo(drugFlow);
		model.addAttribute("drug", drug);
		
		Map<String, Integer> drugLotSurplusCountMap = getSurplusDrugCountMap(
				drugFlow, projFlow, orgFlow);
		model.addAttribute("drugLotSurplusCountMap", drugLotSurplusCountMap);
		return "medroad/edc/drug/info";
	}

	private Map<String, Integer> getSurplusDrugCountMap(String drugFlow,
			String projFlow, String orgFlow) {
		//库存
		GcpDrugIn gcpDrugIn = new GcpDrugIn();
		gcpDrugIn.setProjFlow(projFlow);
		gcpDrugIn.setOrgFlow(orgFlow);
		gcpDrugIn.setDrugFlow(drugFlow);
		List<GcpDrugIn> drugInList = gcpDrugBiz.searchDrugInList(gcpDrugIn);
		Map<String,Integer> drugLotCountMap = new HashMap<String, Integer>();
		for(GcpDrugIn in : drugInList){
			Integer count = drugLotCountMap.get(in.getLotNo());
			if(count == null){
				count = 0;
			}
			if(StringUtil.isNotBlank(in.getDrugAmount())){ 
				count +=  Integer.parseInt(in.getDrugAmount());
			}
			drugLotCountMap.put(in.getLotNo(), count);
		}
		//用量
		PubPatientRecipeDrug temp = new PubPatientRecipeDrug();
		temp.setProjFlow(projFlow);
		temp.setOrgFlow(orgFlow);
		temp.setDrugFlow(drugFlow);
		List<PubPatientRecipeDrug> recipeDrugList = recipeBiz.searchRecipeDrug(temp);
		Map<String,Integer> drugLotUsedCountMap = new HashMap<String, Integer>();
		for(PubPatientRecipeDrug recipeDrug : recipeDrugList){
			Integer count = drugLotUsedCountMap.get(recipeDrug.getLotNo());
			if(count == null){
				count = 0;
			}
			if(StringUtil.isNotBlank(recipeDrug.getDrugAmount())){ 
				count +=  Integer.parseInt(recipeDrug.getDrugAmount());
			}
			drugLotUsedCountMap.put(recipeDrug.getLotNo(), count);
		}
		Map<String,Integer> drugLotSurplusCountMap = new HashMap<String, Integer>();
		for(Map.Entry<String, Integer> map : drugLotCountMap.entrySet() ){
			String lot = map.getKey();
			Integer count = map.getValue();
			
			Integer surplusDrug = 0;
			if(drugLotUsedCountMap.containsKey(lot)){
				surplusDrug = count - drugLotUsedCountMap.get(lot);
			}else {
				surplusDrug = count;
			}
			drugLotSurplusCountMap.put(lot, surplusDrug); 
		}
		return drugLotSurplusCountMap;
	}
	@RequestMapping(value="/drug/record")
	public String useRecord(Model model , Integer currentPage,HttpServletRequest request) throws Exception{ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ); 
		String projFlow = proj.getProjFlow();
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		
		
		
		PubPatientRecipe recipe = new PubPatientRecipe();
		recipe.setProjFlow(projFlow);
		recipe.setOrgFlow(orgFlow);
		List<PubPatientRecipe> recipeList = recipeBiz.searchPatientRecipeByPatientRecipe(recipe);
		Map<String ,PubPatientRecipe> recipeMap = new HashMap<String, PubPatientRecipe>();
		for(PubPatientRecipe temp : recipeList){
			recipeMap.put(temp.getRecipeFlow(), temp);
		}
		
		PageHelper.startPage(currentPage, getPageSize(request));
		PubPatientRecipeDrug temp = new PubPatientRecipeDrug();
		temp.setProjFlow(projFlow);
		temp.setOrgFlow(orgFlow);
		List<PubPatientRecipeDrug> recipeDrugList = recipeBiz.searchRecipeDrug(temp);
		
		model.addAttribute("recipeDrugList", recipeDrugList);
		model.addAttribute("recipeMap", recipeMap);
		return "medroad/edc/drug/record";
	}
	@RequestMapping(value="/drug/store")
	public String store(Model model ) throws Exception{ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ); 
		String projFlow = proj.getProjFlow();
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		List<GcpDrug> gcpDrugList = gcpDrugBiz.searchDrugByProj(projFlow);
		model.addAttribute("drugList", gcpDrugList);
		
		GcpDrugIn in = new GcpDrugIn();
		in.setProjFlow(projFlow);
		in.setOrgFlow(orgFlow);
		List<GcpDrugIn> drugInList = gcpDrugBiz.searchDrugInList(in);
		Map<String,List<GcpDrugIn>> drugInMap = new HashMap<String, List<GcpDrugIn>>();
		for(GcpDrugIn temp : drugInList){
			List<GcpDrugIn> list = drugInMap.get(temp.getDrugFlow());
			if(list == null){
				list = new ArrayList<GcpDrugIn>();
			}
			list.add(temp);
			drugInMap.put(temp.getDrugFlow(), list);
		}
		model.addAttribute("drugInMap", drugInMap);
		
		Map<String,Map<String,Integer>> drugLotMap = new HashMap<String, Map<String,Integer>>();
		for(GcpDrug drug : gcpDrugList){
			Map<String, Integer> drugLotSurplusCountMap = getSurplusDrugCountMap(drug.getDrugFlow(),projFlow,orgFlow);
			drugLotMap.put(drug.getDrugFlow(), drugLotSurplusCountMap);
		}
		model.addAttribute("drugLotMap", drugLotMap);
		return "medroad/edc/drug/store";
	}
	
	@RequestMapping(value="/recipe/drug")
	public String recipeDrug(Model model) throws Exception{ 
		
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT); 
		
		List<PubPatientRecipe> recipeList = recipeBiz.searchPatientRecipe(patient.getPatientFlow());
		Map<String ,List<PubPatientRecipeDrug>> recipeDrugMap = new HashMap<String, List<PubPatientRecipeDrug>>();
		for(PubPatientRecipe recipe : recipeList){
			recipeDrugMap.put(recipe.getRecipeFlow(), recipeBiz.searchPatientRecipeDrug(recipe.getRecipeFlow()));
		}
		
		model.addAttribute("recipeList", recipeList);
		model.addAttribute("recipeDrugMap", recipeDrugMap);
		return "medroad/edc/recipe/drug";
	}
	@RequestMapping(value="/querydata")
	public String querydata(String visitFlow,String attrCode,String recordFlow,Model model) throws Exception{ 
		EdcDesignForm designForm = (EdcDesignForm) getSessionAttribute(GlobalConstant.PROJ_DESC_FORM);
		EdcAttribute attribute = designForm.getAttrMap().get(attrCode);
		if(attribute!=null){
			EdcModule module = designForm.getModuleMap().get(attribute.getModuleCode());
			EdcElement element = designForm.getElementMap().get(attribute.getElementCode());
			model.addAttribute("module", module);
			model.addAttribute("element", element);
			model.addAttribute("attr", attribute);
			model.addAttribute("visitFlow", visitFlow);
			
			List<EdcPatientVisitData> visitData = inputBiz.searchPatientVisitData(recordFlow,attrCode,"1"); 
			if(visitData.size()>0){
				model.addAttribute("visitData", visitData.get(0)); 
			}
		}
		
		return "medroad/edc/reacher/querydata";
	}
	@RequestMapping(value="/updateData")
	@ResponseBody
	public String updateData(String visitFlow,String attrCode,String elementSerialSeq,String recordFlow,String eventNote,String value,Model model) throws Exception{ 
		EdcDesignForm designForm = (EdcDesignForm) getSessionAttribute(GlobalConstant.PROJ_DESC_FORM);
		
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT); 
		List<EdcPatientVisitData> visitData = inputBiz.searchPatientVisitData(recordFlow,attrCode,elementSerialSeq);
		String oldValue = "";
		EdcPatientVisitData data = null;
		
		SysUser user = GlobalContext.getCurrentUser();
		
		if(visitData!=null && visitData.size()>0){
			data = visitData.get(0);
			
			oldValue = data.getAttrValue();
			
			data.setAttrValue(value);
			inputBiz.modifyVisitData(data);
		}else {
			PubPatientVisit pateintVisit = inputBiz.readPatientVisit(patient.getProjFlow(),visitFlow,patient.getPatientFlow());
			EdcPatientVisit edcPatientVisit  = null;
			if(pateintVisit != null ){
				 edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
			}
			data = _addVisitData(visitFlow, patient.getPatientFlow(),
					attrCode, value, elementSerialSeq, user, patient.getProjFlow(),
					edcPatientVisit, designForm.getAttrMap().get(attrCode));
			data.setAttrValue(value);
			inputBiz.addVisitData(data);
		}
		
		//同步修改Event 包括疑问，提交后修改 留痕
		_addVisitDataEvent(patient,data,oldValue,designForm,eventNote);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	private void _addVisitDataEvent(PubPatient patient,EdcPatientVisitData data,String oldValue,EdcDesignForm designForm,String eventNote) {
		EdcVisitDataEvent dataEvent = new EdcVisitDataEvent();
		dataEvent.setRecordFlow(PkUtil.getUUID());
		dataEvent.setProjFlow(data.getProjFlow());
		dataEvent.setOrgFlow(patient.getOrgFlow());
		dataEvent.setPatientFlow(patient.getPatientFlow());
		dataEvent.setPatientCode(patient.getPatientCode());
		dataEvent.setDataRecordFlow(data.getRecordFlow());
		dataEvent.setVisitFlow(data.getVisitFlow());
		dataEvent.setVisitName(designForm.getVisitMap().get(data.getVisitFlow()).getVisitName());
		dataEvent.setModuleCode(data.getModuleCode());
		dataEvent.setModuleName(designForm.getModuleMap().get(data.getModuleCode()).getModuleName());
		dataEvent.setElementCode(data.getElementCode());
		dataEvent.setElementName(designForm.getElementMap().get(data.getElementCode()).getElementName());
		dataEvent.setElementSerialSeq(data.getElementSerialSeq());
		dataEvent.setAttrCode(data.getAttrCode());
		dataEvent.setAttrName(designForm.getAttrMap().get(data.getAttrCode()).getAttrName());
		dataEvent.setEventSeq("");
		dataEvent.setAttrValue(oldValue);
		dataEvent.setAttrEventValue(data.getAttrValue());
		dataEvent.setEventTime(DateUtil.getCurrDateTime());
		dataEvent.setEventUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		dataEvent.setEventUserName(GlobalContext.getCurrentUser().getUserName());
		dataEvent.setQueryFlow("");
		dataEvent.setEventNote(eventNote);
		inspectBiz.addVisitDataEvent(dataEvent);
	}
}

