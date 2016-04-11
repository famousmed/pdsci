package com.pinde.sci.biz.gcp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.model.mo.GcpCfg;

public interface IGcpCfgBiz {
	//--------------�鵵�ļ�--------------
	/**
	 * ����鵵�ļ�
	 * @param applyFile
	 * @return
	 * @throws Exception
	 */
	int saveFinishFileTemplate(GcpCfgFileForm fileForm) throws Exception;
	
	
	/**
	 * ��ѯ�鵵�ļ��嵥
	 * @param applyFile
	 * @return
	 * @throws Exception 
	 */
	List<GcpCfgFileForm> searchFinishFileTemplateList(GcpCfgFileForm fileForm) throws Exception;
	
	/**
	 * ��ѯһ���鵵�ļ�
	 * @param id
	 * @throws Exception 
	 */
	GcpCfgFileForm getFinishFileTemplateById(String id) throws Exception;

	/**
	 * ɾ��һ���ļ�
	 * @param id
	 * @param fileType
	 * @return
	 * @throws Exception
	 */
	int delFileTemplateById(String id, String fileType) throws Exception;
	
	
	
	//--------------�����ļ�-------------------
	/**
	 * ���������ļ�
	 * @param fileForm
	 * @return
	 * @throws Exception 
	 */
	int saveApplyFileTemplate(GcpCfgFileForm fileForm) throws Exception;
	
	/**
	 * ��ѯ�����ļ��б�
	 * @param fileForm
	 * @return
	 * @throws Exception
	 */
	List<GcpCfgFileForm> searchAppLyFileTemplateList() throws Exception;

	/**
	 * ��ѯһ�������ļ�
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	GcpCfgFileForm getApplyFileTemplateById(String id) throws Exception;


	int saveQcRemindConfig(GcpCfg cfg);


	GcpCfg readGcpCfg(String cfgCode);

	String createQcConfigXml(Map<String, String[]> configMap);


	Map<String, List<String>> createQcConfigMap(String configInfo);

}
