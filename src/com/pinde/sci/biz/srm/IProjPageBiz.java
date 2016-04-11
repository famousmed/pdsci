package com.pinde.sci.biz.srm;

import java.util.List;
import java.util.Map;

import com.pinde.core.jspform.Page;
import com.pinde.core.jspform.PageGroup;
import com.pinde.sci.model.mo.PubFile;

public interface IProjPageBiz {
	
	/**
	 * ��ȡ����Map����
	 * @param projRecFlow 
	 * @param page ��ǰpage
	 * @param itemGroupflow 
	 * @return
	 */
	Map<String , Object> getItemGroupDataMap(String projRecFlow , Page page , String itemGroupFlow);
	
//	/**
//	 * ��ȡ����Map����
//	 * @param projRecFlow 
//	 * @param page ��ǰpage
//	 * @param itemGroupflow 
//	 * @return
//	 */
//	Map<String , Object> getPageDataMap(String projRecFlow , Page page);
	
	/**
	 * �޸�recContent item
	 * @param projRecFlow
	 * @param page
	 * @param dataMap
	 */
	void modProjRecContentItem(String projRecFlow , Page page , Map<String , String[]> dataMap);
	
	/**
	 * �޸�recContent itemGroup
	 * @param projRecFlow recFlow
	 * @param page ��ǰҳ
	 * @param dataMap ������
	 * @param itemGroupFlow itemGroup����ˮ��
	 * @param itemGroupName itemGroup������
	 * @param flag "N"��ʾɾ����itemGroup "Y"��ʾ�޸�itemGroup
	 */
	void modProjRecContentItemGroup(String projRecFlow , Page page , Map<String , String[]> dataMap , String itemGroupFlow , String itemGroupName , String flag);
	
	/**
	 * ��ȡitem����itemGroup��jsp ���itemGroupNameΪnull����""�Ļ��ͻ�ȡitem��jsp;
	 * @param page
	 * @param itemGroupName
	 * @return
	 */
	String getJspPath(Page page , String itemGroupName);

	/**
	 * 
	 * @param recTypeId
	 * @param projTypeId
	 * @param projStageId
	 * @return
	 */
	PageGroup getPageGroup(String recTypeId, String projTypeId);

	/**
	 * 
	 * @param recTypeId
	 * @param projTypeId
	 * @param pageName
	 * @param projStageId
	 * @return
	 */
	Page getPage(String recTypeId, String projTypeId, String pageName);
	
	Page getPage(String isAid);

	void delFileItemGroup(String recFlow, Page page, Object object,
			String itemGroupFlow, String itemGroupName, String delFileFlag);
	
}
