package com.pinde.sci.ctrl.xjgl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.docx4j.openpackaging.io.SaveToZipFile;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.Docx4jUtil;
import com.pinde.core.util.JaxbUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.xjgl.IChangeApplyBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.xjgl.UserChangeApplyStatusEnum;
import com.pinde.sci.enums.xjgl.UserChangeApplyTypeEnum;
import com.pinde.sci.form.edu.SubmitApplyForm;
import com.pinde.sci.form.edu.UserChangeApplyForm;
import com.pinde.sci.model.edu.EduStudentChangeExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.EduUserChangeApply;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/xjgl/change/apply")
public class XjglChangeApplyContoller extends GeneralController{
	@Autowired
	private IChangeApplyBiz iChangeApplyBiz;
	@Autowired
	private IUserBiz iUserBiz;
	@Autowired
	private IResDoctorBiz iresDoctorBiz;

	/**
	 * 编辑申请界面跳转
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/editApply")
	public String editApply(String userFlow,Model model,String changeFlag,String recordFlow,String applyTypeId){
		if (StringUtil.isBlank(userFlow)) {
			userFlow=GlobalContext.getCurrentUser().getUserFlow();
		}
		EduUser user=iChangeApplyBiz.readEduUser(userFlow);
		SysUser sysUser=iUserBiz.findByFlow(userFlow);
		Map<String, Object> paramMap=new HashMap<String,Object>();
		sysUser.setUserFlow(userFlow);
		paramMap.put("sysUser", sysUser);
		List<EduCourse> educourseList=iChangeApplyBiz.searchStuCourseList(paramMap);
		ResDoctor doctor=iresDoctorBiz.searchByUserFlow(userFlow);
		EduUserChangeApply eduChangeUser=new EduUserChangeApply();
		Map<String, String>UserAuditTimeMap=new HashMap<String,String>();
		Map<String, String>userAuditPersonMap=new HashMap<String,String>();
		if(StringUtil.isNotBlank(recordFlow)){
			eduChangeUser.setRecordFlow(recordFlow);
			EduUserChangeApply existApply=iChangeApplyBiz.readEduUserChangeApply(recordFlow);
			SubmitApplyForm form=JaxbUtil.converyToJavaBean(existApply.getContent(), SubmitApplyForm.class);
			model.addAttribute("form",form);
			model.addAttribute("existApply", existApply);
		}else{
			eduChangeUser.setUserFlow(userFlow);
			List<EduUserChangeApply> eduUserChangeApplies=iChangeApplyBiz.searchEduUserChangeApply(eduChangeUser);
			for(EduUserChangeApply edu:eduUserChangeApplies){
				if(UserChangeApplyStatusEnum.Approve.getId().equals(edu.getStatusId())|| UserChangeApplyStatusEnum.NotApprove.getId().equals(edu.getStatusId()))	
				{
					String key=edu.getRecordFlow();
					SubmitApplyForm form=JaxbUtil.converyToJavaBean(edu.getContent(), SubmitApplyForm.class);
					String value=form.getAuditDate();
					String person=form.getAuditPerson();
					UserAuditTimeMap.put(key, value);
					userAuditPersonMap.put(key, person);
				}
			}
			model.addAttribute("eduUserChangeApplies", eduUserChangeApplies);
			model.addAttribute("userAuditPersonMap", userAuditPersonMap);
			model.addAttribute("UserAuditTimeMap", UserAuditTimeMap);
		}
		model.addAttribute("user", user);
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("educourseList", educourseList);
		model.addAttribute("doctor", doctor);
		if (GlobalConstant.FLAG_Y.equals(changeFlag)) {
			return "xjgl/student/changeApply";
		}
		return "xjgl/student/application";
	}
	/**
	 * 提交申请
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/saveApply")
	@ResponseBody
	public String saveApply(UserChangeApplyForm applyForm,SubmitApplyForm form,String userFlow,String recordFlow,Model model){
		int result=iChangeApplyBiz.saveAndUpdateChangeApplyInfo(form,applyForm,userFlow,recordFlow);
		if (result!=GlobalConstant.ZERO_LINE) {
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}

	@RequestMapping("/submitApply")
	@ResponseBody
	public String submitApply(String recordFlow,Model model){
		EduUserChangeApply eduUser=iChangeApplyBiz.readEduUserChangeApply(recordFlow);
		eduUser.setStatusId(UserChangeApplyStatusEnum.Submit.getId());
		eduUser.setStatusName(UserChangeApplyStatusEnum.Submit.getName());
		int reslut=iChangeApplyBiz.updataApplyInfo(eduUser,null);
		if(GlobalConstant.ZERO_LINE!=reslut){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	@RequestMapping("/findChangeInfo")
	public String findChangeInfo(String applyTypeId,Model model,Integer currentPage,HttpServletRequest request){
		EduUserChangeApply changeApply=new EduUserChangeApply();
		Map<String, Object> paramMap=new HashMap<String, Object>();
		if (StringUtil.isNotBlank(applyTypeId)) {
			changeApply.setApplyTypeId(applyTypeId);
		}
		PageHelper.startPage(currentPage, getPageSize(request));
		List<String> statusIdList=new ArrayList<String>();
		statusIdList.add(UserChangeApplyStatusEnum.Approve.getId());
		statusIdList.add(UserChangeApplyStatusEnum.NotApprove.getId());
		statusIdList.add(UserChangeApplyStatusEnum.Submit.getId());
		paramMap.put("changeApply", changeApply); 
		paramMap.put("statusIdList", statusIdList);
		List<EduStudentChangeExt>changeExtList=iChangeApplyBiz.searchStdentChangeExtsList(paramMap);
		Map<String, String> extMap=new HashMap<String,String>();
		if(changeExtList.size()>0&&!changeExtList.equals("")){
			for(EduStudentChangeExt ext:changeExtList){
				if (ext.getStatusId().equals(UserChangeApplyStatusEnum.Approve.getId()) || ext.getStatusId().equals(UserChangeApplyStatusEnum.NotApprove.getId())){
					SubmitApplyForm form=JaxbUtil.converyToJavaBean(ext.getContent(), SubmitApplyForm.class);
					String key=ext.getRecordFlow();
					String value=form.getAuditDate();
					extMap.put(key, value);
				}
			}
			model.addAttribute("extMap", extMap);
		}
		model.addAttribute("changeExtList", changeExtList);
		return "xjgl/plat/tranAudit";
	}
	@RequestMapping("/auditApply")
	@ResponseBody
	public String auditApply(SubmitApplyForm form,String recordFlow,String status,Model model){
		EduUserChangeApply user=new EduUserChangeApply();
		user.setRecordFlow(recordFlow);
		EduUserChangeApply eduUser=iChangeApplyBiz.readEduUserChangeApply(recordFlow);
		if(eduUser!=null){
			if(GlobalConstant.FLAG_Y.equals(status)){
				eduUser.setStatusId(UserChangeApplyStatusEnum.Approve.getId());
				eduUser.setStatusName(UserChangeApplyStatusEnum.Approve.getName());
			}
			if(GlobalConstant.FLAG_N.equals(status)){
				eduUser.setStatusId(UserChangeApplyStatusEnum.NotApprove.getId());
				eduUser.setStatusName(UserChangeApplyStatusEnum.NotApprove.getName());
			}
			int result=iChangeApplyBiz.updataApplyInfo(eduUser,form);
			if (GlobalConstant.ZERO_LINE==result) {
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	@RequestMapping("/print")
	public void print(String recordFlow, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> paramMap=new HashMap<String, Object>();
		
		WordprocessingMLPackage temeplete = new WordprocessingMLPackage();
		ServletContext context =  request.getServletContext();
		String watermark = GeneralMethod.getWatermark(null);
		String name="";

		EduUserChangeApply 	user=new EduUserChangeApply();
		if (StringUtil.isNotBlank(recordFlow)) {
			user.setRecordFlow(recordFlow);
		paramMap.put("changeApply", user);
		List<EduStudentChangeExt> eduUserList=iChangeApplyBiz.searchStdentChangeExtsList(paramMap);
		if (eduUserList.size()>0&&!eduUserList.equals("")) {
			EduStudentChangeExt exitApply=eduUserList.get(0);
			SubmitApplyForm form=JaxbUtil.converyToJavaBean(exitApply.getContent(), SubmitApplyForm.class);
			SysUser sysUser=iUserBiz.findByFlow(exitApply.getUserFlow());
			String exitApplyType=exitApply.getApplyTypeId();
				dataMap.put("sid",exitApply.getEduUser().getSid());
				dataMap.put("userName", exitApply.getSysUser().getUserName());
				dataMap.put("majorName",exitApply.getEduUser().getMajorName());
			if (UserChangeApplyTypeEnum.Makeup.getId().equals(exitApplyType)) {
				dataMap.put("trainTypeName",exitApply.getEduUser().getTrainCategoryName());
				dataMap.put("trainOrgName", sysUser.getDeptName());
				dataMap.put("applyMakeUpCou",form.getApplyMakeUpCou());
				dataMap.put("teacherSugg", form.getTeacherSugg());
				String path = "/jsp/xjgl/print/makeUp.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "课程补考申请表.docx";  
			}
			if (UserChangeApplyTypeEnum.OutStudy.getId().equals(exitApplyType)) {
				dataMap.put("trainTypeName",exitApply.getEduUser().getTrainCategoryName());
				dataMap.put("trainOrgName", sysUser.getDeptName());
				dataMap.put("destination", form.getDestination());
				dataMap.put("startTime", form.getStartTime());
				dataMap.put("endTime", form.getEndTime());
				dataMap.put("teacherSugg", form.getTeacherSugg());
				dataMap.put("trainOrgSugg", form.getTrainOrgSugg());
				dataMap.put("studySuggg", form.getStudySuggg());
				dataMap.put("trainSugg", form.getTrainSugg());
				dataMap.put("applyReason", form.getApplyReason());
				
				String path = "/jsp/xjgl/print/outStudy.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "外出学习申请表.docx";  
			}
			if (UserChangeApplyTypeEnum.ChangeTrainType.getId().equals(exitApplyType)) {
				String teacherName="";
				if(StringUtil.isNotBlank(exitApply.getEduUser().getFirstTeacher())){
					teacherName=exitApply.getEduUser().getFirstTeacher();
				}
				if(StringUtil.isNotBlank(exitApply.getEduUser().getSecondTeacher())){
					teacherName=teacherName+" "+exitApply.getEduUser().getSecondTeacher();
				}
				
				dataMap.put("teacherName",teacherName);
				dataMap.put("trainTypeName", exitApply.getEduUser().getTrainCategoryName());
				dataMap.put("willTrainType", form.getWillTrainType());
				dataMap.put("docQualifiedNo", form.getDocQualifiedNo());
				dataMap.put("qualifiedNo", form.getQualifiedNo());
				dataMap.put("applyReason", form.getApplyReason());
				dataMap.put("teacherSugg", form.getTeacherSugg());
				dataMap.put("trainOrgSugg", form.getTrainOrgSugg());
				dataMap.put("postgraduSchSugg", form.getPostgraduSchSugg());
				
				String path = "/jsp/xjgl/print/changeTrainType.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "更改培养类型申请表.docx";
			}
			if(UserChangeApplyTypeEnum.ChangeTeacher.getId().equals(exitApplyType)){
				dataMap.put("trainTypeName", exitApply.getEduUser().getTrainCategoryName());
				dataMap.put("applyReason", form.getApplyReason());
				dataMap.put("teacherSugg", form.getTeacherSugg());
				dataMap.put("swichTeachSugg", form.getSwichTeachSugg());
				dataMap.put("trainOrgSugg", form.getTrainOrgSugg());
				dataMap.put("switchOrgSugg", form.getSwitchOrgSugg());
				dataMap.put("postgraduSchSugg", form.getPostgraduSchSugg());
				
				String path = "/jsp/xjgl/print/changeTeacher.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "更换导师申请表.docx";
			}
			if (UserChangeApplyTypeEnum.DelayExam.getId().equals(exitApplyType)) {
				dataMap.put("trainTypeName",exitApply.getEduUser().getTrainCategoryName());
				dataMap.put("delayExamTime", form.getDelayExamTime());
				dataMap.put("makeUpTime", form.getMakeUpTime());
				dataMap.put("delayCourName", form.getDelayCourName());
				dataMap.put("applyReason", form.getApplyReason());
				dataMap.put("postgraduSchSugg", form.getPostgraduSchSugg());
				
				String path = "/jsp/xjgl/print/delayExam.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "缓考申请表.docx";
			}
			if (UserChangeApplyTypeEnum.DelayStudy.getId().equals(exitApplyType)) {
				dataMap.put("trainTypeName",exitApply.getEduUser().getTrainCategoryName());
				dataMap.put("delayStudyTime", form.getDelayStudyTime());
				dataMap.put("againStudyTime", form.getAgainStudyTime());
				dataMap.put("delayStudycourName", form.getDelayStudycourName());
				dataMap.put("applyReason", form.getApplyReason());
				dataMap.put("postgraduSchSugg", form.getPostgraduSchSugg());
				dataMap.put("teacherSugg", form.getTeacherSugg());
				
				String path = "/jsp/xjgl/print/delayStudy.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "缓修申请表.docx";
			}
			if (UserChangeApplyTypeEnum.LeaveSchool.getId().equals(exitApplyType)) {
				dataMap.put("sex", exitApply.getSysUser().getSexName());
				dataMap.put("studyDegree", exitApply.getEduUser().getTrainTypeName());
				dataMap.put("trainTypeName",exitApply.getEduUser().getTrainCategoryName());
				dataMap.put("applyReason", form.getApplyReason());
				dataMap.put("teacherSugg", form.getTeacherSugg());
				dataMap.put("trainOrgSugg", form.getTrainOrgSugg());
				dataMap.put("postgraduSchSugg", form.getPostgraduSchSugg());
				
				String path = "/jsp/xjgl/print/leaveSchool.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "退学(转学)申请表.docx";
			}
			if (UserChangeApplyTypeEnum.StopStudy.getId().equals(exitApplyType)) {
				String yearY="  ";String monthY="  ";String dayY="  ";
				String yearN="  ";String monthN="  ";String dayN="  ";
				if(StringUtil.isNotBlank(form.getStopStudyStarTime())){
					String time[]=form.getStopStudyStarTime().split("-");
					yearY=time[0];
					monthY=time[1];
					dayY=time[2];
				}else{
					yearY="  - ";
					monthY=" - ";
					dayY=" - ";
				}
				if (StringUtil.isNotBlank(form.getStopStudyEndTime())) {
					String timeN[]=form.getStopStudyEndTime().split("-");
					yearN=timeN[0];
					monthN=timeN[1];
					dayN=timeN[2];
				}else{
					yearN=" - ";
					monthN=" - ";
					dayN=" - ";
				}
				String timeInfoY="";String timeInfoN="";String time="";
				timeInfoY=yearY+"年"+monthY+"月"+dayY+"日"+"至";
				timeInfoN=yearN+"年"+monthN+"月"+dayN+"日";
				time=timeInfoY+timeInfoN;
				
				dataMap.put("studyDegree", exitApply.getEduUser().getTrainTypeName());
				dataMap.put("sex", exitApply.getSysUser().getSexName());
				dataMap.put("trainTypeName",exitApply.getEduUser().getTrainCategoryName());
				dataMap.put("applyReason", form.getApplyReason());
				dataMap.put("time", time);
				dataMap.put("teacherSugg", form.getTeacherSugg());
				dataMap.put("trainOrgSugg", form.getTrainOrgSugg());
				dataMap.put("postgraduSchSugg", form.getPostgraduSchSugg());
				
				String path = "/jsp/xjgl/print/stopStudy.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "休学(复学)申请表.docx";
			}
			if (UserChangeApplyTypeEnum.DelayGraduate.getId().equals(exitApplyType)) {
				dataMap.put("studyDegree", exitApply.getEduUser().getTrainTypeName());
				dataMap.put("sex", exitApply.getSysUser().getSexName());
				dataMap.put("trainTypeName",exitApply.getEduUser().getTrainCategoryName());
				dataMap.put("applyReason", form.getApplyReason());
				dataMap.put("teacherSugg", form.getTeacherSugg());
				dataMap.put("trainOrgSugg", form.getTrainOrgSugg());
				dataMap.put("postgraduSchSugg", form.getPostgraduSchSugg());
				
				String path = "/jsp/xjgl/print/delayGraduate.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "研究生延期申请表.docx";
			}
			if (UserChangeApplyTypeEnum.ChangeMajor.getId().equals(exitApplyType)) {
				dataMap.put("swichmajorName", form.getSwichmajorName());
				dataMap.put("applyReason", form.getApplyReason());
				dataMap.put("teacherSugg", form.getTeacherSugg());
				dataMap.put("swichTeachSugg", form.getSwitchOrgSugg());
				dataMap.put("trainOrgSugg", form.getTrainOrgSugg());
				dataMap.put("switchOrgSugg", form.getSwitchOrgSugg());
				dataMap.put("postgraduSchSugg", form.getPostgraduSchSugg());
				
				String path = "/jsp/xjgl/print/changeMajor.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				name = "更换专业申请表.docx";
			}
			if(temeplete!=null){
				response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
				response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
				ServletOutputStream out = response.getOutputStream ();
				(new SaveToZipFile (temeplete)).save (out);
				out.flush ();
			}
		}
	}
}
	}