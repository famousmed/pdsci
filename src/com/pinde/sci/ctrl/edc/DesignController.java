package com.pinde.sci.ctrl.edc;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IAttrCodeBiz;
import com.pinde.sci.biz.pub.IAttributeBiz;
import com.pinde.sci.biz.pub.IElementBiz;
import com.pinde.sci.biz.pub.IModuleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EdcAttrCodeMapper;
import com.pinde.sci.enums.edc.InspectTypeEnum;
import com.pinde.sci.form.edc.ObservationCfgForm;
import com.pinde.sci.model.edc.EdcModuleForm;
import com.pinde.sci.model.edc.PubModuleForm;
import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttrCodeExample;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcInspect;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcModuleExample;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitAttrCode;
import com.pinde.sci.model.mo.EdcVisitAttrCodeExample;
import com.pinde.sci.model.mo.EdcVisitAttribute;
import com.pinde.sci.model.mo.EdcVisitAttributeExample;
import com.pinde.sci.model.mo.EdcVisitElement;
import com.pinde.sci.model.mo.EdcVisitElementExample;
import com.pinde.sci.model.mo.EdcVisitModule;
import com.pinde.sci.model.mo.EdcVisitModuleExample;
import com.pinde.sci.model.mo.PubAttrCode;
import com.pinde.sci.model.mo.PubAttribute;
import com.pinde.sci.model.mo.PubElement;
import com.pinde.sci.model.mo.PubModule;
import com.pinde.sci.model.mo.PubModuleExample;
import com.pinde.sci.model.mo.PubProj;

