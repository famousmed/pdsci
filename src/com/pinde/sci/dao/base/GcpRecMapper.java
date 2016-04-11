package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.GcpRec;
import com.pinde.sci.model.mo.GcpRecExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GcpRecMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int countByExample(GcpRecExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int deleteByExample(GcpRecExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int deleteByPrimaryKey(String recFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int insert(GcpRec record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int insertSelective(GcpRec record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    List<GcpRec> selectByExampleWithBLOBs(GcpRecExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    List<GcpRec> selectByExample(GcpRecExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    GcpRec selectByPrimaryKey(String recFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int updateByExampleSelective(@Param("record") GcpRec record, @Param("example") GcpRecExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int updateByExampleWithBLOBs(@Param("record") GcpRec record, @Param("example") GcpRecExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int updateByExample(@Param("record") GcpRec record, @Param("example") GcpRecExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int updateByPrimaryKeySelective(GcpRec record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int updateByPrimaryKeyWithBLOBs(GcpRec record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.GCP_REC
     *
     * @mbggenerated Wed Oct 15 10:39:13 CST 2014
     */
    int updateByPrimaryKey(GcpRec record);
}