package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.ErpCrmContractUserRef;
import com.pinde.sci.model.mo.ErpCrmContractUserRefExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ErpCrmContractUserRefMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    int countByExample(ErpCrmContractUserRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    int deleteByExample(ErpCrmContractUserRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    int deleteByPrimaryKey(String recordFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    int insert(ErpCrmContractUserRef record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    int insertSelective(ErpCrmContractUserRef record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    List<ErpCrmContractUserRef> selectByExample(ErpCrmContractUserRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    ErpCrmContractUserRef selectByPrimaryKey(String recordFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    int updateByExampleSelective(@Param("record") ErpCrmContractUserRef record, @Param("example") ErpCrmContractUserRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    int updateByExample(@Param("record") ErpCrmContractUserRef record, @Param("example") ErpCrmContractUserRefExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    int updateByPrimaryKeySelective(ErpCrmContractUserRef record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.ERP_CRM_CONTRACT_USER_REF
     *
     * @mbggenerated Sat Feb 28 17:02:45 GMT+08:00 2015
     */
    int updateByPrimaryKey(ErpCrmContractUserRef record);
}