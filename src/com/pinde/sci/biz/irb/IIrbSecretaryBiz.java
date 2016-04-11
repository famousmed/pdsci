package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.form.irb.IrbDecisionDetailForm;
import com.pinde.sci.form.irb.IrbNoticeForm;
import com.pinde.sci.form.irb.IrbQuickOpinionForm;
import com.pinde.sci.form.irb.IrbReceiptNoticeForm;
import com.pinde.sci.model.irb.IrbForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.PubFile;


public interface IIrbSecretaryBiz {
	
	IrbForm readIrbForm(String irbFlow);
	
	/**
	 * ȷ�����ϴ��ļ�
	 * @param fileIds �ļ�id����
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	int fileConfirm(String[] fileIds,String irbFlow) throws Exception;

	/**
	 * ���油���޸�֪ͨ
	 * @param form �����޸�֪ͨ��װ
	 * @param irbRec 
	 * @return
	 * @throws Exception
	 */
	int saveApplyAndModifyFile(IrbNoticeForm form,IrbRec irbRec)throws Exception;
	/**
	 * ��������֪ͨ
	 * @param form
	 * @return
	 */
	int saveRecNotice(IrbReceiptNoticeForm form);
	/**
	 * �������µ�һ������/�����¼
	 * @param irbFlow
	 * @return
	 */
	IrbProcess queryLatestHandlePro(String irbFlow);
	/**
	 * ������������ۺ����
	 * @param form
	 * @return
	 * @throws Exception
	 */
	int saveQuickOpinion(IrbQuickOpinionForm form) throws Exception;
	
	/**
	 * ����irbApply
	 * @param form
	 * @return
	 */
	List<IrbForm> searchIrbListByForm(IrbApplyForm form);
	/**
	 * ��ȡ���������ۺ����
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	IrbQuickOpinionForm readQuickOpinion(String irbFlow) throws Exception;
	/**
	 * ���洫���������
	 * @param irbFlow
	 * @param form
	 * @return
	 */
	int saveDecDetail(String irbFlow, IrbDecisionDetailForm form) throws Exception;
	/**
	 * ��ȡ�����������
	 * @param irbFlow
	 * @param irbRecTypeId
	 * @return
	 * @throws Exception
	 */
	IrbDecisionDetailForm readDecDetail(String irbFlow,String irbRecTypeId) throws Exception;
	/**
	 * �ж�apply�Ĵ����ļ��������������
	 * @param curApply
	 * @return
	 */
	String checkFileType(IrbApply curApply);
	
	/**
	 * �ж��Ƿ��ѷ�������
	 * @param curApply
	 * @return
	 */
	boolean isHaveApprove(IrbApply curApply);
	/**
	 * �����浵�ļ�
	 * @param form
	 * @param pubFile
	 * @return
	 * @throws Exception
	 */
	int addApplyFile(IrbArchiveForm form,PubFile pubFile)throws Exception;

	int saveReviewFile(IrbDecisionDetailForm decisionForm) throws Exception;
	
}
