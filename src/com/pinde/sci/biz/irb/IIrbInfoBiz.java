package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.form.sys.SysUserForm;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;

/**
 * @Description ����ίԱ��biz
 *
 */
public interface IIrbInfoBiz {
	/**
	 * �������޸�
	 * @param info
	 * @return
	 */
	public int editInfo(IrbInfo info);
	/**
	 * ��������ѯ
	 * @param info
	 * @return
	 */
	public List<IrbInfo> queryInfo (IrbInfo info);
	/**
	 * ��������ѯ
	 * @param recordFlow
	 * @return
	 */
	public IrbInfo queryInfo(String recordFlow);
	/**
	 * ��ѯ��ѡ��Ա
	 * @param form
	 * @return
	 */
	public List<SysUser> queryIrbUser(SysUserForm form);
	/**
	 * ��ѯ��ѡ����
	 * @return
	 */
	public List<SysDept> queryIrbDept();

}
