package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.IrbMeetingUser;
import com.pinde.sci.model.mo.IrbMeetingUserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface IrbMeetingUserMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int countByExample(IrbMeetingUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByExample(IrbMeetingUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int deleteByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insert(IrbMeetingUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int insertSelective(IrbMeetingUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	List<IrbMeetingUser> selectByExample(IrbMeetingUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	IrbMeetingUser selectByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExampleSelective(@Param("record") IrbMeetingUser record,
			@Param("example") IrbMeetingUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByExample(@Param("record") IrbMeetingUser record,
			@Param("example") IrbMeetingUserExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKeySelective(IrbMeetingUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	int updateByPrimaryKey(IrbMeetingUser record);
}