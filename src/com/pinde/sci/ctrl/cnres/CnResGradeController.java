package com.pinde.sci.ctrl.cnres;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.cnres.ICnResExamBiz;
import com.pinde.sci.biz.cnres.ICnResGradeBiz;
import com.pinde.sci.biz.cnres.ICnResDoctorRecruitBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.res.ExamStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.hbres.ResDoctorTrainingSpeForm;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResExam;
import com.pinde.sci.model.mo.ResExamRoom;
import com.pinde.sci.model.mo.ResExamSite;
import com.pinde.sci.model.mo.ResGradeBorderline;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.GradeBorderlineStatistics;
import com.pinde.sci.model.res.GradeStep;
import com.pinde.sci.model.res.GradeStepStatistics;
import com.pinde.sci.model.res.ResDoctorExt;
import com.pinde.sci.model.res.ResDoctorRecruitExt;
import com.pinde.sci.model.res.ResExamDoctorExt;
/**
 * 成绩管理
 * --成绩录入
 * @author shenzhen
 *
 */
@Controller
@RequestMapping("/cnres/grade")
public class CnResGradeController extends GeneralController{
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private ICnResGradeBiz gradeManageBiz;
	@Autowired
	private ICnResDoctorRecruitBiz recruitBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private ICnResExamBiz examManageBiz;
	
	/**
	 * 成绩录入
	 * @return
	 */
	@RequestMapping("/input")
	public String input(ResExamDoctorExt examDoctor , Integer currentPage , Model model){
		List<ResExam> exams = examManageBiz.findALLExam();
		List<ResExam> finishedExams = new ArrayList<ResExam>();
		for(ResExam exam : exams){
			if(ExamStatusEnum.Finished.getId().equals(exam.getExamStatusId())){
				finishedExams.add(exam);
			}
		}
		model.addAttribute("exams" , finishedExams);
		if(StringUtil.isNotBlank(examDoctor.getExamFlow())){
			//查询该场考试下的考点
			List<ResExamSite> sites = this.examManageBiz.findAllUsablelExamSite(examDoctor.getExamFlow());
			model.addAttribute("sites" , sites);
		}
		if(StringUtil.isNotBlank(examDoctor.getSiteFlow())){
			//查询该考点下的考场
			List<ResExamRoom> rooms = this.examManageBiz.findExamRoomsBySiteFlow(examDoctor.getSiteFlow());
			model.addAttribute("rooms" , rooms);
		}
		if(StringUtil.isNotBlank(examDoctor.getExamFlow())){
			PageHelper.startPage(currentPage, 10);
			List<ResExamDoctorExt> userList = this.examManageBiz.findExamDoctorExts(examDoctor);
			model.addAttribute("userList" , userList);
		}
		return "cnres/manage/gradeinput";
	}
	
	@RequestMapping("/getsites")
	@ResponseBody
	public Object getSites(@RequestParam(required=true)String examFlow){
		List<ResExamSite> sites = this.examManageBiz.findAllUsablelExamSite(examFlow);
		return sites;
	}
	
	@RequestMapping("/gradelist")
	public String gradeList(Integer currentPage , Model model){
		ResDoctorExt resDoctorExt = new ResDoctorExt();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		resDoctorExt.setSessionNumber(regYear);
		resDoctorExt.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		SysUser sysUser = new SysUser();
		sysUser.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		sysUser.setStatusId(UserStatusEnum.Activated.getId());//已激活的用户
		resDoctorExt.setSysUser(sysUser);
		PageHelper.startPage(currentPage, 10);
		List<ResDoctorExt> userList= resDoctorBiz.searchDocUser(resDoctorExt);
		model.addAttribute("userList" , userList);
		Map<String , ResDoctorRecruit> doctorRecruitMap = new HashMap<String, ResDoctorRecruit>();
		//查询今年报名人员对应的RES_DOCTOR_RECRUIT记录
		for(ResDoctorExt doctorExt:userList){
			ResDoctorRecruit doctorRecruit = this.gradeManageBiz.findResDoctorRecruitByDoctorFlow(doctorExt.getDoctorFlow());
			doctorRecruitMap.put(doctorExt.getDoctorFlow(), doctorRecruit);
		}
		model.addAttribute("doctorRecruitMap" , doctorRecruitMap);
		return "cnres/manage/gradelist";
	}
	
