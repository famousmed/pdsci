package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.EduCourseRequireRef;
import com.pinde.sci.model.mo.EduCourseRequireRefExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EduCourseRequireRefMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    int countByExample(EduCourseRequireRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    int deleteByExample(EduCourseRequireRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    int deleteByPrimaryKey(String recordFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    int insert(EduCourseRequireRef record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    int insertSelective(EduCourseRequireRef record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    List<EduCourseRequireRef> selectByExample(EduCourseRequireRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    EduCourseRequireRef selectByPrimaryKey(String recordFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    int updateByExampleSelective(@Param("record") EduCourseRequireRef record, @Param("example") EduCourseRequireRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    int updateByExample(@Param("record") EduCourseRequireRef record, @Param("example") EduCourseRequireRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    int updateByPrimaryKeySelective(EduCourseRequireRef record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EDU_COURSE_REQUIRE_REF
     *
     * @mbggenerated Tue Apr 28 13:48:05 GMT+08:00 2015
     */
    int updateByPrimaryKey(EduCourseRequireRef record);
}