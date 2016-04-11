package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcModuleExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EdcModuleMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	int countByExample(EdcModuleExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	int deleteByExample(EdcModuleExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	int deleteByPrimaryKey(String moduleFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	int insert(EdcModule record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	int insertSelective(EdcModule record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	List<EdcModule> selectByExample(EdcModuleExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	EdcModule selectByPrimaryKey(String moduleFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	int updateByExampleSelective(@Param("record") EdcModule record,
			@Param("example") EdcModuleExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	int updateByExample(@Param("record") EdcModule record,
			@Param("example") EdcModuleExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	int updateByPrimaryKeySelective(EdcModule record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_MODULE
	 * @mbggenerated  Tue Oct 14 14:41:56 CST 2014
	 */
	int updateByPrimaryKey(EdcModule record);
}