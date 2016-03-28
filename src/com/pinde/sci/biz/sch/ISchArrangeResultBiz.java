package com.pinde.sci.biz.sch;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.sch.SchArrangeResultForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SysUser;


public interface ISchArrangeResultBiz {
	List<SchArrangeResult> searchSchArrangeResult();
	
	SchArrangeResult readSchArrangeResult(String resultFlow);
	
	int saveSchArrangeResult(SchArrangeResult result);

	int save(SchArrangeResult result);

	int update(SchArrangeResult result);

	List<SchArrangeResult> searchSchArrangeResultByDoctor(String doctorFlow);

	int saveSchArrangeResultForm(SchArrangeResultForm resultForm);

	int delArrangeResult(String doctorFlow);

	List<SchArrangeResult> searchArrangeResultByDate(String schStartDate,
			String schEndDate);

	List<SchArrangeResult> searchArrangeResultByDate(String schStartDate,
			String schEndDate, String doctorName);

	List<SchArrangeResult> searchArrangeResultByDoctorFlows(
			List<String> doctorFlows);

	List<SchArrangeResult> searchArrangeResultByResultFlow(
			List<String> resultFlows);

	List<Map<String,Object>> countResultByUser(List<String> userFlows);

	List<SchArrangeResult> searchArrangeResultByDateAndOrg(String schStartDate,
			String schEndDate, String orgFlow);

	int saveResultByDoctor(ResDoctor doctor);

	int saveSchArrangeResults(List<SchArrangeResult> resultList);

	Map<String, String> countDateArea(ResDoctor doctor);

	List<Map<String, Object>> countMonthNum(String month, ResDoctor doctor);

	List<SchArrangeResult> searchInMonthResult(String schDeptFlow,
			String month, ResDoctor doctor);

	List<SchArrangeResult> willInDoctor(String orgFlow,String userFlow);

	int countRotationUse(String rotationFlow);

	/**
	 * 为自由排班(无方案医师)的医师生成排班数据
	 * @param doctorFlow
	 * @param orgFlow
	 * @return
	 */
	int createFreeRosteringResult(ResDoctor doctor);

	/**
	 * 根据医师找出正在轮转和未轮转的计划
	 * @param doctorFlows
	 * @return
	 */
	List<SchArrangeResult> cutAfterResult(List<String> doctorFlows);

	/**
	 * 编辑该医师的排班计划
	 * @param doctorFlow
	 * @param addSchDeptFlows
	 * @param delResultFlows
	 * @return
	 */
	int editFreeRostering(String doctorFlow, String[] addSchDeptFlows,
			String[] delResultFlows);

	/**
	 * 为组保存排班
	 * @param resultList
	 * @param groupId
	 * @param operUser
	 * @return
	 */
	int saveGroupResult(List<SchArrangeResult> resultList, String groupId,
			SysUser operUser);
}
