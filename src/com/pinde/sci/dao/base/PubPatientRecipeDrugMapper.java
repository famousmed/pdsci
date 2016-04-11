package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.PubPatientRecipeDrug;
import com.pinde.sci.model.mo.PubPatientRecipeDrugExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PubPatientRecipeDrugMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    int countByExample(PubPatientRecipeDrugExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    int deleteByExample(PubPatientRecipeDrugExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    int deleteByPrimaryKey(String recordFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    int insert(PubPatientRecipeDrug record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    int insertSelective(PubPatientRecipeDrug record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    List<PubPatientRecipeDrug> selectByExample(PubPatientRecipeDrugExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    PubPatientRecipeDrug selectByPrimaryKey(String recordFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    int updateByExampleSelective(@Param("record") PubPatientRecipeDrug record, @Param("example") PubPatientRecipeDrugExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    int updateByExample(@Param("record") PubPatientRecipeDrug record, @Param("example") PubPatientRecipeDrugExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    int updateByPrimaryKeySelective(PubPatientRecipeDrug record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_PATIENT_RECIPE_DRUG
     *
     * @mbggenerated Wed Nov 05 13:32:03 GMT+08:00 2014
     */
    int updateByPrimaryKey(PubPatientRecipeDrug record);
}