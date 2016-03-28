package com.pinde.sci.form.irb;

import java.io.Serializable;

public class IrbApplyFileForm implements Serializable{
	
	private static final long serialVersionUID = -8493609869069590758L;
	
	/**
	 * 附件名称
	 */
	private String fileName;
	/**
	 * 附件备注
	 */
	private String fileRemark;
	/**
	 * 文件类型
	 */
	private String fileType;
	/**
	 * 版本号
	 */
	private String version;
	/**
	 * 版本日期
	 */
	private String versionDate;
	/**
	 * 模板中file节点id属性值
	 */
	private String fileTempId;
	
	/**
	 * 文件流水号
	 */
	private String fileFlow;
	/**
	 * 是否被确认
	 */
	private boolean confirm;
	/**
	 * 修改建议
	 */
	private String suggest;
	/**
	 * 显示受理通知
	 */
	private String showNotice;
	/**
	 * 审查申请表url
	 */
	private String url;
	
	
	public String getSuggest() {
		return suggest;
	}
	public void setSuggest(String suggest) {
		this.suggest = suggest;
	}
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
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getVersionDate() {
		return versionDate;
	}
	public void setVersionDate(String versionDate) {
		this.versionDate = versionDate;
	}
	public String getFileTempId() {
		return fileTempId;
	}
	public void setFileTempId(String fileTempId) {
		this.fileTempId = fileTempId;
	}
	public String getFileFlow() {
		return fileFlow;
	}
	public void setFileFlow(String fileFlow) {
		this.fileFlow = fileFlow;
	}
	public boolean isConfirm() {
		return confirm;
	}
	public void setConfirm(boolean confirm) {
		this.confirm = confirm;
	}
	public String getShowNotice() {
		return showNotice;
	}
	public void setShowNotice(String showNotice) {
		this.showNotice = showNotice;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
}
