package com.pinde.sci.biz.sys;

import java.util.List;

import com.pinde.sci.model.mo.SysSubjCode;

/**
 * @author huangfei
 * 学科代码service
 */
public interface ISubjectBiz {
    
    /**
     * 获取所有学科代码
     * @param recordStatus 启用标志 Y 启用，N 停用
     * @return 
     */
    public 	List<SysSubjCode> getAll(String recordStatus);
    /**
     * 新增学科代码
     * @param subject
     * @return
     */
    public int save(SysSubjCode subject);
    /**
     * 批量更新启用停用状态
     * @param ids id列表
     * @return
     */
    public int updateByIds(List<String>ids);
    /**
     * 更新学科代码
     * @param subject
     * @return
     */
    public int update(SysSubjCode subject);
    /**
     * 根据主键获取学科代码
     * @param flow
     * @return
     */
    public SysSubjCode getByFlow(String flow);
    /**
     * 根据id获取学科代码
     * @param id
     * @return
     */
    public SysSubjCode getById(String id);
    /**
     * 更新父学科下所有子学科的父学科id
     * @param id 新父学科id
     * @param parentId 原父学科id
     * @return
     */
    public int updateParentId(String id,String parentId);
}
