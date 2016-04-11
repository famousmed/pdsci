package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubAttrCode;
import com.pinde.sci.model.mo.PubAttrCodeExample;
import com.pinde.sci.model.mo.PubAttribute;



public interface IAttrCodeBiz {
	List<PubAttrCode> searchAttrCodeList(PubAttrCodeExample example);
	
	
	List<PubAttrCode> searchAttrCodeList(String moduleCode,String elementCode);


	void addAttrCode(PubAttribute attr ,List<PubAttrCode> attrCodeList);
	void addAttrCodeList(List<PubAttrCode> attrCodeList);


	List<PubAttrCode> searchAttrCodeListByAttrCode(String attrCode);

 
	void deleteAttrCode(String codeFlow);

 
	void deleteAttrCode(List<PubAttrCode> codeList);


	void add(PubAttrCode attrCode);


	void modify(PubAttrCode attrCode);
 

	 
} 
 