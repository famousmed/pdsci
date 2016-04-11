package com.pinde.sci.biz.hbres;

import java.util.List;

import com.pinde.sci.model.mo.InxInfo;

public interface NoticeBiz {

	/**
	 * 保存公告
	 * @param info
	 * @return
	 */
	public int save(InxInfo info);
	
	/**
	 * 根据条件查询公告 根据创建时间倒序排序
	 * @param info
	 * @return
	 */
	public List<InxInfo> findNotice(InxInfo info);
	
	/**
	 * 根据流水号查询公告
	 * @param flow
	 * @return
	 */
	public InxInfo findNoticByFlow(String flow);
	
	/**
	 * 删除公告
	 * @param flow
	 * @return
	 */
	public int delNotice(String flow);

	int editInfo(InxInfo info);

	List<InxInfo> searchNotice(InxInfo info);

	List<InxInfo> searchSevenDaysNotice(InxInfo info);

	List<InxInfo> findNoticeWithBLOBs(InxInfo info);

	/**
	 * 某日期之后的通知
	 * 如果org不为空则插叙当前机构和org_flow为空的数据,否则只查询org_flow为空的数据
	 * @param orgFlow
	 * @return
	 */
	List<InxInfo> searchInfoByOrgBeforeDate(String orgFlow, String date);
}
