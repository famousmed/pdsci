package com.pinde.sci.biz.res.impl;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.jspform.ItemGroupData;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.res.IResRecBiz;
import com.pinde.sci.biz.sch.ISchArrangeResultBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.JspFormUtil;
import com.pinde.sci.dao.base.ResAppealMapper;
import com.pinde.sci.dao.base.ResDoctorSchProcessMapper;
import com.pinde.sci.dao.base.ResRecMapper;
import com.pinde.sci.dao.res.ResAppealExtMapper;
import com.pinde.sci.dao.res.ResDoctorSchProcessExtMapper;
import com.pinde.sci.dao.res.ResRecExtMapper;
import com.pinde.sci.enums.res.RecStatusEnum;
import com.pinde.sci.enums.res.RegistryTypeEnum;
import com.pinde.sci.enums.res.ResRecTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.hbres.ResRecForm;
import com.pinde.sci.form.res.ResAfterSummaryForm;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.mo.ResAppeal;
import com.pinde.sci.model.mo.ResAppealExample;
import com.pinde.sci.model.mo.ResAppealExample.Criteria;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResRec;
import com.pinde.sci.model.mo.ResRecExample;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorSchProcessExt;
import com.pinde.sci.model.res.ResRecExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class ResRecBizImpl implements IResRecBiz {

	@Autowired
	private ResRecMapper resRecMapper;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private ResRecExtMapper resRecExtMapper;
	@Autowired
	private ResDoctorSchProcessMapper resDoctorProcessMapper;
	@Autowired
	private ResAppealMapper resAppealMapper;
	@Autowired
	private ISchRotationDeptBiz rotationDeptBiz;
	@Autowired
	private ISchDeptBiz schDeptBiz;
	@Autowired
	private IResDoctorProcessBiz processBiz;
	@Autowired
	private ResDoctorSchProcessExtMapper processExtBiz;
	@Autowired
	private ResAppealExtMapper appealExtMapper;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private ISchRotationBiz rotationBiz;
	@Autowired
	private ISchArrangeResultBiz resultBiz;
	
	@Override
	public int edit(ResRec rec) {
		if(rec!=null){
			if(StringUtil.isNotBlank(rec.getRecFlow())){//修改
				GeneralMethod.setRecordInfo(rec, false);
				return this.resRecMapper.updateByPrimaryKeySelective(rec);
			}else{//新增
				rec.setRecFlow(PkUtil.getUUID());
				if(!ResRecTypeEnum.AnnualTrainForm.getId().equals(rec.getRecTypeId())){//培训年度
					rec.setOperTime(DateUtil.getCurrDateTime());
				}
				GeneralMethod.setRecordInfo(rec, true);
				return this.resRecMapper.insertSelective(rec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public int editRec(ResRec rec) {
		if(StringUtil.isNotBlank(rec.getRecFlow())){
			GeneralMethod.setRecordInfo(rec, false);
			return resRecMapper.updateByPrimaryKeySelective(rec);
		}else{
			rec.setRecFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(rec, true);
			return resRecMapper.insertSelective(rec);
		}
	}
	@Override
	public int editAndOut(ResRec rec,ResDoctorSchProcess process){
		if(process!=null){
			resDoctorProcessMapper.updateByPrimaryKeySelective(process);
		}
		return edit(rec);
	}
	
	private IrbSingleForm findTheForm(String currVer,String recTypeId,String rotationFlow){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		String productType = StringUtil.defaultIfEmpty(InitConfig.getSysCfg("res_form_category_"+rotationFlow),InitConfig.getSysCfg("res_form_category"));//与对应开关保持一致
		if(!StringUtil.isNotBlank(productType)){
			productType = GlobalConstant.RES_FORM_PRODUCT;
		}
		
		if (StringUtil.isBlank(currVer)){
			currVer = InitConfig.resFormRequestUtil.getVersionMap().get(productType+"_"+recTypeId);
		}
		if(StringUtil.isBlank(currVer)){
			currVer = InitConfig.resFormRequestUtil.getVersionMap().get(GlobalConstant.RES_FORM_PRODUCT+"_"+recTypeId);
		}
		if(StringUtil.isBlank(currVer)){
			currVer = GlobalConstant.RES_FORM_PRODUCT_VER;
		}
		Map<String,IrbSingleForm> singleFormMap = InitConfig.resFormRequestUtil.getFormMap().get(recTypeId);
		IrbSingleForm singleForm = singleFormMap.get(productType+"_"+currVer);
		if(singleForm==null){
			singleForm = singleFormMap.get(GlobalConstant.RES_FORM_PRODUCT+"_"+currVer);
		}
		if(singleForm == null){
			throw new RuntimeException("未发现表单 模版类型:"+productType+",表单类型:"+ResRecTypeEnum.getNameById(recTypeId)+",版本号:"+currVer);
		}
		return singleForm;
	}
	
	@Override
	public String getFormPath(String recTypeId,String currVer,String rotationFlow){
		if(StringUtil.isNotBlank(recTypeId)){
			IrbSingleForm singleForm = findTheForm(currVer,recTypeId,rotationFlow);
			
			String jspPath = singleForm.getJspPath();
			
			if(StringUtil.isNotBlank(jspPath)){
				jspPath = MessageFormat.format(jspPath,singleForm.getProductType(),singleForm.getVersion());
			}
			return jspPath;
		}
		return "error/404";
	}
	
	@Override
	public int saveRegistryForm(String formFileName,String recFlow,String schDeptFlow,String rotationFlow,HttpServletRequest req, String orgFlow){
		if(StringUtil.isNotBlank(formFileName)){
			String productType = StringUtil.defaultIfEmpty(InitConfig.getSysCfg("res_form_category_"+rotationFlow),InitConfig.getSysCfg("res_form_category"));//与对应开关保持一致
			if(StringUtil.isBlank(productType)){
				productType = GlobalConstant.RES_FORM_PRODUCT;
			}
			String currVer = InitConfig.resFormRequestUtil.getVersionMap().get(productType+"_"+formFileName);
			if(StringUtil.isBlank(currVer)){
				currVer = InitConfig.resFormRequestUtil.getVersionMap().get(GlobalConstant.RES_FORM_PRODUCT+"_"+formFileName);
			}
			if(StringUtil.isBlank(currVer)){
				currVer = GlobalConstant.RES_FORM_PRODUCT_VER;
			}
			Map<String,IrbSingleForm> singleFormMap = InitConfig.resFormRequestUtil.getFormMap().get(formFileName);
			IrbSingleForm singleForm = singleFormMap.get(productType+"_"+currVer);
			if(singleForm == null){
				singleForm = singleFormMap.get(GlobalConstant.RES_FORM_PRODUCT+"_"+currVer);
			}
			if(singleForm == null){
				throw new RuntimeException("未发现表单 模版类型:"+productType+",表单类型:"+ResRecTypeEnum.getNameById(formFileName)+",版本号:"+currVer);
			}
			if(singleForm != null){
				String processFlow = req.getParameter("processFlow");
				ResRec rec = readResRec(recFlow);
				if (rec == null){
					rec = new ResRec();
					SchDept schDept = schDeptBiz.readSchDept(schDeptFlow);
					
					rec.setSchDeptFlow(schDeptFlow);
					if(schDept!=null){
						rec.setSchDeptName(schDept.getSchDeptName());
						rec.setOrgFlow(schDept.getOrgFlow());
						rec.setOrgName(schDept.getOrgName());
						rec.setDeptFlow(schDept.getDeptFlow());
						rec.setDeptName(schDept.getDeptName());
					}
					rec.setRecTypeId(formFileName);
					rec.setRecTypeName(ResRecTypeEnum.getNameById(formFileName));
					rec.setRecVersion(currVer);
					
					String operUserFlow = req.getParameter("operUserFlow");
					if(StringUtil.isNotBlank(operUserFlow)){
						ResDoctor doc = resDoctorBiz.readDoctor(operUserFlow);
						rec.setOperUserFlow(doc.getDoctorFlow());
						rec.setOperUserName(doc.getDoctorName());
						if(!StringUtil.isNotBlank(rec.getOrgFlow())){
							rec.setOrgFlow(doc.getOrgFlow());
							rec.setOrgName(doc.getOrgName());
						}
					}else{
						rec.setOperUserFlow(GlobalContext.getCurrentUser().getUserFlow());
						rec.setOperUserName(GlobalContext.getCurrentUser().getUserName());
						if(!StringUtil.isNotBlank(rec.getOrgFlow())){
							rec.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
							rec.setOrgName(GlobalContext.getCurrentUser().getOrgName());
						}
					}
				}
				
				String recContent = "";
				if (ResRecTypeEnum.Ethics.getId().equals(rec.getRecTypeId()) ||
						ResRecTypeEnum.Document.getId().equals(rec.getRecTypeId()) ||
						ResRecTypeEnum.Appraisal.getId().equals(rec.getRecTypeId())) {
					recContent = getRecContent(formFileName, singleForm, req);
				} else if(ResRecTypeEnum.TeachRegistry.getId().equals(rec.getRecTypeId())){
					recContent = getRecContent(formFileName, singleForm.getItemList(), req,rec.getRecContent());
				} else{
					recContent = getRecContent(formFileName, singleForm.getItemList(), req);
				}
				
				if(ResRecTypeEnum.AfterEvaluation.getId().equals(rec.getRecTypeId())){
					String totalScore = req.getParameter("totalScore");
					ResDoctorSchProcess process = null;
					Double score = new Double(0);
					if(StringUtil.isNotBlank(totalScore)){
						score = Double.parseDouble(totalScore);
//						process = processBiz.searchProcessByRec(rec.getOperUserFlow(),rec.getSchDeptFlow());
						process = processBiz.read(processFlow);
					}
					
					if(req.getParameter("auditStatusId")!=null){
						rec.setAuditStatusId(RecStatusEnum.TeacherAuditY.getId());
						rec.setAuditStatusName(RecStatusEnum.TeacherAuditY.getName());
						
						if(process!=null && process.getSchScore()==null){
							process.setSchScore(BigDecimal.valueOf(score));
							processBiz.edit(process);
						}
						
						recContent = getEvaluationContent(formFileName, singleForm.getItemList(), req,GlobalConstant.RES_ROLE_SCOPE_TEACHER,rec.getRecContent());
					}
					
					if(req.getParameter("headAuditStatusId")!=null){
						rec.setHeadAuditStatusId(RecStatusEnum.HeadAuditY.getId());
						rec.setHeadAuditStatusName(RecStatusEnum.HeadAuditY.getName());
						
						if(process!=null){
							process.setSchScore(BigDecimal.valueOf(score));
							processBiz.edit(process);
						}
						
						recContent = getEvaluationContent(formFileName, singleForm.getItemList(), req,GlobalConstant.RES_ROLE_SCOPE_HEAD,rec.getRecContent());
					}
					if(req.getParameter("managerAuditStatusId")!=null){
						String ckkhrd = req.getParameter("ckkhrd");
						if(GlobalConstant.FLAG_Y.equals(ckkhrd)){
							process.setSchFlag(GlobalConstant.FLAG_Y);
							process.setIsCurrentFlag(GlobalConstant.FLAG_N);
							rec.setManagerAuditStatusId(RecStatusEnum.ManagerAuditY.getId());
							rec.setManagerAuditStatusName(RecStatusEnum.ManagerAuditY.getName());
						}else if(GlobalConstant.FLAG_N.equals(ckkhrd)){
							rec.setManagerAuditStatusId(RecStatusEnum.ManagerAuditN.getId());
							rec.setManagerAuditStatusName(RecStatusEnum.ManagerAuditN.getName());
						}
						if(process!=null){
							process.setSchScore(BigDecimal.valueOf(score));
							processBiz.edit(process);
						}
						recContent = getEvaluationContent(formFileName, singleForm.getItemList(), req,GlobalConstant.RES_ROLE_SCOPE_MANAGER,rec.getRecContent());
					}
				}else if(ResRecTypeEnum.Appraisal.getId().equals(rec.getRecTypeId()) || 
						ResRecTypeEnum.SpeAbilityAssess.getId().equals(rec.getRecTypeId()) || 
						ResRecTypeEnum.RegistryCheckForm.getId().equals(rec.getRecTypeId()) ||
						ResRecTypeEnum.PreTrainForm.getId().equals(rec.getRecTypeId()) ||
						ResRecTypeEnum.AfterSummary.getId().equals(rec.getRecTypeId())){
					if(req.getParameter("auditStatusId")!=null){
						rec.setAuditStatusId(RecStatusEnum.TeacherAuditY.getId());
						rec.setAuditStatusName(RecStatusEnum.TeacherAuditY.getName());
					}
					if(req.getParameter("headAuditStatusId")!=null){
						rec.setHeadAuditStatusId(RecStatusEnum.HeadAuditY.getId());
						rec.setHeadAuditStatusName(RecStatusEnum.HeadAuditY.getName());
					}
					if(req.getParameter("managerAuditStatusId")!=null){
						rec.setManagerAuditStatusId(RecStatusEnum.ManagerAuditY.getId());
						rec.setManagerAuditStatusName(RecStatusEnum.ManagerAuditY.getName());
					}
					if(req.getParameter("adminAuditStatusId")!=null){
						rec.setAdminAuditStatusId(RecStatusEnum.AdminAuditY.getId());
						rec.setAdminAuditStatusName(RecStatusEnum.AdminAuditY.getName());
					}
				}else{
					rec.setAuditStatusId("");
					rec.setAuditStatusName("");
				}
				//培训年度
				if(ResRecTypeEnum.AnnualTrainForm.getId().equals(rec.getRecTypeId())){
					rec.setOperTime(req.getParameter("trainDate"));
				}
				
				rec.setProcessFlow(processFlow);
				rec.setRecContent(recContent);
				String regItem = req.getParameter("regItem");
				String xmlItemName = req.getParameter("xmlItemName");
				if(!StringUtil.isNotBlank(rec.getRecFlow())){
					String[] itemIds = req.getParameterValues("itemId");
					String[] itemNames = req.getParameterValues("itemName");
					if(itemIds!=null && itemIds.length>0){
						for(int i = 0 ; i<itemIds.length ; i++){
							String itemId = itemIds[i];
							String itemName = null;
							if(i<itemNames.length){
								itemName = itemNames[i];
							}
							
							rec.setItemName(itemName);
							if(StringUtil.isNotBlank(xmlItemName)){
								if(GlobalConstant.RES_REQ_OTHER_ITEM_ID.equals(itemId)){
									itemName = regItem;
								}
								recContent = replaceNodeValue(recContent,xmlItemName,itemName);
								rec.setRecContent(recContent);
							}
							rec.setRecFlow(null);
							rec.setItemId(itemId);
							edit(rec);
						}
					}else{
						edit(rec);
					}
				}else{
					String itemId = req.getParameter("itemId");
					String itemName = req.getParameter("itemName");
					rec.setItemName(itemName);
					if(StringUtil.isNotBlank(xmlItemName)){
						if(GlobalConstant.RES_REQ_OTHER_ITEM_ID.equals(itemId)){
							itemName = regItem;
						}
						recContent = replaceNodeValue(recContent,xmlItemName,itemName);
						rec.setRecContent(recContent);
					}
					rec.setItemId(itemId);
					edit(rec);
				}
				
				if(ResRecTypeEnum.AfterSummary.getId().equals(rec.getRecTypeId())){
					if(GlobalConstant.FLAG_Y.equals(req.getParameter("isAgaree"))){
						//String processFlow = req.getParameter("processFlow");
						if(StringUtil.isNotBlank(processFlow)){
							ResDoctorSchProcess process = processBiz.read(processFlow);
							process.setSchFlag(GlobalConstant.FLAG_Y);
							process.setIsCurrentFlag(GlobalConstant.FLAG_N);
							processBiz.edit(process);
						}
					}
				}
				
//				if(ResRecTypeEnum.AfterSummary.getId().equals(rec.getRecTypeId())){
//					ResRec eRec = rec;
//					List<ResRec> recList = searchByRec(ResRecTypeEnum.AfterEvaluation.getId(),eRec.getSchDeptFlow(),eRec.getOperUserFlow());
//					ResRec eInsertRec = null;
//					if(recList!=null && recList.size()>0){
//						eInsertRec = recList.get(0);
//					}
//					if(eInsertRec==null){
//						eInsertRec = new ResRec();
//						eInsertRec.setOrgFlow(eRec.getOrgFlow());
//						eInsertRec.setOrgName(eRec.getOrgName());
//						eInsertRec.setDeptFlow(eRec.getDeptFlow());
//						eInsertRec.setDeptName(eRec.getDeptName());
//						eInsertRec.setSchDeptFlow(eRec.getSchDeptFlow());
//						eInsertRec.setSchDeptName(eRec.getSchDeptName());
//						eInsertRec.setRecTypeId(ResRecTypeEnum.AfterEvaluation.getId());
//						eInsertRec.setRecTypeName(ResRecTypeEnum.AfterEvaluation.getName());
//						eInsertRec.setOperUserFlow(eRec.getOperUserFlow());
//						eInsertRec.setOperUserName(eRec.getOperUserName());
//						//eInsertRec.setStatusId(RecStatusEnum.Submit.getId());
//						//eInsertRec.setStatusName(RecStatusEnum.Submit.getName());
//						
//						String eCurrVer = InitConfig.resFormRequestUtil.getVersionMap().get(productType+"_"+ResRecTypeEnum.AfterEvaluation.getId());
//						if(StringUtil.isBlank(eCurrVer)){
//							eCurrVer = InitConfig.resFormRequestUtil.getVersionMap().get(GlobalConstant.RES_FORM_PRODUCT+"_"+ResRecTypeEnum.AfterEvaluation.getId());
//						}
//						if(StringUtil.isBlank(eCurrVer)){
//							eCurrVer = GlobalConstant.RES_FORM_PRODUCT_VER;
//						}
//						eInsertRec.setRecVersion(eCurrVer);
//						edit(eInsertRec);
//					}
//				}
				
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	private String replaceNodeValue(String content,String nodeName,String value){
		String resultContent = null;
		try {
			Document doc = DocumentHelper.parseText(content);
			Element rootEle = doc.getRootElement();
			Element nade = rootEle.element(nodeName);
			if(nade!=null){
				nade.setText(value);
			}
			resultContent = doc.asXML();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return resultContent;
	}
	
	private String getRecContent(String formName,List<Element> list,HttpServletRequest req,String recContent){
		Element rootEle = null;
		if(StringUtil.isNotBlank(recContent)){
			try {
				rootEle = DocumentHelper.parseText(recContent).getRootElement();
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}else{
			rootEle = DocumentHelper.createElement(formName);
		}
		
		if(list!=null && list.size()>0){
			for(Element e : list){
				String tagName = e.getName();
				String recordFlow = req.getParameter("recordFlow");
				if("itemGroup".equals(tagName)){
					if(recordFlow!=null){
						String delFlag = req.getParameter("delFlag");
						if(GlobalConstant.FLAG_Y.equals(delFlag)){
							Node delNode = rootEle.selectSingleNode("itemGroup[@recordFlow='"+recordFlow+"']");
							delNode.detach();
						}else{
							Element group = null;
							if(StringUtil.isNotBlank(recordFlow)){
								group = (Element)rootEle.selectSingleNode("itemGroup[@recordFlow='"+recordFlow+"']");
								group.setText("");
								group = getContentEle(e.elements(),req,group);
							}else{
								group = DocumentHelper.createElement("itemGroup");
								group.addAttribute("recordFlow",PkUtil.getUUID());
								group.addAttribute("name",e.attributeValue("name"));
//							group.addAttribute("title",e.attributeValue("remark"));
								group = getContentEle(e.elements(),req,group);
								rootEle.add(group);
							}
							
						}
					}
				}else{
					if(recordFlow==null){
						String nodeName = e.attributeValue("name");
						Element itemEle = (Element)rootEle.selectSingleNode(nodeName);
						if(itemEle!=null){
							itemEle.detach();
						}
						String multiple = e.attributeValue("multiple");
						if(GlobalConstant.FLAG_N.equals(multiple) || StringUtil.isBlank(multiple)){
							String value = req.getParameter(nodeName);
							Element element = DocumentHelper.createElement(nodeName); 
							if(GlobalConstant.FLAG_Y.equals(e.attributeValue("isView"))){
								element.addAttribute("title",e.attributeValue("remark"));
							}
							if (StringUtil.isNotBlank(value)) {
								element.setText(value);
							}
							rootEle.add(element);
						}else {
							String[] values = req.getParameterValues(nodeName);
							Element element = DocumentHelper.createElement(nodeName); 
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
			}
		}
		return rootEle.asXML();
	}
	
	//为rootEle组织内容
	private Element getContentEle(List<Element> list,HttpServletRequest req,Element rootEle){
		if(list !=null && list.size()>0 && rootEle!=null){
			for(Element itemEle : list){
				String multiple = itemEle.attributeValue("multiple");
				if(GlobalConstant.FLAG_N.equals(multiple) || StringUtil.isBlank(multiple)){
					String value = req.getParameter(itemEle.attributeValue("name"));
					if(StringUtil.isBlank(value)){
						value = (String) req.getAttribute(itemEle.attributeValue("name"));
					}
					Element element = DocumentHelper.createElement(itemEle.attributeValue("name")); 
					String isView = itemEle.attributeValue("isView");
					if(StringUtil.isNotBlank(isView)){
						element.addAttribute("title",itemEle.attributeValue("remark"));
						element.addAttribute("isView",isView);
					}
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
		return rootEle;
	}
	
	@Override
	public String getRecContent(String formName,List<Element> list,HttpServletRequest req) { 
		Element rootEle = DocumentHelper.createElement(formName);
		rootEle = getContentEle(list,req,rootEle);
		return rootEle.asXML();
	}
	
	private String getEvaluationContent(String formName,List<Element> list,HttpServletRequest req,String roleFlag,String oldContent){
		String content = null;
		try {
			Document doc = null;
			Element root = null;
			Element roleNode = null;
			if(StringUtil.isNotBlank(oldContent)){
				doc = DocumentHelper.parseText(oldContent);
				root = doc.getRootElement();
				roleNode = root.element(roleFlag+ResRecTypeEnum.AfterEvaluation.getId());
				if(roleNode != null){
					roleNode.detach();
				}
			}else{
				doc = DocumentHelper.createDocument();
				root = doc.addElement(formName);
			}
			roleNode = DocumentHelper.createElement(roleFlag+ResRecTypeEnum.AfterEvaluation.getId());
			getContent(list,req,roleNode);
			root.add(roleNode);
			content = root.asXML();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return content;
	}
	
	private String getContent(List<Element> list,HttpServletRequest req,Element rootEle){
		if(list !=null && list.size()>0 && rootEle!=null){
			for(Element itemEle : list){
				String multiple = itemEle.attributeValue("multiple");
				if(GlobalConstant.FLAG_N.equals(multiple) || StringUtil.isBlank(multiple)){
					String value = req.getParameter(itemEle.attributeValue("name"));
					Element element = DocumentHelper.createElement(itemEle.attributeValue("name")); 
					if(GlobalConstant.FLAG_Y.equals(itemEle.attributeValue("isView"))){
						element.addAttribute("title",itemEle.attributeValue("remark"));
					}
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
	
	/**
	 * 解析展示节点
	 */
	@Override
	public List<Map<String,String>> parseViewValue(String recContent){
		List<Map<String,String>> viewList = null;
		if(StringUtil.isNotBlank(recContent)){
			try {
				Document document = DocumentHelper.parseText(recContent);
				Element root = document.getRootElement();
				if(root!=null){
					List<Element> views = root.selectNodes("*[@title]");
					if(views!=null && views.size()>0){
						viewList = new ArrayList<Map<String,String>>();
						for(Element e : views){
							Map<String,String> propInfo = new HashMap<String, String>();
							propInfo.put("title",e.attributeValue("title"));
							propInfo.put("value",e.getText());
							propInfo.put("isView",e.attributeValue("isView"));
							viewList.add(propInfo);
						}
					}
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		if(viewList!=null && viewList.size()>0){
			Collections.sort(viewList,new Comparator<Map<String,String>>() {
				@Override
				public int compare(Map<String, String> map0,Map<String, String> map1){
					if(map0!=null && map1!=null){
						Integer a = 0;
						Integer b = 0;
						try {
							a = Integer.parseInt(map0.get("isView"));
							b = Integer.parseInt(map1.get("isView"));
						} catch (Exception e) {
							e.printStackTrace();
						}
						return a-b;
					}
					return 0;
				}
			});
		}
		return viewList;
	}
	
	@Override
	public ResRec readResRec(String recFlow) {
		ResRec rec = null;
		if(StringUtil.isNotBlank(recFlow)){
			rec = this.resRecMapper.selectByPrimaryKey(recFlow);
		}
		return rec;
	}
	
	@Override
	public List<ResRec> searchByRecWithBLOBs(String recTypeId,String schDeptFlow,String operUserFlow){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
			.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowEqualTo(operUserFlow);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchRecByProcessWithBLOBs(String processFlow,String recTypeId){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andRecTypeIdEqualTo(recTypeId).andProcessFlowEqualTo(processFlow);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchByDeptWithBLOBs(String recTypeId,List<String> schDeptFlows){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
		.andSchDeptFlowIn(schDeptFlows);
		example.setOrderByClause("OPER_USER_FLOW,OPER_TIME");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchByRecWithBLOBs(String recTypeId,String operUserFlow){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
		.andOperUserFlowEqualTo(operUserFlow);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchByRecWithBLOBs(ResRec resRec, String trainYear){
		ResRecExample example = new ResRecExample();
		com.pinde.sci.model.mo.ResRecExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(resRec.getRecTypeId())
		.andOperUserFlowEqualTo(resRec.getOperUserFlow());
		if(StringUtil.isNotBlank(trainYear)){
			criteria.andOperTimeLike(trainYear + "%");
		}
		example.setOrderByClause("NLSSORT(SCH_DEPT_NAME,'NLS_SORT = SCHINESE_PINYIN_M'), OPER_TIME DESC");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchByRecWithBLOBs(String recTypeId,String schDeptFlow,String operUserFlow,String itemId){
		ResRecExample example = new ResRecExample();
		com.pinde.sci.model.mo.ResRecExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
			.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowEqualTo(operUserFlow);
		if(StringUtil.isNotBlank(itemId)){
			criteria.andItemIdEqualTo(itemId);
		}
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchFinishRec(List<String> recTypeIds,String operUserFlow){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdIn(recTypeIds)
		.andOperUserFlowEqualTo(operUserFlow);//.andAuditStatusIdEqualTo(RecStatusEnum.TeacherAuditY.getId());
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExample(example);
	}
	
	@Override
	public List<ResRec> searchByRec(String recTypeId,String schDeptFlow,String operUserFlow){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
			.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowEqualTo(operUserFlow);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExample(example);
	}
	
	@Override
	public List<ResRec> searchByUserFlows(String recTypeId,String schDeptFlow,List<String> operUserFlows){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
		.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowIn(operUserFlows);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExample(example);
	}
	
	@Override
	public List<ResRec> searchByUserFlows(String recTypeId,List<String> operUserFlows){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
		.andOperUserFlowIn(operUserFlows);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExample(example);
	}
	
	@Override
	public List<ResRec> searchByUserFlowsWithBLOBs(String recTypeId,String schDeptFlow,List<String> operUserFlows){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
		.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowIn(operUserFlows);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchByUserFlowsWithBLOBs(String recTypeId,List<String> operUserFlows){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
		.andOperUserFlowIn(operUserFlows);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchByRecForAudit(String recTypeId,String schDeptFlow,String operUserFlow){
		return resRecExtMapper.searchByRecForAudit(recTypeId,schDeptFlow,operUserFlow);
	}
	
	@Override
	public List<Map<String,Object>> searchDoctorNotAuditCount(String schDeptFlow,String teacherUserFlow,String isAudit,List<String> recTypeIds){
		return resRecExtMapper.searchDoctorNotAuditCount(schDeptFlow,teacherUserFlow,isAudit,recTypeIds);
	}
	
	@Override
	public int oneKeyAudit(String recTypeId,String schDeptFlow,String operUserFlow){
		ResRecExample example = new ResRecExample();
		ResRec rec = new ResRec();
		rec.setAuditStatusId(RecStatusEnum.TeacherAuditY.getId());
		rec.setAuditStatusName(RecStatusEnum.TeacherAuditY.getName());
		GeneralMethod.setRecordInfo(rec,false);
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
			.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowEqualTo(operUserFlow).andAuditStatusIdIsNull();
		resRecMapper.updateByExampleSelective(rec,example);
		
		if(ResRecTypeEnum.OperationRegistry.getId().equals(recTypeId) || ResRecTypeEnum.SkillRegistry.getId().equals(recTypeId) || ResRecTypeEnum.DiseaseRegistry.getId().equals(recTypeId)){
			ResAppealExample appealExample = new ResAppealExample();
			appealExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
				.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowEqualTo(operUserFlow).andAuditStatusIdIsNull();
			ResAppeal appeal = new ResAppeal();
			appeal.setAuditStatusId(RecStatusEnum.TeacherAuditY.getId());
			appeal.setAuditStatusName(RecStatusEnum.TeacherAuditY.getName());
			GeneralMethod.setRecordInfo(appeal,false);
			resAppealMapper.updateByExampleSelective(appeal,appealExample);
		}
		
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public List<ResRec> searchByRec(List<String> recTypeIds,String schDeptFlow,String operUserFlow){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdIn(recTypeIds)
			.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowEqualTo(operUserFlow);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExample(example);
	}
	
	@Override
	public List<ResRec> searchByRecWithBLOBs(List<String> recTypeIds,String schDeptFlow,String operUserFlow){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdIn(recTypeIds)
			.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowEqualTo(operUserFlow);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchByRecWithBLOBs(List<String> recFlows){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecFlowIn(recFlows);
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	
	@Override
	public List<ResRec> searchByRec(String recTypeId,List<String> schDeptFlows,String operUserFlow){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
			.andSchDeptFlowIn(schDeptFlows).andOperUserFlowEqualTo(operUserFlow);
		example.setOrderByClause("OPER_TIME");
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public Map<String,Object> parseGradeXml(String recContent){
		Map<String,Object> gradeMap = null;
		if(StringUtil.isNotBlank(recContent)){
			try {
				Document doc = DocumentHelper.parseText(recContent);
				Element root = doc.getRootElement();
				if(root!=null){
					List<Element> items = root.elements("grade");
					if(items!=null && items.size()>0){
						gradeMap = new HashMap<String, Object>();
						for(Element e : items){
							String assessId = e.attributeValue("assessId");
							Map<String,String> dataMap = new HashMap<String, String>();
							gradeMap.put(assessId,dataMap);
							
							Element score = e.element("score");
							if(score!=null){
								String scoreStr = score.getText();
								dataMap.put("score",scoreStr);
							}
							Element lostReason = e.element("lostReason");
							if(lostReason!=null){
								dataMap.put("lostReason",lostReason.getText());
							}
						}
						
						Element totalScore = root.element("totalScore");
						if(totalScore!=null){
							gradeMap.put("totalScore",totalScore.getText());
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return gradeMap;
	}
	
	@Override
	public Map<String, BigDecimal> searchAuditCount(String userFlow, String roleFlag) {
		Map<String, BigDecimal> countMap = null;
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(roleFlag)){
			countMap = new HashMap<String, BigDecimal>();
			List<Map<String,Object>> mapList = this.resRecExtMapper.searchAuditCount(userFlow, roleFlag);
			if(mapList!=null&&!mapList.isEmpty()){
				for (Map<String, Object> map : mapList) {
					String key = null;
					BigDecimal value = null;
					for(String myKey:map.keySet() ) {
						if("key".equals(myKey)){
							key = (String)map.get(myKey);
						}else if("value".equals(myKey)){
							value = (BigDecimal)map.get(myKey);
						}
					}
					countMap.put(key, value);
				}
			}
		}
		return countMap;
	}
	@Override
	public List<ResRecExt> searchAuditList(String userFlow, 
			String roleFlag,
			String recTypeId,
			String doctorFlow,
			String isCurrentFlag) {
		List<ResRecExt> auditList = null;
		if(StringUtil.isNotBlank(userFlow)&&StringUtil.isNotBlank(roleFlag)&&StringUtil.isNotBlank(recTypeId)){
			auditList = this.resRecExtMapper.searchAuditList(userFlow, roleFlag, recTypeId,doctorFlow,isCurrentFlag);
		}
		return auditList;
	}
	@Override
	public List<ResRecExt> searchRegistryList(String userFlow, String roleFlag,ResRec rec,ResDoctorSchProcess process) {
		return this.resRecExtMapper.searchRegistryList(userFlow, roleFlag,rec,process);
	}
	@Override
	public List<ResRecExt> searchTeacherAudit(String schDeptFlow, String isCurrentFlag,String userFlow) {
		return resRecExtMapper.searchTeacherAudit(schDeptFlow, isCurrentFlag,userFlow);
	}
	@Override
	public List<ResRecExt> searchScoreList(String userFlow,
			String roleFlag,
			String sessionNumber,
			String recTypeId,
			String isCurrentFlag) {
		return this.resRecExtMapper.searchScoreList(userFlow,roleFlag,sessionNumber,recTypeId,isCurrentFlag);
	}
	@Override
	public Map<String,String> parseRecContent(String content) {
		Map<String,String> formDataMap = null;
		if(StringUtil.isNotBlank(content)){
			formDataMap = new HashMap<String, String>();
			try {
				Document document = DocumentHelper.parseText(content);
				Element rootElement = document.getRootElement();
				Element afterEvaluation = rootElement.element(GlobalConstant.RES_ROLE_SCOPE_MANAGER+ResRecTypeEnum.AfterEvaluation.getId());
				if(afterEvaluation==null){
					afterEvaluation = rootElement.element(GlobalConstant.RES_ROLE_SCOPE_HEAD+ResRecTypeEnum.AfterEvaluation.getId());
				}
				if(afterEvaluation==null){
					afterEvaluation = rootElement.element(GlobalConstant.RES_ROLE_SCOPE_TEACHER+ResRecTypeEnum.AfterEvaluation.getId());
				}
				List<Element> elements = null;
				if(afterEvaluation!=null){
					elements = afterEvaluation.elements();
				}else{
					elements = rootElement.elements();
				}
				for(Element element : elements){
					List<Node> valueNodes = element.selectNodes("value");
					if(valueNodes != null && !valueNodes.isEmpty()){
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
		return formDataMap;
	}
	
	@Override
	public Map<String,List<Map<String,String>>> parseRecContentAppraise(String content){
		Map<String,List<Map<String,String>>> appraiseMap = null;
		if(StringUtil.isNotBlank(content)){
			appraiseMap = new HashMap<String, List<Map<String,String>>>();
			try {
				Document document = DocumentHelper.parseText(content);
				Element rootElement = document.getRootElement();
				List<Element> elements = rootElement.elements("deptAppraise");
				if(elements!=null && elements.size()>0){
					List<Map<String,String>> deptAppraiseList = new ArrayList<Map<String,String>>();
					for(Element e : elements){
						Map<String,String> appraise = new HashMap<String, String>();
						appraise.put("operTime",e.attributeValue("operTime"));
						appraise.put("operUserName",e.attributeValue("operUserName"));
						appraise.put("auditStatusName",e.attributeValue("auditStatusName"));
						appraise.put("appraise",e.getText());
						deptAppraiseList.add(appraise);
					}
					appraiseMap.put("deptAppraise",deptAppraiseList);
				}
				
				elements = rootElement.elements("deptHeadAutograth");
				if(elements!=null && elements.size()>0){
					List<Map<String,String>> deptAppraiseList = new ArrayList<Map<String,String>>();
					for(Element e : elements){
						Map<String,String> appraise = new HashMap<String, String>();
						appraise.put("operTime",e.attributeValue("operTime"));
						appraise.put("appraise",e.getText());
						deptAppraiseList.add(appraise);
					}
					appraiseMap.put("deptHeadAutograth",deptAppraiseList);
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		return appraiseMap;
	}
	
	@Override
	public List<ResRec> searchRecByUserFlows(List<String> userFlows,String recTypeId){
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
		.andOperUserFlowIn(userFlows);
		return resRecMapper.selectByExample(example);
	}
	
	@Override
	public List<ResDoctorSchProcessExt> searchProcessExt(ResDoctorSchProcessExt processExt){
		return resRecExtMapper.searchProcessExt(processExt);
	}
	
	@Override
	public List<ResRec> searchRecByUserAndSchdept(List<String> userFlows,List<String> schDeptFlows,String recTypeId,String itemName){
		return resRecExtMapper.searchRecByUserAndSchdept(userFlows, schDeptFlows, recTypeId, itemName);
	}
	
	@Override
	public List<ResRecExt> searchRecExtByRecExt(ResRecExt recExt){
		return resRecExtMapper.searchRecExtByRecExt(recExt);
	}
	
	@Override
	public List<Map<String,Object>> countProcessByUser(List<String> userFlows){
		return processExtBiz.countProcessByUser(userFlows);
	}
	
	@Override
	public List<Map<String,Object>> searchTeacherAuditCount(String headUserFlow,String isAudit){
		return resRecExtMapper.searchTeacherAuditCount(headUserFlow,isAudit);
	}
	
	/**TODO****************************************************获取百分比和数量**************************************************************/
	@Override
	public Map<String,String> getFinishPer(List<SchArrangeResult> arrResultList){
		return getFinishPer(arrResultList,GlobalContext.getCurrentUser().getUserFlow());
	}
	
	@Override
	public Map<String,String> getFinishPer(List<SchArrangeResult> arrResultList,String doctorFlow){
		Map<String,String> processMap = new HashMap<String, String>();
		Map<String,SchArrangeResult> proResultMap = new HashMap<String,SchArrangeResult>();
		if(arrResultList!=null&&arrResultList.size()>0){
			for (SchArrangeResult result : arrResultList) {
				String resultFlow = result.getResultFlow();
				if(StringUtil.isNotBlank(resultFlow)){
					ResDoctorSchProcess process = processBiz.searchByResultFlow(resultFlow);
					if(process!=null){
						String processFlow = process.getProcessFlow();
						processMap.put(resultFlow,process.getProcessFlow());
						processMap.put(processFlow,resultFlow);
						proResultMap.put(processFlow,result);
					}
				}
			}
		}
		
		List<String> recTypeIds = new ArrayList<String>();
		for(RegistryTypeEnum regType : RegistryTypeEnum.values()){
			if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_registry_type_"+regType.getId()))){
				recTypeIds.add(regType.getId());
			}
		}
		if(recTypeIds==null || recTypeIds.size()<=0){
			return null;
		}
		
		Map<String,String> finishPerMap = null;
		List<ResRec> recList = searchFinishRec(recTypeIds,doctorFlow);
		Map<String,Integer> recFinishMap = new HashMap<String, Integer>();
		if(recList!=null && recList.size()>0){
			for(ResRec rec : recList){
				String processFlow = rec.getProcessFlow();
				String schDeptFlow = rec.getSchDeptFlow();
				String recTypeId = rec.getRecTypeId();
				String itemId = rec.getItemId();
				
				if(recFinishMap.get(schDeptFlow)==null){
					recFinishMap.put(schDeptFlow,1);
				}else{
					recFinishMap.put(schDeptFlow,recFinishMap.get(schDeptFlow)+1);
				}
				if(recFinishMap.get(schDeptFlow+recTypeId)==null){
					recFinishMap.put(schDeptFlow+recTypeId,1);
				}else{
					recFinishMap.put(schDeptFlow+recTypeId,recFinishMap.get(schDeptFlow+recTypeId)+1);
				}
				if(StringUtil.isNotBlank(itemId)){
					if(recFinishMap.get(schDeptFlow+recTypeId+itemId)==null){
						recFinishMap.put(schDeptFlow+recTypeId+itemId,1);
					}else{
						recFinishMap.put(schDeptFlow+recTypeId+itemId,recFinishMap.get(schDeptFlow+recTypeId+itemId)+1);
					}
				}
				if(recFinishMap.get(processFlow)==null){
					recFinishMap.put(processFlow,1);
				}else{
					recFinishMap.put(processFlow,recFinishMap.get(processFlow)+1);
				}
				if(recFinishMap.get(processFlow+recTypeId)==null){
					recFinishMap.put(processFlow+recTypeId,1);
				}else{
					recFinishMap.put(processFlow+recTypeId,recFinishMap.get(processFlow+recTypeId)+1);
				}
				if(StringUtil.isNotBlank(itemId)){
					if(recFinishMap.get(processFlow+recTypeId+itemId)==null){
						recFinishMap.put(processFlow+recTypeId+itemId,1);
					}else{
						recFinishMap.put(processFlow+recTypeId+itemId,recFinishMap.get(processFlow+recTypeId+itemId)+1);
					}
				}
				
				SchArrangeResult result = proResultMap.get(processFlow);
				if(result!=null){
					String globalUpKey = result.getStandardGroupFlow()+result.getStandardDeptId();
					if(StringUtil.isNotBlank(globalUpKey)){
						if(recFinishMap.get(globalUpKey)==null){
							recFinishMap.put(globalUpKey,1);
						}else{
							recFinishMap.put(globalUpKey,recFinishMap.get(globalUpKey)+1);
						}
					}
					if(recFinishMap.get(globalUpKey+recTypeId)==null){
						recFinishMap.put(globalUpKey+recTypeId,1);
					}else{
						recFinishMap.put(globalUpKey+recTypeId,recFinishMap.get(globalUpKey+recTypeId)+1);
					}
					if(StringUtil.isNotBlank(itemId)){
						if(recFinishMap.get(globalUpKey+recTypeId+itemId)==null){
							recFinishMap.put(globalUpKey+recTypeId+itemId,1);
						}else{
							recFinishMap.put(globalUpKey+recTypeId+itemId,recFinishMap.get(globalUpKey+recTypeId+itemId)+1);
						}
					}
				}
			}
		}
		
		if(arrResultList!=null&&arrResultList.size()>0){
			finishPerMap = new HashMap<String, String>();
			
			//List<String> schDeptFlows = new ArrayList<String>();
			
			for (SchArrangeResult result : arrResultList) {
				String resultFlow = result.getResultFlow();
				//schDeptFlows.add(result.getSchDeptFlow());
				
				List<SchRotationDeptReq> deptReqList = rotationDeptBiz.searchStandardReqByResult(result);
				Map<String,Integer> reqNumMap = new HashMap<String, Integer>();
				Map<String,List<String>> itemMap = new HashMap<String, List<String>>();
				reqNumMap.put("reqSum",0);
				if(deptReqList!=null && deptReqList.size()>0){
					for(SchRotationDeptReq deptReq : deptReqList){
						if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_registry_type_"+deptReq.getRecTypeId()))){
							reqNumMap.put("reqSum",reqNumMap.get("reqSum")+(deptReq.getReqNum().intValue()));
							if(reqNumMap.get(deptReq.getRecTypeId())==null){
								reqNumMap.put(deptReq.getRecTypeId(),(deptReq.getReqNum().intValue()));
							}else{
								reqNumMap.put(deptReq.getRecTypeId(),reqNumMap.get(deptReq.getRecTypeId())+(deptReq.getReqNum().intValue()));
							}
							if(reqNumMap.get(deptReq.getRecTypeId()+"itemCount")==null){
								reqNumMap.put(deptReq.getRecTypeId()+"itemCount",1);
							}else{
								reqNumMap.put(deptReq.getRecTypeId()+"itemCount",reqNumMap.get(deptReq.getRecTypeId()+"itemCount")+1);
							}
							if(reqNumMap.get(deptReq.getRecTypeId()+deptReq.getItemId())==null){
								reqNumMap.put(deptReq.getRecTypeId()+deptReq.getItemId(),deptReq.getReqNum().intValue());
							}else{
								reqNumMap.put(deptReq.getRecTypeId()+deptReq.getItemId(), reqNumMap.get(deptReq.getRecTypeId()+deptReq.getItemId())+(deptReq.getReqNum().intValue()));
							}
							if(itemMap.get(deptReq.getRecTypeId())==null){
								List<String> itemIds = new ArrayList<String>();
								itemIds.add(deptReq.getItemId());
								itemMap.put(deptReq.getRecTypeId(),itemIds);
							}else{
								itemMap.get(deptReq.getRecTypeId()).add(deptReq.getItemId());
							}
						}
					}
				}
				String processFlow = processMap.get(resultFlow);
				String globalUpKey = result.getStandardGroupFlow()+result.getStandardDeptId();
				finishPerMap.put(resultFlow+"finish",defaultString(recFinishMap.get(globalUpKey)));
				finishPerMap.put(resultFlow+"finishSingle",defaultString(recFinishMap.get(processFlow)));
				finishPerMap.put(resultFlow+"req",defaultString(reqNumMap.get("reqSum")));
				
				for(RegistryTypeEnum regType : RegistryTypeEnum.values()){
					if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_registry_type_"+regType.getId()))){
						finishPerMap.put(resultFlow+regType.getId()+"finish",defaultString(recFinishMap.get(processFlow+regType.getId())));
						
						if(GlobalConstant.FLAG_Y.equals(regType.getHaveReq())){
							finishPerMap.put(resultFlow+regType.getId()+"req",defaultString(reqNumMap.get(regType.getId())));
						}
						
						finishPerMap.put(resultFlow+regType.getId()+"itemCount",defaultString(reqNumMap.get(regType.getId()+"itemCount")));
					}
				}
				
				setFinishPerMap(finishPerMap,result,itemMap,recFinishMap,reqNumMap);
			}
			
//			List<ResRec> eRecList = searchByRec(ResRecTypeEnum.AfterEvaluation.getId(),schDeptFlows,GlobalContext.getCurrentUser().getUserFlow());
//			if(eRecList!=null && eRecList.size()>0){
//				for(ResRec eRec : eRecList){
//					Map<String,String> recContent = parseRecContent(eRec.getRecContent());
//					if(recContent!=null){
//						finishPerMap.put(eRec.getSchDeptFlow(),recContent.get("totalScore"));
//					}
//				}
//			}
		}
		return finishPerMap;
	}
	
	private String defaultString(Integer num){
		return num==null?"0":(num+"");
	}
	
	private void setFinishPerMap(Map<String,String> finishPerMap,SchArrangeResult result,Map<String,List<String>> itemMap,Map<String,Integer> recFinishMap,Map<String,Integer> reqNumMap){
		if(finishPerMap!=null){
			String resultFlow = result.getResultFlow();
			String reqSum = finishPerMap.get(resultFlow+"req");
//			String processFlow = processMap.get(resultFlow);
			String globalUpKey = result.getStandardGroupFlow()+result.getStandardDeptId();
			
			if(itemMap!=null && itemMap.size()>0){
				Float count = 0f;
				for(RegistryTypeEnum regType : RegistryTypeEnum.values()){
					if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_registry_type_"+regType.getId()))){
						if(GlobalConstant.FLAG_Y.equals(regType.getHaveReq())){
							Float reqCount = 0f;
							Float itemInReqCount = 0f;
							boolean isFinish = true;
							
							String recTypeId = regType.getId();
							List<String> itemList = itemMap.get(recTypeId);
							if(isFinish = itemList!=null && itemList.size()>0){
								String req = finishPerMap.get(resultFlow+recTypeId+"req");
								for(String itemId : itemList){
									itemId = StringUtil.defaultString(itemId);
									String itemFinish = defaultString(recFinishMap.get(globalUpKey+recTypeId+itemId));
									String itemReq = defaultString(reqNumMap.get(recTypeId+itemId));
									Float itemReqPre = Float.valueOf(getPer(itemReq,req,false));
									Float itemPre = Float.valueOf(typesPer(itemFinish,itemReq,req,reqSum));
									finishPerMap.put(resultFlow+regType.getId()+itemId,itemPre.toString());
									reqCount+=itemPre;
									if(isFinish){
										if(isFinish = StringUtil.isNotBlank(itemFinish) && StringUtil.isNotBlank(itemReq)){
											isFinish = (Integer.valueOf(itemReq) - Integer.valueOf(itemFinish))<=0;
										}
									}
									
									//子项占比
									Float itemInReqPre = Float.valueOf(getPer(itemFinish,itemReq,false));
									Float itemInAllReqPre = Float.valueOf(getPer(itemInReqPre.toString(),itemReqPre.toString(),true));
									itemInReqCount+=itemInAllReqPre;
								}
							}
							finishPerMap.put(resultFlow+recTypeId+"isFinish",isFinish+"");
							finishPerMap.put(resultFlow+recTypeId,reqCount.toString());
							finishPerMap.put(resultFlow+recTypeId+"itemPre",itemInReqCount.toString());
							count += reqCount;
						}
					}
				}
				finishPerMap.put(resultFlow,count.toString());
			}
		}
	}
	
	private String getPer(String num1,String num2,boolean mutil){
		if (StringUtil.isBlank(num1)) {
			num1 = "0";
		}
		if(StringUtil.isBlank(num2)){
			num2 = "0";
		}
		Float f = null;
		if(mutil){
			f = ((Float.valueOf(num1)/100)*Float.valueOf(num2));
		}else{
			if("0".equals(num2)) {
				f = Float.valueOf("0");
			} else {
				f = (Float.valueOf(num1)/Float.valueOf(num2))*100;
				f = f>100?100:f;
			}
		}
		
		BigDecimal b = new BigDecimal(f).setScale(2,BigDecimal.ROUND_HALF_UP);
		return String.valueOf(b);
	}
	
	private String typesPer(String itemFinish,String itemReq,String req,String reqSum){
		String typePer = getPer(req,reqSum,false);
		String itemPer = getPer(itemReq,req,false);
		String itemFinishPer = getPer(itemFinish,itemReq,false);
		return getPer(getPer(itemFinishPer,itemPer,true),typePer,true);
	}
	
	/******************************************************获取百分比和数量**************************************************************/
	
	@Override
	public int saveRecContentForm(String recFlow, String recTypeId,String roleFlag, String processFlow , Object form) {
		if(StringUtil.isNotBlank(recFlow)&&StringUtil.isNotBlank(recTypeId)&&form!=null){
			ResRec rec = this.readResRec(recFlow);
			if(rec!=null){
				Document dom = null;
				try {
					dom = DocumentHelper.parseText(rec.getRecContent());
				} catch (DocumentException e) {
					e.printStackTrace();
					throw new RuntimeException("resRec Xml转换成dom出错，resTypeId："+recTypeId+"，recFlow："+recFlow);
				}
				Element root = dom.getRootElement();
				if(ResRecTypeEnum.AfterEvaluation.getId().equals(recTypeId)){//出科考核表
					
					}else{
						ResAfterSummaryForm myForm = (ResAfterSummaryForm) form;
						String userName = GlobalContext.getCurrentUser().getUserName();
						String userFlow = GlobalContext.getCurrentUser().getUserFlow();
						String auditResult = myForm.getAuditResult();
						if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){//带教老师
							Element deptAppraiseEl = root.element("deptAppraise");
							if(deptAppraiseEl==null){
								deptAppraiseEl = root.addElement("deptAppraise");
							}
							deptAppraiseEl.setText(myForm.getDeptAppraise());
							rec.setAuditTime(DateUtil.getCurrDateTime());
							rec.setAuditUserFlow(userFlow);
							rec.setAuditUserName(userName);
							rec.setAuditStatusId(auditResult);
							rec.setAuditStatusName(RecStatusEnum.getNameById(auditResult));
//							if(RecStatusEnum.TeacherAuditN.getId().equals(auditResult)){
//								rec.setStatusId(RecStatusEnum.Edit.getId());
//								rec.setStatusName(RecStatusEnum.Edit.getName());
//							}
						}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){//科主任
							Element deptHeadAutograthEl = root.element("deptHeadAutograth");
							if(deptHeadAutograthEl==null){
								deptHeadAutograthEl = root.addElement("deptHeadAutograth");
							}
							deptHeadAutograthEl.setText(myForm.getDeptHeadAutograth());
							if(StringUtil.isNotBlank(myForm.getIsAgaree())){
								Element isAgareeEl = root.element("isAgaree");
								if(isAgareeEl==null){
									isAgareeEl = root.addElement("isAgaree");
								}
								/*修改process出科标记*/
								isAgareeEl.setText(myForm.getIsAgaree());
								if(GlobalConstant.FLAG_Y.equals(myForm.getIsAgaree())){
									ResDoctorSchProcess process = this.resDoctorProcessMapper.selectByPrimaryKey(processFlow);
									if(process!=null){
										process.setSchFlag(GlobalConstant.FLAG_Y);
										process.setIsCurrentFlag(GlobalConstant.FLAG_N);
										process.setEndDate(DateUtil.getCurrDate());
										this.resDoctorProcessMapper.updateByPrimaryKeySelective(process);
									}
								}
							}
							rec.setHeadAuditStatusId(auditResult);
							rec.setHeadAuditStatusName(RecStatusEnum.getNameById(auditResult));
							rec.setHeadAuditTime(DateUtil.getCurrDateTime());
							rec.setHeadAuditUserFlow(userFlow);
							rec.setHeadAuditUserName(userName);
//							if(RecStatusEnum.HeadAuditN.getId().equals(auditResult)){
//								rec.setStatusId(RecStatusEnum.Edit.getId());
//								rec.setStatusName(RecStatusEnum.Edit.getName());
//							}
					}
				}
				rec.setRecContent(root.asXML());
				return this.edit(rec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<ResRec> searchResRec(List<String> schDeptFlows,ResRec rec){
		ResRecExample example = new ResRecExample();
		com.pinde.sci.model.mo.ResRecExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchDeptFlowIn(schDeptFlows);
		if(rec!=null){
			if(StringUtil.isNotBlank(rec.getSchDeptName())){
				criteria.andSchDeptNameLike("%"+rec.getSchDeptName()+"%");
			}
			if(StringUtil.isNotBlank(rec.getItemName())){
				criteria.andItemNameLike("%"+rec.getItemName()+"%");
			}
			if(StringUtil.isNotBlank(rec.getRecTypeId())){
				criteria.andRecTypeIdEqualTo(rec.getRecTypeId());
			}
			if(StringUtil.isNotBlank(rec.getAuditStatusId())){
				String auditStatusId = rec.getAuditStatusId();
				if(RecStatusEnum.TeacherAuditY.getId().equals(auditStatusId)){
					criteria.andAuditStatusIdIsNotNull();
				}
				if(RecStatusEnum.TeacherAuditN.getId().equals(auditStatusId)){
					criteria.andAuditStatusIdIsNull();
				}
			}
			if(StringUtil.isNotBlank(rec.getHeadAuditStatusId())){
				String headAuditStatusId = rec.getHeadAuditStatusId();
				if(RecStatusEnum.HeadAuditY.getId().equals(headAuditStatusId)){
					criteria.andHeadAuditStatusIdIsNotNull();
				}
				if(RecStatusEnum.HeadAuditN.getId().equals(headAuditStatusId)){
					criteria.andHeadAuditStatusIdIsNull();
				}
			}
			if(StringUtil.isNotBlank(rec.getOperUserName())){
				criteria.andOperUserNameLike("%"+rec.getOperUserName()+"%");
			}
//			if(StringUtil.isNotBlank(rec.getStatusId())){
//				criteria.andStatusIdEqualTo(rec.getStatusId());
//			}
		}
		example.setOrderByClause("OPER_TIME");
		if(StringUtil.isNotBlank(rec.getRecTypeId()) && (ResRecTypeEnum.AfterEvaluation.getId().equals(rec.getRecTypeId()))){
			return resRecMapper.selectByExampleWithBLOBs(example);
		}
		return resRecMapper.selectByExample(example);
	}
	
	@Override
	public List<Map<String,Object>> countRecWithDoc(List<String> userFlows,List<String> schDeptFlows){
		return countRecWithDoc(userFlows, schDeptFlows,null);
	}
	
	@Override
	public List<Map<String,Object>> countRecWithDoc(List<String> userFlows,List<String> schDeptFlows,String isAudit){
		return resRecExtMapper.countRecWithDoc(userFlows, schDeptFlows,isAudit);
	}
	
	/**********************************************申述*********************************************/
	
	@Override
	public int editAppeal(ResAppeal appeal){
		if(appeal!=null){
			if(StringUtil.isNotBlank(appeal.getAppealFlow())){
				GeneralMethod.setRecordInfo(appeal, false);
				return resAppealMapper.updateByPrimaryKeySelective(appeal);
			}else{
				appeal.setAppealFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(appeal, true);
				return resAppealMapper.insertSelective(appeal);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<ResAppeal> searchAppeal(String recTypeId,String schDeptFlow,String operUserFlow){
		ResAppealExample example = new ResAppealExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
		.andSchDeptFlowEqualTo(schDeptFlow).andOperUserFlowEqualTo(operUserFlow);
		example.setOrderByClause("AUDIT_STATUS_ID NULLS FIRST,OPER_TIME");
		return resAppealMapper.selectByExample(example);
	}
	
	@Override
	public List<ResAppeal> searchAppeal(ResAppeal appeal){
		ResAppealExample example = new ResAppealExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		createAppealCriteria(criteria,appeal);
		
		example.setOrderByClause("OPER_TIME");
		
		return resAppealMapper.selectByExample(example);
	}
	
	@Override
	public List<ResAppeal> searchAppeal(ResAppeal appeal,String startTime,String endTime){
		ResAppealExample example = new ResAppealExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		createAppealCriteria(criteria,appeal);
		
		if(StringUtil.isNotBlank(startTime)){
			criteria.andOperTimeGreaterThanOrEqualTo(startTime);
		}
		
		if(StringUtil.isNotBlank(endTime)){
			criteria.andOperTimeLessThanOrEqualTo(endTime);
		}
		
		example.setOrderByClause("OPER_TIME");
		
		return resAppealMapper.selectByExample(example);
	}
	
	private Criteria createAppealCriteria(Criteria criteria,ResAppeal appeal){
		if(appeal!=null){
			if(StringUtil.isNotBlank(appeal.getOperUserFlow())){
				criteria.andOperUserFlowEqualTo(appeal.getOperUserFlow());
			}
			if(StringUtil.isNotBlank(appeal.getRecTypeId())){
				criteria.andRecTypeIdEqualTo(appeal.getRecTypeId());
			}
			if(StringUtil.isNotBlank(appeal.getItemName())){
				criteria.andItemNameLike("%"+appeal.getItemName()+"%");
			}
		}
		return criteria;
	}
	
	@Override
	public ResAppeal readAppeal(String appealFlow){
		return resAppealMapper.selectByPrimaryKey(appealFlow);
	}
	
	@Override
	public List<ResAppeal> searchAppeal(List<String> schDeptFlows,ResAppeal appeal){
		ResAppealExample example = new ResAppealExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchDeptFlowIn(schDeptFlows);
		if(appeal!=null){
			if(StringUtil.isNotBlank(appeal.getSchDeptName())){
				criteria.andSchDeptNameLike("%"+appeal.getSchDeptName()+"%");
			}
			if(StringUtil.isNotBlank(appeal.getItemName())){
				criteria.andItemNameLike("%"+appeal.getItemName()+"%");
			}
			if(StringUtil.isNotBlank(appeal.getRecTypeId())){
				criteria.andRecTypeIdEqualTo(appeal.getRecTypeId());
			}
			if(StringUtil.isNotBlank(appeal.getStatusId())){
				criteria.andStatusIdEqualTo(appeal.getStatusId());
			}
			if(StringUtil.isNotBlank(appeal.getAuditStatusId())){
				String auditStatusId = appeal.getAuditStatusId();
				if(RecStatusEnum.TeacherAuditY.getId().equals(auditStatusId)){
					criteria.andAuditStatusIdIsNotNull();
				}
				if(RecStatusEnum.TeacherAuditN.getId().equals(auditStatusId)){
					criteria.andAuditStatusIdIsNull();
				}
			}
			if(StringUtil.isNotBlank(appeal.getHeadAuditStatusId())){
				String headAuditStatusId = appeal.getHeadAuditStatusId();
				if(RecStatusEnum.HeadAuditY.getId().equals(headAuditStatusId)){
					criteria.andHeadAuditStatusIdIsNotNull();
				}
				if(RecStatusEnum.HeadAuditN.getId().equals(headAuditStatusId)){
					criteria.andHeadAuditStatusIdIsNull();
				}
			}
		}
		example.setOrderByClause("OPER_TIME");
		return resAppealMapper.selectByExample(example);
	}
	
	
	@Override
	public List<Map<String,Object>> appealCountWithUser(List<String> userFlows,List<String> schDeptFlows){
		return appealExtMapper.appealCountWithUser(userFlows, schDeptFlows,null);
	}
	
	@Override
	public List<Map<String,Object>> appealCountWithUser(List<String> userFlows,List<String> schDeptFlows,String roleFlag){
		return appealExtMapper.appealCountWithUser(userFlows, schDeptFlows,roleFlag);
	}
	
	@Override
	public List<ResAppeal> searchAppealForAudit(String recTypeId,String schDeptFlow,String doctorFlow){
		return appealExtMapper.searchAppealForAudit(recTypeId, schDeptFlow,doctorFlow);
	}
	
	@Override
	public List<Map<String,Object>> searchAppealCount(String schDeptFlow,String operUserFlow){
		return appealExtMapper.searchAppealCount(schDeptFlow,operUserFlow);
	}
	
	@Override
	public List<Map<String,Object>> searchNotAuditAppealCount(String schDeptFlow,String teacherUserFlow,String isAudit){
		return appealExtMapper.searchNotAuditAppealCount(schDeptFlow,teacherUserFlow,isAudit);
	}
	/**********************************************申述*********************************************/

	
	@Override
	public int saveResRecContent(ResRecForm form) throws Exception {
		SysUser currUser = GlobalContext.getCurrentUser();
		String teachTypeId = StringUtil.defaultIfEmpty(form.getTeachTypeId(),"");
		String teachTypeName = "";
		if(StringUtil.isNotBlank(teachTypeId)){
			teachTypeName = DictTypeEnum.TeachType.getDictNameById(teachTypeId);
		}
		String teachAddress = StringUtil.defaultIfEmpty(form.getTeachAddress(),"");
		String teachDate = StringUtil.defaultIfEmpty(form.getTeachDate(),"");
		String teachExplain = StringUtil.defaultIfEmpty(form.getTeachExplain(),"");
		Document dom = null;
		Element root = null;
		ResRec resRec = readResRec(form.getRecFlow());
		if(resRec == null){//新增XML
			resRec = new ResRec();
			dom = DocumentHelper.createDocument();
			root = dom.addElement("content");
			Element teachElement = root.addElement("teach");
			Element teachTypeElement = teachElement.addElement("teachType");
			Element teachAddressElement = teachElement.addElement("teachAddress");
			Element teachDateElement = teachElement.addElement("teachDate");
			Element teachExplainElement = teachElement.addElement("teachExplain");
			teachTypeElement.addAttribute("id", teachTypeId);
			teachTypeElement.setText(teachTypeName);
			teachAddressElement.setText(teachAddress);
			teachDateElement.setText(teachDate);
			teachExplainElement.setText(teachExplain);
			
			ResDoctor resDoctor = resDoctorBiz.readDoctor(currUser.getUserFlow());
			//SysUser sysUser = userBiz.readSysUser(GlobalContext.getCurrentUser().getUserFlow());
			if(resDoctor != null){
				resRec.setOrgFlow(resDoctor.getOrgFlow());
				resRec.setOrgName(resDoctor.getOrgName());
				resRec.setDeptFlow(resDoctor.getDeptFlow());
				resRec.setDeptName(resDoctor.getDeptName());
				//resRec.setSchDeptFlow();
				//resRec.setSchDeptName();
				//教学活动
				resRec.setRecTypeId(ResRecTypeEnum.TeachRegistry.getId());
				resRec.setRecTypeName(ResRecTypeEnum.TeachRegistry.getName());
				//resRec.setItemName();
				//resRec.setRecVersion();
			}
		}else{
			String content = resRec.getRecContent();
			if(StringUtil.isNotBlank(content)){
				dom = DocumentHelper.parseText(content);
				String teachXpath = "//teach";
				Element teachElement = (Element) dom.selectSingleNode(teachXpath);
				if(teachElement != null){
					Element teachTypeElement = teachElement.element("teachType");
					if(teachTypeElement != null){
						teachTypeElement.attribute("id").setValue(teachTypeId);
						teachTypeElement.setText(teachTypeName);
					}
					Element teachAddressElement = teachElement.element("teachAddress");
					if(teachAddressElement != null){
						teachAddressElement.setText(teachAddress);
					}
					Element teachDateElement = teachElement.element("teachDate");
					if(teachDateElement != null){
						teachDateElement.setText(teachDate);
					}
					Element teachExplainElement = teachElement.element("teachExplain");
					if(teachExplainElement != null){
						teachExplainElement.setText(teachExplain);
					}
				}
			}
		}
		resRec.setRecContent(dom.asXML());
		return edit(resRec);
	}

	@Override
	public List<ResRecForm> searchResRecFormList(ResRec resRec) throws Exception {
		ResRecExample example = new ResRecExample();
		com.pinde.sci.model.mo.ResRecExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(resRec.getOrgFlow())){
			criteria.andOrgFlowEqualTo(resRec.getOrgFlow());
		}
		if(StringUtil.isNotBlank(resRec.getRecTypeId())){
			criteria.andRecTypeIdEqualTo(resRec.getRecTypeId());
		}
		if(StringUtil.isNotBlank(resRec.getOperUserFlow())){
			criteria.andOperUserFlowEqualTo(resRec.getOperUserFlow());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		List<ResRec> resRecList = resRecMapper.selectByExampleWithBLOBs(example);
		List<ResRecForm> resRecFormList = new ArrayList<ResRecForm>();
		if(resRecList != null && !resRecList.isEmpty()){
			for(ResRec rec : resRecList){
				ResRecForm form = new ResRecForm();
				form.setRecFlow(rec.getRecFlow());
				if(StringUtil.isNotBlank(rec.getRecContent())){
					Document dom = DocumentHelper.parseText(rec.getRecContent());
					String teachXpath = "//teach";
					Element teachElement = (Element) dom.selectSingleNode(teachXpath);
					if(teachElement != null){
						Element teachTypeElement = teachElement.element("teachType");
						if(teachTypeElement != null){
							form.setTeachTypeId(teachTypeElement.attributeValue("id"));
						}
						Element teachAddressElement = teachElement.element("teachAddress");
						if(teachAddressElement != null){
							form.setTeachAddress(teachAddressElement.getText());
						}
						Element teachDateElement = teachElement.element("teachDate");
						if(teachDateElement != null){
							form.setTeachDate(teachDateElement.getText());
						}
						Element teachExplainElement = teachElement.element("teachExplain");
						if(teachExplainElement != null){
							form.setTeachExplain(teachExplainElement.getText());
						}
					}
				}
				resRecFormList.add(form);
			}
		}
		return resRecFormList;
	}

	@Override
	public ResRecForm getRecContentByRecFlow(String recFlow) throws Exception {
		ResRecForm form = null;
		ResRec resRec = readResRec(recFlow);
		if(resRec != null){
			form = new ResRecForm();
			form.setRecFlow(resRec.getRecFlow());
			Document dom = DocumentHelper.parseText(resRec.getRecContent());
			String teachXpath = "//teach";
			Element teachElement = (Element) dom.selectSingleNode(teachXpath);
			if(teachElement != null){
				Element teachTypeElement = teachElement.element("teachType");
				if(teachTypeElement != null){
					form.setTeachTypeId(teachTypeElement.attributeValue("id"));
				}
				Element teachAddressElement = teachElement.element("teachAddress");
				if(teachAddressElement != null){
					form.setTeachAddress(teachAddressElement.getText());
				}
				Element teachDateElement = teachElement.element("teachDate");
				if(teachDateElement != null){
					form.setTeachDate(teachDateElement.getText());
				}
				Element teachExplainElement = teachElement.element("teachExplain");
				if(teachExplainElement != null){
					form.setTeachExplain(teachExplainElement.getText());
				}
			}
		}
		return form;
	}
	
	@Override
	public ResRec searchRecWithBLOBs(String recTypeId,String operUserFlow){
		ResRec rec = null;
		ResRecExample example = new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
			.andOperUserFlowEqualTo(operUserFlow);
		example.setOrderByClause("OPER_TIME");
		List<ResRec> list = resRecMapper.selectByExampleWithBLOBs(example);
		if (list != null && list.size() >0) {
			rec = list.get(0);
		}
		return rec;
	}
	
	private String getRecContent(String formName,IrbSingleForm singleForm,HttpServletRequest req){
		Map<String , String[]> dataMap = JspFormUtil.getParameterMap(req);
		Element rootEle = DocumentHelper.createElement(formName);
		
		List<Element> itemList = singleForm.getItemList();
		if(itemList !=null && itemList.size()>0){
			for(Element itemEle : itemList){
				if ("itemGroup".equals(itemEle.getName())) {	//itemGroup
					String igName = itemEle.attributeValue("name");
					String modelStyle = itemEle.attributeValue("modelStyle");
					if("add".equals(modelStyle)){//平滑式
						int count = getMatchDataIndex(igName , dataMap);
						 for(int i = 0 ; i<count ; i++){
							 Element itemGroupEle = ((Element)rootEle).addElement("itemGroup");
							itemGroupEle.addAttribute("name", igName);
								
							String remark = itemEle.attributeValue("remark");
							
							if(StringUtil.isNotBlank(remark)){
								itemGroupEle.addAttribute("remark", remark);
							}
							List<Element> igItemList = itemEle.selectNodes("item");
							iteratorItem(igItemList , itemGroupEle , dataMap , i);
						 }	
					}
				} else {//item
					String multiple = itemEle.attributeValue("multiple");
					if(GlobalConstant.FLAG_N.equals(multiple) || StringUtil.isBlank(multiple)){
						String name = itemEle.attributeValue("name");
						String value = "";
						if (dataMap.get(name) != null && dataMap.get(name).length>0) {
							value = dataMap.get(name)[0];
						}
						Element element = rootEle.addElement(itemEle.attributeValue("name")); 
						if(GlobalConstant.FLAG_Y.equals(itemEle.attributeValue("isView"))){
							element.addAttribute("title",itemEle.attributeValue("remark"));
						}
						if (StringUtil.isNotBlank(value)) {
							element.setText(value);
						}
					}else {
						String[] values = dataMap.get(itemEle.attributeValue("name"));
						Element element = rootEle.addElement(itemEle.attributeValue("name")); 
						if(values!=null && values.length>0){
							for(String value : values){
								Element valueEle = element.addElement("value"); 
								if (StringUtil.isNotBlank(value)) {
									valueEle.setText(value);
								}
							}
						}
					}
				}
			}
		}
		
		return rootEle.asXML();
	}
	
	/**
	 * 获取匹配的itemGroup name的item索引
	 * @param pattern
	 * @param datasMap
	 * @return
	 */
	private static int getMatchDataIndex(String pattern , Map<String , String[]> datasMap){
		int count = 0;
		Set<String> keys = datasMap.keySet();
		for(String key:keys){
			if(key.startsWith(pattern+"_")){
				String[] values = datasMap.get(key);
				count = values.length;
				break;
			}
		}
		return count;
	}
	
	/**
	 * 创建item节点 , 并根据索引设置值
	 * @param itemList
	 * @param ele
	 * @param datasMap
	 * @param index
	 */
	private static void iteratorItem(List<Element> itemList , Element ele , Map<String , String[]> datasMap , int index){
		if(itemList!=null && itemList.size()>0){
			for(Element item:itemList){
				Element itemEle = ele.addElement("item");
				String name = item.attributeValue("name");
				itemEle.addAttribute("name", name);
				String remark = item.attributeValue("remark");
				itemEle.addAttribute("remark", remark);
				String[] values = datasMap.get(name);
				String multiple = item.attributeValue("multiple");
				itemEle.addAttribute("multiple", multiple);
				Element valEle = itemEle.addElement("value");
				if(values!=null && values.length>=index+1){
					valEle.setText(values[index]);
				}
			}
		}
	}
	
	@Override
	public Map<String,Object> parseContent(String content) {
		Map<String,Object> formDataMap = null;
		if(StringUtil.isNotBlank(content)){
			formDataMap = new HashMap<String, Object>();
			try {
				Document document = DocumentHelper.parseText(content);
				Element rootElement = document.getRootElement();
				List<Element> elements = rootElement.elements();
				
				for(Element element : elements){
					if ("itemGroup".equals(element.getName())) {//itemGroup
						String key = element.attributeValue("name");
						Map<String , Object> itemGroupDataMap = null;
						if(ResRecTypeEnum.TeachRegistry.getId().equals(rootElement.getName())){
							itemGroupDataMap = new HashMap<String, Object>();
							List<Element> items = element.elements();
							for(Element item : items){
								List<Node> valueNodes = item.selectNodes("value");
								if(valueNodes != null && !valueNodes.isEmpty()){
									String value = "";
									for(Node node : valueNodes){
										if(StringUtil.isNotBlank(value)){
											value+=",";
										}
										value += node.getText();
									}
									itemGroupDataMap.put(item.getName(), value);
								}else {
									itemGroupDataMap.put(item.getName(), item.getText());
								}
							}
						}else{
							itemGroupDataMap = JspFormUtil.IteratorItemNode(element);
						}
						ItemGroupData itemGroupData = new ItemGroupData();
						itemGroupData.setFlow(element.attributeValue("recordFlow"));
						itemGroupData.setObjMap(itemGroupDataMap);
						
						if(formDataMap.containsKey(key)){
							Object obj = formDataMap.get(key);
							List<ItemGroupData> itemGroupDataList = (List<ItemGroupData>)obj;
							itemGroupDataList.add(itemGroupData);
							formDataMap.put(key, itemGroupDataList);
						}else{
							List<ItemGroupData> itemGroupDataList = new ArrayList<ItemGroupData>();
							itemGroupDataList.add(itemGroupData);
							formDataMap.put(key, itemGroupDataList);
						}
					} else {//item
						List<Node> valueNodes = element.selectNodes("value");
						if(valueNodes != null && !valueNodes.isEmpty()){
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
		return formDataMap;
	}
	
	@Override
	public Map<String,Object> parseTeachPlanContent(String content,String recordFlow) {
		Map<String,Object> dataMap = null;
		try {
			Document doc = DocumentHelper.parseText(content);
			if(doc!=null){
				Element group = (Element)doc.selectSingleNode("//itemGroup[@recordFlow='"+recordFlow+"']");
				if(group!=null){
					dataMap = new HashMap<String, Object>();
					dataMap.put("recordFlow",group.attributeValue("recordFlow"));
					List<Element> elements = group.elements();
					for(Element element : elements){
						List<Node> valueNodes = element.selectNodes("value");
						if(valueNodes != null && !valueNodes.isEmpty()){
							String value = "";
							for(Node node : valueNodes){
								if(StringUtil.isNotBlank(value)){
									value+=",";
								}
								value += node.getText();
							}
							dataMap.put(element.getName(), value);
						}else {
							dataMap.put(element.getName(), element.getText());
						}
					}
				}
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return dataMap;
	}
	
	@Override
	public int editPreTrainForm(String recFlow,String resultFlow,String roleFlag,HttpServletRequest req){
		ResRec rec = getRec(recFlow,roleFlag,resultFlow,ResRecTypeEnum.PreTrainForm.getId());
		String contet = getPreTrainXml(roleFlag,rec.getRecContent(),req);
		rec.setRecContent(contet);
		return edit(rec);
	}
	//////
	@Override
	public int editSpeAbilityAccess(String recFlow,String resultFlow,String roleFlag,HttpServletRequest req){
		ResRec rec = getRec(recFlow,roleFlag,resultFlow,ResRecTypeEnum.PreTrainForm.getId());
		String content=getSpeAbilityAccessXml(roleFlag,rec.getRecContent(),req);
		rec.setRecContent(content);
		return edit(rec);
	}
	
	@Override
	public int editAnnualTrainForm(String recFlow,String roleFlag,HttpServletRequest req){
		ResRec rec = getRec(recFlow,roleFlag,null,ResRecTypeEnum.AnnualTrainForm.getId());
		
		String contet = getAnnualTrainXml(req);
		rec.setRecContent(contet);
		return edit(rec);
	}
	//////
	public String getSpeAbilityAccessXml(String roleFlag,String content,HttpServletRequest req){
		Enumeration<String> paramNames = req.getParameterNames();
		if(paramNames!=null){
			try{
				Document document = null;
				Element root = null;
				if(StringUtil.isNotBlank(content)){
					document = DocumentHelper.parseText(content);
					root = document.getRootElement();
				}else{
					root = DocumentHelper.createElement("speAbilityAssess");
				}
				
				Node oldNode = root.selectSingleNode("//"+roleFlag);
				if(oldNode!=null){
					oldNode.detach();
				}
				
				Element newEle = root.addElement(roleFlag);
				while(paramNames.hasMoreElements()){
					String name = paramNames.nextElement();
					Element item = newEle.addElement(name);
					item.setText(req.getParameter(name));
				}
				
				content = root.asXML();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return content;
	}
	private String getPreTrainXml(String roleFlag,String content,HttpServletRequest req){
		Enumeration<String> paramNames = req.getParameterNames();
		if(paramNames!=null){
			try{
				Document document = null;
				Element root = null;
				if(StringUtil.isNotBlank(content)){
					document = DocumentHelper.parseText(content);
					root = document.getRootElement();
				}else{
					root = DocumentHelper.createElement("preTrainForm");
				}
				
				Node oldNode = root.selectSingleNode("//"+roleFlag);
				if(oldNode!=null){
					oldNode.detach();
				}
				
				Element newEle = root.addElement(roleFlag);
				while(paramNames.hasMoreElements()){
					String name = paramNames.nextElement();
					Element item = newEle.addElement(name);
					item.setText(req.getParameter(name));
				}
				
				content = root.asXML();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return content;
	}
	
	private String getAnnualTrainXml(HttpServletRequest req){
		Element root = DocumentHelper.createElement("annualTrainForm");
		
		String[] deptFlows = req.getParameterValues("deptFlow");
		if(deptFlows!=null && deptFlows.length>0){
			for(String flow : deptFlows){
				Element dept = root.addElement("dept");
				dept.addAttribute("id",flow);
				
				String[] studyType = req.getParameterValues(flow+"_studyType");
				String[] content = req.getParameterValues(flow+"_content");
				String[] trainDate = req.getParameterValues(flow+"_trainDate");
				String[] studyScore = req.getParameterValues(flow+"_studyScore");
				String[] studyHours = req.getParameterValues(flow+"_studyHours");
				String[] remark = req.getParameterValues(flow+"_remark");
				if(studyType!=null && studyType.length>0){
					int length = studyType.length;
					for(int i = 0 ;i<length ;i++){
						Element item = dept.addElement("item");
						
						Element studyTypeValue = item.addElement("value");
						studyTypeValue.addAttribute("name",flow+"_studyType");
						studyTypeValue.setText(studyType[i]);
						
						Element contentValue = item.addElement("value");
						contentValue.addAttribute("name",flow+"_content");
						contentValue.setText(content[i]);
						
						Element trainDateValue = item.addElement("value");
						trainDateValue.addAttribute("name",flow+"_trainDate");
						trainDateValue.setText(trainDate[i]);
						
						Element studyScoreValue = item.addElement("value");
						studyScoreValue.addAttribute("name",flow+"_studyScore");
						studyScoreValue.setText(studyScore[i]);
						
						Element studyHoursValue = item.addElement("value");
						studyHoursValue.addAttribute("name",flow+"_studyHours");
						studyHoursValue.setText(studyHours[i]);
						
						Element remarkValue = item.addElement("value");
						remarkValue.addAttribute("name",flow+"_remark");
						remarkValue.setText(remark[i]);
					}
				}
			}
		}
		
		String doctorName = req.getParameter("doctorName");
		Element doctorNameEle = root.addElement("doctorName");
		doctorNameEle.setText(doctorName);
		
		String doctorOperDate = req.getParameter("doctorOperDate");
		Element doctorOperDateEle = root.addElement("doctorOperDate");
		doctorOperDateEle.setText(doctorOperDate);
		
		String teacherName = req.getParameter("teacherName");
		if(StringUtil.isNotBlank(teacherName)){
			Element teacherNameEle = root.addElement("teacherName");
			teacherNameEle.setText(teacherName);
		}
		
		String operDate = req.getParameter("operDate");
		if(StringUtil.isNotBlank(operDate)){
			Element operDateEle = root.addElement("operDate");
			operDateEle.setText(operDate);
		}
		
		return root.asXML();
	}
	
	private ResRec getRec(String recFlow,String roleFlag,String resultFlow,String recTypeId){
		ResRec rec = null;
		
		if(StringUtil.isNotBlank(recFlow)){
			rec = readResRec(recFlow);
			if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
				rec.setAuditStatusId(RecStatusEnum.TeacherAuditY.getId());
				rec.setAuditStatusName(RecStatusEnum.TeacherAuditY.getName());
				rec.setAuditTime(DateUtil.getCurrDateTime());
				rec.setAuditUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				rec.setAuditUserName(GlobalContext.getCurrentUser().getUserName());
			}
		}else{
			rec = new ResRec();
			if(StringUtil.isNotBlank(resultFlow)){
				SchArrangeResult result = resultBiz.readSchArrangeResult(resultFlow);
				if(result!=null){
					rec.setDeptFlow(result.getDeptFlow());
					rec.setDeptName(result.getDeptName());
					rec.setSchDeptFlow(result.getSchDeptFlow());
					rec.setSchDeptName(result.getSchDeptName());
				}
			}
			ResDoctor doctor = resDoctorBiz.readDoctor(GlobalContext.getCurrentUser().getUserFlow());
			if(doctor!=null){
				rec.setOrgFlow(doctor.getOrgFlow());
				rec.setOrgName(doctor.getOrgName());
			}
			rec.setOperUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			rec.setOperUserName(GlobalContext.getCurrentUser().getUserName());
			rec.setRecTypeId(recTypeId);
			rec.setRecTypeName(ResRecTypeEnum.getNameById(recTypeId));
		}
		return rec;
	}
	
	@Override
	public Map<String,Map<String,String>> getPreTrainFormDataMap(String recContent){
		Map<String,Map<String,String>> dataMap = null;
		if(StringUtil.isNotBlank(recContent)){
			try{
				dataMap = new HashMap<String, Map<String,String>>();
				Document document = DocumentHelper.parseText(recContent);
				if(document != null){
					Element root = document.getRootElement();
					if(root != null){
						List<Element> roleEles = root.elements();
						if(roleEles!=null && roleEles.size()>0){
							for(Element roleEle : roleEles){
								Map<String,String> itemMap = new HashMap<String, String>();
								dataMap.put(roleEle.getName(),itemMap);
								List<Element> items = roleEle.elements();
								if(items!=null && items.size()>0){
									for(Element item : items){
										itemMap.put(item.getName(),item.getText());
									}
								}
							}
						}
					}
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return dataMap;
	}
	/////////
	@Override
	public Map<String,Map<String,String>> getSpeAbilityAssessDataMap(String recContent){
		Map<String,Map<String,String>> dataMap = null;
		if(StringUtil.isNotBlank(recContent)){
			try{
				dataMap = new HashMap<String, Map<String,String>>();
				Document document = DocumentHelper.parseText(recContent);
				if(document != null){
					Element root = document.getRootElement();
					if(root != null){
						List<Element> roleEles = root.elements();
						if(roleEles!=null && roleEles.size()>0){
							for(Element roleEle : roleEles){
								Map<String,String> itemMap = new HashMap<String, String>();
								dataMap.put(roleEle.getName(),itemMap);
								List<Element> items = roleEle.elements();
								if(items!=null && items.size()>0){
									for(Element item : items){
										itemMap.put(item.getName(),item.getText());
									}
								}
							}
						}
					}
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return dataMap;
	}
	@Override
	public Map<String,Object> getAnnualTrainFormDataMap(String recContent){
		Map<String,Object> dataMap = null;
		if(StringUtil.isNotBlank(recContent)){
			try{
				dataMap = new HashMap<String, Object>();
				Document document = DocumentHelper.parseText(recContent);
				if(document != null){
					Element root = document.getRootElement();
					if(root != null){
						List<Element> baseEles = root.elements();
						if(baseEles!=null && baseEles.size()>0){
							for(Element base : baseEles){
								String name = base.getName();
								if("dept".equals(name)){
									List<Map<String,String>> itemMaps = new ArrayList<Map<String,String>>();
									List<Element> items = base.elements();
									String id = base.attributeValue("id");
									for(Element item : items){
										Map<String,String> data = new HashMap<String, String>();
										List<Element> values = item.elements();
										for(Element value : values){
											data.put(value.attributeValue("name"),value.getText());
										}
										itemMaps.add(data);
									}
									dataMap.put(id,itemMaps);
								}else{
									dataMap.put(name,base.getText());
								}
							}
						}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return dataMap;
	}

	@Override
	public List<ResRec> searchByUserFlowAndTypeId(String operUserFlow,
			String recTypeId) {
		ResRecExample example=new ResRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecTypeIdEqualTo(recTypeId)
		.andOperUserFlowEqualTo(operUserFlow);
		return resRecMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<ResRec> searchAfterAuditRec(ResDoctorSchProcess process,SysUser user,List<String> recTypeIds,Map<String,String> roleFlagMap){
		return resRecExtMapper.searchAfterAuditRec(process,user,recTypeIds,roleFlagMap);
	}
	
	@Override
	public int auditRecs(String[] recFlows,ResRec rec){
		if(recFlows!=null && recFlows.length>0 && rec!=null){
			List<String> recFlowList = Arrays.asList(recFlows);
			ResRecExample example = new ResRecExample();
			example.createCriteria().andRecFlowIn(recFlowList);
			return resRecMapper.updateByExampleSelective(rec,example);
		}
		return GlobalConstant.ZERO_LINE;
	}
}
