package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.mo.SrmExpertProjExample;
import com.pinde.sci.model.srm.SrmExpertProjExt;
import com.pinde.sci.model.srm.SysUserExt;

public interface IExpertProjBiz {

	/**
	 * ����ר���������Ŀ
	 * @param expertProj
	 */
	void save(SrmExpertProj expertProj);

	/**
	 * ������Ŀ��ˮ�ź� �û���ˮ�Ų�ѯר���������Ŀ
	 * @param projFlow
	 * @param userFlow
	 * @return
	 */
	SrmExpertProj read(String projFlow, String userFlow);

	/**
	 * ���������޸� �������ֶ�
	 * @param expertProj
	 */
	void modifyByFlow(SrmExpertProj expertProj);

	/**
	 * ������Ŀ���� ����
	 * @param expertProj
	 */
	void saveForHide(SrmExpertProj expertProj);
 
	List<SrmExpertProj> searchExample(SrmExpertProjExample expertProj);

	/**
	 * ����������ѯ
	 * @param recordFlow
	 * @return
	 */
	SrmExpertProj read(String recordFlow);

	/**
	 * ��������������ˮ�� ��ѯ�ô����������е�ר���������Ŀ
	 * @param evaluationFlow
	 * @return
	 */
	List<SrmExpertProj> searchExperProjByEvaluationFlow(String evaluationFlow);

	/**
	 * ���������õ�ʱ���ĳ����Ŀ��������ר��
	 * @param groupProj
	 * @param userFlow
	 */
	void saveExpertProj(SrmExpertProjEval groupProj, List<String> userFlowList);

	/**
	 * ���������޸� ���������ֶ�
	 * @param expertProj
	 */
	void modifyWithOutBlobsByFlow(SrmExpertProj expertProj);   
	
	/**
	 * �������������޸� �������ֶ�
	 * @param expertProj
	 */
	void modifyWithBlob(SrmExpertProj expertProj);
	
	/**
	 * �������������޸� ���������ֶ�
	 * @param expertProj
	 */
	void modify(SrmExpertProj expertProj);
	
	/**
	 * ��ѯĳ��ר�ҵ�������Ŀ
	 * @param srmExpertProjExt
	 * @return
	 */
	List<SrmExpertProjExt> searchExpertProj(SrmExpertProjExt srmExpertProjExt);
	
	/**
	 * ��ѯ�μ�ĳ����Ŀ���������ר��
	 * @param expertProj
	 * @return
	 */
	List<SysUserExt>  searchJoinEvalSetExpertList(SrmExpertProj expertProj);
	
	/**
	 * �����û��� ��ѯר���������Ϣ �����û���Ϣ
	 * @param expertProj
	 * @return
	 */
	List<SrmExpertProjExt> searchExpertProjExtAndUserExt(SrmExpertProj expertProj);
	
	/**
	 * �ж�ĳ����Ŀ�Ƿ���ר�Ҵ����
	 * @param projFlow
	 * @return true ��ר�Ҹ�����Ŀ����� ���ұ�����ύ��  false ��û��ר�Ҹ�����Ŀ�����
	 */
	public boolean searchExpertIsSetScoreByProjFlow(String projFlow);
	
	/**
	 * ��ר�ҷ��Ͷ���֪ͨ
	 */
	public void sendPhoneNotice(String evalSetFlow , String userFlow);
	
	/**
	 * ��ר�ҷ����ʼ�֪ͨ
	 */
	public void sendEmailNotice(String evalSetFlow , String userFlow);
 
} 
 