package com.pinde.sci.form.irb;

import java.io.Serializable;

public class IrbApplyFileForm implements Serializable{
	
	private static final long serialVersionUID = -8493609869069590758L;
	
	/**
	 * ��������
	 */
	private String fileName;
	/**
	 * ������ע
	 */
	private String fileRemark;
	/**
	 * �ļ�����
	 */
	private String fileType;
	/**
	 * �汾��
	 */
	private String version;
	/**
	 * �汾����
	 */
	private String versionDate;
	/**
	 * ģ����file�ڵ�id����ֵ
	 */
	private String fileTempId;
	
	/**
	 * �ļ���ˮ��
	 */
	private String fileFlow;
	/**
	 * �Ƿ�ȷ��
	 */
	private boolean confirm;
	/**
	 * �޸Ľ���
	 */
	private String suggest;
	/**
	 * ��ʾ����֪ͨ
	 */
	private String showNotice;
	/**
	 * ��������url
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
