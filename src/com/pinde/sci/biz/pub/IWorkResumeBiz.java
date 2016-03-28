package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.form.pub.WorkResumeForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SysUser;

public interface IWorkResumeBiz {	
	/**
	 * ��ȡȫ����������
	 * @param resume
	 * @return
	 * @throws Exception
	 */
	List<WorkResumeForm> queryWorkList(PubUserResume resume) throws Exception;
	
	/**
	 * ��ȡһ����������
	 * @param recordId
	 * @return
	 * @throws Exception 
	 */
	WorkResumeForm getWorkResumeByRecordId(String userFlow, String recordId) throws Exception;
	
	/**
	 * ���湤������
	 * @param form
	 * @return
	 * @throws Exception 
	 */
	int saveWorkResume(SysUser user, WorkResumeForm form) throws Exception;
	
	/**
	 * ɾ��һ����������
	 * @param recordId
	 * @return
	 * @throws Exception 
	 */
	int delWorkResumeByRecordId(String userFlow, String recordId) throws Exception;
}
