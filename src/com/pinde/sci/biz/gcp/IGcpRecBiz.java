package com.pinde.sci.biz.gcp;

import java.util.List;
import java.util.Map;

import org.dom4j.DocumentException;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.form.gcp.GcpEvaluationForm;
import com.pinde.sci.form.gcp.GcpFinishWorkForm;
import com.pinde.sci.form.gcp.GcpMeetingForm;
import com.pinde.sci.form.gcp.GcpProvFilingForm;
import com.pinde.sci.form.gcp.GcpSumStampForm;
import com.pinde.sci.model.mo.GcpRec;

public interface IGcpRecBiz {
	/**
	 * �������޸�
	 * @param rec
	 * @return ��Ӱ�������
	 */
	int edit(GcpRec rec);
	/**
	 * ��������������
	 * @param projFlow ��Ŀ��ˮ��
	 * @param agree �Ƿ�ͬ������
	 * @param file ����
	 * @return
	 * @throws Exception
	 */
	//int saveEval(String projFlow,String agree,String projectTime,MultipartFile file) throws Exception;
	/**
	 * ����Ψһ
	 * @param projFlow ��Ŀ��ˮ��
	 * @param recTypeId rec����id
	 * @return
	 */
	GcpRec searchOne(String projFlow,String recTypeId);
	
	/**
	 * ��������������
	 * @param projFlow ��Ŀ��ˮ��
	 * @return
	 * @throws Exception
	 */
	GcpEvaluationForm searchEvaluation(String projFlow)throws Exception;
	
	/**
	 * �����ļ�
	 * @param projFlow
	 * @param fileForm
	 * @param files
	 * @return
	 * @throws Exception 
	 */
	int saveApplyFile(MultipartFile[] files, 
			String[] id, String[] fileFlow,String[] name, String[] version, String[] versionDate, 
			String projFlow) throws Exception;
	
	/**
	 * ��ѯ������Ϣ
	 * @param projFlow
	 * @return
	 * @throws Exception 
	 */
	List<GcpCfgFileForm> searchApplyFiles(String projFlow) throws Exception;
	
	/**
	 * ɾ������
	 * @param fileFlow_id
	 * @return
	 * @throws Exception 
	 */
	int delFileByIds(String projFlow, String[] ids) throws Exception;
	/**
	 * �������
	 * @param form
	 * @return
	 * @throws DocumentException
	 */
	int saveMeeting(GcpMeetingForm form) throws Exception;
	/**
	 * ��ȡ������Ϣ
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	GcpMeetingForm searchMeeting(String projFlow)throws Exception;
	/**
	 * ������Ŀ�ĳ�Ա
	 * @param projFlow
	 * @return key:��ɫ���� value:�����û����û������ٺŸ�����
	 */
	Map<String,String> filterProjUser(String projFlow);
	/**
	 * ɾ�������ļ�
	 * @param ids
	 * @param projFlow
	 * @throws Exception
	 */
	void delMeetingFiles(List<String> ids,String projFlow)throws Exception;
	/**
	 * ����ʡ������
	 * @param form
	 * @return
	 * @throws Exception
	 */
	int saveProvFiling(GcpProvFilingForm form) throws Exception;
	/**
	 * ��ȡʡ������
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	GcpProvFilingForm searchProvFiling(String projFlow) throws Exception;
	/**
	 * ��ȡ�ܽ����
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	GcpSumStampForm searchSumStamp(String projFlow) throws Exception;
	/**
	 * �����ܽ����
	 * @param form
	 * @return
	 * @throws Exception
	 */
	int saveSumStamp(GcpSumStampForm form) throws Exception;
	/**
	 * ��ȡ�о���������
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	GcpFinishWorkForm searchFinishWork(String projFlow) throws Exception;
	/**
	 * �����о���������
	 * @param form
	 * @return
	 * @throws Exception
	 */
	int saveFinishWork(GcpFinishWorkForm form) throws Exception;
	
	/**
	 * ����projFlowList��ѯ
	 * @param projFlowList
	 * @return
	 */
	List<GcpRec> searchGcpRecListWithBLOBs(List<String> projFlowList);
	/**
	 * ��ѯ������������
	 * @param gcpRecList
	 * @return
	 * @throws Exception 
	 */
	Map<String, String> searchStartMeetingDate(List<GcpRec> gcpRecList) throws Exception;
	int saveEval(String projFlow, Map<String, Object> paramMap);
}
