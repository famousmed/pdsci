package com.pinde.sci.biz.gcp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.model.mo.GcpCfg;

public interface IGcpCfgBiz {
	//--------------归档文件--------------
	/**
	 * 保存归档文件
	 * @param applyFile
	 * @return
	 * @throws Exception
	 */
	int saveFinishFileTemplate(GcpCfgFileForm fileForm) throws Exception;
	
	
	/**
	 * 查询归档文件清单
	 * @param applyFile
	 * @return
	 * @throws Exception 
	 */
	List<GcpCfgFileForm> searchFinishFileTemplateList(GcpCfgFileForm fileForm) throws Exception;
	
	/**
	 * 查询一条归档文件
	 * @param id
	 * @throws Exception 
	 */
	GcpCfgFileForm getFinishFileTemplateById(String id) throws Exception;

	/**
	 * 删除一条文件
	 * @param id
	 * @param fileType
	 * @return
	 * @throws Exception
	 */
	int delFileTemplateById(String id, String fileType) throws Exception;
	
	
	
	//--------------送审文件-------------------
	/**
	 * 保存送审文件
	 * @param fileForm
	 * @return
	 * @throws Exception 
	 */
	int saveApplyFileTemplate(GcpCfgFileForm fileForm) throws Exception;
	
	/**
	 * 查询送审文件列表
	 * @param fileForm
	 * @return
	 * @throws Exception
	 */
	List<GcpCfgFileForm> searchAppLyFileTemplateList() throws Exception;

	/**
	 * 查询一条送审文件
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
