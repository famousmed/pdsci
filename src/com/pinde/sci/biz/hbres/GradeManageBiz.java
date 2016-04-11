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
 * �ɼ�����
 * @author Administrator
 *
 */
public interface GradeManageBiz {
	
	public Integer defaultGradeStep = 5;//Ĭ�ϲ���
	
	/**
	 * ����ҽ����ˮ�Ų�ѯ��¼
	 * @param doctorFlow
	 * @return
	 */
	public ResDoctorRecruit findResDoctorRecruitByDoctorFlow(String doctorFlow);
	
	/**
	 * ���߸�������ݺ�ѧԱ���� ����ordinal���� ��ѯΨһ��һ����¼��Ϣ(�������һ��)
	 * @param year
	 * @param doctorFlow
	 * @return
	 */
	public ResDoctorRecruit findResDoctorRecruit(String year , String doctorFlow);
	
	public List<ResDoctorRecruit> findResDoctorRecruits(String year , String doctorFlow);
	
	/**
	 * ѧ���ɼ�¼��
	 * @param doctorFlow
	 * @param examResult
	 */
	public void inputDoctorGrade(String examFlow , String doctorFlow , String examResult);
	
	/**
	 * ѧ���ύ־Ը
	 * @param doctorRecruit
	 */
	public void submitRecruit(ResDoctorRecruitWithBLOBs doctorRecruit);

	/**
	 * ����Excel�ɼ�
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	void importExcel(String examFlow , MultipartFile file) throws Exception;
	
	/**
	 * ���ݿ�����ˮ�Ų�ѯ������
	 * @param examFlow
	 * @return
	 */
	List<ResGradeBorderline> findGradeBorderlineByExamFlow(String examFlow);
	
	/**
	 * ���ݿ�����ˮ�ź�רҵId ��ѯ�ôο��Եĸ�רҵ�ķ�����
	 * @param examFlow
	 * @param speId
	 * @return
	 */
	ResGradeBorderline findResGradeBorderlineByExamFlowAndSpeId(String examFlow , String speId);
	
	/**
	 * ��ѯĳ������ĳ��רҵ��������(����)ָ������������
	 * @param examFlow
	 * @param speId
	 * @param moreThanGrade
	 * @return
	 */
	Integer getMoreThanGradeDoctorCountInExamForSpe(String examFlow , String speId , String moreThanGrade);
	
	/**
	 * ��ȡĳ������ ��ͬרҵ�ķ�����ͳ����Ϣ
	 * @param examFlow
	 * @return
	 */
	Map<String , GradeBorderlineStatistics> getGradeBorderlineStatistics(String examFlow);
	
	/**
	 * Ϊĳ������ĳ��רҵ��ӷ�����
	 */
	void addGradeBorderLine(ResGradeBorderline borderline);
	
	/**
	 * ���ɷ�����
	 * @param max
	 * @param min
	 * @param step ����Ϊ0
	 * @return
	 */
	List<GradeStep> crateGradeSteps(Integer max , Integer min , Integer step);
	
	/**
	 * ͳ��ĳ������ĳ��רҵ�ķ���������
	 * @param examFlow
	 * @param speId
	 * @param step
	 * @return
	 */
	List<GradeStep> getGradeStep(String examFlow , String speId , Integer step);

	/**
	 * ͳ��ĳ����������רҵ�����ε�����
	 * @param examFlow
	 * @return
	 */
	Map<String, GradeStepStatistics> getGradeSteps(String examFlow);
	
	/**
	 * ����ĳ������ĳ��רҵ�ķ�����
	 * @param examFlow
	 * @param speId
	 * @return
	 */
	BigDecimal findGradeBorderlineByExamFlowAndSpe(String examFlow , String speId);

	/**
	 * ���沽��
	 * @param borderline
	 */
	public void modGradeBorderlineStep(ResGradeBorderline borderline);
}

	
