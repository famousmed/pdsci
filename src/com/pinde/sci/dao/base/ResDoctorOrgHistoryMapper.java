package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ResDoctorOrgHistory;
import com.pinde.sci.model.mo.ResDoctorOrgHistoryExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ResDoctorOrgHistoryMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	int countByExample(ResDoctorOrgHistoryExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	int deleteByExample(ResDoctorOrgHistoryExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	int deleteByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	int insert(ResDoctorOrgHistory record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	int insertSelective(ResDoctorOrgHistory record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	List<ResDoctorOrgHistory> selectByExample(ResDoctorOrgHistoryExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	ResDoctorOrgHistory selectByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	int updateByExampleSelective(@Param("record") ResDoctorOrgHistory record,
			@Param("example") ResDoctorOrgHistoryExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	int updateByExample(@Param("record") ResDoctorOrgHistory record,
			@Param("example") ResDoctorOrgHistoryExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	int updateByPrimaryKeySelective(ResDoctorOrgHistory record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_DOCTOR_ORG_HISTORY
	 * @mbggenerated  Fri Jun 26 09:12:27 CST 2015
	 */
	int updateByPrimaryKey(ResDoctorOrgHistory record);
}