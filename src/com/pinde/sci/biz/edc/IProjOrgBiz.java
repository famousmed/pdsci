package com.pinde.sci.biz.edc;

import java.util.List;

import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.PubProjOrg;

public interface IProjOrgBiz {
	
	public List<PubProjOrg> search(String projFlow);

	public PubProjOrg read(String recordFlow);

	public void add(PubProjOrg projOrg);

	public void mod(PubProjOrg projOrg);

	public void del(PubProjOrg projOrg);

	public List<PubProjOrg> searchProjOrg(String projFlow);

	public PubProjOrg readProjOrg(String projFlow, String orgFlow);

	public EdcProjOrg readEdcProjOrg(String projFlow, String orgFlow);

	void addProjOrg(PubProjOrg projOrg);

	int saveProjOrgLock(EdcProjOrg edcProjOrg);
	/**
	 * ÅúÁ¿É¾³ý
	 * @param recordFlow
	 * @return
	 */
	int delProjOrgByRecordFlows(List<String> recordFlowList);

	List<PubProjOrg> searchProjOrg(PubProjOrg projOrg);
	 
}
