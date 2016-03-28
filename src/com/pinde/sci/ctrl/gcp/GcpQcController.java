package com.pinde.sci.ctrl.gcp;

import java.text.MessageFormat;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpFinBiz;
import com.pinde.sci.biz.gcp.IGcpProjBiz;
import com.pinde.sci.biz.gcp.IGcpQcRecordBiz;
import com.pinde.sci.biz.gcp.IGcpRecBiz;
import com.pinde.sci.biz.pub.IPubPatientAeBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.gcp.GcpQcCategoryEnum;
import com.pinde.sci.enums.gcp.GcpQcStatusEnum;
import com.pinde.sci.enums.gcp.GcpQcTypeEnum;
import com.pinde.sci.enums.gcp.GcpRecTypeEnum;
import com.pinde.sci.enums.pub.PatientStageEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.form.gcp.GcpMeetingForm;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.mo.GcpContract;
import com.pinde.sci.model.mo.GcpQcRecord;
import com.pinde.sci.model.mo.GcpQcRecordRec;
import com.pinde.sci.model.mo.GcpQcRemind;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientAe;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysDept;

@Controller
@RequestMapping("gcp/qc")
public class GcpQcController extends GeneralController{
	private static Logger logger = LoggerFactory.getLogger(GcpQcController.class);
	
	@Autowired
	private IGcpQcRecordBiz qcRecordBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IPubPatientBiz pubPatientBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IGcpProjBiz gcpProjBiz;
	@Autowired
	private IGcpRecBiz gcpRecBiz;
	@Autowired
	private IPubPatientAeBiz patientAeBiz;
	@Autowired
	private IGcpFinBiz gcpFinBiz;
	
	/**
	 * 跳转至质控页面
	 * */
	@RequestMapping(value={"/editQcRecord"},method={RequestMethod.GET})
	public String editQcRecord(String remindRecordFlow,String qcFlow,Model model){
		if(StringUtil.isNotBlank(qcFlow)){
			GcpQcRecord qcRecord = qcRecordBiz.readQcRecord(qcFlow);
			model.addAttribute("qcRecord",qcRecord);
		}
		if(StringUtil.isNotBlank(remindRecordFlow)){
			GcpQcRemind qcRemind = qcRecordBiz.readQcRemind(remindRecordFlow);
			model.addAttribute("qcRemind",qcRemind);
		}
		return "gcp/proj/qc/editQcRecord";
	}
	
	/**
	 * TODO 保存质控记录
	 * */
	@RequestMapping(value={"/saveQcRecord"},method={RequestMethod.POST})
	@ResponseBody
	public String saveQcRecord(String remindRecordFlow,GcpQcRecord qcRecord,Model model){
		if(qcRecord!=null){
			qcRecord.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			qcRecord.setQcTypeName(GcpQcTypeEnum.getNameById(qcRecord.getQcTypeId()));
			if(StringUtil.isNotBlank(qcRecord.getQcCategoryId())){
				qcRecord.setQcCategoryName(GcpQcCategoryEnum.getNameById(qcRecord.getQcCategoryId()));
			}
			if(!GcpQcTypeEnum.Inspection.getId().equals(qcRecord.getQcTypeId()) && StringUtil.isBlank(qcRecord.getQcFlow())){
				qcRecord.setQcStatusId(GcpQcStatusEnum.Save.getId());
				qcRecord.setQcStatusName(GcpQcStatusEnum.Save.getName());
			}
			return qcRecordBiz.editQcRecordRetuenFlow(qcRecord,remindRecordFlow);
		}
		return GlobalConstant.SAVE_FAIL;
	}

