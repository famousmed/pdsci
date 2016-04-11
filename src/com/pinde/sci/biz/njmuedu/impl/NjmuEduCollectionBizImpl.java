package com.pinde.sci.biz.njmuedu.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.njmuedu.INjmuEduCollectionBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseChapterBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EduCollectionMapper;
import com.pinde.sci.model.mo.EduCollection;
import com.pinde.sci.model.mo.EduCollectionExample;
import com.pinde.sci.model.mo.EduCourseChapter;
@Service
@Transactional(rollbackFor = Exception.class)
public class NjmuEduCollectionBizImpl implements INjmuEduCollectionBiz {
	@Autowired
	private EduCollectionMapper collectionMapper;
	@Autowired
	private INjmuEduCourseChapterBiz chapterBiz;
	@Override
	public List<EduCollection> searchCollectionList(EduCollection collection) {
		EduCollectionExample example = new EduCollectionExample();
		com.pinde.sci.model.mo.EduCollectionExample.Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(collection.getCollectionTypeId())){
			criteria.andCollectionTypeIdEqualTo(collection.getCollectionTypeId());
		}
		if(StringUtil.isNotBlank(collection.getUserFlow())){
			criteria.andUserFlowEqualTo(collection.getUserFlow());
		}
		if(StringUtil.isNotBlank(collection.getResourceFlow())){
			criteria.andResourceFlowEqualTo(collection.getResourceFlow());
		}
		if(StringUtil.isNotBlank(collection.getRecordStatus())){
			criteria.andRecordStatusEqualTo(collection.getRecordStatus());
		}
		return collectionMapper.selectByExample(example);
	}
	
	@Override
	public int saveCollection(EduCollection collection) {
		if(StringUtil.isNotBlank(collection.getRecordFlow())){
			GeneralMethod.setRecordInfo(collection, false);
			return collectionMapper.updateByPrimaryKeySelective(collection);
		}else{
			collection.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(collection, true);
			return collectionMapper.insert(collection);
		}
	}

	@Override
	public int searchCollectionCount(String collectionTypeId, String resourceFlow) {
		if(StringUtil.isNotBlank(collectionTypeId) && StringUtil.isNotBlank(resourceFlow)){
			EduCollectionExample example = new EduCollectionExample();
			example.createCriteria().andCollectionTypeIdEqualTo(collectionTypeId).andResourceFlowEqualTo(resourceFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			return collectionMapper.countByExample(example);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int updateChapterCollection(EduCourseChapter chapter, EduCollection collection) {
		chapterBiz.saveChapter(chapter);
		return saveCollection(collection);
	}

}
