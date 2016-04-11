package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.pub.PubProjUserExt;

public interface IPubProjUserBiz {
	/**
	 * �������޸�
	 * @param user
	 * @return
	 */
	public int edit(PubProjUser user);
	/**
	 * �����������޸�
	 * @param users
	 */
	public void editUsers(List<PubProjUser> users);

	/**
	 * ��ѯ��չ�б�
	 * @param pubProjUserExt
	 * @return
	 */
	public List<PubProjUserExt> queryExtList(PubProjUserExt pubProjUserExt);
	void saveProjUserOrder(String[] recordFlow);
}
