package com.pinde.sci.dao.sys;


import com.pinde.sci.form.sys.SubjectForm;


/**
 * subject��չmapper
 * @author huangfei
 *
 */
public interface SysSubjCodeExtMapper {

	public int updateByIds(SubjectForm form);
	public int updateParentId(SubjectForm form);
}
