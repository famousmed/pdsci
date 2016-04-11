package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ResBase;
import com.pinde.sci.model.mo.ResBaseExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ResBaseMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int countByExample(ResBaseExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int deleteByExample(ResBaseExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int deleteByPrimaryKey(String orgFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int insert(ResBase record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int insertSelective(ResBase record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	List<ResBase> selectByExampleWithBLOBs(ResBaseExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	List<ResBase> selectByExample(ResBaseExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	ResBase selectByPrimaryKey(String orgFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int updateByExampleSelective(@Param("record") ResBase record,
			@Param("example") ResBaseExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int updateByExampleWithBLOBs(@Param("record") ResBase record,
			@Param("example") ResBaseExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int updateByExample(@Param("record") ResBase record,
			@Param("example") ResBaseExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int updateByPrimaryKeySelective(ResBase record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int updateByPrimaryKeyWithBLOBs(ResBase record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_BASE
	 * @mbggenerated  Fri Aug 14 09:57:46 CST 2015
	 */
	int updateByPrimaryKey(ResBase record);
}