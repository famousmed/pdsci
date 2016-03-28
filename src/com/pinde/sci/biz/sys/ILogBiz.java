package com.pinde.sci.biz.sys;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.SysLog;


public interface ILogBiz {

	List<SysLog> searcherLog(SysLog log);

	List<SysLog> searchLog(Map<String, Object> paramMap);
	
}
