package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SrmAchReseachrep;
import com.pinde.sci.model.mo.SrmAchReseachrepExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SrmAchReseachrepMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int countByExample(SrmAchReseachrepExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByExample(SrmAchReseachrepExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByPrimaryKey(String reseachrepFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insert(SrmAchReseachrep record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insertSelective(SrmAchReseachrep record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	List<SrmAchReseachrep> selectByExample(SrmAchReseachrepExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	SrmAchReseachrep selectByPrimaryKey(String reseachrepFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExampleSelective(@Param("record") SrmAchReseachrep record,
			@Param("example") SrmAchReseachrepExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExample(@Param("record") SrmAchReseachrep record,
			@Param("example") SrmAchReseachrepExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKeySelective(SrmAchReseachrep record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_RESEACHREP
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKey(SrmAchReseachrep record);
}