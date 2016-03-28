package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundProcess;

public interface IFundProcessBiz {
	/**
	 * �����������
	 * @param fundProcess 
	 * @return
	 */
	void saveFundProcess(SrmFundProcess fundProcess);
	
	/**
	 * ��ѯ��������
	 * @param fundFlow ������ˮ��
	 * @param statusId ����״̬
	 * @return
	 */
	List<SrmFundProcess> searchFundProcess(String detailFlow,String statusId);
	
	/**
	 * ��������������ѯ���ѹ����б�
	 * @param process
	 * @return
	 */
	List<SrmFundProcess> searchFundProcesses(SrmFundProcess process);
    
	SrmFundProcess readFundProcess(SrmFundProcess process);
}
