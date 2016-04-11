package com.pinde.sci.biz.jszy;

import java.util.List;

import com.pinde.sci.form.jszy.ExtInfoForm;
import com.pinde.sci.form.jszy.SingUpForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.SysDict;

public interface JszyDoctorSingupBiz {

	/**
	 * 提交基础信息
	 * @param form
	 */
	public void submitSingup(SingUpForm form);
	
	/**
	 * 提交志愿信息
	 * @param recruit
	 */
	public void submitRecruit(ResDoctorRecruitWithBLOBs recruit);

	/**
	 * 包装额外信息xml为form对象
	 * @param extInfoXml
	 * @return
	 */
	ExtInfoForm parseExtInfoXml(String extInfoXml);
	
	/**
	 * 根据专业类别查询具体专业
	 * @param catSpeId
	 * @return
	 */
	public List<SysDict> findSpe(String catSpeId);
	
	public void saveRecruit(ResDoctorRecruitWithBLOBs recruit);
	
	/**
	 * 修改doctor
	 * @param doctor
	 */
	public void modDoctorByDoctorFlow(ResDoctor doctor);
	
}
