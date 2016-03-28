package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseChapterExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EduCourseChapterMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	int countByExample(EduCourseChapterExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	int deleteByExample(EduCourseChapterExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	int deleteByPrimaryKey(String chapterFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	int insert(EduCourseChapter record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	int insertSelective(EduCourseChapter record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	List<EduCourseChapter> selectByExample(EduCourseChapterExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	EduCourseChapter selectByPrimaryKey(String chapterFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	int updateByExampleSelective(@Param("record") EduCourseChapter record,
			@Param("example") EduCourseChapterExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	int updateByExample(@Param("record") EduCourseChapter record,
			@Param("example") EduCourseChapterExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	int updateByPrimaryKeySelective(EduCourseChapter record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDU_COURSE_CHAPTER
	 * @mbggenerated  Thu Jul 23 16:05:23 CST 2015
	 */
	int updateByPrimaryKey(EduCourseChapter record);
}