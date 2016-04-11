package com.pinde.sci.biz.edc;

import java.util.List;

import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubProjUserExt;

public interface IProjUserBiz {
	
	public List<PubProjUser> search(PubProjUser pubProjUser);

	public PubProjUser read(String recordFlow);

	public void add(PubProjUser projUser);

	public void mod(PubProjUser projUser);

	public void del(PubProjUser projUser);

	public void saveAllot(String projFlow,String userFlow,String orgFlow,String wsId, String[] roleFlows);

	public void addUserWithRole(SysUser user, String projFlow, String[] roleFlow,String wsId);
	/**
	 * 
	 * @param projUser
	 * @return
	 */
	int editUser(PubProjUser projUser);
	List<PubProjUserExt> search(PubProjUserExt pubProjUserExt);
}
