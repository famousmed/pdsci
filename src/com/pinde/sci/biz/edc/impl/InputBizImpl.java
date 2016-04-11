package com.pinde.sci.biz.edc.impl;



import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.EdcPatientVisitDataMapper;
import com.pinde.sci.dao.base.EdcPatientVisitMapper;
import com.pinde.sci.dao.base.EdcProjParamMapper;
import com.pinde.sci.dao.base.PubPatientVisitMapper;
import com.pinde.sci.dao.edc.EdcPatientVisitDataExtMapper;
import com.pinde.sci.dao.edc.EdcPatientVisitExtMapper;
import com.pinde.sci.enums.edc.EdcInputStatusEnum;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.form.edc.EdcPatientVisitDataForm;
import com.pinde.sci.model.edc.PatientVisitForm;
import com.pinde.sci.model.mo.EdcPatientVisit;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcPatientVisitDataExample;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientVisitExample;
import com.pinde.sci.model.mo.PubPatientVisitExample.Criteria;
import com.pinde.sci.model.mo.PubProjOrg;


@Service
@Transactional(rollbackFor=Exception.class)
public class InputBizImpl implements IInputBiz{
	@Resource
	private EdcProjParamMapper projParamMapper;
	@Resource
	private PubPatientVisitMapper patientVisitMapper;
	@Resource
	private EdcPatientVisitMapper edcPatientVisitMapper;
	@Resource
	private EdcPatientVisitExtMapper edcPatientVisitExtMapper;
	@Resource
	private IPubPatientBiz patientBiz;
	@Resource
	private IVisitBiz visitBiz;
	@Resource
	private EdcPatientVisitDataMapper visitDataMapper;
	@Resource
	private EdcPatientVisitDataExtMapper edcVisitDataExtMapper;
	@Autowired
	private IProjOrgBiz projOrgBiz;
	
	@Override
	public EdcProjParam readProjParam(String projFlow) {
		return projParamMapper.selectByPrimaryKey(projFlow);
	}

	@Override
	public Map<String,Map<String,PatientVisitForm>>  searchPatientVisitMap(String projFlow, String orgFlow) {
		PubPatientVisitExample example = new PubPatientVisitExample();
		example.createCriteria().andProjFlowEqualTo(projFlow)
				.andOrgFlowEqualTo(orgFlow)
				.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubPatientVisit> patientVisit =  patientVisitMapper.selectByExample(example); 
		
		List<EdcPatientVisit> edcPatientVisitList = edcPatientVisitExtMapper.searchEdcPatientVisitList(projFlow,orgFlow);
		Map<String,EdcPatientVisit> edcPatientVisitMap = new HashMap<String, EdcPatientVisit>();
		for(EdcPatientVisit edcPatientVisit : edcPatientVisitList){
			edcPatientVisitMap.put(edcPatientVisit.getRecordFlow(), edcPatientVisit);
		}
		Map<String,Map<String,PatientVisitForm>> result = new HashMap <String, Map<String,PatientVisitForm>>();
		for(PubPatientVisit visit : patientVisit){
			PatientVisitForm form = new PatientVisitForm();
			form.setPatientVisit(visit);
			form.setEdcPatientVisit(edcPatientVisitMap.get(visit.getRecordFlow()));
			
			
			Map<String,PatientVisitForm> visitMap = result.get(visit.getPatientFlow());
			if(visitMap == null){
				visitMap = new HashMap<String, PatientVisitForm>();
			}
			visitMap.put(visit.getVisitFlow(), form);
			result.put(visit.getPatientFlow(), visitMap);
		}
		return result;
	}

