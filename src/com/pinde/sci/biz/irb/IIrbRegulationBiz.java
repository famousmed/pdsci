package com.pinde.sci.biz.irb;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.IrbRegulation;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileForm;

public interface IIrbRegulationBiz {
	/**
	 * 查询
	 * @param regulation
	 * @return
	 */
	List<IrbRegulation> queryRegulationList(IrbRegulation regulation);
	
	/**
	 * 新增或修改
	 * @param fileform
	 * @param regTypeId
	 * @return
	 */
	int editRegulation(PubFile file, IrbRegulation regulation);
	
	/**
	 * 根据流水号查找
	 * @param regFlow
	 * @return
	 */
	IrbRegulation getRegulationByFlow(String regFlow);

}
