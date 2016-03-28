package com.pinde.sci.form.irb;

import java.io.Serializable;

public class IrbArchive implements Serializable{
	
	private static final long serialVersionUID = -5859543930500185290L;
	
	private String fileFlow;
	private String fileName;
	private String archiveDate;
	
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
	public String getArchiveDate() {
		return archiveDate;
	}
	public void setArchiveDate(String archiveDate) {
		this.archiveDate = archiveDate;
	}
	
	
	
}