	@Override
	public PubPatientVisit readPatientVisit(String projFlow, String visitFlow,
			String patientFlow) {
		PubPatientVisitExample example = new PubPatientVisitExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andVisitFlowEqualTo(visitFlow).andPatientFlowEqualTo(patientFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubPatientVisit> pvList = patientVisitMapper.selectByExample(example);
		if(pvList!=null && pvList.size()>0){
			return pvList.get(0);
		}
		return null;
	}

	@Override
	public PubPatient readPatient(String patientFlow) {
		return patientBiz.readPatient(patientFlow); 
	}

	@Override
	public EdcVisit readVisit(String visitFlow) {
		return visitBiz.readVisit(visitFlow);
	}

	@Override
	public void modifyPatientVisit(PubPatientVisit pateintVisit) {
		GeneralMethod.setRecordInfo(pateintVisit, false);
		patientVisitMapper.updateByPrimaryKeySelective(pateintVisit);
	}

	@Override
	public void addPatientVisit(PubPatientVisit pateintVisit,EdcPatientVisit edcPatientVisit) {
		GeneralMethod.setRecordInfo(pateintVisit, true); 
		patientVisitMapper.insert(pateintVisit); 
		
		GeneralMethod.setRecordInfo(edcPatientVisit, true); 
		edcPatientVisitMapper.insert(edcPatientVisit); 
	}

	@Override
	public List<EdcPatientVisitData> searchPatientVisitData(String recordFlow,String attrCode,String elementSerialSeq) {
		EdcPatientVisitDataExample example = new EdcPatientVisitDataExample();
		example.createCriteria().andVisitRecordFlowEqualTo(recordFlow).andAttrCodeEqualTo(attrCode).andElementSerialSeqEqualTo(elementSerialSeq)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		return visitDataMapper.selectByExample(example); 
	}

	@Override
	public void modifyPatientVisit(EdcPatientVisit pateintVisit,EdcPatientVisitData data) { 
		modifyEdcPatientVisit(pateintVisit);
		modifyVisitData(data);
	}

	@Override
	public void addPatientVisit(PubPatientVisit pateintVisit,EdcPatientVisit edcPatientVisit, EdcPatientVisitData data) {
		addPatientVisit(pateintVisit,edcPatientVisit);
		addVisitData(data);
	}

	@Override
	public void addVisitData(EdcPatientVisitData data) {
		GeneralMethod.setRecordInfo(data, true);
		visitDataMapper.insert(data);
	}

	@Override
	public void modifyVisitData(EdcPatientVisitData data) {
		GeneralMethod.setRecordInfo(data, false);
		visitDataMapper.updateByPrimaryKeySelective(data);
	}

	@Override
	public List<EdcPatientVisitData> searchPatientVisitData(String recordFlow) {
		EdcPatientVisitDataExample example = new EdcPatientVisitDataExample();
		example.createCriteria().andVisitRecordFlowEqualTo(recordFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("element_Serial_Seq");
		return visitDataMapper.selectByExample(example); 
	}

	@Override
	public void modifyPatientVisit(EdcPatientVisit edcPateintVisit,
			boolean isOper1) {
		modifyEdcPatientVisit(edcPateintVisit);
		Map<String,String> paramMap  = new HashMap<String, String>();
		paramMap.put("visitRecordFlow", edcPateintVisit.getRecordFlow());
		paramMap.put("modifyTime", DateUtil.getCurrDateTime());
		paramMap.put("modifyUserFlow", GlobalContext.getCurrentUser().getUserFlow());
		if(isOper1){
			edcVisitDataExtMapper.modifyPatientVisitDataValue1(paramMap);
		}else {
			edcVisitDataExtMapper.modifyPatientVisitDataValue2(paramMap);
		}
	}

	private List<EdcPatientVisitData> searchPatientVisitData(String recordFlow,
			String elementCode) {
		EdcPatientVisitDataExample example = new EdcPatientVisitDataExample();
		example.createCriteria().andVisitRecordFlowEqualTo(recordFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andElementCodeEqualTo(elementCode);
		example.setOrderByClause("element_Serial_Seq");
		return visitDataMapper.selectByExample(example); 
	}
	@Override
	public void delVisitData(String recordFlow, String elementCode,
			String elementSerialSeq) {
		if(StringUtil.isNotBlank(elementSerialSeq)){ 
			List<String> seqList = Arrays.asList(StringUtil.split(elementSerialSeq, ","));
			EdcPatientVisitDataExample example = new EdcPatientVisitDataExample();
			example.createCriteria().andVisitRecordFlowEqualTo(recordFlow).andElementCodeEqualTo(elementCode)
			.andElementSerialSeqIn(seqList).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			EdcPatientVisitData record = new EdcPatientVisitData();
			record.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			visitDataMapper.updateByExampleSelective(record, example);
			//重置所有序号排序  必要操作，否则页面新增错误
			List<EdcPatientVisitData> visitData = searchPatientVisitData(recordFlow,elementCode);
			Map<String,Map<String,EdcPatientVisitData>> serialSeqMap  = new TreeMap<String,Map<String,EdcPatientVisitData>>();
			for(EdcPatientVisitData data : visitData){
				Map<String,EdcPatientVisitData> valueMap  = serialSeqMap.get(data.getElementSerialSeq());
				if(valueMap == null){
					valueMap = new HashMap<String, EdcPatientVisitData>();
				}
				valueMap.put(data.getAttrCode(), data);
				serialSeqMap.put(data.getElementSerialSeq(), valueMap);
			}
			int initSeq=1;
			for(Map.Entry<String, Map<String,EdcPatientVisitData>> entity:serialSeqMap.entrySet() ){
				Map<String,EdcPatientVisitData> valueMap = entity.getValue();
				for(Map.Entry<String,EdcPatientVisitData> valueEntity:valueMap.entrySet() ){
					EdcPatientVisitData data =  valueEntity.getValue();
					data.setElementSerialSeq(String.valueOf(initSeq));
					visitDataMapper.updateByPrimaryKeySelective(data);
				}
				initSeq++;
			}
		}
	}

	@Override
	public List<PubPatientVisit> searchPatientVisit(PubPatientVisitExample example) {
		return patientVisitMapper.selectByExample(example);
	}

	@Override
	public List<PubPatientVisit> searchPatientVisit(String projFlow,
			String orgFlow,String patientFlow) {
		PubPatientVisitExample example = new PubPatientVisitExample();
		Criteria criteria =  example.createCriteria().andProjFlowEqualTo(projFlow)
				.andPatientFlowEqualTo(patientFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(orgFlow)){
			criteria.andOrgFlowEqualTo(orgFlow);
		} 
		return  patientVisitMapper.selectByExample(example); 
	}

	@Override
	public EdcPatientVisit readEdcPatientVisit(String recordFlow) {
		return edcPatientVisitMapper.selectByPrimaryKey(recordFlow);
	}


	@Override
	public void addEdcPatientVisit(EdcPatientVisit visit) {
		GeneralMethod.setRecordInfo(visit, true);
		edcPatientVisitMapper.insert(visit);
	}


	@Override
	public void modifyEdcPatientVisit(EdcPatientVisit edcPatientVisit) {
		GeneralMethod.setRecordInfo(edcPatientVisit, false);
		edcPatientVisitMapper.updateByPrimaryKeySelective(edcPatientVisit);
	}

	@Override
	public void addPatientVisit(PubPatientVisit pateintVisit) {
		GeneralMethod.setRecordInfo(pateintVisit, true);
		patientVisitMapper.insert(pateintVisit);
	}

	@Override
	public List<EdcPatientVisitData> searchPatientVisitData(
			EdcPatientVisitDataExample dataExample) {
		return visitDataMapper.selectByExample(dataExample); 
	}

	@Override
	public List<PubPatient> searPatientList(String projFlow) {
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return patientBiz.searchPatient(example);
	}

	@Override
	public PatientVisitForm selectPatientVisit(String recordFlow) {
		PatientVisitForm patientVisit = new PatientVisitForm();
		patientVisit.setPatientVisit(patientVisitMapper.selectByPrimaryKey(recordFlow));
		patientVisit.setEdcPatientVisit(edcPatientVisitMapper.selectByPrimaryKey(recordFlow));
		return patientVisit; 
	}

	@Override
	public EdcPatientVisitData readEdcPatientVisitData(String recordFlow) {
		return visitDataMapper.selectByPrimaryKey(recordFlow);
	}

//	@Override
//	public Map<String,Map<String,Map<String,EdcPatientVisitData>>> getPatientCrfDataMap(String projFlow, String patientFlow) {
//		Map<String,Map<String,Map<String,EdcPatientVisitData>>> patientCrfDataMap = new HashMap<String,Map<String,Map<String,EdcPatientVisitData>>>();
//		EdcPatientVisitDataExample dataExample = new EdcPatientVisitDataExample();
//		dataExample.createCriteria().andProjFlowEqualTo(projFlow).andPatientFlowEqualTo(patientFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
//		List<EdcPatientVisitData> visitDataList = searchPatientVisitData(dataExample);
//		for(EdcPatientVisitData data : visitDataList){
//			 Map<String,Map<String,EdcPatientVisitData>>  serialSeqDataMap = patientCrfDataMap.get(data.getVisitFlow());
//			 if(serialSeqDataMap == null){
//				 serialSeqDataMap = new HashMap<String, Map<String,EdcPatientVisitData>>();
//			 }
//			 Map<String,EdcPatientVisitData> dataMap = serialSeqDataMap.get(data.getAttrCode());
//			 if(dataMap == null){
//				 dataMap = new HashMap<String, EdcPatientVisitData>();
//			 }
//			 dataMap.put(data.getAttrCode(), data);
//			 
//			 serialSeqDataMap.put(data.getElementSerialSeq(), dataMap);
//			 patientCrfDataMap.put(data.getVisitFlow(), serialSeqDataMap);
//		}
//		return patientCrfDataMap;
//	}

	@Override
	public Map<String, PatientVisitForm> getPatientSubmitVisitMap(String projFlow,
		String patientFlow) {
		PubPatientVisitExample example = new PubPatientVisitExample();
		example.createCriteria().andProjFlowEqualTo(projFlow)
				.andPatientFlowEqualTo(patientFlow)
				.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubPatientVisit> patientVisit =  patientVisitMapper.selectByExample(example); 
		
		Map<String,PatientVisitForm> visitMap = new HashMap<String,PatientVisitForm>();
		for(PubPatientVisit visit : patientVisit){
			PatientVisitForm form = new PatientVisitForm();
			form.setPatientVisit(visit);
			EdcPatientVisit edcPatientVisit = edcPatientVisitMapper.selectByPrimaryKey(visit.getRecordFlow());
			if(edcPatientVisit!=null && edcPatientVisit.getInputOperStatusId()!=null && edcPatientVisit.getInputOperStatusId().equals(EdcInputStatusEnum.Checked.getId())){
				form.setEdcPatientVisit(edcPatientVisit); 
				visitMap.put(visit.getVisitFlow(), form);
			}
		}
		return visitMap;
	}


	@Override
	public Map<String, Map<String, Map<String, EdcPatientVisitData>>> getelementSerialSeqValueMap(String recordFlow) {
		Map<String,Map<String,Map<String,EdcPatientVisitData>>> elementSerialSeqValueMap  = new HashMap<String, Map<String,Map<String,EdcPatientVisitData>>>();
		List<EdcPatientVisitData> visitData = searchPatientVisitData(recordFlow);
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
		return elementSerialSeqValueMap;
	}
	
	@Override
	public List<EdcPatientVisitDataForm> searchVisitDataFormList(Map<String,String> conditionMap){
		return edcVisitDataExtMapper.searchVisitDataReport(conditionMap);
	}

	@Override
	public List<PubPatientVisit> searchPatientVisit(String projFlow,String orgFlow
			) {
		PubPatientVisitExample example = new PubPatientVisitExample();
		Criteria criteria =  example.createCriteria().andProjFlowEqualTo(projFlow)
				.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(orgFlow)){
			criteria.andOrgFlowEqualTo(orgFlow);
		} 
		return  patientVisitMapper.selectByExample(example); 
	}
	
	@Override
	public Map<String,String> searchEdcPatientVistMap(String projFlow){
		Map<String,String> visitMap = new HashMap<String,String>();
		//按机构
		List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
		int totalPatientCount = 0;
		if (projOrgList != null && projOrgList.size() > 0) {
			for (PubProjOrg temp:projOrgList) {
				String orgFlow = temp.getOrgFlow();
				String submitCount = edcPatientVisitExtMapper.searchEdcPatientVistMap(projFlow,orgFlow,EdcInputStatusEnum.Submit.getId());
				String checkedCount = edcPatientVisitExtMapper.searchEdcPatientVistMap(projFlow,orgFlow,EdcInputStatusEnum.Checked.getId());
				String saveCount = "0";
				if (StringUtil.isNotBlank(temp.getPatientCount())) {
					saveCount = Integer.parseInt(temp.getPatientCount())-Integer.parseInt(submitCount)-Integer.parseInt(checkedCount)+"";
					totalPatientCount += Integer.parseInt(temp.getPatientCount());
				}
				visitMap.put(orgFlow+EdcInputStatusEnum.Save.getId(), saveCount);
				visitMap.put(orgFlow+EdcInputStatusEnum.Submit.getId(), submitCount);
				visitMap.put(orgFlow+EdcInputStatusEnum.Checked.getId(), checkedCount);
			}
		}
		//全部
		String submitCount = edcPatientVisitExtMapper.searchEdcPatientVistMap(projFlow,"",EdcInputStatusEnum.Submit.getId());
		String checkedCount = edcPatientVisitExtMapper.searchEdcPatientVistMap(projFlow,"",EdcInputStatusEnum.Checked.getId());
		String saveCount = totalPatientCount-Integer.parseInt(submitCount)-Integer.parseInt(checkedCount)+"";
		visitMap.put(EdcInputStatusEnum.Save.getId(), saveCount);
		visitMap.put(EdcInputStatusEnum.Submit.getId(), submitCount);
		visitMap.put(EdcInputStatusEnum.Checked.getId(), checkedCount);
		return visitMap;
	}
}  
 