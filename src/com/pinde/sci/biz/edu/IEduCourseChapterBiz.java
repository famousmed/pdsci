package com.pinde.sci.biz.edu;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.edu.EduCourseChapterExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.SysUser;

public interface IEduCourseChapterBiz {
	/**
	 * 查找章节
	 * @param chapterFlow
	 * @return
	 */
	EduCourseChapter seachOne(String chapterFlow);
	
	/**
	 * 查询课程全部章节
	 * @return
	 */
	List<EduCourseChapter> getAllChapter(String courseFlow);
	
	/**
	 * 保存章节信息
	 * @param chapter
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	int saveChapterInfo(EduCourseChapter chapter, MultipartFile file) throws Exception;
	
	/**
	 * 保存章节
	 * @param chapter
	 * @param file
	 * @return
	 */
	int saveChapter(EduCourseChapter chapter);
	
	/**
	 * 根据课程流水号查出没有富章节的章节
	 * @param eduCourse
	 * @return
	 */
	int countNoParentChapterByCourseFlow(EduCourse eduCourse);
	/**
	 * 根据课程流水号查出有富章节的章节
	 * @param eduCourse
	 * @return
	 */
	int countParentChapterByCourseFlow(EduCourse eduCourse);
	/**
	 * 查找章节（包含扩展属性）
	 * @param chapterFlow
	 * @return
	 */
	EduCourseChapterExt seachOneWithExt(String chapterFlow);
	/**
	 * 删除章节图片
	 * @param chapterFlow
	 * @return
	 */
	int deleteChapterImg(String chapterFlow);
	
	/**
	 * 批量删除
	 * @param chapterFlowList
	 * @return
	 */
	int updateByChapterFlowList(List<String> chapterFlowList);
	
	/**
	 * 查询
	 * @param eduCourseChapter
	 * @return
	 */
	List<EduCourseChapter> searchCourseChapterList(EduCourseChapter chapter, String order,String isParent);
	
	List<EduCourseChapter> searchChapterListByChapterFlowList(List<String> chapterFlowList);
	/**
	 * 查询老师们的所教授章节的详细信息
	 * @param eduUsereList
	 * @return
	 */
    Map<String,Map<String,List<EduCourseChapterExt>>> searchTeachersChapterList(List<EduUserExt> eduUserExtList);
    /**
     * 查询老师所教授的章节基本信息
     * @param teacherId
     * @return
     */
    List<EduCourseChapter> searchChapterListByTeacherId(String teacherId);
    /**
     * 保存resEdu视频信息
     * @param chapter
     * @return
     */
    String saveResEduChapter(EduCourseChapter chapter,String courseFlow);
    /**
     * 查询某课程的视频资料
     * @param courseFlow
     * @return
     */
	EduCourseChapter searchOneChapter(String courseFlow);
    /**
     * 保存章节并返回流水号
     * @param chapter
     * @return
     */
	String saveChapterReturnFlow(EduCourseChapter chapter);
	/**
	 * 获得课程下所有章节的总学分
	 * @param courseFlow
	 * @return
	 */
	BigDecimal getAllChapterCredit(String courseFlow);
	
}
