package com.pinde.sci.dao.base;

import com.pinde.sci.model.mo.PubMeetingFile;
import com.pinde.sci.model.mo.PubMeetingFileExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PubMeetingFileMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    int countByExample(PubMeetingFileExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    int deleteByExample(PubMeetingFileExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    int deleteByPrimaryKey(String fileFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    int insert(PubMeetingFile record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    int insertSelective(PubMeetingFile record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    List<PubMeetingFile> selectByExample(PubMeetingFileExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    PubMeetingFile selectByPrimaryKey(String fileFlow);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    int updateByExampleSelective(@Param("record") PubMeetingFile record, @Param("example") PubMeetingFileExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    int updateByExample(@Param("record") PubMeetingFile record, @Param("example") PubMeetingFileExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    int updateByPrimaryKeySelective(PubMeetingFile record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table PDSCI.PUB_MEETING_FILE
     *
     * @mbggenerated Tue Oct 21 10:27:23 CST 2014
     */
    int updateByPrimaryKey(PubMeetingFile record);
}