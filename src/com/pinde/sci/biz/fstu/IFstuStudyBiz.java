package com.pinde.sci.biz.fstu;

import java.util.List;

import com.pinde.sci.model.mo.FstuStudy;

public interface IFstuStudyBiz {
	/**
	 * FstuStudy表查询
	 * @param study
	 * @return
	 */
	public List<FstuStudy> search(FstuStudy study);
	
	public FstuStudy findByFlow(String studyFlow);
	/**
	 * 新增or修改
	 * @param proj
	 * @return
	 */
	public int saveOrEdit(FstuStudy study);
	

	/**
	 * 查询所有study
	 * @return
	 */
	List<FstuStudy> searchStudys();
	/**
	 * 通过集合userFlow,auditStatusId查询
	 * @param userFlow
	 * @return
	 */
	List<FstuStudy> searchByUserFlows(List<String> userFlow,
			List<String> auditStatusId);
}
