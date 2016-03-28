package com.pinde.sci.dao.irb;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.model.mo.IrbApply;

public interface IrbApplyExtMapper {
	List<IrbApply> queryList(IrbApplyForm form);

	List<IrbApply> searchIrbList(String userFlow);

	Integer searchInitIrbCount(String projCategroy); 
	
	Integer searchFollowIrbCount(String projCategroy);

	List<IrbApply> searchCommitteeIrbList(Map<String,Object> paramMap);

	List<IrbApply> searchUnReviewIrbs(Map<String, Object> paramMap);
	int searchOrgCount(String orgFlow);

	List<IrbApply> searchTrackIrbList();
}
