package com.pinde.sci.biz.irb;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;

import com.pinde.sci.model.irb.ApplyFileTemp;

public interface IIrbCfgBiz {
	/**
	 * ���������ļ��嵥
	 * @param applyFile
	 */
	public int saveApplyFile(ApplyFileTemp applyFile) throws Exception;
	/**
	 * ��ѯ�����嵥
	 * @param applyFile
	 * @return
	 */
	public List<ApplyFileTemp> queryApplyFileList(ApplyFileTemp applyFile) throws Exception;
	/**
	 * �������������嵥
	 * @param applyFile
	 * @param opera ������edit:�޸ģ�del��ɾ��
	 * @return
	 */
	public int operaApplyFile(ApplyFileTemp applyFile,String opera) throws Exception;
	/**
	 * ���ҵ��������嵥
	 * @param applyFile
	 * @return
	 * @throws Exception
	 */
	public ApplyFileTemp queryApplyFile(ApplyFileTemp applyFile) throws Exception;
	/**
	 * ���ҵ��������嵥�ڵ�
	 * @param applyFile
	 * @param dom
	 * @return
	 * @throws Exception
	 */
	public Element queryApplyFileElement(ApplyFileTemp applyFile,Document dom) throws Exception;
}
