package com.pinde.sci.dao.res;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.form.hbres.ResDoctorTrainingSpeForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorOrgHistory;
import com.pinde.sci.model.mo.ResExamDoctor;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorExt;
import com.pinde.sci.model.res.ResExamDoctorExt;
import com.pinde.sci.model.sys.SysUserResDoctorExt;

public interface ResDoctorExtMapper {
	List<ResDoctorExt> searchResDoctorUser(ResDoctorExt resDoctorExt);
	
	List<SysUserResDoctorExt> searchSysUserAndResDoctor(Map<String,Object> paramMap);
	
	/**
	 * ��ѯָ������ , ���ͨ�� , ͬʱ������ָ���������ϵ�����
	 * @param resDoctorExt
	 * @return
	 */
	//Integer searchPassCount(Map<String , Object> paramMap);
	
	Integer searchResDoctorUserCount(Map<String , Object> paramMap);
	
	/**
	 * �������� �û������ѧԱ�����¼���ѯ
	 * @param resDoctorExt
	 * @return
	 */
	List<ResDoctorExt> searchResDoctorUserRecruit(Map<String , Object> paramMap);
	
	/**
	 * ������¼������˲�ѯ
	 * @param paramMap
	 * sessionNumber ����
	 * statusId ״̬
	 * key ��ѯ�ؼ���(����,�ֻ���,���֤��,�ʼ�)
	 * @return
	 */
	List<ResDoctorExt> searchResDoctorUserForAudit(Map<String , Object> paramMap);
	
	/**
	 * ��ѯ����ĳ�����Ե��û�
	 * @param paramMap
	 * statusId ״̬(���ͨ��״̬)
	 * regYear ע�����
	 * examFlow ������ˮ��
	 * @return
	 */
	List<SysUser> searchNotInExamUser(Map<String , Object> paramMap);
	
	/**
	 * ��ѯ��ĳ������ĳ��������û�б�����׼��֤�ŵ��û� ����res_doctor��
	 * key   
	 * examFlow ������ˮ��(String)
	 * siteFlow ������ˮ��(String)
	 * ���� ��רҵ ��ע��ʱ������
	 * 
	 * @param paramMap
	 * @return
	 */
	List<ResExamDoctor> searchNotAllotTicketNumUserInExamAndSite(Map<String , Object> paramMap);
	
	/**
	 * ���ݿ���ѧ�������ѧԱ��Ϣ���ѯ
	 * @param examDoctor
	 * @return
	 */
	List<ResExamDoctorExt> searchExamDoctorExt(ResExamDoctorExt examDoctor);
	
	/**
	 * ���ݿ���ѧ�������ѧԱ��Ϣ���ѯ
	 * @param examDoctor
	 * examDoctor ResExamDoctorExt
	 * key �ؼ���
	 * @return
	 */
	List<ResExamDoctorExt> searchExamDoctorExtByMap(Map<String , Object> paramMap);
	
	/**
	 * ��ѯ�μ�ĳ�����Ե����� ��ѯ������    
	 * examFlow           ������ˮ��
	 * speId              רҵId
	 * startGrade         ��ʼ��
	 * endGrade           ������
	 * moreThanGrade      ����ĳ������
	 * @param paramMap
	 * @return
	 */
	int searchJoinExamDoctorCountByParamMap(Map<String , Object> paramMap);
	
	/**
	 * ��ѯĳ������ĳ��רҵ���������ֵ����Сֵ
	 * @param paramMap
	 * @return
	 */
	int searchMaxOrMinGradeInExam(Map<String , Object> paramMap);
	
	int modifyResDoctorRecruit(Map<String , Object> paramMap);
	
	List<Map<String,Object>> searchTrainPlanCount(@Param(value="doctor")ResDoctor doctor,@Param(value="countType")String countType);
	
	int modifyResDoctorRotation(@Param(value="doctor")ResDoctor doctor);

	Integer searchResRegUserCount(Map<String, Object> paramMap);

	List<ResDoctorExt> searchResRegUserForAudit(Map<String, Object> paramMap);
	
	List<Map<String,String>> searGroupRotation(@Param(value="doctor")ResDoctor doctor);

	ResExamDoctor searchExamDoctor(Map<String,String> paramMap);

	/**
	 * ��ѯ�ǼǱ�
	 * @param paramMap
	 * @return
	 */
	List<ResDoctorExt> searchRegisterList(Map<String, Object> paramMap);

	List<ResDoctorTrainingSpeForm> trainingSpeCountList(Map<String, Object> paramMap);
	
	List<ResDoctor> searchMonthRotationDoctor(@Param(value="schDeptFlow")String schDeptFlow,@Param(value="month")String month);
	
	List<ResDoctor> searchSelDeptDoctor(@Param(value="doctor")ResDoctor doctor);
	
	List<ResDoctor> searchDoctorForChange(@Param(value="doctor")ResDoctor doctor,@Param(value="docOrgHis")ResDoctorOrgHistory docOrgHis);
	
	int updateDocSelFlag(@Param(value="orgFlow")String orgFlow);

	List<ResDoctor> searchDocByteacher(Map<String, Object> paramMap);
	
	/**
	 * ���������ֶ�
	 * @param doctor
	 * @return
	 */
	int updateRedundancyData(@Param(value="doctor")ResDoctor doctor);
	
	/**
	 * ��������������ڸ�רҵ��ռ����
	 * @param org
	 * @param doctor
	 * @return
	 */
	List<Map<String,Object>> countDocByOrg(@Param(value="orgFlows")List<String> orgFlows,@Param(value="doctor")ResDoctor doctor);
	
	/**
	 * ����������ϵ�ҽʦ��
	 * @param doctor
	 * @return
	 */
	List<Map<String,Object>> countGroupDoc(@Param(value="doctor")ResDoctor doctor);
}
