package com.pinde.sci.biz.edc.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IPubPatientWindowBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EdcAttributeMapper;
import com.pinde.sci.dao.base.EdcIeMapper;
import com.pinde.sci.dao.base.EdcPatientVisitDataMapper;
import com.pinde.sci.dao.base.EdcProjParamMapper;
import com.pinde.sci.dao.base.EdcVisitAttrCodeMapper;
import com.pinde.sci.dao.base.EdcVisitAttributeMapper;
import com.pinde.sci.dao.base.EdcVisitDataEventMapper;
import com.pinde.sci.dao.base.EdcVisitElementMapper;
import com.pinde.sci.dao.base.EdcVisitMapper;
import com.pinde.sci.dao.base.EdcVisitModuleMapper;
import com.pinde.sci.dao.base.PubPatientVisitMapper;
import com.pinde.sci.dao.edc.EdcPatientVisitDataExtMapper;
import com.pinde.sci.dao.edc.EdcVisitExtMapper;
import com.pinde.sci.dao.pub.PubPatientVisitExtMapper;
import com.pinde.sci.enums.edc.AppItemInputTypeEnum;
import com.pinde.sci.enums.edc.AttrDataTypeEnum;
import com.pinde.sci.enums.edc.EdcIETypeEnum;
import com.pinde.sci.enums.pub.OutWindowTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.edc.EdcVisitForm;
import com.pinde.sci.form.edc.ElementSerialSeqForm;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcAttributeExample;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcIe;
import com.pinde.sci.model.mo.EdcIeExample;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcPatientVisitDataExample;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitAttrCode;
import com.pinde.sci.model.mo.EdcVisitAttrCodeExample;
import com.pinde.sci.model.mo.EdcVisitAttribute;
import com.pinde.sci.model.mo.EdcVisitAttributeExample;
import com.pinde.sci.model.mo.EdcVisitElement;
import com.pinde.sci.model.mo.EdcVisitElementExample;
import com.pinde.sci.model.mo.EdcVisitExample;
import com.pinde.sci.model.mo.EdcVisitModule;
import com.pinde.sci.model.mo.EdcVisitModuleExample;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientVisitExample;
import com.pinde.sci.model.mo.PubPatientVisitExample.Criteria;
import com.pinde.sci.model.mo.PubPatientWindow;


@Service
@Transactional(rollbackFor=Exception.class)
public class VisitBizImpl implements IVisitBiz{

	@Resource
	private EdcVisitMapper visitMapper;
	@Resource
	private EdcVisitModuleMapper visitModuleMapper;
	@Resource
	private EdcVisitElementMapper visitElementMapper;
	@Resource
	private EdcVisitAttributeMapper visitAttrMapper;
	@Resource
	private EdcVisitAttrCodeMapper visitAttrCodeMapper;
	@Resource
	private EdcProjParamMapper projParamMapper;
	@Resource
	private PubPatientVisitMapper pubPatientVisitMapper;
	@Resource
	private EdcIeMapper ieMapper;
	@Autowired
	private IEdcModuleBiz moduleBiz;
	@Autowired
	private EdcVisitDataEventMapper visitDataEventMapper;
	@Autowired
	private EdcPatientVisitDataMapper patientVisitDataMapper;
	@Autowired
	private PubPatientVisitExtMapper patientVisitExtMapper;
	@Autowired
	private EdcPatientVisitDataExtMapper patientVisitDataExtMapper;
	@Resource
	private EdcVisitExtMapper visitExtMapper;
	@Resource
	private EdcAttributeMapper attrMapper;
	@Resource
	private IPubPatientWindowBiz patientWindowBiz;
	@Autowired
	private IEdcGroupBiz groupBiz;
	@Resource
	private IEdcRandomBiz randomBiz;
	
	@Override
	public List<EdcVisit> searchVisitList(EdcVisitExample example) {
		return visitMapper.selectByExample(example);
	}

