package com.pinde.sci.biz.hbres;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.hbres.ResDoctorTrainingSpeForm;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.res.ResDoctorRecruitExt;


public interface IResDoctorRecruitBiz {

	List<ResDoctorRecruitExt> searchDoctorRecruitWithUserList(Map<String, Object> paramMap);

	List<ResDoctorRecruit> searchDoctorRecruit(ResDoctorRecruit recruit);

	List<SysDict> searchTrainSpeList(Map<String, Object> paramMap);

	/**
	 * ס��ע��ѧԱͳ�Ʊ�
	 * @param paramMap
	 * @return
	 */
	List<ResDoctorTrainingSpeForm> searchRegisterStatistics(Map<String, Object> paramMap);

	List<ResDoctorRecruitExt> searchDoctorRecruitExt(
			Map<String, Object> paramMap);

	int searchDoctorNum(ResDoctorRecruit recruit);

	int editDoctorRecruit(ResDoctorRecruitWithBLOBs recruit);

	ResDoctorRecruit readResDoctorRecruit(String recruitFlow);
	
	/**
	 * ������¼��������
	 * @param recruit
	 */
	void modResDoctorRecruitByRecruitFlow(ResDoctorRecruitWithBLOBs recruit , boolean isModAll);

	/**
	 * ���ø���֪ͨ
	 * @param recruitFlow
	 * @param retestNotice
	 */
	void noticeRetest(String recruitFlow , String retestNotice);

	void noticeRetestBatch(String[] recruitFlows , String retestNotice);

	String searchNoticeDoctorNum(Map<String, Object> paramMap);

	List<ResDoctorRecruitExt> selectDoctorRecruitExt(
			Map<String, Object> paramMap);

	//int editRecruitUnSelective(ResDoctorRecruit recruit);

	List<ResDoctorRecruitExt> readDoctorRecruitExt(Map<String, Object> paramMap);

	void noticeRecruit(String admitNotice , String[] recruitFlows);
	
	/**
	 * רҵ����
	 * @param recruitFlow
	 * @param speId
	 * @param swapNotice
	 */
	public void swapRecruit(String recruitFlow , String speFlow , String swapNotice);
	
	/**
	 * ����ѧԱȷ��¼ȡ���ڱ�־
	 * @param year
	 * @param doctorFlow
	 */
	public void setDoctorConfirmFlagForOutOfDate(String year , String doctorFlow);
	
	/**
	 * ѧԱ�Ƿ��й�ȷ��¼ȡ��¼
	 * @param doctorFlow
	 * @return
	 */
	public boolean doctorIsConfirmAdmit(String doctorFlow);

}
