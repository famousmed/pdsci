package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ErpOaWorkOrder;
import com.pinde.sci.model.mo.ErpOaWorkOrderExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ErpOaWorkOrderMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int countByExample(ErpOaWorkOrderExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int deleteByExample(ErpOaWorkOrderExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int deleteByPrimaryKey(String workFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int insert(ErpOaWorkOrder record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int insertSelective(ErpOaWorkOrder record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	List<ErpOaWorkOrder> selectByExampleWithBLOBs(ErpOaWorkOrderExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	List<ErpOaWorkOrder> selectByExample(ErpOaWorkOrderExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	ErpOaWorkOrder selectByPrimaryKey(String workFlow);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int updateByExampleSelective(@Param("record") ErpOaWorkOrder record,
			@Param("example") ErpOaWorkOrderExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int updateByExampleWithBLOBs(@Param("record") ErpOaWorkOrder record,
			@Param("example") ErpOaWorkOrderExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int updateByExample(@Param("record") ErpOaWorkOrder record,
			@Param("example") ErpOaWorkOrderExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int updateByPrimaryKeySelective(ErpOaWorkOrder record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int updateByPrimaryKeyWithBLOBs(ErpOaWorkOrder record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.ERP_OA_WORK_ORDER
	 * @mbggenerated  Tue Apr 21 14:12:51 CST 2015
	 */
	int updateByPrimaryKey(ErpOaWorkOrder record);
}