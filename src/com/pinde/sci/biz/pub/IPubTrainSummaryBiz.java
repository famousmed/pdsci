package com.pinde.sci.biz.pub;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.PubTrainSummary;

public interface IPubTrainSummaryBiz {
	/**
	 * 保存
	 * @param summary
	 * @return
	 */
	int save(PubTrainSummary summary);
	/**
	 * 查询
	 * @return
	 */
	List<PubTrainSummary> searchSummaryList();
	/**
	 * 获取一条培训计划、总结
	 * @param recordFlow
	 * @return
	 */
	PubTrainSummary readSummary(String recordFlow);
	/**
	 * 统计培训数
	 * @param year 年份
	 * @return
	 */
	Map<String,Integer> countTrain(String year);
}
