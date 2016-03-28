package com.pinde.sci.ctrl.edc;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.pdf.DocumentVo;
import com.pinde.core.pdf.PdfDocumentGenerator;
import com.pinde.core.pdf.utils.ResourceLoader;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.EdcAttrCodeMapper;
import com.pinde.sci.dao.base.EdcAttributeMapper;
import com.pinde.sci.enums.edc.AppItemInputTypeEnum;
import com.pinde.sci.enums.edc.AttrInputTypeEnum;
import com.pinde.sci.enums.edc.EdcIETypeEnum;
import com.pinde.sci.enums.edc.ModuleStyleEnum;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.gcp.GcpProjStatusEnum;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.PatientVisitForm;
import com.pinde.sci.model.edc.RandomDrugGroupForm;
import com.pinde.sci.model.edc.VisitForm;
import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttrCodeExample;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcIe;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcModuleExample;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitAttrCode;
import com.pinde.sci.model.mo.EdcVisitAttribute;
import com.pinde.sci.model.mo.EdcVisitAttributeExample;
import com.pinde.sci.model.mo.EdcVisitExample;
import com.pinde.sci.model.mo.EdcVisitModule;
import com.pinde.sci.model.mo.EdcVisitModuleExample;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientExample.Criteria;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientVisitExample;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysOrg;

