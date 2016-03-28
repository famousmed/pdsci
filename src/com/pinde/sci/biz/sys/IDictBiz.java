package com.pinde.sci.biz.sys;

import java.util.List;

import com.pinde.sci.form.sys.SubDictEditForm;
import com.pinde.sci.model.mo.SysDict;

public interface IDictBiz {

	/**
	 * �����ֵ�
	 * @param dict
	 * @throws Exception 
	 */
	public void addDict(SysDict dict) ;
	
	/**
	 * ������ˮ��(����)�����ֵ�
	 * @param dict
	 * @throws Exception 
	 */
	public void modDict(SysDict dict) ;
	
	/**
	 * ������ˮ�Ÿ����ֵ�(�������ֵ�)
	 * @param dict
	 */
	public void modeDictAndSubDict(SysDict dict);
	
	/**
	 * �������ֵ�
	 * @param subDictForm
	 */
	public void saveSubDict(SubDictEditForm subDictForm);
	
	/**
	 * ������ˮ��(����)����ɾ��
	 * @param dictFlow
	 * @throws Exception 
	 */
	public void delDict(String dictFlow,String recordStatus) ;
	
	/**
	 * ������ˮ��(����)����ɾ��(�������ֵ�)
	 * @param dictFlow
	 * @throws Exception 
	 */
	public void delDictAndSubDict(String dictFlow,String recordStatus) ;
	
	/**
	 * ������ˮ��(����)����
	 * @param dictFlow
	 * @return
	 * @throws Exception 
	 */
	public SysDict readDict(String dictFlow) ;
	
	/**
	 * �����ֵ����ͣ��ֵ����
	 * @param dictFlow
	 * @return
	 * @throws Exception 
	 */
	public SysDict readDict(String dictTypeId,String dictId) ;
	
	/**
	 * ����������ѯ�ֵ�
	 * @param sysDict
	 * @return
	 * @throws Exception 
	 */
	public List<SysDict> searchDictList(SysDict sysDict) ;
	
	/**
	 * �����ֵ�����id�����ֵ�����
	 * @param dictTypeId
	 * @return
	 */
	public List<SysDict> searchDictListByDictTypeId(String dictTypeId);
	
	/**
	 *  �����ֵ�����id���ֵ���ˮ�Ų����ֵ����ݵ��ǲ��������ֵ䱾��
	 * @param dict
	 * @return
	 */
	public List<SysDict> searchDictListByDictTypeIdNotIncludeSelf(SysDict dict);
	
	/**
	 * ���ֵ�����
	 * @param dictFlows
	 */
	public void saveOrder(String[] dictFlows);

	/**
	 * �����ֵ�����id��ѯ���е��ֵ�
	 * @param dictTypeId �ֵ�����id
	 * @param isShowAll �Ƿ��ѯ���� true:��ѯ���� false:��ѯ���õ�
	 * @return
	 */
	List<SysDict> searchDictListAllByDictTypeId(String dictTypeId , boolean isShowAll);
}
