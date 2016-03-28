package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.EduCoursePeriodRef;
import com.pinde.sci.model.mo.EduCoursePeriodRefExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EduCoursePeriodRefMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	int countByExample(EduCoursePeriodRefExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	int deleteByExample(EduCoursePeriodRefExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	int deleteByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	int insert(EduCoursePeriodRef record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	int insertSelective(EduCoursePeriodRef record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	List<EduCoursePeriodRef> selectByExample(EduCoursePeriodRefExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	EduCoursePeriodRef selectByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	int updateByExampleSelective(@Param("record") EduCoursePeriodRef record,
			@Param("example") EduCoursePeriodRefExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	int updateByExample(@Param("record") EduCoursePeriodRef record,
			@Param("example") EduCoursePeriodRefExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	int updateByPrimaryKeySelective(EduCoursePeriodRef record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_PERIOD_REF
	 * @mbggenerated  Mon May 04 19:06:24 CST 2015
	 */
	int updateByPrimaryKey(EduCoursePeriodRef record);
}