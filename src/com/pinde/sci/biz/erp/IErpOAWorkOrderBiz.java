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
	 * 保存
	 * @param workOrder
	 * @return
	 */
	int save(ErpOaWorkOrder workOrder);

	/**
	 * 保存联系单派工
	 * @param workOrderForm
	 * @return
	 * @throws Exception 
	 */
	String saveWorkOrderForm(WorkOrderForm workOrderForm) throws Exception;
	
	/**
	 * 获取一条记录
	 * @param workFlow
	 * @return
	 */
	ErpOaWorkOrder readWorkOrder(String workFlow);

	/**
	 * 查询联系单派工
	 * @param workOrder
	 * @return
	 */
	List<ErpOaWorkOrder> searchWorkOrderList(ErpOaWorkOrder workOrder);
	
	/**
	 * 查询我的派工单
	 * @param paramMap
	 * @return
	 */
	List<ErpOaWorkOrderExt> searchWorkOrderList(Map<String, Object> paramMap);
	

	/**
	 * 查询派工单审核列表
	 * @param paramMap
	 * @return
	 */
	List<ErpOaWorkOrderExt> applyWorkOrderList(Map<String, Object> paramMap);

	/**
	 * 完成工作任务
	 * @param workForm
	 * @return
	 * @throws Exception 
	 */
	int completeWorkOrder(WorkOrderForm workOrderForm) throws Exception;

	/**
	 * 完成工作任务审核
	 * @param workForm
	 * @return
	 * @throws Exception 
	 */
	int implementedAudit(WorkOrderForm workOrderForm) throws Exception;

	/**
	 * 部门经理审核
	 * @param workForm
	 * @return
	 * @throws Exception 
	 */
	int managerAudit(WorkOrderForm workOrderForm,String flag) throws Exception;

	/**
	 * 保存客户回访
	 * @param workForm
	 * @return
	 * @throws Exception 
	 */
	int saveVisit(WorkOrderForm workOrderForm) throws Exception;

	/**
	 * 派工
	 * @param workOrder
	 * @param contactFlow
	 * @return
	 * @throws DocumentException 
	 * @throws Exception 
	 */
	int implementing(ErpOaWorkOrder workOrder) throws DocumentException, Exception;
	
	int countWorkOrder(ErpOaWorkOrder workOrder);
	
	/**
	 * 解析XML
	 * @param workOrder
	 * @return
	 * @throws Exception 
	 */
	WorkOrderForm parseWorkOrderFromXML(ErpOaWorkOrder workOrder) throws Exception;
   /**
    * 把派工单完成时间同步到联系单完成时间
    * @param workFlow
    * @return
    * @throws Exception
    */
	public int changeContactCompleteTime(ErpOaWorkOrder workOrder) throws Exception;
	/**
	 * 更改联系单状态至实施完成
	 * @param contactFlow
	 * @return
	 * @throws Exception
	 */
	public String changeContactStatus(String contactFlow) throws Exception;
	/**
	 * 非本部门处理派工单改派送本部门审核审核
	 * @param workOrder
	 * @return
	 * @throws DocumentException 
	 * @throws Exception 
	 */
	public String workOrderApplyAudit(ErpOaWorkOrder workOrder) throws DocumentException, Exception;
	/**
	 * 删除派工单
	 * @param workOrder
	 * @return
	 */
	public String deleteWorkOrder(ErpOaWorkOrder workOrder);
	/**
	 * 非本部门处理派工单改派送目标部门审核
	 * @param workOrder
	 * @return
	 * @throws DocumentException 
	 * @throws Exception 
	 */
	public String workOrderApplyTargetAudit(ErpOaWorkOrder workOrder) throws DocumentException, Exception;
	/**
	 * 派工单改派目标部门审核不通过
	 * @param workOrder
	 * @return
	 * @throws DocumentException
	 * @throws Exception 
	 */
	public String workOrderApplyTargetUnPassed(ErpOaWorkOrder workOrder) throws DocumentException, Exception;
	/**
	 * 把派工单审核意见转化为xml
	 * @param form
	 * @param workOrder
	 * @return
	 * @throws DocumentException 
	 */
	public String workOrderAuditFormToXml(WorkOrderAuditForm form,ErpOaWorkOrder workOrder) throws DocumentException;
	/**
	 * 把派工单xml审核意见节点转化为WorkOrderAuditFormList
	 * @param workOrder
	 * @return
	 * @throws DocumentException 
	 */
	public List<WorkOrderAuditForm> xmlToWorkOrderAuditFormList(ErpOaWorkOrder workOrder) throws DocumentException;
}
