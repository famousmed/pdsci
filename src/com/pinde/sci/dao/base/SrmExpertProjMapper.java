package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SrmExpertProjMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int countByExample(SrmExpertProjExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByExample(SrmExpertProjExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByPrimaryKey(String expertProjFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insert(SrmExpertProj record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insertSelective(SrmExpertProj record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	List<SrmExpertProj> selectByExampleWithBLOBs(SrmExpertProjExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	List<SrmExpertProj> selectByExample(SrmExpertProjExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	SrmExpertProj selectByPrimaryKey(String expertProjFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExampleSelective(@Param("record") SrmExpertProj record,
			@Param("example") SrmExpertProjExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExampleWithBLOBs(@Param("record") SrmExpertProj record,
			@Param("example") SrmExpertProjExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExample(@Param("record") SrmExpertProj record,
			@Param("example") SrmExpertProjExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKeySelective(SrmExpertProj record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKeyWithBLOBs(SrmExpertProj record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_PROJ
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKey(SrmExpertProj record);
}