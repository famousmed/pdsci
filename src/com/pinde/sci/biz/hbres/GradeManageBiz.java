package com.pinde.sci.biz.hbres;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResGradeBorderline;
import com.pinde.sci.model.res.GradeBorderlineStatistics;
import com.pinde.sci.model.res.GradeStep;
import com.pinde.sci.model.res.GradeStepStatistics;

/**
 * 成绩管理
 * @author Administrator
 *
 */
public interface GradeManageBiz {
	
	public Integer defaultGradeStep = 5;//默认步长
	
	/**
	 * 根据医生流水号查询记录
	 * @param doctorFlow
	 * @return
	 */
	public ResDoctorRecruit findResDoctorRecruitByDoctorFlow(String doctorFlow);
	
	/**
	 * 更具给定的年份和学员主键 按照ordinal排序 查询唯一的一条招录信息(结果集第一条)
	 * @param year
	 * @param doctorFlow
	 * @return
	 */
	public ResDoctorRecruit findResDoctorRecruit(String year , String doctorFlow);
	
	public List<ResDoctorRecruit> findResDoctorRecruits(String year , String doctorFlow);
	
	/**
	 * 学生成绩录入
	 * @param doctorFlow
	 * @param examResult
	 */
	public void inputDoctorGrade(String examFlow , String doctorFlow , String examResult);
	
	/**
	 * 学生提交志愿
	 * @param doctorRecruit
	 */
	public void submitRecruit(ResDoctorRecruitWithBLOBs doctorRecruit);

	/**
	 * 导入Excel成绩
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	void importExcel(String examFlow , MultipartFile file) throws Exception;
	
	/**
	 * 根据考试流水号查询分数线
	 * @param examFlow
	 * @return
	 */
	List<ResGradeBorderline> findGradeBorderlineByExamFlow(String examFlow);
	
	/**
	 * 根据考试流水号和专业Id 查询该次考试的该专业的分数线
	 * @param examFlow
	 * @param speId
	 * @return
	 */
	ResGradeBorderline findResGradeBorderlineByExamFlowAndSpeId(String examFlow , String speId);
	
	/**
	 * 查询某场考试某个专业分数大于(等于)指定分数的人数
	 * @param examFlow
	 * @param speId
	 * @param moreThanGrade
	 * @return
	 */
	Integer getMoreThanGradeDoctorCountInExamForSpe(String examFlow , String speId , String moreThanGrade);
	
	/**
	 * 获取某场考试 不同专业的分数线统计信息
	 * @param examFlow
	 * @return
	 */
	Map<String , GradeBorderlineStatistics> getGradeBorderlineStatistics(String examFlow);
	
	/**
	 * 为某场考试某个专业添加分数线
	 */
	void addGradeBorderLine(ResGradeBorderline borderline);
	
	/**
	 * 生成分数段
	 * @param max
	 * @param min
	 * @param step 不能为0
	 * @return
	 */
	List<GradeStep> crateGradeSteps(Integer max , Integer min , Integer step);
	
	/**
	 * 统计某场考试某个专业的分数段数据
	 * @param examFlow
	 * @param speId
	 * @param step
	 * @return
	 */
	List<GradeStep> getGradeStep(String examFlow , String speId , Integer step);

	/**
	 * 统计某场考试所有专业分数段的数据
	 * @param examFlow
	 * @return
	 */
	Map<String, GradeStepStatistics> getGradeSteps(String examFlow);
	
	/**
	 * 根据某场考试某个专业的分数线
	 * @param examFlow
	 * @param speId
	 * @return
	 */
	BigDecimal findGradeBorderlineByExamFlowAndSpe(String examFlow , String speId);

	/**
	 * 保存步长
	 * @param borderline
	 */
	public void modGradeBorderlineStep(ResGradeBorderline borderline);
}

	
