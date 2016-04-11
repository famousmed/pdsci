package com.pinde.sci.biz.inx;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.pinde.sci.form.inx.InxInfoForm;
import com.pinde.sci.model.inx.InxInfoExt;
import com.pinde.sci.model.mo.InxInfo;

public interface IinxInfoManageBiz {
	/**
	 * 保存资讯
	 * @param info
	 * @return
	 */
	public int save(InxInfo info );
	/**
	 * 上传图片
	 * @param request
	 * @param fileInputName 文件控件名称
	 * @return
	 */
	public String uploadImg(HttpServletRequest request,String fileInputName);
	/**
	 * 获取资讯扩展
	 * @param infoFlow 流水号
	 * @return
	 */
	public InxInfoExt getExtByFlow(String infoFlow);
	/**
	 * 获取上传图片url根路径
	 * @return
	 */
	public String getImageBaseUrl();
	/**
	 * 更新资讯
	 * @param info
	 * @return
	 */
	public int update(InxInfo info);
	/**
	 * 获取资讯
	 * @param infoFlow 流水号
	 * @return
	 */
	public InxInfo getByFlow(String infoFlow);
	/**
	 * 批量更新资讯状态
	 * @param infoFlows 流水号列表
	 * @param infoStatusId 资讯审核状态Id
	 * @return
	 */
	public int updateInfoStatus(List<String> infoFlows,String infoStatusId);
	/**
	 * 删除标题图片
	 * @param infoFlow 流水号
	 * @return 0：失败，1：成功
	 */
	public int deleteTitleImg(String infoFlow);
	/**
	 * 获取资讯列表
	 * @param form
	 * @return
	 */
	public List<InxInfo> getList(InxInfoForm form);
	
	int modifyInxInfo(InxInfo info);
}
