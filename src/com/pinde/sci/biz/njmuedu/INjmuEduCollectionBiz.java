package com.pinde.sci.biz.njmuedu;

import java.util.List;

import com.pinde.sci.model.mo.EduCollection;
import com.pinde.sci.model.mo.EduCourseChapter;

public interface INjmuEduCollectionBiz {
	/**
	 * 查询
	 * @param collection
	 * @return
	 */
	List<EduCollection> searchCollectionList(EduCollection collection);
	
	/**
	 * 保存
	 * @param collection
	 * @return
	 */
	int saveCollection(EduCollection collection);
	
	/**
	 * 收藏数
	 * @param collection
	 * @return
	 */
	int searchCollectionCount(String collectionTypeId, String resourceFlow);
	
	/**
	 * 修改章节收藏
	 * @param chapter
	 * @param collection
	 * @return
	 */
	int updateChapterCollection(EduCourseChapter chapter, EduCollection collection);
	
}
