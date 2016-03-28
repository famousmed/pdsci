package com.pinde.sci.biz.sch;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.sch.SchRotationDeptForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SchRotationGroup;
import com.pinde.sci.model.mo.SysOrg;


public interface ISchRotationDeptBiz {
	List<SchRotationDept> searchSchRotationDept();
	
	List<SchRotationDept> searchSchRotationDept(String rotationFlow);
	
	SchRotationDept readSchRotationDept(String recordFlow);
	

	int saveSchRotationDept(SchRotationDept rotationDept);

	int saveSchRotationDeptForm(SchRotationDeptForm rotationDeptForm);

	List<SchRotationDept> searchSchRotationDeptGroup(String rotationFlow);

	List<SchRotationDept> searchSchRotationDeptMust(String rotationFlow);

	int saveRotationDeptOrd(String[] recordFlows);

	SchRotationDeptReq readDeptReq(String reqFlow);

	int editDeptReq(SchRotationDeptReq deptReq);

	SchRotationDept readSchRotationDept(String schDeptFlow, String rotationFlow);

	List<SchRotationDeptReq> searchDeptReq(String rotationFlow,String schDeptFlow,String recTypeId);

	List<SchRotationDeptReq> searchDeptReq(String rotationFlow,
			String schDeptFlow);

	List<SchRotationDeptReq> searchReqByRotationAndSchDept(
			List<String> rotationFlows, List<String> schDeptFlows,
			String recTypeId, String itemName);

	List<SchRotationDeptReq> searchDeptReqByItemId(String rotationFlow,
			String schDeptFlow, String itemName);

	List<Map<String, Object>> countReqWithSchDept(List<String> rotationFlows,
			List<String> standardDeptIds);


	List<SchRotationDept> searchRotationDeptByFlows(List<String> recordFlows);

	int saveSelDepts(List<String> recordFlows,Map<String,String> schMonthMap,ResDoctor doctor);

	int delSchRotationDeptForm(SchRotationDeptForm rotationDeptForm);

	int saveSelDeptsAndResult(List<String> recordFlows,Map<String,String> schMonthMap,ResDoctor doctor);

	List<SchRotationDept> searchDeptByRotations(List<String> rotationFlows);

	int saveRotationDeptList(List<SchRotationDept> rotationDeptList,
			SchRotationGroup group);

	List<SchRotationDeptReq> searchDeptReqByRel(String relRecordFlow,
			String recTypeId);

	List<SchRotationDeptReq> searchDeptReqByRel(String relRecordFlow);

	List<SchRotationDeptReq> searchStandardReqByMust(
			String rotationFlow, String standardDeptId);

	List<SchRotationDeptReq> searchStandardReqByGroup(String standardGroupFlow,
			String standardDeptId);

	List<SchRotationDeptReq> searchStandardReqByResult(SchArrangeResult result);

	int updateAreaRule(String rotationFlow, String standardDeptId,
			String groupFlow, SysOrg org);

	SchRotationDept readStandardRotationDeptByLocal(String rotationFlow,
			String groupFlow, String standardDeptId);

	List<SchRotationDeptReq> searchStandardReqByRelFlows(
			List<String> relRecordFlows);

	List<SchRotationDeptReq> searchStandardReqByResult(SchArrangeResult result,
			String recTypeId);

	List<SchRotationDeptReq> searchDeptReqByRel(String relRecordFlow,
			String recTypeId, String itemName);

	List<SchRotationDept> searchRotationDeptByGroupFlow(String groupFlow);

	List<SchRotationDept> searchSelDeptByRotations(List<String> rotationFlows);

	List<SchRotationDept> searchOrgSchRotationDept(String rotationFlow,
			String orgFlow);

	List<SchRotationDept> searchDeptByStandard(String rotationFlow,
			String groupFlow, String standardDeptId, String orgFlow);

	int saveSchRotationDeptForm(SchRotationDeptForm rotationDeptForm,
			String rotationFlow);

	List<SchRotationDept> searchOrgSchRotationDeptMust(String rotationFlow,
			String orgFlow);

	List<SchRotationDept> searchOrgSelDeptByRotations(
			List<String> rotationFlows, String orgFlow);

	List<SchRotationDept> searchOrgSchRotationDeptGroup(String rotationFlow,
			String orgFlow);

	int delGroupOrRotationDept(String recordFlow, String groupFlow,
			String rotationFlow);

	/**
	 * 根据一条排班数据flow查询标准规则科室
	 * @param resultFlow
	 * @return
	 */
	SchRotationDept readStandardRotationDept(String resultFlow);

	/**
	 * 根据Flow集合获取rotationDept集合
	 * @param recordFlows
	 * @return
	 */
	List<SchRotationDept> searchRotationDeptByRecordFlows(
			List<String> recordFlows);

	/**
	 * 根据方案获取必轮规则,包含大字段
	 * @param rotationFlow
	 * @return
	 */
	List<SchRotationDept> searchSchRotationDeptMustWithBLOBs(String rotationFlow);

	/**
	 * 根据组合内规则,包含大字段
	 * @param groupFlow
	 * @return
	 */
	List<SchRotationDept> searchRotationDeptByGroupFlowWithBLOBs(
			String groupFlow);

	/**
	 * 计算未关联的科室数量
	 * @param orgFlow
	 * @param rotationFlow
	 * @return
	 */
	int getUnrelCount(String orgFlow, String rotationFlow);

	/**
	 * 获取指定条件要求
	 * @param standardGroupFlow
	 * @param standardDeptId
	 * @param recTypeId
	 * @param itemId
	 * @return
	 */
	List<SchRotationDeptReq> searchStandardReqByStandard(
			String standardGroupFlow, String standardDeptId, String recTypeId,
			String itemId);

	/**
	 * 检测是否拥有默认的其他项,如果没有自动添加
	 * @param relRecordFlow
	 * @param recTypeId
	 * @return
	 */
	int defaultOtherItem(String relRecordFlow, String recTypeId);

}
