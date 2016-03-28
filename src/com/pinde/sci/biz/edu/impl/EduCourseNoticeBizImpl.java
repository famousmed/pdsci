package com.pinde.sci.biz.edu.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseNoticeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EduCourseNoticeMapper;
import com.pinde.sci.dao.edu.EduCourseNoticeExtMapper;
import com.pinde.sci.model.edu.EduCourseNoticeExt;
import com.pinde.sci.model.mo.EduCourseNotice;
import com.pinde.sci.model.mo.EduCourseNoticeExample;
import com.pinde.sci.model.mo.EduCourseNoticeExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class EduCourseNoticeBizImpl implements IEduCourseNoticeBiz{
	@Autowired
	private EduCourseNoticeMapper courseNoticeMapper;
	@Autowired
	private EduCourseNoticeExtMapper courseNoticeExtMapper;
	
	@Override
	public List<EduCourseNotice> searchCourseNoticeList(EduCourseNotice courseNotice) {
		EduCourseNoticeExample example = new EduCourseNoticeExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(courseNotice.getCourseFlow())){
			criteria.andCourseFlowEqualTo(courseNotice.getCourseFlow());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return courseNoticeMapper.selectByExample(example);
	}

	@Override
	public int save(EduCourseNotice courseNotice) {
		if(StringUtil.isNotBlank(courseNotice.getNoticeFlow())){
			GeneralMethod.setRecordInfo(courseNotice, false);
			return courseNoticeMapper.updateByPrimaryKeySelective(courseNotice);
		}else{
			courseNotice.setNoticeFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(courseNotice, true);
			return courseNoticeMapper.insert(courseNotice);
		}
	}

	@Override
	public EduCourseNotice readCourseNotice(String noticeFlow) {
		if(StringUtil.isNotBlank(noticeFlow)){
			return courseNoticeMapper.selectByPrimaryKey(noticeFlow);
		}
		return null;
	}

	@Override
	public List<EduCourseNoticeExt> searchCourseNoticeListByCourseFlow(String courseFlow) {
		if(StringUtil.isNotBlank(courseFlow)){
			return courseNoticeExtMapper.searchCourseNoticeListByCourseFlow(courseFlow);
		}
		return null;
	}

	@Override
	public List<EduCourseNoticeExt> searchCourseNoticeListByCourseFlowRes(
			String courseFlow) {
		if(StringUtil.isNotBlank(courseFlow)){
			return courseNoticeExtMapper.searchCourseNoticeListByCourseFlowRes(courseFlow);
		}
		return null;
	}

}
