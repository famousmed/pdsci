package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;

public interface ISrmAchFileBiz {
   
	/**
	 * ��ѯ�ɹ�����
	 * @param srmAchFile
	 * @return
	 */
	public List<SrmAchFile> searchSrmAchFile(String thesisFlow);
	
	/**
	 * ��ȡ�ɹ��ϴ��ļ�
	 * @param fileFlow
	 * @return
	 */
	public SrmAchFile readAchFile(String fileFlow);
}
