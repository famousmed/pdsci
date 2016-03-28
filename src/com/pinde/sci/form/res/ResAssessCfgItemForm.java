package com.pinde.sci.form.res;

import java.io.Serializable;

public class ResAssessCfgItemForm implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5631934038390814967L;
	
	private String id;
	private String name;
	private String score;
	
	private String titleId;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getTitleId() {
		return titleId;
	}
	public void setTitleId(String titleId) {
		this.titleId = titleId;
	}
}
