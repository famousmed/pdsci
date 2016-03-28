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
	 * 查询指定届数 , 审核通过 , 同时分数在指定分数线上的人数
	 * @param resDoctorExt
	 * @return
	 */
	//Integer searchPassCount(Map<String , Object> paramMap);
	
	Integer searchResDoctorUserCount(Map<String , Object> paramMap);
	
	/**
	 * 根据条件 用户表关联学员表和招录表查询
	 * @param resDoctorExt
	 * @return
	 */
	List<ResDoctorExt> searchResDoctorUserRecruit(Map<String , Object> paramMap);
	
	/**
	 * 湖北招录报名审核查询
	 * @param paramMap
	 * sessionNumber 届数
	 * statusId 状态
	 * key 查询关键字(姓名,手机号,身份证号,邮件)
	 * @return
	 */
	List<ResDoctorExt> searchResDoctorUserForAudit(Map<String , Object> paramMap);
	
	/**
	 * 查询不在某场考试的用户
	 * @param paramMap
	 * statusId 状态(审核通过状态)
	 * regYear 注册年份
	 * examFlow 考试流水号
	 * @return
	 */
	List<SysUser> searchNotInExamUser(Map<String , Object> paramMap);
	
	/**
	 * 查询在某场考试某个考点下没有被分配准考证号的用户 关联res_doctor表
	 * key   
	 * examFlow 考试流水号(String)
	 * siteFlow 考点流水号(String)
	 * 排序 按专业 按注册时间正序
	 * 
	 * @param paramMap
	 * @return
	 */
	List<ResExamDoctor> searchNotAllotTicketNumUserInExamAndSite(Map<String , Object> paramMap);
	
	/**
	 * 根据考试学生表关联学员信息表查询
	 * @param examDoctor
	 * @return
	 */
	List<ResExamDoctorExt> searchExamDoctorExt(ResExamDoctorExt examDoctor);
	
	/**
	 * 根据考试学生表关联学员信息表查询
	 * @param examDoctor
	 * examDoctor ResExamDoctorExt
	 * key 关键字
	 * @return
	 */
	List<ResExamDoctorExt> searchExamDoctorExtByMap(Map<String , Object> paramMap);
	
	/**
	 * 查询参加某场考试的人数 查询条件有    
	 * examFlow           考试流水号
	 * speId              专业Id
	 * startGrade         起始分
	 * endGrade           结束分
	 * moreThanGrade      大于某个分数
	 * @param paramMap
	 * @return
	 */
	int searchJoinExamDoctorCountByParamMap(Map<String , Object> paramMap);
	
	/**
	 * 查询某场考试某个专业分数的最大值或最小值
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
	 * 查询登记表
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
	 * 升级冗余字段
	 * @param doctor
	 * @return
	 */
	int updateRedundancyData(@Param(value="doctor")ResDoctor doctor);
	
	/**
	 * 按条件计算机构内各专业所占人数
	 * @param org
	 * @param doctor
	 * @return
	 */
	List<Map<String,Object>> countDocByOrg(@Param(value="orgFlows")List<String> orgFlows,@Param(value="doctor")ResDoctor doctor);
	
	/**
	 * 计算所属组合的医师数
	 * @param doctor
	 * @return
	 */
	List<Map<String,Object>> countGroupDoc(@Param(value="doctor")ResDoctor doctor);
}
