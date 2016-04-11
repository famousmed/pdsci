package com.pinde.sci.biz.srm.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.ISrmAchFileBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmAchFileMapper;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchFileExample;
@Service
@Transactional(rollbackFor = Exception.class)
public class SrmAchFileBizImpl implements ISrmAchFileBiz{
	@Resource
	private SrmAchFileMapper srmAchFileMapper;

	@Override
	public List<SrmAchFile> searchSrmAchFile(String thesisFlow) {
		SrmAchFileExample example=new SrmAchFileExample();
		example.createCriteria().andAchFlowEqualTo(thesisFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("CREATE_TIME DESC");
		return srmAchFileMapper.selectByExample(example);
	}


	@Override
	public SrmAchFile readAchFile(String fileFlow){
		SrmAchFile file = null;
		if(StringUtil.isNotBlank(fileFlow)){
			file = srmAchFileMapper.selectByPrimaryKey(fileFlow);
		}
		return file;
	}

}
