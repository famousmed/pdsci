package com.pinde.sci.biz.sys;

import java.util.List;

import com.pinde.sci.form.sys.SubDictEditForm;
import com.pinde.sci.model.mo.SysDict;

public interface IDictBiz {

	/**
	 * 保存字典
	 * @param dict
	 * @throws Exception 
	 */
	public void addDict(SysDict dict) ;
	
	/**
	 * 根据流水号(主键)更新字典
	 * @param dict
	 * @throws Exception 
	 */
	public void modDict(SysDict dict) ;
	
	/**
	 * 根据流水号更新字典(包过子字典)
	 * @param dict
	 */
	public void modeDictAndSubDict(SysDict dict);
	
	/**
	 * 保存子字典
	 * @param subDictForm
	 */
	public void saveSubDict(SubDictEditForm subDictForm);
	
	/**
	 * 根据流水号(主键)做软删除
	 * @param dictFlow
	 * @throws Exception 
	 */
	public void delDict(String dictFlow,String recordStatus) ;
	
	/**
	 * 根据流水号(主键)做软删除(包过子字典)
	 * @param dictFlow
	 * @throws Exception 
	 */
	public void delDictAndSubDict(String dictFlow,String recordStatus) ;
	
	/**
	 * 根据流水号(主键)查找
	 * @param dictFlow
	 * @return
	 * @throws Exception 
	 */
	public SysDict readDict(String dictFlow) ;
	
	/**
	 * 根据字典类型，字典代码
	 * @param dictFlow
	 * @return
	 * @throws Exception 
	 */
	public SysDict readDict(String dictTypeId,String dictId) ;
	
	/**
	 * 根据条件查询字典
	 * @param sysDict
	 * @return
	 * @throws Exception 
	 */
	public List<SysDict> searchDictList(SysDict sysDict) ;
	
	/**
	 * 根据字典类型id查找字典数据
	 * @param dictTypeId
	 * @return
	 */
	public List<SysDict> searchDictListByDictTypeId(String dictTypeId);
	
	/**
	 *  根据字典类型id和字典流水号查找字典数据但是不包含该字典本身
	 * @param dict
	 * @return
	 */
	public List<SysDict> searchDictListByDictTypeIdNotIncludeSelf(SysDict dict);
	
	/**
	 * 给字典排序
	 * @param dictFlows
	 */
	public void saveOrder(String[] dictFlows);

	/**
	 * 根据字典类型id查询所有的字典
	 * @param dictTypeId 字典类型id
	 * @param isShowAll 是否查询所有 true:查询所有 false:查询启用的
	 * @return
	 */
	List<SysDict> searchDictListAllByDictTypeId(String dictTypeId , boolean isShowAll);
}
