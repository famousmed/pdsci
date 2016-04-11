package com.pinde.sci.biz.pub;

import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SysUser;

public interface IPubUserResumeBiz {
	/**
	 * ��ȡ��������
	 * @param userFlow
	 * @return
	 */
	PubUserResume readPubUserResume(String userFlow);
	
	/**
	 * �����������
	 * @param userFlow
	 * @return
	 */
	int savePubUserResume(SysUser user, PubUserResume resume);
}
