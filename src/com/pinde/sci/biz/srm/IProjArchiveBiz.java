package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;

public interface IProjArchiveBiz {
    
	/**
	 * 查询符合条件的项目
	 * @param proj
	 * @return
	 */
	public List<PubProj> searchProj(PubProj proj);
	/**
	 * 保存归档结果
	 * @param project
	 * @param process
	 */
	public void saveArchiveResult(PubProj project,PubProjProcess process);
}
