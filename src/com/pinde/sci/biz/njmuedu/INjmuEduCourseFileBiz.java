package com.pinde.sci.biz.njmuedu;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.EduCourseFile;

public interface INjmuEduCourseFileBiz {
	/**
	 * ��������
	 * @param courseFile
	 * @return
	 */
	int saveCourseFile(EduCourseFile courseFile);
	
	/**
	 * ��ѯ
	 * @param courseFile
	 * @return
	 */
	List<EduCourseFile> searchCourseFileList(EduCourseFile courseFile);
	
	/**
	 * �����ļ�
	 * @param courseFile
	 * @return
	 * @throws Exception 
	 */
	int operateFile(MultipartFile file, String courseFlow) throws Exception;
	
	/**
	 * ɾ��ͼƬ
	 * @param courseFlow
	 * @return
	 */
	int delCourseFile(String recordFlow);
	
	/**
	 * ��ȡһ���γ�����
	 * @return
	 */
	EduCourseFile readCourseFile(String recordFlow);
}
