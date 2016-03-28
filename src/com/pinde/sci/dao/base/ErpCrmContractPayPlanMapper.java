package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ErpCrmContractPayPlan;
import com.pinde.sci.model.mo.ErpCrmContractPayPlanExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ErpCrmContractPayPlanMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	int countByExample(ErpCrmContractPayPlanExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	int deleteByExample(ErpCrmContractPayPlanExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	int deleteByPrimaryKey(String planFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	int insert(ErpCrmContractPayPlan record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	int insertSelective(ErpCrmContractPayPlan record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	List<ErpCrmContractPayPlan> selectByExample(
			ErpCrmContractPayPlanExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	ErpCrmContractPayPlan selectByPrimaryKey(String planFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	int updateByExampleSelective(@Param("record") ErpCrmContractPayPlan record,
			@Param("example") ErpCrmContractPayPlanExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	int updateByExample(@Param("record") ErpCrmContractPayPlan record,
			@Param("example") ErpCrmContractPayPlanExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	int updateByPrimaryKeySelective(ErpCrmContractPayPlan record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_PAY_PLAN
	 * @mbggenerated  Fri Feb 27 16:01:59 GMT+08:00 2015
	 */
	int updateByPrimaryKey(ErpCrmContractPayPlan record);
}