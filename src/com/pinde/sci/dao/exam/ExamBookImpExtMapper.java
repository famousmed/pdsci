package com.pinde.sci.dao.exam;

import java.util.List;

import com.pinde.sci.model.exam.ExamBookImpExt;

public interface ExamBookImpExtMapper {

	/**
	 * ��������ѯ�Ѿ��������Ŀ��Ϣ
	 * @param bookImpExt
	 * @return
	 */
	List<ExamBookImpExt> selectExamBookImp(ExamBookImpExt bookImpExt);
	
	/**
	 * ��ѯ������Ϣ�Ͷ�Ӧ����ϸ������ϸ��һ���б�
	 * ��ѯ���ݲ�������ϸ���еĴ��ֶ�
	 * @param bookImpExt
	 * @return
	 */
	ExamBookImpExt selectExamBookImpAndBookImpDetails(ExamBookImpExt bookImpExt);
}
