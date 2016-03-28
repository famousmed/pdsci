package com.pinde.sci.biz.pub.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.gcp.IGcpCfgBiz;
import com.pinde.sci.biz.gcp.IGcpProjBiz;
import com.pinde.sci.biz.gcp.IGcpQcRecordBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.pub.IPubPatientWindowBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.GcpDrugStoreRecMapper;
import com.pinde.sci.dao.base.PubPatientIeMapper;
import com.pinde.sci.dao.base.PubPatientMapper;
import com.pinde.sci.dao.base.PubPatientRecipeDrugMapper;
import com.pinde.sci.dao.base.PubPatientRecipeMapper;
import com.pinde.sci.dao.base.PubPatientVisitMapper;
import com.pinde.sci.dao.edc.PubPatientExtMapper;
import com.pinde.sci.dao.pub.PubPatientVisitExtMapper;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.gcp.GcpQcCategoryEnum;
import com.pinde.sci.enums.gcp.GcpQcTypeEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.model.edc.PatientMinMaxIndateForm;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.GcpCfg;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.GcpDrugStoreRecExample;
import com.pinde.sci.model.mo.GcpQcRemind;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientExample.Criteria;
import com.pinde.sci.model.mo.PubPatientIe;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientWindow;


@Service
@Transactional(rollbackFor=Exception.class)
public class PubPatientBizImpl implements IPubPatientBiz{

	@Resource
	private PubPatientMapper patientMapper;
	@Resource
	private PubPatientExtMapper pubPatientExtMapper;
	@Resource
	private PubPatientVisitMapper pubPatientVisitMapper;
	@Resource
	private PubPatientIeMapper pubPatientIeMapper;
	@Resource
	private GcpDrugStoreRecMapper drugStoreRecMapper;
	@Resource
	private PubPatientRecipeMapper patientRecipeMapper;
	@Resource
	private PubPatientRecipeDrugMapper patientRecipeDrugMapper;
	@Autowired
	private IGcpProjBiz gcpProjBiz;
	@Resource
	private IGcpCfgBiz gcpCfgBiz;
	@Resource
	private IGcpQcRecordBiz gcpQcRecordBiz;
	@Autowired
	private IVisitBiz visitBiz;
	@Resource
	private IPubPatientWindowBiz windowBiz;
	@Resource
	private PubPatientVisitExtMapper patientVisitExtMapper;
	@Autowired
	private IInputBiz inputBiz;
	@Autowired
	private IEdcGroupBiz groupBiz;
	@Resource
	private IEdcRandomBiz randomBiz;
	
	@Override
	public List<PubPatient> searchPatient(PubPatientExample example) {
		return patientMapper.selectByExample(example);
	}

	@Override
	public PubPatient readPatient(String patientFlow) {
		return patientMapper.selectByPrimaryKey(patientFlow);
	}