@Controller
@RequestMapping("/edc/visit")
public class VisitController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(VisitController.class);
	
	private static String icEleVarName = "ic";	//纳入标准元素变量名
	private static String ieeEleVarName = "iee";	//排除标准元素变量名
	private static final String GCP_CURR_PROJ = "gcpCurrProj";
	
	@Autowired
	private IVisitBiz visitBiz; 
	@Autowired
	private IEdcModuleBiz moduleBiz;
	@Autowired
	private IEdcGroupBiz groupBiz;
	@Resource
	private EdcAttrCodeMapper codeMapper;
	@Resource
	private EdcAttributeMapper attrMapper;
	@Autowired
	private IEdcRandomBiz randomBiz;
	@Autowired
	private IPubPatientBiz pubPatientBiz;
	@Autowired
	private IFileBiz pubFileBiz;
	@Autowired
	private IInputBiz inputBiz; 
	@Autowired
	private IPubPatientBiz patientBiz; 
	@Autowired
	private IOrgBiz orgBiz; 
	
	
	//设计维护
	@RequestMapping(value = {"/designManage" },method={RequestMethod.GET})
	public String designManage(String moduleCode,Model model){
		logger.info("==========注销projDescForm=========");
		setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, null);
		
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcProjParam projParam = visitBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		EdcVisitExample example = new EdcVisitExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		EdcDesignForm  edcDesignForm = moduleBiz.getDescForm(projFlow);
		model.addAttribute("edcDesignForm", edcDesignForm);
		
		return "edc/visit/designMaintain";
	}
	
	
	@RequestMapping(value = {"/list" },method={RequestMethod.POST,RequestMethod.GET})
	public String list( Model model) {		
		//CRF 设计 重新初始化 Design
		logger.info("==========注销projDescForm=========");
		setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, null);
		
		return "edc/visit/main";
	}
	
	@RequestMapping(value = {"/addVisit" },method={RequestMethod.GET})
	@ResponseBody
	public String addVisit(){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		visitBiz.addVisit(projFlow);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/showVisit" },method={RequestMethod.GET})
	public String showVisit(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<EdcVisit> visitList =  visitBiz.searchVisitList(projFlow);
		model.addAttribute("visitList", visitList);
		return  "edc/visit/list";
	}
	
	@RequestMapping(value = {"/edit" },method={RequestMethod.GET})
	public String edit(String visitFlow,Model model){
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		model.addAttribute("visit", visit);
		return  "edc/visit/edit";
	}
	
	@RequestMapping(value = {"/save" },method={RequestMethod.POST})
	@ResponseBody
	public String save(EdcVisit visit,Model model){
		visitBiz.modify(visit);
		return  GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/showVisitTable" },method={RequestMethod.GET})
	public String showVisitTable(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<EdcVisit> visitList =  visitBiz.searchVisitList(projFlow);
		model.addAttribute("visitList", visitList);
		
		EdcModuleExample example = new EdcModuleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		example.setOrderByClause("ORDINAL");
		List<EdcModule> moduleList = moduleBiz.searchModuleList(example);
		model.addAttribute("moduleList", moduleList);
		
		Map<String,String> existMap = new HashMap<String, String>();
		EdcVisitModuleExample vmExample = new EdcVisitModuleExample();
		vmExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		List<EdcVisitModule> modules  = visitBiz.searchVisitModule(vmExample);
		for(EdcVisitModule vm : modules){
			existMap.put(vm.getVisitFlow()+"_"+vm.getModuleCode(), vm.getRecordFlow());
		}
		model.addAttribute("existMap", existMap);
		
		EdcProjParam projParam = visitBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		return  "edc/visit/listTable";
	}
	@RequestMapping(value = {"/modifyVisitName" },method={RequestMethod.POST})
	@ResponseBody
	public String modifyVisitName(EdcVisit visit){
		visitBiz.modify(visit);
		return  GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/visitManage" },method={RequestMethod.GET})
	public String visitManage(Model model){
		logger.info("==========注销projDescForm=========");
		setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, null);
		
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String currWsId = (String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		String projFlow = null;
		List<PubPatient> patientList = null;
		if (GlobalConstant.GCP_WS_ID.equals(currWsId)) {
			proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
			String userFlow = GlobalContext.getCurrentUser().getUserFlow();
			if(!(proj != null && GcpProjStatusEnum.Passed.getId().equals(proj.getProjStatusId()) && userFlow.equals(proj.getApplyUserFlow()))){
				setSessionAttribute(GCP_CURR_PROJ,null);
				model.addAttribute("patientFlag", true);
				return "edc/visit/visitManage";
			} else {
				projFlow = proj.getProjFlow();
				//入组受试者列表
				patientList = pubPatientBiz.searchIndatePatientByProjFlow(projFlow);
				model.addAttribute("patientFlag", !(patientList != null && patientList.size() > 0));
			}
		}
		
		projFlow = proj.getProjFlow();
		EdcProjParam projParam = visitBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);

		List<EdcGroup> groupList = groupBiz.searchEdcGroup(projFlow);
		model.addAttribute("groupList", groupList);
		
		List<EdcVisit> visitList = visitBiz.searchVisitList(projFlow);
		model.addAttribute("visitList", visitList);
		
		if (!(projParam != null && !GlobalConstant.FLAG_Y.equals(projParam.getDesignLock()) && !GlobalConstant.FLAG_Y.equals(projParam.getProjLock()))
				|| (GlobalConstant.GCP_WS_ID.equals(currWsId) && patientList != null && patientList.size() > 0)) {
			Map<String,List<EdcVisit>> visitMap = new HashMap<String,List<EdcVisit>>();
			if (visitList != null && visitList.size() > 0) {
				for (EdcVisit visit:visitList) {
					String groupFlow = visit.getGroupFlow();
					if (StringUtil.isBlank(groupFlow)) {
						groupFlow = "common";	//通用
					}
					List<EdcVisit> temp = visitMap.get(groupFlow);
					if (temp == null) {
						temp = new ArrayList<EdcVisit>();
					}
					temp.add(visit);
					visitMap.put(groupFlow, temp);
				}
			}
			model.addAttribute("visitMap", visitMap);
		}
		
		return "edc/visit/visitManage";
	}
	
	/**
	 * 访视页面删除时验证是否有访视数据，若有，不能删除
	 */
	@RequestMapping(value = {"/delVisitConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String delVisitConfirm(String visitFlow){
		PubPatientVisitExample example = new PubPatientVisitExample();
		example.createCriteria().andVisitFlowEqualTo(visitFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);	
		List<PubPatientVisit> pubPatientVisits = visitBiz.searchPubPatientVisits(example);
		if (pubPatientVisits != null && pubPatientVisits.size() > 0) {
			return GlobalConstant.OPRE_FAIL;
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/deleteVisit" },method={RequestMethod.GET})
	@ResponseBody
	public String deleteVisit(String visitFlow){
		visitBiz.delVisit(visitFlow);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/saveVisitBatch" },method={RequestMethod.POST})
	@ResponseBody
	public String saveVisitBatch(@RequestBody VisitForm visitForm){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String currWsId = (String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		if (GlobalConstant.GCP_WS_ID.equals(currWsId)) {
			proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
		}
		String projFlow = proj.getProjFlow();
		List<EdcVisit> visitList =  visitForm.getVisitList();
		for(EdcVisit visit:visitList){
			if (StringUtil.isNotBlank(visit.getGroupFlow())) {
				EdcGroup group = groupBiz.read(visit.getGroupFlow());
				visit.setGroupName(group.getGroupName());
			} else {
				visit.setGroupName("");
			}
			if(StringUtil.isBlank(visit.getVisitFlow())){ 
				visit.setVisitFlow(PkUtil.getUUID());
				visit.setProjFlow(projFlow);
				visitBiz.addVisit(visit);
			}else {
				visitBiz.modify(visit);
			}
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/preview" },method={RequestMethod.GET})
	public String preview(String visitFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcDesignForm projDescForm = moduleBiz.getCrfDescForm(projFlow);
		model.addAttribute("projDescForm", projDescForm);
		
		EdcVisit visit = visitBiz.readVisit(visitFlow);
		model.addAttribute("visit", visit);
		
		return "edc/visit/preview";
	}
	
	//保存或编辑元素
	@RequestMapping(value = {"/savePageModuleOrder" },method={RequestMethod.POST})
	@ResponseBody
	public String savePageModuleOrder(String visitFlow,String [] moduleCode){	
		System.err.println(visitFlow);
		System.err.println(StringUtil.toString(moduleCode));
		visitBiz.savePageModuleOrder(visitFlow, moduleCode);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	//保存或编辑元素
		@RequestMapping(value = {"/savePageModuleOrder2" },method={RequestMethod.GET})
		@ResponseBody
		public String savePageModuleOrder2(String visitFlow,String  moduleCode,Integer ordinal){	
			visitBiz.savePageModuleOrder2(visitFlow, moduleCode,ordinal);
			return GlobalConstant.SAVE_SUCCESSED;
		}

	
	//保存或编辑元素
	@RequestMapping(value = {"/savePageElementOrder" },method={RequestMethod.POST})
	@ResponseBody
	public String savePageElementOrder(String visitFlow,String [] elementCode){			
		System.err.println(visitFlow);
		System.err.println(StringUtil.toString(elementCode));
		visitBiz.savePageElementOrder(visitFlow, elementCode);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	//保存或编辑元素
	@RequestMapping(value = {"/savePageAttributeOrder" },method={RequestMethod.POST})
	@ResponseBody
	public String savePageAttributeOrder(String visitFlow,String [] attrCode){			
		visitBiz.savePageAttributeOrder(visitFlow, attrCode);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/ieList" },method={RequestMethod.GET})
	public String ieList(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = visitBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		List<EdcIe> inList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Include.getId());
		List<EdcIe> exList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Exclude.getId());
		model.addAttribute("inList", inList);
		model.addAttribute("exList", exList);
		return "edc/visit/ieList";
	}
	
	@RequestMapping(value = "/editIE",method={RequestMethod.GET})
	public String editIE(String ieFlow,String typeId,Model model){
		if(StringUtil.isNotBlank(ieFlow)){
			EdcIe ie = visitBiz.readEdcIe(ieFlow);
			typeId = ie.getTypeId();
			model.addAttribute("ie", ie);
		}
		model.addAttribute("typeId", typeId);
		model.addAttribute("typeName", EdcIETypeEnum.getNameById(typeId));
		return "edc/visit/editIE";
	}
	
	@RequestMapping(value = "/saveIE",method={RequestMethod.POST})
	@ResponseBody
	public String saveIE(EdcIe ie){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		ie.setProjFlow(projFlow);	
		ie.setTypeName(EdcIETypeEnum.getNameById(ie.getTypeId()));
		ie.setInputTypeName(AppItemInputTypeEnum.getNameById(ie.getInputTypeId()));
		if (AppItemInputTypeEnum.Bool.getId().equals(ie.getInputTypeId())) {
			ie.setMaxValue("");
			ie.setMinValue("");
		} else if (AppItemInputTypeEnum.Number.getId().equals(ie.getInputTypeId())) {
			ie.setPassedValue("");
		}
		if(StringUtil.isBlank(ie.getIeFlow())){
			visitBiz.addEdcIe(ie);
		}else{
			visitBiz.modifyEdcIe(ie);
		}
		return GlobalConstant.SAVE_SUCCESSED;	
	}
	
	@RequestMapping(value = {"/delIE" },method={RequestMethod.GET})
	@ResponseBody
	public String delIE(EdcIe ie){
		ie.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		visitBiz.modifyEdcIe(ie);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/impEdcIE" },method={RequestMethod.GET})
	@ResponseBody
	public String impEdcIE(){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		int result = this.visitBiz.impEdcIE(projFlow,icEleVarName,ieeEleVarName);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value = "/impAttrCode",method={RequestMethod.GET})
	@ResponseBody
	public String  impAttrCode(){
		EdcAttrCodeExample attrCodeExample = new EdcAttrCodeExample(); 
		attrCodeExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcAttrCode> codeList = codeMapper.selectByExample(attrCodeExample);
		Map<String,List<EdcAttrCode>> attrCodeMap = new HashMap<String,List<EdcAttrCode>>();
		if (codeList != null && codeList.size() > 0) {
			for (EdcAttrCode code :codeList) {
				List<EdcAttrCode> temp = attrCodeMap.get(code.getProjFlow()+"_"+code.getModuleCode()+
						"_"+code.getElementCode()+"_"+code.getAttrCode());
				if(temp == null){
					temp = new ArrayList<EdcAttrCode>();
				}
				temp.add(code);
				attrCodeMap.put(code.getProjFlow()+"_"+code.getModuleCode()+
						"_"+code.getElementCode()+"_"+code.getAttrCode(), temp); 
			}
		}
		
		//添加EdcVisitAttrCode
		EdcVisitAttributeExample attrExample = new EdcVisitAttributeExample();
		attrExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcVisitAttribute> vaList = visitBiz.searchVisitAttribute(attrExample);
		List<EdcVisitAttrCode> visitAttrCodeList = new ArrayList<EdcVisitAttrCode>();
		if (vaList != null && vaList.size() > 0) {
			for (EdcVisitAttribute attr :vaList) {
				List<EdcAttrCode> temp = attrCodeMap.get(attr.getProjFlow()+"_"+attr.getModuleCode()+
						"_"+attr.getElementCode()+"_"+attr.getAttrCode());
				if (temp != null && temp.size() > 0) {
					for (EdcAttrCode code:temp) {
						EdcVisitAttrCode visitAttrCode = new EdcVisitAttrCode();
						visitAttrCode.setRecordFlow(PkUtil.getUUID());
						visitAttrCode.setVisitFlow(attr.getVisitFlow());
						visitAttrCode.setModuleCode(code.getModuleCode());
						visitAttrCode.setElementCode(code.getElementCode());
						visitAttrCode.setAttrCode(code.getAttrCode());
						visitAttrCode.setCodeFlow(code.getCodeFlow());
						visitAttrCode.setProjFlow(code.getProjFlow());
						visitAttrCode.setOrdinal(code.getOrdinal());
						visitAttrCodeList.add(visitAttrCode);
					}
				}
			}
			visitBiz._addVisitAttrCode(visitAttrCodeList);
		}
		
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value = "/groupManage",method={RequestMethod.GET})
	public String groupManage(HttpServletRequest request,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = visitBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		model.addAttribute("isRandom", GeneralMethod.isRandom(projParam));
		model.addAttribute("isBlind", GeneralMethod.isBlind(projParam));
		List<EdcGroup> groupList = groupBiz.searchEdcGroup(projFlow);
		model.addAttribute("groupList", groupList);
		return "edc/group/list";
	}
	
	@RequestMapping(value = "/editEdcGroup",method={RequestMethod.GET})
	public String editEdcGroup(String groupFlow,Model model){
		if(StringUtil.isNotBlank(groupFlow)){
			EdcGroup group = groupBiz.read(groupFlow);
			model.addAttribute("group", group);
		}
		return "edc/group/edit";
	}
	
	@RequestMapping(value = "/saveEdcGroup",method={RequestMethod.POST})
	@ResponseBody
	public String saveEdcGroup(EdcGroup group,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		group.setProjFlow(projFlow);
		groupBiz.save(group);
		return GlobalConstant.OPERATE_SUCCESSED;	
	} 
	
	/**
	 * 组别删除时验证是否有改组别的访视页面，若有，不能删除
	 */
	@RequestMapping(value = {"/delEdcGroupConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String delEdcGroupConfirm(String groupFlow){
		List<EdcVisit> visits = visitBiz.searchVisits(groupFlow);
		if (visits != null && visits.size() > 0) {
			return GlobalConstant.OPRE_FAIL;
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping(value = "/delEdcGroup",method={RequestMethod.GET})
	@ResponseBody
	public String delEdcGroup(EdcGroup group,Model model){
		groupBiz.del(group);
		return GlobalConstant.OPERATE_SUCCESSED;	
	} 
	
	@RequestMapping(value = "/impEdcGroup",method={RequestMethod.GET})
	@ResponseBody
	public String impEdcGroup(){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		List<EdcGroup> groupList = groupBiz.searchEdcGroup(projFlow);
		List<String> groupNameList = new ArrayList<String>();
		int ordinal = 0;
		if (groupList != null && groupList.size() >0) {
			for (EdcGroup group:groupList) {
				groupNameList.add(group.getGroupName());
				if (group.getOrdinal() != null && ordinal < group.getOrdinal()) {
					ordinal = group.getOrdinal();
				}
			}
		}
		List<RandomDrugGroupForm> drugGroupFormList = randomBiz.searchDurgGroups(projFlow);
		int num = 1;
		if (drugGroupFormList != null && drugGroupFormList.size() > 0) {
			for (RandomDrugGroupForm form:drugGroupFormList) {
				if (!groupNameList.contains(form.getDrugGroup())) {
					EdcGroup group = new EdcGroup();
					group.setGroupName(form.getDrugGroup());
					group.setProjFlow(projFlow);
					group.setOrdinal(ordinal+num);
					groupBiz.save(group);
					num++;
				}
			}
		}
			
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	//保存或编辑元素
	@RequestMapping(value = {"/saveEdcAttributeOrder" },method={RequestMethod.POST})
	@ResponseBody
	public String saveEdcAttributeOrder(String moduleCode,String [] attrCode){	
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		visitBiz.saveEdcAttributeOrder(projFlow,moduleCode, attrCode);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/exportEmptyCrf" },method={RequestMethod.GET})
	public void exportEmptyCrf(String orgFlow,String patientFlow,String soureType,final HttpServletResponse response) throws Exception{
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		String projName = proj.getProjName();
		
		final String fileName = projName + "病例报告表（CRF）";
		String outputFileClass = ResourceLoader.getPath("");
		String outputFile = new File(outputFileClass)
		.getParentFile().getParent() + "/load/" + fileName + ".pdf" ;
		
		File file = new File(outputFile);
//		if (!file.exists()) {
			//root 储存的数据
			final Map<String,Object> root=new HashMap<String,Object>();
			root.put("projName", projName);
			
			root.put("soureType", soureType);
			root.put("moduleStyleSingleId", ModuleStyleEnum.Single.getId());
			root.put("flagY", GlobalConstant.FLAG_Y);
			root.put("flagN", GlobalConstant.FLAG_N);
			root.put("unitVarName",GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME);
			
			root.put("radioId",AttrInputTypeEnum.Radio.getId());
			root.put("checkboxId",AttrInputTypeEnum.Checkbox.getId());
			
			EdcDesignForm projDescForm = moduleBiz.getCrfDescForm(projFlow);
			root.put("projDescForm", projDescForm);
			
			EdcProjParam projParam = inputBiz.readProjParam(projFlow);
			root.put("projParam", projParam);
			
			if(StringUtil.isNotBlank(orgFlow)){
				PubPatientExample exam = new PubPatientExample();
				Criteria criteria =  exam.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				criteria.andOrgFlowEqualTo(orgFlow);
				boolean isRandom = GeneralMethod.isRandom(projParam);
				if (isRandom) {		//随机试验过滤未入组样本
					criteria.andInDateIsNotNull();
				}
				exam.setOrderByClause("patient_Seq");
				List<PubPatient> patientList = patientBiz.searchPatient(exam);
				root.put("patientList", patientList);
				
				SysOrg org = orgBiz.readSysOrg(orgFlow);
				root.put("orgName",org.getOrgName());
			}
			
			if(StringUtil.isNotBlank(patientFlow)){
				PubPatient patient = inputBiz.readPatient(patientFlow);
				if (patient.getOrgFlow().equals(orgFlow)) {
					root.put("patient", patient);
					
					//受试者访视
					Map<String,PatientVisitForm> patientSubmitVisitMap = inputBiz.getPatientSubmitVisitMap(projFlow,patientFlow);
					root.put("patientSubmitVisitMap", patientSubmitVisitMap);
					
					//受试者CRF-所有录入 数据 visitFlow-elementSerialSeqValueMap 
					Map<String,Map<String,Map<String,Map<String,EdcPatientVisitData>>>> patientCrfDataMap = new HashMap<String, Map<String,Map<String,Map<String,EdcPatientVisitData>>>>();
					for(Map.Entry<String, PatientVisitForm> entity : patientSubmitVisitMap.entrySet()){
						patientCrfDataMap.put(entity.getKey(), inputBiz.getelementSerialSeqValueMap(entity.getValue().getEdcPatientVisit().getRecordFlow()));
					}
					root.put("patientCrfDataMap", patientCrfDataMap);
				}
				root.put("patientCode",patient.getPatientCode());
			}
			
			root.put("attrValueObj",new GeneralMethod());
			
			int edcSerialAttrCount = 0;
			if (StringUtil.isNotBlank(InitConfig.getSysCfg("edc_serial_attr_count"))) {
				edcSerialAttrCount = Integer.parseInt(InitConfig.getSysCfg("edc_serial_attr_count"));
			}
			root.put("edcSerialAttrCount", edcSerialAttrCount);
			
			try {
				// 模板数据
				DocumentVo vo = new DocumentVo() {
					@Override
					public String findPrimaryKey() {
						return fileName;
					}
					
					@Override
					public Map<String, Object> fillDataMap() {
						return root;
					}
				};
				
				String template = "crfTemplate.html";
				PdfDocumentGenerator pdfGenerator = new PdfDocumentGenerator();
				// 生成pdf
				pdfGenerator.generate(template, vo, outputFile);
			} catch (Exception ex) {
				System.err.println(" \n pdf生成失败");
				ex.printStackTrace();
			}
//		}
		
		pubFileBiz.downFile(file,response);
		
	}
	
}
