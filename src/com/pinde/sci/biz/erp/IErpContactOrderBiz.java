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
	 * �ѹ�����ϵ����������ת��Ϊxml
	 * @param from
	 * @return
	 * @throws Exception 
	 */
	public String contactOrderToXml(ContactOrderForm form) throws Exception;
	/**
	 * ������ˮ�Ų�ѯ������ϵ����ϸ��Ϣ
	 * @param contactFlow
	 * @return
	 */
	public ErpOaContactOrder readContactOrder(String contactFlow);
	/**
	 * ���湤����ϵ��
	 * @param contactOrder
	 * @return
	 */
	public String saveContactOrder(ErpOaContactOrder contactOrder);
	/**
	 * ��ѯ���������Ĺ�����ϵ��
	 * @param contactOrder
	 * @param timeForm
	 * @return
	 */
	public List<ErpOaContactOrder> searchContactOrderList(ErpOaContactOrder contactOrder,ContactOrderTimeForm timeForm);
	/**
	 * ��xmlת����contactForm
	 * @param contactForm
	 * @return
	 * @throws DocumentException 
	 */
	public ContactOrderForm xmlToContactOrder(String contactContent) throws DocumentException;
	/**
	 * ͨ����չ��ѯ������ϵ���б�
	 * @param paramMap
	 * @return
	 */
	public List<ErpOaContactOrder> searchContactOrderList(Map<String,Object> paramMap);
	/**
	 * ɾ��������ϵ��
	 * @param contactFlow
	 * @return
	 */
    public String deleteContactOrder(String contactFlow);
    /**
     * ��ѯ������ϵ���������Ϣ
     * @param contactFlow
     * @return
     * @throws DocumentException 
     */
    public List<ContactOrderAuditForm> searchContactOrderAuditForm(String contactFlow) throws DocumentException;
    /**
     * ������ϵ�������Ϣת��xml
     * @param form
     * @param contactFlow
     * @return
     * @throws DocumentException 
     */
    public String contactOrderAuditToXml(ContactOrderAuditForm form,String contactFlow) throws DocumentException;
    /**
     * ������ϵ��������������Ϣת��xml
     * @param form
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public String contactOrderDisposeToXml(ContactOrderDisposeForm form,String contactFlow) throws DocumentException;
    /**
     * ��ѯ������ϵ��������������Ϣ
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public ContactOrderDisposeForm searchDisposeForm(String contactFlow) throws DocumentException;
    /**
     * ��ѯ��ϵ���ط���Ϣ
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public List<ContactVisitForm> searchVisitForm(String contactFlow) throws DocumentException;
    /**
     * ����ϵ���ط���Ϣת��Ϊxml
     * @param visitForm
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public String contactVisitFormToXml(ContactVisitForm visitForm,String contactFlow) throws DocumentException; 
    /**
     * �ر���ϵ���������е��ɹ���
     * @param contactOrder
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String closeContactAndWorkOrder(String contactFlow) throws DocumentException, Exception;
    /**
     * ��ϵ�������ύ��������Ϣ����
     * @param contactOrder
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String submitContactOrderApply(ErpOaContactOrder contactOrder) throws DocumentException, Exception;
    /**
     * ������ϵ������������
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
     * ������ϵ���طý��
     * @param contact
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String saveVisitResult(ErpOaContactOrder contact) throws DocumentException, Exception;
    /**
     * ����ϵ��״̬������ʵʩ��
     * @param contact
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String recallContact(ErpOaContactOrder contact) throws DocumentException, Exception;
    
    public String saveContactReassign(ErpOaContactOrder contact,String receiveFlag) throws DocumentException, Exception;
   
    /**
     * ������Ϣ����
     * @param obj
     * @return
     * @throws DocumentException 
     * @throws Exception 
     */
    public String contactAndWorkInformationTemplate(Object obj,List<Map<String,String>> menuMapList,String msgTitle) throws DocumentException, Exception;
    /**
     * �ر���ϵ��
     * @param contactFlow
     * @return
     * @throws Exception 
     */
    public String closeContactOrder(ErpOaContactOrder contactOrder) throws Exception;
    /**
     * ��ѯ��ϵ�����ټ�¼
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public List<ContactOrderTrackForm> searchTrackForm(String contactFlow) throws DocumentException;
    /**
     * ����ϵ�����ټ�¼ת��Ϊxml
     * @param visitForm
     * @param contactFlow
     * @return
     * @throws DocumentException
     */
    public String contactTrackFormToXml(ContactOrderTrackForm trackForm,String contactFlow) throws DocumentException; 
    /**
     * ������ϵ�����ټ�¼
     * @param contact
     * @return
     * @throws DocumentException
     * @throws Exception
     */
    public String saveTrackResult(ErpOaContactOrder contact) throws DocumentException, Exception;
	/**
	 * ��ѯ�ÿͻ�����ʷ��ϵ��
	 * @param contactOrder
	 * @param timeForm
	 * @return
	 */
    public List<ErpOaContactOrder> searchHistoryContactOrderList(
			ErpOaContactOrder contactOrder, ContactOrderTimeForm timeForm);
}
