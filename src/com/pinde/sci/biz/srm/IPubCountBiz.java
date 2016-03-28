package com.pinde.sci.biz.srm;


import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.AidTalents;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubProjCountExt;
import com.pinde.sci.model.srm.SrmAchCountExt;

public interface IPubCountBiz {
    
	/**
	 * �����ִ�������ͳ��
	 * @param org
	 * @return
	 */
	public List<Map<String, Integer>> selectCountProjGlobal(SysOrg org);
	/**
	 * ���ܲ��Ŵ�������ͳ��
	 * @param org
	 * @return
	 */
	public List<Map<String, Integer>> selectCountProjCharge(SysOrg org);
	/**
	 * ҽԺ��������ͳ��
	 * @param org
	 * @return
	 */
	public List<Map<String, Integer>> selectCountProjLocal(SysOrg org);
	/**
	 * ҽԺ����˳ɹ�ͳ��
	 * @param org
	 * @return
	 */
	public Map<String,Integer> selectCountSrmAchLocal(SysOrg org);
	
	/**
	 * ���ݸõ�λ����ˮ�Ų�ѯ�õ�λ�²μ������������Ŀ������
	 * @return
	 */
	public int selectProjInExpertAll();
	/**
	 * ���ݸõ�λ����ˮ�Ų�ѯ�õ�λ������ͨ������Ŀ������
	 * @return
	 */
	public int selectProjApproveAll();
	/**
	 * ���ݸõ�λ����ˮ�Ų�ѯ�õ�λ�����ͨ������Ŀ������
	 * @return
	 */
	public int selectProjNotApproveAll();
	/**
	 * ���ݸõ�λ����ˮ�Ų�ѯ�õ�λ��ͨ���걨��˵���Ŀ������
	 * @return
	 */
	public int selectProjApply();
	/**
	 * ���ݸõ�λ����ˮ�Ų�ѯ�õ�λ��ͨ�����ձ�����˵���Ŀ����
	 * @return
	 */
	public int selectProjComplete();
	/**
	 * ���ݸõ�λ����ˮ�Ų�ѯ�õ�λ��һ�����е�λ�ֱ�е�����Ŀ��
	 * @return
	 */
	public List<PubProjCountExt> selectProjGroupByOrg();
	/**
	 * ���ݸõ�λ����ˮ�Ų�ѯ�õ�λ��һ�����е�λ�ֱ�е��ĳɹ����༰����
	 * @return
	 */
	public List<SrmAchCountExt> selectSrmAchByOrg();
	/**
	 * ���ݸõ�λ����ˮ�Ų�ѯ�õ�λ��һ�����е�λ�е�ĳһ�ֳɹ�������
	 * @param table
	 * @param tableName
	 * @return
	 */
	public List<SrmAchCountExt> selectSrmAchByTypeId(String table,String tableName,Boolean sumFlag);
    /**
     * ��ѯ��ǰ��¼�������������������ص��˲ŵļ�¼
     * @param aidTalents
     * @return
     */
    public List<AidTalents> selectAidTalentsByOrg(AidTalents aidTalents);
    /**
     * ��ѯ��ǰ��¼�����������´���˵���Ա
     * @param sysUser
     * @return
     */
    public List<SysUser> selectRegedUser(SysUser sysUser);
    
    /**
     * Ժ���ѯ��Ԥ����˵���Ŀ����
     * @return
     */
    public Integer findDealBudgetAuditProjCount();
    
    /**
     * Ժ���ѯ��������˵�����
     * @return
     */
    public Integer findDealPaymentAuditCount();
}
