package com.pinde.sci.model.irb;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.pinde.sci.model.mo.PubProjOrg;

public class ProjOrgForm implements Serializable{
	
	private static final long serialVersionUID = 7369349189488423572L;
	
	private List<PubProjOrg> projOrgList = new ArrayList<PubProjOrg>();
	private String leaderOrg;
	private String leaderOrgLinkMan;
	private String leaderOrgLinkManPhone;

	public List<PubProjOrg> getProjOrgList() {
		return projOrgList;
	}

	public void setProjOrgList(List<PubProjOrg> projOrgList) {
		this.projOrgList = projOrgList;
	}

	public String getLeaderOrg() {
		return leaderOrg;
	}

	public void setLeaderOrg(String leaderOrg) {
		this.leaderOrg = leaderOrg;
	}

	public String getLeaderOrgLinkMan() {
		return leaderOrgLinkMan;
	}

	public void setLeaderOrgLinkMan(String leaderOrgLinkMan) {
		this.leaderOrgLinkMan = leaderOrgLinkMan;
	}

	public String getLeaderOrgLinkManPhone() {
		return leaderOrgLinkManPhone;
	}

	public void setLeaderOrgLinkManPhone(String leaderOrgLinkManPhone) {
		this.leaderOrgLinkManPhone = leaderOrgLinkManPhone;
	}
}
