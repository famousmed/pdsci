package com.pinde.sci.ctrl.gcp;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PyUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.biz.edc.IEdcRandomBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.gcp.IGcpDrugBiz;
import com.pinde.sci.biz.gcp.IGcpProjBiz;
import com.pinde.sci.biz.pub.IPubPatientAeBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.pub.IPubPatientRecipeBiz;
import com.pinde.sci.biz.pub.IPubPatientWindowBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.enums.gcp.GcpDrugTypeEnum;
import com.pinde.sci.enums.gcp.GcpProjStatusEnum;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.OutWindowTypeEnum;
import com.pinde.sci.enums.pub.PatientRecipeStatusEnum;
import com.pinde.sci.enums.pub.PatientSourceEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.model.irb.CodeValues;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.GcpDrug;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientAe;
import com.pinde.sci.model.mo.PubPatientRecipe;
import com.pinde.sci.model.mo.PubPatientRecipeDrug;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientWindow;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("gcp/researcher")
public class ResearcherController extends GeneralController{
	private static Logger logger = LoggerFactory.getLogger(ResearcherController.class);
	
	private static final String GCP_CURR_PROJ = "gcpCurrProj";
	
	@Autowired
	private IGcpProjBiz pubProjBiz;
	@Autowired
	private IPubPatientBiz pubPatientBiz;
	@Autowired
	private IPubPatientAeBiz patientAeBiz;
	@Autowired
	private IGcpDrugBiz gcpDrugBiz;
	@Autowired
	private IPubPatientRecipeBiz recipeBiz;
	@Autowired
	private IVisitBiz visitBiz;
	@Autowired
	private IPubPatientWindowBiz windowBiz;
	@Autowired
	private IEdcGroupBiz groupBiz;
	@Resource
	private IEdcRandomBiz randomBiz;
	