@Controller
@RequestMapping("/edc/design")
public class DesignController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(DesignController.class);
	
	@Autowired
	private IModuleBiz pubModuleBiz; 
	@Autowired
	private IEdcModuleBiz edcModuleBiz; 
	@Resource
	private EdcAttrCodeMapper codeMapper;
	@Autowired
	private IElementBiz pubElementBiz; 
	@Autowired
	private IAttributeBiz pubAttributeBiz; 
	@Autowired
	private IAttrCodeBiz pubAttrCodeBiz; 
	

	@Autowired
	private IVisitBiz visitBiz; 
	
	//已查看模块分类型显示
	@RequestMapping(value={"/queryChooseModuleAndGroupByType"},method={RequestMethod.GET})
	public String queryChooseModuleAndGroupByType(Model model){
		//获取当前EDC项目流水号
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcModuleExample example = new EdcModuleExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		List<EdcModule> edcModuleList = edcModuleBiz.searchModuleList(example);
		
		//Map用于存放分类型显示的List<EdcModule>
		Map<String,List<EdcModule>> edcModuleTypeMap = new HashMap<String, List<EdcModule>>();
		
		for(EdcModule edcModule : edcModuleList){
			//获取类型ID
			String moduleTypeId = edcModule.getModuleTypeId();
			
			//List<EdcModule> items = new ArrayList<EdcModule>();
			//根据typeId添加到对应的的List
			List<EdcModule> items = edcModuleTypeMap.get(moduleTypeId);
			//NullPoint
			if(items == null){
				items = new ArrayList<EdcModule>();
			}
			items.add(edcModule);
			edcModuleTypeMap.put(moduleTypeId, items);
		}
		model.addAttribute("edcModuleMap", edcModuleTypeMap);
		return "edc/module/chooseModuleList";
	}
	
	
	@RequestMapping(value = {"/sdtm" },method={RequestMethod.GET})
	public String sdtm(Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcModuleExample example = new EdcModuleExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcModule> moduleList = edcModuleBiz.searchModuleList(example);
		Map<String,Integer> existModuleMap = new HashMap<String, Integer>();
		for(EdcModule module : moduleList){
			Integer count = existModuleMap.get(module.getModuleTypeId());
			if(count == null){
				count = 0;
			}
			existModuleMap.put(module.getModuleTypeId(), ++count);
		}
		model.addAttribute("existModuleMap", existModuleMap);
		return "edc/module/sdtm";
	}
	@RequestMapping(value = {"/count" },method={RequestMethod.GET})
	@ResponseBody
	public int count(){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		return edcModuleBiz.countModule(projFlow);
	}
	
	@RequestMapping(value = {"/modList" },method={RequestMethod.GET})
	public String modList(String domain, Model model,HttpServletRequest req) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		PubModuleExample example = new PubModuleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andModuleTypeIdEqualTo(domain); 
		example.setOrderByClause("ORDINAL");
		List<PubModule> moduleList = pubModuleBiz.searchModuleList(example);
		model.addAttribute("moduleList",moduleList);
		
		//本试验已选择的module
		EdcModuleExample edcModuleExample = new EdcModuleExample();
		edcModuleExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		List<EdcModule> edcModuleList = edcModuleBiz.searchModuleList(edcModuleExample);
		List<String> existCodeList = new ArrayList<String>();
		for(EdcModule module : edcModuleList){
			existCodeList.add(module.getModuleCode());
		}
		model.addAttribute("existCodeList", existCodeList);
		return "edc/module/list";
	}
	
	
	
	@RequestMapping(value = {"/saveModule" },method={RequestMethod.POST})
	@ResponseBody
	public String saveModule(String[] moduleCode,String domain, Model model,HttpServletRequest req) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		//系统模块库  源
		PubModuleExample example = new PubModuleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andModuleTypeIdEqualTo(domain); 
		List<PubModule> moduleList = pubModuleBiz.searchModuleList(example);
		Map<String,PubModule> moduleMap = new HashMap<String, PubModule>();
		for(PubModule module : moduleList){
			moduleMap.put(module.getModuleCode(), module);
		}
		
		//本试验已选择的module
		EdcModuleExample edcModuleExample = new EdcModuleExample();
		edcModuleExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andModuleTypeIdEqualTo(domain);
		List<EdcModule> edcModuleList = edcModuleBiz.searchModuleList(edcModuleExample);
		List<String> existCodeList = new ArrayList<String>();
		for(EdcModule module : edcModuleList){
			existCodeList.add(module.getModuleCode());
		}
		//
		List<EdcModule> addList = new ArrayList<EdcModule>();
		List<EdcModule> delList = new ArrayList<EdcModule>();
		
		if(moduleCode!=null){
			for(String code : moduleCode){
				if(!existCodeList.contains(code)){
					PubModule module =  moduleMap.get(code); 
					EdcModule targetModule = new EdcModule();
					_copyPropertiesModule(targetModule, module);
					targetModule.setModuleFlow(PkUtil.getUUID());
					targetModule.setProjFlow(projFlow);
					addList.add(targetModule);
				}
			}
			List<String> chooseCode  = Arrays.asList(moduleCode);
			for(EdcModule module : edcModuleList){
				if(!chooseCode.contains(module.getModuleCode())){
					delList.add(module);
				}
			}
		}else {
			for(EdcModule module : edcModuleList){
				delList.add(module);
			}
		}
		
		edcModuleBiz.addOrDelModule(addList,delList);
		
		return GlobalConstant.SAVE_SUCCESSED;
	}

	private void _copyPropertiesModule(EdcModule targetModule, PubModule module) {
		targetModule.setModuleCode(module.getModuleCode());
		targetModule.setModuleName(module.getModuleName());
		targetModule.setModuleTypeId(module.getModuleTypeId());
		targetModule.setModuleTypeName(module.getModuleTypeName());
		targetModule.setOrdinal(module.getOrdinal());
		targetModule.setModuleStyleId(module.getModuleStyleId());
		targetModule.setModuleStyleName(module.getModuleStyleName());
		targetModule.setModuleShortName(module.getModuleShortName());
		targetModule.setModuleSearch(module.getModuleSearch());
	}

	private void _copyPropertiesElement(EdcElement targetElement,PubElement pubEle) {
		targetElement.setElementName(pubEle.getElementName());
		targetElement.setElementCode(pubEle.getElementCode());
		targetElement.setElementVarName(pubEle.getElementVarName());
		targetElement.setModuleCode(pubEle.getModuleCode());
		targetElement.setElementSerial(pubEle.getElementSerial());
		targetElement.setColumnCount(pubEle.getColumnCount());
		targetElement.setOrdinal(pubEle.getOrdinal());
	}
	

	private void _copyPropertiesAttribute(EdcAttribute targetAttr,PubAttribute pubAttr) {
		targetAttr.setAttrName(pubAttr.getAttrName());
		targetAttr.setAttrCode(pubAttr.getAttrCode());
		targetAttr.setAttrVarName(pubAttr.getAttrVarName());
		targetAttr.setModuleCode(pubAttr.getModuleCode());
		targetAttr.setElementCode(pubAttr.getElementCode());
		targetAttr.setElementName(pubAttr.getElementName());
		targetAttr.setDataTypeId(pubAttr.getDataTypeId());
		targetAttr.setDataTypeName(pubAttr.getDataTypeName());
		targetAttr.setDataLength(pubAttr.getDataLength());
		targetAttr.setDataDecimalLength(pubAttr.getDataDecimalLength());
		targetAttr.setInputTypeId(pubAttr.getInputTypeId());
		targetAttr.setInputTypeName(pubAttr.getInputTypeName());
		targetAttr.setIsViewName(pubAttr.getIsViewName());
		targetAttr.setOrdinal(pubAttr.getOrdinal());
	}

	private void _copyPropertiesAttrCode(EdcAttrCode targetAttrCode,PubAttrCode pubAttrCode) {
		targetAttrCode.setCodeValue(pubAttrCode.getCodeValue());
		targetAttrCode.setCodeName(pubAttrCode.getCodeName());
		targetAttrCode.setModuleCode(pubAttrCode.getModuleCode());
		targetAttrCode.setElementCode(pubAttrCode.getElementCode());
		targetAttrCode.setAttrCode(pubAttrCode.getAttrCode());
		targetAttrCode.setOrdinal(pubAttrCode.getOrdinal());
	}
	
	@RequestMapping(value = {"/selEleAttr" },method={RequestMethod.GET})
	public String selEleAttr(String moduleCode, Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		
		EdcModule module = edcModuleBiz.readEdcModule(projFlow,moduleCode); 
		model.addAttribute("edcModule", module);
		
		PubModuleForm pubModuleForm = pubModuleBiz.getModuleForm(module.getModuleCode());
		model.addAttribute("pubModuleForm", pubModuleForm);
		
		//projMoudle\Element\Attribute\AttrCode
		EdcModuleForm edcModuleForm  = edcModuleBiz.getModuleForm(projFlow,moduleCode);
		model.addAttribute("edcModuleForm", edcModuleForm);
		return "edc/element/list";
	}
	
	@RequestMapping(value = {"/saveDesign" },method={RequestMethod.POST})
	@ResponseBody
	public String saveDesign(String moduleCode,String[] elementCode,String[] attrCode,String[] codeValue){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		//element
		List<EdcElement> addEleList = new ArrayList<EdcElement>();
		List<EdcElement> delEleList = new ArrayList<EdcElement>();
		EdcModuleForm edcModuleForm = edcModuleBiz.getModuleForm(projFlow, moduleCode);
		PubModuleForm pubModuleForm  = pubModuleBiz.getModuleForm(moduleCode);
		Map<String,PubElement> elementMap = pubModuleForm.getElementMap();
		for(String eleCode :elementCode){
			if(!edcModuleForm.getElementCodes().contains(eleCode)){
				PubElement pubEle = elementMap.get(eleCode);
				EdcElement targetElement = new EdcElement();
				_copyPropertiesElement(targetElement,pubEle);
				targetElement.setElementFlow(PkUtil.getUUID());
				targetElement.setProjFlow(projFlow); 
				addEleList.add(targetElement);
			}
		}
		List<EdcElement> existElement = edcModuleForm.getElements();
		List<String> chooseEleCode = Arrays.asList(elementCode);
		for(EdcElement element : existElement){
			if(!chooseEleCode.contains(element.getElementCode())){
				delEleList.add(element);
			}
		}
		edcModuleBiz.saveOrUpdateEdcElement(addEleList,delEleList);
		//attr
		List<EdcAttribute> addAttr = new ArrayList<EdcAttribute>();
		List<EdcAttribute> delAttr = new ArrayList<EdcAttribute>();
		Map<String,PubAttribute> attrMap = pubModuleForm.getAttrMap();
		for(String attributeCode :attrCode){
			if(!edcModuleForm.getAttrCodes().contains(attributeCode)){
				PubAttribute pubAttr = attrMap.get(attributeCode);
				EdcAttribute targetAttr = new EdcAttribute();
				_copyPropertiesAttribute(targetAttr,pubAttr);
				targetAttr.setAttrFlow(PkUtil.getUUID());
				targetAttr.setProjFlow(projFlow); 
				addAttr.add(targetAttr);
			} 
		}
		List<EdcAttribute> existAttr = edcModuleForm.getAttrs();
		List<String> chooseAttrCode = Arrays.asList(attrCode);
		for(EdcAttribute attr : existAttr){
			if(!chooseAttrCode.contains(attr.getAttrCode())){
				delAttr.add(attr);
			}
		}
		edcModuleBiz.saveOrUpdateEdcAttr(addAttr,new ArrayList<EdcAttribute>(), delAttr);
		
		//code
		List<EdcAttrCode> addAttrCode  = new ArrayList<EdcAttrCode>();
		List<EdcAttrCode> delAttrCode = new ArrayList<EdcAttrCode>();
		Map<String,PubAttrCode> codeMap = pubModuleForm.getCodeMap();
		if(codeValue!=null){
			for(String key :codeValue){
				if(!edcModuleForm.getCodeValue().contains(key)){
					PubAttrCode pubAttrCode = codeMap.get(key);
					EdcAttrCode targetAttrCode = new EdcAttrCode();
					_copyPropertiesAttrCode(targetAttrCode,pubAttrCode);
					targetAttrCode.setCodeFlow(PkUtil.getUUID());
					targetAttrCode.setProjFlow(projFlow); 
					addAttrCode.add(targetAttrCode);
				} 
			}
			List<EdcAttrCode> existAttrCode = edcModuleForm.getCodes();
			List<String> chooseCodeValue = Arrays.asList(codeValue);
			for(EdcAttrCode code : existAttrCode){
				if(!chooseCodeValue.contains(code.getAttrCode()+"."+code.getCodeValue())){
					delAttrCode.add(code);
				}
			}
			edcModuleBiz.saveOrUpdateEdcAttrCode(addAttrCode,new ArrayList<EdcAttrCode>(), delAttrCode);
		}else {
			edcModuleBiz.delAttrCode(projFlow,moduleCode);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	
	@RequestMapping(value = {"/selVisitModule" },method={RequestMethod.GET})
	@ResponseBody
	public String selVisitModule(String visitFlow,String moduleCode, Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcModule module = edcModuleBiz.readEdcModule(projFlow, moduleCode);
		
		EdcVisitModuleExample example = new EdcVisitModuleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode).andProjFlowEqualTo(projFlow); 
		List<EdcVisitModule> list = visitBiz.searchVisitModule(example);
		if(list == null || list.size()==0){
			//add
			EdcVisitModule vm = new EdcVisitModule();
			vm.setRecordFlow(PkUtil.getUUID());
			vm.setVisitFlow(visitFlow);
			vm.setModuleCode(moduleCode);
			vm.setModuleName(module.getModuleName());
			vm.setProjFlow(projFlow);
			vm.setOrdinal(module.getOrdinal());
			
			//同步添加元素、属性、代码
			EdcModuleForm moduleForm = edcModuleBiz.getModuleForm(projFlow,moduleCode );
			List<EdcElement> elements = moduleForm.getElements();
			List<EdcVisitElement> veList = new ArrayList<EdcVisitElement>();
			for(EdcElement element :elements){
				if(GlobalConstant.RECORD_STATUS_N.equals(element.getRecordStatus())){
					continue;
				}
				EdcVisitElement ve = new EdcVisitElement();
				ve.setRecordFlow(PkUtil.getUUID());
				ve.setVisitFlow(visitFlow);
				ve.setModuleCode(moduleCode);
				ve.setElementCode(element.getElementCode());
				ve.setProjFlow(projFlow);
				ve.setOrdinal(element.getOrdinal());
				veList.add(ve);
			}
			
			List<EdcAttribute> attrs = moduleForm.getAttrs();
			List<EdcVisitAttribute> visitAttrList = new ArrayList<EdcVisitAttribute>();
			for(EdcAttribute attribute :attrs){
				if(GlobalConstant.RECORD_STATUS_N.equals(attribute.getRecordStatus())){
					continue;
				}
				EdcVisitAttribute visitAttr = new EdcVisitAttribute();
				visitAttr.setRecordFlow(PkUtil.getUUID());
				visitAttr.setVisitFlow(visitFlow);
				visitAttr.setModuleCode(moduleCode);
				visitAttr.setElementCode(attribute.getElementCode());
				visitAttr.setAttrCode(attribute.getAttrCode());
				visitAttr.setProjFlow(projFlow);
				visitAttr.setOrdinal(attribute.getOrdinal());
				visitAttrList.add(visitAttr);
			}
			
			List<EdcAttrCode> codes = moduleForm.getCodes();
			List<EdcVisitAttrCode> visitAttrCodeList = new ArrayList<EdcVisitAttrCode>();
			for(EdcAttrCode code :codes){
				if(GlobalConstant.RECORD_STATUS_N.equals(code.getRecordStatus())){
					continue;
				}
				EdcVisitAttrCode visitAttrCode = new EdcVisitAttrCode();
				visitAttrCode.setRecordFlow(PkUtil.getUUID());
				visitAttrCode.setVisitFlow(visitFlow);
				visitAttrCode.setModuleCode(moduleCode);
				visitAttrCode.setElementCode(code.getElementCode());
				visitAttrCode.setAttrCode(code.getAttrCode());
				visitAttrCode.setCodeFlow(code.getCodeFlow());
				visitAttrCode.setProjFlow(projFlow);
				visitAttrCode.setOrdinal(code.getOrdinal());
				visitAttrCodeList.add(visitAttrCode);
			}
			visitBiz.addVisitModule_Element_Attr_Code(vm,veList,visitAttrList,visitAttrCodeList);
			return GlobalConstant.SAVE_SUCCESSED;
		}else {
			//del
			//visitBiz.delVisitModule(list.get(0));
			//同步废止元素、属性
			visitBiz.delVisitEleAttrCode(list.get(0),projFlow,visitFlow,moduleCode);
			return GlobalConstant.DELETE_SUCCESSED;
		}
		
	}
	
	@RequestMapping(value = {"/seleVisitEleAttr" },method={RequestMethod.GET})
	public String seleVisitEleAttr(String visitFlow,String moduleCode,Model model){
//		EdcModule module = edcModuleBiz.readEdcModule(projFlow, moduleCode);
//		EdcModuleForm moduleForm = edcModuleBiz.getModuleForm(projFlow, moduleCode); 
//		model.addAttribute("module", module);
//		model.addAttribute("moduleForm", moduleForm);
		
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		model.addAttribute("visit", visit);
		
		PubModuleForm pubModuleForm = pubModuleBiz.getModuleForm(moduleCode);
		model.addAttribute("pubModuleForm", pubModuleForm);
		
		//模块
		EdcVisitModule visitModule = visitBiz.searchVisitModule(visitFlow, moduleCode);
		model.addAttribute("visitModule", visitModule);
		
		//元素
		EdcVisitElementExample example = new EdcVisitElementExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode);
		List<EdcVisitElement> veList = visitBiz.searchVisitElement(example);
		List<String> visitEleCodes = new ArrayList<String>();
		Map<String,EdcVisitElement> visitElementMap = new HashMap<String,EdcVisitElement>();
		for(EdcVisitElement visitEle :veList){
			visitEleCodes.add(visitEle.getElementCode());
			visitElementMap.put(visitEle.getElementCode(), visitEle);
		}
		model.addAttribute("visitEleCodes", visitEleCodes);
		model.addAttribute("visitElementMap", visitElementMap);
		//属性
		EdcVisitAttributeExample attrExample = new EdcVisitAttributeExample();
		attrExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode);
		List<EdcVisitAttribute> vaList = visitBiz.searchVisitAttribute(attrExample);
		List<String> visitAttrCodes = new ArrayList<String>();
		for(EdcVisitAttribute visitAttr :vaList){
			visitAttrCodes.add(visitAttr.getAttrCode());
		}
		model.addAttribute("visitAttrCodes", visitAttrCodes);
		//代码
		EdcAttrCodeExample attrCodeExample = new EdcAttrCodeExample(); 
		attrCodeExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andModuleCodeEqualTo(moduleCode);
		List<EdcAttrCode> codeList = codeMapper.selectByExample(attrCodeExample);
		Map<String,String> codeFlowMap = new HashMap<String, String>();
		for(EdcAttrCode ec : codeList){
			codeFlowMap.put(ec.getCodeFlow(), ec.getAttrCode()+"."+ec.getCodeValue());
		}
		
		EdcVisitAttrCodeExample exam = new EdcVisitAttrCodeExample();
		exam.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode);
		List<EdcVisitAttrCode> visitAttrCodeList = visitBiz.searchVisitAttrCode(exam);
		List<String> visitCodeKeys = new ArrayList<String>();
		for(EdcVisitAttrCode vc : visitAttrCodeList){
			visitCodeKeys.add(codeFlowMap.get(vc.getCodeFlow()));
		}
		model.addAttribute("visitCodeKeys", visitCodeKeys);
		
		EdcModuleForm edcModuleForm = edcModuleBiz.getModuleForm(projFlow, moduleCode);
		model.addAttribute("edcModuleForm", edcModuleForm);
		
		//访视模块
		EdcVisitModuleExample vmExample = new EdcVisitModuleExample();
		vmExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andVisitFlowEqualTo(visitFlow).andModuleCodeNotEqualTo(moduleCode);
		List<EdcVisitModule> vmList = visitBiz.searchVisitModule(vmExample);
		List<EdcModule> moduleList = new ArrayList<EdcModule>();
		if (vmList != null && vmList.size() >0) {
			for (EdcVisitModule module:vmList) {
				moduleList.add(edcModuleBiz.readEdcModule(projFlow, module.getModuleCode()));
			}
		}
		model.addAttribute("moduleList", moduleList);
		
		return "edc/visit/attr";
	}
	
	@RequestMapping(value = {"/saveVisitDesign" },method={RequestMethod.POST})
	@ResponseBody
	public String saveVisitDesign(String moduleCode,String visitFlow,String[] elementCode,String[] attrCode){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcModuleForm moduleForm = edcModuleBiz.getModuleForm(projFlow, moduleCode);
		Map<String ,EdcElement> eleMap = moduleForm.getElementMap();
		//element
		List<EdcVisitElement> addEleList = new ArrayList<EdcVisitElement>();
		List<EdcVisitElement> delEleList = new ArrayList<EdcVisitElement>();
		
		EdcVisitElementExample example = new EdcVisitElementExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode);
		List<EdcVisitElement> veList = visitBiz.searchVisitElement(example);
		List<String> visitEleCodes = new ArrayList<String>();
		for(EdcVisitElement visitEle :veList){
			visitEleCodes.add(visitEle.getElementCode());
		}
		EdcElement ele  = null;
		for(String eleCode :elementCode){
			if(!visitEleCodes.contains(eleCode)){
				EdcVisitElement targetElement = new EdcVisitElement();
				targetElement.setRecordFlow(PkUtil.getUUID());
				targetElement.setVisitFlow(visitFlow);
				targetElement.setModuleCode(moduleCode);
				targetElement.setElementCode(eleCode);
				targetElement.setProjFlow(projFlow); 
				ele = eleMap.get(eleCode);
				if(ele != null){
					targetElement.setOrdinal(ele.getOrdinal());
				}
				addEleList.add(targetElement);
			}
		}
		List<String> chooseEleCode = Arrays.asList(elementCode);
		for(EdcVisitElement visitEle : veList){
			if(!chooseEleCode.contains(visitEle.getElementCode())){
				delEleList.add(visitEle);
			}
		}
		//attr
		List<EdcVisitAttribute> addAttrList = new ArrayList<EdcVisitAttribute>();
		List<EdcVisitAttribute> delAttrList = new ArrayList<EdcVisitAttribute>();
		
		EdcVisitAttributeExample attrExample = new EdcVisitAttributeExample();
		attrExample.createCriteria().andProjFlowEqualTo(projFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode);
		List<EdcVisitAttribute> vaList = visitBiz.searchVisitAttribute(attrExample);
		List<String> visitAttrCodes = new ArrayList<String>();
		for(EdcVisitAttribute visitAttr :vaList){
			visitAttrCodes.add(visitAttr.getAttrCode());
		}
		
		for(String attributeCode :attrCode){
			if(!visitAttrCodes.contains(attributeCode)){
				EdcVisitAttribute targetAttr = new EdcVisitAttribute();
				targetAttr.setRecordFlow(PkUtil.getUUID());
				targetAttr.setVisitFlow(visitFlow);
				targetAttr.setModuleCode(moduleCode);
				ele = eleMap.get(attributeCode);
				if(ele != null){
					targetAttr.setElementCode(ele.getElementCode());
					targetAttr.setOrdinal(ele.getOrdinal());
				}
				targetAttr.setAttrCode(attributeCode);
				targetAttr.setProjFlow(projFlow);
				addAttrList.add(targetAttr);
			} 
		}
		List<String> chooseAttrCode = Arrays.asList(attrCode);
		for(EdcVisitAttribute attr : vaList){
			if(!chooseAttrCode.contains(attr.getAttrCode())){
				delAttrList.add(attr);
			}
		}
		visitBiz.saveOrUpdateEdcElementAttr(addEleList,delEleList,addAttrList, delAttrList);
		
		return GlobalConstant.SAVE_SUCCESSED;
	}
	@RequestMapping(value = {"/saveModuleSingle" },method={RequestMethod.GET})
	@ResponseBody
	public String saveModuleSingle(String moduleCode,String actionFlag){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcModule module = edcModuleBiz.readEdcModule(projFlow, moduleCode);
		if(GlobalConstant.FLAG_Y.equals(actionFlag)){ 
			if(module == null ){
				PubModule sourceModule =  pubModuleBiz.readPubModuleByCode(moduleCode);
				EdcModule targetModule = new EdcModule();
				_copyPropertiesModule(targetModule, sourceModule);
				targetModule.setModuleFlow(PkUtil.getUUID());
				targetModule.setProjFlow(projFlow);
				edcModuleBiz.addEdcModule(targetModule);
			}else {
				edcModuleBiz.onOffEdcModule(module,GlobalConstant.RECORD_STATUS_Y);
			}
		}else {
			edcModuleBiz.onOffEdcModule(module,GlobalConstant.RECORD_STATUS_N);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/searchModule" },method={RequestMethod.POST})
	public String searchModule(String searchName,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		List<PubModule> moduleList = pubModuleBiz.moduleSearch("%"+searchName+"%");
		model.addAttribute("moduleList",moduleList);
		
		//本试验已选择的module
		EdcModuleExample edcModuleExample = new EdcModuleExample();
		edcModuleExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		List<EdcModule> edcModuleList = edcModuleBiz.searchModuleList(edcModuleExample);
		List<String> existCodeList = new ArrayList<String>();
		for(EdcModule module : edcModuleList){
			existCodeList.add(module.getModuleCode());
		}
		model.addAttribute("existCodeList", existCodeList);
		return "edc/module/list";
	}
	
	@RequestMapping(value = {"/saveVisitDesignSingle" },method={RequestMethod.POST})
	@ResponseBody
	public synchronized String saveVisitDesignSingle(String moduleCode,String visitFlow,String oprateEleCode,String elementCode,String[] attrCode,String[] codeValue){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		String recordFlow = "";//新增元素的EdcVisitElement的流水号
		
		PubModuleForm pubModuleForm = pubModuleBiz.getModuleForm(moduleCode);
		EdcModuleForm edcModuleForm = edcModuleBiz.getModuleForm(projFlow, moduleCode);
		
		EdcVisitElement visitElement = visitBiz.readVisitElement(projFlow,visitFlow,moduleCode,oprateEleCode);
		EdcElement element = edcModuleForm.getElementMap().get(oprateEleCode);
		
		EdcAttrCodeExample attrCodeExample = new EdcAttrCodeExample(); 
		attrCodeExample.createCriteria().andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode).andElementCodeEqualTo(oprateEleCode);
		List<EdcAttrCode> codeList = codeMapper.selectByExample(attrCodeExample);
		Map<String,String> codeFlowMap = new HashMap<String, String>();
		Map<String,String> codeFlowKeyMap = new HashMap<String, String>();
		for(EdcAttrCode ec : codeList){
			codeFlowMap.put(ec.getCodeFlow(), ec.getAttrCode()+"."+ec.getCodeValue());
			codeFlowKeyMap.put(ec.getAttrCode()+"."+ec.getCodeValue(),ec.getCodeFlow());
		}
		if(StringUtil.isBlank(elementCode)){ //废止页面元素
			if(visitElement != null){
				//废止元素
				visitBiz.onOffVisitElement(visitElement,GlobalConstant.RECORD_STATUS_N);
				//废止属性
				visitBiz.delVisitEleAttr(projFlow, visitFlow, moduleCode,oprateEleCode);
				//废止代码
				visitBiz.delVisitEleAttrCode(projFlow, visitFlow, moduleCode,oprateEleCode);
			}
		}else { //新增
			if(visitElement == null){
				visitElement = new EdcVisitElement();
				visitElement.setRecordFlow(PkUtil.getUUID());
				visitElement.setVisitFlow(visitFlow);
				visitElement.setModuleCode(moduleCode);
				visitElement.setElementCode(oprateEleCode);
				visitElement.setProjFlow(projFlow);
				//排序码
				if (element != null) {
					visitElement.setOrdinal(element.getOrdinal());
				}
				visitBiz.addVisitElement(visitElement);
			}
			
			recordFlow = visitElement.getRecordFlow();
			//新增属性
			EdcVisitAttributeExample example = new EdcVisitAttributeExample();
			example.createCriteria().andProjFlowEqualTo(projFlow).andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode).andElementCodeEqualTo(elementCode)
			.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			List<EdcVisitAttribute> visitAttrList = visitBiz.searchVisitAttribute(example);
			Map<String,EdcVisitAttribute> visitAttrMap = new HashMap<String, EdcVisitAttribute>();
			for(EdcVisitAttribute ve : visitAttrList){
				visitAttrMap.put(ve.getAttrCode(), ve);
			}
			if(attrCode!=null){
				List<EdcVisitAttribute> addVisitAttrList = new ArrayList<EdcVisitAttribute>();
				List<EdcVisitAttribute> modVisitAttrList = new ArrayList<EdcVisitAttribute>();
				List<EdcVisitAttribute> delVisitAttrList = new ArrayList<EdcVisitAttribute>(); 
				//新增属性
				for(String code : attrCode){
					if(!visitAttrMap.containsKey(code)){
						EdcVisitAttribute targetAttr = new EdcVisitAttribute();
						targetAttr.setRecordFlow(PkUtil.getUUID());
						targetAttr.setVisitFlow(visitFlow);
						targetAttr.setModuleCode(moduleCode);
						targetAttr.setElementCode(elementCode);
						targetAttr.setAttrCode(code);
						targetAttr.setProjFlow(projFlow);
						addVisitAttrList.add(targetAttr);
					}
				}
				//废止未选择的属性
				List<String> attrCodeList = Arrays.asList(attrCode);
				for(EdcVisitAttribute ve : visitAttrList){
					if(!attrCodeList.contains(ve.getAttrCode())){
						delVisitAttrList.add(ve);
					}
				}
				visitBiz.saveVisitAttr(addVisitAttrList, modVisitAttrList, delVisitAttrList);
			}else {
				//废止属性
				visitBiz.delVisitEleAttr(projFlow, visitFlow, moduleCode,elementCode);
			}
			
			//新增代码
			EdcVisitAttrCodeExample exam = new EdcVisitAttrCodeExample();
			exam.createCriteria().andProjFlowEqualTo(projFlow).andVisitFlowEqualTo(visitFlow).andModuleCodeEqualTo(moduleCode).andElementCodeEqualTo(elementCode)
			.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			List<EdcVisitAttrCode> visitAttrCodeList = visitBiz.searchVisitAttrCode(exam);
			Map<String,EdcVisitAttrCode> visitAttrCodeMap = new HashMap<String, EdcVisitAttrCode>();
			for(EdcVisitAttrCode vc : visitAttrCodeList){
				visitAttrCodeMap.put(codeFlowMap.get(vc.getCodeFlow()), vc);
			}
			if(codeValue!=null){
				List<EdcVisitAttrCode> addVisitAttrCode  = new ArrayList<EdcVisitAttrCode>();
				List<EdcVisitAttrCode> modVisitAttrCode  = new ArrayList<EdcVisitAttrCode>();
				List<EdcVisitAttrCode> delVisitAttrCode = new ArrayList<EdcVisitAttrCode>();
				//新增
				for(String key :codeValue){
					String codeKey = key.replace(".", ",");
					String attrcode = codeKey.split(",")[0];
					if(!visitAttrCodeMap.containsKey(key)){
						String codeFlow = "";
						int ordinal = 0;
						if (!codeFlowKeyMap.containsKey(key)) {
							codeFlow = PkUtil.getUUID();
							codeFlowMap.put(codeFlow, key);
							codeFlowKeyMap.put(key, codeFlow);
							PubAttrCode pubAttrCode = pubModuleForm.getCodeMap().get(key);
							if (pubAttrCode != null && pubAttrCode.getOrdinal() != null) {
								ordinal = pubAttrCode.getOrdinal();
							}
						} else {
							codeFlow = codeFlowKeyMap.get(key);
							EdcAttrCode edcAttrCode = edcModuleForm.getCodeMap().get(key);
							if (edcAttrCode != null && edcAttrCode.getOrdinal() != null) {
								ordinal = edcAttrCode.getOrdinal();
							}
						}
						EdcVisitAttrCode targetAttrCode = new EdcVisitAttrCode();
						targetAttrCode.setRecordFlow(PkUtil.getUUID());
						targetAttrCode.setVisitFlow(visitFlow);
						targetAttrCode.setModuleCode(moduleCode);
						targetAttrCode.setElementCode(elementCode);
						targetAttrCode.setAttrCode(attrcode);
						targetAttrCode.setCodeFlow(codeFlow);
						targetAttrCode.setOrdinal(ordinal);
						targetAttrCode.setProjFlow(projFlow);
						addVisitAttrCode.add(targetAttrCode);
					}
				}
				//废止未选择的代码
				List<String> codeValueList = Arrays.asList(codeValue);
				for(EdcVisitAttrCode vc : visitAttrCodeList){
					if(!codeValueList.contains(codeFlowMap.get(vc.getCodeFlow()))){
						delVisitAttrCode.add(vc);
					}
				}
				visitBiz.saveVisitAttrCode(addVisitAttrCode, modVisitAttrCode, delVisitAttrCode);
			} else {
				//废止代码
				visitBiz.delVisitEleAttrCode(projFlow, visitFlow, moduleCode,elementCode);
			}
		}
		
		//统一处理项目库,集中所有访视处理
		//元素
		EdcVisitElementExample example = new EdcVisitElementExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode).andElementCodeEqualTo(oprateEleCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcVisitElement> visitElementList = visitBiz.searchVisitElement(example);
		if(visitElementList!=null && visitElementList.size()>0){
			//新增项目库
			if(element == null){
				PubElement pubEle = pubModuleForm.getElementMap().get(oprateEleCode);
				EdcElement targetElement = new EdcElement();
				_copyPropertiesElement(targetElement,pubEle);
				targetElement.setElementFlow(PkUtil.getUUID());
				targetElement.setProjFlow(projFlow); 
				edcModuleBiz.addElement(targetElement);
			}
		} else {
			//废止项目库
			if(element != null && GlobalConstant.RECORD_STATUS_Y.equals(element.getRecordStatus()) ){
				edcModuleBiz.onOffEdcElement(element,GlobalConstant.RECORD_STATUS_N);
			}
		}
		//属性
		EdcVisitAttributeExample attrExample = new EdcVisitAttributeExample();
		attrExample.createCriteria().andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode).andElementCodeEqualTo(oprateEleCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcVisitAttribute> visitAttrList = visitBiz.searchVisitAttribute(attrExample);
		List<String> visitAttrCodes = new ArrayList<String>();
		for(EdcVisitAttribute attr : visitAttrList){
			visitAttrCodes.add(attr.getAttrCode());
		}
		List<EdcAttribute> edcAttrList = edcModuleForm.getEleAttrMap().get(oprateEleCode);
		Map<String,EdcAttribute> edcAttrMap = edcModuleForm.getAttrMap(); 
		List<EdcAttribute> addEdcAttrList = new ArrayList<EdcAttribute>();
		List<EdcAttribute> modEdcAttrList = new ArrayList<EdcAttribute>();
		List<EdcAttribute> delEdcAttrList = new ArrayList<EdcAttribute>();
		for(String visitAttrCode : visitAttrCodes){
			if(!edcAttrMap.containsKey(visitAttrCode)){
				//新增项目库
				PubAttribute pubAttr = pubModuleForm.getAttrMap().get(visitAttrCode);
				EdcAttribute targetAttr = new EdcAttribute();
				_copyPropertiesAttribute(targetAttr,pubAttr);
				targetAttr.setAttrFlow(PkUtil.getUUID());
				targetAttr.setProjFlow(projFlow); 
				addEdcAttrList.add(targetAttr);
			}
		}
		if(edcAttrList!=null){
			for(EdcAttribute attr: edcAttrList){
				if(!visitAttrCodes.contains(attr.getAttrCode())){
					//废止项目库
					delEdcAttrList.add(attr);
				}
			}
		}
		edcModuleBiz.saveOrUpdateEdcAttr(addEdcAttrList,modEdcAttrList, delEdcAttrList);
		//代码
		EdcVisitAttrCodeExample exam = new EdcVisitAttrCodeExample();
		exam.createCriteria().andProjFlowEqualTo(projFlow).andModuleCodeEqualTo(moduleCode).andElementCodeEqualTo(oprateEleCode)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcVisitAttrCode> visitAttrCodeList = visitBiz.searchVisitAttrCode(exam);
		List<String> visitCodeFlows = new ArrayList<String>();
		for(EdcVisitAttrCode vc : visitAttrCodeList){
			visitCodeFlows.add(vc.getCodeFlow());
		}
		Map<String,EdcAttrCode> edcAttrCodeMap = edcModuleForm.getCodeMap(); 
		List<EdcAttrCode> addAttrCode  = new ArrayList<EdcAttrCode>();
		List<EdcAttrCode> modAttrCode  = new ArrayList<EdcAttrCode>();
		List<EdcAttrCode> delAttrCode = new ArrayList<EdcAttrCode>();
		
		for(String visitCodeFlow : visitCodeFlows){
			String key = codeFlowMap.get(visitCodeFlow);
			//因为edcAttrCode没有code，所以还是保留启用功能
			if(!edcAttrCodeMap.containsKey(key)){
				//新增项目库
				PubAttrCode pubAttrCode = pubModuleForm.getCodeMap().get(key);
				EdcAttrCode targetAttrCode = new EdcAttrCode();
				_copyPropertiesAttrCode(targetAttrCode,pubAttrCode);
				targetAttrCode.setCodeFlow(visitCodeFlow);
				targetAttrCode.setProjFlow(projFlow); 
				addAttrCode.add(targetAttrCode);
			}else if(edcAttrCodeMap.containsKey(key) && GlobalConstant.RECORD_STATUS_N.equals(edcAttrCodeMap.get(key).getRecordStatus())){
				//启用项目库
				modAttrCode.add(edcAttrCodeMap.get(key));
			}
		}
		if(edcAttrList!=null){
			for(EdcAttribute attr: edcAttrList){
				List<EdcAttrCode> edcAttrCodeList = edcModuleForm.getAttrCodeMap().get(attr.getAttrCode());
				if (edcAttrCodeList != null) {
					for (EdcAttrCode edcAttrCode: edcAttrCodeList) {
						if(!visitCodeFlows.contains(edcAttrCode.getCodeFlow())){
							//废止项目库
							delAttrCode.add(edcAttrCode);
						}
					}
				}
			}
		}
		edcModuleBiz.saveOrUpdateEdcAttrCode(addAttrCode,modAttrCode, delAttrCode);
		
		return recordFlow;
	}
	
	@RequestMapping(value = {"/designManage" },method={RequestMethod.GET})
	public String designManage(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<EdcModule> moduleList = edcModuleBiz.searchModuleList(projFlow); 
		model.addAttribute("moduleList", moduleList);
		
		List<EdcElement> elementList = edcModuleBiz.searchElementList(projFlow);
		Map<String,List<EdcElement>> elementMap = new HashMap<String, List<EdcElement>>();
		for(EdcElement element : elementList){
			List<EdcElement> temp = elementMap.get(element.getModuleCode());
			if(temp == null){
				temp = new ArrayList<EdcElement>();
			}
			temp.add(element);
			elementMap.put(element.getModuleCode(), temp);
		}
		model.addAttribute("elementMap", elementMap);
		
		
		List<EdcAttribute>  attribute = edcModuleBiz.searchAttributeList(projFlow);
		Map<String,List<EdcAttribute>> attrMap = new HashMap<String, List<EdcAttribute>>();
		for(EdcAttribute attr : attribute){
			List<EdcAttribute> temp = attrMap.get(attr.getElementCode());
			if(temp == null){
				temp = new ArrayList<EdcAttribute>();
			}
			temp.add(attr);
			attrMap.put(attr.getElementCode(), temp);
		}
		model.addAttribute("attrMap", attrMap);
		
		List<EdcAttrCode>  codeList = edcModuleBiz.searchCodeList(projFlow);
		Map<String,List<EdcAttrCode>> codeMap = new HashMap<String, List<EdcAttrCode>>();
		for(EdcAttrCode code : codeList){
			List<EdcAttrCode> temp = codeMap.get(code.getAttrCode());
			if(temp == null){
				temp = new ArrayList<EdcAttrCode>();
			}
			temp.add(code);
			codeMap.put(code.getAttrCode(), temp);
		}
		model.addAttribute("codeMap", codeMap);
		
		return "edc/module/design";
	}
	
	@RequestMapping(value = {"/saveEdcModule" },method={RequestMethod.POST})
	@ResponseBody
	public String saveEdcModule(String type,EdcModule module){
		if ("noSelect".equals(type) && module.getOrdinal() == null) {	//排序码置为空
			EdcModule edcModule = edcModuleBiz.readEdcModule(module.getModuleFlow());
			edcModule.setOrdinal(null);
			edcModuleBiz.modifyEdcModuleNoSelect(edcModule);
		} else {
			edcModuleBiz.modifyEdcModule(module);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	} 
	@RequestMapping(value = {"/modElementName" },method={RequestMethod.POST})
	@ResponseBody
	public String modElementName(String type,EdcElement element){
		if ("noSelect".equals(type) && element.getOrdinal() == null) {	//排序码置为空
			EdcElement ele = edcModuleBiz.readEdcElement(element.getElementFlow());
			ele.setOrdinal(null);
			edcModuleBiz.modifyEdcElementNoSelect(element);
		} else {
			edcModuleBiz.modifyEdcElement(element);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	@RequestMapping(value = {"/modAttr" },method={RequestMethod.POST})
	@ResponseBody
	public String modAttr(EdcAttribute attr){
		edcModuleBiz.modifyEdcAttribute(attr);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/modCodeValue" },method={RequestMethod.POST})
	@ResponseBody
	public String modCodeValue(String attrCode,EdcAttrCode code){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		code.setProjFlow(projFlow);
		edcModuleBiz.modifyEdcAttrCode(attrCode,code);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/modVisitModuleName" },method={RequestMethod.POST})
	@ResponseBody
	public String modVisitModuleName(EdcVisitModule  module){
		edcModuleBiz.modifyEdcVisitModule(module);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/modVisitElement" },method={RequestMethod.POST})
	@ResponseBody
	public String modVisitElement(String type,EdcVisitElement ve){
		if ("noSelect".equals(type) && ve.getOrdinal() == null) {	//排序码置为空
			EdcVisitElement element = edcModuleBiz.searchEdcVisitElement(ve.getRecordFlow());
			element.setOrdinal(null);
			edcModuleBiz.modifyEdcVisitElementNoSelect(element);
		} else {
			edcModuleBiz.modifyEdcVisitElement(ve);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * TODO 观测指标设计
	 * */
	@RequestMapping(value = {"/observationCfg" },method={RequestMethod.GET})
	public String observationDesign(String moduleCode,String viewAllIndex,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(proj!=null){
			String projFlow = proj.getProjFlow();
			
			EdcInspect inspect = edcModuleBiz.readInspect(projFlow,InspectTypeEnum.Observation.getId());
			if(inspect!=null){
				List<ObservationCfgForm> formList = edcModuleBiz.parseInspectInfo(inspect.getInspectInfo());
				if(formList!=null && formList.size()>0){
					Map<String,ObservationCfgForm> observationCfgFormMap = new HashMap<String, ObservationCfgForm>();
					for(ObservationCfgForm form : formList){
						observationCfgFormMap.put(form.getAttrCode(),form);
					}
					model.addAttribute("observationCfgFormMap", observationCfgFormMap);
				}
			}
			
			List<EdcModule> moduleList = edcModuleBiz.searchModuleList(projFlow);
			model.addAttribute("moduleList", moduleList);
			
			if(moduleList!=null && moduleList.size()>0){
				List<EdcModule> singleModuleList = null;
				if(StringUtil.isNotBlank(moduleCode)){
					for(EdcModule module : moduleList){
						if(module.getModuleCode().equals(moduleCode)){
							singleModuleList = new ArrayList<EdcModule>();
							singleModuleList.add(module);
							break;
						}
					}
					model.addAttribute("singleModuleList", singleModuleList);
				}
				
				List<String> moduleCodes = new ArrayList<String>();
				for(EdcModule module : (singleModuleList==null)?moduleList:singleModuleList){
					moduleCodes.add(module.getModuleCode());
				}
				if(moduleCodes.size()>0){
					List<EdcElement> elementList = edcModuleBiz.searchElementList(projFlow,moduleCodes);
					if(elementList!=null && elementList.size()>0){
						Map<String,List<EdcElement>> elementMap = new HashMap<String,List<EdcElement>>();
						for(EdcElement element : elementList){
							if(elementMap.get(element.getModuleCode())==null){
								List<EdcElement> elementTempList = new ArrayList<EdcElement>();
								elementTempList.add(element);
								elementMap.put(element.getModuleCode(),elementTempList);
							}else{
								elementMap.get(element.getModuleCode()).add(element);
							}
						}
						model.addAttribute("elementMap", elementMap);
						
						List<EdcAttribute> attrList = edcModuleBiz.searchAttrList(projFlow,moduleCodes);
						if(attrList!=null && attrList.size()>0){
							Map<String,List<EdcAttribute>> attrMap = new HashMap<String,List<EdcAttribute>>();
							List<String> attrCodes = new ArrayList<String>();
							for(EdcAttribute attr : attrList){
								if(!attrCodes.contains(attr.getAttrCode())){
									attrCodes.add(attr.getAttrCode());
								}
								if(attrMap.get(attr.getElementCode())==null){
									List<EdcAttribute> attrTempList = new ArrayList<EdcAttribute>();
									attrTempList.add(attr);
									attrMap.put(attr.getElementCode(),attrTempList);
								}else{
									attrMap.get(attr.getElementCode()).add(attr);
								}
							}
							model.addAttribute("attrMap", attrMap);
							
							List<EdcAttrCode> codeList = edcModuleBiz.searchByAttrCode(projFlow,attrCodes);
							if(codeList!=null && codeList.size()>0){
								Map<String,EdcAttrCode> codeMap = new HashMap<String, EdcAttrCode>();
								for(EdcAttrCode code : codeList){
									if(codeMap.get(code.getAttrCode())==null){
										codeMap.put(code.getAttrCode(),code);
									}
								}
								model.addAttribute("codeMap", codeMap);
							}
						}
					}
				}
			}
		}
		return "edc/inspectCfg/observationCfg";
	}
	
	@RequestMapping(value = {"/saveInspectInfo" },method={RequestMethod.POST})
	@ResponseBody
	public String saveInspectInfo(ObservationCfgForm form){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(form!=null && proj!=null){
			form.setProjFlow(proj.getProjFlow());
			form.setInspectTypeId(InspectTypeEnum.Observation.getId());
			EdcInspect inspect = edcModuleBiz.createInspectXml(form);
			if(inspect!=null && edcModuleBiz.editInspect(inspect)!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
}

