package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SchRotationDeptReqExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SchRotationDeptReqMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int countByExample(SchRotationDeptReqExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int deleteByExample(SchRotationDeptReqExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int deleteByPrimaryKey(String reqFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int insert(SchRotationDeptReq record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int insertSelective(SchRotationDeptReq record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	List<SchRotationDeptReq> selectByExampleWithBLOBs(
			SchRotationDeptReqExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	List<SchRotationDeptReq> selectByExample(SchRotationDeptReqExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	SchRotationDeptReq selectByPrimaryKey(String reqFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int updateByExampleSelective(@Param("record") SchRotationDeptReq record,
			@Param("example") SchRotationDeptReqExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int updateByExampleWithBLOBs(@Param("record") SchRotationDeptReq record,
			@Param("example") SchRotationDeptReqExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int updateByExample(@Param("record") SchRotationDeptReq record,
			@Param("example") SchRotationDeptReqExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int updateByPrimaryKeySelective(SchRotationDeptReq record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int updateByPrimaryKeyWithBLOBs(SchRotationDeptReq record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_ROTATION_DEPT_REQ
	 * @mbggenerated  Wed Aug 26 08:35:07 CST 2015
	 */
	int updateByPrimaryKey(SchRotationDeptReq record);
}