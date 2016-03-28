package com.pinde.sci.form.sys;

import java.util.List;

public class SubjectForm {
	/**
	 * id列表
	 */
	private List<String> ids;
	/**
	 * 父学科id
	 */
	private String parentId;
	/**
	 * 学科id
	 */
	private String id;

	public List<String> getIds() {
		return ids;
	}

	public void setIds(List<String> ids) {
		this.ids = ids;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
}
