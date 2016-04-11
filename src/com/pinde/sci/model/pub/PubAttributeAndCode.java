package com.pinde.sci.model.pub;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.PubAttrCode;
import com.pinde.sci.model.mo.PubAttribute;

public class PubAttributeAndCode implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4087566356004149783L;
	private PubAttribute attr;
	private List<PubAttrCode> attrCodeList;

	public PubAttribute getAttr() {
		return attr;
	}

	public void setAttr(PubAttribute attr) {
		this.attr = attr;
	}

	public List<PubAttrCode> getAttrCodeList() {
		return attrCodeList;
	}

	public void setAttrCodeList(List<PubAttrCode> attrCodeList) {
		this.attrCodeList = attrCodeList;
	}
}
