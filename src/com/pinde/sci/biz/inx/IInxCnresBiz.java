package com.pinde.sci.biz.inx;

import com.pinde.sci.model.mo.SysUser;

public interface IInxCnresBiz {
	/**
	 * 学生注册
	 * @return
	 */
	int registerUser(SysUser user);
	/**
	 * 发送注册激活邮件
	 * @param userEmail
	 * @param userFlow
	 */
	void sendEmail(String userEmail,String userFlow);
	/**
	 * 忘记密码发送邮件
	 * @param userEmail
	 * @param userCode
	 */
	void sendResetPassEmail(String userEmail, String userFlow);
}
