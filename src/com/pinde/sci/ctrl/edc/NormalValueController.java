package com.pinde.sci.ctrl.edc;



import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.BeanUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IEdcNormalValueBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcNormalValue;
import com.pinde.sci.model.mo.EdcNormalValueExample;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;

@Controller
@RequestMapping("/edc/normalvalue")
public class NormalValueController extends GeneralController {	
	private static Logger logger=LoggerFactory.getLogger(NormalValueController.class);
	@Autowired
	private IEdcModuleBiz edcModuleBiz; 
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IEdcNormalValueBiz normalValueBiz;


	@RequestMapping(value = "/list/{actionScope}",method={RequestMethod.GET})
	public String  list(@PathVariable String actionScope,String orgFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow(); 
		
		EdcProjParam projParam = normalValueBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		if(GlobalConstant.DEPT_LIST_LOCAL.equals(actionScope)){
			orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		}else if(GlobalConstant.DEPT_LIST_GLOBAL.equals(actionScope)){
			List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("pubProjOrgList", pubProjOrgList);
		}
		
		if(StringUtil.isNotBlank(orgFlow)){
			List<EdcNormalValue> normalValueList =  normalValueBiz.searchNormalValue(projFlow,orgFlow);
			List<String> moduleCodeList = new ArrayList<String>();
			Map<String,List<String>> moduleValueMap = new HashMap<String, List<String>>();
			Map<String,List<EdcNormalValue>> eleValueMap = new HashMap<String, List<EdcNormalValue>>();
			if (normalValueList != null && normalValueList.size() > 0 ) {
				for(EdcNormalValue nv : normalValueList){
					String elementCode = nv.getElementCode();
					List<EdcNormalValue> temp  = eleValueMap.get(elementCode);
					if(temp == null){
						temp = new ArrayList<EdcNormalValue>();
					}
					temp.add(nv);
					eleValueMap.put(elementCode, temp);
					
					String moduleCode = nv.getModuleCode();
					if (!moduleCodeList.contains(moduleCode)) {
						moduleCodeList.add(moduleCode);
					}
					List<String> tem  = moduleValueMap.get(moduleCode);
					if(tem == null){
						tem = new ArrayList<String>();
					}
					if (!tem.contains(elementCode)) {
						tem.add(elementCode);
						moduleValueMap.put(moduleCode, tem);
					}
					
				}
			}
			model.addAttribute("moduleValueMap", moduleValueMap);
			model.addAttribute("eleValueMap", eleValueMap);
			
			List<EdcModule> edcModuleList = edcModuleBiz.searchModuleList(projFlow);
			List<EdcModule> moduleList = new ArrayList<EdcModule>();
			if (edcModuleList != null && edcModuleList.size() > 0 ) {
				for(EdcModule module : edcModuleList) {
					if (moduleCodeList.contains(module.getModuleCode())) {
						moduleList.add(module);
					}
				}
			}
			model.addAttribute("moduleList", moduleList);
			
			Map<String,EdcElement> elementMap = new HashMap<String, EdcElement>();
			List<EdcElement> LbElements = edcModuleBiz.searchLbelements(projFlow);
			if(LbElements != null){
				for(EdcElement element :LbElements){
					elementMap.put(element.getElementCode(), element);
				}
			}
			model.addAttribute("elementMap", elementMap);
			
			EdcProjOrg projOrg = normalValueBiz.searchEdcProjOrg(projFlow,orgFlow);
			model.addAttribute("edcProjOrg", projOrg);
			model.addAttribute("orgFlow",orgFlow);
		}
		model.addAttribute("actionScope", actionScope);
		return "edc/normalvalue/list";
	}
	
