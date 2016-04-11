package com.pinde.sci.form.pub;

import java.io.Serializable;

public class ProjFileForm implements Serializable{
	
	private static final long serialVersionUID = 1683056837776219802L;
	
	private String fileFlow;
	private String fileName;
	private String isShared;
	public String getFileFlow() {
		return fileFlow;
	}
	public void setFileFlow(String fileFlow) {
		this.fileFlow = fileFlow;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getIsShared() {
		return isShared;
	}
	public void setIsShared(String isShared) {
		this.isShared = isShared;
	}
}
