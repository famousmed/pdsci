package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.IrbStamp;
import com.pinde.sci.model.mo.IrbStampExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface IrbStampMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int countByExample(IrbStampExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int deleteByExample(IrbStampExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int deleteByPrimaryKey(String stampFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int insert(IrbStamp record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int insertSelective(IrbStamp record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	List<IrbStamp> selectByExample(IrbStampExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	IrbStamp selectByPrimaryKey(String stampFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByExampleSelective(@Param("record") IrbStamp record,
			@Param("example") IrbStampExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByExample(@Param("record") IrbStamp record,
			@Param("example") IrbStampExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByPrimaryKeySelective(IrbStamp record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_STAMP
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByPrimaryKey(IrbStamp record);
}