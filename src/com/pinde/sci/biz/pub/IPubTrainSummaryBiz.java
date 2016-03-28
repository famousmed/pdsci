package com.pinde.sci.biz.pub;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.PubTrainSummary;

public interface IPubTrainSummaryBiz {
	/**
	 * ����
	 * @param summary
	 * @return
	 */
	int save(PubTrainSummary summary);
	/**
	 * ��ѯ
	 * @return
	 */
	List<PubTrainSummary> searchSummaryList();
	/**
	 * ��ȡһ����ѵ�ƻ����ܽ�
	 * @param recordFlow
	 * @return
	 */
	PubTrainSummary readSummary(String recordFlow);
	/**
	 * ͳ����ѵ��
	 * @param year ���
	 * @return
	 */
	Map<String,Integer> countTrain(String year);
}
