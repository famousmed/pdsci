package com.pinde.sci.biz.jsres;

import java.util.List;

import com.pinde.sci.model.jsres.JsResDoctorRecruitExt;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.SysUser;

/**
 * @author tiger
 *
 */
public interface IJsResDoctorRecruitBiz {
	/**
	 * 根据doctorFlow查询
	 *
	 */
	ResDoctorRecruit readResDoctorRecruit(String recruitFlow);

	/**
	 * 查询当前机构下的医师
	 *
	 */
	List<JsResDoctorRecruitExt> resDoctorRecruitExtList(ResDoctorRecruit resDoctorRecruit,SysUser user);
	
	/**
	 * 保存
	 * @param doctorRecruit
	 * @return
	 */
	int saveDoctorRecruit(ResDoctorRecruitWithBLOBs doctorRecruitWithBLOBs);
	
	/**
	 * 查询
	 * @param recruit
	 * @return
	 */
	List<ResDoctorRecruit> searchResDoctorRecruitList(ResDoctorRecruit recruit);
}
