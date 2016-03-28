package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.EdcVisitElement;
import com.pinde.sci.model.mo.EdcVisitElementExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EdcVisitElementMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	int countByExample(EdcVisitElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	int deleteByExample(EdcVisitElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	int deleteByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	int insert(EdcVisitElement record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	int insertSelective(EdcVisitElement record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	List<EdcVisitElement> selectByExample(EdcVisitElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	EdcVisitElement selectByPrimaryKey(String recordFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	int updateByExampleSelective(@Param("record") EdcVisitElement record,
			@Param("example") EdcVisitElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	int updateByExample(@Param("record") EdcVisitElement record,
			@Param("example") EdcVisitElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	int updateByPrimaryKeySelective(EdcVisitElement record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_VISIT_ELEMENT
	 * @mbggenerated  Wed Oct 15 16:20:31 CST 2014
	 */
	int updateByPrimaryKey(EdcVisitElement record);
}