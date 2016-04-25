package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubPatientWindow;


public interface IPubPatientWindowBiz {

	int savePatientWindow(PubPatientWindow patientWindow);

	List<PubPatientWindow> searchPatientWindowList(PubPatientWindow window);

	PubPatientWindow searchPatientWindow(String patientFlow, String visitFlow);

	PubPatientWindow readPatientWindow(String recordFlow);

	List<PubPatientWindow> searchPatientWindowByPatientFlows(String projFlow,
			List<String> patientFlows);

	int savePatientWindow(String projFlow, String patientFlow, String visitFlow);

	PubPatientWindow readPatientWindow(String patientFlow, String visitFlow);

	List<PubPatientWindow> searchRemaind(String projFlow, String orgFlow);

	List<PubPatientWindow> searchPatientWindowByPatientFlows(String projFlow,
			String patientFlow); 

}  
  