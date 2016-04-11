package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.form.pub.EduResumeForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SysUser;

public interface IEduResumeBiz {	
	/**
	 * �����������
	 * @param resume
	 * @return
	 * @throws Exception 
	 */
	int saveEduResume(SysUser user, EduResumeForm form) throws Exception;
	
	/**
	 * ��ȡȫ����������
	 * @param resume
	 * @return
	 * @throws Exception 
	 */
	List<EduResumeForm> queryEduResumeList(PubUserResume resume) throws Exception;
	
	/**
	 * ��ȡһ��������¼
	 * @param recordId
	 * @throws Exception 
	 */
	EduResumeForm getEduResumeByRecordId(String userFlow, String recordId) throws Exception;
	
	/**
	 * ɾ��һ����������
	 * @param recordId
	 * @return
	 * @throws Exception 
	 */
	int delEduResumeByRecordId(String userFlow, String recordId) throws Exception;
}
