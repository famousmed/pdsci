package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;

import org.dom4j.DocumentException;

import com.pinde.sci.form.erp.WorkOrderAuditForm;
import com.pinde.sci.form.erp.WorkOrderForm;
import com.pinde.sci.model.erp.ErpOaWorkOrderExt;
import com.pinde.sci.model.mo.ErpOaWorkOrder;

/**
 * @author tiger
 *
 */
/**
 * @author tiger
 *
 */
/**
 * @author tiger
 *
 */
public interface IErpOAWorkOrderBiz {
	 
	/**
	 * ����
	 * @param workOrder
	 * @return
	 */
	int save(ErpOaWorkOrder workOrder);

	/**
	 * ������ϵ���ɹ�
	 * @param workOrderForm
	 * @return
	 * @throws Exception 
	 */
	String saveWorkOrderForm(WorkOrderForm workOrderForm) throws Exception;
	
	/**
	 * ��ȡһ����¼
	 * @param workFlow
	 * @return
	 */
	ErpOaWorkOrder readWorkOrder(String workFlow);

	/**
	 * ��ѯ��ϵ���ɹ�
	 * @param workOrder
	 * @return
	 */
	List<ErpOaWorkOrder> searchWorkOrderList(ErpOaWorkOrder workOrder);
	
	/**
	 * ��ѯ�ҵ��ɹ���
	 * @param paramMap
	 * @return
	 */
	List<ErpOaWorkOrderExt> searchWorkOrderList(Map<String, Object> paramMap);
	

	/**
	 * ��ѯ�ɹ�������б�
	 * @param paramMap
	 * @return
	 */
	List<ErpOaWorkOrderExt> applyWorkOrderList(Map<String, Object> paramMap);

	/**
	 * ��ɹ�������
	 * @param workForm
	 * @return
	 * @throws Exception 
	 */
	int completeWorkOrder(WorkOrderForm workOrderForm) throws Exception;

	/**
	 * ��ɹ����������
	 * @param workForm
	 * @return
	 * @throws Exception 
	 */
	int implementedAudit(WorkOrderForm workOrderForm) throws Exception;

	/**
	 * ���ž������
	 * @param workForm
	 * @return
	 * @throws Exception 
	 */
	int managerAudit(WorkOrderForm workOrderForm,String flag) throws Exception;

	/**
	 * ����ͻ��ط�
	 * @param workForm
	 * @return
	 * @throws Exception 
	 */
	int saveVisit(WorkOrderForm workOrderForm) throws Exception;

	/**
	 * �ɹ�
	 * @param workOrder
	 * @param contactFlow
	 * @return
	 * @throws DocumentException 
	 * @throws Exception 
	 */
	int implementing(ErpOaWorkOrder workOrder) throws DocumentException, Exception;
	
	int countWorkOrder(ErpOaWorkOrder workOrder);
	
	/**
	 * ����XML
	 * @param workOrder
	 * @return
	 * @throws Exception 
	 */
	WorkOrderForm parseWorkOrderFromXML(ErpOaWorkOrder workOrder) throws Exception;
   /**
    * ���ɹ������ʱ��ͬ������ϵ�����ʱ��
    * @param workFlow
    * @return
    * @throws Exception
    */
	public int changeContactCompleteTime(ErpOaWorkOrder workOrder) throws Exception;
	/**
	 * ������ϵ��״̬��ʵʩ���
	 * @param contactFlow
	 * @return
	 * @throws Exception
	 */
	public String changeContactStatus(String contactFlow) throws Exception;
	/**
	 * �Ǳ����Ŵ����ɹ��������ͱ�����������
	 * @param workOrder
	 * @return
	 * @throws DocumentException 
	 * @throws Exception 
	 */
	public String workOrderApplyAudit(ErpOaWorkOrder workOrder) throws DocumentException, Exception;
	/**
	 * ɾ���ɹ���
	 * @param workOrder
	 * @return
	 */
	public String deleteWorkOrder(ErpOaWorkOrder workOrder);
	/**
	 * �Ǳ����Ŵ����ɹ���������Ŀ�겿�����
	 * @param workOrder
	 * @return
	 * @throws DocumentException 
	 * @throws Exception 
	 */
	public String workOrderApplyTargetAudit(ErpOaWorkOrder workOrder) throws DocumentException, Exception;
	/**
	 * �ɹ�������Ŀ�겿����˲�ͨ��
	 * @param workOrder
	 * @return
	 * @throws DocumentException
	 * @throws Exception 
	 */
	public String workOrderApplyTargetUnPassed(ErpOaWorkOrder workOrder) throws DocumentException, Exception;
	/**
	 * ���ɹ���������ת��Ϊxml
	 * @param form
	 * @param workOrder
	 * @return
	 * @throws DocumentException 
	 */
	public String workOrderAuditFormToXml(WorkOrderAuditForm form,ErpOaWorkOrder workOrder) throws DocumentException;
	/**
	 * ���ɹ���xml�������ڵ�ת��ΪWorkOrderAuditFormList
	 * @param workOrder
	 * @return
	 * @throws DocumentException 
	 */
	public List<WorkOrderAuditForm> xmlToWorkOrderAuditFormList(ErpOaWorkOrder workOrder) throws DocumentException;
}
