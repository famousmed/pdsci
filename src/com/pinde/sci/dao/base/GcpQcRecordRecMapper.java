package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.GcpQcRecordRec;
import com.pinde.sci.model.mo.GcpQcRecordRecExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GcpQcRecordRecMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int countByExample(GcpQcRecordRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int deleteByExample(GcpQcRecordRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int deleteByPrimaryKey(String recFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int insert(GcpQcRecordRec record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int insertSelective(GcpQcRecordRec record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	List<GcpQcRecordRec> selectByExampleWithBLOBs(GcpQcRecordRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	List<GcpQcRecordRec> selectByExample(GcpQcRecordRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	GcpQcRecordRec selectByPrimaryKey(String recFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int updateByExampleSelective(@Param("record") GcpQcRecordRec record,
			@Param("example") GcpQcRecordRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int updateByExampleWithBLOBs(@Param("record") GcpQcRecordRec record,
			@Param("example") GcpQcRecordRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int updateByExample(@Param("record") GcpQcRecordRec record,
			@Param("example") GcpQcRecordRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int updateByPrimaryKeySelective(GcpQcRecordRec record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int updateByPrimaryKeyWithBLOBs(GcpQcRecordRec record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.GCP_QC_RECORD_REC
	 * @mbggenerated  Wed Nov 12 09:02:47 GMT+08:00 2014
	 */
	int updateByPrimaryKey(GcpQcRecordRec record);
}