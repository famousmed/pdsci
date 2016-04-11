package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.model.mo.IrbStamp;

public interface IIrbStampBiz {
	/**
	 * 加载盖章登记列表
	 * @param stamp
	 * @return
	 */
	List<IrbStamp> queryStampList(IrbStamp stamp,String stampEndDate);

	/**
	 * 保存盖章登记
	 * @param stamp
	 * @return
	 */
	int saveStamp(IrbStamp stamp);
	/**
	 * 根据流水号查找一个盖章登记
	 * @param stampFlow
	 * @return
	 */
	IrbStamp getStampByFlow(String stampFlow);
}
