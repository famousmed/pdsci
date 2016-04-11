package com.pinde.sci.biz.sczyres;

import com.pinde.sci.model.mo.SysUser;

public interface InxBiz {

	
	public SysUser login(String userCode , String passwd);		
	
	public void regist(SysUser user);
	
	public void reSendEmail(String userFlow , String userEmail);
	
	public void activateUser(String userFlow);
 
	void registSczy(SysUser user);

	public void sendResetPassEmail(String userEmail, String userFlow);
}
