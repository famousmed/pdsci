package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcElementExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EdcElementMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	int countByExample(EdcElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	int deleteByExample(EdcElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	int deleteByPrimaryKey(String elementFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	int insert(EdcElement record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	int insertSelective(EdcElement record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	List<EdcElement> selectByExample(EdcElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	EdcElement selectByPrimaryKey(String elementFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	int updateByExampleSelective(@Param("record") EdcElement record,
			@Param("example") EdcElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	int updateByExample(@Param("record") EdcElement record,
			@Param("example") EdcElementExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	int updateByPrimaryKeySelective(EdcElement record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EDC_ELEMENT
	 * @mbggenerated  Fri Jul 24 16:54:56 CST 2015
	 */
	int updateByPrimaryKey(EdcElement record);
}