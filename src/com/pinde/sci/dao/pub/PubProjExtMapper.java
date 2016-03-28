package com.pinde.sci.dao.pub;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.pub.PubProjCountExt;
import com.pinde.sci.model.srm.PubProjExt;
import com.pinde.sci.model.srm.ReportForm;

/**
 * proj��չmapper
 * @author Administrator
 *
 */
public interface PubProjExtMapper {

	/**
	 * ����proj����������ѯ���ܲ����µ�������Ŀ
	 * @param proj
	 * @return
	 */
	public List<PubProj> selectChargeProjList(PubProj proj , String chargeOrgFlow);
	
	public List<PubProj> selectChargeProj(Map<String, Object> paramMap);

	public List<PubProj> searchProjByProjFlows(String projFlows);
  
	public List<PubProj> searchProjByProjFlows(List<String> projFlows);

	public List<PubProj> selectLocalProj(Map<String, Object> paramMap); 
	
	public List<PubProj> selectGlobalProj(Map<String, Object> paramMap); 
	
	/**
	 * ��ѯ�걨��˵���Ŀ�б�
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectApplyAduitProjList(Map<String , Object> paramMap);
	
	/**
	 * ��ѯ��ͬ��˵���Ŀ�б�
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectContractAduitProjList(Map<String , Object> paramMap);
	
	/**
	 * ��ѯ��չ�׶���˵���Ŀ��
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectSchduleAduitProjList(Map<String , Object> paramMap);
	
	/**
	 * ��ѯ��ɽ׶���˵���Ŀ��
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectCompleteAduitProjList(Map<String , Object> paramMap);
	
	/**
	 * ��ѯ��Ŀ�б�ͨ�÷���(��ǰ�������������е���Ŀ  �� ����recҪ��ָ��rectype)
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectProjList(Map<String , Object> paramMap);
	
	/**
	 * ������˲�ѯ
	 * @param projExt
	 * @return
	 */
	public List<PubProjExt> selectEvaluationProjList(PubProjExt projExt);
	
	/**
	 * ��Ŀ��ѯͨ�÷���(��ǰ�������������е���Ŀ)
	 * @param proj
	 * @return
	 */
	public List<PubProj> selectCommonProjList(PubProj proj);
	
	/**
	 * ��ѯ�����²�����Ŀ�б�
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectProjListForFundPlan(Map<Object , Object> paramMap);
	/**
	 * ͳ�Ƴ�Ԥ����������������������
	 * @param paramMap
	 * @return
	 */
	public Integer selectCountProj(Map<String,Object> paramMap);
	/**
	 * ͳ�ƴ���˵�Ԥ��
	 * @param paramMap
	 * @return
	 */
	public Integer selectCountProjFund(Map<String,Object> paramMap);
	/**
	 * ͳ�ƴ���˵ĳɹ�
	 * @param paramMap
	 * @return
	 */
	public Integer selectCountSrmAch(Map<String,Object> paramMap);
	
	/**
	 * ����λ��ˮ�Ų�ѯ�õ�λ�²μ������������Ŀ����
	 * @return
	 */
	public List<PubProjCountExt> selectProjCountInExpert(@Param(value="orgFlow") String orgFlow);
	
	/**
	 * ����λ��ˮ�Ų�ѯ�õ�λ����׶�״̬��ص���Ŀ����
	 * @param orgFlow
	 * @return
	 */
	public List<PubProjCountExt> selectRoundStageStatus(HashMap<String,String> map);
	
	public List<PubProjCountExt> selectProjDirect(HashMap<String,String> map);
	
	public Integer selectCountProjFundDown(Map<String,Object> paramMap);
	
	public List<PubProj> selectList(PubProjExt projExt);
	
	public List<PubProj> selectTerminateProj(Map<String,String> terminateId);
	
	/**
	 * �����ѯ
	 * @param proj
	 * @return
	 */
	public List<ReportForm> selectReportFormData(Map<String,Object> paramMap);
	
	/**
	 * ��������������� ��ѯָ�������µ� ���л���ӵ�е���Ŀ����
	 * @param paramMap
	 * @return
	 */
	public List<Map<String , String>> selectOrgHavingProjCount(Map<String , Object> paramMap);

	/**
	 * ��ѯ���걨��λ���ͨ����Ŀ
	 * @param paramMap
	 * @return
	 */
	public int searchAuditCount(Map<String, Object> paramMap);
	
} 
