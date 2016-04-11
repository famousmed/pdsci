package com.pinde.sci.biz.inx;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.inx.InxColumnExt;
import com.pinde.sci.model.mo.InxColumn;

public interface IinxColumnManageBiz {
	/**
	 * ��ȡ������Ŀ
	 * @param recordStatus ��Ŀ״̬
	 * @return
	 */
	public List<InxColumn> getAll(String recordStatus);
	/**
	 * ������Ŀ
	 * @param column
	 * @return
	 */
	public String save(InxColumn column);
	/**
	 * ������Ŀid
	 * @param parentColumnId ����Ŀid
	 * @return
	 */
	public String getNextColumnId(String parentColumnId);
	/**
	 * ��ȡ��Ŀ���������и���Ŀ
	 * @param columnId ��Ŀid
	 * @return
	 */
	public String getAllparentColumn(String columnId);
	/**
	 * ������Ŀid��ȡ��Ŀ
	 * @param columnId ��Ŀid
	 * @return
	 */
	public InxColumn getById(String columnId);
	/**
	 * ������Ŀ
	 * @param column
	 * @return
	 */
	public int update(InxColumn column);
	/**
	 * ��ȡ��Ŀ
	 * @param flow ������ˮ��
	 * @return
	 */
	public InxColumn getByFlow(String flow);
	/**
	 * ��ȡ��Ŀ��չ
	 * @param flow ������ˮ��
	 * @return
	 */
	public InxColumnExt getExtByFlow(String flow);
	/**
	 * ��ȡ����Ŀ
	 * @param columnId
	 * @return
	 */
	public List<InxColumn> queryChildColumn(String columnId);
	/**
	 * �������¼�¼״̬
	 * @param ids id�б�
	 * @param recordStatus ״̬
	 * @return
	 */
	public int updateRecordStatus(List<String> ids,String recordStatus );
	
	List<InxColumn> searchInxColumnList(Map<String, Object> paramMap);
}
