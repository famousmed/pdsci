package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.mo.SrmExpertGroupUserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SrmExpertGroupUserMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int countByExample(SrmExpertGroupUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int deleteByExample(SrmExpertGroupUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int deleteByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int insert(SrmExpertGroupUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int insertSelective(SrmExpertGroupUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	List<SrmExpertGroupUser> selectByExample(SrmExpertGroupUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	SrmExpertGroupUser selectByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByExampleSelective(@Param("record") SrmExpertGroupUser record,
			@Param("example") SrmExpertGroupUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByExample(@Param("record") SrmExpertGroupUser record,
			@Param("example") SrmExpertGroupUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByPrimaryKeySelective(SrmExpertGroupUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_EXPERT_GROUP_USER
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByPrimaryKey(SrmExpertGroupUser record);
}