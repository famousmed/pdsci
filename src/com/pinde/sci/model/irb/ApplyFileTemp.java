package com.pinde.sci.model.irb;

import java.io.Serializable;

/**
 * @Description 模板文件字段封装
 *
 */
public class ApplyFileTemp implements Serializable{
	
	private static final long serialVersionUID = 8346266871615460662L;
	
	/**
	 *送审文件类型
	 */
	private String irbType;
	/**
	 * 子类型
	 */
	private String pjType;
	/**
	 * 文件名称
	 */
	private String name;
	/**
	 * 文件类型：方案/知情同意
	 */
	private String fileType;
	/**
	 * 是否有版本号
	 */
	private String version;
	/**
	 * 是否有版本日期
	 */
	private String versionDate;
	/**
	 * 唯一号
	 */
	private String id;
	/**
	 * 受理通知是否显示
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
