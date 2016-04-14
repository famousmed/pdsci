package com.pinde.sci.model.irb;

import java.io.Serializable;

import com.pinde.sci.model.mo.PubProj;



public class ProjInfoForm implements Serializable{
	
	private static final long serialVersionUID = -2730266631972364094L;

	private PubProj proj;

	//项目信息
	private String registCategory;
	private String isLeader;
	private String interMulCenter;
	//申办方
	private String declarerAddress;
	private String declarerZip;
	private String dLinkMan;
	private String dLinkManPhone;
	private String dLinkManEmail;
	private String isDeclare;
	
	//CRO
	private String CROName;
	private String CROLegalRepresent;
	private String CROAddress;
	private String CROZip;
	private String CROLinkMan;
	private String CROLinkManPhone;
	private String CROLinkManEmail;
	
	//研究者信息
	private String director;
	private String researcherFlow;
	private String researcherPhone;
	private String researcherEmail;
	
	//临床研究单位
	private String leaderOrg;
	private String leaderOrgLinkMan;
	private String leaderOrgLinkManPhone;
	private String leaderOrgLinkManEmail;
	
	private String leaderOrgIrbLinkMan;
	private String leaderOrgIrbLinkManPhone;
	private String leaderOrgIrbLinkManEmail;
	
	private String indication;
	
	private String info;
	private String caseCount;
	
	
	public String getCaseCount() {
		return caseCount;
	}

	public void setCaseCount(String caseCount) {
		this.caseCount = caseCount;
	}

	public String getIndication() {
		return indication;
	}

	public void setIndication(String indication) {
		this.indication = indication;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public PubProj getProj() {
		return proj;
	}

	public void setProj(PubProj proj) {
		this.proj = proj;
	}

	public String getRegistCategory() {
		return registCategory;
	}

	public void setRegistCategory(String registCategory) {
		this.registCategory = registCategory;
	}

	public String getIsLeader() {
		return isLeader;
	}

	public void setIsLeader(String isLeader) {
		this.isLeader = isLeader;
	}

	public String getInterMulCenter() {
		return interMulCenter;
	}

	public void setInterMulCenter(String interMulCenter) {
		this.interMulCenter = interMulCenter;
	}

	public String getDeclarerAddress() {
		return declarerAddress;
	}

	public void setDeclarerAddress(String declarerAddress) {
		this.declarerAddress = declarerAddress;
	}

	public String getDeclarerZip() {
		return declarerZip;
	}

	public void setDeclarerZip(String declarerZip) {
		this.declarerZip = declarerZip;
	}

	public String getdLinkMan() {
		return dLinkMan;
	}

	public void setdLinkMan(String dLinkMan) {
		this.dLinkMan = dLinkMan;
	}

	public String getdLinkManPhone() {
		return dLinkManPhone;
	}

	public void setdLinkManPhone(String dLinkManPhone) {
		this.dLinkManPhone = dLinkManPhone;
	}

	public String getdLinkManEmail() {
		return dLinkManEmail;
	}

	public void setdLinkManEmail(String dLinkManEmail) {
		this.dLinkManEmail = dLinkManEmail;
	}

	public String getCROName() {
		return CROName;
	}

	public void setCROName(String cROName) {
		CROName = cROName;
	}

	public String getCROLegalRepresent() {
		return CROLegalRepresent;
	}

	public void setCROLegalRepresent(String cROLegalRepresent) {
		CROLegalRepresent = cROLegalRepresent;
	}

	public String getCROAddress() {
		return CROAddress;
	}

	public void setCROAddress(String cROAddress) {
		CROAddress = cROAddress;
	}

	public String getCROZip() {
		return CROZip;
	}

	public void setCROZip(String cROZip) {
		CROZip = cROZip;
	}

	public String getCROLinkMan() {
		return CROLinkMan;
	}

	public void setCROLinkMan(String cROLinkMan) {
		CROLinkMan = cROLinkMan;
	}

	public String getCROLinkManPhone() {
		return CROLinkManPhone;
	}

	public void setCROLinkManPhone(String cROLinkManPhone) {
		CROLinkManPhone = cROLinkManPhone;
	}

	public String getCROLinkManEmail() {
		return CROLinkManEmail;
	}

	public void setCROLinkManEmail(String cROLinkManEmail) {
		CROLinkManEmail = cROLinkManEmail;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}
	
	public String getResearcherFlow() {
		return researcherFlow;
	}

	public void setResearcherFlow(String researcherFlow) {
		this.researcherFlow = researcherFlow;
	}

	public String getResearcherPhone() {
		return researcherPhone;
	}

	public void setResearcherPhone(String researcherPhone) {
		this.researcherPhone = researcherPhone;
	}

	public String getResearcherEmail() {
		return researcherEmail;
	}

	public void setResearcherEmail(String researcherEmail) {
		this.researcherEmail = researcherEmail;
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

	public String getLeaderOrgLinkManEmail() {
		return leaderOrgLinkManEmail;
	}

	public void setLeaderOrgLinkManEmail(String leaderOrgLinkManEmail) {
		this.leaderOrgLinkManEmail = leaderOrgLinkManEmail;
	}

	public String getLeaderOrgIrbLinkMan() {
		return leaderOrgIrbLinkMan;
	}

	public void setLeaderOrgIrbLinkMan(String leaderOrgIrbLinkMan) {
		this.leaderOrgIrbLinkMan = leaderOrgIrbLinkMan;
	}

	public String getLeaderOrgIrbLinkManPhone() {
		return leaderOrgIrbLinkManPhone;
	}

	public void setLeaderOrgIrbLinkManPhone(String leaderOrgIrbLinkManPhone) {
		this.leaderOrgIrbLinkManPhone = leaderOrgIrbLinkManPhone;
	}

	public String getLeaderOrgIrbLinkManEmail() {
		return leaderOrgIrbLinkManEmail;
	}

	public void setLeaderOrgIrbLinkManEmail(String leaderOrgIrbLinkManEmail) {
		this.leaderOrgIrbLinkManEmail = leaderOrgIrbLinkManEmail;
	}

	public String getIsDeclare() {
		return isDeclare;
	}

	public void setIsDeclare(String isDeclare) {
		this.isDeclare = isDeclare;
	}
	
	
}
