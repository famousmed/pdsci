package com.pinde.sci.biz.edc.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EdcAttrCodeMapper;
import com.pinde.sci.dao.base.EdcAttributeMapper;
import com.pinde.sci.dao.base.EdcElementMapper;
import com.pinde.sci.dao.base.EdcInspectMapper;
import com.pinde.sci.dao.base.EdcModuleMapper;
import com.pinde.sci.dao.base.EdcNormalValueMapper;
import com.pinde.sci.dao.base.EdcVisitAttrCodeMapper;
import com.pinde.sci.dao.base.EdcVisitAttributeMapper;
import com.pinde.sci.dao.base.EdcVisitElementMapper;
import com.pinde.sci.dao.base.EdcVisitMapper;
import com.pinde.sci.dao.base.EdcVisitModuleMapper;
import com.pinde.sci.enums.edc.AttrDataTypeEnum;
import com.pinde.sci.enums.edc.AttrInputTypeEnum;
import com.pinde.sci.enums.edc.InspectTypeEnum;
import com.pinde.sci.enums.edc.ModuleStyleEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.edc.ObservationCfgForm;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.EdcModuleForm;
import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttrCodeExample;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcAttributeExample;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcElementExample;
import com.pinde.sci.model.mo.EdcInspect;
import com.pinde.sci.model.mo.EdcInspectExample;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcModuleExample;
import com.pinde.sci.model.mo.EdcNormalValue;
import com.pinde.sci.model.mo.EdcNormalValueExample;
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


@Service
@Transactional(rollbackFor=Exception.class)
public class EdcModuleBizImpl implements IEdcModuleBiz{

	@Resource
	private EdcModuleMapper moduleMapper;
	@Resource
	private EdcElementMapper elementMapper;

	@Resource
	private EdcAttributeMapper attrMapper;

	@Resource
	private EdcAttrCodeMapper codeMapper;
	
	@Resource
	private EdcVisitModuleMapper visitModuleMapper;
	@Resource
	private EdcVisitElementMapper visitElementMapper;
	@Resource
	private EdcVisitAttributeMapper visitAttrMapper;
	@Resource
	private EdcVisitAttrCodeMapper visitAttrCodeMapper;
	@Resource
	private EdcNormalValueMapper normalValueMapper;
	@Resource
	private EdcVisitMapper visitMapper;
	@Resource
	private EdcInspectMapper inspectMapper;
	

	@Override
	public List<EdcModule> searchModuleList(EdcModuleExample example) {
		return moduleMapper.selectByExample(example);
	}

