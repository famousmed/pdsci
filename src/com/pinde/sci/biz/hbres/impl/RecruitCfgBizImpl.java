package com.pinde.sci.biz.hbres.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.RecruitCfgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.ResRecruitCfgMapper;
import com.pinde.sci.model.mo.ResGradeBorderline;
import com.pinde.sci.model.mo.ResRecruitCfg;
import com.pinde.sci.model.mo.ResRecruitCfgExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class RecruitCfgBizImpl implements RecruitCfgBiz{

	@Autowired
	private ResRecruitCfgMapper recruitCfgMapper;
	
	@Override
	public ResRecruitCfg findRecruitCfgByYear(String year) {
		ResRecruitCfgExample example = new ResRecruitCfgExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andYearEqualTo(year);
		List<ResRecruitCfg> cgfs = recruitCfgMapper.selectByExample(example);
		if(cgfs.size()==1){
			return cgfs.get(0);
		}else{
			return null;	
		}
	}

	@Override
	public void saveRecruitCfg(ResRecruitCfg recruitCfg) {
		String year = InitConfig.getSysCfg("res_reg_year");
		year = StringUtil.defaultIfEmpty(year, DateUtil.getYear());
		recruitCfg.setYear(year);
		ResRecruitCfg cfg = findRecruitCfgByYear(year);
		if(cfg==null){
			recruitCfg.setCfgFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(recruitCfg, true);
			recruitCfgMapper.insert(recruitCfg);
		}else{
			recruitCfg.setCfgFlow(cfg.getCfgFlow());
			GeneralMethod.setRecordInfo(recruitCfg, false);
			recruitCfgMapper.updateByPrimaryKeySelective(recruitCfg);
		}
		
	}

}
