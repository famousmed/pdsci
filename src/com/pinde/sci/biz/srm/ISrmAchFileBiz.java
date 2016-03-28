package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;

public interface ISrmAchFileBiz {
   
	/**
	 * 查询成果附件
	 * @param srmAchFile
	 * @return
	 */
	public List<SrmAchFile> searchSrmAchFile(String thesisFlow);
	
	/**
	 * 读取成果上传文件
	 * @param fileFlow
	 * @return
	 */
	public SrmAchFile readAchFile(String fileFlow);
}
