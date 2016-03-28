package com.pinde.sci.biz.srm;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.srm.SrmExpertGroupProjExt;

public interface IExpertGroupProjBiz {
	/**
	 * ������Ŀ�ţ�����id(1����������   2����������)
	 * @param groupFlow
	 * @return
	 */
	public SrmExpertProjEval searchSrmExpertGroupProjByProjFlowAndEvaluationId(String projFlow , String evaluationId);
	
	/**
	 * ��������������ˮ��(����)��ѯ �������ö���
	 * @param recordFlow
	 * @return
	 */
	public SrmExpertProjEval searchSrmExpertGroupProjByFlow(String recordFlow);

	public void save(SrmExpertProjEval egp);

	public Map<String, SrmExpertProjEval> orgExperGroupProjMap();
	
	/**
	 * ����������ѯ��������(������Ŀ�����󷽰�)
	 * @param srmExpertGroupProjExt
	 * @return
	 */
	public List<SrmExpertGroupProjExt> searchSrmExpertGroupProjList(SrmExpertGroupProjExt srmExpertGroupProjExt);
	
	/**
	 * ��������������ѯ��������
	 * @param srmExpertGroupProj
	 * @return
	 */
	public  List<SrmExpertProjEval>  searchSrmExpertGroupProj(SrmExpertProjEval  srmExpertGroupProj);
	
	/**
	 * ������ˮ�Ÿ�����������
	 * @param evalSetFlow
	 */
	public void modExpertGroupProjByFlow(SrmExpertProjEval expertGroupProj);
	
	/**
	 * ������ˮ�Ų�ѯ��������
	 * @param evalSetFlow
	 * @return
	 */
	public SrmExpertProjEval read(String evalSetFlow);
	
	/**
	 * ȡ����������
	 * 1��������������״̬�������ΪN
	 * 2:�������������·����ר��ίԱ��¼����ΪN
	 * @param expertGroupProj
	 */
	public void cancelEvalSet(SrmExpertProjEval expertGroupProj);
	
	
}