	/**
	 * 删除质控记录
	 * */
	@RequestMapping(value={"/delQcRecord"},method={RequestMethod.POST})
	@ResponseBody
	public String delQcRecord(GcpQcRecord qcRecord,Model model){
		if(qcRecord!=null && StringUtil.isNotBlank(qcRecord.getQcFlow())){
			qcRecord.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			if(qcRecordBiz.editQcRecord(qcRecord,null) != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * 跳转质控记录报告
	 * */
	@RequestMapping(value={"/qcDetail"},method={RequestMethod.GET})
	public String qcDetail(String projFlow,String qcFlow,Model model){
		if(StringUtil.isNotBlank(qcFlow) && StringUtil.isNotBlank(projFlow)){
			GcpQcRecord qcRecord = qcRecordBiz.readQcRecord(qcFlow);
			model.addAttribute("qcRecord",qcRecord);
			
			PubProj proj = pubProjBiz.readProject(projFlow);
			model.addAttribute("proj",proj);
		}
		return "gcp/proj/qc/qcDetail";
	}
	
	/**
	 * 加载质控详情
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	@RequestMapping(value={"/recordRecDetail"},method={RequestMethod.GET})
	public String recordRecDetail(String qcFlow,String projFlow,String recTypeId,Model model) throws Exception{
		if(StringUtil.isNotBlank(qcFlow)){
			boolean inFlag = GcpRecTypeEnum.IcfInspect.getId().equals(recTypeId) || GcpRecTypeEnum.Org_First_CheckList.getId().equals(recTypeId);
			boolean projFlag = StringUtil.isNotBlank(projFlow) && (
					GcpRecTypeEnum.Dept_OTG_CheckList.getId().equals(recTypeId) 
					|| GcpRecTypeEnum.InspectSummary.getId().equals(recTypeId) 
					|| GcpRecTypeEnum.Org_First_CheckList.getId().equals(recTypeId)
					);
			String formFileName = recTypeId;
			model.addAttribute("formFileName", formFileName);
			if(StringUtil.isNotBlank(formFileName)){ 
				String productType = InitConfig.getSysCfg("qc_form_category");
				if(StringUtil.isEmpty(productType)||StringUtil.isBlank(productType)){
					productType = GlobalConstant.QC_FORM_PRODUCT;
				}
				String currVer = "";	//若已保存过表单，则版本号通过qcRecordRec获取
				GcpQcRecordRec qcRecordRec = qcRecordBiz.readQcRecordRec(qcFlow, recTypeId);
				if (qcRecordRec != null) {
					currVer = qcRecordRec.getRecVersion();
					if(GcpRecTypeEnum.InspectSummary.getId().equals(qcRecordRec.getRecTypeId())){
						model.addAttribute("qcRecordRec", qcRecordRec);
					}
				} else {
					currVer = InitConfig.gcpFormRequestUtil.getVersionMap().get(formFileName);
				}
				if(StringUtil.isEmpty(currVer)||StringUtil.isBlank(currVer)){
					currVer = GlobalConstant.QC_FORM_PRODUCT_VER;
				}
				Map<String,IrbSingleForm> singleFormMap = InitConfig.gcpFormRequestUtil.getFormMap().get(formFileName);
				IrbSingleForm singleForm = singleFormMap.get(productType+"_"+currVer);
				if(singleForm == null){
					throw new RuntimeException("未发现表单 ,文件类型:"+GcpRecTypeEnum.getNameById(recTypeId)+",模版类型:"+productType+",版本号:"+currVer);
				}
				model.addAttribute("formFileName", formFileName);
				String jspPath = singleForm.getJspPath();
				if(StringUtil.isNotBlank(jspPath)){
					jspPath = MessageFormat.format(jspPath,singleForm.getProductType(),singleForm.getVersion());
				}
				
				Map<String,String> formDataMap = new HashMap<String, String>();
				if(qcRecordRec != null && StringUtil.isNotBlank(qcRecordRec.getRecContent())){
					String content = qcRecordRec.getRecContent();
					try {
						Document document = DocumentHelper.parseText(content);
						Element rootElement = document.getRootElement();
						List<Element> elements = rootElement.elements();
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
					} catch (DocumentException e) {
						e.printStackTrace();
					}
				}
				model.addAttribute("formDataMap", formDataMap);
				
				//加载入组信息
				if(inFlag){
					List<PubPatient> patientList = pubPatientBiz.searchPatient(projFlow,GlobalContext.getCurrentUser().getOrgFlow());
					if(patientList!=null && patientList.size()>0){
						boolean isSae = false;
						PubPatientAe patientAe = new PubPatientAe();
						patientAe.setProjFlow(projFlow);
						patientAe.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
						List<PubPatientAe> patientAeList = patientAeBiz.searchPatientAeList(patientAe);
						isSae = patientAeList!=null && patientAeList.size()>0 && GlobalConstant.FLAG_Y.equals(patientAeList.get(0).getIsSae());
							
						int in = 0;
						int off = 0;
						int finish = 0;
						int planSum = 0;
						int icfCount = 0;
						int inStage = 0;
						String firstInDate = null;
						String lastInDate = null;
						for(PubPatient patient : patientList){
							String inDate = patient.getInDate();
							if(StringUtil.isNotBlank(inDate)){
								in++;
								if(StringUtil.isBlank(firstInDate)){
									firstInDate = inDate;
								}else if(firstInDate.compareTo(inDate)>0){
									firstInDate = inDate;
								}
								
								if(StringUtil.isBlank(lastInDate)){
									lastInDate = inDate;
								}else if(lastInDate.compareTo(inDate)<0){
									lastInDate = inDate;
								}
							}
							if(StringUtil.isNotBlank(patient.getIcfDate())){
								icfCount++;
							}
							if(PatientStageEnum.Off.getId().equals(patient.getPatientStageId())){
								off++;
							}else if(PatientStageEnum.Finish.getId().equals(patient.getPatientStageId())){
								finish++;
							}else if(PatientStageEnum.In.getId().equals(patient.getPatientStageId())){
								inStage++;
							}
						}
						
						GcpContract contract = new GcpContract();
						contract.setProjFlow(projFlow);
						List<GcpContract> contractList = gcpFinBiz.searchContList(contract,null);
						if(contractList != null && contractList.size()>0){
							for(GcpContract contractTemp : contractList){
								if(contractTemp.getCaseNumber() != null){
									planSum+=contractTemp.getCaseNumber();
								}
							}
						}
						
						model.addAttribute("planSum",planSum);//计划数
						model.addAttribute("icfCount",icfCount);//知情数
						model.addAttribute("filterCount",patientList.size());//筛查数
						model.addAttribute("in",in);//入组数
						model.addAttribute("inStage",inStage);//进行中
						model.addAttribute("finish",finish);//完成
						model.addAttribute("off",off);//脱落
						model.addAttribute("isSae",isSae);//有无SAE
						model.addAttribute("firstInDate",firstInDate);//第一例入组时间
						model.addAttribute("lastInDate",lastInDate);//最后一例入组时间
					}
				}
				
				if (GcpRecTypeEnum.InspectSummary.getId().equals(recTypeId)) {
					List<GcpQcRecordRec> qcRecordRecList = qcRecordBiz.searchQcRecordRecByQcFlow(projFlow, qcFlow);
					if(qcRecordRecList!=null && qcRecordRecList.size()>0){
						Map<String,String> proplemMap = new HashMap<String, String>();
						for(GcpQcRecordRec temp : qcRecordRecList){
							String problem = "";
							String content = temp.getRecContent();
							try {
								Document document = DocumentHelper.parseText(content);
								Node problemNode = document.getRootElement().selectSingleNode("problem");
								if (problemNode != null) {
									problem = problemNode.getText();
								}
							} catch (DocumentException e) {
								e.printStackTrace();
							}
							proplemMap.put(temp.getRecTypeId(), problem);
						}
						model.addAttribute("proplemMap",proplemMap);
					}
				}
				
				//加载项目信息
				if(projFlag){
					ProjInfoForm projInfoForm = gcpProjBiz.searchGeneralInfo(projFlow);
					//项目来源/CRO
					ProjInfoForm projDeclarerInfoForm =gcpProjBiz.searchDeclarerAndCRO(projFlow);
					projDeclarerInfoForm.getProj().setProjInfo(null);
					projDeclarerInfoForm.setRegistCategory(projInfoForm.getRegistCategory());
					projDeclarerInfoForm.setIsLeader(projInfoForm.getIsLeader());
					projDeclarerInfoForm.setInterMulCenter(projInfoForm.getInterMulCenter());
					
					model.addAttribute("projInfoForm", projDeclarerInfoForm);
					
					//启动会日期
					GcpMeetingForm meetingForm = this.gcpRecBiz.searchMeeting(projFlow);
					model.addAttribute("meetingForm", meetingForm);
				}
				
				return jspPath;
			}
		}
		return "error/404";
	}
	
	/**
	 * 质控内容保存
	 * @throws Exception 
	 * */
	@RequestMapping(value={"/saveQcRecordRec"},method={RequestMethod.POST})
	@ResponseBody
	public String saveQcRecordRec(String formFileName,String recTypeId,String qcFlow,String projFlow,HttpServletRequest req){
		if(StringUtil.isNotBlank(formFileName)){
			String productType = InitConfig.getSysCfg("qc_form_category");
			if(StringUtil.isBlank(productType)){
				productType = GlobalConstant.QC_FORM_PRODUCT;
			}
			String currVer = "";	//若已保存过表单，则版本号通过qcRecordRec获取
			GcpQcRecordRec rec = qcRecordBiz.readQcRecordRec(qcFlow, recTypeId);
			if (rec != null) {
				currVer = rec.getRecVersion();
			} else {
				currVer = InitConfig.gcpFormRequestUtil.getVersionMap().get(formFileName);
			}
			if(StringUtil.isEmpty(currVer)||StringUtil.isBlank(currVer)){
				currVer = GlobalConstant.QC_FORM_PRODUCT_VER;
			}
			Map<String,IrbSingleForm> singleFormMap = InitConfig.gcpFormRequestUtil.getFormMap().get(formFileName);
			if(singleFormMap != null){
				IrbSingleForm singleForm = singleFormMap.get(productType+"_"+currVer);
				if(singleForm == null){
					throw new RuntimeException("未发现表单 ,文件类型:"+GcpRecTypeEnum.getNameById(recTypeId)+",模版类型:"+productType+",版本号:"+currVer);
				}
				String recContent = _getRecContent(formFileName, singleForm.getItemList(), req); 
				if(rec == null){
					rec = new GcpQcRecordRec();
				}
				rec.setProjFlow(projFlow);
				rec.setQcFlow(qcFlow);
				rec.setRecTypeId(recTypeId);
				rec.setRecTypeName(GcpRecTypeEnum.getNameById(recTypeId));
				rec.setRecVersion(currVer);
				rec.setRecContent(recContent);
				qcRecordBiz.saveQcRecordRec(rec);
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 质控内容提交
	 * @throws Exception 
	 * */
	@RequestMapping(value={"/submitQcRecord"},method={RequestMethod.POST})
	@ResponseBody
	public String submitQcRecord(String qcFlow,String qcStatusId){
		if(StringUtil.isNotBlank(qcFlow) && StringUtil.isNotBlank(qcStatusId)){
			GcpQcRecord qcRecord = new GcpQcRecord();
			qcRecord.setQcFlow(qcFlow);
			qcRecord.setQcStatusId(qcStatusId);
			qcRecord.setQcStatusName(GcpQcStatusEnum.getNameById(qcStatusId));
			if(qcRecordBiz.editQcRecord(qcRecord,null) != GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	private String _getRecContent(String formName,List<Element> list,HttpServletRequest req) { 
		Element rootEle = DocumentHelper.createElement(formName);
		if(list !=null && list.size()>0){
			for(Element itemEle : list){
				String multiple = itemEle.attributeValue("multiple");
				if(GlobalConstant.FLAG_N.equals(multiple) || StringUtil.isBlank(multiple)){
					String elementName = itemEle.attributeValue("name");
					String value = req.getParameter(elementName);
					Element element = DocumentHelper.createElement(elementName); 
					if (StringUtil.isNotBlank(value)) {
						element.setText(value);
					}
					rootEle.add(element);
				} else {
					String elementName = itemEle.attributeValue("name");
					String[] values = req.getParameterValues(elementName);
					Element element = DocumentHelper.createElement(elementName); 
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
	
	/**
	 * 跳转至机构质控列表
	 * */
	@RequestMapping(value={"/projQcList"},method={RequestMethod.GET,RequestMethod.POST})
	public String projQcList(PubProj proj,Model model){
		if(proj == null){
			proj = new PubProj();
		}
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		proj.setProjStageId(ProjStageEnum.Schedule.getId());
		proj.setApplyOrgFlow(orgFlow);
		List<PubProj> projList = pubProjBiz.queryProjList(proj);
		model.addAttribute("projList",projList);
		//查询当前机构所有科室
		SysDept dept = new SysDept();
		dept.setOrgFlow(orgFlow);
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList = this.deptBiz.searchDept(dept);
		model.addAttribute("deptList", deptList);
		//查询当前机构所有质控记录
		List<GcpQcRecord> qcRecordList = qcRecordBiz.searchQcRecord(orgFlow,null);
		if(qcRecordList!=null && qcRecordList.size()>0){
			Map<String,List<GcpQcRecord>> qcRecordMap = new HashMap<String, List<GcpQcRecord>>();
			for(GcpQcRecord qcRecord : qcRecordList){
				if(qcRecordMap.get(qcRecord.getProjFlow()+qcRecord.getQcCategoryId())==null){
					List<GcpQcRecord> qcRecordListTemp = new ArrayList<GcpQcRecord>();
					qcRecordListTemp.add(qcRecord);
					qcRecordMap.put(qcRecord.getProjFlow()+qcRecord.getQcCategoryId(),qcRecordListTemp);
				}else{
					qcRecordMap.get(qcRecord.getProjFlow()+qcRecord.getQcCategoryId()).add(qcRecord);
				}
			}
			model.addAttribute("qcRecordMap", qcRecordMap);
		}
		//查询当前机构所有提醒记录
		List<GcpQcRemind> qcRemindList = qcRecordBiz.searchQcRemind(orgFlow);
		if(qcRemindList!=null && qcRemindList.size()>0){
			Map<String,List<GcpQcRemind>> qcRemindMap = new HashMap<String, List<GcpQcRemind>>();
			for(GcpQcRemind qcRemind : qcRemindList){
				if(qcRemindMap.get(qcRemind.getProjFlow()+qcRemind.getQcCategoryId())==null){
					List<GcpQcRemind> qcRecordListTemp = new ArrayList<GcpQcRemind>();
					qcRecordListTemp.add(qcRemind);
					qcRemindMap.put(qcRemind.getProjFlow()+qcRemind.getQcCategoryId(),qcRecordListTemp);
				}else{
					qcRemindMap.get(qcRemind.getProjFlow()+qcRemind.getQcCategoryId()).add(qcRemind);
				}
			}
			model.addAttribute("qcRemindMap", qcRemindMap);
		}
		
		//查询入组信息
		PubPatient patientTemp = new PubPatient();
		patientTemp.setOrgFlow(orgFlow);
		List<PubPatient> patientList = pubPatientBiz.searchPatientList(patientTemp);
		if(patientList!=null && patientList.size()>0){
			Map<String,Map<String,String>> patientMap = new HashMap<String, Map<String,String>>(); 
			for(PubPatient patient : patientList){
				if(patientMap.get(patient.getProjFlow())==null){
					patientMap.put(patient.getProjFlow(),new HashMap<String, String>());
					patientMap.get(patient.getProjFlow()).put("firstInDate","");
					patientMap.get(patient.getProjFlow()).put("lastInDate","");
					patientMap.get(patient.getProjFlow()).put("firstPatientCode","");
					patientMap.get(patient.getProjFlow()).put("firstPatientNamePy","");
					patientMap.get(patient.getProjFlow()).put("isOverOneThird",GlobalConstant.FLAG_N);
					patientMap.get(patient.getProjFlow()).put("inCount","0");
					int planSum = 0 ;
					GcpContract contract = new GcpContract();
					contract.setProjFlow(patient.getProjFlow());
					List<GcpContract> contractList = gcpFinBiz.searchContList(contract,null);
					if(contractList != null && contractList.size()>0){
						for(GcpContract contractTemp : contractList){
							if(contractTemp.getCaseNumber() != null){
								planSum+=contractTemp.getCaseNumber();
							}
						}
					}
					patientMap.get(patient.getProjFlow()).put("planCount",planSum+"");
				}
				if(StringUtil.isNotBlank(patient.getInDate())){
					int inCount = Integer.parseInt(patientMap.get(patient.getProjFlow()).get("inCount"));
					patientMap.get(patient.getProjFlow()).put("inCount",(inCount+1)+"");
					if(StringUtil.isBlank(patientMap.get(patient.getProjFlow()).get("firstInDate"))){
						patientMap.get(patient.getProjFlow()).put("firstInDate",patient.getInDate());
						patientMap.get(patient.getProjFlow()).put("firstPatientCode",patient.getPatientCode());
						patientMap.get(patient.getProjFlow()).put("firstPatientNamePy",patient.getPatientNamePy());
					}else if(patient.getInDate().compareTo(patientMap.get(patient.getProjFlow()).get("firstInDate"))<0){
						patientMap.get(patient.getProjFlow()).put("firstInDate",patient.getInDate());
						patientMap.get(patient.getProjFlow()).put("firstPatientCode",patient.getPatientCode());
						patientMap.get(patient.getProjFlow()).put("firstPatientNamePy",patient.getPatientNamePy());
					}
					if(StringUtil.isBlank(patientMap.get(patient.getProjFlow()).get("lastInDate"))){
						patientMap.get(patient.getProjFlow()).put("lastInDate",patient.getInDate());
					}else if(patient.getInDate().compareTo(patientMap.get(patient.getProjFlow()).get("lastInDate"))>0){
						patientMap.get(patient.getProjFlow()).put("lastInDate",patient.getInDate());
					}
				}
			}
			if(patientMap.size()>0){
				for(String key : patientMap.keySet()){
					int inCount = Integer.parseInt(patientMap.get(key).get("inCount"));
					if(inCount!=0){
						int planCount = Integer.parseInt(patientMap.get(key).get("planCount"));
						if(planCount/inCount <= 3){
							patientMap.get(key).put("isOverOneThird",GlobalConstant.FLAG_Y);
						}
					}
				}
			}
			model.addAttribute("patientMap",patientMap);	
		}
		return "gcp/proj/qc/projQcList";
	}
	
	/**
	 * 跳转至机构质控提醒列表
	 * */
	@RequestMapping(value={"/orgRemindList"},method={RequestMethod.GET,RequestMethod.POST})
	public String projQcList(GcpQcRemind qcRemind,String projName,Model model){
		String projFlows = null;
		Map<String,PubProj> projMap = null;
		if(StringUtil.isNotBlank(projName)){
			PubProj proj = new PubProj();
			proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			proj.setProjName(projName);
			List<PubProj> projList = pubProjBiz.queryProjList(proj);
			if(projList!=null && projList.size()>0){
				projMap = new HashMap<String, PubProj>();
				for(PubProj projTemp : projList){
					projMap.put(projTemp.getProjFlow(),projTemp);
					if(StringUtil.isNotBlank(projFlows)){
						projFlows+=(","+projTemp.getProjFlow());
					}else{
						projFlows = projTemp.getProjFlow();
					}
				}
			}
		}
		if(StringUtil.isBlank(projName) || (StringUtil.isNotBlank(projName) && StringUtil.isNotBlank(projFlows))){
			if(qcRemind==null){
				qcRemind = new GcpQcRemind();
			}
			qcRemind.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			qcRemind.setProjFlow(projFlows);
			List<GcpQcRemind> qcRemindList = qcRecordBiz.searchQcRemindByQcRemind(qcRemind);
			if(qcRemindList!=null && qcRemindList.size()>0){
				if(projMap==null){
					List<String> projFlowList = new ArrayList<String>();
					for(GcpQcRemind qcRemindTemp : qcRemindList){
						projFlowList.add(qcRemindTemp.getProjFlow());
					}
					List<PubProj> projList = pubProjBiz.searchProjByProjFlows(projFlowList);
					if(projList!=null && projList.size()>0){
						projMap = new HashMap<String, PubProj>();
						for(PubProj projTemp : projList){
							projMap.put(projTemp.getProjFlow(),projTemp);
						}
					}
				}
				model.addAttribute("projMap", projMap);
				model.addAttribute("qcRemindList", qcRemindList);
			}
		}
		return "gcp/proj/qc/orgRemindList";
	}
}
