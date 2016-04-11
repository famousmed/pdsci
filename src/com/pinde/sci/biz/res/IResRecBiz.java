package com.pinde.sci.biz.res;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Element;

import com.pinde.sci.form.hbres.ResRecForm;
import com.pinde.sci.model.mo.ResAppeal;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResRec;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorSchProcessExt;
import com.pinde.sci.model.res.ResRecExt;

/**
 * @author tiger
 *
 */
public interface IResRecBiz {
	/**
	 * ������������
	 * @param recFlow
	 * @return
	 */
	ResRec readResRec(String recFlow);
	/**
	 * �������޸�
	 * @param rec
	 * @return
	 */
	int edit(ResRec rec);
	List<ResRec> searchByRec(String recTypeId, String schDeptFlow,
			String operUserFlow);
	Map<String, Object> parseGradeXml(String recContent);
	/**
	 * ��ѯ�����δ��˵ı���Ŀ
	 * @param userFlow ��ǰ��¼�û�
	 * @param roleFlag teacher: ������ʦ,head��������
	 * @return Map key:���id,value:��Ŀ
	 */
	Map<String,BigDecimal> searchAuditCount(String userFlow,String roleFlag);
	/**
	 * @param recFlow
	 * @param recTypeId
	 * @param roleFlag
	 * @param processFlow
	 * @param form
	 * @return
	 */
	int saveRecContentForm(String recFlow,String recTypeId,String roleFlag, String processFlow, Object form);
	List<ResRec> searchByRec(List<String> recTypeIds, String schDeptFlow,
			String operUserFlow);
	int editAppeal(ResAppeal appeal);
	List<ResAppeal> searchAppeal(String recTypeId, String schDeptFlow,
			String operUserFlow);
	List<ResAppeal> searchAppeal(ResAppeal appeal);
	List<ResAppeal> searchAppeal(ResAppeal appeal, String starTime,
			String endTime);
	ResAppeal readAppeal(String appealFlow);
	List<ResRec> searchByRec(String recTypeId, List<String> schDeptFlows,
			String operUserFlow);
	List<ResAppeal> searchAppeal(List<String> schDeptFlows, ResAppeal appeal);
	List<ResRecExt> searchRegistryList(String userFlow, String roleFlag,
			ResRec rec,ResDoctorSchProcess process);
	List<ResRec> searchResRec(List<String> schDeptFlows, ResRec rec);
	List<ResRecExt> searchScoreList(String userFlow, String roleFlag,
			String sessionNumber, String recTypeId, String isCurrentFlag);
	List<ResRecExt> searchTeacherAudit(String schDeptFlow,
			String isCurrentFlag, String userFlow);
	Map<String, String> parseRecContent(String content);
	List<ResRecExt> searchAuditList(String userFlow, String roleFlag,
			String recTypeId, String doctorFlow, String isCurrentFlag);
	List<ResRec> searchByRecWithBLOBs(String recTypeId, String schDeptFlow,
			String operUserFlow);
	Map<String,List<Map<String, String>>> parseRecContentAppraise(String content);
	List<ResRec> searchFinishRec(List<String> recTypeIds, String operUserFlow);
	Map<String, String> getFinishPer(List<SchArrangeResult> arrResultList);
	String getRecContent(String formName, List<Element> list,
			HttpServletRequest req);
	int editAndOut(ResRec rec, ResDoctorSchProcess process);
	List<ResRec> searchByRecWithBLOBs(List<String> recTypeIds,
			String schDeptFlow, String operUserFlow);
	List<ResDoctorSchProcessExt> searchProcessExt(
			ResDoctorSchProcessExt processExt);
	List<ResRec> searchRecByUserAndSchdept(List<String> userFlows,
			List<String> schDeptFlows, String recTypeId, String itemName);
	List<ResRec> searchByRecWithBLOBs(String recTypeId, String schDeptFlow,
			String operUserFlow, String itemName);
	List<ResRecExt> searchRecExtByRecExt(ResRecExt recExt);
	List<Map<String,Object>> countProcessByUser(List<String> userFlows);
	Map<String, String> getFinishPer(List<SchArrangeResult> arrResultList,
			String doctorFlow);
	String getFormPath(String recTypeId, String currVer, String category);
	List<Map<String, Object>> countRecWithDoc(List<String> userFlows,
			List<String> schDeptFlows);
	List<Map<String, Object>> appealCountWithUser(List<String> userFlows,
			List<String> schDeptFlows);
	List<Map<String, Object>> countRecWithDoc(List<String> userFlows,
			List<String> schDeptFlows, String isAudit);
	List<ResRec> searchByRecForAudit(String recTypeId, String schDeptFlow,
			String operUserFlow);
	List<Map<String, Object>> appealCountWithUser(List<String> userFlows,
			List<String> schDeptFlows, String roleFlag);
	List<ResAppeal> searchAppealForAudit(String recTypeId, String schDeptFlow,
			String doctorFlow);
	
	/**
	 * �����ѧ�
	 * @param resRecForm
	 * @return
	 * @throws Exception 
	 */
	int saveResRecContent(ResRecForm resRecForm) throws Exception;
	
