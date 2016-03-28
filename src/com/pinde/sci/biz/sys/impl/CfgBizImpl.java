package com.pinde.sci.biz.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.ICfgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysCfgMapper;
import com.pinde.sci.model.mo.SysCfg;
import com.pinde.sci.model.mo.SysCfgExample;
import com.pinde.sci.model.mo.SysCfgExample.Criteria;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class CfgBizImpl implements ICfgBiz {
	@Resource
	private SysCfgMapper sysCfgMapper;

	@Override
	public SysCfg read(String cfgCode) {
		return sysCfgMapper.selectByPrimaryKey(cfgCode);
	}

	@Override
	public int add(SysCfg cfg) {
		GeneralMethod.setRecordInfo(cfg, true);
		return sysCfgMapper.insert(cfg);
	}

	@Override
	public int mod(SysCfg cfg) {
		GeneralMethod.setRecordInfo(cfg, false);
		return sysCfgMapper.updateByPrimaryKeySelective(cfg);
	}

	@Override
	public List<SysCfg> search(SysCfg cfg) {
		List<String> wsIdList = new ArrayList<String>();
		wsIdList.add(GlobalConstant.SYS_WS_ID);
		SysCfgExample example = new SysCfgExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(cfg.getWsId())) {
			wsIdList.add(cfg.getWsId());
			criteria.andWsIdIn(wsIdList);
		}
		return sysCfgMapper.selectByExampleWithBLOBs(example);
	}

	@Override
	public void save(List<SysCfg> sysCfgList) {
		for (SysCfg sysCfg : sysCfgList) {
			SysCfg temp = this.read(sysCfg.getCfgCode());
			if (temp == null) {
				this.add(sysCfg);
			} else {
				this.mod(sysCfg);
			}
		}
	}

	@Override
	public String getPageSize(HttpServletRequest request) {
		String cfgValue = null;
		String getPath = StringUtil.defaultString(request.getServletPath().toString());
		
		if(GlobalContext.getCurrentUser()!=null){
			String cfgCode = getPath + "/" +GlobalContext.getCurrentUser().getUserFlow();
			String sessionValue = (String) GlobalContext.getSessionAttribute(cfgCode);
			if(StringUtil.isNotBlank(sessionValue)){
				cfgValue = sessionValue;
			}else if(StringUtil.isEquals(InitConfig.getSysCfg("sys_page_size_cfg"),GlobalConstant.FLAG_Y)) {//从数据库取值
				SysCfg cfg = this.read(cfgCode);
				if(cfg!=null){
					cfgValue = cfg.getCfgValue();
					GlobalContext.setSessionAttribute(cfgCode, cfgValue);
				}
			}
		}
		
		if(StringUtil.isBlank(cfgValue)){
			cfgValue = GlobalConstant.DEFAULT_PAGE_SIZE+"";
		}
		return cfgValue;
	}

	@Override
	public void savePageSize(HttpServletRequest request) {
		String cfgValue = request.getParameter(GlobalConstant.PAGE_SIZE);
		if(StringUtil.isBlank(cfgValue)){
			cfgValue = GlobalConstant.DEFAULT_PAGE_SIZE+"";
		}
		String getPath = request.getParameter(GlobalConstant.PAGE_SERVLET_PATH);
		String cfgCode = getPath + "/" +GlobalContext.getCurrentUser().getUserFlow();
		if(StringUtil.isEquals(InitConfig.getSysCfg("sys_page_size_cfg"),GlobalConstant.FLAG_Y)){
			SysCfg cfg = this.read(cfgCode);
			if(cfg==null){
				cfg = new SysCfg();
				cfg.setCfgCode(cfgCode);
				cfg.setCfgValue(cfgValue);
				cfg.setWsId("page");
				cfg.setWsName("分页配置");
				GeneralMethod.setRecordInfo(cfg, true);
				this.add(cfg);
			}else{
				cfg.setCfgValue(cfgValue);
				GeneralMethod.setRecordInfo(cfg, false);
				this.mod(cfg);
			}
		}
		GlobalContext.setSessionAttribute(cfgCode, cfgValue);
	}

	@Override
	public int saveSysCfg(SysCfg start,SysCfg end) {
		if (start!=null) {
			if(StringUtil.isNotBlank(start.getCfgCode())){
				GeneralMethod.setRecordInfo(start, false);
				return sysCfgMapper.updateByPrimaryKeySelective(start);
			}if(StringUtil.isBlank(start.getCfgCode())){
				start.setCfgCode("choose_course_start_time");
				GeneralMethod.setRecordInfo(start, true);
				return sysCfgMapper.insert(start);
			}
		}
		if (end!=null) {
			if(StringUtil.isNotBlank(end.getCfgCode())){
				GeneralMethod.setRecordInfo(end, false);
				return sysCfgMapper.updateByPrimaryKeySelective(end);
			}
			if(StringUtil.isBlank(end.getCfgCode())){
				end.setCfgCode("choose_course_end_time");
				GeneralMethod.setRecordInfo(end, true);
				return sysCfgMapper.insert(end);
			}
		}
		return 0;
	}
}