	/**
	 * 项目选择列表
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/userProjList"},method={RequestMethod.POST,RequestMethod.GET})
	public String userProjList(String projNo,String projName,Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		PubProj proj = new PubProj();
		proj.setApplyUserFlow(currUser.getUserFlow());
		proj.setProjNo(projNo);
		proj.setProjStatusId(GcpProjStatusEnum.Passed.getId());
		proj.setProjName(projName);
		List<PubProj> projList =  pubProjBiz.searchProjList(proj);
		model.addAttribute("projList",projList);
		return "gcp/patient/userProjList";
	}
	
	/**
	 * 设置gcp区域已选项目
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/setCurrProj",method={RequestMethod.GET})
	@ResponseBody
	public String setCurrProj(String projFlow,Model model){
		PubProj proj = pubProjBiz.readProject(projFlow);		
		setSessionAttribute(GCP_CURR_PROJ, proj);
		return GlobalConstant.SELECT_SUCCESSED;	
	}
	
	/**
	 * 发药与随访列表
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/patientList"},method={RequestMethod.GET})
	public String patientList(Model model){
		PubProj proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
		if(proj != null && GcpProjStatusEnum.Passed.getId().equals(proj.getProjStatusId()) && GlobalContext.getCurrentUser().getUserFlow().equals(proj.getApplyUserFlow())){
			List<PubPatient> patientList = pubPatientBiz.searchPatientNotFilter(proj.getProjFlow(),GlobalContext.getCurrentUser().getOrgFlow());
			model.addAttribute("patientList",patientList);
			if(patientList != null && !patientList.isEmpty()){
				//药物编码Map
				List<String> patientFlows = new ArrayList<String>();
				for(PubPatient patient : patientList){
					patientFlows.add(patient.getPatientFlow());
				}
				Map<String,List<String>> patientDrugPackMap = gcpDrugBiz.getPatientDrugPackMap(patientFlows);
				model.addAttribute("patientDrugPackMap",patientDrugPackMap);
				
				PubPatientAe patientAe = new PubPatientAe();
				patientAe.setProjFlow(proj.getProjFlow());
				patientAe.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
				List<PubPatientAe> patientAeList = patientAeBiz.searchPatientAeList(patientAe);
				//根据PatientFlow组织Map
				Map<String, List<PubPatientAe>> patientAeMap = new HashMap<String, List<PubPatientAe>>();
				for(PubPatientAe ae : patientAeList){
					List<PubPatientAe> temp = patientAeMap.get(ae.getPatientFlow());
					if(temp == null){
						temp = new ArrayList<PubPatientAe>();
					}
					temp.add(ae);
					patientAeMap.put(ae.getPatientFlow(), temp);
				}
				model.addAttribute("patientAeMap",patientAeMap);
			}
			
			List<GcpDrug> drugList = gcpDrugBiz.searchDrugByProj(proj.getProjFlow());
			model.addAttribute("drugList",drugList);
			
			model.addAttribute("proj",proj);
			
			List<EdcVisit> visitList = visitBiz.searchVisitList(proj.getProjFlow(),GlobalConstant.FLAG_Y);
			model.addAttribute("visitList",visitList);
		} else {
			setSessionAttribute(GCP_CURR_PROJ,null);
		}
		return "gcp/patient/patientList";
	}
	
	/**
	 * 加载受试者列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/choosePatient"},method={RequestMethod.GET})
	public String choosePatient(PubPatient patient, Model model){
		PubProj proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
		if(proj != null && GcpProjStatusEnum.Passed.getId().equals(proj.getProjStatusId()) && GlobalContext.getCurrentUser().getUserFlow().equals(proj.getApplyUserFlow())){
			patient.setInDate(GlobalConstant.FLAG_N);//标记查不为空
			patient.setProjFlow(proj.getProjFlow());
			patient.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			patient.setPatientStageId(PatientStageEnum.In.getId());
			List<PubPatient> patientList = pubPatientBiz.searchPatientList(patient);
			model.addAttribute("patientList",patientList);
			if(patientList != null && !patientList.isEmpty()){
				//药物编码Map
				GcpDrugStoreRec drugStoreRec = new GcpDrugStoreRec();
				drugStoreRec.setProjFlow(proj.getProjFlow());
				drugStoreRec.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
				List<GcpDrugStoreRec> drugStoreRecList = pubPatientBiz.searchGcpDrugStoreRecList(drugStoreRec);
				Map<String, String> drugPackMap = new HashMap<String, String>();
				for(GcpDrugStoreRec rec : drugStoreRecList){
					drugPackMap.put(rec.getPatientFlow(), rec.getDrugPack());
				}
				model.addAttribute("drugPackMap",drugPackMap);
				
				PubPatientAe patientAe = new PubPatientAe();
				patientAe.setProjFlow(proj.getProjFlow());
				patientAe.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
				List<PubPatientAe> patientAeList = patientAeBiz.searchPatientAeList(patientAe);
				//根据PatientFlow组织Map
				Map<String, List<PubPatientAe>> patientAeMap = new HashMap<String, List<PubPatientAe>>();
				for(PubPatientAe ae : patientAeList){
					List<PubPatientAe> temp = patientAeMap.get(ae.getPatientFlow());
					if(temp == null){
						temp = new ArrayList<PubPatientAe>();
					}
					temp.add(ae);
					patientAeMap.put(ae.getPatientFlow(), temp);
				}
				model.addAttribute("patientAeMap",patientAeMap);
			}
			
			model.addAttribute("proj",proj);
		} else {
			setSessionAttribute(GCP_CURR_PROJ,null);
		}
		return "gcp/patient/choosePatient";
	}
	
	
	/**
	 * 添加受试者
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/addPatient"},method={RequestMethod.GET})
	public String addPatient(Model model){
		return "gcp/patient/addPatient";
	}
	
	@RequestMapping(value={"/savePatient"},method={RequestMethod.POST})
	@ResponseBody
	public String savePatient(PubPatient patient,String in,String ex,Model model){
		if(patient!=null){
			PubProj proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
			if(proj != null){
				String patientName = patient.getPatientName();
				if(StringUtil.isNotBlank(patientName)){
					patient.setPatientNamePy(PyUtil.getFirstSpell(patientName).toUpperCase());
				}
				patient.setProjFlow(proj.getProjFlow());
				patient.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
				patient.setSexName(UserSexEnum.getNameById(patient.getSexId()));
				patient.setPatientStageName(PatientStageEnum.getNameById(patient.getPatientStageId()));
				patient.setPatientTypeId(PatientTypeEnum.Real.getId());
				patient.setPatientTypeName(PatientTypeEnum.Real.getName());
				if(StringUtil.isNotBlank(patient.getPatientSourceId())){
					patient.setPatientSourceName(PatientSourceEnum.getNameById(patient.getPatientSourceId()));
				}
				if(StringUtil.isNotBlank(patient.getInDate())){
					patient.setInDate(DateUtil.getDateTime(patient.getInDate()));
				}
				PubPatient patientSearch = new PubPatient();
				patientSearch.setProjFlow(proj.getProjFlow());
				patientSearch.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
				patientSearch.setPatientTypeId(PatientTypeEnum.Real.getId());
				List<PubPatient> patientList = pubPatientBiz.searchPatient(patientSearch);
				int patientSeq = 0;
				if(patientList != null && patientList.size()>0){
					for(PubPatient patientTemp : patientList){
						if(patientTemp.getPatientSeq() != null){
							if(patientTemp.getPatientSeq()>patientSeq){
								patientSeq = patientTemp.getPatientSeq();
							}
						}
					}
				}
				patient.setPatientSeq(patientSeq+1);
				patient.setPatientCode(patientSeq+1+"");
				if(pubPatientBiz.savePubPatient(patient,in,ex) != GlobalConstant.ZERO_LINE){
					return GlobalConstant.SAVE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
		
	/**
	 * 编辑受试者
	 * @param proj
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/editPatient"},method={RequestMethod.GET})
	public String editPatient(String patientFlow,Model model){
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = pubPatientBiz.readPatient(patientFlow);
			model.addAttribute("patient",patient);
		}
		return "gcp/patient/editPatient";
	}
	
	@RequestMapping(value={"/editPatientSave"},method={RequestMethod.POST})
	@ResponseBody
	public String editPatientSave(PubPatient patient,Model model){
		if(patient!=null){
			String patientName = patient.getPatientName();
			if(StringUtil.isNotBlank(patientName)){
				patient.setPatientNamePy(PyUtil.getFirstSpell(patientName).toUpperCase());
			}
			patient.setSexName(UserSexEnum.getNameById(patient.getSexId()));
			if(StringUtil.isNotBlank(patient.getPatientSourceId())){
				patient.setPatientSourceName(PatientSourceEnum.getNameById(patient.getPatientSourceId()));
			}
			if(pubPatientBiz.savePatient(patient) != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	//*********不良事件************
	
	/**
	 * 受试者ae列表
	 * @param patientFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/aeList"},method={RequestMethod.GET})
	public String aeList(String patientFlow, Model model){
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatientAe patientAe = new PubPatientAe();
			patientAe.setPatientFlow(patientFlow);
			List<PubPatientAe> patientAeList = patientAeBiz.searchPatientAeList(patientAe);
			model.addAttribute("patientAeList", patientAeList);
			PubProj proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
			model.addAttribute("proj", proj);
			return "gcp/patientAe/list";
		}else{
			return editAe(patientFlow, null, model);
		}
	}
	
	/**
	 * 跳转至不良事件报告表
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value={"/editAe"},method={RequestMethod.GET})
	public String editAe(String patientFlow, String recordFlow, Model model){
		PubProj proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
		model.addAttribute("proj", proj);
		String category = proj.getProjCategoryId();
		String formFileName = IrbRecTypeEnum.SaeApplication.getId();
		if(StringUtil.isNotBlank(formFileName)){ 
			String productType = InitConfig.getSysCfg("irb_form_category");
			if(StringUtil.isBlank(productType)){
				productType = GlobalConstant.IRB_FORM_PRODUCT;
			}
			String currVer = InitConfig.formRequestUtil.getVersionMap().get(formFileName);
			if(StringUtil.isBlank(currVer)){
				currVer = GlobalConstant.IRB_FORM_PRODUCT_VER;
			}
			Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
			IrbSingleForm singleForm = 	singleFormMap.get(productType+"_"+category+"_"+currVer);
			if(singleForm == null){
				logger.info("未配置该项目类型表单，默认使用药物申请表单!");
				singleForm = singleFormMap.get(productType+"_"+ProjCategroyEnum.Yw.getId()+"_"+currVer);
			}  
			if(singleForm == null){
				throw new RuntimeException("未发现表单 项目类别:"+proj.getProjCategoryName()+",伦理审查类别:"+IrbTypeEnum.Sae.getId()+",模版类型:"+productType+",版本号:"+currVer);
			}
			model.addAttribute("formFileName", formFileName);
			String jspPath = singleForm.getJspPath();
			//irb/form/{0}/application/init_{1}_{2}
			if(StringUtil.isNotBlank(jspPath)){
				jspPath = MessageFormat.format(jspPath,singleForm.getProductType(),singleForm.getCategory(),singleForm.getVersion());
			}
			
			Map<String,String> formDataMap = new HashMap<String, String>();
			
			PubPatientAe patientAe = patientAeBiz.readPatientAe(recordFlow);
			if(patientAe != null){
				String content = patientAe.getAeInfo();
				try {
					Document document = DocumentHelper.parseText(content);
					Element rootElement = document.getRootElement();
					List<Element> elements = rootElement.elements();
					if (elements != null && elements.size()>0) {
						for(Element element : elements){
							List<Node> valueNodes = element.selectNodes("value");
							if(valueNodes != null && valueNodes.size()>0){
								String value = "";
								for(Node node : valueNodes){
									if(StringUtil.isNotBlank(value)){
										value+=",";
									}
									value += node.getText();
								}
								formDataMap.put(element.getName(), value);
							}else {
								formDataMap.put(element.getName(), element.getText());
							}
						}
					}
				} catch (DocumentException e) {
					e.printStackTrace();
				}
			}
			model.addAttribute("formDataMap", formDataMap);
			return jspPath ;
		}
		return "error/404";
	}
	
	/**
	 * 不良事件一览表
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/patientAeView"},method={RequestMethod.GET})
	public String patientAeView(String projFlow,Model model){
		PubProj proj = null;
		if (StringUtil.isNotBlank(projFlow)) {
			proj = pubProjBiz.readProject(projFlow);
		} else {
			proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
		}
		if(proj != null){
			if (GcpProjStatusEnum.Passed.getId().equals(proj.getProjStatusId()) && GlobalContext.getCurrentUser().getUserFlow().equals(proj.getApplyUserFlow())) {
				PubPatientAe patientAe = new PubPatientAe();
				patientAe.setProjFlow(proj.getProjFlow());
				patientAe.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
				List<PubPatientAe> patientAeList = patientAeBiz.searchPatientAeList(patientAe);
				model.addAttribute("patientAeList",patientAeList);
			}
			model.addAttribute("proj",proj);
		} else {
			setSessionAttribute(GCP_CURR_PROJ,null);
		}
		return "gcp/patientAe/view";
	}
	
	/**
	 * 保存不良事件报告表
	 * @param formFileName
	 * @param patientFlow
	 * @param orgFlow
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/savePatientAe"},method={RequestMethod.POST})
	@ResponseBody
	public String savePatientAe(String formFileName, String patientFlow, String orgFlow, String recordFlow, HttpServletRequest req)throws Exception{
		PubProj proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
		if(proj != null && StringUtil.isNotBlank(formFileName)){ 
			String category = proj.getProjCategoryId();
			
			String productType = InitConfig.getSysCfg("irb_form_category");
			if(StringUtil.isBlank(productType)){
				productType = GlobalConstant.IRB_FORM_PRODUCT;
			}
			String currVer = InitConfig.formRequestUtil.getVersionMap().get(formFileName);
			if(StringUtil.isBlank(currVer)){
				currVer = GlobalConstant.IRB_FORM_PRODUCT_VER;
			}
			Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
			if(singleFormMap != null){
				IrbSingleForm singleForm = 	singleFormMap.get(productType+"_"+category+"_"+currVer);
				if(singleForm == null){
					logger.info("未配置该项目类型表单，默认使用药物申请表单!");
					singleForm = 	singleFormMap.get(productType+"_"+ProjCategroyEnum.Yw.getId()+"_"+currVer);
				}  
				
				if(singleForm == null){
					throw new RuntimeException("未发现表单: 项目类别"+proj.getProjCategoryName()+",伦理审查类别:"+IrbTypeEnum.Sae.getId()+",模版类型:"+productType+",版本号:"+currVer);
				}
				logger.info(formFileName+"=="+singleForm.getItemList().size()+"==="); 
				//**********************
				PubPatient patient = pubPatientBiz.readPatient(patientFlow);
				if(patient != null){
					PubPatientAe patientAe = new PubPatientAe();
					patientAe.setRecordFlow(recordFlow);
					patientAe.setPatientFlow(patientFlow);
					patientAe.setPatientCode(patient.getPatientCode());
					patientAe.setPatientNamePy(patient.getPatientNamePy());
					patientAe.setOrgFlow(orgFlow);
					patientAe.setProjFlow(proj.getProjFlow());
					patientAe.setAeName(req.getParameter("saeName"));
					patientAe.setIsSae(GlobalConstant.FLAG_Y);
					patientAe.setReportDate(req.getParameter("firstReportDate"));
					if (singleForm != null) {
						//因果关系
						Map<String,CodeValues> codeValuesMap = singleForm.getItemCodeMap().get("aeRelations");
						if(codeValuesMap != null){
							CodeValues codevalue = codeValuesMap.get(req.getParameter("aeRelations"));
							if(codevalue != null){
								String aeRelations = codevalue.getText();
								patientAe.setAeRelations(aeRelations);
							}
						}
						
						//报告类型名称
						Map<String,CodeValues> codeValuesMap2 = singleForm.getItemCodeMap().get("reportType");
						if(codeValuesMap2 != null){
							CodeValues codevalue = codeValuesMap2.get(req.getParameter("reportType"));
							if(codevalue != null){
								String reportType = codevalue.getText();
								patientAe.setReportType(reportType);
							}
						}
					}
					String recContent = _getRecContent(formFileName, singleForm.getItemList(), req);
					patientAe.setAeInfo(recContent);
					int result = patientAeBiz.save(patientAe);
					if(result != GlobalConstant.ZERO_LINE){
						//return GlobalConstant.SAVE_SUCCESSED;
						return patientAe.getRecordFlow();
					}
				}
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 获取XML表单内容
	 * @param formName
	 * @param list
	 * @param req
	 * @return
	 */
	private String _getRecContent(String formName,List<Element> list,HttpServletRequest req) { 
		Element rootEle = DocumentHelper.createElement(formName);
		if(list !=null && list.size()>0){
			for(Element itemEle : list){
				String multiple = itemEle.attributeValue("multiple");
				if(GlobalConstant.FLAG_N.equals(multiple) || StringUtil.isBlank(multiple)){
					String value = req.getParameter(itemEle.attributeValue("name"));
					Element element = DocumentHelper.createElement(itemEle.attributeValue("name")); 
					if (StringUtil.isNotBlank(value)) {
						element.setText(value);
					}
					rootEle.add(element);
				}else {
					String[] values = req.getParameterValues(itemEle.attributeValue("name"));
					Element element = DocumentHelper.createElement(itemEle.attributeValue("name")); 
					if(values!=null && values.length>0){
						for(String value : values){
							Element valueEle = DocumentHelper.createElement("value"); 
							if (StringUtil.isNotBlank(value)) {
								valueEle.setText(value);
							}
							element.add(valueEle);
						}
					}
					rootEle.add(element);
				}
			}
		}
		return rootEle.asXML();
	}
	
