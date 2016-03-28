package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.edc.PubModuleForm;
import com.pinde.sci.model.mo.PubModule;
import com.pinde.sci.model.mo.PubModuleExample;



public interface IModuleBiz {
	List<PubModule> searchModuleList(PubModuleExample example);
	
	PubModule readPubModule(String flow);
	
	PubModule readPubModuleByCode(String code);

	PubModuleForm getModuleForm(String moduleCode);

	List<PubModule> moduleSearch(String keyword); 
	
	//ÐÂÔö
	int addPubModule(PubModule pm);
	
	//ÐÞ¸Ä
	int updatePubModule(PubModule pm);

	List<PubModule> searchModuleListByDomain(String domain);
}   
 