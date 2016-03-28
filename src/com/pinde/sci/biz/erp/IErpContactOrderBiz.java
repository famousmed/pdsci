package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;

import org.dom4j.DocumentException;

import com.pinde.sci.form.erp.ContactOrderAuditForm;
import com.pinde.sci.form.erp.ContactOrderDisposeForm;
import com.pinde.sci.form.erp.ContactOrderForm;
import com.pinde.sci.form.erp.ContactOrderTimeForm;
import com.pinde.sci.form.erp.ContactOrderTrackForm;
import com.pinde.sci.form.erp.ContactVisitForm;
import com.pinde.sci.model.erp.ErpOaContactOrderExt;
import com.pinde.sci.model.mo.ErpOaContactOrder;
import com.pinde.sci.model.mo.PubMsg;
import com.pinde.sci.model.mo.SysUser;

public interface IErpContactOrderBiz {
    
	/**
	 * 把工作联系单部分内容转化为xml
	 * @param from
	 * @return
	 * @throws Exception 
	 */
	public String contactOrderToXml(ContactOrderForm form) throws Exception;
	/**
	 * 根据流水号查询工作联系单详细信息
	 * @param contactFlow
	 * @return
	 */
	public ErpOaContactOrder readContactOrder(String contactFlow);
	/**
	 * 保存工作联系单
	 * @param contactOrder
	 * @return
	 */
	public String saveContactOrder(ErpOaContactOrder contactOrder);
	/**
	 * 查询符合条件的工作联系单
	 * @param contactOrder
	 * @param timeForm
	 * @return
	 */
	public List<ErpOaContactOrder> searchContactOrderList(ErpOaContactOrder contactOrder,ContactOrderTimeForm timeForm);
	/**
	 * 把xml转化成contactForm
	 * @param contactForm
	 * @return
	 * @throws DocumentException 
	 */
	public ContactOrderForm xmlToContactOrder(String contactContent) throws DocumentException;
	/**
	 * 通过扩展查询工作联系单列表
	 * @param paramMap
	 * @return
	 */
	public List<ErpOaContactOrder> searchContactOrderList(Map<String,Object> paramMap);
	/**
	 * 删除工作联系单
	 * @param contactFlow
	 * @return
	 */
    public String deleteContactOrder(String contactFlow);
    /**
     * 查询工作联系单的审核信息
     * @param contactFlow
     * @return
     * @throws DocumentException 
     */
    public List<ContactOrderAuditForm> searchContactOrderAuditForm(String contactFlow) throws DocumentException;
    /**
     * 工作联系单审核信息转化xml
     * @param form
     * @param contactFlow
     * @return
     * @throws DocumentException 
     */
    public String contactOrderAuditToXml(ContactOrderAuditForm form,String contactFlow) throws DocumentException;
    /**
     * 工作联系单技服部处理信息转化xml
     * @param form
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public String contactOrderDisposeToXml(ContactOrderDisposeForm form,String contactFlow) throws DocumentException;
    /**
     * 查询工作联系单技服部处理信息
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public ContactOrderDisposeForm searchDisposeForm(String contactFlow) throws DocumentException;
    /**
     * 查询联系单回访信息
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public List<ContactVisitForm> searchVisitForm(String contactFlow) throws DocumentException;
    /**
     * 把联系单回访信息转化为xml
     * @param visitForm
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public String contactVisitFormToXml(ContactVisitForm visitForm,String contactFlow) throws DocumentException; 
    /**
     * 关闭联系单及其所有的派工单
     * @param contactOrder
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String closeContactAndWorkOrder(String contactFlow) throws DocumentException, Exception;
    /**
     * 联系单申请提交并发送消息提醒
     * @param contactOrder
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String submitContactOrderApply(ErpOaContactOrder contactOrder) throws DocumentException, Exception;
    /**
     * 保存联系单申请审核意见
     * @param oaContactOrder
     * @param form
     * @param status
     * @param scope
     * @return
     * @throws DocumentException
     * @throws Exception 
     */
    public String saveContactApplyAudit(ErpOaContactOrder oaContactOrder,ContactOrderAuditForm form,String status,String scope) throws DocumentException, Exception;
    /**
     * 保存联系单回访结果
     * @param contact
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String saveVisitResult(ErpOaContactOrder contact) throws DocumentException, Exception;
    /**
     * 把联系单状态撤回至实施中
     * @param contact
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String recallContact(ErpOaContactOrder contact) throws DocumentException, Exception;
    
    public String saveContactReassign(ErpOaContactOrder contact,String receiveFlag) throws DocumentException, Exception;
   
    /**
     * 生成消息内容
     * @param obj
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String contactAndWorkInformationTemplate(Object obj,List<Map<String,String>> menuMapList,String msgTitle) throws DocumentException, Exception;
    /**
     * 关闭联系单
     * @param contactFlow
     * @return
     * @throws Exception 
     */
    public String closeContactOrder(ErpOaContactOrder contactOrder) throws Exception;
    /**
     * 查询联系单跟踪记录
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public List<ContactOrderTrackForm> searchTrackForm(String contactFlow) throws DocumentException;
    /**
     * 把联系单跟踪记录转化为xml
     * @param visitForm
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public String contactTrackFormToXml(ContactOrderTrackForm trackForm,String contactFlow) throws DocumentException; 
    /**
     * 保存联系单跟踪记录
     * @param contact
     * @return
     * @throws DocumentException
     * @throws Exception
     */
    public String saveTrackResult(ErpOaContactOrder contact) throws DocumentException, Exception;
	/**
	 * 查询该客户的历史联系单
	 * @param contactOrder
	 * @param timeForm
	 * @return
	 */
    public List<ErpOaContactOrder> searchHistoryContactOrderList(
			ErpOaContactOrder contactOrder, ContactOrderTimeForm timeForm);
}
