package com.pinde.sci.dao.res;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.hbres.ResDoctorTrainingSpeForm;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.res.ResDoctorRecruitExt;

public interface ResDoctorRecruitExtMapper {

	List<ResDoctorRecruitExt> searchDoctorRecruitWithUserList(Map<String, Object> paramMap);

	List<SysDict> searchTrainSpeList(Map<String, Object> paramMap);

	/**
	 * 住培注册学员统计
	 * @param paramMap
	 * @return
	 */
	List<ResDoctorTrainingSpeForm> searchRegisterStatistics(Map<String, Object> paramMap);

	List<ResDoctorRecruitExt> searchDoctorRecruitExt(
			Map<String, Object> paramMap);

	String searchNoticeDoctorNum(Map<String, Object> paramMap);

	List<ResDoctorRecruitExt> selectDoctorRecruitExt(
			Map<String, Object> paramMap);

	List<ResDoctorRecruitExt> readDoctorRecruitExt(Map<String, Object> paramMap);

}