	@Override
	public void addOrDelModule(List<EdcModule> addList, List<EdcModule> delList) {
		for(EdcModule module : addList){
			module.setModuleTypeName(DictTypeEnum.ModuleType.getDictNameById(module.getModuleTypeId()));
			if (StringUtil.isNotBlank(module.getModuleStyleId())) {
				module.setModuleStyleName(ModuleStyleEnum.getNameById(module.getModuleStyleId()));
			}
			GeneralMethod.setRecordInfo(module, true);
			moduleMapper.insert(module);
		}
		
		for(EdcModule module : delList){
			module.setModuleTypeName(DictTypeEnum.ModuleType.getDictNameById(module.getModuleTypeId()));
			if (StringUtil.isNotBlank(module.getModuleStyleId())) {
				module.setModuleStyleName(ModuleStyleEnum.getNameById(module.getModuleStyleId()));
			}
			GeneralMethod.setRecordInfo(module, false);
			module.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			moduleMapper.updateByPrimaryKeySelective(module);
			
			//同步废止
			//元素
			EdcElementExample example = new EdcElementExample();
			example.createCriteria().andModuleCodeEqualTo(module.getModuleCode()).andProjFlowEqualTo(module.getProjFlow()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			EdcElement record = new EdcElement();
			record.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			elementMapper.updateByExampleSelective(record, example);
			//属性
			EdcAttributeExample attrExample = new EdcAttributeExample();
			attrExample.createCriteria().andModuleCodeEqualTo(module.getModuleCode()).andProjFlowEqualTo(module.getProjFlow()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			EdcAttribute attrRecord = new EdcAttribute();
			attrRecord.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			attrMapper.updateByExampleSelective(attrRecord, attrExample);
			//代码
			EdcAttrCodeExample codeExample = new EdcAttrCodeExample();
			codeExample.createCriteria().andModuleCodeEqualTo(module.getModuleCode()).andProjFlowEqualTo(module.getProjFlow()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			EdcAttrCode codeRecord = new EdcAttrCode();
			codeRecord.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			codeMapper.updateByExampleSelective(codeRecord, codeExample);
			//页面模块
			EdcVisitModuleExample vmExample = new EdcVisitModuleExample();
			vmExample.createCriteria().andModuleCodeEqualTo(module.getModuleCode()).andProjFlowEqualTo(module.getProjFlow()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			EdcVisitModule vmRecord = new EdcVisitModule();
			vmRecord.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			visitModuleMapper.updateByExampleSelective(vmRecord, vmExample);
			//页面元素
			EdcVisitElementExample veExample = new EdcVisitElementExample();
			veExample.createCriteria().andModuleCodeEqualTo(module.getModuleCode()).andProjFlowEqualTo(module.getProjFlow()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			EdcVisitElement veRecord = new EdcVisitElement();
			veRecord.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			visitElementMapper.updateByExampleSelective(veRecord, veExample);
			//页面属性
			EdcVisitAttributeExample vaExample = new EdcVisitAttributeExample();
			vaExample.createCriteria().andModuleCodeEqualTo(module.getModuleCode()).andProjFlowEqualTo(module.getProjFlow()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			EdcVisitAttribute vaRecord = new EdcVisitAttribute();
			vaRecord.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			visitAttrMapper.updateByExampleSelective(vaRecord, vaExample);
		}
	}

	@Override
	public EdcModule readEdcModule(String projFlow, String moduleCode) {
		EdcModuleExample example = new EdcModuleExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode);
		List<EdcModule> list = moduleMapper.selectByExample(example);
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
	}

	@Override
	public EdcModuleForm getModuleForm(String projFlow ,String moduleCode) {
		EdcModuleForm moduleForm = new EdcModuleForm();
		//Element
		EdcElementExample example = new EdcElementExample();
		example.createCriteria().andModuleCodeEqualTo(moduleCode).andProjFlowEqualTo(projFlow)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcElement> elements = elementMapper.selectByExample(example);
		moduleForm.setElements(elements);  //element-list
		List<String> elementCodes = moduleForm.getElementCodes();
		Map<String,EdcElement> elementMap = moduleForm.getElementMap();
		for(EdcElement element :elements){
			elementCodes.add(element.getElementCode());
			elementMap.put(element.getElementCode(), element); //element-map
		}
		
		//Attribute
		EdcAttributeExample	 attrExample = new EdcAttributeExample(); 
		attrExample.createCriteria().andModuleCodeEqualTo(moduleCode).andProjFlowEqualTo(projFlow)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcAttribute> attrList = attrMapper.selectByExample(attrExample);
		moduleForm.setAttrs(attrList);	//attr - list
		Map<String,List<EdcAttribute>> eleAttrMap = moduleForm.getEleAttrMap();
		Map<String,EdcAttribute> attrMap = moduleForm.getAttrMap();
		List<String> attrCodes = moduleForm.getAttrCodes();
		for(EdcAttribute attr : attrList){
			List<EdcAttribute> temp = eleAttrMap.get(attr.getElementCode());
			if(temp == null){
				temp = new ArrayList<EdcAttribute>();
			}
			temp.add(attr);
			eleAttrMap.put(attr.getElementCode(), temp); //attr-ref map
			attrMap.put(attr.getAttrCode(), attr);	//attr- self map
			attrCodes.add(attr.getAttrCode());
		}
		//AttrCode
		EdcAttrCodeExample attrCodeExample = new EdcAttrCodeExample(); 
		attrCodeExample.createCriteria().andModuleCodeEqualTo(moduleCode).andProjFlowEqualTo(projFlow);
		List<EdcAttrCode> codeList = codeMapper.selectByExample(attrCodeExample);
		moduleForm.setCodes(codeList);	// code - list
		Map<String ,List<EdcAttrCode>> attrCodeMap = moduleForm.getAttrCodeMap();
		Map<String,EdcAttrCode> codeMap = moduleForm.getCodeMap();
		List<String> codeValues = moduleForm.getCodeValue();
		for(EdcAttrCode code : codeList){
			List<EdcAttrCode> temp = attrCodeMap.get(code.getAttrCode());
			if(temp == null){
				temp = new ArrayList<EdcAttrCode>();
			}
			temp.add(code);
			attrCodeMap.put(code.getAttrCode(), temp);  //code - ref map
			codeMap.put(code.getAttrCode()+"."+code.getCodeValue(), code);  //code -self map
			if(GlobalConstant.RECORD_STATUS_Y.equals(code.getRecordStatus())){	
				codeValues.add(code.getAttrCode()+"."+code.getCodeValue());
			}
		}
		return moduleForm;
	}

	@Override
	public void saveOrUpdateEdcElement(List<EdcElement> addEleList,
			List<EdcElement> delEleList) {
		for(EdcElement element :addEleList){
			GeneralMethod.setRecordInfo(element, true);
			elementMapper.insert(element);
		}
		for(EdcElement element :delEleList){
			GeneralMethod.setRecordInfo(element, false);
			element.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			elementMapper.updateByPrimaryKeySelective(element);
		}
	}

	@Override
	public void saveOrUpdateEdcAttr(List<EdcAttribute> addAttr,List<EdcAttribute> modAttr,
			List<EdcAttribute> delAttr) {
		for(EdcAttribute attr :addAttr){
			GeneralMethod.setRecordInfo(attr, true);
			attrMapper.insert(attr);
		}
		for(EdcAttribute attr :modAttr){
			GeneralMethod.setRecordInfo(attr, false);
			attr.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			attrMapper.updateByPrimaryKeySelective(attr);
		}
		for(EdcAttribute attr :delAttr){
			GeneralMethod.setRecordInfo(attr, false);
			attr.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			attrMapper.updateByPrimaryKeySelective(attr);
		}
	}

	@Override
	public void saveOrUpdateEdcAttrCode(List<EdcAttrCode> addAttrCode,List<EdcAttrCode> modAttrCode,
			List<EdcAttrCode> delAttrCode) {
		for(EdcAttrCode code :addAttrCode){
			GeneralMethod.setRecordInfo(code, true);
			codeMapper.insert(code);
		}
		for(EdcAttrCode code :modAttrCode){
			GeneralMethod.setRecordInfo(code, false);
			code.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			codeMapper.updateByPrimaryKeySelective(code);
		}
		for(EdcAttrCode code :delAttrCode){
			GeneralMethod.setRecordInfo(code, false);
			code.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			codeMapper.updateByPrimaryKeySelective(code);
		}
	}
 
	@Override
	public void delAttrCode(String projFlow,String moduleCode) {
		EdcAttrCodeExample example = new EdcAttrCodeExample();
		example.createCriteria().andModuleCodeEqualTo(moduleCode).andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		EdcAttrCode record = new EdcAttrCode();
		record.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		codeMapper.updateByExampleSelective(record, example);
	}

	@Override
	public void onOffEdcModule(EdcModule module, String recordStatus) {
		
		if(GlobalConstant.RECORD_STATUS_N.equals(recordStatus)){
			//调用原来批量的方法
			List<EdcModule> delList = new ArrayList<EdcModule>();
			delList.add(module);
			addOrDelModule(new ArrayList<EdcModule>(),delList);
		}else {
			GeneralMethod.setRecordInfo(module, false);
			module.setRecordStatus(recordStatus);
			moduleMapper.updateByPrimaryKeySelective(module);
		}
	}

	@Override
	public void addEdcModule(EdcModule targetModule) {
		targetModule.setModuleTypeName(DictTypeEnum.ModuleType.getDictNameById(targetModule.getModuleTypeId()));
		if (StringUtil.isNotBlank(targetModule.getModuleStyleId())) {
			targetModule.setModuleStyleName(ModuleStyleEnum.getNameById(targetModule.getModuleStyleId()));
		}
		GeneralMethod.setRecordInfo(targetModule, true);
		moduleMapper.insert(targetModule);
	}

	@Override
	public int countModule(String projFlow) {
		EdcModuleExample example = new EdcModuleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		return moduleMapper.countByExample(example);
	}

	@Override
	public void addElement(EdcElement element) {
		GeneralMethod.setRecordInfo(element, true);
		elementMapper.insert(element);
	}

	@Override
	public void onOffEdcElement(EdcElement element, String recordStatus) { 
		GeneralMethod.setRecordInfo(element, false);
		element.setRecordStatus(recordStatus);
		elementMapper.updateByPrimaryKeySelective(element);
	}

	@Override
	public void delAttrCode(String projFlow, String moduleCode,
			String oprateEleCode) {
		EdcAttrCodeExample example = new EdcAttrCodeExample();
		example.createCriteria().andModuleCodeEqualTo(moduleCode).andProjFlowEqualTo(projFlow).andElementCodeEqualTo(oprateEleCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		EdcAttrCode record = new EdcAttrCode();
		record.setRecordStatus(GlobalConstant.RECORD_STATUS_N); 
		codeMapper.updateByExampleSelective(record, example);
	}

	@Override
	public List<EdcModule> searchModuleList(String projFlow) {
		EdcModuleExample example = new EdcModuleExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return searchModuleList(example);
	}

	@Override
	public List<EdcAttribute> searchAttributeList(String projFlow) {
		EdcAttributeExample example = new EdcAttributeExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return attrMapper.selectByExample(example);
	}

	@Override
	public List<EdcElement> searchElementList(String projFlow) {
		EdcElementExample	example = new EdcElementExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y); 
		example.setOrderByClause("ORDINAL");
		return elementMapper.selectByExample(example);
	}
	
	@Override
	public List<EdcElement> searchElementList(String projFlow,List<String> moduleCodes){
		EdcElementExample	example = new EdcElementExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andModuleCodeIn(moduleCodes); 
		example.setOrderByClause("ORDINAL");
		return elementMapper.selectByExample(example);
	}
	
	@Override
	public List<EdcAttribute> searchAttrList(String projFlow,List<String> moduleCodes){
		EdcAttributeExample example = new EdcAttributeExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andModuleCodeIn(moduleCodes);
		example.setOrderByClause("ORDINAL");
		return attrMapper.selectByExample(example);
	}
	
	@Override
	public List<EdcAttrCode> searchCodeList(String projFlow) {
		EdcAttrCodeExample	example = new EdcAttrCodeExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y); 
		example.setOrderByClause("ORDINAL");
		return codeMapper.selectByExample(example);
	}

	@Override
	public EdcDesignForm getDescForm(String projFlow) {
		EdcDesignForm designForm = new EdcDesignForm();
		//项目模块
		EdcModuleExample moduleExample = new EdcModuleExample();
		moduleExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		moduleExample.setOrderByClause("ORDINAL");
		List<EdcModule> moduleList = moduleMapper.selectByExample(moduleExample);
		designForm.setModuleList(moduleList);
		Map<String,EdcModule> moduleMap = designForm.getModuleMap();
		for(EdcModule module : moduleList){
			moduleMap.put(module.getModuleCode(), module);
		}
		//项目元素
		EdcElementExample example = new EdcElementExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		List<EdcElement> elements = elementMapper.selectByExample(example);
		Map<String,EdcElement> elementMap = designForm.getElementMap();
		Map<String,List<EdcElement>> moduleElementMap = designForm.getModuleElementMap();
		for(EdcElement element :elements){
			elementMap.put(element.getElementCode(), element); 
			List<EdcElement> temp = moduleElementMap.get(element.getModuleCode());
			if(temp == null){
				temp = new ArrayList<EdcElement>();
			}
			temp.add(element);
			moduleElementMap.put(element.getModuleCode(), temp);
		}
		
		//项目属性
		EdcAttributeExample	 attrExample = new EdcAttributeExample(); 
		attrExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		attrExample.setOrderByClause("ORDINAL");
		List<EdcAttribute> attrList = attrMapper.selectByExample(attrExample);
		Map<String,EdcAttribute> attrMap = designForm.getAttrMap();
		Map<String,List<EdcAttribute>> elementAttrMap = designForm.getElementAttrMap();
		for(EdcAttribute attr : attrList){
			attrMap.put(attr.getAttrCode(), attr);
			List<EdcAttribute> temp = elementAttrMap.get(attr.getElementCode());
			if(temp == null){
				temp = new ArrayList<EdcAttribute>();
			}
			temp.add(attr);
			elementAttrMap.put(attr.getElementCode(), temp);
		}
		//项目代码
		EdcAttrCodeExample attrCodeExample = new EdcAttrCodeExample(); 
		attrCodeExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		attrCodeExample.setOrderByClause("ORDINAL");
		List<EdcAttrCode> codeList = codeMapper.selectByExample(attrCodeExample);
		Map<String,EdcAttrCode> codeMap = designForm.getCodeMap();
		Map<String ,List<EdcAttrCode>> attrCodeMap = designForm.getAttrCodeMap();
		Map<String,Map<String,String>> attrCodeValueMap = designForm.getAttrCodeValueMap();
		
		for(EdcAttrCode code : codeList){
			codeMap.put(code.getCodeFlow(), code);
			List<EdcAttrCode> temp = attrCodeMap.get(code.getAttrCode());
			if(temp == null){
				temp = new ArrayList<EdcAttrCode>();
			}
			temp.add(code);
			attrCodeMap.put(code.getAttrCode(), temp);  
			
			
			Map<String,String> codeValueMap = attrCodeValueMap.get(code.getAttrCode());
			if(codeValueMap == null){
				codeValueMap = new HashMap<String, String>();
			}
			codeValueMap.put(code.getCodeValue(),code.getCodeName());
			attrCodeValueMap.put(code.getAttrCode(), codeValueMap);
		}
		
		//页面
		 Map<String,EdcVisit> visitMap = new HashMap<String, EdcVisit>();
		EdcVisitExample visitExample = new EdcVisitExample();
		visitExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		visitExample.setOrderByClause("ORDINAL");
		List<EdcVisit> visitList = visitMapper.selectByExample(visitExample);
		for(EdcVisit visit : visitList){
			visitMap.put(visit.getVisitFlow(), visit);
		}
		designForm.setVisitList(visitList);
		designForm.setVisitMap(visitMap);
		
		//页面模块
		EdcVisitModuleExample vmExample = new EdcVisitModuleExample();
		vmExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		//vmExample.setOrderByClause("(SELECT ORDINAL from EDC_MODULE where  module_code = EDC_VISIT_MODULE.module_code and proj_flow='"+projFlow+"' and record_status='"+GlobalConstant.RECORD_STATUS_Y+"')");
		vmExample.setOrderByClause("ORDINAL");
		List<EdcVisitModule> visitModuleList =  visitModuleMapper.selectByExample(vmExample);
		Map<String, List<EdcVisitModule>> visitModuleMap = designForm.getVisitModuleMap();
		for(EdcVisitModule vm : visitModuleList){
			List<EdcVisitModule> temp = visitModuleMap.get(vm.getVisitFlow());
			if(temp == null){
				temp = new ArrayList<EdcVisitModule>();
			}
			temp.add(vm);
			visitModuleMap.put(vm.getVisitFlow(), temp);
		}
		
		//页面元素
		EdcVisitElementExample veExample = new EdcVisitElementExample();
		veExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		//veExample.setOrderByClause("(SELECT ORDINAL from EDC_ELEMENT where element_code = EDC_VISIT_ELEMENT.element_code and proj_flow='"+projFlow+"' and record_status='"+GlobalConstant.RECORD_STATUS_Y+"')");
		veExample.setOrderByClause("ORDINAL");
		List<EdcVisitElement> elementList =  visitElementMapper.selectByExample(veExample);
		Map<String, List<EdcVisitElement>> visitElementMap = designForm.getVisitModuleElementMap();
		for(EdcVisitElement ve : elementList){
			List<EdcVisitElement> temp = visitElementMap.get(ve.getVisitFlow()+"_"+ve.getModuleCode());
			if(temp == null){
				temp = new ArrayList<EdcVisitElement>();
			}
			temp.add(ve);
			visitElementMap.put(ve.getVisitFlow()+"_"+ve.getModuleCode(), temp);
		}
		//页面属性 
		EdcVisitAttributeExample vaExample = new EdcVisitAttributeExample();
		vaExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		//vaExample.setOrderByClause("(SELECT ORDINAL from EDC_ATTRIBUTE where attr_code = EDC_VISIT_ATTRIBUTE.attr_code and proj_flow='"+projFlow+"' and record_status='"+GlobalConstant.RECORD_STATUS_Y+"')");
		vaExample.setOrderByClause("ORDINAL");
		List<EdcVisitAttribute> visitAttrList =  visitAttrMapper.selectByExample(vaExample);
		Map<String, List<EdcVisitAttribute>> visitElementAttributeMap = designForm.getVisitElementAttributeMap();
		for(EdcVisitAttribute attr : visitAttrList){
			List<EdcVisitAttribute> temp = visitElementAttributeMap.get(attr.getVisitFlow()+"_"+attr.getModuleCode()+"_"+attr.getElementCode());
			if(temp == null){
				temp = new ArrayList<EdcVisitAttribute>();
			}
			temp.add(attr);
			visitElementAttributeMap.put(attr.getVisitFlow()+"_"+attr.getModuleCode()+"_"+attr.getElementCode(), temp);
		}
		//页面代码
		EdcVisitAttrCodeExample vcExample = new EdcVisitAttrCodeExample();
		vcExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		//vaExample.setOrderByClause("(SELECT ORDINAL from EDC_ATTR_CODE where code_flow = EDC_VISIT_ATTR_CODE.code_flow and proj_flow='"+projFlow+"' and record_status='"+GlobalConstant.RECORD_STATUS_Y+"')");
		vcExample.setOrderByClause("ORDINAL");
		List<EdcVisitAttrCode> visitAttrCodeList =  visitAttrCodeMapper.selectByExample(vcExample);
		Map<String, List<EdcVisitAttrCode>> visitAttrCodeMap = designForm.getVisitAttrCodeMap();
		for(EdcVisitAttrCode attrCode : visitAttrCodeList){
			List<EdcVisitAttrCode> temp = visitAttrCodeMap.get(attrCode.getVisitFlow()+"_"+attrCode.getModuleCode()+"_"+attrCode.getElementCode()+"_"+attrCode.getAttrCode());
			if(temp == null){
				temp = new ArrayList<EdcVisitAttrCode>();
			}
			temp.add(attrCode);
			visitAttrCodeMap.put(attrCode.getVisitFlow()+"_"+attrCode.getModuleCode()+"_"+attrCode.getElementCode()+"_"+attrCode.getAttrCode(), temp);
		}
		//标准单位
		Map<String,String> standarUnitMap = new HashMap<String,String>();
		for(EdcModule module : moduleList){
			if(module.getModuleTypeId().equals(GlobalConstant.MODULD_TYPE_LB)){
				if(moduleElementMap.get(module.getModuleCode())!=null){
					for(EdcElement element:moduleElementMap.get(module.getModuleCode())){
						if( elementAttrMap.get(element.getElementCode())!=null){
							 for(EdcAttribute attr : elementAttrMap.get(element.getElementCode())){
								 if( GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME .equals(attr.getAttrVarName())){
									 if(attrCodeMap.get(attr.getAttrCode())!=null){
										 for(EdcAttrCode code : attrCodeMap.get(attr.getAttrCode())){
											 standarUnitMap.put(code.getElementCode(), code.getCodeName());
										 }
									 }
								 }
							 }
						}
					}
				}
			}
		}
		designForm.setElementStandardUnitMap(standarUnitMap);
		//正常值范围
		EdcNormalValueExample nvExample = new EdcNormalValueExample();
		nvExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcNormalValue> list = normalValueMapper.selectByExample(nvExample);
		Map<String,Map<String,EdcNormalValue>> normalValueMap = new HashMap<String, Map<String,EdcNormalValue>>();
		for(EdcNormalValue normalValue : list){
			Map<String,EdcNormalValue> sexNormalValueMap =  normalValueMap.get(normalValue.getOrgFlow()+"_"+normalValue.getElementCode());
			if(sexNormalValueMap == null){
				sexNormalValueMap = new HashMap<String, EdcNormalValue>();
			}
			sexNormalValueMap.put(normalValue.getSexId(), normalValue);
			normalValueMap.put(normalValue.getOrgFlow()+"_"+normalValue.getElementCode(), sexNormalValueMap);
		}
		designForm.setNormalValueMap(normalValueMap);
		return designForm;
	}
	
	@Override
	public EdcDesignForm getCrfDescForm(String projFlow) {
		EdcDesignForm designForm = new EdcDesignForm();
		//项目模块
		EdcModuleExample moduleExample = new EdcModuleExample();
		moduleExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		moduleExample.setOrderByClause("ORDINAL");
		List<EdcModule> moduleList = moduleMapper.selectByExample(moduleExample);
		designForm.setModuleList(moduleList);
		Map<String,EdcModule> moduleMap = designForm.getModuleMap();
		for(EdcModule module : moduleList){
			moduleMap.put(module.getModuleCode(), module);
		}
		//项目元素
		EdcElementExample example = new EdcElementExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		List<EdcElement> elements = elementMapper.selectByExample(example);
		Map<String,EdcElement> elementMap = designForm.getElementMap();
		Map<String,List<EdcElement>> moduleElementMap = designForm.getModuleElementMap();
		for(EdcElement element :elements){
			elementMap.put(element.getElementCode(), element); 
			List<EdcElement> temp = moduleElementMap.get(element.getModuleCode());
			if(temp == null){
				temp = new ArrayList<EdcElement>();
			}
			temp.add(element);
			moduleElementMap.put(element.getModuleCode(), temp);
		}
		
		//项目属性
		EdcAttributeExample	 attrExample = new EdcAttributeExample(); 
		attrExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		attrExample.setOrderByClause("ORDINAL");
		List<EdcAttribute> attrList = attrMapper.selectByExample(attrExample);
		Map<String,EdcAttribute> attrMap = designForm.getAttrMap();
		Map<String,List<EdcAttribute>> elementAttrMap = designForm.getElementAttrMap();
		for(EdcAttribute attr : attrList){
			attrMap.put(attr.getAttrCode(), attr);
			List<EdcAttribute> temp = elementAttrMap.get(attr.getElementCode());
			if(temp == null){
				temp = new ArrayList<EdcAttribute>();
			}
			temp.add(attr);
			elementAttrMap.put(attr.getElementCode(), temp);
		}
		//项目代码
		EdcAttrCodeExample attrCodeExample = new EdcAttrCodeExample(); 
		attrCodeExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		attrCodeExample.setOrderByClause("ORDINAL");
		List<EdcAttrCode> codeList = codeMapper.selectByExample(attrCodeExample);
		Map<String,EdcAttrCode> codeMap = designForm.getCodeMap();
		Map<String ,List<EdcAttrCode>> attrCodeMap = designForm.getAttrCodeMap();
		Map<String,Map<String,String>> attrCodeValueMap = designForm.getAttrCodeValueMap();
		
		for(EdcAttrCode code : codeList){
			codeMap.put(code.getCodeFlow(), code);
			List<EdcAttrCode> temp = attrCodeMap.get(code.getAttrCode());
			if(temp == null){
				temp = new ArrayList<EdcAttrCode>();
			}
			temp.add(code);
			attrCodeMap.put(code.getAttrCode(), temp);  
			
			
			Map<String,String> codeValueMap = attrCodeValueMap.get(code.getAttrCode());
			if(codeValueMap == null){
				codeValueMap = new HashMap<String, String>();
			}
			codeValueMap.put(code.getCodeValue(),code.getCodeName());
			attrCodeValueMap.put(code.getAttrCode(), codeValueMap);
		}
		
		//页面
		 Map<String,EdcVisit> visitMap = new HashMap<String, EdcVisit>();
		EdcVisitExample visitExample = new EdcVisitExample();
		visitExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		visitExample.setOrderByClause("ORDINAL");
		List<EdcVisit> visitList = visitMapper.selectByExample(visitExample);
		for(EdcVisit visit : visitList){
			visitMap.put(visit.getVisitFlow(), visit);
		}
		designForm.setVisitList(visitList);
		designForm.setVisitMap(visitMap);
		
		//页面模块
		EdcVisitModuleExample vmExample = new EdcVisitModuleExample();
		vmExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		//vmExample.setOrderByClause("(SELECT ORDINAL from EDC_MODULE where  module_code = EDC_VISIT_MODULE.module_code and proj_flow='"+projFlow+"' and record_status='"+GlobalConstant.RECORD_STATUS_Y+"')");
		vmExample.setOrderByClause("ORDINAL");
		List<EdcVisitModule> visitModuleList =  visitModuleMapper.selectByExample(vmExample);
		Map<String, List<EdcVisitModule>> visitModuleMap = designForm.getVisitModuleMap();
		for(EdcVisitModule vm : visitModuleList){
			List<EdcVisitModule> temp = visitModuleMap.get(vm.getVisitFlow());
			if(temp == null){
				temp = new ArrayList<EdcVisitModule>();
			}
			temp.add(vm);
			visitModuleMap.put(vm.getVisitFlow(), temp);
		}
		
		//页面元素
		EdcVisitElementExample veExample = new EdcVisitElementExample();
		veExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		//veExample.setOrderByClause("(SELECT ORDINAL from EDC_ELEMENT where element_code = EDC_VISIT_ELEMENT.element_code and proj_flow='"+projFlow+"' and record_status='"+GlobalConstant.RECORD_STATUS_Y+"')");
		veExample.setOrderByClause("ORDINAL");
		List<EdcVisitElement> elementList =  visitElementMapper.selectByExample(veExample);
		Map<String, List<EdcVisitElement>> visitElementMap = designForm.getVisitModuleElementMap();
		for(EdcVisitElement ve : elementList){
			String moduleCode = ve.getModuleCode();
			if (StringUtil.isNotBlank(ve.getPlaceholdModuleCode())) {
				moduleCode = ve.getPlaceholdModuleCode();
			}
			List<EdcVisitElement> temp = visitElementMap.get(ve.getVisitFlow()+"_"+moduleCode);
			if(temp == null){
				temp = new ArrayList<EdcVisitElement>();
			}
			temp.add(ve);
			visitElementMap.put(ve.getVisitFlow()+"_"+moduleCode, temp);
		}
		//页面属性 
		EdcVisitAttributeExample vaExample = new EdcVisitAttributeExample();
		vaExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		//vaExample.setOrderByClause("(SELECT ORDINAL from EDC_ATTRIBUTE where attr_code = EDC_VISIT_ATTRIBUTE.attr_code and proj_flow='"+projFlow+"' and record_status='"+GlobalConstant.RECORD_STATUS_Y+"')");
		vaExample.setOrderByClause("ORDINAL");
		List<EdcVisitAttribute> visitAttrList =  visitAttrMapper.selectByExample(vaExample);
		Map<String, List<EdcVisitAttribute>> visitElementAttributeMap = designForm.getVisitElementAttributeMap();
		for(EdcVisitAttribute attr : visitAttrList){
			List<EdcVisitAttribute> temp = visitElementAttributeMap.get(attr.getVisitFlow()+"_"+attr.getModuleCode()+"_"+attr.getElementCode());
			if(temp == null){
				temp = new ArrayList<EdcVisitAttribute>();
			}
			temp.add(attr);
			visitElementAttributeMap.put(attr.getVisitFlow()+"_"+attr.getModuleCode()+"_"+attr.getElementCode(), temp);
		}
		//页面代码
		EdcVisitAttrCodeExample vcExample = new EdcVisitAttrCodeExample();
		vcExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		//vaExample.setOrderByClause("(SELECT ORDINAL from EDC_ATTR_CODE where code_flow = EDC_VISIT_ATTR_CODE.code_flow and proj_flow='"+projFlow+"' and record_status='"+GlobalConstant.RECORD_STATUS_Y+"')");
		vcExample.setOrderByClause("ORDINAL");
		List<EdcVisitAttrCode> visitAttrCodeList =  visitAttrCodeMapper.selectByExample(vcExample);
		Map<String, List<EdcVisitAttrCode>> visitAttrCodeMap = designForm.getVisitAttrCodeMap();
		for(EdcVisitAttrCode attrCode : visitAttrCodeList){
			List<EdcVisitAttrCode> temp = visitAttrCodeMap.get(attrCode.getVisitFlow()+"_"+attrCode.getModuleCode()+"_"+attrCode.getElementCode()+"_"+attrCode.getAttrCode());
			if(temp == null){
				temp = new ArrayList<EdcVisitAttrCode>();
			}
			temp.add(attrCode);
			visitAttrCodeMap.put(attrCode.getVisitFlow()+"_"+attrCode.getModuleCode()+"_"+attrCode.getElementCode()+"_"+attrCode.getAttrCode(), temp);
		}
		//标准单位
		Map<String,String> standarUnitMap = new HashMap<String,String>();
		for(EdcModule module : moduleList){
			if(module.getModuleTypeId().equals(GlobalConstant.MODULD_TYPE_LB)){
				if(moduleElementMap.get(module.getModuleCode())!=null){
					for(EdcElement element:moduleElementMap.get(module.getModuleCode())){
						if( elementAttrMap.get(element.getElementCode())!=null){
							 for(EdcAttribute attr : elementAttrMap.get(element.getElementCode())){
								 if( GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME .equals(attr.getAttrVarName())){
									 if(attrCodeMap.get(attr.getAttrCode())!=null){
										 for(EdcAttrCode code : attrCodeMap.get(attr.getAttrCode())){
											 standarUnitMap.put(code.getElementCode(), code.getCodeName());
										 }
									 }
								 }
							 }
						}
					}
				}
			}
		}
		designForm.setElementStandardUnitMap(standarUnitMap);
		//正常值范围
		EdcNormalValueExample nvExample = new EdcNormalValueExample();
		nvExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcNormalValue> list = normalValueMapper.selectByExample(nvExample);
		Map<String,Map<String,EdcNormalValue>> normalValueMap = new HashMap<String, Map<String,EdcNormalValue>>();
		for(EdcNormalValue normalValue : list){
			Map<String,EdcNormalValue> sexNormalValueMap =  normalValueMap.get(normalValue.getOrgFlow()+"_"+normalValue.getElementCode());
			if(sexNormalValueMap == null){
				sexNormalValueMap = new HashMap<String, EdcNormalValue>();
			}
			sexNormalValueMap.put(normalValue.getSexId(), normalValue);
			normalValueMap.put(normalValue.getOrgFlow()+"_"+normalValue.getElementCode(), sexNormalValueMap);
		}
		designForm.setNormalValueMap(normalValueMap);
		return designForm;
	}

	@Override
	public EdcModule readEdcModule(String moduleFlow) {
		return moduleMapper.selectByPrimaryKey(moduleFlow);
	}

	@Override
	public void modifyEdcModule(EdcModule module) {
		module.setModuleTypeName(DictTypeEnum.ModuleType.getDictNameById(module.getModuleTypeId()));
		if (StringUtil.isNotBlank(module.getModuleStyleId())) {
			module.setModuleStyleName(ModuleStyleEnum.getNameById(module.getModuleStyleId()));
		}
		GeneralMethod.setRecordInfo(module, false);
		moduleMapper.updateByPrimaryKeySelective(module);
	}

	@Override
	public void modifyEdcElement(EdcElement element) {
		GeneralMethod.setRecordInfo(element, false);
		elementMapper.updateByPrimaryKeySelective(element);
	}

	@Override
	public void modifyEdcAttribute(EdcAttribute attr) {
		GeneralMethod.setRecordInfo(attr, false);
		if(StringUtil.isNotBlank(attr.getDataTypeId())){
			attr.setDataTypeName(AttrDataTypeEnum.getNameById(attr.getDataTypeId()));
		}
		if(StringUtil.isNotBlank(attr.getInputTypeId())){
			attr.setInputTypeName( AttrInputTypeEnum.getNameById(attr.getInputTypeId()));
		}
		attrMapper.updateByPrimaryKeySelective(attr);
	}

	@Override
	public void modifyEdcAttrCode(String attrCode,EdcAttrCode code) {
		EdcAttrCodeExample example = new EdcAttrCodeExample();
		example.createCriteria().andAttrCodeEqualTo(attrCode).andProjFlowEqualTo(code.getProjFlow())
		.andCodeValueEqualTo(code.getCodeValue()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		GeneralMethod.setRecordInfo(code, false);
		codeMapper.updateByExampleSelective(code, example);
	}

	@Override
	public List<EdcElement> searchElementList(EdcElementExample eleExample) {
		return elementMapper.selectByExample(eleExample);
	}

	@Override
	public List<EdcElement> searchLbelements(String projFlow) {
		List<EdcElement> result  = new ArrayList<EdcElement>();
		EdcModuleExample moduleExample = new EdcModuleExample();
		moduleExample.createCriteria().andProjFlowEqualTo(projFlow).andModuleTypeIdEqualTo(GlobalConstant.MODULD_TYPE_LB).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);		
		List<EdcModule> moduleList = moduleMapper.selectByExample(moduleExample);
		if(moduleList!=null){
			for(EdcModule module : moduleList){
				EdcElementExample eleExample = new EdcElementExample();
				eleExample.createCriteria().andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(module.getModuleCode()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				result.addAll(elementMapper.selectByExample(eleExample));
			}
		}
		return result;
	}
	
	@Override
	public EdcElement selElement(String projFlow, String eleVarName) {
		EdcElementExample example = new EdcElementExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andElementVarNameEqualTo(eleVarName).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcElement> list = elementMapper.selectByExample(example);
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
	}
	
	@Override
	public List<EdcAttribute> searchAttrList(String projFlow, String elementCode) {
		EdcAttributeExample	 attrExample = new EdcAttributeExample(); 
		attrExample.createCriteria().andProjFlowEqualTo(projFlow).andElementCodeEqualTo(elementCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		attrExample.setOrderByClause("ORDINAL");
		List<EdcAttribute> attrList = attrMapper.selectByExample(attrExample);
		return attrList;
	}
	
	@Override
	public EdcModule readModuleByShortName(String shortName){
		EdcModuleExample example = new EdcModuleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andModuleShortNameEqualTo(shortName);
		List<EdcModule> moduleList = moduleMapper.selectByExample(example);
		if(moduleList != null && moduleList.size()>0){
			return moduleList.get(0);
		}
		return null;
	}
	
	@Override
	public void modifyEdcVisitModule(EdcVisitModule visitModule) {
		GeneralMethod.setRecordInfo(visitModule, false);
		visitModuleMapper.updateByPrimaryKeySelective(visitModule);
	}
	
	@Override
	public void modifyEdcVisitElement(EdcVisitElement ve) {
		GeneralMethod.setRecordInfo(ve, false);
		visitElementMapper.updateByPrimaryKeySelective(ve);
	}

	@Override
	public EdcVisitElement searchEdcVisitElement(String recordFlow) {
		return visitElementMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public void modifyEdcVisitElementNoSelect(EdcVisitElement ve) {
		GeneralMethod.setRecordInfo(ve, false);
		visitElementMapper.updateByPrimaryKey(ve);
	}
	
	@Override
	public EdcElement readEdcElement(String elementFlow) {
		return elementMapper.selectByPrimaryKey(elementFlow);
	}
	
	@Override
	public void modifyEdcElementNoSelect(EdcElement element) {
		GeneralMethod.setRecordInfo(element, false);
		elementMapper.updateByPrimaryKey(element);
	}
	
	@Override
	public void modifyEdcModuleNoSelect(EdcModule module) {
		module.setModuleTypeName(DictTypeEnum.ModuleType.getDictNameById(module.getModuleTypeId()));
		if (StringUtil.isNotBlank(module.getModuleStyleId())) {
			module.setModuleStyleName(ModuleStyleEnum.getNameById(module.getModuleStyleId()));
		}
		GeneralMethod.setRecordInfo(module, false);
		moduleMapper.updateByPrimaryKey(module);
	}
	
	@Override
	public EdcAttribute readAttribute(String projFlow,String attrCode){
		EdcAttributeExample example = new EdcAttributeExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andAttrCodeEqualTo(attrCode);
		List<EdcAttribute> attrList = attrMapper.selectByExample(example);
		EdcAttribute attr = null;
		if(attrList!=null && attrList.size()>0){
			attr = attrList.get(0);
		}
		return attr;
	}

	//获取attrCode
	@Override
	public List<EdcAttrCode> searchByAttrCode(String projFlow,List<String> attrCodes){
		EdcAttrCodeExample example = new EdcAttrCodeExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andAttrCodeIn(attrCodes);
		example.setOrderByClause("ORDINAL");
		return codeMapper.selectByExample(example);
	}
	
	//EdcInspect
	@Override
	public EdcInspect readInspect(String projFlow,String inspectTypeId){
		EdcInspect inspect = null;
		
		EdcInspectExample example = new EdcInspectExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andInspectTypeIdEqualTo(inspectTypeId).andProjFlowEqualTo(projFlow);
		
		List<EdcInspect> inspectList = inspectMapper.selectByExampleWithBLOBs(example);
		if(inspectList!=null && inspectList.size()>0){
			inspect = inspectList.get(0);
		}else{
			inspect = new EdcInspect();
			inspect.setProjFlow(projFlow);
			inspect.setInspectTypeId(inspectTypeId);
			inspect.setInspectTypeName(InspectTypeEnum.getNameById(inspectTypeId));
			Document document = DocumentHelper.createDocument();
			document.addElement("inspectInfo");
			inspect.setInspectInfo(document.asXML());
			GeneralMethod.setRecordInfo(inspect, true);
			inspectMapper.insertSelective(inspect);
		}
		return inspect;
	}
	
	@Override
	public int editInspect(EdcInspect inspect){
		if(inspect!=null){
			GeneralMethod.setRecordInfo(inspect, false);
			return inspectMapper.updateByPrimaryKeySelective(inspect);
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public EdcInspect createInspectXml(ObservationCfgForm form){
		EdcInspect inspect = readInspect(form.getProjFlow(),form.getInspectTypeId());
		if(form!=null && inspect!=null){
			try {
				Document document = DocumentHelper.parseText(inspect.getInspectInfo());
				Element rootElement = document.getRootElement();
				Element item = (Element)rootElement.selectSingleNode("item[@attrCode='"+form.getAttrCode()+"']");
				if(item!=null){
					item.detach();
				}else{
					item = rootElement.addElement("item");
					item.addAttribute("elementName",form.getElementName());
					item.addAttribute("attrCode",form.getAttrCode());
					item.addAttribute("attrName",form.getAttrName());
					item.addAttribute("isCode",form.getIsCode());
				}
				inspect.setInspectInfo(document.asXML());
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		return inspect;
	}
	
	@Override
	public List<ObservationCfgForm> parseInspectInfo(String inspectInfo){
		List<ObservationCfgForm> selAttrList = null;
		if(StringUtil.isNotBlank(inspectInfo)){
			try {
				Document document = DocumentHelper.parseText(inspectInfo);
				Element rootElement = document.getRootElement();
				if(rootElement!=null){
					List<Element> items = rootElement.elements("item");
					if(items!=null && items.size()>0){
						selAttrList = new ArrayList<ObservationCfgForm>();
						for(Element item : items){
							ObservationCfgForm form = new ObservationCfgForm();
							form.setAttrCode(item.attributeValue("attrCode"));
							form.setAttrName(item.attributeValue("attrName"));
							form.setElementName(item.attributeValue("elementName"));
							form.setIsCode(item.attributeValue("isCode"));
							selAttrList.add(form);
						}
					}
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		return selAttrList;
	}
}  
 