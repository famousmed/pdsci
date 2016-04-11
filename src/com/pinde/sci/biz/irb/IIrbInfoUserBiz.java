package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.model.irb.IrbInfoUserExt;
import com.pinde.sci.model.mo.IrbInfoUser;

/**
 * @Description ����ίԱ���Աbiz
 *
 */
public interface IIrbInfoUserBiz {
	/**
	 * ��ӻ��޸�
	 * @param user
	 * @return
	 */
	public int edit(IrbInfoUser user);
	/**
	 * ������ӻ��޸�
	 * @param users
	 */
	public void editUsers(List<IrbInfoUser> users);
	/**
	 * ��ѯ
	 * @param user
	 * @return
	 */
	public List<IrbInfoUser> queryUserList(IrbInfoUser user);
	/**
	 * ɾ��
	 * @param user
	 * @return
	 */
	public int delete(IrbInfoUser user);
	/**
	 * ��ѯ��չ
	 * @param user
	 * @return
	 */
	public List<IrbInfoUserExt> queryUserExtList(IrbInfoUser user);
	/**
	 * ����������
	 * @param flow
	 * @return
	 */
	public IrbInfoUser queryUserByFlow(String flow);
	public void saveOrder(String[] userFlow,String irbInfoFlow);
	
}
