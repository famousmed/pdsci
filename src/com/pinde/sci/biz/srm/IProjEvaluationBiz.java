package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.srm.PubProjExt;

/**
 * ��Ŀ�������
 * 
 * @author shenzhen
 * 
 */
public interface IProjEvaluationBiz {

	/**
	 * ��ѯ��������Ŀ�б�
	 * 
	 * @param projListScope
	 * @param proj
	 * @param orgFlow
	 * @return
	 */
	public List<PubProjExt> searchProjList(PubProjExt projExt);
	
	/**
	 * ������������(����)
	 * 1�������������������
	 * 2���������������������ѡ��ר��
	 * @param groupProj
	 * @param userFlows
	 */
	public void saveEvaluationSettingForNetWork(SrmExpertProjEval groupProj);
	
	/**
	 * ������������(����)
	 * 1:���ԭ�������� �ͽ�ԭ�����������е�ר�Һ���Ŀ�Ĺ�����¼״̬��ΪN
	 * 2�������򱣴���������
	 * @param groupProj
	 * @param userFlows
	 */
	public void saveEvaluationSettingForMeeting(SrmExpertProjEval groupProj);
	
//	/**
//	 * ���������� �� ������ ���һ���������Ŀʱ �� �����û����ϵ�ר�Һ͸���Ŀ
//	 * @param expertProjEval
//	 */
//	public void saveExpertProjWhenAddProjForMeeting(SrmExpertProjEval expertProjEval);


}
