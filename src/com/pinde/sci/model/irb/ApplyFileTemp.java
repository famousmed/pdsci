package com.pinde.sci.model.irb;

import java.io.Serializable;

/**
 * @Description ģ���ļ��ֶη�װ
 *
 */
public class ApplyFileTemp implements Serializable{
	
	private static final long serialVersionUID = 8346266871615460662L;
	
	/**
	 *�����ļ�����
	 */
	private String irbType;
	/**
	 * ������
	 */
	private String pjType;
	/**
	 * �ļ�����
	 */
	private String name;
	/**
	 * �ļ����ͣ�����/֪��ͬ��
	 */
	private String fileType;
	/**
	 * �Ƿ��а汾��
	 */
	private String version;
	/**
	 * �Ƿ��а汾����
	 */
	private String versionDate;
	/**
	 * Ψһ��
	 */
	private String id;
	/**
	 * ����֪ͨ�Ƿ���ʾ
	 */
	private String showNotice;
	
	
	public String getShowNotice() {
		return showNotice;
	}
	public void setShowNotice(String showNotice) {
		this.showNotice = showNotice;
	}
	public String getIrbType() {
		return irbType;
	}
	public void setIrbType(String irbType) {
		this.irbType = irbType;
	}
	public String getPjType() {
		return pjType;
	}
	public void setPjType(String pjType) {
		this.pjType = pjType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
