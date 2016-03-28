package com.pinde.sci.form.gcp;

import org.springframework.web.multipart.MultipartFile;

public class GcpMeetingFileForm {
	private String id;
	private String fileName;
	private String fileFlow;
	private MultipartFile file;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileFlow() {
		return fileFlow;
	}
	public void setFileFlow(String fileFlow) {
		this.fileFlow = fileFlow;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
}
