package com.pinde.sci.model.gcp;

import com.pinde.sci.model.mo.GcpContract;

public class GcpContractExt extends GcpContract{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8363897076376176154L;

	private String deptFlow;

    private String projName;
    
    private String fileName;
    
    private String fileFlow;

	public String getDeptFlow() {
		return deptFlow;
	}

	public void setDeptFlow(String deptFlow) {
		this.deptFlow = deptFlow;
	}

	public String getProjName() {
		return projName;
	}

	public void setProjName(String projName) {
		this.projName = projName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileFlow() {
		return fileFlow;
	}

	public void setFileFlow(String fileFlow) {
		this.fileFlow = fileFlow;
	}
	
	
    
}
