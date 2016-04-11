package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SysUserExt;

public interface IExpertBiz {

	/**
	 * �����û���ˮ�Ų���ר��(Ψһ)
	 * @param userFlow
	 * @return
	 */
	public SrmExpert readExpert(String userFlow);
	
	/**
	 * �޸�ר����Ϣ
	 * @param user
	 * @param expert
	 */
	int updateSysUserAndSrmExpert(SysUser user, SrmExpert expert);
	
	/**
	 * ����������ѯר��
	 * @param sysUser
	 * @param srmExpert
	 * @return
	 */
	public List<SysUser> searchExpertFormSysUser(SysUser sysUser);
	
	/**
	 * ��ѯ����ĳ�����������µ�ר�� , ��evalSetFlowΪnull����""ʱ  ��ѯ����ר��
	 * @param evalSetFlow
	 * @return
	 */
	public List<SysUserExt> searchExpertNotInEvalSetByEvalSetFlow(String evalSetFlow);

	/**
	 * ��ѯ��ˮ��ר���б�
	 * @param expertFlowList
	 * @return
	 */
	List<SrmExpert> searchExpertList(List<String> userFlowList);
	
	void addOrModifyExpertByUserFlow(SrmExpert expert);

}
