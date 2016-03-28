package com.pinde.sci.ctrl.pub;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
import com.pinde.sci.dao.base.EdcAttributeMapper;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.form.edc.EdcVisitForm;
import com.pinde.sci.model.edc.PubModuleForm;
import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttrCodeExample;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcAttributeExample;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcElementExample;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcModuleExample;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitExample;
import com.pinde.sci.model.mo.EdcVisitModule;
import com.pinde.sci.model.mo.EdcVisitModuleExample;
import com.pinde.sci.model.mo.PubAttrCode;
import com.pinde.sci.model.mo.PubAttribute;
import com.pinde.sci.model.mo.PubAttributeExample;
import com.pinde.sci.model.mo.PubElement;
import com.pinde.sci.model.mo.PubElementExample;
import com.pinde.sci.model.mo.PubModule;
import com.pinde.sci.model.mo.PubModuleExample;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.pub.PubAttributeAndCode;

@Controller
@RequestMapping("/pub/module")
public class ModuleController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(ModuleController.class);
	
	@Autowired
	private IModuleBiz pubModuleBiz; 
	@Autowired
	private IElementBiz pubElementBiz; 
	@Autowired
	private IAttributeBiz pubAttributeBiz; 
	@Autowired
	private IAttrCodeBiz pubAttrCodeBiz; 
	@Autowired
	private IEdcModuleBiz moduleBiz;
	@Resource
	private EdcAttributeMapper attrMapper;
	@Resource
	private EdcAttrCodeMapper attrCodeMapper;
	@Autowired
	private IVisitBiz visitBiz;
	@Resource
	private PubProjMapper projMapper;
	
	@RequestMapping(value = {"/addModule" })
	public String addModule(String moduleTypeId, Model model){
		PubModule pubModule = new PubModule();
		pubModule.setModuleTypeId(moduleTypeId);
	//	pubModule.setModuleName(DictTypeEnum.ModuleType.getDictNameById(moduleTypeId));
		model.addAttribute( "pubModule", pubModule);
		model.addAttribute( "type", "add");
		return "/pub/module/edit";
	}
	
	@RequestMapping(value = {"/saveModule"} ,method={RequestMethod.POST})
	@ResponseBody
	public String saveModule(PubModule pm){
		if(StringUtil.isBlank(pm.getModuleFlow())){
			pubModuleBiz.addPubModule(pm);
		}else {
			pubModuleBiz.updatePubModule(pm);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value={"/getModuleByFlow"}, method={RequestMethod.GET})
	public String getModuleByFlow(String moduleFlow,Model model){
		PubModule pubModule = pubModuleBiz.readPubModule(moduleFlow);
		model.addAttribute("pubModule",pubModule);
		return "/pub/module/edit";
	}
	
	@RequestMapping(value = {"/list" },method={RequestMethod.POST,RequestMethod.GET})
	public String list( Model model) {
		PubModuleExample example = new PubModuleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		List<PubModule> moduleList = pubModuleBiz.searchModuleList(example);
		
		Map<String,List<PubModule>>  moduleMap = new HashMap<String, List<PubModule>>();
		for(PubModule module : moduleList){
			List<PubModule> temp = moduleMap.get(module.getModuleTypeId());
			if(temp == null){
				temp = new ArrayList<PubModule>();
			}
			temp.add(module);
			moduleMap.put(module.getModuleTypeId(), temp);
		}
		model.addAttribute("moduleMap",moduleMap);
		
		return "pub/module/list";
	}
	@RequestMapping(value = {"/modList" },method={RequestMethod.GET})
	public String modList(String domain, Model model) {
		List<PubModule> moduleList = pubModuleBiz.searchModuleListByDomain(domain);
		model.addAttribute("moduleList", moduleList);
		return "pub/module/modulelist_block";
	}
	
	
	
	@RequestMapping(value = {"/show" },method={RequestMethod.POST,RequestMethod.GET})
	public String show(String moduleCode, Model model) {
		PubModule module = pubModuleBiz.readPubModuleByCode(moduleCode);
		model.addAttribute("currModule",module);
		
		List<PubModule> moduleList = pubModuleBiz.searchModuleListByDomain(module.getModuleTypeId());
		model.addAttribute("moduleList", moduleList);
		
		List<PubElement> elementList = pubElementBiz.searchElementList(moduleCode);
		model.addAttribute("elementList",elementList);
		return "pub/element/list";
	}
	
	@RequestMapping(value = {"/showAttr" },method={RequestMethod.POST,RequestMethod.GET})
	public String showAttr(String moduleCode ,String elementCode,Model model){
		PubElement element = pubElementBiz.readPubElementByCode(elementCode);
		model.addAttribute("element",element);
		List<PubAttribute> attrList = pubAttributeBiz.searchAttributeList(moduleCode, elementCode);
		model.addAttribute("attrList",attrList);
		
		List<PubAttrCode> attrCodeList = pubAttrCodeBiz.searchAttrCodeList(moduleCode,elementCode);
		Map<String,List<PubAttrCode>> attrCodeMap = new HashMap<String, List<PubAttrCode>>();
		for(PubAttrCode code : attrCodeList){
			List<PubAttrCode> temp = attrCodeMap.get(code.getAttrCode());
			if(temp == null){
				temp = new ArrayList<PubAttrCode>()	;
			}
			temp.add(code);
			attrCodeMap.put(code.getAttrCode(), temp);
		}
		
		model.addAttribute("attrCodeMap",attrCodeMap);
		return "pub/attribute/list";
	}
	
	@RequestMapping(value = {"/edit" },method={RequestMethod.POST,RequestMethod.GET})
	public String edit(String elementFlow,String moduleFlow ,Model model){
		PubModule module = pubModuleBiz.readPubModule(moduleFlow);
		model.addAttribute("module",module);
		
		PubElement element = pubElementBiz.readPubElement(elementFlow);
		model.addAttribute("pubElement",element);
		
		return "pub/element/edit";
	}
	
	
	//保存或编辑元素
	@RequestMapping(value = {"/saveElement" },method={RequestMethod.POST})
	@ResponseBody
	public String saveElement(PubElement element,HttpServletRequest req){
		if(StringUtil.isBlank(element.getElementFlow())){
			boolean addValFlag = GlobalConstant.FLAG_Y.equals(req.getParameter(GlobalConstant.DEFAULT_ATTR_VALUE_VAR_NAME));
			boolean addUnitFlag = GlobalConstant.FLAG_Y.equals(req.getParameter(GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME));
			boolean addAbnormalFlag = GlobalConstant.FLAG_Y.equals(req.getParameter(GlobalConstant.DEFAULT_ATTR_ABNORMAL_VAR_NAME));
			String moduleTypeId = req.getParameter("moduleTypeId");
			pubElementBiz.addElement(element,addValFlag,addUnitFlag,addAbnormalFlag,moduleTypeId);
		}else{
			pubElementBiz.updatePubElementByFlow(element);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	//保存或编辑元素
	@RequestMapping(value = {"/saveElementOrder" },method={RequestMethod.POST})
	@ResponseBody
	public String saveElementOrder(String [] elementFlow){		
		pubElementBiz.saveElementOrder(elementFlow);		
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	//保存或编辑元素
	@RequestMapping(value = {"/saveAttributeOrder" },method={RequestMethod.POST})
	@ResponseBody
	public String saveAttributeOrder(String [] attrFlow){		
		pubAttributeBiz.saveAttributeOrder(attrFlow);		
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	
	
	@RequestMapping(value = {"/addAttr" },method={RequestMethod.GET})
	public String addAttr(String moduleCode,String elementCode ,Model model){
		PubElement element = pubElementBiz.readPubElementByCode(elementCode);
		model.addAttribute("element",element);
		
		PubModule module = pubModuleBiz.readPubModuleByCode(element.getModuleCode());
		model.addAttribute("module", module);
		return "pub/attribute/edit";
	}
	
	@RequestMapping(value = {"/saveAttr" },method={RequestMethod.POST})
	@ResponseBody
	public String saveAttr(@RequestBody PubAttributeAndCode megerForm, Model model){
		PubAttribute attr = megerForm.getAttr();
		if(StringUtil.isBlank(attr.getAttrFlow())){
			pubAttributeBiz.addAttr(attr);
		}else {
			pubAttributeBiz.modify(attr);
		}
		pubAttrCodeBiz.addAttrCode(attr,megerForm.getAttrCodeList());
		return GlobalConstant.SAVE_SUCCESSED;
	}
	@RequestMapping(value = {"/modifyAttr" },method={RequestMethod.POST})
	@ResponseBody
	public String modifyAttr(PubAttribute attr, Model model){
		if(StringUtil.isBlank(attr.getAttrFlow())){
			pubAttributeBiz.addAttr(attr);
		}else {
			pubAttributeBiz.modify(attr);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	@RequestMapping(value = {"/modCodeValue" },method={RequestMethod.POST})
	@ResponseBody
	public String modifyAttrCode(PubAttrCode attrCode, Model model){
		if(StringUtil.isBlank(attrCode.getCodeFlow())){
			pubAttrCodeBiz.add(attrCode);
		}else {
			pubAttrCodeBiz.modify(attrCode);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/editAttr" },method={RequestMethod.GET})
	public String editAttr(String attrCode, Model model){
		PubAttribute attr = pubAttributeBiz.readPubAttributeByCode(attrCode);
		List<PubAttrCode> attrCodeList = pubAttrCodeBiz.searchAttrCodeListByAttrCode(attrCode);
		model.addAttribute("attr", attr);
		model.addAttribute("attrCodeList", attrCodeList);
		
		PubElement element = pubElementBiz.readPubElementByCode(attr.getElementCode());
		model.addAttribute("element",element);
		
		PubModule module = pubModuleBiz.readPubModuleByCode(element.getModuleCode());
		model.addAttribute("module", module);
		return "pub/attribute/edit";
	}
	@RequestMapping(value = {"/deleteAttrCode" },method={RequestMethod.GET})
	@ResponseBody
	public String deleteAttrCode(String codeFlow, Model model){
		pubAttrCodeBiz.deleteAttrCode(codeFlow);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/deleteAttr" },method={RequestMethod.GET})
	@ResponseBody
	public String deleteAttr(String attrFlow, Model model){
		PubAttribute attr = pubAttributeBiz.readPubAttribute(attrFlow);
		pubAttributeBiz.deleteAttr(attr);
		//同步删除代码
		List<PubAttrCode> codeList = pubAttrCodeBiz.searchAttrCodeListByAttrCode(attr.getAttrCode());
		pubAttrCodeBiz.deleteAttrCode(codeList);
		
		return GlobalConstant.DELETE_SUCCESSED;
	}
	@RequestMapping(value = {"/delModule" },method={RequestMethod.GET})
	@ResponseBody
	public String delModule(String moduleFlow, Model model){
		PubModule module = pubModuleBiz.readPubModule(moduleFlow);
		module.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		pubModuleBiz.updatePubModule(module);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	@RequestMapping(value = {"/addStandardUnit" },method={RequestMethod.GET})
	public String addStandardUnit(){
		return "pub/attribute/standardUnit";
	}
	@RequestMapping(value = {"/domainInfo" },method={RequestMethod.GET})
	public String domainInfo(String domain,Model model){
		List<PubModule> moduleList = pubModuleBiz.searchModuleListByDomain(domain);
		model.addAttribute("moduleList", moduleList);
		return "pub/module/domainInfo";
	}
	@RequestMapping(value = {"/delElement" },method={RequestMethod.GET})
	@ResponseBody
	public String delElement(String elementFlow,Model model){
		PubElement element = pubElementBiz.readPubElement(elementFlow);
		element.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		pubElementBiz.updatePubElementByFlow(element);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	@RequestMapping(value = {"/saveElementConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String saveElementConfirm(String elementCode,String elementVarName,Model model){
		PubElementExample example = new PubElementExample();
		example.createCriteria().andElementVarNameEqualTo(elementVarName).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubElement> elements = pubElementBiz.searchElementList(example);
		for(PubElement element : elements){
			if(element.getElementCode().equals(elementCode)){
				continue;
			}
			if(element.getElementVarName().equals(elementVarName)){
				return GlobalConstant.OPRE_FAIL;
			}
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	@RequestMapping(value = {"/saveAttrConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String saveAttrConfirm(String elementCode,String attrCode,String attrVarName,Model model){
		PubAttributeExample example = new PubAttributeExample();
		example.createCriteria().andElementCodeEqualTo(elementCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andAttrVarNameEqualTo(attrVarName);
		List<PubAttribute> attrs = pubAttributeBiz.searchAttributeList(example);
		for(PubAttribute attr : attrs){
			if(attr.getAttrCode().equals(attrCode)){
				continue;
			}
			if(attr.getAttrVarName().equals(attrVarName) ){
				return GlobalConstant.OPRE_FAIL;
			}
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	/**
	 * 复制元素（包含其属性、代码）
	 */
	@RequestMapping(value = {"/copyElement" },method={RequestMethod.GET})
	@ResponseBody
	public String copyElement(String elementFlow){
		PubElement element = pubElementBiz.readPubElement(elementFlow);
		pubElementBiz.copyElement(element);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 复制属性（包含其代码）
	 */
	@RequestMapping(value = {"/copyAttr" },method={RequestMethod.GET})
	@ResponseBody
	public String copyAttr(String attrFlow){
		PubAttribute attr = pubAttributeBiz.readPubAttribute(attrFlow);
		pubAttributeBiz.copyAttribute(attr);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 模块删除时验证是否被选入项目库，若是，不能删除
	 */
	@RequestMapping(value = {"/delModuleConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String delModuleConfirm(String moduleCode){
		EdcModuleExample example = new EdcModuleExample();
		example.createCriteria().andModuleCodeEqualTo(moduleCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcModule> modules = moduleBiz.searchModuleList(example);
		if (modules != null && modules.size() > 0) {
			return GlobalConstant.OPRE_FAIL;
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	/**
	 * 元素删除时验证是否被选入项目库，若是，不能删除
	 */
	@RequestMapping(value = {"/delElementConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String delElementConfirm(String elementCode){
		EdcElementExample example = new EdcElementExample();
		example.createCriteria().andElementCodeEqualTo(elementCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);	
		List<EdcElement> elements = moduleBiz.searchElementList(example);
		if (elements != null && elements.size() > 0) {
			return GlobalConstant.OPRE_FAIL;
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	/**
	 * 属性删除时验证是否被选入项目库，若是，不能删除
	 */
	@RequestMapping(value = {"/delAttrConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String delAttrConfirm(String attrCode){
		EdcAttributeExample example = new EdcAttributeExample();
		example.createCriteria().andAttrCodeEqualTo(attrCode).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcAttribute> attrList = attrMapper.selectByExample(example);
		if (attrList != null && attrList.size() > 0) {
			return GlobalConstant.OPRE_FAIL;
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	/**
	 * 属性代码删除时验证是否被选入项目库，若是，不能删除
	 */
	@RequestMapping(value = {"/delAttrCodeConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String delAttrCodeConfirm(String attrCode,String codeValue){
		EdcAttrCodeExample example = new EdcAttrCodeExample();
		example.createCriteria().andAttrCodeEqualTo(attrCode).andCodeValueEqualTo(codeValue).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);	
		List<EdcAttrCode> attrCodeList = attrCodeMapper.selectByExample(example);
		if (attrCodeList != null && attrCodeList.size() > 0) {
			return GlobalConstant.OPRE_FAIL;
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}

	//设计维护
	@RequestMapping(value = {"/design" },method={RequestMethod.GET})
	public String designManage(String moduleCode,Model model){
		PubModuleExample example = new PubModuleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubModule> moduleList = pubModuleBiz.searchModuleList(example);
		model.addAttribute("moduleList", moduleList);
		if(StringUtil.isNotBlank(moduleCode)){
			PubModuleForm pubDesignForm =  pubModuleBiz.getModuleForm(moduleCode);
			model.addAttribute("pubDesignForm", pubDesignForm);
		} 
		return "pub/module/designMaintain";
	}
	
	@RequestMapping(value = {"/edcModuleRemind" },method={RequestMethod.GET})
	public String edcModuleRemind(String moduleCode,Model model){
		PubModule pubModule = pubModuleBiz.readPubModuleByCode(moduleCode);
		model.addAttribute("pubModule", pubModule);
		
		List<EdcVisitForm> visitModuleForms = visitBiz.searchVisitsByModuleCode(moduleCode);
		model.addAttribute("visitModuleForms", visitModuleForms);
		
		return "pub/element/edcModuleRemind";
	}
	
	@RequestMapping(value = {"/edcElementRemind" },method={RequestMethod.GET})
	public String edcElementRemind(String elementCode,Model model){
		PubElement pubElement = pubElementBiz.readPubElementByCode(elementCode);
		model.addAttribute("pubElement", pubElement);
		
		List<EdcVisitForm> visitModuleForms = visitBiz.searchVisitsByElementCode(elementCode);
		model.addAttribute("visitModuleForms", visitModuleForms);
		
		return "pub/element/edcElementRemind";
	}
}
