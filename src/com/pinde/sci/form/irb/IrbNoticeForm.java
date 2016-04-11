package com.pinde.sci.form.irb;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.irb.ApplyFileTemp;

public class IrbNoticeForm implements Serializable{
	
	private static final long serialVersionUID = -701605522834614175L;
	/**
	 * 未提交文件
	 */
	private List<ApplyFileTemp> applyFiles;
	/**
	 * 需修改文件
	 */
	private List<IrbApplyFileForm> modifyFiles;
	/**
	 * 对应的apply
	 */
	private String irbFlow;
	
	
	

	public String getIrbFlow() {
		return irbFlow;
	}
	public void setIrbFlow(String irbFlow) {
		this.irbFlow = irbFlow;
	}
	public List<ApplyFileTemp> getApplyFiles() {
		return applyFiles;
	}
	public void setApplyFiles(List<ApplyFileTemp> applyFiles) {
		this.applyFiles = applyFiles;
	}
	public List<IrbApplyFileForm> getModifyFiles() {
		return modifyFiles;
	}
	public void setModifyFiles(List<IrbApplyFileForm> modifyFiles) {
		this.modifyFiles = modifyFiles;
	}
	
}