	@Override
	public List<PubPatient> searchPatientByProjFlow(String projFlow) {
		PubPatientExample example = new PubPatientExample(); 
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId());
		example.setOrderByClause("PATIENT_SEQ");
		return searchPatient(example);
	}
	
	@Override
	public List<PubPatient> searchAllPatients(String projFlow) {
		PubPatientExample example = new PubPatientExample(); 
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("PATIENT_SEQ");
		return searchPatient(example);
	}
	
	@Override
	public List<PubPatient> searchPatientByProjFlow(String projFlow,String patientType) {
		PubPatientExample example = new PubPatientExample(); 
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientTypeIdEqualTo(patientType);
		example.setOrderByClause("PATIENT_SEQ");
		return searchPatient(example);
	}
	
	@Override
	public List<PubPatient> searchIndatePatientByProjFlow(String projFlow) {
		PubPatientExample example = new PubPatientExample(); 
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andInDateIsNotNull();
		return searchPatient(example);
	}
	
	@Override
	public void addPatient(String projFlow, String orgFlow,String patientType,String code,Integer seq,boolean isRandom) {
		PubPatient patient = new  PubPatient();
		patient.setPatientFlow(PkUtil.getUUID());
		patient.setPatientSeq(seq);
		patient.setPatientCode(code);
		patient.setProjFlow(projFlow);
		patient.setOrgFlow(orgFlow);
		patient.setPatientTypeId(patientType);
		patient.setPatientTypeName(PatientTypeEnum.getNameById(patientType));
		patient.setPatientStageId(PatientStageEnum.Filter.getId());
		patient.setPatientStageName(PatientStageEnum.Filter.getName());
		GeneralMethod.setRecordInfo(patient, true);
		patientMapper.insert(patient);
	}

	@Override
	public List<PubPatient> searchPatient(String projFlow, String orgFlow) {
		PubPatientExample example = new PubPatientExample(); 
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).
		andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId());
		example.setOrderByClause("PATIENT_SEQ");
		return searchPatient(example);
	}
	
	@Override
	public List<PubPatient> searchPatientNotFilter(String projFlow, String orgFlow) {
		PubPatientExample example = new PubPatientExample(); 
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andPatientStageIdNotEqualTo(PatientStageEnum.Filter.getId()).
		andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId());
		example.setOrderByClause("PATIENT_SEQ");
		return searchPatient(example);
	}
	
	@Override
	public List<PubPatient> searchPatientList(PubPatient patient) {
		PubPatientExample example = new PubPatientExample(); 
		com.pinde.sci.model.mo.PubPatientExample.Criteria criteria = example.createCriteria().
		andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId());
		if(StringUtil.isNotBlank(patient.getProjFlow())){
			criteria.andProjFlowEqualTo(patient.getProjFlow());
		}
		if(StringUtil.isNotBlank(patient.getOrgFlow())){
			criteria.andOrgFlowEqualTo(patient.getOrgFlow());
		}
		if(StringUtil.isNotBlank(patient.getPatientCode())){
			criteria.andPatientCodeLike("%" + patient.getPatientCode() + "%");
		}
		if(StringUtil.isNotBlank(patient.getPatientNamePy())){
			criteria.andPatientNamePyLike("%" + patient.getPatientNamePy() + "%");
		}
		if(StringUtil.isNotBlank(patient.getPatientStageId())){
			criteria.andPatientStageIdEqualTo(patient.getPatientStageId());
		}
		if(StringUtil.isNotBlank(patient.getInDate())){
			if(GlobalConstant.FLAG_N.equals(patient.getInDate())){
				criteria.andInDateIsNotNull();
			}
		}
		example.setOrderByClause("PATIENT_SEQ");
		return searchPatient(example);
	}
	
	@Override
	public void modifyPatient(PubPatient patient) {
		GeneralMethod.setRecordInfo(patient, false);
		patientMapper.updateByPrimaryKeySelective(patient);
	}

	@Override
	public void disPatient(String projFlow, String orgFlow, String patientType) {
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andPatientTypeIdEqualTo(patientType)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		PubPatient record = new PubPatient();
		record.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		
		patientMapper.updateByExampleSelective(record, example);
	}

	@Override
	public void disPatient(String projFlow, String orgFlow, String patientType, String code) {
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andPatientTypeIdEqualTo(patientType)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientCodeEqualTo(code);
		
		PubPatient record = new PubPatient();
		record.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		
		patientMapper.updateByExampleSelective(record, example);
	}

	@Override
	public PubPatient readPatient(String projFlow, String orgFlow, String patientType, String code) {
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andPatientTypeIdEqualTo(patientType)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientCodeEqualTo(code);
		
		List<PubPatient> result =  patientMapper.selectByExample(example);
		if(result!=null && result.size()>0){
			return result.get(0);
		}
		return null;
	}

	@Override
	public Integer getPatientMaxCount(String projFlow) {
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId())
		.andPatientStageIdNotEqualTo(PatientStageEnum.Filter.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y); 
		int count = patientMapper.countByExample(example);
		return count;
	}

	@Override
	public int count(PubPatientExample example) {
		return patientMapper.countByExample(example);
	}

	@Override
	public void resetPatient(PubPatient patient) {
		GeneralMethod.setRecordInfo(patient, false);
		patientMapper.updateByPrimaryKey(patient);
	}

	@Override
	public List<PubPatient> getUnAssignPatientList(String projFlow,String orgFlow) { 
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId())
		.andPatientStageIdEqualTo(PatientStageEnum.Filter.getId());
		example.setOrderByClause("PATIENT_SEQ");
		return patientMapper.selectByExample(example);
	}

	@Override
	public List<PubPatient> searchAssignPatientByProjFlow(String projFlow,String orgFlow) { 
		PubPatientExample example = new PubPatientExample(); 
		Criteria criteria = example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).
		andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andPatientStageIdNotEqualTo(PatientStageEnum.Filter.getId());
		if(StringUtil.isNotBlank(orgFlow)){
			criteria.andOrgFlowEqualTo(orgFlow);
		}
		example.setOrderByClause("PATIENT_SEQ");
		return searchPatient(example);
	}
	
	@Override
	public Map<String, String> getOrgInDateMap(String projFlow) {
		List<PatientMinMaxIndateForm> indateForm = pubPatientExtMapper.selectInDate(projFlow);
		Map<String,String> inDateMap = new HashMap<String, String>();
		for(PatientMinMaxIndateForm form: indateForm){
			inDateMap.put(form.getOrgFlow()+"_Min", form.getMinInDate());
			inDateMap.put(form.getOrgFlow()+"_Max", form.getMaxInDate());
			inDateMap.put(form.getOrgFlow()+"_Count", form.getInCount());
		}
		return inDateMap;
	}
	
	@Override
	public Map<String, String> searchMaxVisitDateMap(String projFlow,String orgFlow,String patientStage) {
		List<PubPatientVisit> patientList = searchPatientVisit(projFlow,orgFlow,patientStage);
		Map<String,String> visitDateMap = new HashMap<String, String>();
		if (patientList != null && patientList.size() > 0) {
			for(PubPatientVisit visit: patientList){
				visitDateMap.put(visit.getPatientFlow()+"_VisitName", visit.getVisitName());
				visitDateMap.put(visit.getPatientFlow()+"_VisitDate", visit.getVisitDate());
			}
		}
		return visitDateMap;
	}
	
	@Override
	public List<PubPatientVisit> searchPatientVisit(String projFlow,String orgFlow,String patientStage) {
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("projFlow", projFlow);
		paramMap.put("orgFlow", orgFlow);
		paramMap.put("patientStage", patientStage);
		return patientVisitExtMapper.searchPatientVisit(paramMap);
	}

	@Override
	public int count(PubPatient pubPatient) {
		PubPatientExample example = new PubPatientExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(pubPatient!=null){
			String projFlow = pubPatient.getProjFlow();
			if(StringUtil.isNotBlank(projFlow)){
				criteria.andProjFlowEqualTo(projFlow);
			}
			String orgFlow = pubPatient.getOrgFlow();
			if(StringUtil.isNotBlank(orgFlow)){
				criteria.andOrgFlowEqualTo(orgFlow);
			}
			String patientStageId = pubPatient.getPatientStageId();
			if(StringUtil.isNotBlank(patientStageId)){
				criteria.andPatientStageIdEqualTo(patientStageId);
			}
			String patientTypeId = pubPatient.getPatientTypeId();
			if(StringUtil.isNotBlank(patientTypeId)){
				criteria.andPatientTypeIdEqualTo(patientTypeId);
			}
		}
		return this.patientMapper.countByExample(example);
	}

	@Override
	public List<PubPatient> searchPatient(PubPatient patient) {
		PubPatientExample example = new PubPatientExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(patient!=null){
			if(StringUtil.isNotBlank(patient.getOrgFlow())){
				criteria.andOrgFlowEqualTo(patient.getOrgFlow());
			}
			String inDate = patient.getInDate();
			if(StringUtil.isNotBlank(inDate)){
				if(GlobalConstant.FLAG_Y.equals(inDate)){
					criteria.andInDateIsNotNull();
				}else{
					criteria.andInDateEqualTo(inDate);
				}
			}
			if(StringUtil.isNotBlank(patient.getPatientTypeId())){
				criteria.andPatientTypeIdEqualTo(patient.getPatientTypeId());
			}
			if(StringUtil.isNotBlank(patient.getProjFlow())){
				criteria.andProjFlowEqualTo(patient.getProjFlow());
			}
		}
		example.setOrderByClause("in_date desc");
		return this.patientMapper.selectByExample(example);
	}
	
	@Override
	public int savePubPatient(PubPatient patient,String in,String ex){//TODO 新增受试者
		patient.setPatientFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(patient,true);
		patientMapper.insertSelective(patient);
		
		createPatientWindow(patient.getPatientFlow());
		//添加一次访视
		EdcVisit visit = visitBiz.searchBaseline(patient.getProjFlow(),"");
		if(StringUtil.isNotBlank(patient.getInDate()) && visit != null){
			PubPatientVisit patientVisit = new PubPatientVisit();
			patientVisit.setOrgFlow(patient.getOrgFlow());
			patientVisit.setProjFlow(patient.getProjFlow());
			patientVisit.setPatientFlow(patient.getPatientFlow());
			patientVisit.setVisitFlow(visit.getVisitFlow());
			patientVisit.setVisitName(visit.getVisitName());
			patientVisit.setVisitDate(DateUtil.transDate(patient.getInDate()));
			patientVisit.setVisitOperFlow(patient.getInDoctorFlow());
			visitBiz.savePatientVisit(patientVisit);
		}
		
		PubPatientIe patientIe = new PubPatientIe();
		patientIe.setPatientFlow(patient.getPatientFlow());
		patientIe.setProjFlow(patient.getProjFlow());
		GeneralMethod.setRecordInfo(patientIe,true);
		try{
			Document dom = DocumentHelper.parseText("<ieInfo/>");
			Element root = dom.getRootElement();
			Element includeElement = root.addElement("include");
			Element excludeElement = root.addElement("exclude");
			includeElement.addAttribute("value",StringUtil.isNotBlank(in)?in:GlobalConstant.FLAG_N);
			excludeElement.addAttribute("value",StringUtil.isNotBlank(ex)?in:GlobalConstant.FLAG_N);
			patientIe.setIeInfo(dom.asXML());
		}catch(Exception e){
			e.printStackTrace();
		}
		pubPatientIeMapper.insertSelective(patientIe);
		if(patient.getInDate()!=null){
			String projFlow = patient.getProjFlow();
			String orgFlow = patient.getOrgFlow();
			
			PubPatient searchPatient = new PubPatient();
			searchPatient.setProjFlow(projFlow);
			searchPatient.setOrgFlow(orgFlow);
			searchPatient.setInDate(GlobalConstant.FLAG_N);
			List<PubPatient> patientList = searchPatientList(searchPatient);
			if(patientList!=null && patientList.size()>0){
				GcpCfg cfg = gcpCfgBiz.readGcpCfg(GlobalConstant.GCP_QC_REMIND);
				if(cfg != null){
					Map<String,List<String>> qcConfigMap = gcpCfgBiz.createQcConfigMap(cfg.getCfgBigValue());
					if(qcConfigMap != null){
						if(patientList.size()==1){
							List<String> qcTypeList = qcConfigMap.get(GcpQcCategoryEnum.FirstCaseGroup.getId());
							if(qcTypeList != null && qcTypeList.size()>0){
								GcpQcRemind qcRemind = new GcpQcRemind();
								for(String type : qcTypeList){
									qcRemind.setRecordFlow(null);
									qcRemind.setProjFlow(patient.getProjFlow());
									qcRemind.setOrgFlow(patient.getOrgFlow());
									qcRemind.setQcTypeId(type);
									qcRemind.setQcTypeName(GcpQcTypeEnum.getNameById(type));
									qcRemind.setQcCategoryId(GcpQcCategoryEnum.FirstCaseGroup.getId());
									qcRemind.setQcCategoryName(GcpQcCategoryEnum.FirstCaseGroup.getName());
									qcRemind.setRemindStatus(GlobalConstant.FLAG_N);
									qcRemind.setRemindContent("该项目首例病人已于"+DateUtil.getCurrDate()+"入组,请"+GcpQcTypeEnum.getNameById(type).replace("质控","")+"及时进行质控!");
									gcpQcRecordBiz.saveQcRemind(qcRemind);
								}
							}
						}else{
							Map<String,Object> patientCountMap = this.gcpProjBiz.searchPatientCount(patient.getProjFlow(),patient.getOrgFlow());
							if(patientCountMap.get(patient.getProjFlow())!=null && (Integer)patientCountMap.get(patient.getProjFlow())!=0){
								double per = (((Integer)patientCountMap.get(patient.getProjFlow()))*1.0)/patientList.size();
								if(per <= 3.0){
									List<String> qcTypeList = qcConfigMap.get(GcpQcCategoryEnum.OneThirdGroup.getId());
									if(qcTypeList != null && qcTypeList.size()>0){
										GcpQcRemind qcRemind = new GcpQcRemind();
										for(String type : qcTypeList){
											qcRemind.setRecordFlow(null);
											qcRemind.setProjFlow(patient.getProjFlow());
											qcRemind.setQcTypeId(type);
											qcRemind.setQcCategoryId(GcpQcCategoryEnum.OneThirdGroup.getId());
											if(gcpQcRecordBiz.readQcRemind(qcRemind)==null){
												qcRemind.setOrgFlow(patient.getOrgFlow());
												qcRemind.setQcTypeName(GcpQcTypeEnum.getNameById(type));
												qcRemind.setQcCategoryName(GcpQcCategoryEnum.OneThirdGroup.getName());
												qcRemind.setRemindStatus(GlobalConstant.FLAG_N);
												qcRemind.setRemindContent("该项目已于"+DateUtil.getCurrDate()+"入组第"+patientList.size()+"例病人,超过1/3,请"+GcpQcTypeEnum.getNameById(type).replace("质控","")+"及时进行质控!");
												gcpQcRecordBiz.saveQcRemind(qcRemind);
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public int savePatient(PubPatient patient){
		if(patient != null){
			if(StringUtil.isNotBlank(patient.getPatientFlow())){
				GeneralMethod.setRecordInfo(patient,false);
				return patientMapper.updateByPrimaryKeySelective(patient);
			}else{
				patient.setPatientFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(patient,true);
				return patientMapper.insertSelective(patient);
			}
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public List<PubPatient> searchPatientByGroup(String projFlow, String orgFlow,boolean isRandom,String groupName) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("projFlow", projFlow);
		paramMap.put("orgFlow", orgFlow);
		paramMap.put("isRandom", isRandom);
		paramMap.put("groupName", groupName);
		return pubPatientExtMapper.searchPatientByGroup(paramMap);
	}
	
	@Override
	public List<PubPatient> searchAssignPatientByGroup(String projFlow, String orgFlow,String groupName) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("projFlow", projFlow);
		paramMap.put("orgFlow", orgFlow);
		paramMap.put("groupName", groupName);
		return pubPatientExtMapper.searchAssignPatientByGroup(paramMap);
	}

	@Override
	public int countPatient(PubPatient pubPatient) {
		PubPatientExample example = new PubPatientExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(pubPatient!=null){
			String projFlow = pubPatient.getProjFlow();
			if(StringUtil.isNotBlank(projFlow)){
				criteria.andProjFlowEqualTo(projFlow);
			}
			String patientStageId = pubPatient.getPatientStageId();
			if(StringUtil.isNotBlank(patientStageId)){
				criteria.andPatientStageIdEqualTo(patientStageId);
			}
			String patientTypeId = pubPatient.getPatientTypeId();
			if(StringUtil.isNotBlank(patientTypeId)){
				criteria.andPatientTypeIdEqualTo(patientTypeId);
			}
			String orgFlow = pubPatient.getOrgFlow();
			if(StringUtil.isNotBlank(orgFlow)){
				criteria.andOrgFlowEqualTo(orgFlow);
			}
			String inDate = pubPatient.getInDate();
			if(StringUtil.isNotBlank(inDate)){
				if(GlobalConstant.FLAG_Y.equals(inDate)){
					criteria.andInDateIsNotNull();
				}else{
					criteria.andInDateEqualTo(inDate);
				}
			}
		}
		return this.patientMapper.countByExample(example);
	}

	@Override
	public List<GcpDrugStoreRec> searchGcpDrugStoreRecList(GcpDrugStoreRec drugStoreRec) {
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		com.pinde.sci.model.mo.GcpDrugStoreRecExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(drugStoreRec.getProjFlow())){
			criteria.andProjFlowEqualTo(drugStoreRec.getProjFlow());
		}
		return drugStoreRecMapper.selectByExample(example);
	}

	@Override
	public List<PubPatient> searchPatientStageList(List<String> projFlowList) {
		if(projFlowList != null && !projFlowList.isEmpty()){
			PubPatientExample example = new PubPatientExample();
			example.createCriteria().andProjFlowIn(projFlowList).andPatientStageIdEqualTo(PatientStageEnum.In.getId()).andInDateIsNotNull().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			
			List<String> stageIdList = new ArrayList<String>();
			stageIdList.add(PatientStageEnum.Finish.getId());
			stageIdList.add(PatientStageEnum.Off.getId());
			Criteria criteria = example.createCriteria().andProjFlowIn(projFlowList).andPatientStageIdIn(stageIdList).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
 			example.or(criteria);
			return patientMapper.selectByExample(example);
		}
		return null;
	}
	
	@Override
	public int createPatientWindow(String patientFlow){
		PubPatient patient = null;
		if(StringUtil.isNotBlank(patientFlow)){
			patient = readPatient(patientFlow);
		}
		if(patient!=null){
			String inDate = patient.getInDate();
			if (StringUtil.isNotBlank(inDate)) {
				String projFlow = patient.getProjFlow();
				String orgFlow = patient.getOrgFlow();
				String indate = DateUtil.transDate(inDate);
				//保存受试者访视窗
				List<EdcVisit> visitList = null;
				List<EdcGroup> groupList = groupBiz.searchEdcGroup(projFlow);
				if (groupList != null && groupList.size() >0) {
					String drugGroup = randomBiz.searchPatientDrugGroup(patientFlow);
					if (StringUtil.isNotBlank(drugGroup)) {
						EdcGroup group = groupBiz.searchEdcGroup(projFlow,drugGroup);
						if (group != null) {
							visitList = visitBiz.searchVisitsByGroupFlow(projFlow,group.getGroupFlow(),null);
						}
					}
				} else {
					visitList = visitBiz.searchVisitList(projFlow);
				}
				
				if (visitList != null && visitList.size() >0) {
					int days = 0;
					for (int i=0;i<visitList.size();i++) {
						EdcVisit visit = visitList.get(i);
						PubPatientWindow window = new PubPatientWindow();
						window.setProjFlow(projFlow);
						window.setOrgFlow(orgFlow);
						window.setPatientFlow(patient.getPatientFlow());
						window.setPatientCode(patient.getPatientCode());
						window.setPatientName(patient.getPatientName());
						window.setInDate(inDate);
						window.setVisitFlow(visit.getVisitFlow());
						window.setVisitName(visit.getVisitName());
						String visitWindow = visit.getVisitWindow();
						if (StringUtil.isNotBlank(visitWindow)) {
							String leftDate = "";
							String rightDate = "";
							String leftDay = "";
							if (visitWindow.split(",").length >0) {
								leftDay = visitWindow.split(",")[0];
							}
							String wday = "";
							if (visitWindow.split(",").length >1) {
								wday = visitWindow.split(",")[1];
							}
							String rightDay = "";
							if (visitWindow.split(",").length >2) {
								rightDay = visitWindow.split(",")[2];
							}
							if (StringUtil.isNotBlank(wday)) {
								days += Integer.parseInt(wday);//访视日期递增
								if (StringUtil.isNotBlank(leftDay)) {
									leftDate = DateUtil.addDate(indate, days-Integer.parseInt(leftDay));
								} else {
									leftDate = DateUtil.addDate(indate, days);
								}
								if (StringUtil.isNotBlank(rightDay)) {
									rightDate = DateUtil.addDate(indate, days+Integer.parseInt(rightDay));
								} else {
									rightDate = DateUtil.addDate(indate, days);
								}
							}
							window.setWindowLeft(leftDate);
							window.setWindowRight(rightDate);
							windowBiz.savePatientWindow(window);
						}
					}
				}
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int savePubPatient(PubPatient patient){
		modifyPatient(patient);
		if (PatientTypeEnum.Real.getId().equals(patient.getPatientTypeId())) {
			createPatientWindow(patient.getPatientFlow());
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public List<PubPatient> searchPatientList(List<String> patientFlows){
		PubPatientExample example = new PubPatientExample(); 
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientFlowIn(patientFlows);
		example.setOrderByClause("PATIENT_SEQ");
		return searchPatient(example);
	}
	
	@Override
	public PubPatient searchMaxInDatePatient(String projFlow,String orgFlow) {
		PubPatient patient = null;
		PubPatientExample example = new PubPatientExample();
		com.pinde.sci.model.mo.PubPatientExample.Criteria criteria = example.createCriteria()
				.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andProjFlowEqualTo(projFlow).andInDateIsNotNull();
		if (StringUtil.isNotBlank(orgFlow)) {
			criteria.andOrgFlowEqualTo(orgFlow);
		}
		example.setOrderByClause("in_date desc");
		List<PubPatient> list = this.patientMapper.selectByExample(example);
		if (list != null && list.size()>0) {
			patient = list.get(0);
		}
		return patient;
	}
}  
 