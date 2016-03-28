package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCollection;
import com.pinde.sci.model.mo.EduCourseChapter;

public interface IEduCollectionBiz {
	/**
	 * ��ѯ
	 * @param collection
	 * @return
	 */
	List<EduCollection> searchCollectionList(EduCollection collection);
	
	/**
	 * ����
	 * @param collection
	 * @return
	 */
	int saveCollection(EduCollection collection);
	
	/**
	 * �ղ���
	 * @param collection
	 * @return
	 */
	int searchCollectionCount(String collectionTypeId, String resourceFlow);
	
	/**
	 * �޸��½��ղ�
	 * @param chapter
	 * @param collection
	 * @return
	 */
	int updateChapterCollection(EduCourseChapter chapter, EduCollection collection);
	
}
