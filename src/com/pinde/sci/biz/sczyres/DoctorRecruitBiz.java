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
	 * 查询招录信息
	 * @param recruit 招录条件
	 * @param orderByColum 根据这个字段排序 为null时不排序
	 * @param order desc or asc 
	 * @return
	 */
	public List<ResDoctorRecruit> findDoctorRecruit(ResDoctorRecruit recruit , String orderByColum , String order);
	
	/**
	 * 根据机构流水号和年份 查询指定年份某家医院的所有专业
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
	 * 招录操作 录取 不录取
	 * @param recruit
	 */
	public void recruit(ResDoctorRecruitWithBLOBs recruit);
	
	/**
	 * 根据自身条件查询招录人数
	 * @param recruit
	 * @return
	 */
	public int findCountByRecruit(ResDoctorRecruit recruit);
	
	/**
	 * 根据没有被录取的学员流水号 查询这些学员的调剂记录
	 * @param noRecruitDoctors
	 * @return
	 */
	public Map<String , ResDoctorRecruit> findSwapDoctorRecruit(List<String> noRecruitDoctors);
	
	/**
	 * 根据给定已经被调剂学员的流水号 查询这些学员没有被录取的记录
	 * @param swapRecruitDoctors
	 * @return
	 */
	public Map<String , ResDoctorRecruit> findNoRecruitDoctorRecruit(List<String> swapRecruitDoctors);
	
	/**
	 * 调剂操作
	 * @param recruit
	 */
	public void swapRecruit(ResDoctorRecruitWithBLOBs recruit);
		
}
