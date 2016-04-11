package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SchRotation;
import com.pinde.sci.model.mo.SchRotationExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SchRotationMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int countByExample(SchRotationExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int deleteByExample(SchRotationExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int deleteByPrimaryKey(String rotationFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int insert(SchRotation record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int insertSelective(SchRotation record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	List<SchRotation> selectByExampleWithBLOBs(SchRotationExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	List<SchRotation> selectByExample(SchRotationExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	SchRotation selectByPrimaryKey(String rotationFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int updateByExampleSelective(@Param("record") SchRotation record,
			@Param("example") SchRotationExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int updateByExampleWithBLOBs(@Param("record") SchRotation record,
			@Param("example") SchRotationExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int updateByExample(@Param("record") SchRotation record,
			@Param("example") SchRotationExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int updateByPrimaryKeySelective(SchRotation record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int updateByPrimaryKeyWithBLOBs(SchRotation record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION
	 * @mbggenerated  Thu Aug 27 17:54:25 CST 2015
	 */
	int updateByPrimaryKey(SchRotation record);
}