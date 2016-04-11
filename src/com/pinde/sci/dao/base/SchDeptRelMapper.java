package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SchDeptRel;
import com.pinde.sci.model.mo.SchDeptRelExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SchDeptRelMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	int countByExample(SchDeptRelExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	int deleteByExample(SchDeptRelExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	int deleteByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	int insert(SchDeptRel record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	int insertSelective(SchDeptRel record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	List<SchDeptRel> selectByExample(SchDeptRelExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	SchDeptRel selectByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	int updateByExampleSelective(@Param("record") SchDeptRel record,
			@Param("example") SchDeptRelExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	int updateByExample(@Param("record") SchDeptRel record,
			@Param("example") SchDeptRelExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	int updateByPrimaryKeySelective(SchDeptRel record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SCH_DEPT_REL
	 * @mbggenerated  Fri Aug 21 11:00:50 CST 2015
	 */
	int updateByPrimaryKey(SchDeptRel record);
}