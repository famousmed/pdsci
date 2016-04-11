package com.pinde.sci.ctrl.edc;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.PyUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.edc.EdcBlindTypeEnum;
import com.pinde.sci.enums.edc.EdcIETypeEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignLabelEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignStatusEnum;
import com.pinde.sci.enums.edc.EdcRandomAssignTypeEnum;
import com.pinde.sci.enums.edc.EdcRandomPromptStatusEnum;
import com.pinde.sci.enums.edc.EdcRandomTypeEnum;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.gcp.GcpDrugStoreStatusEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.pub.ProjOrgTypeEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.form.edc.EdcPatientIeForm;
import com.pinde.sci.model.edc.RandomFactor;
import com.pinde.sci.model.edc.RandomInfo;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcIe;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.EdcRandomRecExample;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/edc/random")
public class RandomController extends GeneralController {	
	private static Logger logger=LoggerFactory.getLogger(RandomController.class);
	@Autowired
	private IEdcRandomBiz randomBiz;	
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IPubPatientBiz patientBiz;
	@Autowired
	private IInputBiz inputBiz;
	@Autowired
	private IVisitBiz visitBiz;
	@Autowired
	private IEdcGroupBiz groupBiz;

	@RequestMapping(value={"/param"},method={RequestMethod.GET})
	public String param(Model model){
		//获取当前EDC项目流水号
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		if(projParam!=null){
			/*
			 * <factors>
					<layer index="1" weight="2">
						<item code="0">超重(BMI:24~28)</item>
						<item code="1">一度肥胖(BMI:28~35)</item>
						<item code="2">二度肥胖(BMI:35~40)</item>
						<item code="3">三度肥胖(BMI&gt;40)</item>
					</layer>
					<layer index="2" weight="1">
						<item code="1">男</item>
						<item code="2">女</item>
					</layer>
				</factors>
			 * */
			String factorParam = projParam.getRandomFactor();
			 
			
			if(StringUtil.isNotBlank(factorParam)){
				List<RandomFactor> factors = GeneralMethod.getRandomFactor(factorParam);
				model.addAttribute("factors", factors);
			}
			
			String randomFileFlow = projParam.getRandomFileFlow();
			if(StringUtil.isNotBlank(randomFileFlow)){
				PubFile file = fileBiz.readFile(randomFileFlow);
				model.addAttribute("randomFile", file);
			}
		}
		
		
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		
		Map<String,EdcProjOrg> edcProjOrgMap = randomBiz.getEdcPropOrgMap(projFlow);
		model.addAttribute("edcProjOrgMap", edcProjOrgMap);
		
		Integer assignCount = randomBiz.countAssign(projFlow);
		model.addAttribute("assignCount", assignCount);
		
		return "edc/random/param";
	}

	
	
	@RequestMapping(value={"/randomFile"},method={RequestMethod.POST})
	public String randomFile(PubFileForm fileForm){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		
		randomBiz.addRandomFile(projParam,fileForm,projFlow);
		return "redirect:/edc/random/param";
	}
	
