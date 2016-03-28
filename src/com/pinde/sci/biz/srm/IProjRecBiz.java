package com.pinde.sci.biz.srm;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.PubProjRecExample;
import com.pinde.sci.model.mo.SysUser;

public interface IProjRecBiz {

//	/**
//	 * ����
//	 * @param projProcessRec
//	 */
//	public void addProjRec(PubProjRec projRec);
	
//	/**
//	 * ��������ط���
//	 * @param projProcessRec
//	 * @param user
//	 */
//	public void saveProjRec(PubProjRec projRec , SysUser user);
	
//	/**
//	 * �޸�(������ˮ�������޸�)
//	 * @param projProcessRec
//	 */
//	public void updateProjRec(PubProjRec projRec);
	
//	/**
//	 * �޸ĵ�����
//	 * @param projProcessRec
//	 */
//	public void updateProjRec(PubProjRec projRec , SysUser user);
	
	/**
	 * ������������ �������ֶ�
	 * @param flow
	 * @return
	 */
	public PubProjRec readProjRec(String flow);
	
//	/**
//	 * ������������ ���������ֶ�
//	 * @param flow
//	 * @return
//	 */
//	public PubProjRec selectProjRecNoContentByFlow(String flow);
	
	/**
	 * ����
	 * @param projProcessRec
	 */
	public void addProjRec(PubProjRec projRec);
	
//	/**
//	 * ��������ط���
//	 * @param projProcessRec 
//	 * @param user
//	 */
//	public void addProjRec(PubProjRec projRec , SysUser user);

	public List<PubProjRec> searchProjRec(PubProjRecExample example);
	
	public List<PubProjRec> searchProjRecNotInApply(PubProjRec projRec);
	
	public List<PubProjRec> searchProjRec(PubProjRec projRec);
	
	public void modProjRec(PubProjRec applyRec);

//	public void addPubProjRec(String recTypeId,PubProj pubProj);

	public void delProjRec(PubProjRec rec);

//	public void submitRecAudit(String recTypeId,PubProjRec rec);

	public void changeRecStatusForAudit(String recTypeId, PubProj proj,
			PubProjRec rec, String projListScope,
			String isNotAgree,String auditContent);
	
	/**
	 * ����projFlow��recType ��ѯ ����Ψһһ����¼������ ���������ֶ�  �������ڼ��� �ȶ���rec�����
	 */
	public PubProjRec selectProjRecByProjFlowAndRecType(String projFlow , String recTypeId);
	
	/**
	 * ����projFlow��recType ��ѯ rec������
	 */
	public Integer selectRecCountByProjFlowAndRecType(String projFlow , String recTypeId);
	
	/**
	 * ����projFlow��recType ��ѯ ����Ψһһ����¼ �������ֶ� �������ڽ�չ���� �� �������ȶ���rec���
	 * @param projFlow
	 * @param recTypeId
	 * @return
	 */
	public PubProjRec selectProjRecWithContentByProjFlowAndRecType(String projFlow , String recTypeId);
	
	/**
	 * ����recContent
	 * @param applyRec
	 */
	public void modProjRecWithXml(PubProjRec applyRec);
    
	/**
	 * �����Ƿ������ֹ����������������Ƿ����
	 * @param projFlow
	 * @param recTypeId
	 * @return
	 */
	public List<PubProjRec> searchCompleteAndTerminate(String projFlow,String recTypeId);
	
	public List<PubProjRec> selectProjRecByProjFlowAndRecList(String projFlow , List<String> recTypeList);

	PubProjRec selectProjRecNoContentByFlow(String flow);	
}
