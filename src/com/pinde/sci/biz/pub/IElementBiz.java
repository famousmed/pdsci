package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubElement;
import com.pinde.sci.model.mo.PubElementExample;



public interface IElementBiz {
	List<PubElement> searchElementList(PubElementExample example);
	
	List<PubElement> searchElementList(String moduleCode);
	
	PubElement readPubElement(String flow); 

	PubElement readPubElementByCode(String elementCode);

	
	//根据元素流水号修改元素
	void updatePubElementByFlow(PubElement element);
	//根据元素代码修改元素
	void updatePubElementByCode(PubElement element);
	
	void saveElementOrder(String [] elementFlow);
 
	void addElement(PubElement element, boolean addValFlag,
			boolean addUnitFlag, boolean addAbnormalFlag, String moduleTypeId);
	
	//元素复制
	void copyElement(PubElement element);
	
} 
 