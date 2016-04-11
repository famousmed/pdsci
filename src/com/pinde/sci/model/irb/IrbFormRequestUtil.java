package com.pinde.sci.model.irb;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class IrbFormRequestUtil implements Serializable{
	
	private static final long serialVersionUID = -5028190301142088428L;
	
	private Map<String,String>  versionMap = new HashMap<String, String>();
	private Map<String,List<IrbSingleForm>> formTypeMap = new HashMap<String, List<IrbSingleForm>>();
	private Map<String,Map<String,IrbSingleForm>> formMap = new HashMap<String, Map<String,IrbSingleForm>>();
	
	

	public Map<String, String> getVersionMap() {
		return versionMap;
	}

	public void setVersionMap(Map<String, String> versionMap) {
		this.versionMap = versionMap;
	}


	public Map<String, List<IrbSingleForm>> getFormTypeMap() {
		return formTypeMap;
	}

	public void setFormTypeMap(Map<String, List<IrbSingleForm>> formTypeMap) {
		this.formTypeMap = formTypeMap;
	}

	public Map<String, Map<String, IrbSingleForm>> getFormMap() {
		return formMap;
	}

	public void setFormMap(Map<String, Map<String, IrbSingleForm>> formMap) {
		this.formMap = formMap;
	}

	@Override
	public String toString() {
		System.out.println(versionMap);
		System.out.println(formTypeMap);
		System.out.println(formMap);
		return null;
	}
}
