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
	 * 根据招录主键更新
	 * @param recruit
	 */
	void modResDoctorRecruitByRecruitFlow(ResDoctorRecruitWithBLOBs recruit , boolean isModAll);

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
	
	/**
	 * 学员是否有过确认录取记录
	 * @param doctorFlow
	 * @return
	 */
	public boolean doctorIsConfirmAdmit(String doctorFlow);

}
