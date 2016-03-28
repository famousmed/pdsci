package com.pinde.sci.biz.irb;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.IrbRegulation;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileForm;

public interface IIrbRegulationBiz {
	/**
	 * ��ѯ
	 * @param regulation
	 * @return
	 */
	List<IrbRegulation> queryRegulationList(IrbRegulation regulation);
	
	/**
	 * �������޸�
	 * @param fileform
	 * @param regTypeId
	 * @return
	 */
	int editRegulation(PubFile file, IrbRegulation regulation);
	
	/**
	 * ������ˮ�Ų���
	 * @param regFlow
	 * @return
	 */
	IrbRegulation getRegulationByFlow(String regFlow);

}
