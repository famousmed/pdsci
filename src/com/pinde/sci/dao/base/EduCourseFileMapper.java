package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.EduCourseFile;
import com.pinde.sci.model.mo.EduCourseFileExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EduCourseFileMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	int countByExample(EduCourseFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	int deleteByExample(EduCourseFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	int deleteByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	int insert(EduCourseFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	int insertSelective(EduCourseFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	List<EduCourseFile> selectByExample(EduCourseFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	EduCourseFile selectByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	int updateByExampleSelective(@Param("record") EduCourseFile record,
			@Param("example") EduCourseFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	int updateByExample(@Param("record") EduCourseFile record,
			@Param("example") EduCourseFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	int updateByPrimaryKeySelective(EduCourseFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_FILE
	 * @mbggenerated  Fri Dec 05 10:49:59 CST 2014
	 */
	int updateByPrimaryKey(EduCourseFile record);
}