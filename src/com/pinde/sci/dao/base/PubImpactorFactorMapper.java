package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.PubImpactorFactor;
import com.pinde.sci.model.mo.PubImpactorFactorExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PubImpactorFactorMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int countByExample(PubImpactorFactorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByExample(PubImpactorFactorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByPrimaryKey(String factorFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insert(PubImpactorFactor record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insertSelective(PubImpactorFactor record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	List<PubImpactorFactor> selectByExample(PubImpactorFactorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	PubImpactorFactor selectByPrimaryKey(String factorFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExampleSelective(@Param("record") PubImpactorFactor record,
			@Param("example") PubImpactorFactorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExample(@Param("record") PubImpactorFactor record,
			@Param("example") PubImpactorFactorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKeySelective(PubImpactorFactor record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_IMPACTOR_FACTOR
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKey(PubImpactorFactor record);
}