package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;

public interface IProjArchiveBiz {
    
	/**
	 * ��ѯ������������Ŀ
	 * @param proj
	 * @return
	 */
	public List<PubProj> searchProj(PubProj proj);
	/**
	 * ����鵵���
	 * @param project
	 * @param process
	 */
	public void saveArchiveResult(PubProj project,PubProjProcess process);
}
