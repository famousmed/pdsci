package com.pinde.sci.dao.exam;

import java.util.List;

import com.pinde.sci.model.exam.ExamBookImpExt;

public interface ExamBookImpExtMapper {

	/**
	 * 关联书表查询已经导入的题目信息
	 * @param bookImpExt
	 * @return
	 */
	List<ExamBookImpExt> selectExamBookImp(ExamBookImpExt bookImpExt);
	
	/**
	 * 查询导入信息和对应的详细，该详细是一个列表
	 * 查询内容不包含详细表中的大字段
	 * @param bookImpExt
	 * @return
	 */
	ExamBookImpExt selectExamBookImpAndBookImpDetails(ExamBookImpExt bookImpExt);
}
