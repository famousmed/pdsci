package com.pinde.sci.biz.pub;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.PubTrain;
import com.pinde.sci.model.mo.PubTrainUser;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;

public interface IPubTrainUserBiz {
	/**
	 * ��ѯͬ������ѵ��Ա
	 * @param orgFlow
	 * @return
	 */
	List<SysUser> queryUserListFromSysUser(String orgFlow,String deptFlow);
	
	/**
	 * ��ѯ��ѵ��Ա
	 * @param trainFlow
	 */
	List<PubTrainUser> queryTrainUserList(PubTrainUser trainUser);
	
	/**
	 * ������޸���ѵ��Ա
	 * @param user
	 * @return
	 */
	int editUser(PubTrainUser user);
	/**
	 * ������ѵ��Ա�ļ�
	 * @param files
	 * @param userFlows
	 */
	String saveFiles(List<MultipartFile> filesList, String[] recordFlows,String[] fileNos);
	
	/**
	 * ��ѯ����
	 * @return
	 */
	List<SysDept> queryIrbDept();
	/**
	 * ��������ѯ��ѵ��Ա��¼��
	 * @param trainUser
	 * @return
	 */
	long queryTrainUserCount(PubTrainUser trainUser);

	int saveTrainUser(String[] userFlows, PubTrain train);

}
