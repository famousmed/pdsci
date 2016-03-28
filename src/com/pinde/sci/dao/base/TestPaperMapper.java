package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.TestPaper;
import com.pinde.sci.model.mo.TestPaperExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TestPaperMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	int countByExample(TestPaperExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	int deleteByExample(TestPaperExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	int deleteByPrimaryKey(String paperFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	int insert(TestPaper record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	int insertSelective(TestPaper record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	List<TestPaper> selectByExample(TestPaperExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	TestPaper selectByPrimaryKey(String paperFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	int updateByExampleSelective(@Param("record") TestPaper record,
			@Param("example") TestPaperExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	int updateByExample(@Param("record") TestPaper record,
			@Param("example") TestPaperExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	int updateByPrimaryKeySelective(TestPaper record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.TEST_PAPER
	 * @mbggenerated  Thu Jun 18 15:04:02 CST 2015
	 */
	int updateByPrimaryKey(TestPaper record);
}