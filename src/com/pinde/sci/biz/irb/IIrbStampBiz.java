package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.model.mo.IrbStamp;

public interface IIrbStampBiz {
	/**
	 * ���ظ��µǼ��б�
	 * @param stamp
	 * @return
	 */
	List<IrbStamp> queryStampList(IrbStamp stamp,String stampEndDate);

	/**
	 * ������µǼ�
	 * @param stamp
	 * @return
	 */
	int saveStamp(IrbStamp stamp);
	/**
	 * ������ˮ�Ų���һ�����µǼ�
	 * @param stampFlow
	 * @return
	 */
	IrbStamp getStampByFlow(String stampFlow);
}
