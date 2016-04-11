package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SysUserMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	int countByExample(SysUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	int deleteByExample(SysUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	int deleteByPrimaryKey(String userFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	int insert(SysUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	int insertSelective(SysUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	List<SysUser> selectByExample(SysUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	SysUser selectByPrimaryKey(String userFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	int updateByExampleSelective(@Param("record") SysUser record,
			@Param("example") SysUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	int updateByExample(@Param("record") SysUser record,
			@Param("example") SysUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	int updateByPrimaryKeySelective(SysUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SYS_USER
	 * @mbggenerated  Thu Aug 27 15:16:47 CST 2015
	 */
	int updateByPrimaryKey(SysUser record);
}