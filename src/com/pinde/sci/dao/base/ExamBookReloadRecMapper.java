package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ExamBookReloadRec;
import com.pinde.sci.model.mo.ExamBookReloadRecExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ExamBookReloadRecMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	int countByExample(ExamBookReloadRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	int deleteByExample(ExamBookReloadRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	int deleteByPrimaryKey(String reloadRecFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	int insert(ExamBookReloadRec record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	int insertSelective(ExamBookReloadRec record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	List<ExamBookReloadRec> selectByExample(ExamBookReloadRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	ExamBookReloadRec selectByPrimaryKey(String reloadRecFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	int updateByExampleSelective(@Param("record") ExamBookReloadRec record,
			@Param("example") ExamBookReloadRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	int updateByExample(@Param("record") ExamBookReloadRec record,
			@Param("example") ExamBookReloadRecExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	int updateByPrimaryKeySelective(ExamBookReloadRec record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	int updateByPrimaryKey(ExamBookReloadRec record);
}