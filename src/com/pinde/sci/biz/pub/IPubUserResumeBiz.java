package com.pinde.sci.biz.pub;

import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SysUser;

public interface IPubUserResumeBiz {
	/**
	 * 获取个人履历
	 * @param userFlow
	 * @return
	 */
	PubUserResume readPubUserResume(String userFlow);
	
	/**
	 * 保存个人履历
	 * @param userFlow
	 * @return
	 */
	int savePubUserResume(SysUser user, PubUserResume resume);
}
