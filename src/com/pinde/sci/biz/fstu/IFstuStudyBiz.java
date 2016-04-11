package com.pinde.sci.biz.fstu;

import java.util.List;

import com.pinde.sci.model.mo.FstuStudy;

public interface IFstuStudyBiz {
	/**
	 * FstuStudy���ѯ
	 * @param study
	 * @return
	 */
	public List<FstuStudy> search(FstuStudy study);
	
	public FstuStudy findByFlow(String studyFlow);
	/**
	 * ����or�޸�
	 * @param proj
	 * @return
	 */
	public int saveOrEdit(FstuStudy study);
	

	/**
	 * ��ѯ����study
	 * @return
	 */
	List<FstuStudy> searchStudys();
	/**
	 * ͨ������userFlow,auditStatusId��ѯ
	 * @param userFlow
	 * @return
	 */
	List<FstuStudy> searchByUserFlows(List<String> userFlow,
			List<String> auditStatusId);
}
