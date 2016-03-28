package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ErpCrmContractMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	int countByExample(ErpCrmContractExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	int deleteByExample(ErpCrmContractExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	int deleteByPrimaryKey(String contractFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	int insert(ErpCrmContract record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	int insertSelective(ErpCrmContract record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	List<ErpCrmContract> selectByExample(ErpCrmContractExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	ErpCrmContract selectByPrimaryKey(String contractFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	int updateByExampleSelective(@Param("record") ErpCrmContract record,
			@Param("example") ErpCrmContractExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	int updateByExample(@Param("record") ErpCrmContract record,
			@Param("example") ErpCrmContractExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	int updateByPrimaryKeySelective(ErpCrmContract record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT
	 * @mbggenerated  Sat Feb 28 16:15:26 GMT+08:00 2015
	 */
	int updateByPrimaryKey(ErpCrmContract record);
}