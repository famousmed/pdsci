package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ResReg;
import com.pinde.sci.model.mo.ResRegExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ResRegMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	int countByExample(ResRegExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	int deleteByExample(ResRegExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	int deleteByPrimaryKey(String regFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	int insert(ResReg record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	int insertSelective(ResReg record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	List<ResReg> selectByExample(ResRegExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	ResReg selectByPrimaryKey(String regFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	int updateByExampleSelective(@Param("record") ResReg record,
			@Param("example") ResRegExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	int updateByExample(@Param("record") ResReg record,
			@Param("example") ResRegExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	int updateByPrimaryKeySelective(ResReg record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_REG
	 * @mbggenerated  Wed Mar 18 11:18:43 CST 2015
	 */
	int updateByPrimaryKey(ResReg record);
}