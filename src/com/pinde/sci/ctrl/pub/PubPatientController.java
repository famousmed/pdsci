package com.pinde.sci.ctrl.pub;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientVisitExample;
import com.pinde.sci.model.mo.PubPatientVisitExample.Criteria;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;

@Controller
@RequestMapping("/pub/patient")
public class PubPatientController extends GeneralController {	
	private static Logger logger=LoggerFactory.getLogger(PubPatientController.class);
	
	@Autowired
	private IPubPatientBiz patientBiz;
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IInputBiz inputBiz; 
	@Autowired
	private IEdcRandomBiz randomBiz;
	
	
	@RequestMapping(value = "/list",method={RequestMethod.GET})
	public String list(Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(edcCurrProj.getProjFlow());
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		
		List<PubPatient> patientList = patientBiz.searchAllPatients(edcCurrProj.getProjFlow());
		Map<String,String> patientMap = new HashMap<String, String>();
		for(PubPatient patient : patientList){
			String temp = patientMap.get(patient.getOrgFlow()+"_"+patient.getPatientTypeId());
			if(temp == null){
				 temp = patient.getPatientCode();
			}else {
				temp+=","+patient.getPatientCode();
			}
			patientMap.put(patient.getOrgFlow()+"_"+patient.getPatientTypeId(), temp);
		}
		model.addAttribute("patientMap", patientMap);
		return "edc/patient/list";
	}
	@RequestMapping(value = "/initProjPatient",method={RequestMethod.GET})
	public String initProjPatient(String patientType,Model model){
		model.addAttribute("patientType", patientType);
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(edcCurrProj.getProjFlow());
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		
		List<PubPatient> patientList = patientBiz.searchPatientByProjFlow(edcCurrProj.getProjFlow(),patientType);
		Map<String,String> patientMap = new HashMap<String, String>();
		for(PubPatient patient : patientList){
			String temp = patientMap.get(patient.getOrgFlow());
			if(temp == null){
				 temp = patient.getPatientCode();
			}else {
				temp+=","+patient.getPatientCode();
			}
			patientMap.put(patient.getOrgFlow(), temp);
		}
		model.addAttribute("patientMap", patientMap);
		return "edc/patient/init";
	}
	@RequestMapping(value = "/initProjPatient",method={RequestMethod.POST})
	@ResponseBody
	public String initProjPatient(String patientType,HttpServletRequest req){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = edcCurrProj.getProjFlow();
		
		EdcProjParam param = inputBiz.readProjParam(projFlow);
		if (param == null || StringUtil.isBlank(param.getIsRandom())) {
			return "操作失败，请先维护项目参数！";
		}
		boolean isRandom = GeneralMethod.isRandom(param);
		
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		
		List<PubPatient> patientList = patientBiz.searchPatientByProjFlow(projFlow,patientType);	//按'PATIENT_SEQ'排序
		Map<String,List<String>> existPatientCodeMap = new HashMap<String, List<String>>();
		Map<String,PubPatient> patientCodeMap = new HashMap<String, PubPatient>();
		Map<String,List<String>> orgPatientMap = new HashMap<String, List<String>>();
		for (PubPatient patient: patientList) {
			List<String> codes = existPatientCodeMap.get(patient.getOrgFlow());
			if(codes == null){
				codes = new ArrayList<String>();
			}
			codes.add(patient.getPatientCode());
			existPatientCodeMap.put(patient.getOrgFlow(), codes);
			patientCodeMap.put(patient.getOrgFlow()+"_"+patient.getPatientCode(), patient);
			
			List<String> patientFlows = orgPatientMap.get(patient.getOrgFlow());
			if(patientFlows == null){
				patientFlows = new ArrayList<String>();
			}
			patientFlows.add(patient.getPatientFlow());
			orgPatientMap.put(patient.getOrgFlow(), patientFlows);
		}
		
		for(PubProjOrg org : pubProjOrgList){
			String orgFlow =  org.getOrgFlow();
			String patientCode = req.getParameter(orgFlow+"_patientCode");
			if(StringUtil.isNotBlank(patientCode)){
				List<String> patientCodes = _getCodes(patientCode); //页面限制格式 后台不做校验了
				List<String> existCodes = existPatientCodeMap.get(orgFlow);
				
				int seq  = 1 ;
				//重新分配 已存在和已有访视 的受试者的序号
				if (existCodes != null) {
					for(String code : existCodes){
						PubPatient patient = patientCodeMap.get(orgFlow + "_" +code);
						if(patientCodes.contains(code)){	//已存在的受试者
							patient.setPatientSeq(seq);
							patientBiz.modifyPatient(patient); 
							seq++;
						} else {
							PubPatientVisitExample example = new PubPatientVisitExample();
							example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow)
							.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientFlowEqualTo(patient.getPatientFlow());
							List<PubPatientVisit> patientVisitList = inputBiz.searchPatientVisit(example);
							if(patientVisitList != null && patientVisitList.size() > 0){	//已有访视的受试者
								patient.setPatientSeq(seq);
								patientBiz.modifyPatient(patient); 
								seq++;
							}
						}
					}
				}
				//分配新的受试者
				for(String code : patientCodes){
					if(existCodes==null || !existCodes.contains(code)){ 
						patientBiz.addPatient(projFlow,orgFlow,patientType,code,seq,isRandom); 
						seq++;
					}
				}
				
				if(existCodes!=null && existCodes.size()>0){
					for(String code :existCodes){
						if(!patientCodes.contains(code)){
							PubPatient patient = patientBiz.readPatient(projFlow,org.getOrgFlow(),patientType,code);
							if(patient !=null){
								PubPatientVisitExample example = new PubPatientVisitExample();
								example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow)
								.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientFlowEqualTo(patient.getPatientFlow());
								List<PubPatientVisit> patientVisitList = inputBiz.searchPatientVisit(example);
								if(patientVisitList==null || patientVisitList.size()==0){
									patientBiz.disPatient(projFlow,org.getOrgFlow(),patientType,code);
								}else {
									return GlobalConstant.OPRE_FAIL +patient.getPatientCode()+" 号受试者已存在访视，无法重新分配!"; 
								}
							}
						}
					}
				}
			} else {
				List<String> patientFlows = orgPatientMap.get(orgFlow);
				if (patientFlows != null && patientFlows.size() >0) {
					PubPatientVisitExample example = new PubPatientVisitExample();
					Criteria criteria = example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow)
					.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
					criteria.andPatientFlowIn(patientFlows);
					List<PubPatientVisit> patientVisitList = inputBiz.searchPatientVisit(projFlow, orgFlow);
					if(patientVisitList!=null && patientVisitList.size()>0){
						//已存在样本访视，不能删除
						PubPatient patient = patientBiz.readPatient(patientVisitList.get(0).getPatientFlow());
						return GlobalConstant.OPRE_FAIL +patient.getPatientCode()+" 号受试者已存在访视，无法重新分配!";
					} else {
						patientBiz.disPatient(projFlow,orgFlow,patientType);
					}
				} else {
					patientBiz.disPatient(projFlow,orgFlow,patientType);
				}
			}
			if (PatientTypeEnum.Real.getId().equals(patientType)) {
				org.setPatientCount(req.getParameter(orgFlow+"_patientCount"));
				projOrgBiz.mod(org);
			}
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	
	private List<String> _getCodes(String patientCode) {
		List<String> result = new ArrayList<String>();
		String[] codes = StringUtil.split(patientCode, ",");
		for(String str: codes){
			if(str.indexOf("-")>-1){
				String[] startEndCode = StringUtil.split(str, "-");
				String startCode = startEndCode[0];
				String endCode = startEndCode[1];
				for(int i=Integer.parseInt(startCode) ;i<=Integer.parseInt(endCode);i++){
					result.add(i+"");
				}
			}else {
				result.add(str);
			}
		}
		return result;
	}
	
	@RequestMapping(value = "/adjust",method={RequestMethod.GET})
	public String adjust(String orgFlow,Model model){
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(edcCurrProj.getProjFlow());
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		
		List<PubPatient> patientList = patientBiz.searchPatient(edcCurrProj.getProjFlow(),orgFlow);
		model.addAttribute("patientList", patientList);
		return "edc/patient/adjust";
	}
	@RequestMapping(value = "/saveAdjust",method={RequestMethod.GET})
	public String saveAdjust(String patientFlow,String orgFlow,String centerNo,Model model){
		PubPatient patient = patientBiz.readPatient(patientFlow);
		patient.setOrgFlow(orgFlow);
		patientBiz.modifyPatient(patient);
		return "edc/patient/adjust";
	}
	

	@RequestMapping(value = {"/manage/{actionScope}" },method={RequestMethod.GET})
	public String manage(@PathVariable String actionScope,String orgFlow,Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		if(GlobalConstant.DEPT_LIST_LOCAL.equals(actionScope)){
			orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		}else if(GlobalConstant.DEPT_LIST_GLOBAL.equals(actionScope)){
			List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("pubProjOrgList", pubProjOrgList);
		}
		model.addAttribute("orgFlow", orgFlow);	
		model.addAttribute("actionScope", actionScope);
		
		return "edc/patient/manage/patientListMain";
	}
	
	@RequestMapping(value = {"/patientList" },method={RequestMethod.GET})
	public String patientList(String orgFlow,Model model) {
		model.addAttribute("orgFlow", orgFlow);
		if(StringUtil.isNotBlank(orgFlow)){
			PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			String projFlow = proj.getProjFlow();
			
			List<PubPatient> patientList = patientBiz.searchPatient(projFlow,orgFlow);
			model.addAttribute("patientList", patientList);
			
			EdcProjParam projParam = randomBiz.readProjParam(projFlow);
			model.addAttribute("isBlind", GeneralMethod.isBlind(projParam));
			model.addAttribute("isRandom", GeneralMethod.isRandom(projParam));
			
			Map<String,EdcRandomRec> randomMap = randomBiz.getPatientRandomMap(projFlow,orgFlow);
			model.addAttribute("randomMap", randomMap);
			
			Map<String,String> visitDateMap = patientBiz.searchMaxVisitDateMap(projFlow, orgFlow, null);
			model.addAttribute("visitDateMap", visitDateMap);
		}
		
		return "edc/patient/manage/patientList";
	}
	
	@RequestMapping(value = {"/changePatientStage" },method={RequestMethod.POST})
	@ResponseBody
	public String changePatientStage(String patientFlow,String patientStageId,String patientStageNote) {
		PubPatient patient = patientBiz.readPatient(patientFlow);
		if (patient != null) {
			patient.setPatientStageId(patientStageId);
			patient.setPatientStageName(PatientStageEnum.getNameById(patientStageId));
			patient.setPatientStageNote(StringUtil.defaultString(patientStageNote));	//备注：如脱落原因
			patientBiz.modifyPatient(patient);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/patientStageNote" },method={RequestMethod.GET})
	public String patientStageNote(String patientFlow,Model model) {
		PubPatient patient = patientBiz.readPatient(patientFlow);
		model.addAttribute("patient", patient);
		return "edc/patient/manage/patientStageNote";
	}
	
}
