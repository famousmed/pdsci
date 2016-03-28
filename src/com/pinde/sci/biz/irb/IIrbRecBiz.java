package com.pinde.sci.biz.irb;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;

import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.model.mo.IrbRec;

public interface IIrbRecBiz {
	/**
	 * 新增或修改
	 * @param irbRec
	 * @return
	 */
	public int edit(IrbRec irbRec);
	/**
	 * 查询
	 * @param irbRec
	 * @return
	 */
	public List<IrbRec> queryList(IrbRec irbRec);
	/**
	 * 查询已上传文件
	 * @param irbRec
	 * @return
	 * @throws Exception
	 */
	public List<IrbApplyFileForm> queryUploadFile(IrbRec irbRec) throws Exception;
	/**
	 * 查询已上传的文件
	 * @param irbFlow apply 流水号
	 * @param fileId 文件流水号
	 * @return
	 * @throws Exception
	 */
	public IrbApplyFileForm queryUploadFile(String irbFlow, String fileId) throws Exception;
	/**
	 * 查询已上传文件
	 * @param dom
	 * @param fileId 文件id
	 * @return
	 * @throws Exception
	 */
	public Element queryUploadFile(Document dom, String fileId);
	/**
	 * 查询补充修改通知中的文件
	 * @param irbFlow
	 * @param type apply:需补充文件,modify:需修改文件
	 * @return
	 * @throws Exception
	 */
	public List<IrbApplyFileForm> queryApplyOrModify(String irbFlow,String type)throws Exception;
	/**
	 * 检查是否有补充修改通知
	 * @param irbFlow
	 * @return true:有，false:没有
	 * @throws Exception
	 */
	public boolean checkNotice(String irbFlow,String recVersion) throws Exception;
	/**
	 * 查询已确认文件
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	public List<IrbApplyFileForm> queryConfirmFile(String irbFlow)throws Exception;
	/**
	 * 查找
	 * @param irbFlow
	 * @param formFileName
	 * @return
	 */
	public IrbRec readIrbRec(String irbFlow, String formFileName);
	/**
	 * 查找
	 * @param irbRec
	 * @return
	 */
	public IrbRec readIrbRec(IrbRec irbRec);
	
	/**
	 * 根据irbFlow查找
	 * @param irbFlow
	 * @return
	 */
	public List<IrbRec> queryRecListByIrbFlow(String irbFlow);
	
	/**
	 * 查询已存档文件
	 * @param irbFlow
	 * @return
	 * @throws Exception 
	 */
	public List<IrbArchiveForm> queryArchiveFile(String irbFlow) throws Exception;
	/**
	 * 文件存档
	 * @param form
	 * @throws Exception 
	 */
	void saveArchiveFile(IrbArchiveForm form) throws Exception;
	/**
	 * 文件存档
	 * @param list
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	int saveArchiveFile(List<IrbArchiveForm> list,String irbFlow) throws Exception;
	/**
	 * 操作存档文件
	 * @param ids
	 * @param irbFlow
	 * @param oper  del:删除，sort:排序
	 * @return
	 * @throws Exception
	 */
	int operApplyFile(String[] ids, String irbFlow,String oper) throws Exception;
	IrbRec readIrbRec(String recFlow);

}
