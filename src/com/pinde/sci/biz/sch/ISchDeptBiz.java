package com.pinde.sci.biz.sch;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDeptExternalRel;


public interface ISchDeptBiz {
	List<SchDept> searchSchDept(String deptFlow);
	
	SchDept readSchDept(String schDeptFlow);
	
	int saveSchDept(SchDept dept);
	
	Map<String,List<SchDept>> searchSchDeptMap(String orgFlow);

	List<SchDept> searchSchDeptList(String orgFlow);

	int saveSchDeptAndRed(SchDept dept, String[] standardDeptId);

	List<SchDept> searchSchExternalDeptListByDept(String deptFlow);

	int saveSchDeptAndRedAndExtRel(SchDept dept, String[] standardDeptIds,
			SchDeptExternalRel deptExtRel);

	int delSchDept(SchDept dept);

	/**
	 * 为机构各部门自动1:1映射轮转科室
	 * @param orgFlow
	 * @return
	 */
	int mapDeptRel(String orgFlow,List<String> deptFlows);

	/**
	 * 通过轮转科室的flow集合获取轮转科室
	 * @param schDeptLists
	 * @return
	 */
	List<SchDept> searchDeptByFlows(List<String> schDeptLists);

	/**
	 * 通过教师flow获取该教师带过的科室
	 * @param teacherUserFlow
	 * @return
	 */
	List<SchDept> searchTeachDept(String teacherUserFlow);

	/**
	 * 通过部门流水集合获取轮转科室
	 * @param deptLists
	 * @return
	 */
	List<SchDept> searchDeptByDeotFlows(List<String> deptLists);

	/**
	 * 获取医师的轮转计划内科室
	 * @param userFlow
	 * @return
	 */
	List<SchDept> searchrotationDept(String userFlow);

	/**
	 * 按条件筛选医师们的轮转科室范围
	 * @param doctor
	 * @return
	 */
	List<SchDept> countDeptArea(ResDoctor doctor);

	/**
	 * 获取该用户的所有轮转科室
	 * @param userFlow
	 * @return
	 */
	List<SchDept> userSchDept(String userFlow);
}
