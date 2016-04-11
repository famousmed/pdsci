package com.pinde.sci.biz.irb;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;

import com.pinde.sci.model.irb.ApplyFileTemp;

public interface IIrbCfgBiz {
	/**
	 * 保存送审文件清单
	 * @param applyFile
	 */
	public int saveApplyFile(ApplyFileTemp applyFile) throws Exception;
	/**
	 * 查询送审清单
	 * @param applyFile
	 * @return
	 */
	public List<ApplyFileTemp> queryApplyFileList(ApplyFileTemp applyFile) throws Exception;
	/**
	 * 操作单个送审清单
	 * @param applyFile
	 * @param opera 操作：edit:修改，del：删除
	 * @return
	 */
	public int operaApplyFile(ApplyFileTemp applyFile,String opera) throws Exception;
	/**
	 * 查找单个送审清单
	 * @param applyFile
	 * @return
	 * @throws Exception
	 */
	public ApplyFileTemp queryApplyFile(ApplyFileTemp applyFile) throws Exception;
	/**
	 * 查找单个送审清单节点
	 * @param applyFile
	 * @param dom
	 * @return
	 * @throws Exception
	 */
	public Element queryApplyFileElement(ApplyFileTemp applyFile,Document dom) throws Exception;
}
