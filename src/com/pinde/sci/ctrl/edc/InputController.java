package com.pinde.sci.ctrl.edc;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
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
import com.pinde.core.util.PyUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IInspectBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.pub.IPubPatientWindowBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubPatientIeMapper;
import com.pinde.sci.enums.edc.EdcInputStatusEnum;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.edc.ProjInputTypeEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.PatientVisitForm;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcNormalValue;
import com.pinde.sci.model.mo.EdcPatientVisit;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcPatientVisitDataExample;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcQuery;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitDataEvent;
import com.pinde.sci.model.mo.EdcVisitDataEventExample;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientIe;
import com.pinde.sci.model.mo.PubPatientIeExample;
import com.pinde.sci.model.mo.PubPatientExample.Criteria;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientWindow;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/edc/input")
public class InputController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(InputController.class);
	
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
	@Autowired
	private IInspectBiz inspectBiz; 
	@Autowired
	private IEdcGroupBiz groupBiz;
	@Resource
	private IPubPatientWindowBiz patientWindowBiz;
	@Resource
	private IEdcRandomBiz randomBiz;
	@Autowired
	private PubPatientIeMapper patientIeMapper;
	
	
	@RequestMapping(value = {"/listMain/{patientScope}" },method={RequestMethod.GET})
	public String listMain(@PathVariable String patientScope,String patientType,String orgFlow,Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		if(GlobalConstant.DEPT_LIST_LOCAL.equals(patientScope)){
			
		}else if(GlobalConstant.DEPT_LIST_GLOBAL.equals(patientScope)){ 
			List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("pubProjOrgList", pubProjOrgList);	
		}
		model.addAttribute("patientScope", patientScope);
		model.addAttribute("patientType", patientType);
		
		List<EdcGroup> groupList = groupBiz.searchEdcGroup(projFlow);
		model.addAttribute("groupList", groupList);
		
		logger.info("getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)="+getSessionAttribute(GlobalConstant.PROJ_DESC_FORM));
		if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
			logger.info("==============init proj desc ========");
			EdcDesignForm designForm = edcModuleBiz.getCrfDescForm(projFlow);
			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
		}
		model.addAttribute("orgFlow", orgFlow);
		return "edc/input/patientListMain";
	}
	
	@RequestMapping(value = {"/list" },method={RequestMethod.GET})
	public String list(String patientScope,String patientType,String orgFlow,String groupFlow,Model model) {
		model.addAttribute("patientScope", patientScope);
		model.addAttribute("patientType", patientType);
		model.addAttribute("groupFlow", groupFlow);	
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		
		//项目参数
		EdcProjParam projParam = inputBiz.readProjParam(proj.getProjFlow());
		model.addAttribute("projParam", projParam);
		
		if(GlobalConstant.DEPT_LIST_LOCAL.equals(patientScope)){
			orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		}
		
		String projFlow = proj.getProjFlow();
		if(StringUtil.isNotBlank(orgFlow)){
			List<PubPatient> patientList = null;
			EdcProjParam param = inputBiz.readProjParam(projFlow);
			boolean isRandom = GeneralMethod.isRandom(param);
			
			if (StringUtil.isNotBlank(groupFlow) && PatientTypeEnum.Real.getId().equals(patientType)) {
				String groupName = "";
				EdcGroup group = groupBiz.read(groupFlow);
				if (group != null) {
					groupName = group.getGroupName();
				}
				patientList = patientBiz.searchPatientByGroup(projFlow, orgFlow, isRandom, groupName);
			} else {
				PubPatientExample example = new PubPatientExample();
				Criteria criteria =  example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow)
				.andPatientTypeIdEqualTo(patientType).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				
				if (isRandom && PatientTypeEnum.Real.getId().equals(patientType)) {		//随机试验过滤未入组样本,模拟录入不过滤
					criteria.andInDateIsNotNull();
				}
				example.setOrderByClause("patient_Seq");
				patientList = patientBiz.searchPatient(example);
			}
			model.addAttribute("patientList", patientList);
			
			Map<String,Map<String,PatientVisitForm>>   patientVisitMap = inputBiz.searchPatientVisitMap(projFlow,orgFlow);
			model.addAttribute("patientVisitMap", patientVisitMap);
			
			EdcProjOrg edcProjOrg = projOrgBiz.readEdcProjOrg(projFlow,orgFlow);
			model.addAttribute("edcProjOrg", edcProjOrg);
		}
		
		List<EdcVisit> visitList = null;
		if (StringUtil.isNotBlank(groupFlow) && PatientTypeEnum.Real.getId().equals(patientType)) {
			visitList = visitBiz.searchVisitsByGroupFlow(projFlow,groupFlow,null);
		} else {
			visitList = visitBiz.searchVisitList(projFlow);
		}
		model.addAttribute("visitList", visitList);	
		
		return "edc/input/patientList";
	}
	@RequestMapping(value = {"/inputMain" },method={RequestMethod.GET})
	public String inputMain(String patientScope,String patientType,String groupFlow,String patientFlow,String visitFlow,Model model){
		model.addAttribute("patientScope", patientScope);
		model.addAttribute("patientType", patientType);
		model.addAttribute("groupFlow", groupFlow);
		
		PubPatient patient = patientBiz.readPatient(patientFlow);
		model.addAttribute("patient", patient);
		setSessionAttribute(GlobalConstant.EDC_CURR_PATIENT, patient);
		
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		model.addAttribute("visit", visit);
		setSessionAttribute(GlobalConstant.EDC_CURR_VISIT, visit);
		
		
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(patient.getProjFlow(),visitFlow,patientFlow);
		
		model.addAttribute("patientVisit", pateintVisit);
		if(pateintVisit != null ){
			EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
			model.addAttribute("edcPatientVisit", edcPatientVisit);
			
			String currOperFlow = GlobalContext.getCurrentUser().getUserFlow();
			String inputOperStatusId = edcPatientVisit.getInputOperStatusId();
			String inputOperFlow = edcPatientVisit.getInputOperFlow();
			if (EdcInputStatusEnum.Checked.getId().equals(inputOperStatusId)) {	//录入完成
				model.addAttribute("inputOperFlow", inputOperFlow);
				model.addAttribute("inputStatusId", inputOperStatusId);
			} else {
				model.addAttribute("inputOperFlow", currOperFlow);
				if (currOperFlow.equals(edcPatientVisit.getInputOper1Flow())) {
					model.addAttribute("inputStatusId", edcPatientVisit.getInputOper1StatusId());
				} else {
					model.addAttribute("inputStatusId", edcPatientVisit.getInputOper2StatusId());
				}
			}
			
			//页面使用，单次，多次 通用
			Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = 	inputBiz.getelementSerialSeqValueMap(pateintVisit.getRecordFlow());
			model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
		}
		
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		String orgFlow = patient.getOrgFlow();
		
		if(StringUtil.isNotBlank(orgFlow)){
			List<PubPatient> patientList = null;
			EdcProjParam param = inputBiz.readProjParam(projFlow);
			boolean isRandom = GeneralMethod.isRandom(param);
			
			if (StringUtil.isNotBlank(groupFlow) && PatientTypeEnum.Real.getId().equals(patientType)) {
				String groupName = "";
				EdcGroup group = groupBiz.read(groupFlow);
				if (group != null) {
					groupName = group.getGroupName();
				}
				patientList = patientBiz.searchPatientByGroup(projFlow, orgFlow, isRandom, groupName);
			} else {
				PubPatientExample example = new PubPatientExample();
				Criteria criteria =  example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow)
				.andPatientTypeIdEqualTo(patientType).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				if (isRandom && PatientTypeEnum.Real.getId().equals(patientType)) {		//随机试验过滤未入组样本,模拟录入不过滤
					criteria.andInDateIsNotNull();
				}
				example.setOrderByClause("patient_Seq");
				patientList = patientBiz.searchPatient(example);
			}
			model.addAttribute("patientList", patientList);
		}
		
		List<EdcVisit> visitList = null;
		if (StringUtil.isNotBlank(groupFlow) && PatientTypeEnum.Real.getId().equals(patientType)) {
			visitList = visitBiz.searchVisitsByGroupFlow(projFlow,groupFlow,null);
		} else {
			visitList = visitBiz.searchVisitList(projFlow);
		}
		model.addAttribute("visitList", visitList);
		
		return "edc/input/input";
	}
	
	
	@RequestMapping(value = {"/submitData" },method={RequestMethod.GET})
	@ResponseBody
	public String submitData(String inputType,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		String patientFlow =  ((PubPatient)getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT)).getPatientFlow();
		String visitFlow =  ((EdcVisit)getSessionAttribute(GlobalConstant.EDC_CURR_VISIT)).getVisitFlow();
		
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
		EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
		SysUser currUser = GlobalContext.getCurrentUser();
		//项目参数
		EdcProjParam projParam = (EdcProjParam) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ_PARAM);
		
		setOper(projParam,inputType,edcPatientVisit,currUser,EdcInputStatusEnum.Submit.getId());
		
		inputBiz.modifyEdcPatientVisit(edcPatientVisit);
		
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/saveVisitDate" },method={RequestMethod.GET})
	@ResponseBody
	public String saveVisitDate(String visitDate,String inputType, Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		SysUser currUser = GlobalContext.getCurrentUser();
		String projFlow = proj.getProjFlow();
		
		
		//Patient
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		//Visit
		EdcVisit visit = (EdcVisit) getSessionAttribute(GlobalConstant.EDC_CURR_VISIT);
		String visitFlow = visit.getVisitFlow();
		//项目参数
		EdcProjParam projParam =  (EdcProjParam) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ_PARAM);
		
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visit.getVisitFlow(),patient.getPatientFlow());
		if(pateintVisit == null){
			//添加访视记录
			pateintVisit = _addPatientVisit(patientFlow, visitFlow, projFlow, patient, visit);
			//添加EDC访视记录
			EdcPatientVisit edcPateintVisit = _addEdcPatientVisit(pateintVisit.getRecordFlow());
			
			pateintVisit.setVisitDate(visitDate);
			//判断录一录二
			setOper(projParam,inputType,edcPateintVisit,currUser,EdcInputStatusEnum.Save.getId());
			
			inputBiz.addPatientVisit(pateintVisit,edcPateintVisit);
		}else {
			pateintVisit.setVisitDate(visitDate);
			inputBiz.modifyPatientVisit(pateintVisit);
		}
		
		//回写访视窗
		EdcVisit baseLineVisit = visitBiz.searchBaseline(projFlow,GlobalConstant.FLAG_Y);//若分组别，基线先查通用基线，若无再查组别基线
		if (baseLineVisit == null) {
			List<EdcGroup> groupList = groupBiz.searchEdcGroup(projFlow);
			if (groupList != null && groupList.size() > 0) {
				String drugGroup = randomBiz.searchPatientDrugGroup(patientFlow);
				if (StringUtil.isNotBlank(drugGroup)) {
					EdcGroup group = groupBiz.searchEdcGroup(projFlow,drugGroup);
					if (group != null) {
						baseLineVisit = visitBiz.searchBaseline(projFlow,group.getGroupFlow());
					}
				}
			}
		}
		
		if (baseLineVisit != null) {
			List<EdcVisit> visitList = visitBiz.searchVisitList(projFlow);
			List<String> visitFlows = new ArrayList<String>();
			for(EdcVisit temp : visitList){
				visitFlows.add(temp.getVisitFlow());
			}
			pateintVisit = inputBiz.readPatientVisit(projFlow,visit.getVisitFlow(),patient.getPatientFlow());
			if (pateintVisit != null) {
				//基线以前的访视不回写访视窗,只回写访视日期
				if (visitFlows.indexOf(visitFlow) >= visitFlows.indexOf(baseLineVisit.getVisitFlow())) {
					visitBiz.updatePatientWindow(pateintVisit.getRecordFlow());
				} else {
					PubPatientWindow window = patientWindowBiz.readPatientWindow(patient.getPatientFlow(),visitFlow);
					if(window!=null){
						window.setVisitDate(visitDate);
						patientWindowBiz.savePatientWindow(window);
					}
				}
			}
		}
		
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	private EdcPatientVisit _addEdcPatientVisit(String recordFlow) {
		EdcPatientVisit visit = new EdcPatientVisit();
		visit.setRecordFlow(recordFlow);
		return visit;
	}

	private void setOper(EdcProjParam projParam, String inputType, EdcPatientVisit pateintVisit, SysUser currUser,String status) {
		if(EdcInputStatusEnum.Checked.getId().equals(pateintVisit.getInputOperStatusId())){
			return;
		}
		String statusId = EdcInputStatusEnum.Save.getId().equals(status)? EdcInputStatusEnum.Save.getId():EdcInputStatusEnum.Submit.getId();
		String statusName = EdcInputStatusEnum.Save.getId().equals(status)? EdcInputStatusEnum.Save.getName():EdcInputStatusEnum.Submit.getName();
		String time = DateUtil.getCurrDateTime();
		if(GeneralMethod.isSingleInput(projParam) || ProjInputTypeEnum.Single.getId().equals(inputType)){
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
					if(!EdcInputStatusEnum.Submit.getId().equals(pateintVisit.getInputOper1StatusId())){
						pateintVisit.setInputOper1StatusId(statusId);
						pateintVisit.setInputOper1StatusName(statusName);
					}
					pateintVisit.setInputOper1Time(time);
				}else if(currUser.getUserFlow().equals(pateintVisit.getInputOper2Flow())||StringUtil.isBlank(pateintVisit.getInputOper2Flow())){
					pateintVisit.setInputOper2Flow(currUser.getUserFlow());
					pateintVisit.setInputOper2Name(currUser.getUserName());
					//防止异步出错
					if(!EdcInputStatusEnum.Submit.getId().equals(pateintVisit.getInputOper2StatusId())){
						pateintVisit.setInputOper2StatusId(statusId);
						pateintVisit.setInputOper2StatusName(statusName);
					}
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
	@RequestMapping(value = {"/saveData" },method={RequestMethod.POST})//TODO
	@ResponseBody
    public synchronized  String saveData(String visitFlow,String attrCode,String value,String elementSerialSeq,String inputType) {
		EdcDesignForm designForm = (EdcDesignForm) getSessionAttribute(GlobalConstant.PROJ_DESC_FORM);
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		SysUser currUser = GlobalContext.getCurrentUser();
		String projFlow = proj.getProjFlow();
		
		if(StringUtil.isBlank(elementSerialSeq)){
			elementSerialSeq = "1";
		}
		
		EdcAttribute attr = designForm.getAttrMap().get(attrCode);
		//Patient
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		//Visit
	
		EdcVisit visit = (EdcVisit) getSessionAttribute(GlobalConstant.EDC_CURR_VISIT);
		//最新的visit  录入员澄清数据页面传入visitFlow
		if(StringUtil.isNotBlank(visitFlow)){
			visit = inputBiz.readVisit(visitFlow);
		}
		visitFlow = visit.getVisitFlow();
		//项目参数
		EdcProjParam projParam =  (EdcProjParam) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ_PARAM);
		if(projParam == null){
			projParam = inputBiz.readProjParam(projFlow);
		}
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
			setOper(projParam,inputType,edcPatientVisit,currUser,EdcInputStatusEnum.Save.getId());
			inputBiz.addEdcPatientVisit(edcPatientVisit);
		}else {
			setOper(projParam,inputType,edcPatientVisit,currUser,EdcInputStatusEnum.Save.getId());
			inputBiz.modifyEdcPatientVisit(edcPatientVisit);
		}
		
		List<EdcPatientVisitData> visitData = inputBiz.searchPatientVisitData(pateintVisit.getRecordFlow(),attrCode,elementSerialSeq);
		String oldValue = "";
		if(visitData!=null && visitData.size()>0){
			data = visitData.get(0);
			
			oldValue = data.getAttrValue();
			
			setDataValueAndTip(value, currUser, edcPatientVisit, projParam, inputType, data);
			inputBiz.modifyVisitData(data);
		}else {
			data = _addVisitData(visitFlow, patientFlow,
					attrCode, value, elementSerialSeq, currUser, projFlow,
					edcPatientVisit, attr, projParam);
			setDataValueAndTip(value, currUser, edcPatientVisit, projParam, inputType, data);
			inputBiz.addVisitData(data);
		}
		
		inputBiz.modifyVisitData(data);
		
		//同步修改Event 包括疑问，提交后修改 留痕
		_modifyVisitDataEvent(patient,edcPatientVisit,data, oldValue,designForm);
		
		return GlobalConstant.SAVE_SUCCESSED;
	} 
	@RequestMapping(value = {"/saveEmptyDataAndUnit" },method={RequestMethod.POST})//
	@ResponseBody
	 public   String saveEmptyDataAndUnit(@RequestBody List<EdcPatientVisitData> datas,String inputType) {
		if(datas!=null && datas.size()>0){
			for(EdcPatientVisitData data : datas){
				saveData(null,data.getAttrCode(),data.getAttrValue(),data.getElementSerialSeq(),inputType);
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	private void _modifyVisitDataEvent(PubPatient patient,EdcPatientVisit edcPatientVisit,
			EdcPatientVisitData data,String oldValue, EdcDesignForm designForm) { 
		if(EdcInputStatusEnum.Checked.getId().equals(edcPatientVisit.getInputOperStatusId())){
			if(StringUtil.isEquals(oldValue, data.getAttrValue())){
				return;
			} 
			List<EdcQuery> queryList = inspectBiz.searchUnSolveSdvQuery(data.getRecordFlow());
			if(queryList!=null && queryList.size()>0){
				//此处疑问入口控制，只允许存在一条疑问
				
				String queryFlow = queryList.get(0).getQueryFlow();
				EdcVisitDataEventExample example = new EdcVisitDataEventExample();
				example.createCriteria().andDataRecordFlowEqualTo(data.getRecordFlow()).andQueryFlowEqualTo(queryFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				List<EdcVisitDataEvent> eventList = inspectBiz.searchEdcDataVisitEvent(example);
				if(eventList!=null && eventList.size()>0){
					EdcVisitDataEvent dataEvent = eventList.get(0);
					dataEvent.setAttrEventValue(data.getAttrValue());
					dataEvent.setEventTime(DateUtil.getCurrDateTime());
					dataEvent.setEventUserFlow(GlobalContext.getCurrentUser().getUserFlow());
					dataEvent.setEventUserName(GlobalContext.getCurrentUser().getUserName());
					inspectBiz.modifyDataEvent(dataEvent);
				}
			}else {
				_addVisitDataEvent(patient,data,oldValue,designForm);
			}
		}
	}

	private void _addVisitDataEvent(PubPatient patient,EdcPatientVisitData data,String oldValue,EdcDesignForm designForm) {
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
		inspectBiz.addVisitDataEvent(dataEvent);
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
		String attrValueTip = getAttrValueTip(data,attrValue);
		if(EdcInputStatusEnum.Checked.getId().equals(edcPateintVisit.getInputOperStatusId())){
			data.setAttrValue(attrValue);
			data.setAttrValueTip(attrValueTip);
			return;
		}
		if(GeneralMethod.isSingleInput(param) || ProjInputTypeEnum.Single.getId().equals(inputType)){
			data.setAttrValue1(attrValue);
			data.setAttrValue2(attrValue);
			data.setAttrValue(attrValue);
			data.setAttrValue1Tip(attrValueTip);
			data.setAttrValue2(attrValueTip);
			data.setAttrValueTip(attrValueTip);
		}else {
			if(currUser.getUserFlow().equals(edcPateintVisit.getInputOper1Flow())){ 
				data.setAttrValue1(attrValue);
				data.setAttrValue1Tip(attrValueTip);
			}else if(StringUtil.isBlank(edcPateintVisit.getInputOper2Flow())||currUser.getUserFlow().equals(edcPateintVisit.getInputOper2Flow())){
				data.setAttrValue2(attrValue);
				data.setAttrValue2Tip(attrValueTip);
			}
		}
	}
	
	
	private String getAttrValueTip(EdcPatientVisitData data, String attrValue) {
		String tip = "";
		if(StringUtil.isBlank(attrValue)){
			tip =  GlobalConstant.INPUT_TIP_BLANK;
		}else {
			EdcDesignForm designForm =  (EdcDesignForm) getSessionAttribute(GlobalConstant.PROJ_DESC_FORM);
			EdcAttribute attr = designForm.getAttrMap().get(data.getAttrCode());
			Map<String,Map<String,EdcNormalValue>> orgEleNormalValueMap = designForm.getNormalValueMap();
			if(attr.getAttrVarName().equals(GlobalConstant.DEFAULT_ATTR_VALUE_VAR_NAME) ){
				PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
				if(orgEleNormalValueMap.containsKey(patient.getOrgFlow()+"_"+data.getElementCode())){
					Map<String,EdcNormalValue> normalValueMap = orgEleNormalValueMap.get(patient.getOrgFlow()+"_"+data.getElementCode());
					String max = "";
					String min = "";
					EdcNormalValue normalValue = null;
					if(normalValueMap.containsKey(UserSexEnum.Unknown.getId())){
						normalValue =  normalValueMap.get(UserSexEnum.Unknown.getId());
					}else if(normalValueMap.containsKey(patient.getSexId())){
						normalValue =  normalValueMap.get(patient.getSexId());
					}
					if(normalValue!=null){
						min =  normalValue.getLowerValue();
						max =  normalValue.getUpperValue();
						if(StringUtil.isNotBlank(min)&& attrValue.compareTo(min)<0){ 
							tip = GlobalConstant.INPUT_TIP_LB + min + "~" + max;
						}
						if(StringUtil.isNotBlank(max)&& attrValue.compareTo(max)>0){
							tip = GlobalConstant.INPUT_TIP_LB + min + "~" + max;
						}
					}
				}
			}
		}
		System.out.println("tip="+tip); 
		return tip;
	}

	@RequestMapping(value = {"/checkDiff" },method={RequestMethod.GET})
	@ResponseBody
	public int checkDiff(){
		//Patient
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		//Visit
		EdcVisit visit = (EdcVisit) getSessionAttribute(GlobalConstant.EDC_CURR_VISIT);
		String visitFlow = visit.getVisitFlow();
		int diffCount = 0;
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(proj.getProjFlow(),visitFlow,patientFlow);
		if(pateintVisit != null){
			List<EdcPatientVisitData> visitData = inputBiz.searchPatientVisitData(pateintVisit.getRecordFlow());
			for(EdcPatientVisitData data : visitData){
				String value1 = data.getAttrValue1();
				String value2 = data.getAttrValue2();
				if(StringUtil.isNotEquals(value1, value2)){
					diffCount++;
				}
			}
		}
		return diffCount;
	}
	
	@RequestMapping(value = {"/check" },method={RequestMethod.GET})
	public String check(String patientScope, Model model){
		model.addAttribute("patientScope", patientScope);
		//Patient
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		//Visit
		EdcVisit visit = (EdcVisit) getSessionAttribute(GlobalConstant.EDC_CURR_VISIT);
		if(visit!=null){
			String visitFlow = visit.getVisitFlow();
			PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			PubPatientVisit pateintVisit = inputBiz.readPatientVisit(proj.getProjFlow(),visitFlow,patientFlow);
			
			model.addAttribute("patientVisit", pateintVisit);
			
			if(pateintVisit != null ){
				EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
				model.addAttribute("edcPatientVisit", edcPatientVisit);
				
				List<EdcPatientVisitData> visitData = inputBiz.searchPatientVisitData(pateintVisit.getRecordFlow());
				//Map<String,PatientVisitData> valueMap = new HashMap<String, PatientVisitData>();
				
				//页面使用，单次，多次 通用
				Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = new HashMap<String, Map<String,Map<String,EdcPatientVisitData>>>();
				
				Map<String,String> existDiffModuleMap = new HashMap<String, String>();
				Map<String,String> existDiffElementMap = new HashMap<String, String>();  //判断元素是否显示，下属属性全部相同则不显示元素
				Map<String,String> existDiffElementSeqMap = new HashMap<String, String>();
				Map<String,String> existDiffAttrValueMap = new HashMap<String, String>();		//属性是否相同，相同页面则不展示
				for(EdcPatientVisitData data : visitData){
					//数据展示
					Map<String,Map<String,EdcPatientVisitData>> serialSeqMap = elementSerialSeqValueMap.get(data.getElementCode());
					if(serialSeqMap == null){
						serialSeqMap = new TreeMap<String, Map<String,EdcPatientVisitData>>();
					}
					Map<String,EdcPatientVisitData> valueMap  = serialSeqMap.get(data.getElementSerialSeq());
					if(valueMap == null){
						valueMap = new HashMap<String, EdcPatientVisitData>();
					}
					valueMap.put(data.getAttrCode(), data);
					serialSeqMap.put(data.getElementSerialSeq(), valueMap);
					elementSerialSeqValueMap.put(data.getElementCode(), serialSeqMap);
					
					
					
					if(StringUtil.isNotEquals(data.getAttrValue1(), data.getAttrValue2())){
						existDiffModuleMap.put(data.getModuleCode(), data.getModuleCode());
						
						existDiffAttrValueMap.put(data.getElementCode()+"_"+ data.getElementSerialSeq()+"_"+data.getAttrCode(),
								data.getElementCode()+"_"+ data.getElementSerialSeq()+"_"+data.getAttrCode());
						
						existDiffElementSeqMap.put(data.getElementCode()+"_"+ data.getElementSerialSeq(), data.getElementCode()+"_"+ data.getElementSerialSeq());
						existDiffElementMap.put(data.getElementCode(), data.getElementCode());
					}
				}
				model.addAttribute("existDiffModuleMap", existDiffModuleMap);
				model.addAttribute("existDiffElementMap", existDiffElementMap);
				model.addAttribute("existDiffElementSeqMap", existDiffElementSeqMap);
				model.addAttribute("existDiffAttrValueMap", existDiffAttrValueMap);
				model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
			}
		}
		
		return "edc/input/check";
	}
	
	
	@RequestMapping(value = {"/doSubmitCheck" },method={RequestMethod.GET})
	@ResponseBody
	public String doSubmitCheck(Model model){
		//Patient
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		//Visit
		EdcVisit visit = (EdcVisit) getSessionAttribute(GlobalConstant.EDC_CURR_VISIT);
		if(visit!=null){
			String visitFlow = visit.getVisitFlow();
			PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			PubPatientVisit patientVisit = inputBiz.readPatientVisit(proj.getProjFlow(),visitFlow,patientFlow);
			
			boolean isOper1 = false;
			if(patientVisit != null ){
				EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(patientVisit.getRecordFlow());
				
				if(EdcInputStatusEnum.Save.getId().equals(edcPatientVisit.getInputOper1StatusId())){
					//录一核对
					edcPatientVisit.setInputOper1StatusId(EdcInputStatusEnum.Submit.getId());
					edcPatientVisit.setInputOper1StatusName(EdcInputStatusEnum.Submit.getName()); 
					edcPatientVisit.setInputOper1Time(DateUtil.getCurrDateTime());
					isOper1 = true;
				}else if(EdcInputStatusEnum.Save.getId().equals(edcPatientVisit.getInputOper2StatusId())){
					//录二核对
					edcPatientVisit.setInputOper2StatusId(EdcInputStatusEnum.Submit.getId());
					edcPatientVisit.setInputOper2StatusName(EdcInputStatusEnum.Submit.getName()); 
					edcPatientVisit.setInputOper2Time(DateUtil.getCurrDateTime());
				}
			
				
				edcPatientVisit.setInputOperFlow(GlobalContext.getCurrentUser().getUserFlow());
				edcPatientVisit.setInputOperName(GlobalContext.getCurrentUser().getUserName());
				edcPatientVisit.setInputOperStatusId(EdcInputStatusEnum.Checked.getId());
				edcPatientVisit.setInputOperStatusName(EdcInputStatusEnum.Checked.getName()); 
				edcPatientVisit.setInputOperTime(DateUtil.getCurrDateTime());
				
	//			List<PatientVisitData> visitData = inputBiz.searchPatientVisitData(patientVisit.getRecordFlow());
	//			for(PatientVisitData data : visitData){
	//				if(isOper1){
	//					data.setAttrValue(data.getAttrValue1());
	//				}else {
	//					data.setAttrValue(data.getAttrValue2());
	//				}
	//			}
	//			批量修改
				inputBiz.modifyPatientVisit(edcPatientVisit, isOper1);
			}
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/delSerialSeqData" },method={RequestMethod.GET})
	@ResponseBody
	public String delSerialSeqData(String elementCode,String elementSerialSeq){
		//Patient
		PubPatient patient = (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		String patientFlow = patient.getPatientFlow();
		//Visit
		EdcVisit visit = (EdcVisit) getSessionAttribute(GlobalConstant.EDC_CURR_VISIT);
		String visitFlow = visit.getVisitFlow();
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		PubPatientVisit patientVisit = inputBiz.readPatientVisit(proj.getProjFlow(),visitFlow,patientFlow);
		if(patientVisit != null){
			inputBiz.delVisitData(patientVisit.getRecordFlow(),elementCode,elementSerialSeq);
		}
		
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/abnormalInputMain" },method={RequestMethod.GET})
	public String abnormalInputMain(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		return "edc/input/abnormalInputMain";
	}
	
	@RequestMapping(value = {"/abnormalInputList" },method={RequestMethod.GET})//TODO
	public String abnormalInputList(String orgFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
			logger.info("==============init proj desc ========");
			EdcDesignForm designForm = edcModuleBiz.getDescForm(projFlow);
			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
		}
		
		EdcPatientVisitDataExample dataExample = new EdcPatientVisitDataExample();
		dataExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andAttrValueTipIsNotNull();
		dataExample.setOrderByClause("modify_time");
		List<EdcPatientVisitData> datas = inputBiz.searchPatientVisitData(dataExample);
		
		List<PubPatient> patientList = inputBiz.searPatientList(projFlow);
		Map<String,PubPatient> patientMap = new HashMap<String, PubPatient>();
		for(PubPatient patient : patientList){
			patientMap.put(patient.getPatientFlow(),patient);
		}
		model.addAttribute("patientMap", patientMap);
		
		//按机构过滤
		List<EdcPatientVisitData> dataList = new ArrayList<EdcPatientVisitData>();
		if (StringUtil.isNotBlank(orgFlow)) {
			if (datas != null) {
				for (EdcPatientVisitData data:datas) {
					PubPatient patient = patientMap.get(data.getPatientFlow());
					if (patient != null && patient.getOrgFlow().equals(orgFlow)) {
						dataList.add(data);
					}
				}
			}
		} else {
			dataList = datas;
		}
		model.addAttribute("dataList", dataList);
		
//		Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = new HashMap<String, Map<String,Map<String,EdcPatientVisitData>>>();

//		 
//		
//		for(EdcPatientVisitData data : dataList){
//			Map<String,Map<String,EdcPatientVisitData>> serialSeqMap = elementSerialSeqValueMap.get(data.getRecordFlow()+"_"+ data.getElementCode());
//			if(serialSeqMap == null){
//				serialSeqMap = new TreeMap<String, Map<String,EdcPatientVisitData>>();
//			}
//			Map<String,EdcPatientVisitData> valueMap  = serialSeqMap.get(data.getElementSerialSeq());
//			if(valueMap == null){
//				valueMap = new HashMap<String, EdcPatientVisitData>();
//			}
//			valueMap.put(data.getAttrCode(), data);
//			serialSeqMap.put(data.getElementSerialSeq(), valueMap);
//			elementSerialSeqValueMap.put(data.getRecordFlow()+"_"+ data.getElementCode(), serialSeqMap);
//		}
//		model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
		
		return "edc/input/abnormalInputList";
	}
	
	@RequestMapping(value = {"/dataTrail" },method={RequestMethod.GET,RequestMethod.POST})
	public String dataTrail(String orgFlow,String patientCode,String moduleCode,String elementAttrCode,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		logger.info("getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)="+getSessionAttribute(GlobalConstant.PROJ_DESC_FORM));
		if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
			logger.info("==============init proj desc ========");
			EdcDesignForm designForm = edcModuleBiz.getDescForm(projFlow);
			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
		}
		
		
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);	
		
		
		
		EdcVisitDataEventExample example = new EdcVisitDataEventExample();
		com.pinde.sci.model.mo.EdcVisitDataEventExample.Criteria criteria =  example.createCriteria()
				.andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y); 
		if(StringUtil.isNotBlank(orgFlow)){
			criteria.andOrgFlowEqualTo(orgFlow);
		}
		if(StringUtil.isNotBlank(patientCode)){
			criteria.andPatientCodeEqualTo(patientCode);
		}
		if(StringUtil.isNotBlank(moduleCode)){
			criteria.andModuleCodeEqualTo(moduleCode);
			
		}
		if(StringUtil.isNotBlank(elementAttrCode)){
			criteria.andElementCodeEqualTo(StringUtil.split(elementAttrCode, "_")[0]);
			criteria.andAttrCodeEqualTo(StringUtil.split(elementAttrCode, "_")[1]);
		}
		example.setOrderByClause("ORG_FLOW,PATIENT_CODE,ELEMENT_CODE,ATTR_CODE,ELEMENT_SERIAL_SEQ,EVENT_TIME");
		List<EdcVisitDataEvent> eventList = inspectBiz.searchEdcDataVisitEvent(example);
		model.addAttribute("eventList", eventList);
		return "/edc/input/dataTrail";
	}
	
	@RequestMapping(value = {"/editPatientConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String editPatientConfirm(String patientFlow, Model model){
		PubPatient patient = patientBiz.readPatient(patientFlow);
		if (patient != null) {
			String inDate = patient.getInDate();
			if (StringUtil.isNotBlank(inDate)) {
				return GlobalConstant.OPRE_FAIL;
			}
		}
		return  GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/editPubPatient" })
	public String editPubPatient(String patientScope,String patientType, String patientFlow, String visitFlow, Model model){
		model.addAttribute("patientScope", patientScope);
		model.addAttribute("patientType", patientType);
		PubPatient patient = patientBiz.readPatient(patientFlow);
		if (StringUtil.isNotBlank(visitFlow)) {
			PubPatientVisit pateintVisit = inputBiz.readPatientVisit(patient.getProjFlow(),visitFlow,patientFlow);
			
			if(pateintVisit != null ){
				EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
				String currOperFlow = edcPatientVisit.getInputOper1Flow();
				String inputStatusId = edcPatientVisit.getInputOper1StatusId();
				model.addAttribute( "currOperFlow", currOperFlow);
				model.addAttribute( "inputStatusId", inputStatusId);
			}
		}
		
		model.addAttribute( "patientFlow", patientFlow);
		model.addAttribute( "visitFlow", visitFlow);
		return "/edc/input/editPubPatient";
	}
	
	@RequestMapping(value = {"/savePubPatient"} ,method={RequestMethod.POST})
	@ResponseBody
	public String savePubPatient(String patientFlow, PubPatient patient){
		patient.setPatientNamePy(PyUtil.getFirstSpell(patient.getPatientName()).toUpperCase());
		patient.setSexName(UserSexEnum.getNameById(patient.getSexId()));
		patient.setPatientFlow(patientFlow);
		patient.setPatientStageId(PatientStageEnum.In.getId());
		patient.setPatientStageName(PatientStageEnum.In.getName());
		patient.setInDate(DateUtil.getDateTime(patient.getInDate()));	//入组日期转换为yyyyMMddHHmmss格式
		patient.setInDoctorFlow(GlobalContext.getCurrentUser().getUserFlow());
		patient.setInDoctorName(GlobalContext.getCurrentUser().getUserName());
		patientBiz.savePubPatient(patient);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/selVisit" },method={RequestMethod.GET})
	public String selVisit(String patientScope,String patientType,String groupFlow, String visitFlow, String patientFlow, Model model) {
		model.addAttribute("patientScope", patientScope);
		model.addAttribute("patientType", patientType);
		model.addAttribute("groupFlow", groupFlow);
		
		PubPatient patient = patientBiz.readPatient(patientFlow);
		model.addAttribute("patient", patient);
		setSessionAttribute(GlobalConstant.EDC_CURR_PATIENT, patient);
		
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		model.addAttribute("visit", visit);
		setSessionAttribute(GlobalConstant.EDC_CURR_VISIT, visit);
		
		
		PubPatientVisit patientVisit = inputBiz.readPatientVisit(patient.getProjFlow(),visitFlow,patientFlow);
		
		model.addAttribute("patientVisit", patientVisit);
		if(patientVisit != null ){
			EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(patientVisit.getRecordFlow());
			model.addAttribute("edcPatientVisit", edcPatientVisit);
			
			String currOperFlow = GlobalContext.getCurrentUser().getUserFlow();
			String inputOperStatusId = edcPatientVisit.getInputOperStatusId();
			String inputOperFlow = edcPatientVisit.getInputOperFlow();
			if (StringUtil.isNotBlank(inputOperStatusId) && inputOperStatusId.equals(EdcInputStatusEnum.Checked.getId())) {	//录入完成
				model.addAttribute("inputOperFlow", inputOperFlow);
				model.addAttribute("inputStatusId", inputOperStatusId);
			} else {
				model.addAttribute("inputOperFlow", currOperFlow);
				if (currOperFlow.equals(edcPatientVisit.getInputOper1Flow())) {
					model.addAttribute("inputStatusId", edcPatientVisit.getInputOper1StatusId());
				} else {
					model.addAttribute("inputStatusId", edcPatientVisit.getInputOper2StatusId());
				}
			}
			
			//页面使用，单次，多次 通用
			Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap = inputBiz.getelementSerialSeqValueMap(patientVisit.getRecordFlow());
			model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
		}
		
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		String orgFlow = patient.getOrgFlow();
		
		if(StringUtil.isNotBlank(orgFlow)){
			List<PubPatient> patientList = null;
			EdcProjParam param = inputBiz.readProjParam(projFlow);
			boolean isRandom = GeneralMethod.isRandom(param);
			
			if (StringUtil.isNotBlank(groupFlow) && PatientTypeEnum.Real.getId().equals(patientType)) {
				String groupName = "";
				EdcGroup group = groupBiz.read(groupFlow);
				if (group != null) {
					groupName = group.getGroupName();
				}
				patientList = patientBiz.searchPatientByGroup(projFlow, orgFlow, isRandom, groupName);
			} else {
				PubPatientExample example = new PubPatientExample();
				Criteria criteria =  example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow)
				.andPatientTypeIdEqualTo(patientType).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				if (isRandom && PatientTypeEnum.Real.getId().equals(patientType)) {		//随机试验过滤未入组样本,模拟录入不过滤
					criteria.andInDateIsNotNull();
				}
				example.setOrderByClause("patient_Seq");
				patientList = patientBiz.searchPatient(example);
			}
			model.addAttribute("patientList", patientList);
		}
		
		List<EdcVisit> visitList = null;
		if (StringUtil.isNotBlank(groupFlow) && PatientTypeEnum.Real.getId().equals(patientType)) {
			visitList = visitBiz.searchVisitsByGroupFlow(projFlow,groupFlow,null);
		} else {
			visitList = visitBiz.searchVisitList(projFlow);
		}
		model.addAttribute("visitList", visitList);
		
		return "edc/input/input";
	}
	
	@RequestMapping(value = {"/selPatientConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String selPatientConfirm(String visitFlow, String patientFlow){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		PubPatientVisit patientVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
		if (patientVisit != null) {
			EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(patientVisit.getRecordFlow());
			String inputOper1Flow = edcPatientVisit.getInputOper1Flow();
			String inputOper2Flow = edcPatientVisit.getInputOper2Flow();
			String currOperFlow = GlobalContext.getCurrentUser().getUserFlow();
			if (StringUtil.isNotBlank(inputOper1Flow) && StringUtil.isNotBlank(inputOper2Flow)) {
				if (!currOperFlow.equals(inputOper1Flow) && !currOperFlow.equals(inputOper2Flow)) {
					return GlobalConstant.OPRE_FAIL;
				}
			}
		}
		//判断是否需要弹框编辑姓名、性别等基本信息
		PubPatient patient = patientBiz.readPatient(patientFlow);
		if (patient != null && PatientTypeEnum.Real.getId().equals(patient.getPatientTypeId()) 
				&& StringUtil.isBlank(patient.getInDate())) {
			return GlobalConstant.OPRE_FAIL_FLAG;
		}
		
		return  GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/cancleSubmit" },method={RequestMethod.GET})
	@ResponseBody
	public String cancleSubmit(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		String patientFlow =  ((PubPatient)getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT)).getPatientFlow();
		String visitFlow =  ((EdcVisit)getSessionAttribute(GlobalConstant.EDC_CURR_VISIT)).getVisitFlow();
		
		PubPatientVisit pateintVisit = inputBiz.readPatientVisit(projFlow,visitFlow,patientFlow);
		EdcPatientVisit edcPatientVisit = inputBiz.readEdcPatientVisit(pateintVisit.getRecordFlow());
		SysUser currUser = GlobalContext.getCurrentUser();
		String currUserFlow = currUser.getUserFlow();
		
		setCancelStatus(edcPatientVisit,currUserFlow);
		
		inputBiz.modifyEdcPatientVisit(edcPatientVisit);
		
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	private void setCancelStatus(EdcPatientVisit pateintVisit, String currUserFlow) {
		String statusId = EdcInputStatusEnum.Save.getId();
		String statusName = EdcInputStatusEnum.Save.getName();
		if(currUserFlow.equals(pateintVisit.getInputOper1Flow()) && 
				currUserFlow.equals(pateintVisit.getInputOper2Flow())){//单份录入或快速录入
			pateintVisit.setInputOper1StatusId(statusId);
			pateintVisit.setInputOper1StatusName(statusName);
			
			pateintVisit.setInputOper2StatusId(statusId);
			pateintVisit.setInputOper2StatusName(statusName);
			
			pateintVisit.setInputOperStatusId(statusId);
			pateintVisit.setInputOperStatusName(statusName);
		} else {
			if (currUserFlow.equals(pateintVisit.getInputOper1Flow())) {
				pateintVisit.setInputOper1StatusId(statusId);
				pateintVisit.setInputOper1StatusName(statusName);
			}
			if (currUserFlow.equals(pateintVisit.getInputOper2Flow())) {
				pateintVisit.setInputOper2StatusId(statusId);
				pateintVisit.setInputOper2StatusName(statusName);
			}
			
			if(EdcInputStatusEnum.Submit.getId().equals(pateintVisit.getInputOperStatusId())){
				pateintVisit.setInputOperStatusId("");
				pateintVisit.setInputOperStatusName("");
			} else if (EdcInputStatusEnum.Checked.getId().equals(pateintVisit.getInputOperStatusId())) {
				pateintVisit.setInputOperStatusId(EdcInputStatusEnum.Submit.getId());
				pateintVisit.setInputOperStatusName(EdcInputStatusEnum.Submit.getName());
			}
		}
	}
	@RequestMapping(value = {"/showPatientCase" },method={RequestMethod.GET})
	
	public String showPatientCase(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		
		String patientFlow =  ((PubPatient)getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT)).getPatientFlow();
		
		PubPatientIeExample  example = new PubPatientIeExample();
		example.createCriteria().andPatientFlowEqualTo(patientFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubPatientIe> recList = patientIeMapper.selectByExampleWithBLOBs(example);
		List<Map<String,String>> dataList = new ArrayList<Map<String,String>>(); 
		if(recList.size()>0){
			PubPatientIe record = recList.get(0);
			try {
				Document doc = DocumentHelper.parseText(record.getIeInfo());
				Element rootEle = doc.getRootElement();
				List<Element> images = rootEle.elements();
				if(images!=null){
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
		
		return "edc/input/patientCaseList";
	}
	
}

