package com.pinde.sci.biz.inx;

import com.pinde.sci.model.mo.SysUser;

public interface IInxNjmuEduBiz {
	/**
	 * ѧ��ע��
	 * @return
	 */
	int registerUser(SysUser user);
	/**
	 * ����ע�ἤ���ʼ�
	 * @param userEmail
	 * @param userFlow
	 */
	void sendEmail(String userEmail,String userFlow);
}
