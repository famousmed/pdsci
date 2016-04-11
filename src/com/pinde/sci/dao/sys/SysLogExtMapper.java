package com.pinde.sci.dao.sys;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.SysLog;

public interface SysLogExtMapper {

	List<SysLog> searchLog(Map<String,Object> paramMap);
}
