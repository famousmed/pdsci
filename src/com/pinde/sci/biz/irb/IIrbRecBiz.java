package com.pinde.sci.biz.irb;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;

import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.model.mo.IrbRec;

public interface IIrbRecBiz {
	/**
	 * �������޸�
	 * @param irbRec
	 * @return
	 */
	public int edit(IrbRec irbRec);
	/**
	 * ��ѯ
	 * @param irbRec
	 * @return
	 */
	public List<IrbRec> queryList(IrbRec irbRec);
	/**
	 * ��ѯ���ϴ��ļ�
	 * @param irbRec
	 * @return
	 * @throws Exception
	 */
	public List<IrbApplyFileForm> queryUploadFile(IrbRec irbRec) throws Exception;
	/**
	 * ��ѯ���ϴ����ļ�
	 * @param irbFlow apply ��ˮ��
	 * @param fileId �ļ���ˮ��
	 * @return
	 * @throws Exception
	 */
	public IrbApplyFileForm queryUploadFile(String irbFlow, String fileId) throws Exception;
	/**
	 * ��ѯ���ϴ��ļ�
	 * @param dom
	 * @param fileId �ļ�id
	 * @return
	 * @throws Exception
	 */
	public Element queryUploadFile(Document dom, String fileId);
	/**
	 * ��ѯ�����޸�֪ͨ�е��ļ�
	 * @param irbFlow
	 * @param type apply:�貹���ļ�,modify:���޸��ļ�
	 * @return
	 * @throws Exception
	 */
	public List<IrbApplyFileForm> queryApplyOrModify(String irbFlow,String type)throws Exception;
	/**
	 * ����Ƿ��в����޸�֪ͨ
	 * @param irbFlow
	 * @return true:�У�false:û��
	 * @throws Exception
	 */
	public boolean checkNotice(String irbFlow,String recVersion) throws Exception;
	/**
	 * ��ѯ��ȷ���ļ�
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	public List<IrbApplyFileForm> queryConfirmFile(String irbFlow)throws Exception;
	/**
	 * ����
	 * @param irbFlow
	 * @param formFileName
	 * @return
	 */
	public IrbRec readIrbRec(String irbFlow, String formFileName);
	/**
	 * ����
	 * @param irbRec
	 * @return
	 */
	public IrbRec readIrbRec(IrbRec irbRec);
	
	/**
	 * ����irbFlow����
	 * @param irbFlow
	 * @return
	 */
	public List<IrbRec> queryRecListByIrbFlow(String irbFlow);
	
	/**
	 * ��ѯ�Ѵ浵�ļ�
	 * @param irbFlow
	 * @return
	 * @throws Exception 
	 */
	public List<IrbArchiveForm> queryArchiveFile(String irbFlow) throws Exception;
	/**
	 * �ļ��浵
	 * @param form
	 * @throws Exception 
	 */
	void saveArchiveFile(IrbArchiveForm form) throws Exception;
	/**
	 * �ļ��浵
	 * @param list
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	int saveArchiveFile(List<IrbArchiveForm> list,String irbFlow) throws Exception;
	/**
	 * �����浵�ļ�
	 * @param ids
	 * @param irbFlow
	 * @param oper  del:ɾ����sort:����
	 * @return
	 * @throws Exception
	 */
	int operApplyFile(String[] ids, String irbFlow,String oper) throws Exception;
	IrbRec readIrbRec(String recFlow);

}
