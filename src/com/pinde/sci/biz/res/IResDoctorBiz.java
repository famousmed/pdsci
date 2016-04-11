package com.pinde.sci.biz.res;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.form.hbres.ResDoctorTrainingSpeForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorOrgHistory;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResExamDoctor;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorExt;
import com.pinde.sci.model.sys.SysUserResDoctorExt;
/**
 * @author tiger
 *
 */
public interface IResDoctorBiz {
	List<ResDoctor> searchDoctor();
	ResDoctor readDoctor(String recordFlow);
	int editDoctor(ResDoctor doctor);
	List<ResDoctor> searchByDoc(ResDoctor doctor);
	int editDocUser(ResDoctor doctor, SysUser user);
	List<ResDoctorExt> searchDocUser(ResDoctorExt resDoctorExt);
	
	List<ResDoctorExt> searchDocUser(Map<String , Object> paramMap);
	/**
	 * �����û���ˮ�Ų���
	 * @param userFlow �û���ˮ��
	 * @return
	 */
	ResDoctor searchByUserFlow(String userFlow);
	/**
	 * ��ѯ������ʦ�������
	 * @param resultFlow ��ת�ƻ���ˮ��
	 * @param roleFlow ��ɫ��ˮ��
	 * @return
	 */
	List<SysUser> searchTeacherOrHead(String resultFlow,String roleFlow);
	/**
	 * ���������ʦ�Ϳ�����
	 * @param process
	 * @param resultFlow
	 * @param preResultFlow
	 */
	void saveChoose(ResDoctorSchProcess process,String resultFlow,String preResultFlow);
	
	
	List<ResDoctor> searchDoctorByuserFlow(List<String> userFlows);
	int editDocUserFromRegister(ResDoctor doctor, SysUser user);
	
	/**
	 * ����ɨ���
	 * @param oldImg
	 * @param file
	 * @param folderName
	 * @return
	 */
	String saveImg(String oldImg, MultipartFile file, String folderName);
	
	String checkFile(MultipartFile file);
	
	Integer searchResDoctorUserCount(Map<String , Object> paramMap);
	
	/**
	 * ������¼ ע���û���� 
	 * @param user
	 * @param doctor
	 */
	void auditDoctor(SysUser user , ResDoctor doctor);
	List<Map<String, Object>> searchTrainPlanCount(ResDoctor doctor,
			String countType);
	int modifyResDoctorRotation(ResDoctor doctor);
	int submitUserInfo(SysUser user, ResDoctor doctor);
	Integer searchResRegUserCount(Map<String, Object> activatedCountParamMap);
	List<ResDoctorExt> searchRegUser(Map<String, Object> paramMap);
	ResDoctor searchResDoctor(String userFlow, String regYear);
	List<Map<String, String>> searGroupRotation(ResDoctor doctor);
	ResExamDoctor searchExamDoctor(String doctorFlow, String examType,String examYear);
	
	
	/**
	 * ��ѯע��ǼǱ�
	 * @param paramMap
	 * @return
	 */
	List<ResDoctorExt> searchRegisterList(Map<String, Object> paramMap);
	void withdrawDoctor(ResDoctor doctor);
	
	/**
	 * רҵ����ͳ��
	 * @param paramMap
	 * @return
	 */
	List<ResDoctorTrainingSpeForm> trainingSpeCountList(Map<String, Object> paramMap);
	List<ResDoctor> searchMonthRotationDoctor(String schDeptFlow, String month);
	int resultAudit(String orgFlow);
    /**
     * ��ѯϵͳ�����û�����סԺҽʦ��Ϣ
     * @param userDoctorExt
     * @param checkUserFlowList
     * @return
     */
	List<SysUserResDoctorExt> searchSysUserAndResDoctor(
			SysUserResDoctorExt userDoctorExt,List<String> checkUserFlowList,String schDeptFlow);

	List<ResDoctor> searchSelDeptDoctor(ResDoctor doctor);
	List<ResDoctor> searchDoctorForChange(ResDoctor doctor,
			ResDoctorOrgHistory docOrgHis);
	int updateDocSelFlag(String orgFlow);
	List<ResDoctor> searchDocByteacher(Map<String, Object> paramMap);
	int editDoctorUser(ResDoctor doctor, SysUser user);
	int resetDoctorRecruit(String doctorFlow);
	
	/**
	 * ����������ҽʦ,�����Լ�
	 * @param doctor
	 * @return
	 */
	List<ResDoctor> searchByDocNotSelf(ResDoctor doctor,String doctorFlow);
	
	/**
	 * ���������ֶ�
	 * @param doctor
	 * @return
	 */
	int updateRedundancyData(ResDoctor doctor);
	
	/**
	 * ��������������ڸ�רҵ��ռ����
	 * @param org
	 * @param doctor
	 * @return
	 */
	List<Map<String, Object>> countDocByOrg(List<String> orgFlows,
			ResDoctor doctor);
	
	/**
	 * ��ѯָ�������·�������������
	 * @param doctor
	 * @return
	 */
	public int findDoctorCountInOrg(ResDoctor doctor);
	
	/**
	 * ����������ϵ�ҽʦ��
	 * @param doctor
	 * @return
	 */
	List<Map<String, Object>> countGroupDoc(ResDoctor doctor);
	
	/**
	 * ɾ��������ҽʦ������ѡ�ƺ��Ű�
	 * @param doctorFlowList
	 * @return
	 */
	int clearSelAndRostering(List<String> doctorFlowList);
	
	/**
	 * ����courseFlow��ѯ��Ӧ��ResDoctor����
	 * @param process
	 * @param user
	 * @return
	 */
	Map<String,Map<String,Object>> courseFlowResDoctorMap(List<EduCourseExt> eduCourseList);
	/**
	 * only����
	 * @param resDoctor
	 * @return
	 */
	int onlySaveResDoctor(ResDoctor resDoctor);
	ResDoctor findByFlow(String doctorFlow);
	
}