	@RequestMapping("/inputdoctorgrade")
	@ResponseBody
	public String inputDoctorGrade(String examFlow , String doctorFlow , String examResult){
		this.gradeManageBiz.inputDoctorGrade(examFlow , doctorFlow, examResult);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	//*********************成绩导入***********************
	
	/**
	 * 跳转至成绩导入
	 * @param doctorFlow
	 * @param examResult
	 * @return
	 */
	@RequestMapping(value="/openImport",method={RequestMethod.GET})
	public String openImport(String examFlow){
		return "cnres/manage/importResult";
	}
	
	/**
	 * 导入Excel成绩
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/importExcel"},method={RequestMethod.POST})
	@ResponseBody
	public String importExcel(String examFlow , MultipartFile file) throws Exception{
		if(file.getSize() > 0){
			try{
				gradeManageBiz.importExcel(examFlow , file);
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}catch(RuntimeException re){
				return re.getMessage();
			}
			
		}
		return GlobalConstant.UPLOAD_FAIL;
	}
	
	//******************* 统计 *************************
	
	/**
	 * 住培学员注册登记表
	 * @param examSite
	 * @return
	 */
	@RequestMapping("/registerList")
	public String registerList(String orgFlow, Integer currentPage, Model model){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		//基地
		List<SysOrg> orgList = orgBiz.searchHbresOrgList();
		model.addAttribute("orgList",orgList);
		Map<String, Object> paramMap = new HashMap<String , Object>();
		ResDoctorRecruit doctorRecruit = new ResDoctorRecruit();
		doctorRecruit.setOrgFlow(orgFlow);
		doctorRecruit.setRecruitYear(regYear);
		paramMap.put("doctorRecruit", doctorRecruit);
		PageHelper.startPage(currentPage, 10);
		List<ResDoctorExt> doctorExtList = resDoctorBiz.searchRegisterList(paramMap);
		model.addAttribute("doctorExtList", doctorExtList);
		return "cnres/manage/registerList";
	}
	
	
	
	/**
	 * 住培注册学员统计表
	 * @param orgFlow
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping("/registerStatistics")
	public String registerStatistics(String orgFlow, Model model){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		//基地
		List<SysOrg> orgList = orgBiz.searchHbresOrgList();
		model.addAttribute("orgList",orgList);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		ResDoctorRecruit doctorRecruit = new ResDoctorRecruit();
		doctorRecruit.setOrgFlow(orgFlow);
		doctorRecruit.setRecruitYear(regYear);
		paramMap.put("doctorRecruit", doctorRecruit);
		List<ResDoctorTrainingSpeForm> doctorRecruitFormList =  recruitBiz.searchRegisterStatistics(paramMap);
		if(doctorRecruitFormList != null && !doctorRecruitFormList.isEmpty()){
			Map<String, String> doctorRecruitFormMap =  new HashMap<String, String>();
			for(ResDoctorTrainingSpeForm form : doctorRecruitFormList){
				doctorRecruitFormMap.put(form.getSpeId(), form.getDoctorCount());
			}
			model.addAttribute("doctorRecruitFormMap", doctorRecruitFormMap);
		}
		return "cnres/manage/registerStatistics";
	}
	
	
	
	/**
	 * 录取考试成绩排序表
	 * @param resDoctor
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping("/recruitResultList")
	public String recruitResultList(String orgFlow, Integer currentPage, Model model){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		//基地
		List<SysOrg> orgList = orgBiz.searchHbresOrgList();
		model.addAttribute("orgList",orgList);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		ResDoctorRecruit doctorRecruit = new ResDoctorRecruit();
		doctorRecruit.setOrgFlow(orgFlow);
		doctorRecruit.setRecruitYear(regYear);
		paramMap.put("doctorRecruit", doctorRecruit);
		PageHelper.startPage(currentPage, 10);
		List<ResDoctorRecruitExt> doctorRecruitExtList =  recruitBiz.searchDoctorRecruitWithUserList(paramMap);
		model.addAttribute("doctorRecruitExtList" , doctorRecruitExtList);
		return "cnres/manage/recruitResultList";
	}
	
	@RequestMapping("/gradeline")
	public String showGradeLine(String examFlow , Model model){
		List<ResExam> exams = examManageBiz.findALLExam();
		List<ResExam> finishedExams = new ArrayList<ResExam>();
		for(ResExam exam : exams){
			if(ExamStatusEnum.Finished.getId().equals(exam.getExamStatusId())){
				finishedExams.add(exam);
			}
		}
		model.addAttribute("exams" , finishedExams);
		ResExam currExam = null;
		if(StringUtil.isBlank(examFlow)){
			if(finishedExams.size()>0){
				currExam = finishedExams.get(0); 
			}
		}else{
			currExam = this.examManageBiz.findExamByFlow(examFlow);
		}
		model.addAttribute("currExam" , currExam);
		
		if(currExam!=null){
			//查询参加考试的总人数
			Integer joinExamSumDoctor = this.examManageBiz.findExamUserCountByExamFlow(currExam.getExamFlow());
			model.addAttribute("joinExamSumDoctor" , joinExamSumDoctor);
			//获取考试不同专业分数线统计信息
			Map<String , GradeBorderlineStatistics> gradeBorderlineStatistics = this.gradeManageBiz.getGradeBorderlineStatistics(currExam.getExamFlow());
			model.addAttribute("statisticsMap"  , gradeBorderlineStatistics);
		}
		
		return "cnres/manage/grade/gradeline";
	}
	
	@RequestMapping("/getpasscount")
	public String getPasscount(ResGradeBorderline borderline , Model model){
		this.gradeManageBiz.addGradeBorderLine(borderline);
		return showGradeLine(borderline.getExamFlow() , model);
	}
	
	@RequestMapping("/publishgradeborderline")
	public String publishGradeBorderline(ResGradeBorderline borderline , Model model){
		borderline.setPublishFlag(GlobalConstant.FLAG_Y);
		this.gradeManageBiz.addGradeBorderLine(borderline);
		return showGradeLine(borderline.getExamFlow() , model);
	}
	
	@RequestMapping("/getgradesteps")
	public String getgradesteps(String examFlow , Model model){
		Map<String ,GradeStepStatistics> gradeSteps = this.gradeManageBiz.getGradeSteps(examFlow);
		model.addAttribute("gradeStepsMap" , gradeSteps);
		ResExam currExam = this.examManageBiz.findExamByFlow(examFlow);
		model.addAttribute("currExam" , currExam);
		return "cnres/manage/grade/gradesteps";
	}
	
	@RequestMapping("/getgradestep")
	public String getgradestep(ResGradeBorderline borderline , Model model){
		//实时保存步长
		this.gradeManageBiz.modGradeBorderlineStep(borderline);
		List<GradeStep> gradeSteps = this.gradeManageBiz.getGradeStep(borderline.getExamFlow(), borderline.getSpeId(), Integer.parseInt(borderline.getGradeStep()));
		model.addAttribute("gradeSteps" , gradeSteps);
		return "cnres/manage/grade/gradestep";
	}

}
