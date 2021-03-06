package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ErpCrmCustomerMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	int countByExample(ErpCrmCustomerExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	int deleteByExample(ErpCrmCustomerExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	int deleteByPrimaryKey(String customerFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	int insert(ErpCrmCustomer record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	int insertSelective(ErpCrmCustomer record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	List<ErpCrmCustomer> selectByExample(ErpCrmCustomerExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	ErpCrmCustomer selectByPrimaryKey(String customerFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	int updateByExampleSelective(@Param("record") ErpCrmCustomer record,
			@Param("example") ErpCrmCustomerExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	int updateByExample(@Param("record") ErpCrmCustomer record,
			@Param("example") ErpCrmCustomerExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	int updateByPrimaryKeySelective(ErpCrmCustomer record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CUSTOMER
	 * @mbggenerated  Mon Jan 12 09:58:01 GMT+08:00 2015
	 */
	int updateByPrimaryKey(ErpCrmCustomer record);
}