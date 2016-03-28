package com.pinde.sci.biz.erp.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContactOrderBiz;
import com.pinde.sci.biz.erp.IErpOAWorkOrderBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.ErpOaContactOrderMapper;
import com.pinde.sci.dao.base.SysCfgMapper;
import com.pinde.sci.dao.erp.ErpOaContactOrderExtMapper;
import com.pinde.sci.enums.erp.ContactOrderStatusEnum;
import com.pinde.sci.enums.erp.WorkOrderStatusEnum;
import com.pinde.sci.enums.pub.WeixinStatusEnum;
import com.pinde.sci.form.erp.ContactOrderAuditForm;
import com.pinde.sci.form.erp.ContactOrderDisposeForm;
import com.pinde.sci.form.erp.ContactOrderForm;
import com.pinde.sci.form.erp.ContactOrderTimeForm;
import com.pinde.sci.form.erp.ContactOrderTrackForm;
import com.pinde.sci.form.erp.ContactVisitForm;
import com.pinde.sci.form.erp.WorkOrderForm;
import com.pinde.sci.model.mo.ErpOaContactOrder;
import com.pinde.sci.model.mo.ErpOaContactOrderExample;
import com.pinde.sci.model.mo.ErpOaContactOrderExample.Criteria;
import com.pinde.sci.model.mo.ErpOaWorkOrder;
import com.pinde.sci.model.mo.SysCfg;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class ErpContactOrderBizImpl implements IErpContactOrderBiz{

	@Autowired
	private ErpOaContactOrderMapper contactOrderMapper;
	@Autowired
	private ErpOaContactOrderExtMapper contactOrderExtMapper;
	@Resource
	private SysCfgMapper sysCfgMapper;
	@Autowired
	private IErpOAWorkOrderBiz workOrderBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IMsgBiz msgBiz;

	@Override
	public String contactOrderToXml(ContactOrderForm form) throws Exception{
		Document dom = null;
		Element root = null;
		if(form!=null){
			String address = StringUtil.defaultIfEmpty(form.getCustomerAddress(),"");
			String consumerAddress = StringUtil.defaultIfEmpty(form.getConsumerAddress(),"");
			String statusId = StringUtil.defaultIfEmpty(form.getContractStatusId(),"");
			String statusName = StringUtil.defaultIfEmpty(form.getContractStatusName(),"");
			String userFlow = StringUtil.defaultIfEmpty(form.getUserFlow(),"");
			String userName = StringUtil.defaultIfEmpty(form.getUserName(),"");
			String deptName = StringUtil.defaultIfEmpty(form.getDeptName(),"");
			String postName = StringUtil.defaultIfEmpty(form.getPostName(),"");
			String telPhone = StringUtil.defaultIfEmpty(form.getTelPhone(),"");
			String celPhone = StringUtil.defaultIfEmpty(form.getCelPhone(),"");
			ErpOaContactOrder contactOrder=null;
			if(form.getContactOrder()!=null){
				contactOrder=readContactOrder(form.getContactOrder().getContactFlow());
			}
			if(contactOrder==null){
				//第一次新增XML
				dom = DocumentHelper.createDocument();
				root = dom.addElement("info");
				Element formElement=root.addElement("form");
				Element customerElement=formElement.addElement("customer");
				Element addressElement=customerElement.addElement("address");
				addressElement.setText(address);
				Element consumerElement=formElement.addElement("consumer");
				Element consumerAddressElement=consumerElement.addElement("address");
				consumerAddressElement.setText(consumerAddress);
				Element contactUserElement=formElement.addElement("contactUser");
				Element userElement=contactUserElement.addElement("user");
				userElement.addAttribute("userFlow", userFlow);
				userElement.addAttribute("userName", userName);
				userElement.addAttribute("deptName", deptName);
				userElement.addAttribute("postName", postName);
				userElement.addAttribute("telPhone", telPhone);
				userElement.addAttribute("celPhone", celPhone);
				Element contractElement=formElement.addElement("contract");
				contractElement.addAttribute("statusId", statusId);
				contractElement.addAttribute("statusName", statusName);
			}else{
				String contactContent=contactOrder.getContactContent();
				if(StringUtil.isNotBlank(contactContent)){
					dom = DocumentHelper.parseText(contactContent);
					String infoXpath="/info";
					Element infoElement=(Element) dom.selectSingleNode(infoXpath);
					if(infoElement==null){
						infoElement=dom.addElement("info");
					}
					String formXpath="/info/form";
					Element formElement=(Element) dom.selectSingleNode(formXpath);
					if(formElement==null){
						formElement=infoElement.addElement("form");
					}
					String customerXpath="/info/form/customer";
					Element customerElement=(Element)dom.selectSingleNode(customerXpath);
					if(customerElement==null){
						customerElement=formElement.addElement("customer");
					}
					String consumerXpath="/info/form/consumer";
					Element consumerElement=(Element)dom.selectSingleNode(consumerXpath);
					if(consumerElement==null){
						consumerElement=formElement.addElement("consumer");
					}
					String addressXpath="/info/form/customer/address";
					Element addressElement=(Element)dom.selectSingleNode(addressXpath);
					if(addressElement==null){
						addressElement=customerElement.addElement("address");
					}
					addressElement.setText(address);
					
					String consumerAddressXpath="/info/form/consumer/address";
					Element consumerAddressElement=(Element)dom.selectSingleNode(consumerAddressXpath);
					if(consumerAddressElement==null){
						consumerAddressElement=consumerElement.addElement("address");
					}
					consumerAddressElement.setText(consumerAddress);
					
					String contactUserXpath = "/info/form/contactUser";
					Element contactUserElement=(Element)dom.selectSingleNode(contactUserXpath);
					if(contactUserElement==null){
						contactUserElement=formElement.addElement("contactUser");
					}
					formElement.remove(contactUserElement);
				    Element newContactUserElement=formElement.addElement("contactUser");
				    Element userElement=newContactUserElement.addElement("user");
				    userElement.addAttribute("userFlow", userFlow);
					userElement.addAttribute("userName", userName);
					userElement.addAttribute("deptName", deptName);
					userElement.addAttribute("postName", postName);
					userElement.addAttribute("telPhone", telPhone);
					userElement.addAttribute("celPhone", celPhone);
					String contractXpath="/info/form/contract";
					Element contractElement=(Element) formElement.selectSingleNode(contractXpath);
					if(contractElement==null){
						contractElement=formElement.addElement("contract");
					}
					formElement.remove(contractElement);
					Element newContractElement=formElement.addElement("contract");
					newContractElement.addAttribute("statusId", statusId);
					newContractElement.addAttribute("statusName", statusName);
				}
			}
		}
		return dom.asXML();
	}

	@Override
	public ErpOaContactOrder readContactOrder(String contactFlow) {
		ErpOaContactOrder contactOrder=this.contactOrderMapper.selectByPrimaryKey(contactFlow);
		return contactOrder;
	}
    
	@Override
	public String submitContactOrderApply(ErpOaContactOrder contactOrder) throws Exception {
		if(contactOrder!=null){
			saveContactOrder(contactOrder);
			//发消息提醒
			List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
			Map<String,String> saleMenuMap=new HashMap<String, String>();
			saleMenuMap.put("menuId", "erp-xsgl-crmxsgzl-lxdsqsh");
			if(StringUtil.isNotBlank(contactOrder.getApplyDeptFlow())){
			  saleMenuMap.put("deptFlow", contactOrder.getApplyDeptFlow());
			}
			menuMapList.add(saleMenuMap);
			String msgTitle="工作联系单（单号："+contactOrder.getContactNo()+"）已提交！";
			return contactAndWorkInformationTemplate(contactOrder, menuMapList, msgTitle);
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@Override
	public String saveContactOrder(ErpOaContactOrder contactOrder) {
		if(StringUtil.isNotBlank(contactOrder.getContactFlow())){
		  GeneralMethod.setRecordInfo(contactOrder, false);
		  int result=this.contactOrderMapper.updateByPrimaryKeySelective(contactOrder);
		  if(result==GlobalConstant.ONE_LINE){
			  return contactOrder.getContactFlow();
		  }else{
			  return GlobalConstant.SAVE_FAIL;
		  }
		}else{
			contactOrder.setContactFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(contactOrder, true);
			synchronized(this){
				String newNo = "";
				String signYearAndMonth = DateUtil.transDateTime(contactOrder.getApplyDate(), "yyyy-MM-dd HH:mm","yyyyMM");
				String cfgCode =  signYearAndMonth;
				SysCfg cfg = sysCfgMapper.selectByPrimaryKey("PDXXLXD"+cfgCode);
				 if (cfg != null && StringUtil.isNotBlank(cfg.getCfgValue())) {
					  String cfgValue =  cfg.getCfgValue();
					  newNo = Integer.parseInt(cfgValue) + 1 + "";
				   } else {
					   newNo = "1";
				   }
				//回写cfgValue
				   if (cfg == null) {
				       cfg = new SysCfg();
					   cfg.setCfgCode("PDXXLXD"+cfgCode);
					   cfg.setCfgValue(newNo);
					   cfg.setCfgDesc("南京品德信息最新联系单号");
					   cfg.setWsId("contactOrder");
					   cfg.setWsName("联系单");
					   GeneralMethod.setRecordInfo(cfg, true);
					   sysCfgMapper.insert(cfg);
				   } else {
					   cfg.setCfgValue(newNo);
					   cfg.setCfgDesc("南京品德信息最新联系单号");
					   cfg.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
					   GeneralMethod.setRecordInfo(cfg, false);
					   sysCfgMapper.updateByPrimaryKeySelective(cfg);
				   }
				   //newNo不足三位补0
				   int length = newNo.length();
				   if (length<3) {
					   for (int i=0;i<(3-length);i++) {
						   newNo = "0" + newNo;
					   }
				   }
				   contactOrder.setContactNo(cfgCode + newNo);
			}
			this.contactOrderMapper.insertSelective(contactOrder);
			return contactOrder.getContactFlow();
		}
		
	}
    
	
	
	@Override
	public List<ErpOaContactOrder> searchContactOrderList(
			ErpOaContactOrder contactOrder,ContactOrderTimeForm timeForm) {
		ErpOaContactOrderExample example=new ErpOaContactOrderExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(contactOrder!=null){
			if(StringUtil.isNotBlank(contactOrder.getCustomerFlow())){
				criteria.andCustomerFlowEqualTo(contactOrder.getCustomerFlow());
			}
			if(StringUtil.isNotBlank(contactOrder.getCustomerName())){
				criteria.andCustomerNameLike("%"+contactOrder.getCustomerName()+"%");
			}
			if(StringUtil.isNotBlank(contactOrder.getDemandMatterId())){
				criteria.andDemandMatterIdEqualTo(contactOrder.getDemandMatterId());
			}
			if(StringUtil.isNotBlank(contactOrder.getContactStatusId())){
				criteria.andContactStatusIdEqualTo(contactOrder.getContactStatusId());
			}
			if(StringUtil.isNotBlank(contactOrder.getProductTypeName())){
				criteria.andProductTypeNameLike("%"+contactOrder.getProductTypeName()+"%");
			}
			if(StringUtil.isNotBlank(contactOrder.getContractFlow())){
				criteria.andContractFlowEqualTo(contactOrder.getContractFlow());
			}
		}
		if(timeForm!=null){
			if(StringUtil.isNotBlank(timeForm.getApplyDateStart())){
				criteria.andApplyDateGreaterThanOrEqualTo(timeForm.getApplyDateStart());
			}
			if(StringUtil.isNotBlank(timeForm.getApplyDateEnd())){
				criteria.andApplyDateLessThanOrEqualTo(timeForm.getApplyDateEnd());
			}
		}
		    example.setOrderByClause("APPLY_DATE DESC, CREATE_TIME DESC");
		return this.contactOrderMapper.selectByExample(example);
	}
	
	@Override
	public List<ErpOaContactOrder> searchHistoryContactOrderList(
			ErpOaContactOrder contactOrder,ContactOrderTimeForm timeForm) {
		ErpOaContactOrderExample example=new ErpOaContactOrderExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(contactOrder!=null){
			if(StringUtil.isNotBlank(contactOrder.getCustomerFlow())){
				criteria.andCustomerFlowEqualTo(contactOrder.getCustomerFlow());
			}
			if(StringUtil.isNotBlank(contactOrder.getCustomerName())){
				criteria.andCustomerNameLike("%"+contactOrder.getCustomerName()+"%");
			}
			if(StringUtil.isNotBlank(contactOrder.getDemandMatterId())){
				criteria.andDemandMatterIdEqualTo(contactOrder.getDemandMatterId());
			}
			if(StringUtil.isNotBlank(contactOrder.getContactStatusId())){
				criteria.andContactStatusIdNotEqualTo(contactOrder.getContactStatusId());
			}
			if(StringUtil.isNotBlank(contactOrder.getProductTypeName())){
				criteria.andProductTypeNameLike("%"+contactOrder.getProductTypeName()+"%");
			}
			if(StringUtil.isNotBlank(contactOrder.getContractFlow())){
				criteria.andContractFlowEqualTo(contactOrder.getContractFlow());
			}
		}
		if(timeForm!=null){
			if(StringUtil.isNotBlank(timeForm.getApplyDateStart())){
				criteria.andApplyDateGreaterThanOrEqualTo(timeForm.getApplyDateStart());
			}
			if(StringUtil.isNotBlank(timeForm.getApplyDateEnd())){
				criteria.andApplyDateLessThanOrEqualTo(timeForm.getApplyDateEnd());
			}
		}
		    example.setOrderByClause("APPLY_DATE DESC, CREATE_TIME DESC");
		return this.contactOrderMapper.selectByExample(example);
	}

	@Override
	public ContactOrderForm xmlToContactOrder(String contactContent) throws DocumentException {
		ContactOrderForm form=new ContactOrderForm();
		if(StringUtil.isNotBlank(contactContent)){
			Document dom = DocumentHelper.parseText(contactContent);
			String addressXpath="/info/form/customer/address";
			Element addressElement=(Element) dom.selectSingleNode(addressXpath);
			if(addressElement!=null){
				form.setCustomerAddress(addressElement.getText());
			}
			String consumerAddressXpath="/info/form/consumer/address";
			Element consumerAddressElement=(Element) dom.selectSingleNode(consumerAddressXpath);
			if(consumerAddressElement!=null){
				form.setConsumerAddress(consumerAddressElement.getText());
			}
			String userXpath="//user";
			Element userElement=(Element) dom.selectSingleNode(userXpath);
			if(userElement!=null){
				    form.setUserFlow(userElement.attributeValue("userFlow"));
				    form.setUserName(userElement.attributeValue("userName"));
				    form.setPostName(userElement.attributeValue("postName"));
				    form.setDeptName(userElement.attributeValue("deptName"));
				    form.setTelPhone(userElement.attributeValue("telPhone"));
				    form.setCelPhone(userElement.attributeValue("celPhone"));
			}
		    String contractXpath="/info/form/contract";
		    Element contractElement=(Element) dom.selectSingleNode(contractXpath);
		    if(contractElement!=null){
		    	form.setContractStatusId(contractElement.attributeValue("statusId"));
			    form.setContractStatusName(contractElement.attributeValue("statusName"));
		    }
		}
		return form;
	}

	@Override
	public List<ErpOaContactOrder> searchContactOrderList(
			Map<String, Object> paramMap) {
		List<ErpOaContactOrder> contactOrderList=this.contactOrderExtMapper.searchContactOrderList(paramMap);
		return contactOrderList;
	}

	@Override
	public String deleteContactOrder(String contactFlow) {
		ErpOaContactOrder contactOrder=this.readContactOrder(contactFlow);
		if(contactOrder!=null){
			contactOrder.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(contactOrder, false);
			int result=this.contactOrderMapper.updateByPrimaryKeySelective(contactOrder);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}

	@Override
	public List<ContactOrderAuditForm> searchContactOrderAuditForm(
			String contactFlow) throws DocumentException {
		List<ContactOrderAuditForm> auditFormList=new ArrayList<ContactOrderAuditForm>();
	    ErpOaContactOrder contactOrder=readContactOrder(contactFlow);
	    if(contactOrder!=null){
	      if(StringUtil.isNotBlank(contactOrder.getContactContent())){
	    	  Document dom = DocumentHelper.parseText(contactOrder.getContactContent());
			  String auditsXpath="/info/audits";
			  Element auditsElement=(Element) dom.selectSingleNode(auditsXpath);
			  if(auditsElement==null){
				  return auditFormList;
			  }else{
				  String auditXpath="//audit";
				  List<Element> auditElementList=dom.selectNodes(auditXpath);
				  if(auditElementList!=null && !auditElementList.isEmpty()){
					  ContactOrderAuditForm form=null;
					  for(Element audit:auditElementList){
						  form=new ContactOrderAuditForm();
						  Element auditUserElement=(Element) audit.selectSingleNode("auditUser");
						  if(auditUserElement!=null){
							  form.setUserFlow(auditUserElement.attributeValue("userFlow"));
							  form.setUserName(auditUserElement.attributeValue("userName"));
						  }
						  Element auditDateElement=(Element) audit.selectSingleNode("auditDate");
						  if(auditDateElement!=null){
							  form.setAuditDate(auditDateElement.getText());
						  }
						  Element auditResultElement=(Element) audit.selectSingleNode("auditResult");
						  if(auditResultElement!=null){
							  form.setAuditStatusId(auditResultElement.attributeValue("id"));
							  form.setAuditStatusName(auditResultElement.attributeValue("name"));
							  form.setAuditContent(auditResultElement.getText());
						  }
						  auditFormList.add(form);
					  }
				  }
			  }
	      }	
	    }
		return auditFormList;
	}

	@Override
	public String contactOrderAuditToXml(ContactOrderAuditForm form,
			String contactFlow) throws DocumentException {
		 Document dom=null;
		 ErpOaContactOrder contactOrder=readContactOrder(contactFlow);
		 if(contactOrder!=null){
		      if(StringUtil.isNotBlank(contactOrder.getContactContent())){
		    	  dom = DocumentHelper.parseText(contactOrder.getContactContent());
				  Element rootElement=dom.getRootElement();
		    	  String auditsXpath="/info/audits";
				  Element auditsElement=(Element) dom.selectSingleNode(auditsXpath);
				  if(auditsElement==null){
					  auditsElement=rootElement.addElement("audits");
				  } 
				  Element auditElement=auditsElement.addElement("audit");
				  Element auditUserElement=auditElement.addElement("auditUser");
		    	  auditUserElement.addAttribute("userFlow", form.getUserFlow());
		    	  auditUserElement.addAttribute("userName", form.getUserName());
		    	  Element auditDateElement=auditElement.addElement("auditDate");
		    	  auditDateElement.setText(form.getAuditDate());
		    	  Element auditResultElement=auditElement.addElement("auditResult");
		    	  auditResultElement.addAttribute("id", form.getAuditStatusId());
		    	  auditResultElement.addAttribute("name", form.getAuditStatusName());
		    	  auditResultElement.setText(form.getAuditContent());
		    	  return dom.asXML();
		      }
		 }
		 return "";
	}

	@Override
	public String contactOrderDisposeToXml(ContactOrderDisposeForm form,
			String contactFlow) throws DocumentException {
		 Document dom=null;
		 ErpOaContactOrder contactOrder=readContactOrder(contactFlow);
		 if(contactOrder!=null){
			 if(StringUtil.isNotBlank(contactOrder.getContactContent())){
				 dom = DocumentHelper.parseText(contactOrder.getContactContent());
				  Element rootElement=dom.getRootElement();
		    	  String disposeXpath="/info/dispose";
				  Element disposeElement=(Element) dom.selectSingleNode(disposeXpath);
				  if(disposeElement==null){
					  disposeElement=rootElement.addElement("dispose");
				  }
				  String planFinishTimeXpath="/info/dispose/planFinishTime";
				  Element planFinishTimeElement=(Element) dom.selectSingleNode(planFinishTimeXpath);
				  if(planFinishTimeElement==null){
					  planFinishTimeElement=disposeElement.addElement("planFinishTime");
				  }
				  planFinishTimeElement.setText(form.getPlanFinishTime());
				  
				  String methodXpath="/info/dispose/method";
				  Element methodElement=(Element) dom.selectSingleNode(methodXpath);
				  if(methodElement==null){
					  methodElement=disposeElement.addElement("method");
				  }
				  methodElement.setText(form.getMethod()==null?"":form.getMethod());
				  
				  String resultXpath="/info/dispose/result";
				  Element resultElement=(Element) dom.selectSingleNode(resultXpath);
				  if(resultElement==null){
					  resultElement=disposeElement.addElement("result");
				  }
				  resultElement.setText(form.getResult());
				  return dom.asXML();
			 }
		 }
		return "";
	}

	@Override
	public ContactOrderDisposeForm searchDisposeForm(String contactFlow)
			throws DocumentException {
		ContactOrderDisposeForm form=new ContactOrderDisposeForm();
		ErpOaContactOrder contactOrder=readContactOrder(contactFlow);
		 if(contactOrder!=null){
		      if(StringUtil.isNotBlank(contactOrder.getContactContent())){
		    	  Document dom = DocumentHelper.parseText(contactOrder.getContactContent());
				  String planFinishTimeXpath="/info/dispose/planFinishTime";
				  Element planFinishTimeElement=(Element) dom.selectSingleNode(planFinishTimeXpath);
				  if(planFinishTimeElement!=null){
					  form.setPlanFinishTime(planFinishTimeElement.getText());
				  }
				  String methodXpath="/info/dispose/method";
				  Element methodElement=(Element) dom.selectSingleNode(methodXpath);
				  if(methodElement!=null){
					  form.setMethod(methodElement.getText());
				  }	 
				  String resultXpath="/info/dispose/result";
				  Element resultElement=(Element) dom.selectSingleNode(resultXpath);
				  if(resultElement!=null){
					  form.setResult(resultElement.getText());
				  }	 
		      }
		 }
		return form;
	}

	@Override
	public List<ContactVisitForm> searchVisitForm(String contactFlow)
			throws DocumentException {
		ErpOaContactOrder contactOrder=readContactOrder(contactFlow);
		List<ContactVisitForm> visitFormList=new ArrayList<ContactVisitForm>();
		if(contactOrder!=null){
			if(StringUtil.isNotBlank(contactOrder.getContactContent())){
				Document dom = DocumentHelper.parseText(contactOrder.getContactContent());
				 String visitsXpath="/info/visits";
				  Element visitsElement=(Element) dom.selectSingleNode(visitsXpath);
				  if(visitsElement==null){
					  return visitFormList;
				  }else{
					  String visitXpath="//visit";
					  List<Element> visitElementList=dom.selectNodes(visitXpath);
					  if(visitElementList!=null && !visitElementList.isEmpty()){
						  ContactVisitForm visitForm=null;
						  for(Element visitElement:visitElementList){
							  visitForm=new ContactVisitForm();
							  Element customerLinkManElement=(Element) visitElement.selectSingleNode("customerLinkMan");
							  if(customerLinkManElement!=null){
								  visitForm.setCustomerLinkManFlow(customerLinkManElement.attributeValue("userFlow"));
								  visitForm.setCustomerLinkMan(customerLinkManElement.getText());
							  }
							  Element visitContentElement=(Element) visitElement.selectSingleNode("visitContent");
							  if(visitContentElement!=null){
								  visitForm.setVisitDate(visitContentElement.attributeValue("visitDate"));
								  visitForm.setIsSolved(visitContentElement.attributeValue("isSolved"));
								  visitForm.setVisitContent(visitContentElement.getText());
							  }
							  Element visitorElement=(Element) visitElement.selectSingleNode("visitor");
							  if(visitorElement!=null){
								  visitForm.setVisitor(visitorElement.getText());
							  }
							  visitFormList.add(visitForm);
						  }
					  }
				  }
			}
		}
		return visitFormList;
	}

	@Override
	public String contactVisitFormToXml(ContactVisitForm visitForm,
			String contactFlow) throws DocumentException {
		 Document dom=null;
		 ErpOaContactOrder contactOrder=readContactOrder(contactFlow);
		 if(contactOrder!=null){
		      if(StringUtil.isNotBlank(contactOrder.getContactContent())){
		    	  dom = DocumentHelper.parseText(contactOrder.getContactContent());
				  Element rootElement=dom.getRootElement();
		    	  String visitsXpath="/info/visits";
				  Element visitsElement=(Element) dom.selectSingleNode(visitsXpath);
				  if(visitsElement==null){
					  visitsElement=rootElement.addElement("visits");
				  }
				  Element visitElement=visitsElement.addElement("visit");
				  Element customerLinkManElement=visitElement.addElement("customerLinkMan");
				  customerLinkManElement.addAttribute("userFlow", visitForm.getCustomerLinkManFlow());
				  customerLinkManElement.setText(visitForm.getCustomerLinkMan());
				  Element visitContentElement=visitElement.addElement("visitContent");
				  visitContentElement.addAttribute("visitDate", visitForm.getVisitDate());
				  visitContentElement.addAttribute("isSolved", visitForm.getIsSolved());
				  visitContentElement.setText(visitForm.getVisitContent());
				  Element visitorElement=visitElement.addElement("visitor");
				  visitorElement.setText(visitForm.getVisitor());
		          return dom.asXML();
	 }
   }
		 return "";
}
	
	@Override
	public List<ContactOrderTrackForm> searchTrackForm(String contactFlow)
			throws DocumentException {
		ErpOaContactOrder contactOrder=readContactOrder(contactFlow);
		List<ContactOrderTrackForm> trackFormList=new ArrayList<ContactOrderTrackForm>();
		if(contactOrder!=null){
			if(StringUtil.isNotBlank(contactOrder.getContactContent())){
				Document dom = DocumentHelper.parseText(contactOrder.getContactContent());
				 String tracksXpath="/info/tracks";
				  Element tracksElement=(Element) dom.selectSingleNode(tracksXpath);
				  if(tracksElement==null){
					  return trackFormList;
				  }else{
					  String trackXpath="//track";
					  List<Element> trackElementList=dom.selectNodes(trackXpath);
					  if(trackElementList!=null && !trackElementList.isEmpty()){
						  ContactOrderTrackForm trackForm=null;
						  for(Element trackElement:trackElementList){
							  trackForm=new ContactOrderTrackForm();
							  Element recordElement=(Element) trackElement.selectSingleNode("record");
							  if(recordElement!=null){
								  trackForm.setRecordUserFlow(recordElement.attributeValue("userFlow"));
								  trackForm.setRecordUserName(recordElement.attributeValue("userName"));
								  trackForm.setRecordDate(recordElement.attributeValue("recordDate"));
							  }
							  Element dateElement=(Element) trackElement.selectSingleNode("date");
							  if(dateElement!=null){
								  trackForm.setTrackDate(dateElement.getText());
							  }
							  Element contentElement=(Element) trackElement.selectSingleNode("content");
							  if(contentElement!=null){
								  trackForm.setTrackContent(contentElement.getText());
							  }
							  trackFormList.add(trackForm);
						  }
					  }
				  }
			}
		}
		return trackFormList;
	}

	@Override
	public String contactTrackFormToXml(ContactOrderTrackForm trackForm,
			String contactFlow) throws DocumentException {
		 Document dom=null;
		 ErpOaContactOrder contactOrder=readContactOrder(contactFlow);
		 if(contactOrder!=null){
		      if(StringUtil.isNotBlank(contactOrder.getContactContent())){
		    	  dom = DocumentHelper.parseText(contactOrder.getContactContent());
				  Element rootElement=dom.getRootElement();
		    	  String tracksXpath="/info/tracks";
				  Element tracksElement=(Element) dom.selectSingleNode(tracksXpath);
				  if(tracksElement==null){
					  tracksElement=rootElement.addElement("tracks");
				  }
				  Element trackElement=tracksElement.addElement("track");
				  Element recordElement=trackElement.addElement("record");
				  recordElement.addAttribute("userFlow", trackForm.getRecordUserFlow());
				  recordElement.addAttribute("userName", trackForm.getRecordUserName());
				  recordElement.addAttribute("recordDate", trackForm.getRecordDate());
				  Element dateElement=trackElement.addElement("date");
				  dateElement.setText(trackForm.getTrackDate());
				  Element contentElement=trackElement.addElement("content");
				  contentElement.setText(trackForm.getTrackContent());
		          return dom.asXML();
	 }
   }
		 return "";
}

	@Override
	public String closeContactAndWorkOrder(String contactFlow) throws Exception {
		ErpOaContactOrder contactOrder = this.readContactOrder(contactFlow);
		if(contactOrder!=null){
			ContactOrderAuditForm form=new ContactOrderAuditForm();
			form.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			form.setUserName(GlobalContext.getCurrentUser().getUserName());
			form.setAuditStatusId(ContactOrderStatusEnum.Closed.getId());
			form.setAuditStatusName(ContactOrderStatusEnum.Closed.getName());
			form.setAuditDate(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
			form.setAuditContent("");
			String contactOrderContent=contactOrderAuditToXml(form,contactFlow);
			contactOrder.setContactContent(contactOrderContent);
			contactOrder.setContactStatusId(ContactOrderStatusEnum.Closed.getId());
			contactOrder.setContactStatusName(ContactOrderStatusEnum.Closed.getName());
		    this.saveContactOrder(contactOrder);	
		
		ErpOaWorkOrder workOrder=new ErpOaWorkOrder();
		workOrder.setContactFlow(contactFlow);
		List<ErpOaWorkOrder> workOrderList=this.workOrderBiz.searchWorkOrderList(workOrder);
		if(workOrderList!=null && !workOrderList.isEmpty()){
			for(ErpOaWorkOrder wo:workOrderList){
				wo.setWorkStatusId(WorkOrderStatusEnum.Closed.getId());
				wo.setWorkStatusName(WorkOrderStatusEnum.Closed.getName());
				this.workOrderBiz.save(wo);
			}
		}
		 //消息提醒
		List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
		Map<String,String> saleMenuMap=new HashMap<String, String>();
		saleMenuMap.put("menuId", "erp-xsgl-crmxsgzl-lxdsqsh");
		if(StringUtil.isNotBlank(contactOrder.getApplyDeptFlow())){
			  saleMenuMap.put("deptFlow", contactOrder.getApplyDeptFlow());
		}
		Map<String,String> implementMenuMap=new HashMap<String, String>();
		implementMenuMap.put("menuId", "erp-ssgl-lxdgl-lxdpg");
		String msgTitle="工作联系单（单号："+contactOrder.getContactNo()+"）已关单！";
		return contactAndWorkInformationTemplate(contactOrder, menuMapList, msgTitle);
		}
		return GlobalConstant.OPRE_FAIL;
	}

	@Override
	public String saveContactApplyAudit(ErpOaContactOrder oaContactOrder,
			ContactOrderAuditForm form,String status, String scope) throws Exception {
		if(oaContactOrder!=null && form!=null){
		     String msgTitle="";
		     List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
			 if(GlobalConstant.USER_LIST_GLOBAL.equals(scope)){
				  if(GlobalConstant.FLAG_Y.equals(status)){
					   //总经理审核通过
						form.setAuditStatusId(ContactOrderStatusEnum.ManagerPassed.getId());
						form.setAuditStatusName(ContactOrderStatusEnum.ManagerPassed.getName());
						oaContactOrder.setContactStatusId(ContactOrderStatusEnum.ManagerPassed.getId());
						oaContactOrder.setContactStatusName(ContactOrderStatusEnum.ManagerPassed.getName());
						//发送消息
						Map<String,String> saleMenuMap=new HashMap<String, String>();
						saleMenuMap.put("menuId", "erp-xsgl-crmxsgzl-lxdsqsh");
						if(StringUtil.isNotBlank(oaContactOrder.getApplyDeptFlow())){
							  saleMenuMap.put("deptFlow", oaContactOrder.getApplyDeptFlow());
						}
						Map<String,String> implementMenuMap=new HashMap<String, String>();
						implementMenuMap.put("menuId", "erp-ssgl-lxdgl-lxdjs");
						menuMapList.add(saleMenuMap);
						menuMapList.add(implementMenuMap);
						msgTitle="工作联系单（单号："+oaContactOrder.getContactNo()+"）总经理审核通过！";
				  }else{
						//总经理审核不通过
						form.setAuditStatusId(ContactOrderStatusEnum.ManagerUnPassed.getId());
						form.setAuditStatusName(ContactOrderStatusEnum.ManagerUnPassed.getName());
						oaContactOrder.setContactStatusId(ContactOrderStatusEnum.ManagerUnPassed.getId());
						oaContactOrder.setContactStatusName(ContactOrderStatusEnum.ManagerUnPassed.getName());
						//发送消息
						Map<String,String> saleMenuMap=new HashMap<String, String>();
						saleMenuMap.put("menuId", "erp-xsgl-crmxsgzl-lxdsqsh");
						if(StringUtil.isNotBlank(oaContactOrder.getApplyDeptFlow())){
							  saleMenuMap.put("deptFlow", oaContactOrder.getApplyDeptFlow());
						}
						menuMapList.add(saleMenuMap);
						msgTitle="工作联系单（单号："+oaContactOrder.getContactNo()+"）总经理审核不通过！";
				  }
			  }
	         if(GlobalConstant.USER_LIST_LOCAL.equals(scope)){
	       	  if(GlobalConstant.FLAG_Y.equals(status)){
	       		        //商务审核通过
						form.setAuditStatusId(ContactOrderStatusEnum.BusinessPassed.getId());
						form.setAuditStatusName(ContactOrderStatusEnum.BusinessPassed.getName());
						oaContactOrder.setContactStatusId(ContactOrderStatusEnum.BusinessPassed.getId());
						oaContactOrder.setContactStatusName(ContactOrderStatusEnum.BusinessPassed.getName());
						//发送消息
						Map<String,String> saleMenuMap=new HashMap<String, String>();
						saleMenuMap.put("menuId", "erp-xsgl-crmxsgzl-lxdsqsh");
						if(StringUtil.isNotBlank(oaContactOrder.getApplyDeptFlow())){
							  saleMenuMap.put("deptFlow", oaContactOrder.getApplyDeptFlow());
						}
						Map<String,String> implementMenuMap=new HashMap<String, String>();
						implementMenuMap.put("menuId", "erp-ssgl-lxdgl-lxdjs");
						menuMapList.add(saleMenuMap);
						menuMapList.add(implementMenuMap);
						msgTitle="工作联系单（单号："+oaContactOrder.getContactNo()+"）商务审核通过！";
	       	  }else if(GlobalConstant.FLAG_F.equals(status)){
						 //商务审核通过至总经理审核
						form.setAuditStatusId(ContactOrderStatusEnum.ManagerAuditing.getId());
						form.setAuditStatusName(ContactOrderStatusEnum.ManagerAuditing.getName());
						oaContactOrder.setContactStatusId(ContactOrderStatusEnum.ManagerAuditing.getId());
						oaContactOrder.setContactStatusName(ContactOrderStatusEnum.ManagerAuditing.getName());
						//发送消息
						Map<String,String> saleMenuMap=new HashMap<String, String>();
						saleMenuMap.put("menuId", "erp-xsgl-crmxsgzl-lxdsqsh");
						if(StringUtil.isNotBlank(oaContactOrder.getApplyDeptFlow())){
							  saleMenuMap.put("deptFlow", oaContactOrder.getApplyDeptFlow());
						}
						Map<String,String> bossMenuMap=new HashMap<String, String>();
						bossMenuMap.put("menuId", "erp-zjl-shgl-lxdsqsh");
						menuMapList.add(saleMenuMap);
						menuMapList.add(bossMenuMap);
						msgTitle="工作联系单（单号："+oaContactOrder.getContactNo()+"）商务审核通过,等待总经理审核！";
	       	      }else{
						form.setAuditStatusId(ContactOrderStatusEnum.BusinessUnPassed.getId());
						form.setAuditStatusName(ContactOrderStatusEnum.BusinessUnPassed.getName());
						oaContactOrder.setContactStatusId(ContactOrderStatusEnum.BusinessUnPassed.getId());
						oaContactOrder.setContactStatusName(ContactOrderStatusEnum.BusinessUnPassed.getName());
						//发送消息
						Map<String,String> saleMenuMap=new HashMap<String, String>();
						saleMenuMap.put("menuId", "erp-xsgl-crmxsgzl-lxdsqsh");
						if(StringUtil.isNotBlank(oaContactOrder.getApplyDeptFlow())){
							  saleMenuMap.put("deptFlow", oaContactOrder.getApplyDeptFlow());
						}
						menuMapList.add(saleMenuMap);
						msgTitle="工作联系单（单号："+oaContactOrder.getContactNo()+"）商务审核不通过！";
	       	      }
			  }
	         if(GlobalConstant.USER_LIST_PERSONAL.equals(scope)){
	       	  if(GlobalConstant.FLAG_Y.equals(status)){
	       		        //销售部门经理审核通过
						form.setAuditStatusId(ContactOrderStatusEnum.SalePassed.getId());
						form.setAuditStatusName(ContactOrderStatusEnum.SalePassed.getName());
						oaContactOrder.setContactStatusId(ContactOrderStatusEnum.SalePassed.getId());
						oaContactOrder.setContactStatusName(ContactOrderStatusEnum.SalePassed.getName());
						//发送消息
						Map<String,String> businessMenuMap=new HashMap<String, String>();
						businessMenuMap.put("menuId", "erp-swgl-shgl-lxdsh");
						menuMapList.add(businessMenuMap);
						msgTitle="工作联系单（单号："+oaContactOrder.getContactNo()+"）销售部门审核通过，等待商务审核中！";
	       	  }else{
						//销售部门经理审核不通过
						form.setAuditStatusId(ContactOrderStatusEnum.SaleUnPassed.getId());
						form.setAuditStatusName(ContactOrderStatusEnum.SaleUnPassed.getName());
						oaContactOrder.setContactStatusId(ContactOrderStatusEnum.SaleUnPassed.getId());
						oaContactOrder.setContactStatusName(ContactOrderStatusEnum.SaleUnPassed.getName());
						//发送消息
						msgTitle="工作联系单（单号："+oaContactOrder.getContactNo()+"）销售部门审核不通过！";
					}
			  }
				String content=contactOrderAuditToXml(form, oaContactOrder.getContactFlow());
				if(StringUtil.isNotBlank(content)){
					oaContactOrder.setContactContent(content);
				}
				saveContactOrder(oaContactOrder);
				return contactAndWorkInformationTemplate(oaContactOrder, menuMapList, msgTitle);
		} 
		return GlobalConstant.SAVE_FAIL;
	}

	@Override
	public String saveVisitResult(ErpOaContactOrder contact) throws Exception {
		if(contact!=null){
			saveContactOrder(contact);
			//回访完成发消息提醒商务关单
			List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
			Map<String,String> businessMenuMap=new HashMap<String, String>();
			businessMenuMap.put("menuId", "erp-swgl-shgl-lxdsh");
			menuMapList.add(businessMenuMap);
			String msgTitle="工作联系单（单号："+contact.getContactNo()+"）回访完成！";
			return contactAndWorkInformationTemplate(contact, menuMapList, msgTitle);
		}
		return GlobalConstant.OPRE_FAIL;
	}

	@Override
	public String recallContact(ErpOaContactOrder contact) throws Exception {
		if(contact!=null){
			saveContactOrder(contact);
			//联系单撤回发消息提醒实施部门
			List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
			Map<String,String> implementMenuMap=new HashMap<String, String>();
			implementMenuMap.put("menuId", "erp-ssgl-lxdgl-lxdpg");
			menuMapList.add(implementMenuMap);
			String msgTitle="工作联系单（单号："+contact.getContactNo()+"）已经被撤回至"+contact.getReceiveDeptName()+"！";
			return contactAndWorkInformationTemplate(contact, menuMapList, msgTitle);
		}
		return GlobalConstant.OPRE_FAIL;
	}

	@Override
	public String saveContactReassign(ErpOaContactOrder contact,String receiveFlag) throws Exception {
		if(contact!=null){
			List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
			String msgTitle="";
			if(GlobalConstant.FLAG_Y.equals(receiveFlag)){
				Map<String,String> implementMenuMap=new HashMap<String, String>();
				implementMenuMap.put("menuId", "erp-ssgl-lxdgl-lxdpg");
				menuMapList.add(implementMenuMap);
				contact.setContactStatusId(ContactOrderStatusEnum.Received.getId());
				contact.setContactStatusName(ContactOrderStatusEnum.Received.getName());
				contact.setReceiveUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				contact.setReceiveUserName(GlobalContext.getCurrentUser().getUserName());
				msgTitle="工作联系单（单号："+contact.getContactNo()+"）已经被"+contact.getReceiveDeptName()+"接收！";
			}else{
				Map<String,String> implementMenuMap=new HashMap<String, String>();
				implementMenuMap.put("menuId", "erp-ssgl-lxdgl-lxdjs");
				implementMenuMap.put("deptFlow", contact.getReceiveDeptFlow());
				menuMapList.add(implementMenuMap);
				msgTitle="工作联系单（单号："+contact.getContactNo()+"）已经被改派至"+contact.getReceiveDeptName()+"！";
			}
		    saveContactOrder(contact);
			return contactAndWorkInformationTemplate(contact, menuMapList, msgTitle);
		}
		return GlobalConstant.OPRE_FAIL;
	}

	
	@Override
	public String contactAndWorkInformationTemplate(Object obj,
			List<Map<String,String>> menuMapList,String msgTitle) throws Exception {
		List<SysUser> targetList=new ArrayList<SysUser>();
 		List<String> targetFlowList=new ArrayList<String>();
		ErpOaContactOrder contact=null;
		ErpOaWorkOrder work=null;
		String thisMsgTitle="";
		String thisMsgContent="";
		String msgContent="";
		//查询消息发送目标（来自向上与向下菜单）
		Map<String,Object> paramMap=null;
	    if(menuMapList!=null && !menuMapList.isEmpty()){
	    	List<SysUser> userList=null;
	    	for(Map<String,String> map:menuMapList){
	    		paramMap=new HashMap<String, Object>();
	    		if(StringUtil.isNotBlank(map.get("menuId"))){
	    			paramMap.put("menuId", map.get("menuId"));
	    		}
	    		if(StringUtil.isNotBlank(map.get("deptFlow"))){
	    			paramMap.put("deptFlow", map.get("deptFlow"));
	    		}
	    		userList=this.userBiz.searchUserByMenu(paramMap);
	    		if(userList!=null && !userList.isEmpty()){
	    			for(SysUser user:userList){
	    				if(!targetFlowList.contains(user.getUserFlow())){
	    					targetList.add(user);
	    					targetFlowList.add(user.getUserFlow());
	    				}
	    			}
	    		}
	    	}
	    }
		if(obj instanceof ErpOaContactOrder){
			//查询消息发送目标（联系单申请人自身）
			contact=(ErpOaContactOrder) obj;
			SysUser applyUser=this.userBiz.readSysUser(contact.getApplyUserFlow());
			if(!targetFlowList.contains(applyUser.getUserFlow())){
				  targetList.add(applyUser);
				  targetFlowList.add(applyUser.getUserFlow());
			}
			//组织信息内容
			msgContent+="<br>客户名称："+contact.getCustomerName();
			msgContent+="<br>产品/项目："+contact.getProductTypeName();
			if(StringUtil.isNotBlank(contact.getRemark())){
				msgContent+="<br>"+"备注："+contact.getRemark()+"<br>";
			}else{
				msgContent+="<br>"+"备注：空"+"<br>";
			}
			//查询曾经参与过审核的人的信息
			List<ContactOrderAuditForm> auditFormList=searchContactOrderAuditForm(contact.getContactFlow());
			if(auditFormList!=null && !auditFormList.isEmpty()){
				for(ContactOrderAuditForm form:auditFormList){
					if(!targetFlowList.contains(form.getUserFlow())){
						targetFlowList.add(form.getUserFlow());
						targetList.add(this.userBiz.readSysUser(form.getUserFlow()));
					}
				}
				msgContent+="审核意见："+auditFormList.get(auditFormList.size()-1).getAuditContent()+"<br>"
				           +"审核人："+auditFormList.get(auditFormList.size()-1).getUserName()+"<br>";
			}
			//查询实施部门处理意见
			ContactOrderDisposeForm disposeForm=searchDisposeForm(contact.getContactFlow());
			if(disposeForm!=null && StringUtil.isNotBlank(disposeForm.getResult())){
				msgContent+="实施部门处理意见：";
				msgContent+=disposeForm.getResult()+"<br>";
			}
			//查询客户回访意见
			List<ContactVisitForm> visitFormList=searchVisitForm(contact.getContactFlow());
			
			if(visitFormList!=null && !visitFormList.isEmpty()){
				ContactVisitForm visitForm=visitFormList.get(visitFormList.size()-1);
				msgContent+="客户回访结果：";
				if(GlobalConstant.FLAG_Y.equals(visitForm.getIsSolved())){
					msgContent+="已解决问题。"+"<br>";
				}else{
					msgContent+="未解决问题。"+"<br>";
				}
				msgContent+="客户回访意见："+visitForm.getVisitContent()+"<br>";
				msgContent+="客户联系人："+visitForm.getCustomerLinkMan()+"\t"+"回访时间："+visitForm.getVisitDate()+"\t"+"回访人："+visitForm.getVisitor();
			}
			
		}else if(obj instanceof ErpOaWorkOrder){
			//组织信息内容
			work=(ErpOaWorkOrder) obj;
			SysUser sysUser=this.userBiz.readSysUser(work.getAssignUserFlow());
			if(sysUser!=null && !targetFlowList.contains(sysUser.getUserFlow())){
				  targetList.add(sysUser);
				  targetFlowList.add(sysUser.getUserFlow());
			}
			WorkOrderForm workOrderForm=this.workOrderBiz.parseWorkOrderFromXML(work);
		}
		//发送消息
		if(targetList!=null && !targetList.isEmpty()){
			for(SysUser user:targetList){
			  if(!GlobalContext.getCurrentUser().getUserFlow().equals(user.getUserFlow())){
				    thisMsgTitle="";
					thisMsgContent="";
					thisMsgTitle=user.getUserName()+"你好，"+msgTitle;
					thisMsgContent=thisMsgTitle+msgContent;
				    msgBiz.addEmailMsg(user.getUserEmail(), thisMsgTitle, thisMsgContent);
				    if(WeixinStatusEnum.Status1.getId().equals(user.getWeiXinStatusId())){
				    	//处理html标签
				    	thisMsgContent=transformHtmlBr(thisMsgContent);
						msgBiz.addWeixinMsg(user.getUserFlow(), thisMsgTitle, thisMsgContent);
					} 
			  }
		}
	   }
		return GlobalConstant.OPERATE_SUCCESSED;
}
   
	public String transformHtmlBr(String htmlStr){
		String thisMsgContent="";
		String [] htmlStrArray=htmlStr.split("<br>");
		if(htmlStrArray!=null && htmlStrArray.length>0){
			for(String str:htmlStrArray){
				thisMsgContent+=str+"\n";
			}
		}
		return thisMsgContent;
	}

	@Override
	public String closeContactOrder(ErpOaContactOrder contactOrder) throws Exception {
		if(contactOrder!=null){
			saveContactOrder(contactOrder);
			List<Map<String,String>> menuMapList=new ArrayList<Map<String,String>>();
			Map<String,String> saleMenuMap=new HashMap<String, String>();
			saleMenuMap.put("menuId", "erp-xsgl-crmxsgzl-lxdhf");
			menuMapList.add(saleMenuMap);
			String msgTitle="工作联系单（单号："+contactOrder.getContactNo()+"）实施完成等待回访！";
			contactAndWorkInformationTemplate(contactOrder, menuMapList, msgTitle);
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}

	@Override
	public String saveTrackResult(ErpOaContactOrder contact)
			throws DocumentException, Exception {
		if(contact!=null){
			saveContactOrder(contact);
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
}
