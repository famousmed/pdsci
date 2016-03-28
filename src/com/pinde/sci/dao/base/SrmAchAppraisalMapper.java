package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SrmAchAppraisal;
import com.pinde.sci.model.mo.SrmAchAppraisalExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SrmAchAppraisalMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int countByExample(SrmAchAppraisalExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByExample(SrmAchAppraisalExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByPrimaryKey(String appraisalFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insert(SrmAchAppraisal record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insertSelective(SrmAchAppraisal record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	List<SrmAchAppraisal> selectByExample(SrmAchAppraisalExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	SrmAchAppraisal selectByPrimaryKey(String appraisalFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExampleSelective(@Param("record") SrmAchAppraisal record,
			@Param("example") SrmAchAppraisalExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExample(@Param("record") SrmAchAppraisal record,
			@Param("example") SrmAchAppraisalExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKeySelective(SrmAchAppraisal record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_APPRAISAL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKey(SrmAchAppraisal record);
}