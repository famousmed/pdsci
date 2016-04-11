package com.pinde.sci.biz.inx;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.pinde.sci.form.inx.InxInfoForm;
import com.pinde.sci.model.inx.InxInfoExt;
import com.pinde.sci.model.mo.InxInfo;

public interface IinxInfoManageBiz {
	/**
	 * ������Ѷ
	 * @param info
	 * @return
	 */
	public int save(InxInfo info );
	/**
	 * �ϴ�ͼƬ
	 * @param request
	 * @param fileInputName �ļ��ؼ�����
	 * @return
	 */
	public String uploadImg(HttpServletRequest request,String fileInputName);
	/**
	 * ��ȡ��Ѷ��չ
	 * @param infoFlow ��ˮ��
	 * @return
	 */
	public InxInfoExt getExtByFlow(String infoFlow);
	/**
	 * ��ȡ�ϴ�ͼƬurl��·��
	 * @return
	 */
	public String getImageBaseUrl();
	/**
	 * ������Ѷ
	 * @param info
	 * @return
	 */
	public int update(InxInfo info);
	/**
	 * ��ȡ��Ѷ
	 * @param infoFlow ��ˮ��
	 * @return
	 */
	public InxInfo getByFlow(String infoFlow);
	/**
	 * ����������Ѷ״̬
	 * @param infoFlows ��ˮ���б�
	 * @param infoStatusId ��Ѷ���״̬Id
	 * @return
	 */
	public int updateInfoStatus(List<String> infoFlows,String infoStatusId);
	/**
	 * ɾ������ͼƬ
	 * @param infoFlow ��ˮ��
	 * @return 0��ʧ�ܣ�1���ɹ�
	 */
	public int deleteTitleImg(String infoFlow);
	/**
	 * ��ȡ��Ѷ�б�
	 * @param form
	 * @return
	 */
	public List<InxInfo> getList(InxInfoForm form);
	
	int modifyInxInfo(InxInfo info);
}
