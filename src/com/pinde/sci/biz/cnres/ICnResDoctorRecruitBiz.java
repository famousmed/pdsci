package com.pinde.sci.biz.cnres;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.hbres.ResDoctorTrainingSpeForm;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.res.ResDoctorRecruitExt;


public interface ICnResDoctorRecruitBiz {

	List<ResDoctorRecruitExt> searchDoctorRecruitWithUserList(Map<String, Object> paramMap);

	List<ResDoctorRecruit> searchDoctorRecruit(ResDoctorRecruit recruit);

	List<SysDict> searchTrainSpeList(Map<String, Object> paramMap);

	/**
	 * 住培注册学员统计表
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
	 * 设置复试通知
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
	 * 专业调剂
	 * @param recruitFlow
	 * @param speId
	 * @param swapNotice
	 */
	public void swapRecruit(String recruitFlow , String speFlow , String swapNotice);
	
	/**
	 * 设置学员确认录取过期标志
	 * @param year
	 * @param doctorFlow
	 */
	public void setDoctorConfirmFlagForOutOfDate(String year , String doctorFlow);

}
