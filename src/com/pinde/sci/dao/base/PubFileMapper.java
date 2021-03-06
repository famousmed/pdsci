package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PubFileMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int countByExample(PubFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int deleteByExample(PubFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int deleteByPrimaryKey(String fileFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int insert(PubFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int insertSelective(PubFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	List<PubFile> selectByExampleWithBLOBs(PubFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	List<PubFile> selectByExample(PubFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	PubFile selectByPrimaryKey(String fileFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int updateByExampleSelective(@Param("record") PubFile record,
			@Param("example") PubFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int updateByExampleWithBLOBs(@Param("record") PubFile record,
			@Param("example") PubFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int updateByExample(@Param("record") PubFile record,
			@Param("example") PubFileExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int updateByPrimaryKeySelective(PubFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int updateByPrimaryKeyWithBLOBs(PubFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.PUB_FILE
	 * @mbggenerated  Thu Apr 02 10:19:42 CST 2015
	 */
	int updateByPrimaryKey(PubFile record);
}