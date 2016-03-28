package com.pinde.sci.biz.edc;

import java.util.List;

import com.pinde.sci.form.edc.ObservationCfgForm;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.EdcModuleForm;
import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcElementExample;
import com.pinde.sci.model.mo.EdcInspect;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcModuleExample;
import com.pinde.sci.model.mo.EdcVisitElement;
import com.pinde.sci.model.mo.EdcVisitModule;

public interface IEdcModuleBiz {
	List<EdcModule> searchModuleList(EdcModuleExample example);

	void addOrDelModule(List<EdcModule> addList, List<EdcModule> delList);

	EdcModule readEdcModule(String projFlow, String moduleCode);
 
	EdcModuleForm getModuleForm(String projFlow, String moduleCode);

	void saveOrUpdateEdcElement(List<EdcElement> addEleList,
			List<EdcElement> delEleList);

	void saveOrUpdateEdcAttr(List<EdcAttribute> addAttr,List<EdcAttribute> modAttr,
			List<EdcAttribute> delAttr);

	void saveOrUpdateEdcAttrCode(List<EdcAttrCode> addAttrCode,List<EdcAttrCode> modAttrCode,
			List<EdcAttrCode> delAttrCode);

	void delAttrCode(String projFlow,String moduleCode); 

	void onOffEdcModule(EdcModule module, String recordStatusY);

	void addEdcModule(EdcModule targetModule);

	int countModule(String projFlow);

	void addElement(EdcElement targetElement);

	void onOffEdcElement(EdcElement element, String recordStatusN);

	void delAttrCode(String projFlow, String moduleCode, String oprateEleCode);

	List<EdcModule> searchModuleList(String projFlow);

	List<EdcAttribute> searchAttributeList(String projFlow);

	List<EdcElement> searchElementList(String projFlow);
	
	List<EdcAttrCode> searchCodeList(String projFlow);

	EdcDesignForm getDescForm(String projFlow);
 
	EdcModule readEdcModule(String moduleFlow); 

	void modifyEdcModule(EdcModule module);

	void modifyEdcElement(EdcElement element);

	void modifyEdcAttribute(EdcAttribute attr);


	void modifyEdcAttrCode(String attrCode, EdcAttrCode code);

	List<EdcElement> searchElementList(EdcElementExample eleExample);

	List<EdcElement> searchLbelements(String projFlow);

	EdcElement selElement(String projFlow, String eleVarName);

	List<EdcAttribute> searchAttrList(String projFlow,String elementCode);

	EdcModule readModuleByShortName(String shortName);

	void modifyEdcVisitModule(EdcVisitModule visitModule);

	void modifyEdcVisitElement(EdcVisitElement ve);

	EdcDesignForm getCrfDescForm(String projFlow);

	EdcVisitElement searchEdcVisitElement(String recordFlow);

	void modifyEdcVisitElementNoSelect(EdcVisitElement ve);

	EdcElement readEdcElement(String elementFlow);

	void modifyEdcElementNoSelect(EdcElement element);

	void modifyEdcModuleNoSelect(EdcModule module);

	List<EdcElement> searchElementList(String projFlow, List<String> moduleCodes);

	List<EdcAttribute> searchAttrList(String projFlow, List<String> moduleCodes);

	List<EdcAttrCode> searchByAttrCode(String projFlow, List<String> attrCodes);

	EdcInspect readInspect(String projFlow,String inspectTypeId);

	int editInspect(EdcInspect inspect);

	EdcInspect createInspectXml(ObservationCfgForm form);

	List<ObservationCfgForm> parseInspectInfo(String inspectInfo);

	EdcAttribute readAttribute(String projFlow, String attrCode);
 
}  
  