	@RequestMapping(value={"/list"},method={RequestMethod.GET})
	public String list(Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		SysUser user = GlobalContext.getCurrentUser();
		String orgFlow = user.getOrgFlow();
		
		List<PubPatient> patientList = patientBiz.searchPatient(projFlow, orgFlow);
		model.addAttribute("patientList", patientList);
		
		
		Map<String,EdcRandomRec> randomMap = randomBiz.getPatientRandomMap(projFlow,orgFlow);
		model.addAttribute("randomMap", randomMap);
		
		model.addAttribute("isBlind", GeneralMethod.isBlind(projParam));
		
		EdcProjOrg edcProjOrg = randomBiz.readEdcProjParam(projFlow, orgFlow);
		model.addAttribute("edcProjOrg", edcProjOrg);
		
		PubProjOrg pubProjOrg = projOrgBiz.readProjOrg(projFlow, orgFlow);
		model.addAttribute("pubProjOrg", pubProjOrg);
		
		return "/edc/random/list";
	}
	@RequestMapping(value={"/assign"},method={RequestMethod.GET})
	public String assign(String patientFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		String factorParam = projParam.getRandomFactor();
		if(StringUtil.isNotBlank(factorParam)){ 
			List<RandomFactor> factors = GeneralMethod.getRandomFactor(factorParam);
			model.addAttribute("factors", factors);
		}
		
		PubPatient patient = patientBiz.readPatient(patientFlow);
		model.addAttribute("patient", patient);
		
		if (GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("edc_include_exclude"))) {
			List<EdcIe> inList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Include.getId());
			List<EdcIe> exList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Exclude.getId());
			model.addAttribute("inList", inList);
			model.addAttribute("exList", exList);
		}
		
		model.addAttribute("ieFlag", InitConfig.getSysCfg("edc_include_exclude"));
		
		return "/edc/random/assign";
	}
	
	@RequestMapping(value={"/assign"})
	@ResponseBody
	public String assign(@RequestBody EdcPatientIeForm patientIeForm,String assignLabel){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		String patientFlow = patientIeForm.getPatientFlow();
		
		PubPatient currPatient = patientBiz.readPatient(patientFlow);
		currPatient.setPatientBirthday(patientIeForm.getPatientBirthday());
		currPatient.setPatientName(patientIeForm.getPatientName());
		currPatient.setPatientNamePy(PyUtil.getFirstSpell(currPatient.getPatientName()).toUpperCase());
		currPatient.setSexId(patientIeForm.getSexId());
		currPatient.setSexName(UserSexEnum.getNameById(patientIeForm.getSexId()));
		
		EdcProjParam param = randomBiz.readProjParam(projFlow);
		String layerFactors = StringUtil.defaultString(patientIeForm.getLayerFactors());
		
		Map<String,String> ieValueMap = null;
		if (GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("edc_include_exclude"))) {//随机入组申请是否填写纳入/排除开关
			List<EdcPatientIeForm> ieValueList = patientIeForm.getIeValueList();
			//组织ieValueMap，保存至PubPatientIe表中
			ieValueMap = new HashMap<String,String>();
			if (ieValueList != null && ieValueList.size() > 0) {
				ieValueMap = new HashMap<String,String>();
				for (EdcPatientIeForm form:ieValueList) {
					String ieValue = form.getIeValue();
					String varName = form.getVarName();
					ieValueMap.put(varName, ieValue);
				}
			}
		}
		
		String callBack = randomBiz.assign(ieValueMap,param,assignLabel,currPatient,layerFactors,EdcRandomAssignTypeEnum.Net.getId(),GlobalContext.getCurrentUser()); 
		
		return callBack;
	}
	
	private String getFactor(List<RandomFactor> factors,HttpServletRequest req) {
		String layerFactors ="";
		for(RandomFactor factor : factors){
			String value=req.getParameter("factor_"+factor.getIndex());
			layerFactors+=value;
		}
		return layerFactors;
	}
	
	
	@RequestMapping(value={"/modProjParam"},method={RequestMethod.GET})
	@ResponseBody
	public String modProjParam(EdcProjParam param ){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = randomBiz.readProjParam(projFlow); 
		
		param.setProjFlow(projFlow);
		if(StringUtil.isBlank(param.getRandomLock())){
			param.setRandomLock(GlobalConstant.FLAG_N);
		}
		if(StringUtil.isNotBlank(param.getBlindTypeId())){
			param.setBlindTypeName(EdcBlindTypeEnum.getNameById(param.getBlindTypeId()));
		}
		if(StringUtil.isNotBlank(param.getRandomTypeId())){
			param.setRandomTypeName(EdcRandomTypeEnum.getNameById(param.getRandomTypeId()));
		}
		if(projParam == null){
			randomBiz.addProjParam(param);
		}else {
			randomBiz.modify(param);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	@RequestMapping(value={"/editFactor"},method={RequestMethod.GET})
	public String editFactor(){
		return "/edc/random/editFactor";
	}
	
	@RequestMapping(value={"/saveFactor"},method={RequestMethod.POST})
	@ResponseBody
	public String saveFactor(String index,String weight,String code,String name){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = randomBiz.readProjParam(projFlow); 
		if(projParam == null){
			projParam = new EdcProjParam();
			projParam.setProjFlow(projFlow);
			randomBiz.addProjParam(projParam);
		}
		
		if(projParam!=null){
			String randomFactior = projParam.getRandomFactor();
			if(StringUtil.isBlank(randomFactior)){ 
				randomFactior = "<factors/>";
			}
			Document doc;
			try {
				doc = DocumentHelper.parseText(randomFactior);
//				Node layerNode = doc.selectSingleNode("factors/layer[@index='"+index+"']"); 
				List<Element> layerEles = doc.selectNodes("factors/layer[@index='"+index+"']");
				Element layerElement = null;
				if(layerEles == null || layerEles.size()==0){
					layerElement = doc.getRootElement().addElement("layer");
					layerElement.addAttribute("index",index);
					layerElement.addAttribute("weight",weight);
				} else {
					layerElement = layerEles.get(0);
				}
				Element itemEle = layerElement.addElement("item");
				itemEle.addAttribute("code",code);
				itemEle.setText(name);
				projParam.setRandomFactor(doc.asXML());
				randomBiz.modify(projParam);
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	@RequestMapping(value={"/delFactor"},method={RequestMethod.GET})
	@ResponseBody
	public String delFactor(String index,String code) {  
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = randomBiz.readProjParam(projFlow); 
		if(projParam!=null){
			String randomFactior = projParam.getRandomFactor();
			if(StringUtil.isBlank(randomFactior)){ 
				randomFactior = "<factors/>";
			}
			Document doc;
			try {
				doc = DocumentHelper.parseText(randomFactior);
				
				Node layerNode = doc.getRootElement().selectSingleNode("./layer[@index='"+index+"']");
				Node itemNode = layerNode.selectSingleNode("./item[@code='"+code+"']");
				if(itemNode != null){
					itemNode.detach();
					if (layerNode.selectNodes("item").isEmpty()) {	//代码全部删除完时删除该分层
						layerNode.detach();
					}
					if (doc.getRootElement().selectNodes("layer").isEmpty()) {
						projParam.setRandomFactor("");
					} else {
						projParam.setRandomFactor(doc.asXML());
					}
					randomBiz.modify(projParam);
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}
	@RequestMapping(value={"/assignFollow"},method={RequestMethod.GET})
	public String assignFollow(String patientFlow, Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		String factorParam = projParam.getRandomFactor();
		if(StringUtil.isNotBlank(factorParam)){ 
			List<RandomFactor> factors = GeneralMethod.getRandomFactor(factorParam);
			model.addAttribute("factors", factors);
		}
	    
	    RandomInfo randomInfo = randomBiz.getRandomInfo(patientFlow);
	    model.addAttribute("randomInfo", randomInfo);
	    
	    if (GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("edc_include_exclude"))) {
			List<EdcIe> inList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Include.getId());
			List<EdcIe> exList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Exclude.getId());
			model.addAttribute("inList", inList);
			model.addAttribute("exList", exList);
			Map<String,String> patientIeMap = randomBiz.getPatientIeMap(patientFlow);
			model.addAttribute("patientIeMap", patientIeMap);
		}
	    
		return "/edc/random/assignFollow";
	}
	@RequestMapping(value={"/assignFollow"},method={RequestMethod.POST})
	@ResponseBody
	public String assignFollow(String patientFlow,String assignLabel,HttpServletRequest req){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		PubPatient currPatient = patientBiz.readPatient(patientFlow);
		
		EdcProjParam projParam = randomBiz.readProjParam(projFlow); 
		
		List<RandomFactor> factors = GeneralMethod.getRandomFactor(projParam.getRandomFactor());
		String layerFactors = "";
		if(factors!=null && factors.size()>0){
			 layerFactors = getFactor(factors,req);
		}
		String callBack = randomBiz.assign(null,projParam,assignLabel,currPatient,layerFactors,EdcRandomAssignTypeEnum.Net.getId(),GlobalContext.getCurrentUser()); 
		return callBack;
	}
	
	@RequestMapping(value={"/schedule"},method={RequestMethod.GET})
	public String schedule(String patientFlow, Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		
		Map<String,String> assignDateMap = randomBiz.getOrgAssignDateMap(projFlow);
		model.addAttribute("assignDateMap", assignDateMap);
		
		Map<String,String> inDateMap = patientBiz.getOrgInDateMap(projFlow);
		model.addAttribute("inDateMap", inDateMap);
 		return "/edc/random/schedule";
	}
	
	
	@RequestMapping(value={"/manage/{userScope}"},method={RequestMethod.GET})
	public String manage(@PathVariable String userScope,String orgFlow, Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		model.addAttribute("isBlind", GeneralMethod.isBlind(projParam));
		
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		
		
		
		if(GlobalConstant.USER_LIST_LOCAL.equals(userScope)){
			orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		}
		if(StringUtil.isNotBlank(orgFlow)){
			PubPatientExample example = new PubPatientExample();
			example.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId())
			.andPatientStageIdNotEqualTo(PatientStageEnum.Filter.getId()).andOrgFlowEqualTo(orgFlow);
			example.setOrderByClause("PATIENT_SEQ");
			List<PubPatient> patientList = patientBiz.searchPatient(example);
			model.addAttribute("patientList", patientList);
			
			Map<String,EdcRandomRec> randomRecMap = randomBiz.getPatientRandomMap(projFlow, orgFlow);
			model.addAttribute("randomRecMap", randomRecMap);
			

			Map<String,EdcRandomRec> randomMap = randomBiz.getPatientRandomMap(projFlow,orgFlow);
			model.addAttribute("randomMap", randomMap);
		}
		model.addAttribute("userScope", userScope);
 		return "/edc/random/manage";
	}
	
	
	
	@RequestMapping(value={"/assignTrend"},method={RequestMethod.GET})
	public String assignTrend(String orgFlow, Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if (proj != null) {
			String projFlow = proj.getProjFlow();
			System.err.println(orgFlow);
			if(StringUtil.isBlank(orgFlow)){
				orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			}
			PubProjOrg projOrg = projOrgBiz.readProjOrg(projFlow, orgFlow);
			model.addAttribute("projOrg", projOrg);
			
			Map<String,Object> assignMap = randomBiz.getOrgAssignMap(projFlow,orgFlow);
			model.addAttribute("assignMap", assignMap);
		}
 		return "/edc/random/assignTrend";
	}
	@RequestMapping(value={"/randomlist"},method={RequestMethod.GET})
	public String randomlist(String orgFlow, Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		model.addAttribute("isBlind", GeneralMethod.isBlind(projParam));
		
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		
		if(StringUtil.isNotBlank(orgFlow)){
			EdcRandomRecExample	 example = new EdcRandomRecExample();
			example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			example.setOrderByClause("ORDINAL");
			List<EdcRandomRec> recList = randomBiz.searchRandomRecList(example);
			model.addAttribute("recList", recList);
		}
		return "/edc/random/randomRecList";
	}
	@RequestMapping(value={"/breakBlind"},method={RequestMethod.GET})
	public String breakBlind(String patientFlow, Model model){ 
		RandomInfo randomInfo = randomBiz.getRandomInfo(patientFlow);
		model.addAttribute("randomInfo", randomInfo);
		return "/edc/random/breakBlind";
	}
	
	@RequestMapping(value={"/breakBlindApply"},method={RequestMethod.GET})
	@ResponseBody
	public String breakBlindApply(String patientFlow, Model model){ 
		RandomInfo randomInfo = randomBiz.getRandomInfo(patientFlow);
		EdcRandomRec rec = randomInfo.getRandomRec();
		
		if(rec != null){
			rec.setPromptStatusId(EdcRandomPromptStatusEnum.Apply.getId());
			rec.setPromptStatusName(EdcRandomPromptStatusEnum.Apply.getName());
			
			randomBiz.modifyEdcRandomRec(rec);
		}
		
		return GlobalConstant.OPRE_SUCCESSED;
	}
	@RequestMapping(value={"/agreePompt"},method={RequestMethod.GET})
	@ResponseBody
	public String agreePompt(String patientFlow, Model model){ 
		RandomInfo randomInfo = randomBiz.getRandomInfo(patientFlow);
		EdcRandomRec rec = randomInfo.getRandomRec();
		
		if(rec != null){
			rec.setPromptStatusId(EdcRandomPromptStatusEnum.Agree.getId());
			rec.setPromptStatusName(EdcRandomPromptStatusEnum.Agree.getName());
			
			randomBiz.modifyEdcRandomRec(rec);
		}
		
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	
	
	@RequestMapping(value={"/breakBlind"},method={RequestMethod.POST})
	@ResponseBody
	public String saveBreakBlind(String patientFlow, Model model){ 
		RandomInfo randomInfo = randomBiz.getRandomInfo(patientFlow);
		EdcRandomRec randomRec = randomInfo.getRandomRec();
		randomRec.setPromptStatusId(EdcRandomPromptStatusEnum.Prompted.getId());
		randomRec.setPromptStatusName(EdcRandomPromptStatusEnum.Prompted.getName());
		randomRec.setPromptTime(DateUtil.getCurrDateTime());
		randomRec.setPromptUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		randomRec.setPromptUserName(GlobalContext.getCurrentUser().getUserName());
		
		int result =  randomBiz.modifyEdcRandomRec(randomRec);
		if(result != GlobalConstant.ZERO_LINE){
			EdcGroup group = groupBiz.searchEdcGroup(randomInfo.getPatient().getProjFlow(), randomRec.getDrugGroup());
			return group.getGroupNote();
		}
		return GlobalConstant.PROMPT_FAIL;
	}
	
	@RequestMapping(value={"/lockOrgRandom"},method={RequestMethod.GET})
	@ResponseBody
	public String lockOrgRandom(String orgFlow,String checkedFlag, Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjOrg epo = randomBiz.readEdcProjParam(projFlow,orgFlow);
		if(epo == null){
			epo = new EdcProjOrg();
			epo.setRecordFlow(PkUtil.getUUID());
			epo.setProjFlow(projFlow);
			epo.setOrgFlow(orgFlow);
			epo.setRandomLock(checkedFlag);
			randomBiz.addEdcProjOrg(epo);
		}else {
			epo.setRandomLock(checkedFlag);
			randomBiz.modifyEdcProjOrg(epo);
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping(value={"/cancleAssign"},method={RequestMethod.GET})
	public String cancleAssign(Model model){ 
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		EdcProjParam projParam = randomBiz.readProjParam(projFlow);
		model.addAttribute("isBlind", GeneralMethod.isBlind(projParam));
		
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		if(StringUtil.isNotBlank(orgFlow)){
			Map<String,EdcRandomRec> groupDrugAssignMap = new HashMap<String, EdcRandomRec>();
			List<EdcRandomRec> randomRecs = randomBiz.searchPatientRandom(projFlow,orgFlow);
//			for(EdcRandomRec rec : randomRecs){
//				groupDrugAssignMap.put(rec.getDrugGroup(), rec);   //每组最后申请的一例药物
//			}
//			model.addAttribute("groupDrugAssignMap", groupDrugAssignMap);
			
			if(randomRecs.size()>0){
				EdcRandomRec randomRec = randomRecs.get(randomRecs.size()-1);
				model.addAttribute("randomRec", randomRec); 
				
				//入组申请：判断是否已有访视，若有不给撤销
				List<PubPatientVisit> patientVisitList = inputBiz.searchPatientVisit(projFlow, orgFlow,randomRec.getPatientFlow());
				if (patientVisitList != null && patientVisitList.size()>0) {
					model.addAttribute("visitFlag", GlobalConstant.FLAG_Y);
				}
			}
			
			
		}
		return "/edc/random/cancleAssign";
	}
	
	
	@RequestMapping(value={"/doCancleAssign"},method={RequestMethod.GET})
	@ResponseBody
	public String doCancleAssign(String recFlow){
		
		EdcRandomRec rec = randomBiz.readEdcRandomRec(recFlow);
		RandomInfo randomInfo = randomBiz.getRandomInfo(rec.getPatientFlow());

		EdcProjParam projParam = randomBiz.readProjParam(rec.getProjFlow());
		if(EdcRandomTypeEnum.Dynamic.getId().equals(projParam.getRandomTypeId())){
			cancleDynamicAssign(rec, randomInfo);
		}else if(EdcRandomTypeEnum.BlockCompetition.getId().equals(projParam.getRandomTypeId())){
			cancleBlockCompetition(rec,randomInfo);
		}
		return GlobalConstant.OPERATE_SUCCESSED;
	}



	private void cancleBlockCompetition(EdcRandomRec randomRec,RandomInfo randomInfo) {
		EdcRandomRecExample example = new EdcRandomRecExample();
		example.createCriteria().andProjFlowEqualTo(randomRec.getProjFlow()).andBlockNumEqualTo(randomRec.getBlockNum())
		.andAssignStatusIdEqualTo(EdcRandomAssignStatusEnum.Assigned.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EdcRandomRec> recList = randomBiz.searchRandomRec(example);
		
		if(recList!=null && recList.size()>1){ 
			//已经2条以上记录，无需重置区间
			
		}else if(recList!=null && recList.size()==1){
			//本区间只申请了本条记录，撤销需要重置区间
			randomRec.setOrgFlow("");
		
			randomBiz.resetBlock(randomRec);
			
		}
		randomRec.setDrugPack("");
		randomRec.setDrugFactorName("");
		randomRec.setPatientFlow("");
		randomRec.setPatientCode("");
		randomRec.setRandomCode("");
		randomRec.setAssignStatusId(EdcRandomAssignStatusEnum.UnAssign.getId());
		randomRec.setAssignStatusName(EdcRandomAssignStatusEnum.UnAssign.getName());
		randomRec.setAssignLabelId("");
		randomRec.setAssignLabelName("");
		randomRec.setAssignUserFlow("");
		randomRec.setAssignTime("");
		randomRec.setAssignUserName("");
		randomRec.setAssignEmail(GlobalConstant.FLAG_N);
		randomRec.setAssignTypeId("");
		randomRec.setAssignTypeName("");
		
		randomBiz.modifyEdcRandomRecForCancle(randomRec);
		resetPatient(randomInfo.getPatient());
	}



	private void cancleDynamicAssign(EdcRandomRec rec, RandomInfo randomInfo) {
		String drugPack = rec.getDrugPack();
		GcpDrugStoreRec storeRec = null;
		if (StringUtil.isNotBlank(drugPack)) {
			storeRec = randomBiz.seachGcpDrugStoreRec(rec.getPatientFlow(),drugPack);
		}
		
		if(EdcRandomAssignLabelEnum.First.getId().equals(rec.getAssignLabelId())){
			//入组撤销
			if (storeRec != null) {
				resetDrugStoreRec(storeRec);
			}
			
			resetRandomRec(rec);
			
			resetPatient(randomInfo.getPatient());
		}else if(EdcRandomAssignLabelEnum.Follow.getId().equals(rec.getAssignLabelId())){
			GcpDrugStoreRec record = randomInfo.getDrugRecList().get(randomInfo.getDrugRecList().size()-2); //倒数第二次申请记录
			
			//随访撤销
			resetDrugStoreRec(storeRec);
			
			rollBackRandomRec(randomInfo.getRandomRec(),record); 
		}
	}
	@RequestMapping(value={"/cancleAssignBlockCompetition"},method={RequestMethod.GET})
	@ResponseBody
	public String cancleAssignBlockCompetition(String recFlow){
		EdcRandomRec rec = randomBiz.readEdcRandomRec(recFlow);
		RandomInfo randomInfo = randomBiz.getRandomInfo(rec.getPatientFlow());
		cancleDynamicAssign(rec, randomInfo);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	private void rollBackRandomRec(EdcRandomRec randomRec,GcpDrugStoreRec record) {
		randomRec.setDrugPack(record.getDrugPack());
		randomRec.setDrugFactorName(record.getDrugFactorName());
		randomRec.setAssignLabelId(record.getAssignLabelId());
		randomRec.setAssignLabelName(record.getAssignLabelName());
		randomRec.setAssignUserFlow(record.getAssignUserFlow());
		randomRec.setAssignUserName(record.getAssignUserName());
		randomRec.setAssignTime(record.getAssignTime());
		
		randomBiz.modifyEdcRandomRec(randomRec);
	}
	
	
	private void resetPatient(PubPatient patient) {
		patient.setPatientName("");
		patient.setPatientNamePy("");
		patient.setSexId("");
		patient.setSexName("");
		patient.setIdNo("");
		patient.setPatientStageId(PatientStageEnum.Filter.getId());
		patient.setPatientStageName(PatientStageEnum.Filter.getName());
		patient.setPatientAge("");
		patient.setPatientBirthday("");
		patient.setPatientHeight("");
		patient.setPatientWeight("");
		patient.setPatientPhone("");
		patient.setInDate("");
		patient.setInDoctorFlow("");
		patient.setInDoctorName("");
		patientBiz.resetPatient(patient);
	}

	private void resetRandomRec(EdcRandomRec randomRec) {
		randomRec.setDrugPack("");
		randomRec.setDrugFactorName("");
		randomRec.setPatientFlow("");
		randomRec.setPatientCode("");
		randomRec.setRandomCode("");
		randomRec.setAssignStatusId(EdcRandomAssignStatusEnum.UnAssign.getId());
		randomRec.setAssignStatusName(EdcRandomAssignStatusEnum.UnAssign.getName());
		randomRec.setAssignLabelId("");
		randomRec.setAssignLabelName("");
		randomRec.setAssignUserFlow("");
		randomRec.setAssignTime("");
		randomRec.setAssignUserName("");
		randomRec.setAssignEmail(GlobalConstant.FLAG_N);
		randomRec.setAssignTypeId("");
		randomRec.setAssignTypeName("");
		randomBiz.modifyEdcRandomRecForCancle(randomRec);
	}

	private void resetDrugStoreRec(GcpDrugStoreRec rec) {
		rec.setDrugFactorName("");
		rec.setDrugStatusId(GcpDrugStoreStatusEnum.UnSend.getId());
		rec.setDrugStatusName(GcpDrugStoreStatusEnum.UnSend.getName());
		rec.setAssignTime("");
		rec.setAssignUserFlow("");
		rec.setAssignUserName("");
		rec.setAssignLabelId("");
		rec.setAssignLabelName("");
		rec.setPatientFlow("");
		rec.setPatientCode("");
		rec.setAssignEmail(GlobalConstant.FLAG_N);
		rec.setAssignTypeId("");
		rec.setAssignTypeName("");
		randomBiz.modifyGcpDrugStoreRec(rec);
	}
	
	@RequestMapping(value={"/showRandomInfo"},method={RequestMethod.GET})
	public String showRandomInfo(String patientFlow, Model model){
	    RandomInfo randomInfo = randomBiz.getRandomInfo(patientFlow);
	    model.addAttribute("randomInfo", randomInfo);
	    
	    PubPatient patient = randomInfo.getPatient();
	    PubProjOrg pubProjOrg = projOrgBiz.readProjOrg(patient.getProjFlow(), patient.getOrgFlow());
		model.addAttribute("pubProjOrg", pubProjOrg);
		
		EdcProjParam projParam = randomBiz.readProjParam(patient.getProjFlow());
	    model.addAttribute("isBlind", GeneralMethod.isBlind(projParam));
	    
	    
	    EdcGroup group = groupBiz.searchEdcGroup(patient.getProjFlow(), randomInfo.getRandomRec().getDrugGroup());
	    model.addAttribute("group", group);
		return "/edc/random/randomInfo";
	}
	
	@RequestMapping(value={"/includeExclude"},method={RequestMethod.GET})
	public String includeExclude(String patientFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		PubPatient patient = patientBiz.readPatient(patientFlow);
		model.addAttribute("patient", patient);
		
		List<EdcIe> inList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Include.getId());
		List<EdcIe> exList = visitBiz.searchIeList(projFlow,EdcIETypeEnum.Exclude.getId());
		model.addAttribute("inList", inList);
		model.addAttribute("exList", exList);
		
		Map<String,String> patientIeMap = randomBiz.getPatientIeMap(patientFlow);
		model.addAttribute("patientIeMap", patientIeMap);
		
		return "/edc/random/includeExclude";
	}
	@RequestMapping(value={"/view"},method={RequestMethod.GET})
	public String view(String patientFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if (proj != null) {
			String projFlow = proj.getProjFlow();
			String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			boolean flag = true;
			if (StringUtil.isNotBlank(orgFlow)) {
				PubProjOrg projOrg = projOrgBiz.readProjOrg(projFlow, orgFlow);
				if (projOrg != null && (ProjOrgTypeEnum.Parti.getId().equals(projOrg.getOrgTypeId()))) {	//当前用户所属机构的机构角色为参与 
					flag = false;
					model.addAttribute("projOrg", projOrg);
				}
			}
			if (flag) {
				orgFlow = "";
				List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
				projOrgList = GeneralMethod.filterProjOrg(projOrgList);	//过滤非组长和参与的机构
				model.addAttribute("projOrgList", projOrgList);
				
				Integer maxVisit = randomBiz.searchMaxVisit(projFlow);
				
				model.addAttribute("maxVisit", maxVisit);
				Map<Integer,Integer> visitCountMap = new HashMap<Integer, Integer>();
				if(maxVisit!=null && maxVisit>1){
					for(int i=1;i<maxVisit;i++){
						visitCountMap.put(i, randomBiz.searchMaxVisitFollow(projFlow,i));
					}
					model.addAttribute("visitCountMap", visitCountMap);
				}
			}
			model.addAttribute("multiOrg", flag);
			
			Map<String,Object> assignMap = randomBiz.getOrgAssignMap(projFlow,orgFlow);
			model.addAttribute("assignMap", assignMap);
		}
		return "/edc/view/random";
	}
	
	@RequestMapping(value={"/orgSchedule"},method={RequestMethod.GET})
	public String orgSchedule(Model model){
		SysUser sysUser = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		if(sysUser != null){
			String orgFlow = sysUser.getOrgFlow();
			String projFlow = edcCurrProj.getProjFlow();
			Map<String,String> randomMap = new HashMap<String,String>();
			
			PubProjOrg pubProjOrg = projOrgBiz.readProjOrg(projFlow, orgFlow);
			if(pubProjOrg != null){
				randomMap.put("centerNo",pubProjOrg.getCenterNo()+"");
				randomMap.put("orgName",pubProjOrg.getOrgName());
			}
			
			Map<String,String> assignDateMap = randomBiz.getOrgAssignDateMap(projFlow);
			randomMap.put("assignCount",assignDateMap.get(orgFlow+"_Count"));
			
			Map<String,String> inDateMap = patientBiz.getOrgInDateMap(projFlow);
			randomMap.put("minInDate",inDateMap.get(orgFlow+"_Min"));
			randomMap.put("maxInDate",inDateMap.get(orgFlow+"_Max"));
			randomMap.put("inCount",inDateMap.get(orgFlow+"_Count"));
			
			model.addAttribute("randomMap",randomMap);
		}
		
		return "/edc/random/orgSchedule";
	}
	
	/**
	 * 申请时校验是否有重名，如果有 提示姓名，编号
	 */
	@RequestMapping(value = {"/assignConfirm" },method={RequestMethod.POST})
	@ResponseBody
	public String assignConfirm(String patientFlow,String patientName){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		SysUser user = GlobalContext.getCurrentUser();
		String orgFlow = user.getOrgFlow();
		
		PubPatientExample example = new PubPatientExample();
		example.createCriteria().andPatientNameEqualTo(patientName).andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId())
		.andPatientStageIdNotEqualTo(PatientStageEnum.Filter.getId()).andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubPatient> patientList = patientBiz.searchPatient(example);
		if (patientList != null && patientList.size() > 0) {
			String confirmMessage = "";
			for (PubPatient patient:patientList) {
				if (StringUtil.isNotBlank(confirmMessage)) {
					confirmMessage += "，";
				}
				confirmMessage += patient.getPatientCode();
			}
			return confirmMessage;
		}
		
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	@RequestMapping(value = {"/druglist/{userScope}" },method={RequestMethod.GET})
	public String druglist(@PathVariable String userScope,String orgFlow,Model model){
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		model.addAttribute("userScope", userScope);
		if(GlobalConstant.DEPT_LIST_LOCAL.equals(userScope)){
			SysUser user = GlobalContext.getCurrentUser();
			orgFlow = user.getOrgFlow();
			
			PubProjOrg pubProjOrg = projOrgBiz.readProjOrg(projFlow, orgFlow);
			model.addAttribute("pubProjOrg", pubProjOrg);
			
		}
		
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);
		
		
		if(StringUtil.isNotBlank(orgFlow)){
			List<GcpDrugStoreRec> drugList = randomBiz.searchDrugStoreList(projFlow,orgFlow);
			model.addAttribute("drugList", drugList);
			
			model.addAttribute("assignCount", randomBiz.countAssignDrug(projFlow,orgFlow));
			model.addAttribute("unAssignCount", randomBiz.countUnAssignDrug(projFlow,orgFlow));
		}
		return "/edc/random/druglist";
	}
	
	
}
