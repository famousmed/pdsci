package com.pinde.sci.biz.inx;

import java.util.List;

import com.pinde.sci.form.inx.InxInfoForm;
import com.pinde.sci.model.mo.InxInfo;

public interface IInxInfoBiz {
	/**
	 * 
	 * @param column
	 * @return
	 */
	List<InxInfo> queryByForm(InxInfoForm form);
	
	/**
	 * ��ѯBlob
	 * @param column
	 * @return
	 */
	List<InxInfo> queryByFormWithBlobs(InxInfoForm form);

	/**
	 * ����infoFlow��ѯ
	 * @param infoFlow
	 * @return
	 */
	InxInfo getByInfoFlow(String infoFlow);
	
	/**
	 * ��ѯͼƬ����
	 * @return
	 */
	List<InxInfo> queryImgNews(InxInfoForm form);

	/**
	 * ��ȡ��Ѷ�б�
	 * @param form
	 * @return
	 */
	public List<InxInfo> getList(InxInfoForm form);
	
	/**
	 * ��ѯ�����б�
	 * @param form
	 * @return
	 */
	List<InxInfo> queryClassifyList(InxInfoForm form);

	/**
	 * �޸���Ѷ
	 * @param info
	 * @return
	 */
	int  modifyInxInfo(InxInfo info);

		
}
