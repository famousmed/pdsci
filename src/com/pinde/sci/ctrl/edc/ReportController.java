package com.pinde.sci.ctrl.edc;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.pdf.utils.ResourceLoader;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IEdcProjBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IInspectBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.pub.IPubPatientWindowBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.NumTrans;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.enums.edc.EdcInputStatusEnum;
import com.pinde.sci.enums.edc.InspectTypeEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.form.edc.EdcPatientVisitDataForm;
import com.pinde.sci.form.edc.ElementSerialSeqForm;
import com.pinde.sci.form.edc.ObservationCfgForm;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.PatientVisitForm;
import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcInspect;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientWindow;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;

@Controller
@RequestMapping("/edc/report")
public class ReportController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(ReportController.class);
	
	private static String CM_SHORT_NAME = "CM";
	private static String AE_SHORT_NAME = "AE";
	
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private PubProjMapper pubProjMapper;
	@Autowired
	private IEdcRandomBiz randomBiz; 
	@Autowired
	private IEdcModuleBiz edcModuleBiz; 
	@Autowired
	private IPubPatientBiz patientBiz;
	@Autowired
	private IVisitBiz visitBiz;
	@Autowired
	private IEdcProjBiz projBiz;
	@Autowired
	private IInspectBiz inspectBiz;
	@Autowired
	private IInputBiz inputBiz; 
	@Autowired
	private IEdcGroupBiz groupBiz;
	@Autowired
	private IPubPatientWindowBiz windowBiz;
	@Autowired
	private IFileBiz pubFileBiz;
	
	@RequestMapping(value={"/patientState"},method={RequestMethod.GET})
	public String patientState(Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		//完成
		Map<String,List<PubPatient>> finishCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.Finish.getId()); 
		model.addAttribute("finishCountMap", finishCountMap);
		//脱落
		Map<String,List<PubPatient>> offCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.Off.getId()); 
		model.addAttribute("offCountMap", offCountMap);
		
		Map<String,String> inDateMap = patientBiz.getOrgInDateMap(projFlow);
		model.addAttribute("inDateMap", inDateMap);
 		return "/edc/report/patientState";
	}
	
	@RequestMapping(value = {"/timeWindowDataMain"},method={RequestMethod.GET})
	public String timeWindowDataMain(Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);	
		
		List<EdcGroup> groupList = groupBiz.searchEdcGroup(projFlow);
		model.addAttribute("groupList", groupList);
		
		return "/edc/report/timeWindowDataMain";
	}
	
	@RequestMapping(value={"/timeWindowData"},method={RequestMethod.GET})
	public String timeWindowDate(String orgFlow,String type,String groupFlow,String displayOut,Model model){
		model.addAttribute("groupFlow", groupFlow);	
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(proj != null){
			String projFlow = proj.getProjFlow();
			List<EdcVisit> visitList = null;
			if (StringUtil.isNotBlank(groupFlow)) {
				visitList = visitBiz.searchVisitsByGroupFlow(projFlow,groupFlow,GlobalConstant.FLAG_Y);
			} else {
				visitList = visitBiz.searchVisitList(projFlow,GlobalConstant.FLAG_Y);
			}
			if(visitList!=null && visitList.size()>0){
				model.addAttribute("visitList", visitList);
				
				List<PubPatient> patientList = null;
				if (StringUtil.isNotBlank(groupFlow)) {
					String groupName = "";
					EdcGroup group = groupBiz.read(groupFlow);
					if (group != null) {
						groupName = group.getGroupName();
					}
					patientList = patientBiz.searchAssignPatientByGroup(projFlow, orgFlow, groupName);
				} else if(StringUtil.isNotBlank(orgFlow) || GlobalConstant.FLAG_Y.equals(displayOut)){
					patientList = patientBiz.searchAssignPatientByProjFlow(projFlow,orgFlow);
				}
				if(patientList!=null && patientList.size()>0){
					model.addAttribute("patientList", patientList);
					
					PubPatientWindow window = new PubPatientWindow();
					window.setOrgFlow(orgFlow);
					window.setProjFlow(projFlow);
					List<PubPatientWindow> windowList = windowBiz.searchPatientWindowList(window);
					Map<String,PubPatientWindow> windowMap = null;
					if(windowList!=null && windowList.size()>0){
						windowMap = new HashMap<String, PubPatientWindow>();
						for(PubPatientWindow windowTemp : windowList){
							windowMap.put(windowTemp.getPatientFlow()+windowTemp.getVisitFlow(),windowTemp);
						}
						model.addAttribute("windowMap", windowMap);
						
						if(GlobalConstant.FLAG_Y.equals(displayOut)){
							List<PubPatient> outList = new ArrayList<PubPatient>();
							for(PubPatient patient : patientList){
								for(EdcVisit visit: visitList){
									String key = patient.getPatientFlow()+visit.getVisitFlow();
									if(windowMap.get(key)!=null && StringUtil.isNotBlank(windowMap.get(key).getOutWindowTypeId())){
										outList.add(patient);
										break;
									}
								}
							}
							model.addAttribute("patientList", outList);
							
							List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
							if(pubProjOrgList!=null && pubProjOrgList.size()>0){
								final Map<String,PubProjOrg> pubProjOrgMap = new HashMap<String, PubProjOrg>();
								for(PubProjOrg org : pubProjOrgList){
									pubProjOrgMap.put(org.getOrgFlow(),org);
								}
								Collections.sort(outList,new Comparator<PubPatient>(){
									@Override
									public int compare(PubPatient p1,PubPatient p2) {
										PubProjOrg p1Org = pubProjOrgMap.get(p1.getOrgFlow());
										PubProjOrg p2Org = pubProjOrgMap.get(p2.getOrgFlow());
										if(p1Org==null){
											return -1;
										}else if(p2Org==null){
											return 1;
										}else if(p1Org!=null && p2Org!=null){
											return p1Org.getCenterNo()-p2Org.getCenterNo();
										}
										return 0;
									}
									
								});
							}
						}
					}else if(GlobalConstant.FLAG_Y.equals(displayOut)){
						model.addAttribute("patientList", null);
					}
				}
			}
		}
		
		return "/edc/report/timeWindowData";
	}
	
	@RequestMapping(value={"/queryManage"},method={RequestMethod.GET})
	public String queryManage(Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(edcCurrProj != null){
			String projFlow = edcCurrProj.getProjFlow();
			
			List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("projOrgList", projOrgList);
			
			Map<String,Integer> queryMap = inspectBiz.searchEdcQuery(projFlow);
			model.addAttribute("queryMap",queryMap);
		}
		return "/edc/report/queryManage";
	}
	
	/**
	 * 合并用药报表
	 * */
	@RequestMapping(value={"/cmMain"},method={RequestMethod.GET})
	public String cmMain(Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(edcCurrProj != null){
			String projFlow = edcCurrProj.getProjFlow();
			List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("pubProjOrgList",pubProjOrgList);
		}
		return "/edc/report/cmMain";
	}
	
	@RequestMapping(value={"/cmList"},method={RequestMethod.GET})
	public String cmList(Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(edcCurrProj != null){
			String projFlow = edcCurrProj.getProjFlow();
			List<PubProjOrg> pubProjOrgTempList = GeneralMethod.filterProjOrg(projOrgBiz.searchProjOrg(projFlow));
			
			if(pubProjOrgTempList != null){
				
				
				EdcModule module = edcModuleBiz.readModuleByShortName(CM_SHORT_NAME);
				model.addAttribute("module",module);
				
				if(module != null){
					List<PubPatientVisit> patientVisitList = visitBiz.searchPatientVisitByModule(projFlow, module.getModuleCode(),EdcInputStatusEnum.Checked.getId());
					Map<String,List<ElementSerialSeqForm>> visitDataEventSeqFormMap = new HashMap<String,List<ElementSerialSeqForm>>();
					List<String> patientFlowList = new ArrayList<String>();
					List<String> OrgFlowList = new ArrayList<String>();
					Map<String,List<PubPatientVisit>> patientVisitListMap = new HashMap<String,List<PubPatientVisit>>();
					for(PubPatientVisit patientVisit : patientVisitList){
						String patientFlow = patientVisit.getPatientFlow();
						String visitFlow = patientVisit.getVisitFlow();
						
						if(!patientFlowList.contains(patientFlow)){
							patientFlowList.add(patientFlow);
						}
						if(!OrgFlowList.contains(patientVisit.getOrgFlow())){
							OrgFlowList.add(patientVisit.getOrgFlow());
						}
						
						List<ElementSerialSeqForm> visitDataEventSeqFormList = visitBiz.searchElementSerialSeq(patientFlow, visitFlow);
						if(visitDataEventSeqFormList != null && visitDataEventSeqFormList.size()>0){
							visitDataEventSeqFormMap.put(patientFlow+visitFlow, visitDataEventSeqFormList);
						}
						
						if(patientVisitListMap.get(patientVisit.getOrgFlow())==null){
							List<PubPatientVisit> patientVisitTempList = new ArrayList<PubPatientVisit>();
							patientVisitTempList.add(patientVisit);
							patientVisitListMap.put(patientVisit.getPatientFlow(), patientVisitTempList);
						}else{
							patientVisitListMap.get(patientVisit.getPatientFlow()).add(patientVisit);
						}
					}
					model.addAttribute("patientVisitListMap",patientVisitListMap);
					model.addAttribute("visitDataEventSeqFormMap",visitDataEventSeqFormMap);
					
					List<PubProjOrg> pubProjOrgList = new ArrayList<PubProjOrg>();
					for(PubProjOrg projOrg : pubProjOrgTempList){
						if(OrgFlowList.contains(projOrg.getOrgFlow())){
							pubProjOrgList.add(projOrg);
						}
					}
					model.addAttribute("pubProjOrgList",pubProjOrgList);
					
					List<PubPatient> pubPatientListTemp = patientBiz.searchPatientByProjFlow(projFlow);
					Map<String,List<PubPatient>> patientListMap = new HashMap<String,List<PubPatient>>();
					for(PubPatient pubPatient : pubPatientListTemp){
						String patientFlow = pubPatient.getPatientFlow();
						if(patientFlowList.contains(patientFlow)){
							if(patientListMap.get(pubPatient.getOrgFlow())==null){
								List<PubPatient> patientList = new ArrayList<PubPatient>();
								patientList.add(pubPatient);
								patientListMap.put(pubPatient.getOrgFlow(), patientList);
							}else{
								patientListMap.get(pubPatient.getOrgFlow()).add(pubPatient);
							}
						}
					}
					model.addAttribute("patientListMap",patientListMap);
				}
			}
		}

		return "/edc/report/cmList";
	}
	
	
	/**
	 * 不良事件报表
	 * */
	@RequestMapping(value={"/aeMain"},method={RequestMethod.GET})
	public String aeMain(Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(edcCurrProj != null){
			String projFlow = edcCurrProj.getProjFlow();
			List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("pubProjOrgList",pubProjOrgList);
		}
		
		return "/edc/report/aeMain";
	}
	
	@RequestMapping(value={"/aeList"},method={RequestMethod.GET})
	public String aeList(Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(edcCurrProj != null){
			String projFlow = edcCurrProj.getProjFlow();
			List<PubProjOrg> pubProjOrgTempList = GeneralMethod.filterProjOrg(projOrgBiz.searchProjOrg(projFlow));
			
			if(pubProjOrgTempList != null){
				
				
				EdcModule module = edcModuleBiz.readModuleByShortName(AE_SHORT_NAME);
				model.addAttribute("module",module);
				
				if(module != null){
					List<PubPatientVisit> patientVisitList = visitBiz.searchPatientVisitByModule(projFlow, module.getModuleCode(),EdcInputStatusEnum.Checked.getId());
					Map<String,List<ElementSerialSeqForm>> visitDataEventSeqFormMap = new HashMap<String,List<ElementSerialSeqForm>>();
					List<String> patientFlowList = new ArrayList<String>();
					List<String> OrgFlowList = new ArrayList<String>();
					Map<String,List<PubPatientVisit>> patientVisitListMap = new HashMap<String,List<PubPatientVisit>>();
					for(PubPatientVisit patientVisit : patientVisitList){
						String patientFlow = patientVisit.getPatientFlow();
						String visitFlow = patientVisit.getVisitFlow();
						
						if(!patientFlowList.contains(patientFlow)){
							patientFlowList.add(patientFlow);
						}
						if(!OrgFlowList.contains(patientVisit.getOrgFlow())){
							OrgFlowList.add(patientVisit.getOrgFlow());
						}
						
						List<ElementSerialSeqForm> visitDataEventSeqFormList = visitBiz.searchElementSerialSeq(patientFlow, visitFlow);
						if(visitDataEventSeqFormList != null && visitDataEventSeqFormList.size()>0){
							visitDataEventSeqFormMap.put(patientFlow+visitFlow, visitDataEventSeqFormList);
						}
						
						if(patientVisitListMap.get(patientVisit.getOrgFlow())==null){
							List<PubPatientVisit> patientVisitTempList = new ArrayList<PubPatientVisit>();
							patientVisitTempList.add(patientVisit);
							patientVisitListMap.put(patientVisit.getPatientFlow(), patientVisitTempList);
						}else{
							patientVisitListMap.get(patientVisit.getPatientFlow()).add(patientVisit);
						}
					}
					model.addAttribute("patientVisitListMap",patientVisitListMap);
					model.addAttribute("visitDataEventSeqFormMap",visitDataEventSeqFormMap);
					
					List<PubProjOrg> pubProjOrgList = new ArrayList<PubProjOrg>();
					for(PubProjOrg projOrg : pubProjOrgTempList){
						if(OrgFlowList.contains(projOrg.getOrgFlow())){
							pubProjOrgList.add(projOrg);
						}
					}
					model.addAttribute("pubProjOrgList",pubProjOrgList);
					
					List<PubPatient> pubPatientListTemp = patientBiz.searchPatientByProjFlow(projFlow);
					Map<String,List<PubPatient>> patientListMap = new HashMap<String,List<PubPatient>>();
					for(PubPatient pubPatient : pubPatientListTemp){
						String patientFlow = pubPatient.getPatientFlow();
						if(patientFlowList.contains(patientFlow)){
							if(patientListMap.get(pubPatient.getOrgFlow())==null){
								List<PubPatient> patientList = new ArrayList<PubPatient>();
								patientList.add(pubPatient);
								patientListMap.put(pubPatient.getOrgFlow(), patientList);
							}else{
								patientListMap.get(pubPatient.getOrgFlow()).add(pubPatient);
							}
						}
					}
					model.addAttribute("patientListMap",patientListMap);
				}
			}
		}

		return "/edc/report/aeList";
	}
	
	/**
	 * 一条记录的详情
	 * */
	@RequestMapping(value={"/reportInfoMain"},method={RequestMethod.GET})
	public String reportInfoMain(String moduleCode,String visitFlow,String recordFlow,String seq,Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(edcCurrProj != null){
			String projFlow = edcCurrProj.getProjFlow();
			if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
				logger.info("==============init proj desc ========");
				EdcDesignForm designForm = edcModuleBiz.getDescForm(projFlow);
				setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
			}
		}
		
		PatientVisitForm patientVisit = inputBiz.selectPatientVisit(recordFlow);
		model.addAttribute("patientVisitForm", patientVisit);

		EdcVisit visit = visitBiz.readVisit(visitFlow);
		model.addAttribute("visit", visit);
		
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
		
		model.addAttribute("moduleCode",moduleCode);
		model.addAttribute("visitFlow",visitFlow);
		model.addAttribute("seq",seq);
		return "/edc/report/reportInfoMain";
	}
	
	@RequestMapping(value={"/offPatientList"},method={RequestMethod.GET})
	public String offPatientList(Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		//脱落
		Map<String,List<PubPatient>> offCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.Off.getId()); 
		model.addAttribute("offCountMap", offCountMap);
		//访视
		Map<String,String> visitDateMap = patientBiz.searchMaxVisitDateMap(projFlow,null,PatientStageEnum.Off.getId());
		model.addAttribute("visitDateMap", visitDateMap);
 		return "/edc/report/offPatientList";
	}
	
	/**
	 * TODO  实验室异常值列表
	 * */
	@RequestMapping(value={"/abnormalList"},method={RequestMethod.GET})
	public String abnormalList(String orgFlow,String patientCode,Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(proj != null){
			String projFlow = proj.getProjFlow();
			List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("pubProjOrgList",pubProjOrgList);
			
			Map<String,String> conditionMap = new HashMap<String, String>();
			conditionMap.put("projFlow",proj.getProjFlow());
			conditionMap.put("attrValueTip","%"+GlobalConstant.INPUT_TIP_LB+"%");
			if(StringUtil.isNotBlank(patientCode)){
				conditionMap.put("patientCode",patientCode);
			}
			if(StringUtil.isNotBlank(orgFlow)){
				conditionMap.put("orgFlow",orgFlow);
			}
			List<EdcPatientVisitDataForm> patientVisitDataFormList = inputBiz.searchVisitDataFormList(conditionMap);
			if(patientVisitDataFormList!=null && patientVisitDataFormList.size()>0){
				Map<String,List<EdcPatientVisitDataForm>> patientVisitDataFormMap = new HashMap<String, List<EdcPatientVisitDataForm>>();
				for(EdcPatientVisitDataForm dataForm : patientVisitDataFormList){
					if(patientVisitDataFormMap.get(dataForm.getOrgFlow())==null){
						List<EdcPatientVisitDataForm> patientVisitDataFormTempList = new ArrayList<EdcPatientVisitDataForm>();
						patientVisitDataFormTempList.add(dataForm);
						patientVisitDataFormMap.put(dataForm.getOrgFlow(), patientVisitDataFormTempList);
					}else{
						patientVisitDataFormMap.get(dataForm.getOrgFlow()).add(dataForm);
					}
				}
				model.addAttribute("patientVisitDataFormMap",patientVisitDataFormMap);
			}
		}
 		return "/edc/report/abnormalList";
	}
	
	/**
	 * TODO  观测指标一览
	 * */
	@RequestMapping(value={"/observationList"},method={RequestMethod.GET})
	public String observationList(String attrCode,Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(proj != null){
			String projFlow = proj.getProjFlow();
			
			EdcInspect inspect = edcModuleBiz.readInspect(projFlow,InspectTypeEnum.Observation.getId());
			if(inspect!=null){
				List<ObservationCfgForm> observationCfgFormList = edcModuleBiz.parseInspectInfo(inspect.getInspectInfo());
				if(observationCfgFormList!=null && observationCfgFormList.size()>0){
					model.addAttribute("observationCfgFormList",observationCfgFormList);
					
					ObservationCfgForm observationCfgForm = null;
					for(ObservationCfgForm form : observationCfgFormList){
						if(form.getAttrCode().equals(attrCode)){
							observationCfgForm = form;
							break;
						}
					}
					model.addAttribute("observationCfgForm",observationCfgForm);
					
					if(observationCfgForm!=null){
						model.addAttribute("isCode",GlobalConstant.FLAG_Y.equals(observationCfgForm.getIsCode()));
						List<EdcPatientVisitData> visitDataList= visitBiz.searchPatientVisitDataByAttrCode(projFlow,attrCode);
						
						if(GlobalConstant.FLAG_Y.equals(observationCfgForm.getIsCode())){
							List<String> attrCodes = new ArrayList<String>();
							attrCodes.add(attrCode);
							List<EdcAttrCode> codeList = edcModuleBiz.searchByAttrCode(projFlow,attrCodes);
							if(codeList!=null && codeList.size()>0){
								model.addAttribute("codeList",codeList);
								
								Map<String,String> codeMap = new HashMap<String, String>();
								for(EdcAttrCode code : codeList){
									codeMap.put(code.getCodeValue(),code.getCodeName());
								}
								model.addAttribute("codeMap",codeMap);
							}
						}else{
							EdcAttribute attr = edcModuleBiz.readAttribute(projFlow,attrCode);
							if(attr!=null){
								List<EdcPatientVisitData> visitDataMaxMinList= visitBiz.searchVisitDataDistinct(projFlow,attrCode,attr.getDataTypeId());
								model.addAttribute("visitDataMaxMinList",visitDataMaxMinList);
							}
						}
						
						if(visitDataList!=null && visitDataList.size()>0){
							model.addAttribute("visitDataList",visitDataList);
							
							Map<String,Integer> attrCountMap = new HashMap<String, Integer>();
							Map<String,List<EdcPatientVisitData>> patientVisitDataMap = new HashMap<String, List<EdcPatientVisitData>>();
							List<String> patientFlows = new ArrayList<String>();
							for(EdcPatientVisitData data : visitDataList){
								String key = data.getAttrValue();
								if(attrCountMap.get(key)==null){
									attrCountMap.put(key,1);
								}else{
									attrCountMap.put(key,attrCountMap.get(key)+1);
								}
								if(patientVisitDataMap.get(data.getPatientFlow())==null){
									List<EdcPatientVisitData> visitDataTempList = new ArrayList<EdcPatientVisitData>();
									visitDataTempList.add(data);
									patientVisitDataMap.put(data.getPatientFlow(),visitDataTempList);
								}else{
									patientVisitDataMap.get(data.getPatientFlow()).add(data);
								}
								if(!patientFlows.contains(data.getPatientFlow())){
									patientFlows.add(data.getPatientFlow());
								}
							}
							model.addAttribute("attrCountMap",attrCountMap);
							model.addAttribute("patientVisitDataMap",patientVisitDataMap);
							
							List<PubPatient> patientList = patientBiz.searchPatientList(patientFlows);
							if(patientList!=null && patientList.size()>0){
								List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
								model.addAttribute("pubProjOrgList",pubProjOrgList);
								
								List<EdcVisit> visitList = visitBiz.searchVisitList(projFlow);
								if(visitList!=null && visitList.size()>0){
									Map<String,EdcVisit> visitMap = new HashMap<String, EdcVisit>();
									for(EdcVisit visit : visitList){
										visitMap.put(visit.getVisitFlow(),visit);
									}
									model.addAttribute("visitMap",visitMap);
								}
								
								Map<String,List<PubPatient>> patientMap = new HashMap<String, List<PubPatient>>();
								for(PubPatient patient : patientList){
									if(patientMap.get(patient.getOrgFlow())==null){
										List<PubPatient> patientTempList = new ArrayList<PubPatient>();
										patientTempList.add(patient);
										patientMap.put(patient.getOrgFlow(),patientTempList);
									}else{
										patientMap.get(patient.getOrgFlow()).add(patient);
									}
								}
								model.addAttribute("patientMap",patientMap);
							}
						}
					}
				}
			}
		}
 		return "/edc/report/observationList";
	}
	
	/**
	 * TODO  病例情况一览表EXCEL导出
	 * @throws Exception 
	 * */
	@RequestMapping(value={"/exportPatientState"},method={RequestMethod.GET})
	public void exportPatientState(HttpServletResponse response) throws Exception{
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		//完成
		Map<String,List<PubPatient>> finishCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.Finish.getId()); 
		//脱落
		Map<String,List<PubPatient>> offCountMap =  randomBiz.getOrgCount(projFlow,PatientStageEnum.Off.getId()); 
		
		Map<String,String> inDateMap = patientBiz.getOrgInDateMap(projFlow);
		
		HSSFWorkbook workbook = new HSSFWorkbook();
		
		HSSFSheet sheet = workbook.createSheet("病例情况一览表");
		sheet.setColumnWidth(0,3500);
		sheet.setColumnWidth(1,6500);
		sheet.setColumnWidth(2,5000);
		sheet.setColumnWidth(3,5000);
		sheet.setColumnWidth(4,5000);
		sheet.setColumnWidth(5,4000);
		sheet.setColumnWidth(6,4000);
		sheet.setColumnWidth(7,6000);
		sheet.setColumnWidth(8,6000);
		
		HSSFCellStyle style = workbook.createCellStyle();
		
		style.setFillForegroundColor(HSSFColor.WHITE.index);
	    style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    style.setBorderRight(HSSFCellStyle.BORDER_THIN);
	    style.setBorderTop(HSSFCellStyle.BORDER_THIN);		
	    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    
	    HSSFFont font = workbook.createFont();
	    font.setFontHeightInPoints((short) 12);
	    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    
	    style.setFont(font);
	    
	    HSSFCellStyle style2 = workbook.createCellStyle();
	    style2.setFillForegroundColor(HSSFColor.WHITE.index);
	    style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	    style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
	    style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
	    style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    
	    HSSFFont font2 = workbook.createFont();
	    font2.setFontHeightInPoints((short) 10);
	    font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
	    
	    style2.setFont(font2);
	    
	    String[] headers = {"中心号","机构名称","第一例入组","最后一例入组","试验间隔跨度","计划入组","实际入组","完成病例（％）","脱落病例（％）"};
	    
	    HSSFRow row = sheet.createRow(0);
	    row.setHeightInPoints(20);
	    for (int i = 0; i < headers.length; i++) {
	       HSSFCell cell = row.createCell(i);
	       cell.setCellStyle(style);
	       HSSFRichTextString text = new HSSFRichTextString(headers[i]);
	       cell.setCellValue(text);
	    }
	    
	    String minInDate = "";
	    String maxInDate = "";
	    int patientCount = 0;
	    int inCount = 0;
	    int finishCount = 0;
	    int offCount = 0;
	    int rownum = 1;
	    for(PubProjOrg org : GeneralMethod.filterProjOrg(pubProjOrgList)){
	    	HSSFRow listRow = sheet.createRow(rownum++);
	    	listRow.setHeightInPoints(15);
	    	
	    	HSSFCell centerNo = listRow.createCell(0);
	    	centerNo.setCellStyle(style2);
	    	centerNo.setCellValue(org.getCenterNo());
	    	
	    	HSSFCell orgName = listRow.createCell(1);
	    	orgName.setCellStyle(style2);
	    	orgName.setCellValue(org.getOrgName());
	    	
	    	String firstDateStr = DateUtil.transDate(inDateMap.get(org.getOrgFlow()+"_Min"));
	    	HSSFCell firstInDate = listRow.createCell(2);
	    	firstInDate.setCellStyle(style2);
	    	firstInDate.setCellValue(firstDateStr);
	    	
	    	String lastInDateStr =  DateUtil.transDate(inDateMap.get(org.getOrgFlow()+"_Max"));
	    	HSSFCell lastInDate = listRow.createCell(3);
	    	lastInDate.setCellStyle(style2);
	    	lastInDate.setCellValue(lastInDateStr);
	    	
	    	String dateSpanStr = "";
	    	if(StringUtil.isNotBlank(firstDateStr) && StringUtil.isNotBlank(lastInDateStr)){
	    		dateSpanStr = DateUtil.signDaysBetweenTowDate(lastInDateStr,firstDateStr)+"";
	    	}
	    	HSSFCell dateSpan = listRow.createCell(4);
	    	dateSpan.setCellStyle(style2);
	    	dateSpan.setCellValue(dateSpanStr);
	    	
	    	int patientCountInt = 0;
	    	if(StringUtil.isNotBlank(org.getPatientCount())){
	    		patientCountInt = Integer.parseInt(org.getPatientCount());
	    	}
	    	HSSFCell orgPatientCount = listRow.createCell(5);
	    	orgPatientCount.setCellStyle(style2);
	    	orgPatientCount.setCellValue(patientCountInt);
	    	
	    	int inDateCountInt = 0;
	    	if(StringUtil.isNotBlank(inDateMap.get(org.getOrgFlow()+"_Count"))){
	    		inDateCountInt = Integer.parseInt(inDateMap.get(org.getOrgFlow()+"_Count"));
	    	}
	    	HSSFCell inDateCount = listRow.createCell(6);
	    	inDateCount.setCellStyle(style2);
	    	inDateCount.setCellValue(inDateCountInt);
	    	
	    	int finishCountInt = 0;
	    	String finishCountStr = "";
	    	if(finishCountMap.get(org.getOrgFlow())!=null){
	    		finishCountInt = finishCountMap.get(org.getOrgFlow()).size();
	    	}
	    	finishCountStr += ("（"+NumTrans.transPercent(finishCountInt+"",inDateCountInt+"",2)+"）");
	    	HSSFCell orgFinishCount = listRow.createCell(7);
	    	orgFinishCount.setCellStyle(style2);
	    	orgFinishCount.setCellValue(finishCountInt+finishCountStr);
	    	
	    	int offCountInt = 0;
	    	String offCountStr = "";
	    	if(offCountMap.get(org.getOrgFlow())!=null){
	    		offCountInt = offCountMap.get(org.getOrgFlow()).size();
	    	}
	    	offCountStr += ("（"+NumTrans.transPercent(offCountInt+"",inDateCountInt+"",2)+"）");
	    	HSSFCell orgOffCount = listRow.createCell(8);
	    	orgOffCount.setCellStyle(style2);
	    	orgOffCount.setCellValue(offCountInt+offCountStr);
	    	
	    	if(StringUtil.isNotBlank(firstDateStr)){
	    		if(!(StringUtil.isNotBlank(minInDate) && firstDateStr.compareTo(minInDate)>0)){
	    			minInDate = firstDateStr;
	    		}
	    	}
	    	
	    	if(StringUtil.isNotBlank(lastInDateStr)){
	    		if(!(StringUtil.isNotBlank(maxInDate) && lastInDateStr.compareTo(maxInDate)<0)){
	    			maxInDate = lastInDateStr;
	    		}
	    	}
	    	
	    	inCount+=inDateCountInt;
	    	
	    	patientCount+=patientCountInt;
	    	
	    	finishCount+=finishCountInt;
	    	
	    	offCount+=offCountInt;
	    }
	    
	    HSSFRow listRow = sheet.createRow(rownum++);
	    listRow.setHeightInPoints(15);
	    
	    HSSFCell centerNo = listRow.createCell(0);
    	centerNo.setCellStyle(style2);
    	centerNo.setCellValue("汇总");
    	
    	HSSFCell orgName = listRow.createCell(1);
    	orgName.setCellStyle(style2);
    	
    	HSSFCell firstInDate = listRow.createCell(2);
    	firstInDate.setCellStyle(style2);
    	firstInDate.setCellValue(minInDate);
    	
    	HSSFCell lastInDate = listRow.createCell(3);
    	lastInDate.setCellStyle(style2);
    	lastInDate.setCellValue(maxInDate);
    	
    	String dateSpanStr = "";
    	if(StringUtil.isNotBlank(minInDate) && StringUtil.isNotBlank(maxInDate)){
    		dateSpanStr = DateUtil.signDaysBetweenTowDate(maxInDate,minInDate)+"";
    	}
    	HSSFCell dateSpan = listRow.createCell(4);
    	dateSpan.setCellStyle(style2);
    	dateSpan.setCellValue(dateSpanStr);
    	
    	HSSFCell orgPatientCount = listRow.createCell(5);
    	orgPatientCount.setCellStyle(style2);
    	orgPatientCount.setCellValue(patientCount);
    	
    	HSSFCell inDateCount = listRow.createCell(6);
    	inDateCount.setCellStyle(style2);
    	inDateCount.setCellValue(inCount);
    	
    	String finishCountStr = ("（"+NumTrans.transPercent(finishCount+"",inCount+"",2)+"）");
    	HSSFCell orgFinishCount = listRow.createCell(7);
    	orgFinishCount.setCellStyle(style2);
    	orgFinishCount.setCellValue(finishCount+finishCountStr);
    	
    	String offCountStr = ("（"+NumTrans.transPercent(offCount+"",inCount+"",2)+"）");
    	HSSFCell orgOffCount = listRow.createCell(8);
    	orgOffCount.setCellStyle(style2);
    	orgOffCount.setCellValue(offCount+offCountStr);
	    
	    String outputFileClass = ResourceLoader.getPath("");
		String outputFile = new File(outputFileClass).getParentFile().getParent() + "/load/病例情况一览表.xls" ;
		File file = new File(outputFile);
	    
	    workbook.write(new FileOutputStream(file));
	    pubFileBiz.downFile(file,response);
		
	}
}

