package com.pinde.sci.biz.res;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.SysUser;

public interface IResDoctorProcessBiz {
	/**
	 * ������޸�
	 * @param process
	 * @return
	 */
	int edit(ResDoctorSchProcess process);
	/**
	 * ����ת�ƻ���ˮ�Ų���
	 * @param resultFlow
	 * @return
	 */
	ResDoctorSchProcess searchByResultFlow(String resultFlow);
	/**
	 * ������������
	 * @param processFlow
	 * @return
	 */
	ResDoctorSchProcess read(String processFlow);

	List<ResDoctorSchProcess> searchDoctorProcess(ResDoctorSchProcess doctorProcess);
	List<ResDoctorSchProcess> searchByResultFlows(List<String> schResultFlows);
	ResDoctorSchProcess searchProcessByRec(String doctorFlow, String schDeptFlow);
	List<ResDoctorSchProcess> searchProcessByDoctor(String doctorFlow);
	List<ResDoctorSchProcess> searchProcessByDoctor(ResDoctor doctor,
			ResDoctorSchProcess process,Map<String,String> roleFlagMap);
	List<ResDoctorSchProcess> searchProcessByOrg(String orgFlow);
	
	/**
	 * ��ѯ�û���ǰ��ת����
	 * @param userFlow
	 * @return
	 */
	ResDoctorSchProcess searchCurrDept(SysUser sysUser);
	
	/**
	 * ���ݴ�����ʦflow��ѯ������ʦ�������Ŀ���
	 * @param userFlow
	 * @return
	 */
	List<String> searchTeachDept(String userFlow);
	
	/**
	 * ɸȥû�п�ʼ��ת��ҽʦ
	 * @param doctorFlows
	 * @return
	 */
	List<String> searchRotationDoctor(List<String> doctorFlows);
	
	/**
	 * ��ѯ���û����ڲ����µ�������ת��ѧԱ
	 * @param userFlow
	 * @return
	 */
	List<ResDoctorSchProcess> searchCurrentProcessByUserFlow(String userFlow,
			String isCurrentFlag);
}
