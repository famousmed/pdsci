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
	 * Ϊ�����������Զ�1:1ӳ����ת����
	 * @param orgFlow
	 * @return
	 */
	int mapDeptRel(String orgFlow,List<String> deptFlows);

	/**
	 * ͨ����ת���ҵ�flow���ϻ�ȡ��ת����
	 * @param schDeptLists
	 * @return
	 */
	List<SchDept> searchDeptByFlows(List<String> schDeptLists);

	/**
	 * ͨ����ʦflow��ȡ�ý�ʦ�����Ŀ���
	 * @param teacherUserFlow
	 * @return
	 */
	List<SchDept> searchTeachDept(String teacherUserFlow);

	/**
	 * ͨ��������ˮ���ϻ�ȡ��ת����
	 * @param deptLists
	 * @return
	 */
	List<SchDept> searchDeptByDeotFlows(List<String> deptLists);

	/**
	 * ��ȡҽʦ����ת�ƻ��ڿ���
	 * @param userFlow
	 * @return
	 */
	List<SchDept> searchrotationDept(String userFlow);

	/**
	 * ������ɸѡҽʦ�ǵ���ת���ҷ�Χ
	 * @param doctor
	 * @return
	 */
	List<SchDept> countDeptArea(ResDoctor doctor);

	/**
	 * ��ȡ���û���������ת����
	 * @param userFlow
	 * @return
	 */
	List<SchDept> userSchDept(String userFlow);
}
