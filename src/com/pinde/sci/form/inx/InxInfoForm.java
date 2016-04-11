package com.pinde.sci.form.inx;

import java.util.List;

public class InxInfoForm {
	/**
	 * 记录状态
	 */
	private String recordStatus;
	/**
	 * 所属栏目id
	 */
	private String columnId;
	/**
	 * 标题
	 */
	private String infoTitle;
	/**
	 * 关键字
	 */
	private String infoKeyword;
	/**
	 * 分页开始索引
	 */
	private String startIndex;
	/**
	 * 分页结束索引
	 */
	private String endIndex;
	/**
	 * 内容
	 */
	private String content;
	/**
	 * 开始日期
	 */
	private String startDate;
	/**
	 * 结束日期
	 */
	private String endDate;
	/**
	 * 是否有图片 Y：有，N 没有
	 */
	private String hasImage;
	/**
	 * 流水号列表
	 */
	private List<String> infoFlows;
	/**
	 * 资讯审核状态id
	 */
	private String infoStatusId;
	/**
	 * 资讯审核状态名称
	 */
	private String infoStatusName;
	/**
	 * 按浏览量排行
	 */
	private String orderByViewNum;
	/**
	 * 是否带大字段
	 */
	private String isWithBlobs;
	
	
	
	public InxInfoForm() {}

	
	public InxInfoForm(String columnId, String startIndex, String endIndex) {
		this.columnId = columnId;
		this.startIndex = startIndex;
		this.endIndex = endIndex;
	}


	public InxInfoForm(String columnId, String infoTitle, String startIndex,
			String endIndex, String startDate, String endDate) {
		this.columnId = columnId;
		this.infoTitle = infoTitle;
		this.startIndex = startIndex;
		this.endIndex = endIndex;
		this.startDate = startDate;
		this.endDate = endDate;
	}


	public String getRecordStatus() {
		return recordStatus;
	}
	public void setRecordStatus(String recordStatus) {
		this.recordStatus = recordStatus;
	}
	public String getColumnId() {
		return columnId;
	}
	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}
	public String getInfoTitle() {
		return infoTitle;
	}
	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}
	public String getInfoKeyword() {
		return infoKeyword;
	}
	public void setInfoKeyword(String infoKeyword) {
		this.infoKeyword = infoKeyword;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}


	public String getStartDate() {
		return startDate;
	}


	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}


	public String getEndDate() {
		return endDate;
	}


	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}


	public String getHasImage() {
		return hasImage;
	}


	public void setHasImage(String hasImage) {
		this.hasImage = hasImage;
	}


	public List<String> getInfoFlows() {
		return infoFlows;
	}


	public void setInfoFlows(List<String> infoFlows) {
		this.infoFlows = infoFlows;
	}


	public String getInfoStatusId() {
		return infoStatusId;
	}


	public void setInfoStatusId(String infoStatusId) {
		this.infoStatusId = infoStatusId;
	}


	public String getInfoStatusName() {
		return infoStatusName;
	}


	public void setInfoStatusName(String infoStatusName) {
		this.infoStatusName = infoStatusName;
	}


	public String getOrderByViewNum() {
		return orderByViewNum;
	}


	public void setOrderByViewNum(String orderByViewNum) {
		this.orderByViewNum = orderByViewNum;
	}


	public String getIsWithBlobs() {
		return isWithBlobs;
	}


	public void setIsWithBlobs(String isWithBlobs) {
		this.isWithBlobs = isWithBlobs;
	}
	
}
