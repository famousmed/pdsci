package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubTrain;

public interface IPubTrainBiz {
	
	/**
	 * 通过流水号获取培训信息
	 * @param trainFlow
	 * @return
	 */
	PubTrain getTrainByFlow(String trainFlow);
	
	/**
	 * 保存或修改培训信息
	 * @param train
	 * @return
	 */
	int saveTrain(PubTrain train);
	
	/**
	 * 删除培训信息
	 * @param train
	 */
	int deleteTrain(PubTrain train);
	
	/**
	 * 培训信息查询
	 * @param train
	 * @param endTrainDate
	 * @return
	 */
	List<PubTrain> queryTrainList(PubTrain train, String endTrainDate,List<String> trainFlows);
	/**
	 * 查询列表
	 * @param train
	 * @return
	 */
	List<PubTrain> searchList(PubTrain train);
	/**
	 * 统计培训数
	 * @param train
	 * @return
	 */
	int countTrain(PubTrain train);
}
