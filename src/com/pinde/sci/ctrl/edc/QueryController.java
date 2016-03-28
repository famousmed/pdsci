package com.pinde.sci.ctrl.edc;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.pdf.DocumentVo;
import com.pinde.core.pdf.PdfDocumentGenerator;
import com.pinde.core.pdf.utils.ResourceLoader;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IInspectBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.common.DateTrans;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.enums.edc.EdcQuerySendWayEnum;
import com.pinde.sci.enums.edc.EdcQuerySolveStatusEnum;
import com.pinde.sci.enums.edc.EdcQueryStatusEnum;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.PatientVisitForm;
import com.pinde.sci.model.mo.EdcDcf;
import com.pinde.sci.model.mo.EdcDcfExample;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcQuery;
import com.pinde.sci.model.mo.EdcQueryExample;
import com.pinde.sci.model.mo.EdcQueryExample.Criteria;
import com.pinde.sci.model.mo.EdcVisitDataEvent;
import com.pinde.sci.model.mo.EdcVisitDataEventExample;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;

@Controller
@RequestMapping("/edc/query")
public class QueryController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(QueryController.class);
	
	
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IInspectBiz inspectBiz;
	@Autowired
	private IInputBiz inputBiz;
	@Autowired
	private IPubPatientBiz patientBiz; 
	@Autowired
	private IEdcModuleBiz edcModuleBiz; 
	@Autowired
	private PubProjMapper pubProjMapper;
	@Autowired
	private IFileBiz pubFileBiz; 
	
	
	@RequestMapping(value = {"/main" },method={RequestMethod.GET})
	public String main(Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);	
		
		return "edc/query/queryMain";
	}
	
	@RequestMapping(value = {"/list" },method={RequestMethod.GET})
	public String list(String orgFlow,String patientCode,Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcQueryExample example = new EdcQueryExample();
		Criteria criteria =  example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(patientCode)){
			criteria.andPatientCodeEqualTo(patientCode);
		}
		if(StringUtil.isNotBlank(orgFlow)){
			criteria.andOrgFlowEqualTo(orgFlow);
		}
		example.setOrderByClause("patient_code,send_time");
		List<EdcQuery> queryList = inspectBiz.searchEdcQuery(example);
		model.addAttribute("queryList", queryList);
		return "edc/query/queryList";
	}

	@RequestMapping(value = {"/showQueryEvent" },method={RequestMethod.GET})
	public String showQueryEvent(String queryFlow,Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = inputBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
			logger.info("==============init proj desc ========");
			EdcDesignForm designForm = edcModuleBiz.getDescForm(projFlow);
			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
		}
		
		
		EdcQuery query = inspectBiz.readEdcQuery(queryFlow);
		model.addAttribute("query", query);
		
		EdcVisitDataEventExample data = new EdcVisitDataEventExample();  
		data.createCriteria().andProjFlowEqualTo(projFlow).andQueryFlowEqualTo(queryFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		data.setOrderByClause("modify_time");
		List<EdcVisitDataEvent> dataList = inspectBiz.searchEdcDataVisitEvent(data);
		model.addAttribute("dataList", dataList);
		return "edc/query/dataList";
	}

	
	@RequestMapping(value = {"/patientQueryMain/{patientScope}" },method={RequestMethod.GET})
	public String queryMain(@PathVariable String patientScope,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		if(GlobalConstant.DEPT_LIST_LOCAL.equals(patientScope)){
			
		}else if(GlobalConstant.DEPT_LIST_GLOBAL.equals(patientScope)){ 
			List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("pubProjOrgList", pubProjOrgList);	
		}
		model.addAttribute("patientScope", patientScope);
		
		return "edc/query/patientQueryMain";
	}
	@RequestMapping(value = {"/patientQueryList/{patientScope}" },method={RequestMethod.GET})
	public String querylist(@PathVariable String patientScope,String orgFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcProjParam projParam = inputBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		if(GlobalConstant.DEPT_LIST_LOCAL.equals(patientScope)){
			orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		}
	
		if(StringUtil.isNotBlank(orgFlow)){
			PubPatientExample exam = new PubPatientExample();
			com.pinde.sci.model.mo.PubPatientExample.Criteria criteria =  exam.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			criteria.andOrgFlowEqualTo(orgFlow);
			boolean isRandom = GeneralMethod.isRandom(projParam);
			if (isRandom) {		//随机试验过滤未入组样本
				criteria.andInDateIsNotNull();
			}
			exam.setOrderByClause("patient_Seq");
			List<PubPatient> patientList = patientBiz.searchPatient(exam);
			model.addAttribute("patientList", patientList);
			
			
			EdcQueryExample example = new EdcQueryExample();
			example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			List<EdcQuery> queryList = inspectBiz.searchEdcQuery(example);
			Map<String,Map<String,Map<String,Integer>>> patientQueryCountMap = new HashMap<String, Map<String,Map<String,Integer>>>();
			Map<String,Integer> summaryMap = new HashMap<String, Integer>();
			for(EdcQuery query : queryList){
				Map<String,Map<String,Integer>> queryCountMap = patientQueryCountMap.get(query.getPatientFlow());
				Integer summaryCount = summaryMap.get(query.getPatientFlow());
				if(queryCountMap == null){
					queryCountMap = new HashMap<String, Map<String,Integer>>();
				}
				if(summaryCount == null){
					summaryCount = 0;
				}
				summaryCount++;
				Map<String,Integer> countMap = queryCountMap.get(query.getSolveStatusId());
				
				if(countMap == null){
					countMap  = new HashMap<String, Integer>();
				}
				Integer count = countMap.get(query.getSendWayId());
				if(count == null){
					count = 0;
				}
				count++;
				countMap.put(query.getSendWayId(), count);
				queryCountMap.put(query.getSolveStatusId(), countMap);
				patientQueryCountMap.put(query.getPatientFlow(), queryCountMap);
				
				summaryMap.put(query.getPatientFlow(), summaryCount);
			}
			model.addAttribute("patientQueryCountMap", patientQueryCountMap);
			model.addAttribute("summaryMap", summaryMap);
		}
		
		return "edc/query/patientQueryList";
	}
	@RequestMapping(value = {"/crf" },method={RequestMethod.GET})
	public String crf(String patientFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		logger.info("getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)="+getSessionAttribute(GlobalConstant.PROJ_DESC_FORM));
		if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
			logger.info("==============init proj desc ========");
			EdcDesignForm designForm = edcModuleBiz.getCrfDescForm(projFlow);
			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
		}
		
		PubPatient patient = inputBiz.readPatient(patientFlow);
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
		
		
		//所有未处理的疑问
		EdcQueryExample example = new EdcQueryExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andPatientFlowEqualTo(patientFlow)
		.andSolveStatusIdEqualTo(EdcQuerySolveStatusEnum.UnSolve.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("SEND_TIME");
		List<EdcQuery> queryList = inspectBiz.searchEdcQuery(example);
		
		List<EdcQuery> sdvQueryList = new ArrayList<EdcQuery>();
		List<EdcQuery>	manualQueryList = new ArrayList<EdcQuery>();
		List<EdcQuery> logicQueryList = new ArrayList<EdcQuery>();
		Map<String,EdcQuery> queryMap = new HashMap<String, EdcQuery>();
		for(EdcQuery query : queryList){
			if(query.getSendWayId().equals(EdcQuerySendWayEnum.Sdv.getId())){
				sdvQueryList.add(query);
			}else if(query.getSendWayId().equals(EdcQuerySendWayEnum.Manual.getId())){
				manualQueryList.add(query);
			}else if(query.getSendWayId().equals(EdcQuerySendWayEnum.Logic.getId())){
				logicQueryList.add(query);
			}
			queryMap.put(query.getQueryFlow(), query);
		}
		model.addAttribute("sdvQueryList", sdvQueryList);
		model.addAttribute("manualQueryList", manualQueryList);
		model.addAttribute("logicQueryList", logicQueryList);
		
		
	
		EdcVisitDataEventExample  dataEventExample = new EdcVisitDataEventExample();
		dataEventExample.createCriteria().andProjFlowEqualTo(projFlow).andQueryFlowIsNotNull()
		.andPatientFlowEqualTo(patientFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcVisitDataEvent> dataList = inspectBiz.searchEdcDataVisitEvent(dataEventExample);
		//jcallout
		Map<String,Map<String,Map<String,String>>> visitAttrMap = new HashMap<String, Map<String,Map<String,String>>>();
		for(EdcVisitDataEvent event : dataList){
			String queryFlow = event.getQueryFlow();
			if(queryMap.get(queryFlow)!=null && queryMap.get(queryFlow).getSolveStatusId().equals(EdcQuerySolveStatusEnum.UnSolve.getId())){
				Map<String,Map<String,String>> serialSeqAttrMap = visitAttrMap.get(event.getVisitFlow());
				if(serialSeqAttrMap==null){
					serialSeqAttrMap = new HashMap<String, Map<String,String>>();
				}
				Map<String,String> attrMap = serialSeqAttrMap.get(event.getElementSerialSeq());
				if(attrMap == null){
					attrMap = new HashMap<String, String>();
				}
				attrMap.put(event.getAttrCode(), event.getQueryFlow());
				serialSeqAttrMap.put(event.getElementSerialSeq(), attrMap);
				visitAttrMap.put(event.getVisitFlow(),serialSeqAttrMap);
			}
		}
		model.addAttribute("visitAttrMap", visitAttrMap);
		
		return "edc/query/queryCrf";
	}
	
	@RequestMapping(value = {"/solveQuery" },method={RequestMethod.GET})
	@ResponseBody
	public String solveQuery(String queryFlow){
		EdcQuery query = inspectBiz.readEdcQuery(queryFlow);
		query.setSolveStatusId(EdcQuerySolveStatusEnum.Solved.getId());
		query.setSolveStatusName(EdcQuerySolveStatusEnum.Solved.getName());
		query.setSolveTime(DateUtil.getCurrDateTime());
		query.setSolveUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		query.setSolveUserName(GlobalContext.getCurrentUser().getUserName());
		
		inspectBiz.modifyQuery(query);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	@RequestMapping(value = {"/showQueryBySendWay" },method={RequestMethod.GET})
	public String showQueryBySendWay(String sendWayId,String patientFlow,Model model){
		EdcQueryExample example = new EdcQueryExample();
		example.createCriteria().andPatientFlowEqualTo(patientFlow).andSolveStatusIdEqualTo(EdcQuerySolveStatusEnum.UnSolve.getId())
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSendWayIdEqualTo(sendWayId);
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
		
		return "/edc/query/querySendWayList";
	}
	
	@RequestMapping(value = {"/sendConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String sendConfirm(String queryFlow,Model model){
		EdcQuery query = inspectBiz.readEdcQuery(queryFlow);
		query.setQueryStatusId(EdcQueryStatusEnum.Sended.getId());
		query.setQueryStatusName(EdcQueryStatusEnum.Sended.getName());
		inspectBiz.modifyQuery(query);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	@RequestMapping(value = {"/dcf" },method={RequestMethod.GET})
	public String dcf(String orgFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcQueryExample example = new EdcQueryExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andQueryStatusIdEqualTo(EdcQueryStatusEnum.Sended.getId())
		.andDcfNoIsNull().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y); 
		example.setOrderByClause("PATIENT_CODE,SEND_TIME");
		List<EdcQuery> queryList = inspectBiz.searchEdcQuery(example);
		
		List<EdcQuery> sdvList = new ArrayList<EdcQuery>();
		List<EdcQuery> notSdvList = new ArrayList<EdcQuery>();
		for(EdcQuery query :queryList ){
			if(query.getSendWayId().equals(EdcQuerySendWayEnum.Sdv.getId())){
				sdvList.add(query);
			}else {
				notSdvList.add(query);
			}
		}
		model.addAttribute("sdvList", sdvList);
		model.addAttribute("notSdvList", notSdvList);
		
		Map<String,List<EdcVisitDataEvent>> queryEventMap = new HashMap<String, List<EdcVisitDataEvent>>();
		for(EdcQuery query :queryList){
			EdcVisitDataEventExample eventExample = new EdcVisitDataEventExample();
			eventExample.createCriteria().andQueryFlowEqualTo(query.getQueryFlow());
			List<EdcVisitDataEvent> temp = inspectBiz.searchEdcDataVisitEvent(eventExample);
			queryEventMap.put(query.getQueryFlow(), temp);
		}
		model.addAttribute("queryEventMap", queryEventMap);
		
		PubProjOrg org = projOrgBiz.readProjOrg(projFlow, orgFlow);
		int centerNo = org.getCenterNo();
		
		//生成DCF
		String date = DateUtil.getCurrDate2();
		Integer seq = inspectBiz.readDcfSeq(projFlow,orgFlow);
		if(sdvList.size()>0){
			++seq;
			String dcfNo = "DCF-SDV-"+date+"-"+centerNo+"-"+seq;
			EdcDcf dcf = new EdcDcf();
			dcf.setDcfFlow(PkUtil.getUUID());
			dcf.setProjFlow(projFlow);
			dcf.setOrgFlow(orgFlow);
			dcf.setDcfDate(date);
			dcf.setDcfNo(dcfNo);
			dcf.setDcfUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			dcf.setDcfUserName(GlobalContext.getCurrentUser().getUserName());
			dcf.setOrdinal(seq);
			inspectBiz.addDcf(dcf);
			model.addAttribute("sdvDcf", dcf);
			for(EdcQuery query : sdvList){
				query.setDcfFlow(dcf.getDcfFlow());
				query.setDcfNo(dcfNo);
				inspectBiz.modifyQuery(query);
			}
		}
		if(notSdvList.size()>0){
			++seq;
			String dcfNo = "DCF-"+date+"-"+centerNo+"-"+seq;
			EdcDcf dcf = new EdcDcf();
			dcf.setDcfFlow(PkUtil.getUUID());
			dcf.setProjFlow(projFlow);
			dcf.setOrgFlow(orgFlow);
			dcf.setDcfDate(date);
			dcf.setDcfNo(dcfNo);
			dcf.setDcfUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			dcf.setDcfUserName(GlobalContext.getCurrentUser().getUserName());
			dcf.setOrdinal(seq);
			inspectBiz.addDcf(dcf);
			model.addAttribute("notSdvDcf", dcf);	
			
			for(EdcQuery query : notSdvList){
				query.setDcfFlow(dcf.getDcfFlow());
				query.setDcfNo(dcfNo);
				inspectBiz.modifyQuery(query);
			}
		}
		return "/edc/query/dcfQuery";
	}
	
	@RequestMapping(value = {"/dcflist" },method={RequestMethod.GET})
	public String dcflist(String orgFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);	
		if(StringUtil.isNotBlank(orgFlow)){
			EdcDcfExample	example = new EdcDcfExample();
			example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			example.setOrderByClause("ORDINAL");
			
			List<EdcDcf> dcfList = inspectBiz.searchEdcDcf(example);
			model.addAttribute("dcfList", dcfList);
		}
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		return "/edc/query/dcfList";
	}
	
	@RequestMapping(value = {"/showDcf" },method={RequestMethod.GET})
	public String showDcf(String dcfFlow,Model model){
		EdcDcf dcf = inspectBiz.readEdcDcf(dcfFlow);
		String dcfNo = dcf.getDcfNo();
		String orgFlow = dcf.getOrgFlow();
		model.addAttribute("orgFlow", orgFlow);
		
		EdcQueryExample example = new EdcQueryExample();
		example.createCriteria().andDcfFlowEqualTo(dcfFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y); 
		example.setOrderByClause("PATIENT_CODE,SEND_TIME");
		List<EdcQuery> queryList = inspectBiz.searchEdcQuery(example);
		if (dcfNo.indexOf("SDV")>0) {
			model.addAttribute("sdvDcf", dcf);
			model.addAttribute("sdvList", queryList);
		} else {
			model.addAttribute("notSdvDcf", dcf);
			model.addAttribute("notSdvList", queryList);
		}
		
		Map<String,List<EdcVisitDataEvent>> queryEventMap = new HashMap<String, List<EdcVisitDataEvent>>();
		for(EdcQuery query :queryList){
			EdcVisitDataEventExample eventExample = new EdcVisitDataEventExample();
			eventExample.createCriteria().andQueryFlowEqualTo(query.getQueryFlow());
			List<EdcVisitDataEvent> temp = inspectBiz.searchEdcDataVisitEvent(eventExample);
			queryEventMap.put(query.getQueryFlow(), temp);
		}
		model.addAttribute("queryEventMap", queryEventMap);
		
		return "/edc/query/dcfQuery";
	}
	
	@RequestMapping(value = {"/showDcfTemplate" },method={RequestMethod.GET})
	public String showDcfTemplate(String dcfFlow,Model model){
		EdcDcf dcf = inspectBiz.readEdcDcf(dcfFlow);
		model.addAttribute("dcf", dcf);
		String dcfNo = dcf.getDcfNo();
		String projFlow = dcf.getProjFlow();
		PubProj proj = pubProjMapper.selectByPrimaryKey(projFlow);
		String projName = proj.getProjName();
		String orgFlow = dcf.getOrgFlow();
		String orgName = InitConfig.getOrgNameByFlow(orgFlow);
		model.addAttribute("projName", projName);
		model.addAttribute("orgName", orgName);
		
		EdcQueryExample example = new EdcQueryExample();
		example.createCriteria().andDcfFlowEqualTo(dcfFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y); 
		example.setOrderByClause("PATIENT_CODE,SEND_TIME");
		List<EdcQuery> queryList = inspectBiz.searchEdcQuery(example);
		if (dcfNo.indexOf("SDV")>0) {
			model.addAttribute("sdvDcf", dcf);
			model.addAttribute("sdvList", queryList);
		} else {
			model.addAttribute("notSdvDcf", dcf);
			model.addAttribute("notSdvList", queryList);
		}
		
		Map<String,List<EdcVisitDataEvent>> queryEventMap = new HashMap<String, List<EdcVisitDataEvent>>();
		for(EdcQuery query :queryList){
			EdcVisitDataEventExample eventExample = new EdcVisitDataEventExample();
			eventExample.createCriteria().andQueryFlowEqualTo(query.getQueryFlow());
			List<EdcVisitDataEvent> temp = inspectBiz.searchEdcDataVisitEvent(eventExample);
			queryEventMap.put(query.getQueryFlow(), temp);
		}
		model.addAttribute("queryEventMap", queryEventMap);
		
		return "/edc/query/dcfQueryPdfTemplate";
	}
	
	@RequestMapping(value = {"/downDcf" },method={RequestMethod.GET})
	public void downDcf(String dcfFlow,final HttpServletResponse response) throws Exception{
		
		//下载pdf
		EdcDcf dcf = inspectBiz.readEdcDcf(dcfFlow);
		final String fileName = dcf.getDcfNo();
		String outputFileClass = ResourceLoader.getPath("");
		String outputFile = new File(outputFileClass)
		.getParentFile().getParent() + "/load/" + fileName + ".pdf" ;
		
		File file = new File(outputFile);
//		if (!file.exists()) {
			//root 储存的数据
			final Map<String,Object> root=new HashMap<String,Object>();
			root.put("dcf", dcf);
			String dcfNo = dcf.getDcfNo();
			String projFlow = dcf.getProjFlow();
			PubProj proj = pubProjMapper.selectByPrimaryKey(projFlow);
			String projName = proj.getProjName();
			String orgFlow = dcf.getOrgFlow();
			String orgName = InitConfig.getOrgNameByFlow(orgFlow);
			root.put("projName", projName);
			root.put("orgName", orgName);
			
			root.put("dateTrans", new DateTrans());  
			
			EdcQueryExample example = new EdcQueryExample();
			example.createCriteria().andDcfFlowEqualTo(dcfFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y); 
			example.setOrderByClause("PATIENT_CODE,SEND_TIME");
			List<EdcQuery> queryList = inspectBiz.searchEdcQuery(example);
			
			if (dcfNo.indexOf("SDV")>0) {
				root.put("sdvList", queryList);
			} else {
				root.put("notSdvList", queryList);	
			}
			
			Map<String,List<EdcVisitDataEvent>> queryEventMap = new HashMap<String, List<EdcVisitDataEvent>>();
			Map<String,List<EdcQuery>> patientQueryMap = new HashMap<String, List<EdcQuery>>();
			List<String> patientCodeList = new ArrayList<String>();
			if (queryList != null) {
				for (EdcQuery query:queryList) {
					EdcVisitDataEventExample eventExample = new EdcVisitDataEventExample();
					eventExample.createCriteria().andQueryFlowEqualTo(query.getQueryFlow());
					List<EdcVisitDataEvent> temp = inspectBiz.searchEdcDataVisitEvent(eventExample);
					queryEventMap.put(query.getQueryFlow(), temp);
					
					String patientCode = query.getPatientCode();
					if (!patientCodeList.contains(patientCode)) {
						patientCodeList.add(patientCode);
					}
					List<EdcQuery> tempList = patientQueryMap.get(patientCode);
					if (tempList == null) {
						tempList = new ArrayList<EdcQuery>();
					}
					tempList.add(query);
					patientQueryMap.put(patientCode, tempList);
				}
			}
			root.put("queryEventMap", queryEventMap);
			root.put("patientQueryMap", patientQueryMap);
			root.put("patientCodeList", patientCodeList); 
			
			
			try {
				// 模板数据
				DocumentVo vo = new DocumentVo() {
					@Override
					public String findPrimaryKey() {
						return fileName;
					}
					
					@Override
					public Map<String, Object> fillDataMap() {
						return root;
					}
				};
				
				String template = "queryPdfTemplate.ftl";
				PdfDocumentGenerator pdfGenerator = new PdfDocumentGenerator();
				// 生成pdf
				pdfGenerator.generate(template, vo, outputFile);
			} catch (Exception ex) {
				System.err.println(" \n pdf生成失败");
				ex.printStackTrace();
			}
//		}
		
		pubFileBiz.downFile(file,response);
		
	}
	
}

