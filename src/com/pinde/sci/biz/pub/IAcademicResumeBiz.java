package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.form.pub.AcademicResumeForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SysUser;

public interface IAcademicResumeBiz {	
	
	/**
	 * ��ȡȫ��ѧ����ְ
	 * @throws Exception 
	 */
	List<AcademicResumeForm> queryAcademicList(PubUserResume resume) throws Exception;
	
	/**
	 * ��ȡһ��ѧ����ְ
	 * @throws Exception 
	 */
	AcademicResumeForm getAcademicResumeByRecordId(String userFlow, String recordId) throws Exception;
	/**
	 * ����ѧ����ְ
	 * @param form
	 * @return
	 * @throws Exception 
	 */
	int saveAcademicResume(SysUser user, AcademicResumeForm form) throws Exception;
	
	/**
	 * ɾ��һ��ѧ����ְ
	 * @param recordId
	 * @return
	 * @throws Exception 
	 */
	int delAcademicResumeByRecordId(String userFlow, String recordId) throws Exception;
	
}
