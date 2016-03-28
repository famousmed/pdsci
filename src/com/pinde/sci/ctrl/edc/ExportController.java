package com.pinde.sci.ctrl.edc;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.pdf.utils.ResourceLoader;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.biz.edc.IEdcModuleBiz;
import com.pinde.sci.biz.edc.IInputBiz;
import com.pinde.sci.biz.edc.IInspectBiz;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IVisitBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.edc.PatientTypeEnum;
import com.pinde.sci.model.edc.EdcDesignForm;
import com.pinde.sci.model.edc.PatientVisitForm;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcPatientVisit;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitAttribute;
import com.pinde.sci.model.mo.EdcVisitElement;
import com.pinde.sci.model.mo.EdcVisitModule;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientExample.Criteria;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;

@Controller
@RequestMapping("/edc/export")
public class ExportController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(ExportController.class);
	
	@Autowired
	private IPubPatientBiz patientBiz; 
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IVisitBiz visitBiz;
	@Autowired
	private IEdcModuleBiz edcModuleBiz; 
	@Autowired
	private IInputBiz inputBiz; 
	@Autowired
	private IInspectBiz inspectBiz;
	@Autowired
	private IEdcGroupBiz groupBiz;
	@Autowired
	private IFileBiz pubFileBiz;
	
	@RequestMapping(value = {"/crfExport" },method={RequestMethod.GET})
	public String crfExport(String orgFlow,String patientFlow,String type,Model model) {
		model.addAttribute("orgFlow", orgFlow);
		model.addAttribute("patientFlow", patientFlow);
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcProjParam projParam = inputBiz.readProjParam(projFlow);
		model.addAttribute("projParam", projParam);
		
		List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
		model.addAttribute("pubProjOrgList", pubProjOrgList);	
		
		if ("patient".equals(type)) {
			if(getSessionAttribute(GlobalConstant.PROJ_DESC_FORM)==null){
				logger.info("==============init proj desc ========");
				EdcDesignForm designForm = edcModuleBiz.getCrfDescForm(projFlow);
				setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, designForm);
			}
		} else {
			setSessionAttribute(GlobalConstant.PROJ_DESC_FORM, null);
		}
		
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
			model.addAttribute("patientList", patientList);
		}
		if(StringUtil.isNotBlank(patientFlow)){
			PubPatient patient = inputBiz.readPatient(patientFlow);
			if (patient.getOrgFlow().equals(orgFlow)) {
				model.addAttribute("patient", patient);
				
				//覆盖Session Patient
				setSessionAttribute(GlobalConstant.EDC_CURR_PATIENT,patient);
				
				
				//受试者访视
				Map<String,PatientVisitForm> patientSubmitVisitMap = inputBiz.getPatientSubmitVisitMap(projFlow,patientFlow);
				model.addAttribute("patientSubmitVisitMap", patientSubmitVisitMap);
				
				//受试者CRF-所有录入 数据 visitFlow-elementSerialSeqValueMap 
				Map<String,Map<String,Map<String,Map<String,EdcPatientVisitData>>>> patientCrfDataMap = new HashMap<String, Map<String,Map<String,Map<String,EdcPatientVisitData>>>>();
				for(Map.Entry<String, PatientVisitForm> entity : patientSubmitVisitMap.entrySet()){
					patientCrfDataMap.put(entity.getKey(), inputBiz.getelementSerialSeqValueMap(entity.getValue().getEdcPatientVisit().getRecordFlow()));
				}
				model.addAttribute("patientCrfDataMap", patientCrfDataMap);
			} else {
				model.addAttribute("patientFlow", "");
			}
		}
		
		return "/edc/export/crfExportMain";
	}
	
	/**
	 * TODO  数据导出列表
	 * */
	@RequestMapping(value={"/exportDataList"},method={RequestMethod.GET})
	public String exportDataList(Model model) {
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		model.addAttribute("proj",proj);
		
		String projFlow = proj.getProjFlow();
		
		List<EdcModule> moduleList = edcModuleBiz.searchModuleList(projFlow);
		model.addAttribute("moduleList",moduleList);
		
		return "/edc/export/exportData";
	}
	
	/**
	 * TODO  数据导出
	 * */
	@RequestMapping(value={"/exportData"},method={RequestMethod.POST})
	public void exportData(String[] moduleCodes,String[] moduleNames,String format,String isRar,String nameFlag,String visitStyle,HttpServletResponse response) throws Exception{
		PubProj proj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = proj.getProjFlow();
		
		EdcProjParam projParam = inputBiz.readProjParam(projFlow);
		
		EdcDesignForm designForm = edcModuleBiz.getCrfDescForm(projFlow);
		
		PubPatientExample exam = new PubPatientExample();
		Criteria criteria =  exam.createCriteria().andProjFlowEqualTo(projFlow).andPatientTypeIdEqualTo(PatientTypeEnum.Real.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		boolean isRandom = GeneralMethod.isRandom(projParam);
		if (isRandom) {		//随机试验过滤未入组样本
			criteria.andInDateIsNotNull();
		}
		exam.setOrderByClause("org_flow desc,patient_seq");
		List<PubPatient> patientList = patientBiz.searchPatient(exam);
		
		Map<String,Map<String,PatientVisitForm>> patientSubmitVisitMaps = null;
		Map<String,Map<String,Map<String,Map<String,Map<String,EdcPatientVisitData>>>>> patientCrfDataMaps = null;
		if(patientList!=null && patientList.size()>0){
			patientSubmitVisitMaps = new HashMap<String, Map<String,PatientVisitForm>>();
			patientCrfDataMaps = new HashMap<String, Map<String,Map<String,Map<String,Map<String,EdcPatientVisitData>>>>>();
			for(PubPatient patient : patientList){
				//受试者访视
				Map<String,PatientVisitForm> patientSubmitVisitMap = inputBiz.getPatientSubmitVisitMap(projFlow,patient.getPatientFlow());
				patientSubmitVisitMaps.put(patient.getPatientFlow(),patientSubmitVisitMap);
				
				//受试者CRF-所有录入 数据 visitFlow-elementSerialSeqValueMap 
				Map<String,Map<String,Map<String,Map<String,EdcPatientVisitData>>>> patientCrfDataMap = new HashMap<String, Map<String,Map<String,Map<String,EdcPatientVisitData>>>>();
				for(Map.Entry<String, PatientVisitForm> entity : patientSubmitVisitMap.entrySet()){
					patientCrfDataMap.put(entity.getKey(), inputBiz.getelementSerialSeqValueMap(entity.getValue().getEdcPatientVisit().getRecordFlow()));
				}
				patientCrfDataMaps.put(patient.getPatientFlow(),patientCrfDataMap);
			}
		}
		
		Map<String,List<EdcVisit>> moduleVisitMap = new HashMap<String, List<EdcVisit>>();
		for(EdcVisit visit : designForm.getVisitList()){
			List<EdcVisitModule> visitModuleList = designForm.getVisitModuleMap().get(visit.getVisitFlow());
			if(visitModuleList!=null){
				for(EdcVisitModule visitModule : visitModuleList){
					if(moduleVisitMap.get(visitModule.getModuleCode())==null){
						List<EdcVisit> visitList = new ArrayList<EdcVisit>();
						visitList.add(visit);
						moduleVisitMap.put(visitModule.getModuleCode(),visitList);
					}else{
						moduleVisitMap.get(visitModule.getModuleCode()).add(visit);
					}
				}
			}
		}
		
		
		
		//excel下载
		HSSFWorkbook workbook = new HSSFWorkbook();//表格对象
		
		Map<String,HSSFCellStyle> styleMap = createStyle(workbook);//单元格样式
		
		if(moduleCodes!=null && moduleCodes.length>0){
			Map<String,List<Map<String,String>>> titleMap = buildTitle(projFlow,visitStyle,moduleCodes,moduleVisitMap);
			Map<String,Map<String,Map<String,String>>> dataMap = getValue(moduleCodes,patientList,designForm,projFlow);
			for(int index = 0 ; index<moduleCodes.length ; index++){
				if(titleMap!=null){
					String moduleCode = moduleCodes[index];
					String moduleName = moduleNames[index];
					List<Map<String,String>> titleList = titleMap.get(moduleCode);
					int titleColNum = 0;
					int currentColNum = 0;
					
					HSSFSheet sheet = workbook.createSheet(moduleName);
					HSSFRow titleRow = sheet.createRow(0);
					
					currentColNum = titleColNum++;
					HSSFCell patientCodeTitle = titleRow.createCell(currentColNum);
					patientCodeTitle.setCellStyle(styleMap.get("title"));
				    patientCodeTitle.setCellValue("受试者编号");
				    sheet.setColumnWidth(currentColNum,4000);
				    
				    if("vertical".equals(visitStyle)){
				    	currentColNum = titleColNum++;
				    	HSSFCell visitNameTitle = titleRow.createCell(currentColNum);
				    	visitNameTitle.setCellStyle(styleMap.get("title"));
				    	visitNameTitle.setCellValue("访视名称");
					    sheet.setColumnWidth(currentColNum,5000);
				    }
				    
					if(titleList!=null && titleList.size()>0){
						for(Map<String,String> title : titleList){
							currentColNum = titleColNum++;
							HSSFCell titleCell = titleRow.createCell(currentColNum);
							titleCell.setCellStyle(styleMap.get("title"));
							titleCell.setCellValue(title.get("title"));
							int width = StringUtil.defaultString(title.get("title")).length()*800;
							if(width>65280) width=65280;
						    sheet.setColumnWidth(currentColNum,width);
							
							if(patientList!=null && patientList.size()>0){
								int rowNum = 1;
								for(PubPatient patient : patientList){
									List<EdcVisit> visitList = moduleVisitMap.get(moduleCode);
									if("vertical".equals(visitStyle)){
										if(visitList!=null && visitList.size()>0){
											for(EdcVisit visit : visitList){
												String key = patient.getPatientFlow()+"_"+visit.getVisitFlow()+"_"+moduleCode+"_"+title.get("elementCode");
												Map<String,Map<String,String>> seqValueMap = dataMap.get(key);
												int currRow = rowNum++;
												String value = "";
												HSSFRow bodyRow = sheet.getRow(currRow);
												if(bodyRow==null){
													bodyRow = sheet.createRow(currRow);
													
													HSSFCell codeCell = bodyRow.createCell(0);
													codeCell.setCellStyle(styleMap.get("body"));
													codeCell.setCellValue(patient.getPatientCode());
													int currWidth = sheet.getColumnWidth(0);
													int valueWidth = StringUtil.defaultString(patient.getPatientCode()).length()*600;
													if(currWidth<valueWidth){
														if(valueWidth>65280) valueWidth=65280;
														sheet.setColumnWidth(0,valueWidth);
													}
													
													HSSFCell visitCell = bodyRow.createCell(1);
													visitCell.setCellStyle(styleMap.get("body"));
													visitCell.setCellValue(visit.getVisitName());
													currWidth = sheet.getColumnWidth(1);
													valueWidth = StringUtil.defaultString(visit.getVisitName()).length()*600;
													if(currWidth<valueWidth){
														if(valueWidth>65280) valueWidth=65280;
														sheet.setColumnWidth(1,valueWidth);
													}
												}
												if(seqValueMap!=null){
													for(String seqValueMapKey : seqValueMap.keySet()){
														if(StringUtil.isNotBlank(value)){
															value += "\n";
														}
														value += (seqValueMap.size()>1?("("+seqValueMapKey+")"):"")+StringUtil.defaultString(seqValueMap.get(seqValueMapKey).get(title.get("attrCode")));
														int currWidth = sheet.getColumnWidth(currentColNum);
														int valueWidth = StringUtil.defaultString(value).length()*600;
														if(currWidth<valueWidth){
															if(valueWidth>65280) valueWidth=65280;
															sheet.setColumnWidth(currentColNum,valueWidth);
														}
													}
													HSSFCell bodyCell = bodyRow.createCell(currentColNum);
													bodyCell.setCellStyle(styleMap.get("body"));
													bodyCell.setCellValue(value);
												}else{
													HSSFCell bodyCell = bodyRow.createCell(currentColNum);
													bodyCell.setCellStyle(styleMap.get("body"));
												}
											}
										}
									}else{
										String key = patient.getPatientFlow()+"_"+title.get("visitFlow")+"_"+moduleCode+"_"+title.get("elementCode");
										Map<String,Map<String,String>> seqValueMap = dataMap.get(key);
										int currRow = rowNum++;
										String value = "";
										HSSFRow bodyRow = sheet.getRow(currRow);
										if(bodyRow==null){
											bodyRow = sheet.createRow(currRow);
											
											HSSFCell codeCell = bodyRow.createCell(0);
											codeCell.setCellStyle(styleMap.get("body"));
											codeCell.setCellValue(patient.getPatientCode());
										}
										if(seqValueMap!=null){
											for(String seqValueMapKey : seqValueMap.keySet()){
												if(StringUtil.isNotBlank(value)){
													value += "\n";
												}
												value += (seqValueMap.size()>1?("("+seqValueMapKey+")"):"")+StringUtil.defaultString(seqValueMap.get(seqValueMapKey).get(title.get("attrCode")));
												int currWidth = sheet.getColumnWidth(currentColNum);
												int valueWidth = StringUtil.defaultString(value).length()*600;
												if(currWidth<valueWidth){
													if(valueWidth>65280) valueWidth=65280;
													sheet.setColumnWidth(currentColNum,valueWidth);
												}
											}
											HSSFCell bodyCell = bodyRow.createCell(currentColNum);
											bodyCell.setCellStyle(styleMap.get("body"));
											bodyCell.setCellValue(value);
										}else{
											HSSFCell bodyCell = bodyRow.createCell(currentColNum);
											bodyCell.setCellStyle(styleMap.get("body"));
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		String outputFileClass = ResourceLoader.getPath("");
		String outputFile = new File(outputFileClass).getParentFile().getParent() + "/load/" + proj.getProjShortName() + StringUtil.defaultString(nameFlag) + ".xls" ;
		File file = new File(outputFile);
	    
	    workbook.write(new FileOutputStream(file));
	    pubFileBiz.downFile(file,response);
		
		
	}
	
	private Map<String,HSSFCellStyle> createStyle(HSSFWorkbook workbook){
		Map<String,HSSFCellStyle> styleMap = new HashMap<String, HSSFCellStyle>();
		
		HSSFCellStyle style = workbook.createCellStyle();
		
		style.setFillForegroundColor(HSSFColor.WHITE.index);
	    style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    style.setBorderRight(HSSFCellStyle.BORDER_THIN);
	    style.setBorderTop(HSSFCellStyle.BORDER_THIN);		
	    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    
	    HSSFFont font = workbook.createFont();
	    font.setFontHeightInPoints((short) 12);
	    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    
	    style.setFont(font);
	    
	    HSSFCellStyle style2 = workbook.createCellStyle();
	    style2.setFillForegroundColor(HSSFColor.WHITE.index);
	    style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	    style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
	    style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
	    style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    style2.setWrapText(true);
	    
	    HSSFFont font2 = workbook.createFont();
	    font2.setFontHeightInPoints((short) 10);
	    font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
	    
	    style2.setFont(font2);
	    
	    styleMap.put("title",style);
	    styleMap.put("body",style2);
		
		return styleMap;
	}
	
	private Map<String,List<Map<String,String>>> buildTitle(String projFlow,String visitStyle,String[] moduleCodes,Map<String,List<EdcVisit>> moduleVisitMap){
		List<EdcElement> elementList = edcModuleBiz.searchElementList(projFlow);
		Map<String,List<EdcElement>> elementMap = null;
		if(elementList!=null && elementList.size()>0){
			elementMap = new HashMap<String, List<EdcElement>>();
			for(EdcElement element : elementList){
				if(elementMap.get(element.getModuleCode())==null){
					List<EdcElement> elementListTemp = new ArrayList<EdcElement>();
					elementListTemp.add(element);
					elementMap.put(element.getModuleCode(),elementListTemp);
				}else{
					elementMap.get(element.getModuleCode()).add(element);
				}
			}
		}
		
		List<EdcAttribute> attributeList = edcModuleBiz.searchAttributeList(projFlow);
		Map<String,List<EdcAttribute>> attributeMap = null;
		if(attributeList!=null && attributeList.size()>0){
			attributeMap = new HashMap<String, List<EdcAttribute>>();
			for(EdcAttribute attr : attributeList){
				if(attributeMap.get(attr.getElementCode())==null){
					List<EdcAttribute> attrListTemp = new ArrayList<EdcAttribute>();
					attrListTemp.add(attr);
					attributeMap.put(attr.getElementCode(),attrListTemp);
				}else{
					attributeMap.get(attr.getElementCode()).add(attr);
				}
			}
		}
		
		List<EdcVisit> visitList = visitBiz.searchVisitList(projFlow);
		Map<String,List<Map<String,String>>> resultMap = new HashMap<String, List<Map<String,String>>>();
		
		if("vertical".equals(visitStyle)){
			for(String moduleCode :moduleCodes){
				if(elementMap!=null){
					List<EdcElement> elements = elementMap.get(moduleCode);
					if(elements!=null && elements.size()>0){
						for(EdcElement element : elements){
							if(attributeMap!=null){
								List<EdcAttribute> attrs = attributeMap.get(element.getElementCode());
								if(attrs!=null && attrs.size()>0){
									for(EdcAttribute attr : attrs){
										Map<String,String> attrMap = new HashMap<String, String>();
										if(GlobalConstant.FLAG_Y.equals(attr.getIsViewName())){
											attrMap.put("title",element.getElementName()+"．"+attr.getAttrName());
										}else{
											attrMap.put("title",element.getElementName());
										}
										attrMap.put("elementCode",element.getElementCode());
										attrMap.put("attrCode",attr.getAttrCode());
										if(resultMap.get(moduleCode)==null){
											List<Map<String,String>> attrList = new ArrayList<Map<String,String>>();
											attrList.add(attrMap);
											resultMap.put(moduleCode,attrList);
										}else{
											resultMap.get(moduleCode).add(attrMap);
										}
									}
								}
							}
						}
					}
				}
			}
		}else{
			for(String moduleCode :moduleCodes){
				if(visitList!=null && visitList.size()>0){
					for(EdcVisit visit : visitList){
						if(elementMap!=null){
							List<EdcElement> elements = elementMap.get(moduleCode);
							if(elements!=null && elements.size()>0){
								for(EdcElement element : elements){
									if(attributeMap!=null){
										List<EdcAttribute> attrs = attributeMap.get(element.getElementCode());
										if(attrs!=null && attrs.size()>0){
											for(EdcAttribute attr : attrs){
												Map<String,String> attrMap = new HashMap<String, String>();
												String title = visit.getVisitName()+"_";
												if(GlobalConstant.FLAG_Y.equals(attr.getIsViewName())){
													attrMap.put("title",title+element.getElementName()+"．"+attr.getAttrName());
												}else{
													attrMap.put("title",title+element.getElementName());
												}
												attrMap.put("elementCode",element.getElementCode());
												attrMap.put("attrCode",attr.getAttrCode());
												attrMap.put("visitFlow",visit.getVisitFlow());
												if(resultMap.get(moduleCode)==null){
													List<Map<String,String>> attrList = new ArrayList<Map<String,String>>();
													attrList.add(attrMap);
													resultMap.put(moduleCode,attrList);
												}else{
													resultMap.get(moduleCode).add(attrMap);
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		return resultMap;
	}
	
	private Map<String,Map<String,Map<String,String>>> getValue(String[] moduleCodes,List<PubPatient> patientList,EdcDesignForm designForm,String projFlow){
		Map<String,Map<String,Map<String,String>>> resultMap = new HashMap<String, Map<String,Map<String,String>>>();
		if(patientList!=null && patientList.size()>0){
			for(PubPatient patient : patientList){
				Map<String,PatientVisitForm> patientSubmitVisitMap = inputBiz.getPatientSubmitVisitMap(projFlow,patient.getPatientFlow());
				
				Map<String,Map<String,Map<String,Map<String,EdcPatientVisitData>>>> patientCrfDataMap = new HashMap<String, Map<String,Map<String,Map<String,EdcPatientVisitData>>>>();
				for(Map.Entry<String, PatientVisitForm> entity : patientSubmitVisitMap.entrySet()){
					patientCrfDataMap.put(entity.getKey(), inputBiz.getelementSerialSeqValueMap(entity.getValue().getEdcPatientVisit().getRecordFlow()));
				}
				
				if(designForm!=null){
					List<EdcVisit> visitList = designForm.getVisitList();
					if(visitList!=null && visitList.size()>0){
						for(EdcVisit visit : visitList){
							for(String moduleCode : moduleCodes){
								String commCode = visit.getVisitFlow()+"_"+moduleCode;
								Map<String,List<EdcVisitElement>> visitElementMap = designForm.getVisitModuleElementMap();
								if(visitElementMap!=null){
									List<EdcVisitElement> visitElementList = visitElementMap.get(commCode);
									if(visitElementList!=null && visitElementList.size()>0){
										for(EdcVisitElement visitElement : visitElementList){
											if(StringUtil.isNotBlank(visitElement.getPlaceholdModuleCode())){
												moduleCode = visitElement.getPlaceholdModuleCode();
											}
											String elementCode = visitElement.getElementCode();
											String commAttrCode = commCode+"_"+elementCode;
											
											Map<String,List<EdcVisitAttribute>> visitElementAttributeMap = designForm.getVisitElementAttributeMap();
											if(visitElementAttributeMap!=null){
												List<EdcVisitAttribute> visitAttributeList = visitElementAttributeMap.get(commAttrCode);
												if(visitAttributeList!=null && visitAttributeList.size()>0){
													EdcPatientVisit edcPatientVisit = null;
													PatientVisitForm patientVisitForm = patientSubmitVisitMap.get(visit.getVisitFlow());
													if(patientVisitForm!=null){
														edcPatientVisit = patientVisitForm.getEdcPatientVisit();
													}
													
													Map<String,Map<String,EdcPatientVisitData>> seqValueMap = null;
													Map<String,Map<String,Map<String,EdcPatientVisitData>>> patientCrfDataMapTemp = patientCrfDataMap.get(visit.getVisitFlow());
													if(patientCrfDataMapTemp!=null){
														seqValueMap = patientCrfDataMapTemp.get(elementCode);
													}
													
													String key = patient.getPatientFlow()+"_"+commAttrCode;
													
													if(edcPatientVisit!=null){
														Map<String,EdcElement> elementMap = designForm.getElementMap();
														if(elementMap!=null){
															EdcElement element = elementMap.get(elementCode);
															if(element!=null){
																if(resultMap.get(key)==null){
																	Map<String,Map<String,String>> temp = new TreeMap<String, Map<String,String>>();
																	resultMap.put(key,temp);
																}
																if(GlobalConstant.FLAG_N.equals(element.getElementSerial())){
																	if(resultMap.get(key).get("1")==null){
																		Map<String,String> temp = new HashMap<String, String>();
																		resultMap.get(key).put("1",temp);
																	}
																	for(EdcVisitAttribute visitAttribute : visitAttributeList){
																		String value = "";
																		if(seqValueMap!=null && edcPatientVisit!=null){
																			value = GeneralMethod.getVisitData(visitAttribute.getAttrCode(),seqValueMap.get("1"),edcPatientVisit.getInputOperFlow(),edcPatientVisit);
																		}
																		if(StringUtil.isEmpty(value)){
																			Map<String,EdcAttribute> attrMap = designForm.getAttrMap();
																			if(attrMap!=null){
																				EdcAttribute attribute = attrMap.get(visitAttribute.getAttrCode());
																				if(attribute!=null && GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME.equals(attribute.getAttrVarName())){
																					Map<String,String> elementStandardUnitMap = designForm.getElementStandardUnitMap();
																					if(elementStandardUnitMap!=null){
																						value = elementStandardUnitMap.get(elementCode);
																					}
																				}
																			}
																		}
																		value = GeneralMethod.getAttrValue(designForm,visitAttribute.getAttrCode(),value);
																		resultMap.get(key).get("1").put(visitAttribute.getAttrCode(),StringEscapeUtils.unescapeHtml(value));
																	}
																}else if(GlobalConstant.FLAG_Y.equals(element.getElementSerial())){
																	if(seqValueMap!=null && edcPatientVisit!=null && seqValueMap.size()>0){
																		for(String seqValueMapKey : seqValueMap.keySet()){
																			if(resultMap.get(key).get(seqValueMapKey)==null){
																				Map<String,String> temp = new HashMap<String, String>();
																				resultMap.get(key).put(seqValueMapKey,temp);
																			}
																			
																			for(EdcVisitAttribute visitAttribute : visitAttributeList){
																				String value = "";
																				if(seqValueMap!=null && edcPatientVisit!=null){
																					value = GeneralMethod.getVisitData(visitAttribute.getAttrCode(),seqValueMap.get(seqValueMapKey),edcPatientVisit.getInputOperFlow(),edcPatientVisit);
																				}
																				if(StringUtil.isBlank(value)){
																					Map<String,EdcAttribute> attrMap = designForm.getAttrMap();
																					if(attrMap!=null){
																						EdcAttribute attribute = attrMap.get(visitAttribute.getAttrCode());
																						if(attribute!=null && GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME.equals(attribute.getAttrName())){
																							Map<String,String> elementStandardUnitMap = designForm.getElementStandardUnitMap();
																							if(elementStandardUnitMap!=null){
																								value = elementStandardUnitMap.get(elementCode);
																							}
																						}
																					}
																				}
																				value = GeneralMethod.getAttrValue(designForm,visitAttribute.getAttrCode(),value);
																				value = StringEscapeUtils.unescapeHtml(value);
																				resultMap.get(key).get(seqValueMapKey).put(visitAttribute.getAttrCode(),StringEscapeUtils.unescapeHtml(value));
																			}
																		}
																	}else{
																		resultMap.get(key).put("1",new HashMap<String, String>());
																		for(EdcVisitAttribute visitAttribute : visitAttributeList){
																			resultMap.get(key).get("1").put(visitAttribute.getAttrCode(),"");
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		return resultMap;
	}
}