	/**
	 * ��ѯ
	 * @param resRec
	 * @return
	 * @throws Exception 
	 */
	List<ResRecForm> searchResRecFormList(ResRec resRec) throws Exception;
	
	ResRecForm getRecContentByRecFlow(String recFlow) throws Exception;
	
	List<Map<String, Object>> searchAppealCount(String schDeptFlow,
			String operUserFlow);
	int oneKeyAudit(String recTypeId, String schDeptFlow, String operUserFlow);
	List<Map<String, String>> parseViewValue(String recContent);
	List<Map<String, Object>> searchTeacherAuditCount(String headUserFlow,
			String isAudit);
	List<ResRec> searchByUserFlows(String recTypeId, String schDeptFlow,
			List<String> operUserFlows);
	List<Map<String, Object>> searchDoctorNotAuditCount(String schDeptFlow,
			 String teacherUserFlow, String isAudit,List<String> recTypeIds);
	List<Map<String, Object>> searchNotAuditAppealCount(String schDeptFlow,
			String teacherUserFlow, String isAudit);
	List<ResRec> searchByUserFlowsWithBLOBs(String recTypeId,
			String schDeptFlow, List<String> operUserFlows);
	Map<String, Object> parseContent(String content);
	ResRec searchRecWithBLOBs(String recTypeId, String operUserFlow);
	
	/**
	 * �������ͺͲ����˲��Ұ������ֶ����ݵļ�¼
	 * @param recTypeId
	 * @param operUserFlow
	 * @return
	 */
	List<ResRec> searchByRecWithBLOBs(String recTypeId, String operUserFlow);
	
	List<ResRec> searchByRecWithBLOBs(ResRec resRec, String trainYear);
	
	/**
	 * ͨ�� ��ѧ���� �Ĵ��ֶκ�itemGroup��flow��ȡitemGroup����
	 * @param content
	 * @return
	 */
	Map<String, Object> parseTeachPlanContent(String content,String recordFlow);
	
	/**
	 * �༭��ǰ��ѵ��
	 * @param recFlow
	 * @param roleFlag
	 * @param req
	 * @return
	 */
	int editPreTrainForm(String recFlow, String resultFlow, String roleFlag,HttpServletRequest req);
	
	/**
	 * ��ȡ��ǰ��ѵ������
	 * @param recContent
	 * @return
	 */
	Map<String, Map<String, String>> getPreTrainFormDataMap(String recContent);
	
	/**
	 * ���������ѵ��¼
	 * @param recFlow
	 * @param roleFlag
	 * @param req
	 * @return
	 */
	int editAnnualTrainForm(String recFlow, String roleFlag,
			HttpServletRequest req);
	
	/**
	 * ��ȡ�����ѵ��map
	 * @param recContent
	 * @return
	 */
	Map<String, Object> getAnnualTrainFormDataMap(String recContent);
	
	/**
	 * ��ȡ�û��ǵĵ�һ���ͼ�¼
	 * @param userFlows
	 * @param recTypeId
	 * @return
	 */
	List<ResRec> searchRecByUserFlows(List<String> userFlows, String recTypeId);
	int editSpeAbilityAccess(String recFlow, String resultFlow,
			String roleFlag, HttpServletRequest req);
	Map<String, Map<String, String>> getSpeAbilityAssessDataMap(
			String recContent);
	List<ResRec> searchByUserFlowAndTypeId(String operUserFlow,String recTypeId);
	int editRec(ResRec rec);
	
	/**
	 * ���ݱ����ͺ���ת���һ�ȡrec��¼
	 * @param recTypeId
	 * @param schDeptFlows
	 * @return
	 */
	List<ResRec> searchByDeptWithBLOBs(String recTypeId,
			List<String> schDeptFlows);
	
	/**
	 * ��ѯ��ǰ���̻�����εĴ�������Ա����
	 * @param process
	 * @param user
	 * @param recTypeIds
	 * @return
	 */
	List<ResRec> searchAfterAuditRec(ResDoctorSchProcess process, SysUser user,
			List<String> recTypeIds,Map<String,String> roleFlagMap);
	
	/**
	 * ����rec��ˮ���ϻ�ȡ�����ֶ�rec
	 * @param recFlows
	 * @return
	 */
	List<ResRec> searchByRecWithBLOBs(List<String> recFlows);
	
	/**
	 * ����rec��ˮ�������rec
	 * @param recFlows
	 * @return
	 */
	int auditRecs(String[] recFlows, ResRec rec);
	List<ResRec> searchByUserFlows(String recTypeId, List<String> operUserFlows);
	List<ResRec> searchByUserFlowsWithBLOBs(String recTypeId,
			List<String> operUserFlows);
	
	/**
	 * �����
	 * @param formFileName
	 * @param recFlow
	 * @param schDeptFlow
	 * @param rotationFlow
	 * @param req
	 * @param orgFlow
	 * @return
	 */
	int saveRegistryForm(String formFileName, String recFlow,
			String schDeptFlow, String rotationFlow, HttpServletRequest req,
			String orgFlow);
	
	/**
	 * ���ݹ��̼�¼�����ͻ�ȡ�Ǽ�����
	 * @param processFlow
	 * @param recTypeId
	 * @return
	 */
	List<ResRec> searchRecByProcessWithBLOBs(String processFlow,
			String recTypeId);
}
