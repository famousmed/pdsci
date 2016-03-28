package com.pinde.sci.ctrl.edc;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IInspectBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.edc.EdcQuerySendWayEnum;
import com.pinde.sci.enums.edc.EdcQuerySolveStatusEnum;
import com.pinde.sci.enums.edc.EdcQueryStatusEnum;
import com.pinde.sci.enums.edc.EdcSdvStatusEnum;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.PatientVisitForm;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcPatientVisit;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcQuery;
import com.pinde.sci.model.mo.EdcQueryExample;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitDataEvent;
import com.pinde.sci.model.mo.EdcVisitDataEventExample;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientExample.Criteria;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;

@Controller
@RequestMapping("/edc/inspect")
public class InspectController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(InspectController.class);
	
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
	
	
	
	@RequestMapping(value = {"/sdv" },method={RequestMethod.GET})
	public String listMain(String orgFlow,Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		
		List<EdcGroup> groupList = groupBiz.searchEdcGroup(projFlow);
		model.addAttribute("groupList", groupList);
		
		logger.info("getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)="+getSessionAttribute(GlobalConstant.PROJ_DESC_FORM));
		if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
			logger.info("==============init proj desc ========");
			EdcDesignForm designForm = edcModuleBiz.getCrfDescForm(projFlow);
			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
		}
		return "edc/inspect/sdv/patientListMain";
	}
	
	@RequestMapping(value = {"/list" },method={RequestMethod.GET})
	public String list(String patientScope,String orgFlow,String groupFlow,Model model) {
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
			boolean isRandom = GeneralMethod.isRandom(projParam);
			if (StringUtil.isNotBlank(groupFlow)) {
				String groupName = "";
				EdcGroup group = groupBiz.read(groupFlow);
				if (group != null) {
					groupName = group.getGroupName();
				}
				patientList = patientBiz.searchPatientByGroup(projFlow, orgFlow, isRandom, groupName);
			} else {
				PubPatientExample example = new PubPatientExample();
				Criteria criteria =  example.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				criteria.andOrgFlowEqualTo(orgFlow);
				if (isRandom) {		//随机试验过滤未入组样本
					criteria.andInDateIsNotNull();
				}
				example.setOrderByClause("patient_Seq");
				patientList = patientBiz.searchPatient(example);
			}
			model.addAttribute("patientList", patientList);
		}
		
		List<EdcVisit> visitList = null;
		if (StringUtil.isNotBlank(groupFlow)) {
			visitList = visitBiz.searchVisitsByGroupFlow(projFlow,groupFlow,null);
		} else {
			visitList = visitBiz.searchVisitList(projFlow);
		}
		model.addAttribute("visitList", visitList);	
		
		Map<String,Map<String,PatientVisitForm>>   patientVisitMap = inputBiz.searchPatientVisitMap(projFlow,orgFlow);
		model.addAttribute("patientVisitMap", patientVisitMap);
		
		return "edc/inspect/sdv/patientList";
	}
	@RequestMapping(value = {"/inputOperInfo" },method={RequestMethod.GET})
	public String inputOperInfo(String recordFlow,Model model) {
		EdcPatientVisit edcPatientVisit = inputBiz.selectPatientVisit(recordFlow).getEdcPatientVisit();
		model.addAttribute("edcPatientVisit", edcPatientVisit);
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		//项目参数
		EdcProjParam projParam = inputBiz.readProjParam(proj.getProjFlow());
		String inputTypeId = projParam.getInputTypeId();
		model.addAttribute("inputTypeId", inputTypeId);
		return "edc/inspect/sdv/inputOperInfo";
	}
	@RequestMapping(value = {"/sdvMain" },method={RequestMethod.GET})
	public String sdvMain(String recordFlow,Model model) {
		PatientVisitForm patientVisit = inputBiz.selectPatientVisit(recordFlow);
		model.addAttribute("patientVisitForm", patientVisit);
		
		PubPatient patient = patientBiz.readPatient(patientVisit.getPatientVisit().getPatientFlow());
		model.addAttribute("patient", patient);
		setSessionAttribute(GlobalConstant.EDC_CURR_PATIENT, patient);
		
		EdcVisit visit = visitBiz.readVisit(patientVisit.getPatientVisit().getVisitFlow());
		model.addAttribute("visit", visit);
		setSessionAttribute(GlobalConstant.EDC_CURR_VISIT, visit);
		
		List<EdcPatientVisitData> visitData = inputBiz.searchPatientVisitData(recordFlow);
		//页面使用，单次，多次 通用
		Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = new HashMap<String, Map<String,Map<String,EdcPatientVisitData>>>();
 
		for(EdcPatientVisitData data : visitData){
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
		}
		model.addAttribute("elementSerialSeqValueMap", elementSerialSeqValueMap);
		
		//组织判断属性是否已发送sdv疑问map
		Map<String,Boolean> attrSDVQueryMap  = new HashMap<String,Boolean>();	//判断属性是否已发送sdv疑问	
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		String patientFlow = patient.getPatientFlow();
		EdcQueryExample example = new EdcQueryExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andPatientFlowEqualTo(patientFlow).
		andQueryTypeIdEqualTo(GlobalConstant.QUERY_TYPE_SDV).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcQuery> queryList = inspectBiz.searchEdcQuery(example);
		List<String> queryFlowList = new ArrayList<String>();
		if (queryList != null) {
			for (EdcQuery query:queryList) {
				queryFlowList.add(query.getQueryFlow());
			}
		}
		if (queryFlowList.size()>0) {
			EdcVisitDataEventExample examp = new EdcVisitDataEventExample();
			examp.createCriteria().andQueryFlowIn(queryFlowList);
			List<EdcVisitDataEvent> eventList = inspectBiz.searchEdcDataVisitEvent(examp);
			if (eventList != null && eventList.size()>0) {
				for (EdcVisitDataEvent event:eventList) {
					attrSDVQueryMap.put(event.getPatientFlow()+"_"+event.getVisitFlow()+"_"+event.getAttrCode()+"_"+event.getElementSerialSeq(), true);
				}
			}
		}
		model.addAttribute("attrSDVQueryMap", attrSDVQueryMap);
		
		return "edc/inspect/sdv/sdvMain";
	}
	
	@RequestMapping(value = {"/doSdvSubmit" },method={RequestMethod.GET})
	@ResponseBody
	public String doSdvSubmit(String recordFlow,Model model) {
		PatientVisitForm patientVisitForm = inputBiz.selectPatientVisit(recordFlow);
		EdcPatientVisit edcPatientVisit = patientVisitForm.getEdcPatientVisit();
		edcPatientVisit.setSdvOperFlow(GlobalContext.getCurrentUser().getUserFlow());
		edcPatientVisit.setSdvOperName(GlobalContext.getCurrentUser().getUserName());
		edcPatientVisit.setSdvOperTime(DateUtil.getCurrDateTime());
		edcPatientVisit.setSdvOperStatusId(EdcSdvStatusEnum.Sdved.getId());
		edcPatientVisit.setSdvOperStatusName(EdcSdvStatusEnum.Sdved.getName());
		inputBiz.modifyEdcPatientVisit(edcPatientVisit);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	@RequestMapping(value = {"/confirmQuerySend" },method={RequestMethod.GET})
	@ResponseBody
	public String confirmQuerySend(String recordFlow) {
		EdcDesignForm designForm = (EdcDesignForm) getSessionAttribute(GlobalConstant.PROJ_DESC_FORM);
		//禁止重复发送
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
		
		if(visitData!=null){
			recordFlow = visitData.getRecordFlow();		//不可省略
			List<EdcQuery> queryList = inspectBiz.searchUnSolveSdvQuery(recordFlow);
			if(queryList!=null && queryList.size()>0){
				StringBuffer alert = new StringBuffer(designForm.getElementMap().get(visitData.getElementCode()).getElementName());
					if(!designForm.getAttrMap().get(visitData.getAttrCode()).getAttrVarName().equals(GlobalConstant.DEFAULT_ATTR_VALUE_VAR_NAME)){
						alert.append("."+designForm.getAttrMap().get(visitData.getAttrCode()).getAttrName()); 
					};	
					alert.append(" "+GlobalConstant.MANUAL_QUERY_CONFIRM); 
				return alert.toString()+"_recordFlow_"+recordFlow;
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	
	@RequestMapping(value = {"/sdvQuery" },method={RequestMethod.GET})
	@ResponseBody
	public String sdvQuery(String recordFlow,String orgFlow,String emptyDataKey,Model model) {
		EdcPatientVisitData visitData = inputBiz.readEdcPatientVisitData(recordFlow);
		
		if(visitData==null){
			visitData = _addEmptyVisitData(emptyDataKey);
		}
		EdcDesignForm designForm = (EdcDesignForm) getSessionAttribute(GlobalConstant.PROJ_DESC_FORM);
		String visitName = designForm.getVisitMap().get(visitData.getVisitFlow()).getVisitName();
		String moduleName = designForm.getModuleMap().get(visitData.getModuleCode()).getModuleName();
		String elementName = designForm.getElementMap().get(visitData.getElementCode()).getElementName();
		String attrName = designForm.getAttrMap().get(visitData.getAttrCode()).getAttrName();
		
		String queryContent = visitName+"."+moduleName+"."+elementName+"."+attrName;
		
		EdcQuery query = _addQuery(EdcQuerySendWayEnum.Sdv.getId(),EdcQuerySendWayEnum.Sdv.getName(),GlobalConstant.QUERY_TYPE_SDV,queryContent);
		
		EdcVisitDataEvent dataEvent = _addDataEvent(visitData,query);
		
		//修改sdv审核中状态
		EdcPatientVisit patientVisit = inputBiz.readEdcPatientVisit(visitData.getVisitRecordFlow());
		if(StringUtil.isBlank(patientVisit.getSdvOperStatusId())){ 
			patientVisit.setSdvOperStatusId(EdcSdvStatusEnum.Sdving.getId());
			patientVisit.setSdvOperStatusName(EdcSdvStatusEnum.Sdving.getName());
			patientVisit.setSdvOperTime(DateUtil.getCurrDateTime());
			patientVisit.setSdvOperFlow(GlobalContext.getCurrentUser().getUserFlow());
			patientVisit.setSdvOperName(GlobalContext.getCurrentUser().getUserName());
			inputBiz.modifyEdcPatientVisit(patientVisit);
		}
		
		inspectBiz.addEdcQuery(query,dataEvent);
		return GlobalConstant.OPRE_SUCCESSED; 
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

	private EdcQuery _addQuery(String sendWayId,String sendWayName,String queryTypeId,String queryContent) {
		PubPatient patient =  (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
		
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
		query.setSendUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		query.setSendUserName(GlobalContext.getCurrentUser().getUserName());
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

	private EdcVisitDataEvent _addDataEvent(EdcPatientVisitData visitData,EdcQuery query) {
		EdcDesignForm designForm = (EdcDesignForm) getSessionAttribute(GlobalConstant.PROJ_DESC_FORM);
		PubPatient patient =  (PubPatient) getSessionAttribute(GlobalConstant.EDC_CURR_PATIENT);
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
	@RequestMapping(value = {"/manual" },method={RequestMethod.GET})
	public String manual(String orgFlow,String patientFlow,String type,Model model) {
		model.addAttribute("orgFlow", orgFlow);
		model.addAttribute("patientFlow", patientFlow);
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcProjParam projParam = inputBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);	
		
		if ("patient".equals(type)) {
			if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
				logger.info("==============init proj desc ========");
				EdcDesignForm designForm = edcModuleBiz.getCrfDescForm(projFlow);
				setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
			}
		} else {
			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, null);
		}
		
		if(StringUtil.isNotBlank(orgFlow)){
			PubPatientExample exam = new PubPatientExample();
			Criteria criteria =  exam.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			criteria.andOrgFlowEqualTo(orgFlow);
			boolean isRandom = GeneralMethod.isRandom(projParam);
			if (isRandom) {		//随机试验过滤未入组样本
				criteria.andInDateIsNotNull();
			}
			exam.setOrderByClause("patient_Seq");
			List<PubPatient> patientList = patientBiz.searchPatient(exam);
			model.addAttribute("patientList", patientList);
		}
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = inputBiz.readPatient(patientFlow);
			if (patient.getOrgFlow().equals(orgFlow)) {
				model.addAttribute("patient", patient);
				
				//覆盖Session Patient
				setSessionAttribute(GlobalConstant.EDC_CURR_PATIENT,patient);
				
				
				//受试者访视
				Map<String,PatientVisitForm> patientSubmitVisitMap = inputBiz.getPatientSubmitVisitMap(projFlow,patientFlow);
				model.addAttribute("patientSubmitVisitMap", patientSubmitVisitMap);
				
				//受试者CRF-所有录入 数据 visitFlow-elementSerialSeqValueMap 
				Map<String,Map<String,Map<String,Map<String,EdcPatientVisitData>>>> patientCrfDataMap = new HashMap<String, Map<String,Map<String,Map<String,EdcPatientVisitData>>>>();
				for(Map.Entry<String, PatientVisitForm> entity : patientSubmitVisitMap.entrySet()){
					patientCrfDataMap.put(entity.getKey(), inputBiz.getelementSerialSeqValueMap(entity.getValue().getEdcPatientVisit().getRecordFlow()));
				}
				model.addAttribute("patientCrfDataMap", patientCrfDataMap);
			} else {
				model.addAttribute("patientFlow", "");
			}
		}
		
		return "/edc/inspect/manual/manualMain";
	}
	
	@RequestMapping(value = {"/manualQuery" },method={RequestMethod.GET})
	public String manualQuery() {
		return "/edc/inspect/manual/manualQuery";
	}
	
	
	@RequestMapping(value = {"/manualQuery" },method={RequestMethod.POST})
	@ResponseBody
	public String manualQuery(String[] recordFlow ,String queryTypeId,String queryContent) {
		
		EdcQuery query =  _addQuery(EdcQuerySendWayEnum.Manual.getId(),EdcQuerySendWayEnum.Manual.getName(),queryTypeId,queryContent);
		List<EdcVisitDataEvent> dataEventList = new ArrayList<EdcVisitDataEvent>();
		for(String flow : recordFlow){
			EdcPatientVisitData visitData = inputBiz.readEdcPatientVisitData(flow);
			if(visitData==null){
				visitData = _addEmptyVisitData(flow);
			}
			EdcVisitDataEvent dataEvent = _addDataEvent(visitData,query);
			dataEventList.add(dataEvent);
		}
		inspectBiz.addEdcQuery(query,dataEventList);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	@RequestMapping(value = {"/unSolverQuery" },method={RequestMethod.GET})
	public String unSolverQuery(String  recordFlow ,Model model) {
		
		List<EdcQuery> queryList = inspectBiz.searchUnSolveSdvQuery(recordFlow);
		model.addAttribute("queryList", queryList);
		
		Map<String,List<EdcVisitDataEvent>> queryEventMap = new HashMap<String, List<EdcVisitDataEvent>>();
		for(EdcQuery query :queryList){
			EdcVisitDataEventExample eventExample = new EdcVisitDataEventExample();
			eventExample.createCriteria().andQueryFlowEqualTo(query.getQueryFlow());
			List<EdcVisitDataEvent> temp = inspectBiz.searchEdcDataVisitEvent(eventExample);
			queryEventMap.put(query.getQueryFlow(), temp);
		}
		model.addAttribute("queryEventMap", queryEventMap);
		
		return "/edc/inspect/manual/unSolveQuery";
	}
	
	@RequestMapping(value = {"/showAllQuery" },method={RequestMethod.GET})
	public String showAllQuery(String patientFlow, String sendWayId, Model model){
		PubPatient patient = patientBiz.readPatient(patientFlow);
		model.addAttribute("patient", patient);
		model.addAttribute("sendWayId", sendWayId);
		
		EdcQueryExample example = new EdcQueryExample();
		if (StringUtil.isNotBlank(sendWayId)) {
			if (sendWayId.equals("SDV")) {
				example.createCriteria().andPatientFlowEqualTo(patientFlow).andSendWayIdEqualTo(GlobalConstant.SEND_WAY_SDV).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			} else {
				List<String> sendWays = new ArrayList<String>();
				sendWays.add(GlobalConstant.SEND_WAY_MANUAL);
				sendWays.add(GlobalConstant.SEND_WAY_LOGIC);
				example.createCriteria().andPatientFlowEqualTo(patientFlow).andSendWayIdIn(sendWays).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			}
		} else {
			example.createCriteria().andPatientFlowEqualTo(patientFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		}
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
		
		return "/edc/inspect/manual/allQuery";
	}
	
}

