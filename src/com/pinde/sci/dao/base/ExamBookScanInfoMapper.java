package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ExamBookScanInfo;
import com.pinde.sci.model.mo.ExamBookScanInfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ExamBookScanInfoMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    int countByExample(ExamBookScanInfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    int deleteByExample(ExamBookScanInfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    int deleteByPrimaryKey(String scanFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    int insert(ExamBookScanInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    int insertSelective(ExamBookScanInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    List<ExamBookScanInfo> selectByExample(ExamBookScanInfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    ExamBookScanInfo selectByPrimaryKey(String scanFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    int updateByExampleSelective(@Param("record") ExamBookScanInfo record, @Param("example") ExamBookScanInfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    int updateByExample(@Param("record") ExamBookScanInfo record, @Param("example") ExamBookScanInfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    int updateByPrimaryKeySelective(ExamBookScanInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.EXAM_BOOK_SCAN_INFO
     *
     * @mbggenerated Fri Dec 26 15:46:14 CST 2014
     */
    int updateByPrimaryKey(ExamBookScanInfo record);
}