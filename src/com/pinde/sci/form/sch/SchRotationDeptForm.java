package com.pinde.sci.form.sch;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationGroup;

public class SchRotationDeptForm implements Serializable{
	
	private static final long serialVersionUID = 3862460508039897169L;
	
	private List<SchRotationDept> rotationDeptList;
	private SchRotationGroup rotationGroup;
	
	public List<SchRotationDept> getRotationDeptList() {
		return rotationDeptList;
	}
	public void setRotationDeptList(List<SchRotationDept> rotationDeptList) {
		this.rotationDeptList = rotationDeptList;
	}
	public SchRotationGroup getRotationGroup() {
		return rotationGroup;
	}
	public void setRotationGroup(SchRotationGroup rotationGroup) {
		this.rotationGroup = rotationGroup;
	}
}
