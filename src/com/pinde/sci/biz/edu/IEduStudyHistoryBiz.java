package com.pinde.sci.biz.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EduStudyHistory;

public interface IEduStudyHistoryBiz {
	/**
	 * �������޸�
	 * @param history
	 * @return
	 */
	int edit(EduStudyHistory history);
	/**
	 * ����ѧϰ��¼
	 * @param operTypeId
	 * @param resourceFlow
	 * @return
	 */
	int save(String operTypeId,String resourceFlow);
	/**
	 * ��ѯ�б�
	 * @return
	 */
	List<EduStudyHistory> searchList();
	/**
	 * ��ѯ��������
	 * @return
	 */
	Map<String, Object> searchExtData(List<EduStudyHistory> historyList);
}
