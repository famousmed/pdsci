package com.pinde.sci.dao.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.njmuedu.EduUserExt;

public interface NjmuEduUserExtMapper {
	
	List<EduUserExt> selectList(EduUserExt userExt);
	/**
	 * ����Ա����--��ѯ��Ա��Ϣ
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserForManage(Map<String,Object> paramMap);
    /**
     * �γ�ѧϰ���ͳ��--��ѯѧϰ���ſε���Ա��Ϣ
     * @param paramMap
     * @return
     */
	List<EduUserExt> searchEduUserForCourseDetail(Map<String,Object> paramMap);
	
	/**
	 * ��ȡ�û���Ϣ
	 * @param userFlow
	 * @return
	 */
	EduUserExt readEduUserInfo(String userFlow);
	/**
	 * ��ȡ��ʦ�������ν̵Ŀγ���Ϣ
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduAndCourseList(Map<String,Object> paramMap);
	/**
	 * ������ˮ�Ų�ѯ�û�
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserList(Map<String,Object> paramMap);
	
}
