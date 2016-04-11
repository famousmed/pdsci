package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundDetailExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SrmProjFundDetailMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int countByExample(SrmProjFundDetailExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByExample(SrmProjFundDetailExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByPrimaryKey(String fundDetailFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insert(SrmProjFundDetail record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insertSelective(SrmProjFundDetail record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	List<SrmProjFundDetail> selectByExample(SrmProjFundDetailExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	SrmProjFundDetail selectByPrimaryKey(String fundDetailFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExampleSelective(@Param("record") SrmProjFundDetail record,
			@Param("example") SrmProjFundDetailExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExample(@Param("record") SrmProjFundDetail record,
			@Param("example") SrmProjFundDetailExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKeySelective(SrmProjFundDetail record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_PROJ_FUND_DETAIL
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKey(SrmProjFundDetail record);
}