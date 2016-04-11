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
	 * 根据用户流水号查找
	 * @param userFlow 用户流水号
	 * @return
	 */
	ResDoctor searchByUserFlow(String userFlow);
	/**
	 * 查询带教老师或科主任
	 * @param resultFlow 轮转计划流水号
	 * @param roleFlow 角色流水号
	 * @return
	 */
	List<SysUser> searchTeacherOrHead(String resultFlow,String roleFlow);
	/**
	 * 保存带教老师和科主任
	 * @param process
	 * @param resultFlow
	 * @param preResultFlow
	 */
	void saveChoose(ResDoctorSchProcess process,String resultFlow,String preResultFlow);
	
	
	List<ResDoctor> searchDoctorByuserFlow(List<String> userFlows);
	int editDocUserFromRegister(ResDoctor doctor, SysUser user);
	
	/**
	 * 保存扫描件
	 * @param oldImg
	 * @param file
	 * @param folderName
	 * @return
	 */
	String saveImg(String oldImg, MultipartFile file, String folderName);
	
	String checkFile(MultipartFile file);
	
	Integer searchResDoctorUserCount(Map<String , Object> paramMap);
	
	/**
	 * 湖北招录 注册用户审核 
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
	 * 查询注册登记表
	 * @param paramMap
	 * @return
	 */
	List<ResDoctorExt> searchRegisterList(Map<String, Object> paramMap);
	void withdrawDoctor(ResDoctor doctor);
	
	/**
	 * 专业人数统计
	 * @param paramMap
	 * @return
	 */
	List<ResDoctorTrainingSpeForm> trainingSpeCountList(Map<String, Object> paramMap);
	List<ResDoctor> searchMonthRotationDoctor(String schDeptFlow, String month);
	int resultAudit(String orgFlow);
    /**
     * 查询系统所有用户及其住院医师信息
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
	 * 按条件查找医师,不含自己
	 * @param doctor
	 * @return
	 */
	List<ResDoctor> searchByDocNotSelf(ResDoctor doctor,String doctorFlow);
	
	/**
	 * 升级冗余字段
	 * @param doctor
	 * @return
	 */
	int updateRedundancyData(ResDoctor doctor);
	
	/**
	 * 按条件计算机构内各专业所占人数
	 * @param org
	 * @param doctor
	 * @return
	 */
	List<Map<String, Object>> countDocByOrg(List<String> orgFlows,
			ResDoctor doctor);
	
	/**
	 * 查询指定机构下符合条件的人数
	 * @param doctor
	 * @return
	 */
	public int findDoctorCountInOrg(ResDoctor doctor);
	
	/**
	 * 计算所属组合的医师数
	 * @param doctor
	 * @return
	 */
	List<Map<String, Object>> countGroupDoc(ResDoctor doctor);
	
	/**
	 * 删除集合内医师的所有选科和排班
	 * @param doctorFlowList
	 * @return
	 */
	int clearSelAndRostering(List<String> doctorFlowList);
	
	/**
	 * 根据courseFlow查询对应的ResDoctor对象
	 * @param process
	 * @param user
	 * @return
	 */
	Map<String,Map<String,Object>> courseFlowResDoctorMap(List<EduCourseExt> eduCourseList);
	/**
	 * only保存
	 * @param resDoctor
	 * @return
	 */
	int onlySaveResDoctor(ResDoctor resDoctor);
	ResDoctor findByFlow(String doctorFlow);
	
}
