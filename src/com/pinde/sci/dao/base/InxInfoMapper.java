package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.InxInfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface InxInfoMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int countByExample(InxInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int deleteByExample(InxInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int deleteByPrimaryKey(String infoFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int insert(InxInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int insertSelective(InxInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	List<InxInfo> selectByExampleWithBLOBs(InxInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	List<InxInfo> selectByExample(InxInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	InxInfo selectByPrimaryKey(String infoFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int updateByExampleSelective(@Param("record") InxInfo record,
			@Param("example") InxInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int updateByExampleWithBLOBs(@Param("record") InxInfo record,
			@Param("example") InxInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int updateByExample(@Param("record") InxInfo record,
			@Param("example") InxInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int updateByPrimaryKeySelective(InxInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int updateByPrimaryKeyWithBLOBs(InxInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.INX_INFO
	 * @mbggenerated  Thu Jul 09 09:19:30 CST 2015
	 */
	int updateByPrimaryKey(InxInfo record);
}