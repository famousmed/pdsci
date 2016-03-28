package com.pinde.sci.common;


import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.dom4j.Element;

import com.pinde.core.exception.GeneralException;
import com.pinde.core.util.XmlParse;

public class ProjPageCfgParse extends XmlParse{

	public ProjPageCfgParse(File xml) throws GeneralException {
		super(xml);
	}

	
	public Map<String , Map<String , String>> parseProductConfig() throws Exception{
		Map<String , Map<String , String>> result = new HashMap<String , Map<String , String>>();
		Element rootEle = this.getRootElement();
		Iterator iterator = rootEle.elementIterator();
		while(iterator.hasNext()){
			Element ele = (Element)iterator.next();
			String eleName = ele.getName();
			Iterator projTypeIterator = ele.elementIterator("projType");
			Map<String , String> childMap = new HashMap<String , String>();
			while(projTypeIterator.hasNext()){
				Element projTypeEle = (Element)projTypeIterator.next();
				String id = projTypeEle.attributeValue("id");
				String pageGroupName = projTypeEle.attributeValue("pageGroupName");
				childMap.put(id, pageGroupName);
				
			}
			result.put(eleName, childMap);
		}
		return result;
	}

}
