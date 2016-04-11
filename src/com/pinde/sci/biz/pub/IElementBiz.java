package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubElement;
import com.pinde.sci.model.mo.PubElementExample;



public interface IElementBiz {
	List<PubElement> searchElementList(PubElementExample example);
	
	List<PubElement> searchElementList(String moduleCode);
	
	PubElement readPubElement(String flow); 

	PubElement readPubElementByCode(String elementCode);

	
	//����Ԫ����ˮ���޸�Ԫ��
	void updatePubElementByFlow(PubElement element);
	//����Ԫ�ش����޸�Ԫ��
	void updatePubElementByCode(PubElement element);
	
	void saveElementOrder(String [] elementFlow);
 
	void addElement(PubElement element, boolean addValFlag,
			boolean addUnitFlag, boolean addAbnormalFlag, String moduleTypeId);
	
	//Ԫ�ظ���
	void copyElement(PubElement element);
	
} 
 