	@RequestMapping(value = "/addNormalValue",method={RequestMethod.POST})
	@ResponseBody
	public String  addNormalValue(EdcNormalValue normalValue,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow(); 
		String recordFlow = normalValue.getRecordFlow();
		normalValue.setProjFlow(projFlow);
		if(StringUtil.isBlank(normalValue.getRecordFlow())){
			recordFlow = normalValueBiz.addNormalValue(normalValue);
		}else {
			 normalValueBiz.modifyNormalValue(normalValue);
		}
		return recordFlow;
	}
	@RequestMapping(value = "/modNormalValue",method={RequestMethod.POST})
	@ResponseBody
	public String  modNormalValue(EdcNormalValue normalValue,Model model){
		normalValueBiz.modifyNormalValue(normalValue);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	
	@RequestMapping(value = "/copyRecord",method={RequestMethod.GET})
	@ResponseBody
	public String  copyRecord(String recordFlow,Model model){
		EdcNormalValue normalValue = normalValueBiz.readNormalValue(recordFlow);
		normalValueBiz.copyRecord(normalValue);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value = "/delRecord",method={RequestMethod.GET})
	@ResponseBody
	public String  delRecord(String recordFlow,Model model){
		EdcNormalValue normalValue = normalValueBiz.readNormalValue(recordFlow);
		if(normalValue!=null){
			normalValueBiz.delRecord(normalValue);
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	
	@RequestMapping(value = "/doSubmit",method={RequestMethod.GET})
	@ResponseBody
	public String  doSubmit(String orgFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow(); 
		normalValueBiz.lockNormalValue(projFlow,orgFlow);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value = "/normalValueFile/{actionScope}",method={RequestMethod.POST})
	public String  normalValueFile(@PathVariable String actionScope ,String orgFlow, String operateType, PubFileForm fileForm){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		if (operateType.equals("update")) {	//重新上传
			normalValueBiz.updateNormalValueFile(projFlow,orgFlow,fileForm);
		} else { //上传
			normalValueBiz.addNormalValueFile(projFlow,orgFlow,fileForm);
		}
		return "redirect:/edc/normalvalue/list/"+actionScope+"?orgFlow="+orgFlow;
	}

	@RequestMapping(value = "/unLockNormalValue",method={RequestMethod.GET})
	@ResponseBody
	public String  normalValueFile(String orgFlow){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjOrg projOrg = normalValueBiz.searchEdcProjOrg(projFlow, orgFlow);
		if(projOrg != null){
			normalValueBiz.unLockNormalValue(projOrg);
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value = "/impNormalValue",method={RequestMethod.GET})
	@ResponseBody
	public String  impNormalValue(String orgFlow){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
			
		Map<String,String> elementCodeMap = new HashMap<String, String>();
		List<EdcElement> LbElements = edcModuleBiz.searchLbelements(projFlow);
		if(LbElements != null){
			for(EdcElement element :LbElements){
				elementCodeMap.put(element.getElementCode(), element.getModuleCode());
			}
		}
		
		EdcDesignForm edcDesignForm = edcModuleBiz.getDescForm(projFlow);
		Map<String,String> standarUnitMap = new HashMap<String,String>();
		for(EdcModule module :edcDesignForm.getModuleList()){
			if(module.getModuleTypeId().equals(GlobalConstant.MODULD_TYPE_LB)){
				if(edcDesignForm.getModuleElementMap().get(module.getModuleCode())!=null){
					for(EdcElement element: edcDesignForm.getModuleElementMap().get(module.getModuleCode())){
						if( edcDesignForm.getElementAttrMap().get(element.getElementCode())!=null){
							 for(EdcAttribute attr : edcDesignForm.getElementAttrMap().get(element.getElementCode())){
								 if( GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME .equals(attr.getAttrVarName())){
									 if(edcDesignForm.getAttrCodeMap().get(attr.getAttrCode())!=null){
										 for(EdcAttrCode code : edcDesignForm.getAttrCodeMap().get(attr.getAttrCode())){
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
		
		EdcNormalValueExample example = new EdcNormalValueExample();
		example.createCriteria().andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("modify_time");
		List<EdcNormalValue> normalValueList = normalValueBiz.searchEdcNormalValue(example);
		Map<String,EdcNormalValue> otherNormalValueMap = new HashMap<String, EdcNormalValue>();
		Map<String,EdcNormalValue> projNormalValueMap = new HashMap<String, EdcNormalValue>();
		for(EdcNormalValue normalValue : normalValueList){
			//过滤非本试验检查元素
			if(!elementCodeMap.containsKey(normalValue.getElementCode())){
				continue;
			}
			String unit = standarUnitMap.get(normalValue.getElementCode());
			if(normalValue.getProjFlow().equals(projFlow)){
				projNormalValueMap.put(normalValue.getElementCode()+"_"+normalValue.getSexId(), normalValue);
			} else if ((StringUtil.isBlank(unit) && StringUtil.isBlank(normalValue.getUnit())) || (StringUtil.isNotBlank(unit) && unit.equals(normalValue.getUnit()))) {	//单位一致才导入
				otherNormalValueMap.put(normalValue.getElementCode()+"_"+normalValue.getSexId(), normalValue);
			}
		}	
		for(Map.Entry<String,EdcNormalValue> entity : otherNormalValueMap.entrySet()){
			if(!projNormalValueMap.containsKey(entity.getKey())){
				copyNormalValue(entity.getValue(),projFlow,orgFlow);
				elementCodeMap.remove(entity.getValue().getElementCode());
			}
		}
		for(Map.Entry<String,EdcNormalValue> entity : projNormalValueMap.entrySet()){
			elementCodeMap.remove(entity.getValue().getElementCode());
		}
		if (elementCodeMap.keySet() != null && elementCodeMap.keySet().size() > 0) { //未导入正常值范围且本试验无正常值范围记录的元素
			for (String elementCode:elementCodeMap.keySet()) {
				EdcNormalValue normalValue = new EdcNormalValue();
				normalValue.setElementCode(elementCode);
				normalValue.setUnit(standarUnitMap.get(elementCode));
				normalValue.setModuleCode(elementCodeMap.get(elementCode));
				normalValue.setOrgFlow(orgFlow);
				normalValue.setProjFlow(projFlow);
				normalValueBiz.addNormalValue(normalValue);
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}

	private void copyNormalValue(EdcNormalValue origNormalValue,String projFlow,String orgFlow) {
		EdcNormalValue normalValue = new EdcNormalValue();
		try {
			BeanUtil.copyProperties(normalValue, origNormalValue);
			normalValue.setRecordFlow(PkUtil.getUUID());
			normalValue.setOrgFlow(orgFlow);
			normalValue.setProjFlow(projFlow);
			normalValueBiz.addNormalValue(normalValue);
			
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
	
}
