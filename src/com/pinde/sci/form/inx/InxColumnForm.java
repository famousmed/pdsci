package com.pinde.sci.form.inx;

public class InxColumnForm {
	/**
	 * ��Ŀ����
	 */
	private String columnName;
	/**
	 * ������Ŀid
	 */
	private String parentColumnId;
	/**
	 * ��ҳ��ʼ����
	 */
	private String startIndex;
	/**
	 * ��ҳ��������
	 */
	private String endIndex;
	/**
	 * ��ˮ��
	 */
	private String columnFlow;
	
	
	
	public InxColumnForm() {
	}
	
	public InxColumnForm(String columnName, String parentColumnId,
			String startIndex, String endIndex) {
		this.columnName = columnName;
		this.parentColumnId = parentColumnId;
		this.startIndex = startIndex;
		this.endIndex = endIndex;
	}

	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getParentColumnId() {
		return parentColumnId;
	}
	public void setParentColumnId(String parentColumnId) {
		this.parentColumnId = parentColumnId;
	}
	public String getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(String startIndex) {
		this.startIndex = startIndex;
	}
	public String getEndIndex() {
		return endIndex;
	}
	public void setEndIndex(String endIndex) {
		this.endIndex = endIndex;
	}

	public String getColumnFlow() {
		return columnFlow;
	}

	public void setColumnFlow(String columnFlow) {
		this.columnFlow = columnFlow;
	}
	
}
