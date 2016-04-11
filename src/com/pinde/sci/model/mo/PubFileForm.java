package com.pinde.sci.model.mo;

import org.springframework.web.multipart.MultipartFile;

public class PubFileForm {
	private  String fileName;
	private  String fileRemark;
	
	public MultipartFile file;
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRemark() {
		return fileRemark;
	}
	public void setFileRemark(String fileRemark) {
		this.fileRemark = fileRemark;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
}
