package com.pinde.sci.biz.jszy;

import java.util.List;

import com.pinde.sci.form.jszy.ExtInfoForm;
import com.pinde.sci.form.jszy.SingUpForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.SysDict;

public interface JszyDoctorSingupBiz {

	/**
	 * �ύ������Ϣ
	 * @param form
	 */
	public void submitSingup(SingUpForm form);
	
	/**
	 * �ύ־Ը��Ϣ
	 * @param recruit
	 */
	public void submitRecruit(ResDoctorRecruitWithBLOBs recruit);

	/**
	 * ��װ������ϢxmlΪform����
	 * @param extInfoXml
	 * @return
	 */
	ExtInfoForm parseExtInfoXml(String extInfoXml);
	
	/**
	 * ����רҵ����ѯ����רҵ
	 * @param catSpeId
	 * @return
	 */
	public List<SysDict> findSpe(String catSpeId);
	
	public void saveRecruit(ResDoctorRecruitWithBLOBs recruit);
	
	/**
	 * �޸�doctor
	 * @param doctor
	 */
	public void modDoctorByDoctorFlow(ResDoctor doctor);
	
}
