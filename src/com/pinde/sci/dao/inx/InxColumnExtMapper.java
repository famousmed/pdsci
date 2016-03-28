package com.pinde.sci.dao.inx;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.inx.InxColumnForm;
import com.pinde.sci.model.inx.InxColumnExt;
import com.pinde.sci.model.mo.InxColumn;


public interface InxColumnExtMapper {
	public List<InxColumnExt> selectByForm(InxColumnForm form);
	public long selectCountByForm(InxColumnForm form);
	public InxColumnExt selectOneByForm(InxColumnForm form);
	List<InxColumn> searchInxColumnList(Map<String, Object> paramMap);
}