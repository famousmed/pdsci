package com.pinde.sci.form.sys;

import java.util.List;

public class SubjectForm {
	/**
	 * id�б�
	 */
	private List<String> ids;
	/**
	 * ��ѧ��id
	 */
	private String parentId;
	/**
	 * ѧ��id
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
