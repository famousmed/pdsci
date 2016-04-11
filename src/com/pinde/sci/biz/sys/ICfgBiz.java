package com.pinde.sci.biz.sys;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.pinde.sci.model.mo.SysCfg;

public interface ICfgBiz {
	
	public SysCfg read(String cfgCode);
	
	public int add(SysCfg cfg);
	
	public int mod(SysCfg cfg);
	
	public void save(List<SysCfg> sysCfgList);
	
	public List<SysCfg> search(SysCfg cfg);
//	
//	public int addSysCfg(String [] cfgCodes);

	public String getPageSize(HttpServletRequest request);

	public void savePageSize(HttpServletRequest request);
	
	

	int saveSysCfg(SysCfg start, SysCfg end);
}
