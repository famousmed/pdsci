package com.pinde.sci.biz.srm;

import java.util.List;
import java.util.Map;

import com.pinde.core.jspform.Page;
import com.pinde.core.jspform.PageGroup;
import com.pinde.sci.model.mo.PubFile;

public interface IProjPageBiz {
	
	/**
	 * 获取数据Map对象
	 * @param projRecFlow 
	 * @param page 当前page
	 * @param itemGroupflow 
	 * @return
	 */
	Map<String , Object> getItemGroupDataMap(String projRecFlow , Page page , String itemGroupFlow);
	
//	/**
//	 * 获取数据Map对象
//	 * @param projRecFlow 
//	 * @param page 当前page
//	 * @param itemGroupflow 
//	 * @return
//	 */
//	Map<String , Object> getPageDataMap(String projRecFlow , Page page);
	
	/**
	 * 修改recContent item
	 * @param projRecFlow
	 * @param page
	 * @param dataMap
	 */
	void modProjRecContentItem(String projRecFlow , Page page , Map<String , String[]> dataMap);
	
	/**
	 * 修改recContent itemGroup
	 * @param projRecFlow recFlow
	 * @param page 当前页
	 * @param dataMap 表单数据
	 * @param itemGroupFlow itemGroup的流水号
	 * @param itemGroupName itemGroup的名称
	 * @param flag "N"表示删除该itemGroup "Y"表示修改itemGroup
	 */
	void modProjRecContentItemGroup(String projRecFlow , Page page , Map<String , String[]> dataMap , String itemGroupFlow , String itemGroupName , String flag);
	
	/**
	 * 获取item或者itemGroup的jsp 如果itemGroupName为null或者""的话就获取item的jsp;
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
