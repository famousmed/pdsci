package com.pinde.sci.biz.sys;

import java.util.List;

import com.pinde.sci.model.mo.SysSubjCode;

/**
 * @author huangfei
 * ѧ�ƴ���service
 */
public interface ISubjectBiz {
    
    /**
     * ��ȡ����ѧ�ƴ���
     * @param recordStatus ���ñ�־ Y ���ã�N ͣ��
     * @return 
     */
    public 	List<SysSubjCode> getAll(String recordStatus);
    /**
     * ����ѧ�ƴ���
     * @param subject
     * @return
     */
    public int save(SysSubjCode subject);
    /**
     * ������������ͣ��״̬
     * @param ids id�б�
     * @return
     */
    public int updateByIds(List<String>ids);
    /**
     * ����ѧ�ƴ���
     * @param subject
     * @return
     */
    public int update(SysSubjCode subject);
    /**
     * ����������ȡѧ�ƴ���
     * @param flow
     * @return
     */
    public SysSubjCode getByFlow(String flow);
    /**
     * ����id��ȡѧ�ƴ���
     * @param id
     * @return
     */
    public SysSubjCode getById(String id);
    /**
     * ���¸�ѧ����������ѧ�Ƶĸ�ѧ��id
     * @param id �¸�ѧ��id
     * @param parentId ԭ��ѧ��id
     * @return
     */
    public int updateParentId(String id,String parentId);
}
