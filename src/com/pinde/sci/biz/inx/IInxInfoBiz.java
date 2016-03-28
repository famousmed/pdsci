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
	 * 查询Blob
	 * @param column
	 * @return
	 */
	List<InxInfo> queryByFormWithBlobs(InxInfoForm form);

	/**
	 * 根据infoFlow查询
	 * @param infoFlow
	 * @return
	 */
	InxInfo getByInfoFlow(String infoFlow);
	
	/**
	 * 查询图片新闻
	 * @return
	 */
	List<InxInfo> queryImgNews(InxInfoForm form);

	/**
	 * 获取资讯列表
	 * @param form
	 * @return
	 */
	public List<InxInfo> getList(InxInfoForm form);
	
	/**
	 * 查询分类列表
	 * @param form
	 * @return
	 */
	List<InxInfo> queryClassifyList(InxInfoForm form);

	/**
	 * 修改资讯
	 * @param info
	 * @return
	 */
	int  modifyInxInfo(InxInfo info);

		
}
