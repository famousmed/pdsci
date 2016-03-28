package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.SrmAchPatentAuthor;
import com.pinde.sci.model.mo.SrmAchPatentAuthorExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SrmAchPatentAuthorMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int countByExample(SrmAchPatentAuthorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int deleteByExample(SrmAchPatentAuthorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int deleteByPrimaryKey(String authorFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int insert(SrmAchPatentAuthor record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int insertSelective(SrmAchPatentAuthor record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	List<SrmAchPatentAuthor> selectByExample(SrmAchPatentAuthorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	SrmAchPatentAuthor selectByPrimaryKey(String authorFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByExampleSelective(@Param("record") SrmAchPatentAuthor record,
			@Param("example") SrmAchPatentAuthorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByExample(@Param("record") SrmAchPatentAuthor record,
			@Param("example") SrmAchPatentAuthorExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByPrimaryKeySelective(SrmAchPatentAuthor record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.SRM_ACH_PATENT_AUTHOR
	 * @mbggenerated  Thu Aug 21 17:48:24 CST 2014
	 */
	int updateByPrimaryKey(SrmAchPatentAuthor record);
}