	@RequestMapping(value={"/editRecipe"},method={RequestMethod.GET})
	public String editRecipe(String patientFlow, Model model){
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = pubPatientBiz.readPatient(patientFlow);
			model.addAttribute("patient",patient);
			
			PubProj proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
			if(proj != null){
				String projFlow = proj.getProjFlow();
				List<GcpDrug> drugList = gcpDrugBiz.searchDrugByProj(projFlow);
				if(drugList!=null && drugList.size()>0){
					Collections.sort(drugList,new Comparator<GcpDrug>() {
						@Override
						public int compare(GcpDrug d1, GcpDrug d2) {
							if(GcpDrugTypeEnum.ExamDrug.getId().equals(d2.getDrugTypeId())){
								return 1;
							}
							return -1;
						}
					});
					model.addAttribute("drugList",drugList);
				}
			}
		}
		return "gcp/patient/editRecipe";
	}
	
	@RequestMapping(value={"/saveRecipe"},method={RequestMethod.POST})
	@ResponseBody
	public String saveRecipe(String[] drugFlows,String drugPack,String patientFlow,String visitFlow,Model model){
		if(drugFlows!=null && drugFlows.length>0 && StringUtil.isNotBlank(patientFlow)){
			PubProj proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
			SysUser user = GlobalContext.getCurrentUser();
			PubPatient patient = pubPatientBiz.readPatient(patientFlow);
			if(patient!=null){
				PubPatientRecipe patientRecipe = new PubPatientRecipe();
				patientRecipe.setPatientFlow(patientFlow);
				patientRecipe.setVisitFlow(visitFlow);
				patientRecipe.setPatientCode(patient.getPatientCode());
				patientRecipe.setPatientNamePy(patient.getPatientNamePy());
				patientRecipe.setOrgFlow(user.getOrgFlow());
				patientRecipe.setProjFlow(proj.getProjFlow());
				patientRecipe.setRecipeDate(DateUtil.getCurrDateTime());
				patientRecipe.setRecipeDoctorFlow(user.getUserFlow());
				patientRecipe.setRecipeDoctorName(user.getUserName());
				patientRecipe.setRecipeStatusId(PatientRecipeStatusEnum.UnDispens.getId());
				patientRecipe.setRecipeStatusName(PatientRecipeStatusEnum.UnDispens.getName());
				int result = gcpDrugBiz.saveRecipe(patientRecipe, drugFlows, drugPack);
				if(GlobalConstant.ONE_LINE == result){
					return GlobalConstant.SAVE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	//**************受试者一览表*******************
	
	@RequestMapping(value={"/patientView"},method={RequestMethod.GET})
	public String patientView(Model model){
		PubProj proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
		if(proj != null && GcpProjStatusEnum.Passed.getId().equals(proj.getProjStatusId()) && GlobalContext.getCurrentUser().getUserFlow().equals(proj.getApplyUserFlow())){
			List<PubPatient> patientList = pubPatientBiz.searchPatientNotFilter(proj.getProjFlow(),GlobalContext.getCurrentUser().getOrgFlow());
			if(patientList != null && !patientList.isEmpty()){
				//药物编码Map
				List<String> patientFlows = new ArrayList<String>();
				for(PubPatient patient : patientList){
					patientFlows.add(patient.getPatientFlow());
				}
				Map<String,List<String>> patientDrugPackMap = gcpDrugBiz.getPatientDrugPackMap(patientFlows);
				model.addAttribute("patientDrugPackMap",patientDrugPackMap);
			}
			model.addAttribute("patientList",patientList);
			model.addAttribute("proj",proj);
		} else {
			setSessionAttribute(GCP_CURR_PROJ,null);
		}
		return "gcp/patient/list";
	}
	
	@RequestMapping(value={"/drugRecord"},method={RequestMethod.GET})
	public String drugRecord(String patientFlow,Model model){
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = pubPatientBiz.readPatient(patientFlow);
			model.addAttribute("patient",patient);
			
			List<PubPatientRecipe> patientRecipeList = recipeBiz.searchPatientRecipe(patientFlow);
			if(patientRecipeList!=null && patientRecipeList.size()>0){
				List<String> recipeFlows = new ArrayList<String>();
				for(PubPatientRecipe patientRecipe : patientRecipeList){
					recipeFlows.add(patientRecipe.getRecipeFlow());
				}
				List<PubPatientRecipeDrug> patientRecipeDrugTempList = recipeBiz.searchPatientRecipeDrugByRecipeFlows(recipeFlows);
				if(patientRecipeDrugTempList!=null && patientRecipeDrugTempList.size()>0){
					Map<String,List<PubPatientRecipeDrug>> patientRecipeDrugMap = new HashMap<String,List<PubPatientRecipeDrug>>();
					for(PubPatientRecipeDrug patientRecipeDrug : patientRecipeDrugTempList){
						if(patientRecipeDrugMap.get(patientRecipeDrug.getRecipeFlow())==null){
							List<PubPatientRecipeDrug> patientRecipeDrugList = new ArrayList<PubPatientRecipeDrug>();
							patientRecipeDrugList.add(patientRecipeDrug);
							patientRecipeDrugMap.put(patientRecipeDrug.getRecipeFlow(),patientRecipeDrugList);
						}else{
							patientRecipeDrugMap.get(patientRecipeDrug.getRecipeFlow()).add(patientRecipeDrug);
						}
					}
					model.addAttribute("patientRecipeDrugMap",patientRecipeDrugMap);
				}
				model.addAttribute("patientRecipeList",patientRecipeList);
			}
		}
		return "gcp/patient/drugRecord";
	}
	
	@RequestMapping(value = {"/changePatientStage" },method={RequestMethod.POST})
	@ResponseBody
	public String changePatientStage(String patientFlow,String patientStageId,String patientStageNote) {
		PubPatient patient = pubPatientBiz.readPatient(patientFlow);
		if (patient != null) {
			patient.setPatientStageId(patientStageId);
			patient.setPatientStageName(PatientStageEnum.getNameById(patientStageId));
			patient.setPatientStageNote(StringUtil.defaultString(patientStageNote));	//备注：如脱落原因
			pubPatientBiz.modifyPatient(patient);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value = {"/patientStageNote" },method={RequestMethod.GET})
	public String patientStageNote(String patientFlow,Model model) {
		PubPatient patient = pubPatientBiz.readPatient(patientFlow);
		model.addAttribute("patient", patient);
		return "gcp/patient/patientStageNote";
	}
	
	@RequestMapping(value={"/followRemind"},method={RequestMethod.GET})
	public String followRemind(Model model){
		String noGroupKey = "noGroup";
		String currWsId = (String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		PubProj proj = null;
		boolean toSearch = false;
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		String orgFlow = null;
		if(GlobalConstant.GCP_WS_ID.equals(currWsId)){
			proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
			orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			toSearch = proj != null && GcpProjStatusEnum.Passed.getId().equals(proj.getProjStatusId()) && userFlow.equals(proj.getApplyUserFlow());
		}else{
			proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
			toSearch = proj != null;
		}
		model.addAttribute("proj",proj);
		
		if(toSearch){
			PubPatient searchPatient = new PubPatient();
			searchPatient.setProjFlow(proj.getProjFlow());
			searchPatient.setOrgFlow(orgFlow);
			searchPatient.setInDate(GlobalConstant.FLAG_N);
			List<PubPatient> patientList = pubPatientBiz.searchPatientList(searchPatient);
			model.addAttribute("patientList",patientList);
			if(patientList != null && !patientList.isEmpty()){
				//药物编码Map
				List<String> patientFlows = new ArrayList<String>();
				for(PubPatient patient : patientList){
					patientFlows.add(patient.getPatientFlow());
				}
				Map<String,List<String>> patientDrugPackMap = gcpDrugBiz.getPatientDrugPackMap(patientFlows);
				model.addAttribute("patientDrugPackMap",patientDrugPackMap);
				
				//访视分组
				Map<String,List<EdcVisit>> visitListMap = new HashMap<String, List<EdcVisit>>();
				Map<String,List<String>> visitFlowsMap = new HashMap<String, List<String>>();
				Map<String,String> patientGroupMap = null;
				List<EdcGroup> groupList = groupBiz.searchEdcGroup(proj.getProjFlow());
				if (groupList != null && groupList.size() >0) {
					List<EdcRandomRec> randomRecList = randomBiz.searchRandomRec(patientFlows);
					if(randomRecList!=null && randomRecList.size()>0){
						patientGroupMap = new HashMap<String, String>();
						for(EdcRandomRec randomRec : randomRecList){
							if(patientGroupMap.get(randomRec.getPatientFlow())==null){
								patientGroupMap.put(randomRec.getPatientFlow(),randomRec.getDrugGroup());
							}
						}
						
						for(EdcGroup group : groupList){
							List<EdcVisit> visitTempList = visitBiz.searchVisitsByGroupFlow(proj.getProjFlow(),group.getGroupFlow(),null);
							if(visitTempList!=null && visitTempList.size()>0){
								visitListMap.put(group.getGroupName(),visitTempList);
								List<String> visitFlowsTemp = new ArrayList<String>();
								visitFlowsMap.put(group.getGroupName(),visitFlowsTemp);
								for(EdcVisit visit : visitTempList){
									visitFlowsTemp.add(visit.getVisitFlow());
								}
							}
						}
					}
				} else {
					List<EdcVisit> visitTempList = visitBiz.searchVisitList(proj.getProjFlow(),GlobalConstant.FLAG_Y);
					if(visitTempList!=null && visitTempList.size()>0){
						visitListMap.put(noGroupKey,visitTempList);
						List<String> visitFlowsTemp = new ArrayList<String>();
						visitFlowsMap.put(noGroupKey,visitFlowsTemp);
						for(EdcVisit visit : visitTempList){
							visitFlowsTemp.add(visit.getVisitFlow());
						}
					}
				}
				//获取上一次和下一次访视信息
				if(visitListMap.size()>0){
					String currDate = DateUtil.getCurrDate();
					final Map<String,Map<String,Object>> patientVisitMap = new HashMap<String,Map<String,Object>>();
					//获取所有该项目病人访视窗
					List<PubPatientWindow> windowList = windowBiz.searchPatientWindowByPatientFlows(proj.getProjFlow(),patientFlows);
					if(windowList!=null && windowList.size()>0){
						Map<String,PubPatientWindow> windowMap = new HashMap<String, PubPatientWindow>();
						Map<String,List<PubPatientWindow>> WindowListMap = new HashMap<String, List<PubPatientWindow>>();
						for(PubPatientWindow window : windowList){
							windowMap.put(window.getPatientFlow()+window.getVisitFlow(),window);
							if(WindowListMap.get(window.getPatientFlow())==null){
								List<PubPatientWindow> windowListTemp = new ArrayList<PubPatientWindow>();
								windowListTemp.add(window);
								WindowListMap.put(window.getPatientFlow(),windowListTemp);
							}else{
								WindowListMap.get(window.getPatientFlow()).add(window);
							}
						}
						for(String patientFlow : patientFlows){
							List<String> visitFlows = null;
							if(groupList != null && groupList.size() >0){
								visitFlows = visitFlowsMap.get(patientGroupMap.get(patientFlow));
							}else{
								visitFlows = visitFlowsMap.get(noGroupKey);
							}
							Map<String,Object> patientVisitInfo = new HashMap<String, Object>();
							int index = 0;
							if(WindowListMap.get(patientFlow)!=null && WindowListMap.get(patientFlow).size()>0){
								PubPatientWindow beforwindow = WindowListMap.get(patientFlow).get(0);
								if(beforwindow!=null){
									patientVisitInfo.put("beforeVisit",windowMap.get(patientFlow+(beforwindow.getVisitFlow())));
									index = visitFlows.indexOf(beforwindow.getVisitFlow())+1;
								}
							}
							if(index<visitFlows.size()){
								PubPatientWindow windowTemp = windowMap.get(patientFlow+visitFlows.get(index));
								if(windowTemp!=null){
									patientVisitInfo.put("nextWindow",windowTemp);
									if(StringUtil.isNotBlank(windowTemp.getWindowVisitLeft()) && StringUtil.isNotBlank(windowTemp.getWindowVisitRight())){
										patientVisitInfo.put("remindDays",DateUtil.signDaysBetweenTowDate(windowTemp.getWindowVisitLeft(),currDate));
										patientVisitInfo.put("outDays",DateUtil.signDaysBetweenTowDate(currDate,windowTemp.getWindowVisitRight()));
									}
								}	
							}
							patientVisitMap.put(patientFlow,patientVisitInfo);
						}
					}
					//排序
					Collections.sort(patientList,new Comparator<PubPatient>() {
						@Override
						public int compare(PubPatient p1, PubPatient p2) {
							Map<String,Object> p1VisitInfoMap = patientVisitMap.get(p1.getPatientFlow());
							Map<String,Object> p2VisitInfoMap = patientVisitMap.get(p2.getPatientFlow());
							if(p1VisitInfoMap==null && p2VisitInfoMap!=null){
								return 1;
							}else if(p2VisitInfoMap==null && p1VisitInfoMap!=null){
								return -1;
							}else if(p1VisitInfoMap!=null && p2VisitInfoMap!=null){
								Long p1RemindDays = (Long)p1VisitInfoMap.get("remindDays");
								Long p2RemindDays = (Long)p2VisitInfoMap.get("remindDays");
								if(p1RemindDays!=null && p2RemindDays!=null){
									return (int) (p1RemindDays-p2RemindDays);
								}else if(p1RemindDays==null && p2RemindDays!=null){
									return 1;
								}else if(p2RemindDays==null && p1RemindDays!=null){
									return -1;
								}
							}
							return 0;
						}
					});
					model.addAttribute("patientVisitMap",patientVisitMap);
				}
			}
		} else {
			setSessionAttribute(GCP_CURR_PROJ,null);
		}
		return "gcp/patient/followRemind";
	}
	
	//保存受试者的访视通知状态
	@RequestMapping(value = {"/saveWindowNotice" },method={RequestMethod.POST})
	@ResponseBody
	public String saveWindowNotice(String patientFlow,String projFlow,String visitFlow) {
		if(StringUtil.isNotBlank(projFlow) && StringUtil.isNotBlank(projFlow) && StringUtil.isNotBlank(visitFlow)){
			if(windowBiz.savePatientWindow(projFlow,patientFlow,visitFlow)!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value={"/visit"},method={RequestMethod.GET})
	public String  visit(String patientFlow,Model model){
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = pubPatientBiz.readPatient(patientFlow);
			model.addAttribute("patient",patient);
			if(patient!=null){
				List<EdcVisit> visitList = visitBiz.searchVisitList(patient.getProjFlow(),GlobalConstant.FLAG_Y);
				if(visitList!=null && visitList.size()>0){
					PubPatientVisit temp = new PubPatientVisit();
					temp.setProjFlow(patient.getProjFlow());
					temp.setOrgFlow(patient.getOrgFlow());
					temp.setPatientFlow(patientFlow);
					List<PubPatientVisit> patientVisitList = visitBiz.searchPatientVisit(temp);
					
					if (patientVisitList != null && patientVisitList.size() >0) {
						model.addAttribute("patientVisitList",patientVisitList);
						
						Map<String,Map<String,String>> visitInfoMap = new HashMap<String, Map<String,String>>();
						for (PubPatientVisit visit:patientVisitList) {
							temp = visitBiz.readPatientVisit(visit.getRecordFlow());
							Map<String,String> tempMap = createVisitInfoMap(temp.getVisitInfo());
							
							PubPatientRecipe patientRecipe = new PubPatientRecipe();
							patientRecipe.setPatientFlow(visit.getPatientFlow());
							patientRecipe.setVisitFlow(visit.getVisitFlow());
							List<PubPatientRecipe> patientRecipeList = recipeBiz.searchPatientRecipeByPatientRecipe(patientRecipe);
							if(patientRecipeList!=null && patientRecipeList.size()>0){
								if(tempMap==null){
									tempMap = new HashMap<String, String>();
								}
								tempMap.put("recipeInfo",patientRecipeList.size()+"");
							}
							visitInfoMap.put(temp.getRecordFlow(),tempMap);
						}
						model.addAttribute("visitInfoMap",visitInfoMap);
						
						List<String> visitFlowList = new ArrayList<String>();
						for(EdcVisit visit : visitList){
							visitFlowList.add(visit.getVisitFlow());
						}
						temp = patientVisitList.get(0);
						int index = visitFlowList.indexOf(temp.getVisitFlow())+1;
						model.addAttribute("hasNextVisit",visitList.size()>index);
					}
				}
			}
		}
		return "gcp/patient/visit";
	}
	
	@RequestMapping(value={"/patientInfo"},method={RequestMethod.GET})
	public String  patientInfo(String patientFlow,String date,Model model){
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = pubPatientBiz.readPatient(patientFlow);
			model.addAttribute("patient",patient);
			
			String projFlow = patient.getProjFlow();
			String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			
			List<EdcVisit> visitList = visitBiz.searchVisitList(patient.getProjFlow(),GlobalConstant.FLAG_Y);
			if(visitList!=null && visitList.size()>0){
				List<String> visitFlows = new ArrayList<String>();
				for(EdcVisit visit : visitList){
					visitFlows.add(visit.getVisitFlow());
				}
				
				PubPatientVisit temp = new PubPatientVisit();
				temp.setProjFlow(projFlow);
				temp.setOrgFlow(orgFlow);
				temp.setPatientFlow(patientFlow);
				List<PubPatientVisit> patientVisitList = visitBiz.searchPatientVisit(temp);
				if(patientVisitList!=null && patientVisitList.size()>0){
					PubPatientVisit patientVisit = patientVisitList.get(0);
					String lastVisitDate = patientVisit.getVisitDate();
					model.addAttribute("lastVisitDate",lastVisitDate);
					
					int index = visitFlows.indexOf(patientVisit.getVisitFlow())+1;
					int visitSize = visitList.size();
					if(index<visitSize){
						PubPatientWindow window = new PubPatientWindow();
						window.setPatientFlow(patientFlow);
						window.setProjFlow(projFlow);
						window.setVisitFlow(visitFlows.get(index));
						List<PubPatientWindow> windowList = windowBiz.searchPatientWindowList(window);
						if(windowList!=null && windowList.size()>0){
							window = windowList.get(0);
							if(StringUtil.isNotBlank(window.getWindowVisitLeft()) && StringUtil.isNotBlank(window.getWindowVisitRight()) && StringUtil.isNotBlank(date)){
								if(window.getWindowVisitLeft().compareTo(date)>0){
									window.setOutWindowTypeName(OutWindowTypeEnum.Earlier.getName());
								}else if(window.getWindowVisitRight().compareTo(date)<0){
									window.setOutWindowTypeName(OutWindowTypeEnum.Delayed.getName());
								}
							}
							if(StringUtil.isBlank(window.getOutWindowTypeName())){
								window.setOutWindowTypeName("否");
							}
							model.addAttribute("window",window);
						}
					}
				}
			}
		}
		return "gcp/patient/patientInfo";
	}
	
	@RequestMapping(value = {"/savePatientVisit" },method={RequestMethod.POST})
	@ResponseBody
	public String savePatientVisit(PubPatientVisit patientVisit) {
		if(patientVisit!=null){
			patientVisit.setVisitOperFlow(GlobalContext.getCurrentUser().getUserFlow());
			if(StringUtil.isNotBlank(patientVisit.getPatientFlow())){
				PubPatient patient = pubPatientBiz.readPatient(patientVisit.getPatientFlow());
				if(patient!=null){
					patientVisit.setProjFlow(patient.getProjFlow());
					patientVisit.setOrgFlow(patient.getOrgFlow());
				}
			}
			if(StringUtil.isNotBlank(patientVisit.getVisitFlow())){
				EdcVisit visit = visitBiz.readVisit(patientVisit.getVisitFlow());
				if(visit!=null){
					patientVisit.setVisitName(visit.getVisitName());
				}
			}
			if(visitBiz.savePatientVisit(patientVisit)!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value={"/patientVisitInfo"},method={RequestMethod.GET})
	public String  patientVisitInfo(String patientFlow,String visitFlow,Model model){
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = pubPatientBiz.readPatient(patientFlow);
			model.addAttribute("patient",patient);
			
			if(StringUtil.isNotBlank(visitFlow)){
				PubPatientVisit patientVisit = new PubPatientVisit();
				patientVisit.setPatientFlow(patientFlow);
				patientVisit.setVisitFlow(visitFlow);
				List<PubPatientVisit> patientVisitList = visitBiz.searchPatientVisit(patientVisit);
				if(patientVisitList!=null && patientVisitList.size()>0){
					patientVisit = visitBiz.readPatientVisit(patientVisitList.get(0).getRecordFlow());
					model.addAttribute("patientVisit",patientVisit);
					
					Map<String,String> visitInfoMap = createVisitInfoMap(patientVisit.getVisitInfo());
					model.addAttribute("visitInfoMap",visitInfoMap);
				}
				PubPatientRecipe patientRecipe = null;
				PubPatientRecipe temp = new PubPatientRecipe();
				temp.setPatientFlow(patientFlow);
				temp.setVisitFlow(visitFlow);
				List<PubPatientRecipe> patientRecipeList = recipeBiz.searchPatientRecipeByPatientRecipe(temp);
				if(patientRecipeList!=null && patientRecipeList.size()>0){
					patientRecipe = patientRecipeList.get(0);
					List<PubPatientRecipeDrug> patientRecipeDrugList = recipeBiz.searchPatientRecipeDrug(patientRecipe.getRecipeFlow());
					if(patientRecipeDrugList!=null && patientRecipeDrugList.size()>0){
						List<String> drugFlows = new ArrayList<String>();
						for(PubPatientRecipeDrug patientRecipeDrug : patientRecipeDrugList){
							drugFlows.add(patientRecipeDrug.getDrugFlow());
						}
						List<GcpDrug> drugList = gcpDrugBiz.searchDrugByDrugFlows(drugFlows);
						model.addAttribute("drugList",drugList);
					}
				}
				model.addAttribute("patientRecipe",patientRecipe);
				PubPatientWindow window = windowBiz.searchPatientWindow(patientFlow, visitFlow);
				model.addAttribute("window",window);
			}
		}
		return "gcp/patient/patientVisitInfo";
	}
	
	@RequestMapping(value = {"/editVisitInfo" },method={RequestMethod.GET})
	public String editVisitInfo(String recordFlow,String infoType,Model model) {
		if(StringUtil.isNotBlank(recordFlow)){
			PubPatientVisit patientVisit = visitBiz.readPatientVisit(recordFlow);
			if(patientVisit!=null){
				Map<String,String> visitInfoMap = createVisitInfoMap(patientVisit.getVisitInfo());
				if(visitInfoMap!=null){
					model.addAttribute("infoContent",visitInfoMap.get(infoType));
				}
			}
		}
		return "gcp/patient/visitInfo";
	}
	
	@RequestMapping(value = {"/saveVisitInfo" },method={RequestMethod.POST})
	@ResponseBody
	public String saveVisitInfo(String recordFlow,String infoType,String infoContent) {
		if(StringUtil.isNotBlank(recordFlow)){
			PubPatientVisit patientVisit = visitBiz.readPatientVisit(recordFlow);
			String visitInfo = null;
			if(patientVisit!=null){
				visitInfo = patientVisit.getVisitInfo();
			}
			visitInfo = createVisitInfoXml(visitInfo,infoType,infoContent);
			patientVisit.setVisitInfo(visitInfo);
			if(StringUtil.isNotBlank(visitInfo) && visitBiz.savePatientVisit(patientVisit)!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	private String createVisitInfoXml(String visitInfo,String name,String value){
		Document document = null;
		Element rootElement = null;
		try {
			if(StringUtil.isNotBlank(visitInfo)){
				document = DocumentHelper.parseText(visitInfo);
				rootElement = document.getRootElement();
			}else{
				document = DocumentHelper.createDocument();
				rootElement = document.addElement("visitInfo");
			}
			Element item = (Element) rootElement.selectSingleNode("item[@name='"+name+"']");
			if(item!=null){
				item.detach();
			}
			item = rootElement.addElement("item");
			item.addAttribute("name",name);
			item.setText(value);
			
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return document.asXML();
	}
	
	private Map<String,String> createVisitInfoMap(String visitInfo){
		Map<String,String> visitInfoMap = null;
		if(StringUtil.isNotBlank(visitInfo)){
			visitInfoMap = new HashMap<String,String>();
			try {
				Document document = DocumentHelper.parseText(visitInfo);
				Element root = document.getRootElement();
				List<Element> items = root.elements("item");
				if(items!=null && items.size()>0){
					for(Element element : items){
						visitInfoMap.put(element.attributeValue("name"),element.getText());
					}
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		return visitInfoMap;
	}
	
	@RequestMapping(value = {"/windowInfo" },method={RequestMethod.GET})
	public String windowInfo(String patientFlow,Model model){
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = pubPatientBiz.readPatient(patientFlow);
			model.addAttribute("patient",patient);
			if(patient!=null){
				List<EdcVisit> visitList = visitBiz.searchVisitList(patient.getProjFlow());
				if(visitList!=null && visitList.size()>0){
					model.addAttribute("visitList",visitList);
					
					PubPatientWindow window = new PubPatientWindow();
					window.setPatientFlow(patient.getPatientFlow());
					window.setProjFlow(patient.getProjFlow());
					List<PubPatientWindow> windowList = windowBiz.searchPatientWindowList(window);
					if(windowList!=null && windowList.size()>0){
						Map<String,PubPatientWindow> windowMap = new HashMap<String, PubPatientWindow>();
						for(PubPatientWindow windowTemp : windowList){
							windowMap.put(windowTemp.getVisitFlow(),windowTemp);
						}
						model.addAttribute("windowMap",windowMap);
					}
				}
			}
		}
		return "gcp/patient/windowInfo";
	}
}
