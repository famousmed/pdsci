package com.pinde.sci.form.irb;

import java.io.Serializable;


public class IrbArchiveForm implements Serializable{
	
	private static final long serialVersionUID = 4154180794289171593L;
	
	private String irbFlow;
	private String recType;
	private String date;
	private String fileFlow;
	private String url;
	private String name;
	private String id;
	
	public String getIrbFlow() {
		return irbFlow;
	}
	public void setIrbFlow(String irbFlow) {
		this.irbFlow = irbFlow;
	}
	public String getRecType() {
		return recType;
	}
	public void setRecType(String recType) {
		this.recType = recType;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getFileFlow() {
		return fileFlow;
	}
	public void setFileFlow(String fileFlow) {
		this.fileFlow = fileFlow;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}


}
