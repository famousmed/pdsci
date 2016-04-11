package com.pinde.sci.biz.sczyres;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResJointOrg;
import com.pinde.sci.model.mo.ResOrgSpeAssign;
import com.pinde.sci.model.res.ResDoctorRecruitExt;

public interface DoctorRecruitBiz {

	/**
	 * ��ѯ��¼��Ϣ
	 * @param recruit ��¼����
	 * @param orderByColum ��������ֶ����� Ϊnullʱ������
	 * @param order desc or asc 
	 * @return
	 */
	public List<ResDoctorRecruit> findDoctorRecruit(ResDoctorRecruit recruit , String orderByColum , String order);
	
	/**
	 * ���ݻ�����ˮ�ź���� ��ѯָ�����ĳ��ҽԺ������רҵ
	 * @param orgFlow
	 * @param assignYear
	 * @return
	 */
	public List<ResOrgSpeAssign> findSpeAssign(String orgFlow , String assignYear);
	
	
	public List<ResOrgSpeAssign> findSpes(ResOrgSpeAssign spe);

	List<ResDoctorRecruitExt> selectDoctorRecruitExt(
			Map<String, Object> paramMap);
	
	public ResDoctorRecruit readResDoctorRecruit(String recruitFlow);
	
	public	int editDoctorRecruit(ResDoctorRecruitWithBLOBs recruit);
	
	/**
	 * ��¼���� ¼ȡ ��¼ȡ
	 * @param recruit
	 */
	public void recruit(ResDoctorRecruitWithBLOBs recruit);
	
	/**
	 * ��������������ѯ��¼����
	 * @param recruit
	 * @return
	 */
	public int findCountByRecruit(ResDoctorRecruit recruit);
	
	/**
	 * ����û�б�¼ȡ��ѧԱ��ˮ�� ��ѯ��ЩѧԱ�ĵ�����¼
	 * @param noRecruitDoctors
	 * @return
	 */
	public Map<String , ResDoctorRecruit> findSwapDoctorRecruit(List<String> noRecruitDoctors);
	
	/**
	 * ���ݸ����Ѿ�������ѧԱ����ˮ�� ��ѯ��ЩѧԱû�б�¼ȡ�ļ�¼
	 * @param swapRecruitDoctors
	 * @return
	 */
	public Map<String , ResDoctorRecruit> findNoRecruitDoctorRecruit(List<String> swapRecruitDoctors);
	
	/**
	 * ��������
	 * @param recruit
	 */
	public void swapRecruit(ResDoctorRecruitWithBLOBs recruit);
		
}
