package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ResAssessCfg;
import com.pinde.sci.model.mo.ResAssessCfgExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ResAssessCfgMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int countByExample(ResAssessCfgExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int deleteByExample(ResAssessCfgExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int deleteByPrimaryKey(String cfgFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int insert(ResAssessCfg record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int insertSelective(ResAssessCfg record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	List<ResAssessCfg> selectByExampleWithBLOBs(ResAssessCfgExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	List<ResAssessCfg> selectByExample(ResAssessCfgExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	ResAssessCfg selectByPrimaryKey(String cfgFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int updateByExampleSelective(@Param("record") ResAssessCfg record,
			@Param("example") ResAssessCfgExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int updateByExampleWithBLOBs(@Param("record") ResAssessCfg record,
			@Param("example") ResAssessCfgExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int updateByExample(@Param("record") ResAssessCfg record,
			@Param("example") ResAssessCfgExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int updateByPrimaryKeySelective(ResAssessCfg record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int updateByPrimaryKeyWithBLOBs(ResAssessCfg record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.RES_ASSESS_CFG
	 * @mbggenerated  Tue Jan 13 09:15:17 CST 2015
	 */
	int updateByPrimaryKey(ResAssessCfg record);
}