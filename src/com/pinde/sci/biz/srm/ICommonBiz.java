package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;

public interface ICommonBiz {

	
	/**
	 * ��ѯ��Ŀ�б�ͨ�÷��� ��Ҫ�������㵫������ı�Ļ���������
	 * @param proj
	 * @param recTypeId
	 * @return
	 */
	public List<PubProj> searchProjList(PubProj proj, String recTypeId);
	
}