	@Override
	public void addVisit(String projFlow) {
		EdcVisitExample example = new EdcVisitExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y); 
		int count = visitMapper.countByExample(example);
		
		
		EdcVisit visit = new EdcVisit();
		visit.setVisitFlow(PkUtil.getUUID());
		visit.setVisitName("访视"+(++count));
//		visit.setVisitTypeId(visitTypeId);
//		visit.setVisitTypeName(visitTypeName);
		
		visit.setOrdinal(++count);
		visit.setProjFlow(projFlow);
		GeneralMethod.setRecordInfo(visit, true);
		visitMapper.insert(visit);
	}

	@Override
	public List<EdcVisit> searchVisitList(String projFlow) {
		EdcVisitExample example = new EdcVisitExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		example.setOrderByClause("ORDINAL");
		return searchVisitList(example); 
	}
	
	@Override
	public EdcVisit searchBaseline(String projFlow,String groupFlow) {
		EdcVisit visit = null; 
		EdcVisitExample example = new EdcVisitExample();
		com.pinde.sci.model.mo.EdcVisitExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andProjFlowEqualTo(projFlow).andIsBaselineEqualTo(GlobalConstant.FLAG_Y);
		if (StringUtil.isNotBlank(groupFlow)) {
			if (GlobalConstant.FLAG_Y.equals(groupFlow)) {	//通用组别
				criteria.andGroupFlowIsNull();
			} else {
				criteria.andGroupFlowEqualTo(groupFlow);
			}
		}
		example.setOrderByClause("ORDINAL");
		List<EdcVisit> visitList = searchVisitList(example);
		if(visitList!=null && visitList.size()>0){
			visit = visitList.get(0);
		}
		return visit; 
	}
	
	@Override
	public List<EdcVisit> searchVisitList(String projFlow,String isVisit) {
		EdcVisitExample example = new EdcVisitExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andIsVisitEqualTo(isVisit);
		example.setOrderByClause("ORDINAL");
		return searchVisitList(example);
	}

	@Override
	public EdcVisit readVisit(String visitFlow) {
		return visitMapper.selectByPrimaryKey(visitFlow);
	}

	@Override
	public void modify(EdcVisit visit) {
		GeneralMethod.setRecordInfo(visit, false);
		visit.setVisitTypeName(DictTypeEnum.VisitType.getDictNameById( visit.getVisitTypeId()));
		visitMapper.updateByPrimaryKeySelective(visit);
	}

	@Override
	public EdcVisitModule searchVisitModule(String visitFlow,String moduleCode) {
		EdcVisitModule visitModule = null;
		EdcVisitModuleExample example = new EdcVisitModuleExample();
		example.createCriteria().andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcVisitModule> list = visitModuleMapper.selectByExample(example);
		if (list != null && list.size() >0) {
			visitModule = list.get(0);
		}
		return visitModule; 
	}
	
	@Override
	public List<EdcVisitModule> searchVisitModule(EdcVisitModuleExample vmExample) {
		return visitModuleMapper.selectByExample(vmExample); 
	}

	@Override
	public void addVisitModule(EdcVisitModule vm) {
		GeneralMethod.setRecordInfo(vm, true);
		visitModuleMapper.insert(vm);
	}

	public void _delVisitModule(EdcVisitModule edcVisitModule) {
		GeneralMethod.setRecordInfo(edcVisitModule, false);
		edcVisitModule.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		visitModuleMapper.updateByPrimaryKeySelective(edcVisitModule);
	}

	@Override
	public void delVisitEleAttrCode(EdcVisitModule edcVisitModule,String projFlow, String visitFlow,
			String moduleCode) {
		_delVisitModule(edcVisitModule);
		//del ele
		EdcVisitElementExample eleExample = new EdcVisitElementExample();
		eleExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode)
		.andVisitFlowEqualTo(visitFlow);
		EdcVisitElement element = new EdcVisitElement();
		element.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		visitElementMapper.updateByExampleSelective(element, eleExample);
		//del attr
		EdcVisitAttributeExample attrExample = new EdcVisitAttributeExample();
		attrExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode)
		.andVisitFlowEqualTo(visitFlow);
		EdcVisitAttribute attr = new EdcVisitAttribute();
		attr.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		visitAttrMapper.updateByExampleSelective(attr, attrExample);
		//del attrCode
		EdcVisitAttrCodeExample attrCodeExample = new EdcVisitAttrCodeExample();
		attrCodeExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode)
		.andVisitFlowEqualTo(visitFlow);
		EdcVisitAttrCode attrCode = new EdcVisitAttrCode();
		attrCode.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		visitAttrCodeMapper.updateByExampleSelective(attrCode, attrCodeExample);
	}

	public void _addVisitElement(List<EdcVisitElement> veList) {
		for(EdcVisitElement ve : veList){
			GeneralMethod.setRecordInfo(ve, true);
			visitElementMapper.insert(ve);
		}
	}

	public void _addVisitAttr(List<EdcVisitAttribute> visitAttrList) {
		for(EdcVisitAttribute visitAttr: visitAttrList){
			GeneralMethod.setRecordInfo(visitAttr, true);
			visitAttrMapper.insert(visitAttr);
		}
	}
	public void _modVisitAttr(List<EdcVisitAttribute> visitAttrList) {
		for(EdcVisitAttribute visitAttr: visitAttrList){
			GeneralMethod.setRecordInfo(visitAttr, false);
			visitAttr.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			visitAttrMapper.updateByPrimaryKeySelective(visitAttr);
		}
	}
	public void _delVisitAttr(List<EdcVisitAttribute> visitAttrList) {
		for(EdcVisitAttribute visitAttr: visitAttrList){
			GeneralMethod.setRecordInfo(visitAttr, false);
			visitAttr.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			visitAttrMapper.updateByPrimaryKeySelective(visitAttr);
		}
	}
	
	@Override
	public void _addVisitAttrCode(List<EdcVisitAttrCode> visitAttrCodeList) {
		for(EdcVisitAttrCode visitAttrCode: visitAttrCodeList){
			GeneralMethod.setRecordInfo(visitAttrCode, true);
			visitAttrCodeMapper.insert(visitAttrCode);
		}
	}
	public void _modVisitAttrCode(List<EdcVisitAttrCode> visitAttrCodeList) {
		for(EdcVisitAttrCode visitAttrCode: visitAttrCodeList){
			GeneralMethod.setRecordInfo(visitAttrCode, false);
			visitAttrCode.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			visitAttrCodeMapper.updateByPrimaryKeySelective(visitAttrCode);
		}
	}
	public void _delVisitAttrCode(List<EdcVisitAttrCode> visitAttrCodeList) {
		for(EdcVisitAttrCode visitAttrCode: visitAttrCodeList){
			GeneralMethod.setRecordInfo(visitAttrCode, false);
			visitAttrCode.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			visitAttrCodeMapper.updateByPrimaryKeySelective(visitAttrCode);
		}
	}
	
	
	public void _delVisitElement(List<EdcVisitElement> visitEleList) {
		for(EdcVisitElement visitEle: visitEleList){
			GeneralMethod.setRecordInfo(visitEle, false);
			visitEle.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			visitElementMapper.updateByPrimaryKeySelective(visitEle);
		}
	}

	@Override
	public void addVisitModule_Element_Attr_Code(EdcVisitModule vm,
			List<EdcVisitElement> veList, List<EdcVisitAttribute> visitAttrList,List<EdcVisitAttrCode> visitAttrCodeList) {
		addVisitModule(vm);
		_addVisitElement(veList);
		_addVisitAttr(visitAttrList);
		_addVisitAttrCode(visitAttrCodeList);
	}

	@Override
	public List<EdcVisitElement> searchVisitElement(
			EdcVisitElementExample example) {
		return visitElementMapper.selectByExample(example);
	}

	@Override
	public List<EdcVisitAttribute> searchVisitAttribute(
			EdcVisitAttributeExample attrExample) {
		return visitAttrMapper.selectByExample(attrExample);
	}
	
	@Override
	public List<EdcVisitAttrCode> searchVisitAttrCode(
			EdcVisitAttrCodeExample attrCodeExample) {
		return visitAttrCodeMapper.selectByExample(attrCodeExample);
	}

	@Override
	public void saveOrUpdateEdcElementAttr(List<EdcVisitElement> addEleList,
			List<EdcVisitElement> delEleList,
			List<EdcVisitAttribute> addAttrList,
			List<EdcVisitAttribute> delAttrList) {
		_addVisitElement(addEleList);
		_delVisitElement(delEleList);
		_addVisitAttr(addAttrList);
		_delVisitAttr(delAttrList);
	}

	@Override
	public void delVisit(String visitFlow) {
		EdcVisitExample example = new EdcVisitExample();
		example.createCriteria().andVisitFlowEqualTo(visitFlow);
		EdcVisit record = new EdcVisit();
		record.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		visitMapper.updateByExampleSelective(record, example);
	}

	@Override
	public void addVisit(EdcVisit visit) {
		GeneralMethod.setRecordInfo(visit, true);
		visit.setVisitTypeName(DictTypeEnum.VisitType.getDictNameById( visit.getVisitTypeId()));
		visitMapper.insert(visit);
	}

	@Override
	public EdcVisitElement readVisitElement(String projFlow, String visitFlow,
			String moduleCode, String oprateEleCode) {
		EdcVisitElementExample example = new EdcVisitElementExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andVisitFlowEqualTo(visitFlow)
		.andModuleCodeEqualTo(moduleCode).andElementCodeEqualTo(oprateEleCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcVisitElement> veList = visitElementMapper.selectByExample(example);
		if(veList!=null && veList.size()>0){
			return veList.get(0);
		}
		return null;
	}

	@Override
	public void onOffVisitElement(EdcVisitElement visitElement,String recordStatus) {
		GeneralMethod.setRecordInfo(visitElement, false);
		visitElement.setRecordStatus(recordStatus);
		visitElementMapper.updateByPrimaryKey(visitElement);
	}

	@Override
	public void addVisitElement(EdcVisitElement visitElement) {
		GeneralMethod.setRecordInfo(visitElement, true);
		visitElementMapper.insert(visitElement);
	}

	@Override
	public void delVisitEleAttr(String projFlow, String visitFlow,
			String moduleCode, String elementCode) {
		EdcVisitAttributeExample attrExample = new EdcVisitAttributeExample();
		attrExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode)
		.andVisitFlowEqualTo(visitFlow).andElementCodeEqualTo(elementCode);
		EdcVisitAttribute attr = new EdcVisitAttribute();
		attr.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		visitAttrMapper.updateByExampleSelective(attr, attrExample);
	}
	
	@Override
	public void delVisitEleAttrCode(String projFlow, String visitFlow,
			String moduleCode, String elementCode) {
		EdcVisitAttrCodeExample attrCodeExample = new EdcVisitAttrCodeExample();
		attrCodeExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode)
		.andVisitFlowEqualTo(visitFlow).andElementCodeEqualTo(elementCode);
		EdcVisitAttrCode attrCode = new EdcVisitAttrCode();
		attrCode.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		visitAttrCodeMapper.updateByExampleSelective(attrCode, attrCodeExample);
	}

	@Override
	public void saveVisitAttr(List<EdcVisitAttribute> addVisitAttrList,
			List<EdcVisitAttribute> modVisitAttrList,
			List<EdcVisitAttribute> delVisitAttrList) {
		_addVisitAttr(addVisitAttrList);
		_modVisitAttr(modVisitAttrList);
		_delVisitAttr(delVisitAttrList);
	}
	
	@Override
	public void saveVisitAttrCode(List<EdcVisitAttrCode> addVisitAttrCodeList,
			List<EdcVisitAttrCode> modVisitAttrCodeList,
			List<EdcVisitAttrCode> delVisitAttrCodeList) {
		_addVisitAttrCode(addVisitAttrCodeList);
		_modVisitAttrCode(modVisitAttrCodeList);
		_delVisitAttrCode(delVisitAttrCodeList);
	}

	@Override
	public void savePageModuleOrder(String visitFlow, String[] moduleCode) {
		for(int i=0;i<moduleCode.length;i++){
			EdcVisitModule update = new EdcVisitModule();
//			update.setVisitFlow(visitFlow);
//			update.setModuleCode(moduleCode[i]);
			update.setOrdinal((i+1));
			EdcVisitModuleExample example = new EdcVisitModuleExample();
			example.createCriteria().andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode[i]).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			visitModuleMapper.updateByExampleSelective(update, example);			
		}		
	}

	@Override
	public void savePageModuleOrder2(String visitFlow, String moduleCode,Integer ordinal) {
			EdcVisitModule update = new EdcVisitModule();
			update.setVisitFlow(visitFlow);
			update.setModuleCode(moduleCode);
			update.setOrdinal(ordinal);
			EdcVisitModuleExample example = new EdcVisitModuleExample();
			example.createCriteria().andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			visitModuleMapper.updateByExampleSelective(update, example);			
	}
	
	@Override
	public void savePageElementOrder(String visitFlow, String[] elementCode) {
		for(int i=0;i<elementCode.length;i++){
			EdcVisitElement update = new EdcVisitElement();
//			update.setVisitFlow(visitFlow);
//			update.setModuleCode(moduleCode[i]);
			update.setOrdinal((i+1));
			EdcVisitElementExample example = new EdcVisitElementExample();
			example.createCriteria().andVisitFlowEqualTo(visitFlow).andElementCodeEqualTo(elementCode[i]).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			visitElementMapper.updateByExampleSelective(update, example);			
		}		
	}

	@Override
	public void savePageAttributeOrder(String visitFlow, String[] attrCode) {
		for(int i=0;i<attrCode.length;i++){
			EdcVisitAttribute update = new EdcVisitAttribute();
//			update.setVisitFlow(visitFlow);
//			update.setModuleCode(moduleCode[i]);
			update.setOrdinal((i+1));
			EdcVisitAttributeExample example = new EdcVisitAttributeExample();
			example.createCriteria().andVisitFlowEqualTo(visitFlow).andAttrCodeEqualTo(attrCode[i]).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			visitAttrMapper.updateByExampleSelective(update, example);			
		}		
	}

	@Override
	public EdcProjParam readProjParam(String projFlow) {
		return projParamMapper.selectByPrimaryKey(projFlow); 
	}
	
	@Override
	public List<PubPatientVisit> searchPubPatientVisits(PubPatientVisitExample example) {
		return pubPatientVisitMapper.selectByExample(example);
	}
	
	@Override
	public List<EdcIe> searchIeList(String projFlow,String ieType) {
		EdcIeExample example = new EdcIeExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andTypeIdEqualTo(ieType);
		example.setOrderByClause("ORDINAL");
		return searchIeList(example); 
	}
	
	@Override
	public List<EdcIe> searchIeList(EdcIeExample example) {
		return ieMapper.selectByExample(example);
	}
	
	@Override
	public EdcIe readEdcIe(String ieFlow) {
		return ieMapper.selectByPrimaryKey(ieFlow); 
	}
	
	@Override
	public void addEdcIe(EdcIe ie) {
		ie.setIeFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(ie, true);
		ieMapper.insert(ie);
	}
	
	@Override
	public void modifyEdcIe(EdcIe ie) {
		GeneralMethod.setRecordInfo(ie, false);
		ieMapper.updateByPrimaryKeySelective(ie);
	}
	
	@Override
	public int impEdcIE(String projFlow,String icEleVarName,String ieeEleVarName){
		//复制纳入标准
		String typeId = EdcIETypeEnum.Include.getId();
		String eleVarName = icEleVarName;
		addIEList(projFlow,typeId,icEleVarName,"true");
		//复制排除标准
		typeId = EdcIETypeEnum.Exclude.getId();
		eleVarName = ieeEleVarName;
		addIEList(projFlow,typeId,eleVarName,"false");
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public void addIEList(String projFlow,String typeId,String eleVarName,String passValueFlag){
		EdcElement ele =  moduleBiz.selElement(projFlow, eleVarName);
		if (ele != null) {
			List<EdcAttribute> attrList = moduleBiz.searchAttrList(projFlow,ele.getElementCode());
			String typeName = EdcIETypeEnum.getNameById(typeId);
			String inputTypeId = AppItemInputTypeEnum.Bool.getId();
			String inputTypeName = AppItemInputTypeEnum.getNameById(inputTypeId);
			if (attrList != null && attrList.size() > 0) {
				for(EdcAttribute attr :attrList){
					if(GlobalConstant.RECORD_STATUS_N.equals(attr.getRecordStatus())){
						continue;
					}
					EdcIe ie = new EdcIe();
					ie.setProjFlow(projFlow);
					ie.setIeName(StringUtil.defaultString(attr.getAttrName()));
					ie.setIeVarName(StringUtil.defaultString(attr.getAttrVarName()));
					ie.setTypeId(typeId);
					ie.setTypeName(typeName);
					ie.setInputTypeId(inputTypeId);
					ie.setInputTypeName(inputTypeName);
					ie.setPassedValue(passValueFlag);
					ie.setMaxValue("");
					ie.setMinValue("");
					if (attr.getOrdinal() != null) {
						ie.setOrdinal(attr.getOrdinal());
					}
					addEdcIe(ie);
				}
			}
		}
	}
	
	@Override
	public List<PubPatientVisit> searchPatientVisit(String projFlow,String orgFlow){
		PubPatientVisitExample example = new PubPatientVisitExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("VISIT_DATE DESC");
		return pubPatientVisitMapper.selectByExample(example);
	}
	
	@Override
	public List<EdcPatientVisitData> searchPatientVisitDataByModuleCode(String projFlow,String modleCode){
		EdcPatientVisitDataExample example = new EdcPatientVisitDataExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(modleCode);
		example.setOrderByClause("ELEMENT_SERIAL_SEQ");
		return patientVisitDataMapper.selectByExample(example);
	}
	
	@Override
	public List<EdcPatientVisitData> searchPatientVisitDataByAttrCode(String projFlow,String attrCode){
		EdcPatientVisitDataExample example = new EdcPatientVisitDataExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andAttrCodeEqualTo(attrCode)
		.andAttrValueIsNotNull();
		return patientVisitDataMapper.selectByExample(example);
	}
	
	@Override
	public List<EdcPatientVisitData> searchVisitDataDistinct(String projFlow,String attrCode,String attrDataTypeId){
		Map<String,String> conditionMap = new HashMap<String, String>();
		conditionMap.put("projFlow",projFlow);
		conditionMap.put("attrCode",attrCode);
		if(AttrDataTypeEnum.Integer.getId().equals(attrDataTypeId) || AttrDataTypeEnum.Float.getId().equals(attrDataTypeId)){
			conditionMap.put("attrValue","TO_NUMBER(ATTR_VALUE)");
		}else{
			conditionMap.put("attrValue","ATTR_VALUE");
		}
		return patientVisitDataExtMapper.searchVisitDataDistinct(conditionMap);
	}
	
	@Override
	public List<PubPatientVisit> searchPatientVisitByModule(String projFlow,String moduleCode,String inputOperStatusId){
		Map<String,String> map = new HashMap<String,String>();
		map.put("projFlow",projFlow);
		map.put("moduleCode",moduleCode);
		map.put("inputOperStatusId",inputOperStatusId);
		return patientVisitExtMapper.selectByModuleCode(map);
	}
	
	@Override
	public List<ElementSerialSeqForm> searchElementSerialSeq(String patientFlow,String visitFlow){
		Map<String,String> map = new HashMap<String,String>();
		map.put("patientFlow",patientFlow);
		map.put("visitFlow",visitFlow);
		return patientVisitDataExtMapper.selectSeq(map);
	}
	
	@Override
	public List<EdcVisit> searchVisits(String groupFlow) {
		EdcVisitExample example = new EdcVisitExample();
		example.createCriteria().andGroupFlowEqualTo(groupFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return searchVisitList(example); 
	}
	
	@Override
	public List<EdcVisit> searchCommonVisits(String projFlow) {
		EdcVisitExample example = new EdcVisitExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andGroupFlowIsNull().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return searchVisitList(example); 
	}
	
	@Override
	public List<EdcVisit> searchVisitsByGroupFlow(String projFlow,String groupFlow,String isVisit){
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("projFlow",projFlow);
		paramMap.put("groupFlow",groupFlow);
		paramMap.put("isVisit",isVisit);
		return visitExtMapper.searchVisitsByGroupFlow(paramMap);
	}
	
	@Override
	public List<EdcVisit> sortVisitByOrdinal(List<EdcVisit> visitList) {
		if (visitList != null && visitList.size() > 0) {
			Collections.sort(visitList, new Comparator<EdcVisit>(){
				@Override
				public int compare(EdcVisit visit1, EdcVisit visit2) {
					return visit1.getOrdinal().compareTo(visit2.getOrdinal());
				}
			});
		}
		return visitList;
	}
	
	@Override
	public void saveEdcAttributeOrder(String projFlow, String moduleCode, String[] attrCode) {
		for(int i=0;i<attrCode.length;i++){
			EdcAttribute update = new EdcAttribute();
			update.setOrdinal((i+1));
			EdcAttributeExample example = new EdcAttributeExample();
			example.createCriteria().andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode).andAttrCodeEqualTo(attrCode[i]).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			attrMapper.updateByExampleSelective(update, example);			
		}		
	}
	
	@Override
	public List<EdcVisitForm> searchVisitsByModuleCode(String moduleCode){
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("moduleCode",moduleCode);
		return visitExtMapper.searchVisitsByModuleCode(paramMap);
	}
	
	@Override
	public List<EdcVisitForm> searchVisitsByElementCode(String elementCode){
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("elementCode",elementCode);
		return visitExtMapper.searchVisitsByElementCode(paramMap);
	}
	
	@Override
	public List<PubPatientVisit> searchPatientVisit(PubPatientVisit patientVisit){
		PubPatientVisitExample example = new PubPatientVisitExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(patientVisit.getProjFlow())) {
			criteria.andProjFlowEqualTo(patientVisit.getProjFlow());
		}
		if (StringUtil.isNotBlank(patientVisit.getOrgFlow())) {
			criteria.andOrgFlowEqualTo(patientVisit.getOrgFlow());
		}
		if (StringUtil.isNotBlank(patientVisit.getPatientFlow())) {
			criteria.andPatientFlowEqualTo(patientVisit.getPatientFlow());
		}
		if (StringUtil.isNotBlank(patientVisit.getVisitFlow())) {
			criteria.andVisitFlowEqualTo(patientVisit.getVisitFlow());
		}
		example.setOrderByClause("VISIT_DATE DESC");
		return pubPatientVisitMapper.selectByExample(example);
	}
	
	@Override
	public PubPatientVisit readPatientVisit(String recordFlow){
		return pubPatientVisitMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public int savePatientVisit(PubPatientVisit patientVisit){
		if(patientVisit!=null){
			if(StringUtil.isNotBlank(patientVisit.getRecordFlow())){
				GeneralMethod.setRecordInfo(patientVisit, false);
				return pubPatientVisitMapper.updateByPrimaryKeySelective(patientVisit);
			}else{
				patientVisit.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(patientVisit, true);
				pubPatientVisitMapper.insertSelective(patientVisit);
				return updatePatientWindow(patientVisit.getRecordFlow());
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int updatePatientWindow(String recordFlow){
		if(StringUtil.isNotBlank(recordFlow)){
			PubPatientVisit patientVisit = readPatientVisit(recordFlow);
			PubPatientWindow window = null;
			if(patientVisit!=null){
				window = patientWindowBiz.readPatientWindow(patientVisit.getPatientFlow(),patientVisit.getVisitFlow());
			}
			if(window!=null){
				window.setVisitDate(patientVisit.getVisitDate());
				String visitDate = patientVisit.getVisitDate();
				//回写当前访视访视窗
				writeBackWindow(window);
				//计算下次访视访视窗
				List<EdcVisit> visitList = null;
				String projFlow = patientVisit.getProjFlow();
				List<EdcGroup> groupList = groupBiz.searchEdcGroup(projFlow);
				if (groupList != null && groupList.size() >0) {//分组别
					String drugGroup = randomBiz.searchPatientDrugGroup(patientVisit.getPatientFlow());
					if (StringUtil.isNotBlank(drugGroup)) {
						EdcGroup group = groupBiz.searchEdcGroup(projFlow,drugGroup);
						if (group != null) {
							visitList = searchVisitsByGroupFlow(projFlow,group.getGroupFlow(),null);
						}
					}
				} else {
					visitList = searchVisitList(projFlow,GlobalConstant.FLAG_Y);
				}
				
				if(visitList!=null && visitList.size()>0){
					List<String> visitFlows = new ArrayList<String>();
					for(EdcVisit visit : visitList){
						visitFlows.add(visit.getVisitFlow());
					}
					int index = visitFlows.indexOf(window.getVisitFlow())+1;
					if(index!=0 && index<visitList.size()){
						EdcVisit visit = visitList.get(index);
						PubPatientWindow nextWindow = patientWindowBiz.readPatientWindow(patientVisit.getPatientFlow(),visitFlows.get(index));
						if(nextWindow!=null){
							String[] windowArea = null;
							if(StringUtil.isNotBlank(visit.getVisitWindow())){
								windowArea = visit.getVisitWindow().split(",");
							};
							if(windowArea!=null && windowArea.length>1 && StringUtil.isNotBlank(windowArea[1])){
								String leftVisitDate = null;
								String rightVisitDate = null;
								if (StringUtil.isNotBlank(windowArea[0])) {
									leftVisitDate = DateUtil.addDate(visitDate, Integer.parseInt(windowArea[1])-Integer.parseInt(windowArea[0]));
								} else {
									leftVisitDate = DateUtil.addDate(visitDate, Integer.parseInt(windowArea[1]));
								}
								if (windowArea.length>2 && StringUtil.isNotBlank(windowArea[2])) {
									rightVisitDate = DateUtil.addDate(visitDate, Integer.parseInt(windowArea[1])+Integer.parseInt(windowArea[2]));
								} else {
									rightVisitDate = DateUtil.addDate(visitDate, Integer.parseInt(windowArea[1]));
								}
								if(!(leftVisitDate.equals(nextWindow.getWindowVisitLeft()) && rightVisitDate.equals(nextWindow.getWindowVisitRight()))){
									nextWindow.setWindowVisitLeft(leftVisitDate);
									nextWindow.setWindowVisitRight(rightVisitDate);
									if(StringUtil.isNotBlank(nextWindow.getVisitDate())){
										writeBackWindow(nextWindow);
									}
									patientWindowBiz.savePatientWindow(nextWindow);
								}
							}
						}
					}
				}
				return patientWindowBiz.savePatientWindow(window);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	private void writeBackWindow(PubPatientWindow window){
		String visitDate = window.getVisitDate();
		if(StringUtil.isNotBlank(window.getWindowVisitLeft()) && StringUtil.isNotBlank(window.getWindowVisitRight()) && StringUtil.isNotBlank(visitDate)){
			long outDays = 0l;
			if(visitDate.compareTo(window.getWindowVisitLeft())<0){
				window.setOutWindowTypeId(OutWindowTypeEnum.Earlier.getId());
				window.setOutWindowTypeName(OutWindowTypeEnum.Earlier.getName());
				outDays = DateUtil.signDaysBetweenTowDate(visitDate,window.getWindowVisitLeft());
			}else if(visitDate.compareTo(window.getWindowVisitRight())>0){
				window.setOutWindowTypeId(OutWindowTypeEnum.Delayed.getId());
				window.setOutWindowTypeName(OutWindowTypeEnum.Delayed.getName());
				outDays = DateUtil.signDaysBetweenTowDate(visitDate,window.getWindowVisitRight());
			}else{
				window.setOutWindowTypeId("");
				window.setOutWindowTypeName("");
				window.setOutWindowDays("");
			}
			if(outDays!=0l){
				if(outDays>0l){
					window.setOutWindowDays("+"+outDays);
				}else{
					window.setOutWindowDays(outDays+"");
				}
			}
		}
	}
} 
 