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
	 * ����doctorFlow��ѯ
	 *
	 */
	ResDoctorRecruit readResDoctorRecruit(String recruitFlow);

	/**
	 * ��ѯ��ǰ�����µ�ҽʦ
	 *
	 */
	List<JsResDoctorRecruitExt> resDoctorRecruitExtList(ResDoctorRecruit resDoctorRecruit,SysUser user);
	
	/**
	 * ����
	 * @param doctorRecruit
	 * @return
	 */
	int saveDoctorRecruit(ResDoctorRecruitWithBLOBs doctorRecruitWithBLOBs);
	
	/**
	 * ��ѯ
	 * @param recruit
	 * @return
	 */
	List<ResDoctorRecruit> searchResDoctorRecruitList(ResDoctorRecruit recruit);
}
