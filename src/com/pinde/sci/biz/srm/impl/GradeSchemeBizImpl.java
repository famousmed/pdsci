package com.pinde.sci.biz.srm.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IGradeSchemeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmGradeSchemeMapper;
import com.pinde.sci.model.mo.SrmGradeScheme;
import com.pinde.sci.model.mo.SrmGradeSchemeExample;
import com.pinde.sci.model.mo.SrmGradeSchemeExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class GradeSchemeBizImpl implements IGradeSchemeBiz {
	
	@Resource
	private SrmGradeSchemeMapper srmGradeSchemeMapper;
	
	@Override
	public SrmGradeScheme readGradeScheme(String schemeFlow) {
		return srmGradeSchemeMapper.selectByPrimaryKey(schemeFlow);
	}

	@Override
	public int saveGradeScheme(SrmGradeScheme scheme) {
		if(StringUtil.isNotBlank(scheme.getSchemeFlow())){
			GeneralMethod.setRecordInfo(scheme, false);
			return srmGradeSchemeMapper.updateByPrimaryKeySelective(scheme);
		}else{
			scheme.setSchemeFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(scheme, true);
			return srmGradeSchemeMapper.insert(scheme);
		}
	}
	
	@Override
	public List<SrmGradeScheme> searchGradeScheme(SrmGradeScheme scheme) {
		SrmGradeSchemeExample example=new SrmGradeSchemeExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(scheme.getSchemeName())){
			criteria.andSchemeNameLike("%"+scheme.getSchemeName()+"%");
		}
		if(StringUtil.isNotBlank(scheme.getEvaluationId())){
			criteria.andEvaluationIdEqualTo(scheme.getEvaluationId());
		}
		return srmGradeSchemeMapper.selectByExample(example);
	}
}
