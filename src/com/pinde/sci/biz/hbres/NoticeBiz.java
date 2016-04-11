package com.pinde.sci.biz.hbres;

import java.util.List;

import com.pinde.sci.model.mo.InxInfo;

public interface NoticeBiz {

	/**
	 * ���湫��
	 * @param info
	 * @return
	 */
	public int save(InxInfo info);
	
	/**
	 * ����������ѯ���� ���ݴ���ʱ�䵹������
	 * @param info
	 * @return
	 */
	public List<InxInfo> findNotice(InxInfo info);
	
	/**
	 * ������ˮ�Ų�ѯ����
	 * @param flow
	 * @return
	 */
	public InxInfo findNoticByFlow(String flow);
	
	/**
	 * ɾ������
	 * @param flow
	 * @return
	 */
	public int delNotice(String flow);

	int editInfo(InxInfo info);

	List<InxInfo> searchNotice(InxInfo info);

	List<InxInfo> searchSevenDaysNotice(InxInfo info);

	List<InxInfo> findNoticeWithBLOBs(InxInfo info);

	/**
	 * ĳ����֮���֪ͨ
	 * ���org��Ϊ�������ǰ������org_flowΪ�յ�����,����ֻ��ѯorg_flowΪ�յ�����
	 * @param orgFlow
	 * @return
	 */
	List<InxInfo> searchInfoByOrgBeforeDate(String orgFlow, String date);
}
