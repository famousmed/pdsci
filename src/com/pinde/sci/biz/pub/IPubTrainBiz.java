package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubTrain;

public interface IPubTrainBiz {
	
	/**
	 * ͨ����ˮ�Ż�ȡ��ѵ��Ϣ
	 * @param trainFlow
	 * @return
	 */
	PubTrain getTrainByFlow(String trainFlow);
	
	/**
	 * ������޸���ѵ��Ϣ
	 * @param train
	 * @return
	 */
	int saveTrain(PubTrain train);
	
	/**
	 * ɾ����ѵ��Ϣ
	 * @param train
	 */
	int deleteTrain(PubTrain train);
	
	/**
	 * ��ѵ��Ϣ��ѯ
	 * @param train
	 * @param endTrainDate
	 * @return
	 */
	List<PubTrain> queryTrainList(PubTrain train, String endTrainDate,List<String> trainFlows);
	/**
	 * ��ѯ�б�
	 * @param train
	 * @return
	 */
	List<PubTrain> searchList(PubTrain train);
	/**
	 * ͳ����ѵ��
	 * @param train
	 * @return
	 */
	int countTrain(PubTrain train);
}
