package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbInfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface IrbInfoMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int countByExample(IrbInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByExample(IrbInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insert(IrbInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insertSelective(IrbInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	List<IrbInfo> selectByExample(IrbInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	IrbInfo selectByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExampleSelective(@Param("record") IrbInfo record,
			@Param("example") IrbInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExample(@Param("record") IrbInfo record,
			@Param("example") IrbInfoExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKeySelective(IrbInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_INFO
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKey(IrbInfo record);
}