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
	 * �����½�
	 * @param chapterFlow
	 * @return
	 */
	EduCourseChapter seachOne(String chapterFlow);
	
	/**
	 * ��ѯ�γ�ȫ���½�
	 * @return
	 */
	List<EduCourseChapter> getAllChapter(String courseFlow);
	
	/**
	 * �����½���Ϣ
	 * @param chapter
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	int saveChapterInfo(EduCourseChapter chapter, MultipartFile file) throws Exception;
	
	/**
	 * �����½�
	 * @param chapter
	 * @param file
	 * @return
	 */
	int saveChapter(EduCourseChapter chapter);
	
	/**
	 * ���ݿγ���ˮ�Ų��û�и��½ڵ��½�
	 * @param eduCourse
	 * @return
	 */
	int countNoParentChapterByCourseFlow(EduCourse eduCourse);
	/**
	 * ���ݿγ���ˮ�Ų���и��½ڵ��½�
	 * @param eduCourse
	 * @return
	 */
	int countParentChapterByCourseFlow(EduCourse eduCourse);
	/**
	 * �����½ڣ�������չ���ԣ�
	 * @param chapterFlow
	 * @return
	 */
	EduCourseChapterExt seachOneWithExt(String chapterFlow);
	/**
	 * ɾ���½�ͼƬ
	 * @param chapterFlow
	 * @return
	 */
	int deleteChapterImg(String chapterFlow);
	
	/**
	 * ����ɾ��
	 * @param chapterFlowList
	 * @return
	 */
	int updateByChapterFlowList(List<String> chapterFlowList);
	
	/**
	 * ��ѯ
	 * @param eduCourseChapter
	 * @return
	 */
	List<EduCourseChapter> searchCourseChapterList(EduCourseChapter chapter, String order,String isParent);
	
	List<EduCourseChapter> searchChapterListByChapterFlowList(List<String> chapterFlowList);
	/**
	 * ��ѯ��ʦ�ǵ��������½ڵ���ϸ��Ϣ
	 * @param eduUsereList
	 * @return
	 */
    Map<String,Map<String,List<EduCourseChapterExt>>> searchTeachersChapterList(List<EduUserExt> eduUserExtList);
    /**
     * ��ѯ��ʦ�����ڵ��½ڻ�����Ϣ
     * @param teacherId
     * @return
     */
    List<EduCourseChapter> searchChapterListByTeacherId(String teacherId);
    /**
     * ����resEdu��Ƶ��Ϣ
     * @param chapter
     * @return
     */
    String saveResEduChapter(EduCourseChapter chapter,String courseFlow);
    /**
     * ��ѯĳ�γ̵���Ƶ����
     * @param courseFlow
     * @return
     */
	EduCourseChapter searchOneChapter(String courseFlow);
    /**
     * �����½ڲ�������ˮ��
     * @param chapter
     * @return
     */
	String saveChapterReturnFlow(EduCourseChapter chapter);
	/**
	 * ��ÿγ��������½ڵ���ѧ��
	 * @param courseFlow
	 * @return
	 */
	BigDecimal getAllChapterCredit(String courseFlow);
	
}
