package com.pinde.sci.biz.res;

import java.util.List;

import com.pinde.sci.model.mo.ResOrgSpeAssign;


public interface IResOrgSpeAssignBiz {

	List<ResOrgSpeAssign> searchSpeAssign(String assignYear);

	int editSpeAssign(ResOrgSpeAssign speAssign);
	
	/**
	 * 根据机构流水号和年份 查询指定年份某家医院的所有专业
	 * @param orgFlow
	 * @param assignYear
	 * @return
	 */
	List<ResOrgSpeAssign> searchSpeAssign(String orgFlow , String assignYear);
	
	ResOrgSpeAssign searchSpeAssign(String orgFlow , String assignYear , String speId);
	
	/**
	 * 根据主键查询专业
	 * @param flow
	 * @return
	 */
	ResOrgSpeAssign findSpeAssignByFlow(String flow);

	int editSpeAssignUnSelective(ResOrgSpeAssign speAssign);
	
	/**
	 * 查询指定专业的所有医院招录计划
	 * @param speId
	 * @return
	 */
	List<ResOrgSpeAssign> searchSpeAssignBySpeIdAndYear(String speId , String year);
	

	
}
