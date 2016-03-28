package com.pinde.sci.ctrl.sczyres;

import java.io.File;
import java.math.BigDecimal;
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

import com.pinde.core.jspform.ItemGroupData;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.Docx4jUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.hbres.RecruitCfgBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.pub.IAcademicResumeBiz;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sczyres.DoctorRecruitBiz;
import com.pinde.sci.biz.sczyres.DoctorSingupBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.res.CertificateTypeEnum;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.enums.sczyres.SczyRecDocTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.MsgTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.form.sczyres.ExtInfoForm;
import com.pinde.sci.form.sczyres.SingUpForm;
import com.pinde.sci.form.sczyres.WorkResumeForm;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.PubMsg;
import com.pinde.sci.model.mo.PubMsgExample;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResOrgSpeAssign;
import com.pinde.sci.model.mo.ResRecruitCfg;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysOrgExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.res.DateCfgMsg;

@Controller
@RequestMapping("/sczyres/doctor")
public class DoctorController extends GeneralController{
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IResDoctorBiz doctorBiz;
	@Autowired
	private DoctorSingupBiz doctorSingupBiz;
	@Autowired
	private DoctorRecruitBiz doctorRecruitBiz;
	@Autowired
	private NoticeBiz noticeBiz;
	@Autowired
	private IPubUserResumeBiz userResumeBiz;
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private RecruitCfgBiz recruitCfgBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IPubUserResumeBiz resumeBiz;
	
	@RequestMapping("/home")
	public String home(Integer currentPage , Model model){
		SysUser user = GlobalContext.getCurrentUser();
		ResDoctor doctor = doctorBiz.readDoctor(user.getUserFlow());
		model.addAttribute("doctor" , doctor);
		ResDoctorRecruit recruit = new ResDoctorRecruit();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		recruit.setDoctorFlow(user.getUserFlow());
		recruit.setRecruitYear(regYear);
		List<ResDoctorRecruit> recruits = this.doctorRecruitBiz.findDoctorRecruit(recruit , "CREATE_TIME" , null);
		if(!recruits.isEmpty()){
			recruit = recruits.get(recruits.size()-1);
			model.addAttribute("recruit" , recruit);
		}
		
		//读取系统消息
		PageHelper.startPage(currentPage,10);
		PubMsgExample example = new PubMsgExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andReceiverEqualTo(user.getUserFlow()).andMsgTypeIdEqualTo(MsgTypeEnum.Sys.getId());
		example.setOrderByClause("MSG_TIME desc");
		List<PubMsg> msgList = msgBiz.searchMessageWithBLOBs(example);
		if(msgList!=null && msgList.size()>0){
			model.addAttribute("msgList",msgList);
			
			int newMsg = 0;
			for(PubMsg msg : msgList){
				if(!GlobalConstant.FLAG_Y.equals(msg.getReceiveFlag())){
					newMsg++;
				}
			}
			model.addAttribute("newMsg",newMsg);
		}
		
		return "sczyres/doctor/index";
	}
	
	@RequestMapping("/readMsg")
	@ResponseBody
	public String readMsg(PubMsg msg){
		int result = msgBiz.updateMsg(msg);
		if(GlobalConstant.ZERO_LINE!=result){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	@RequestMapping("/singup")
	public String singup(Model model){
		SysUser user = GlobalContext.getCurrentUser();
		String userFlow = user.getUserFlow();
		user = this.userBiz.readSysUser(userFlow);
		model.addAttribute("user" , user);
		ResDoctor doctor = doctorBiz.readDoctor(userFlow);
		model.addAttribute("doctor" , doctor);
		PubUserResume resume = userResumeBiz.readPubUserResume(userFlow);
		if(resume!=null){
			String resumeXml = resume.getUserResume();
			ExtInfoForm extInfo = doctorSingupBiz.parseExtInfoXml(resumeXml);
			model.addAttribute("extInfo" ,extInfo);
		}
		if(doctor!=null && RegStatusEnum.Passed.getId().equals(doctor.getDoctorStatusId())){
		//是审核通过
		//此时只能查看报名信息
			String regYear = InitConfig.getSysCfg("res_reg_year");
			ResDoctorRecruit recruit = new ResDoctorRecruit();
			recruit.setDoctorFlow(user.getUserFlow());
			recruit.setRecruitYear(regYear);
			List<ResDoctorRecruit> recruits = this.doctorRecruitBiz.findDoctorRecruit(recruit , "CREATE_TIME" , null);
			model.addAttribute("recruits" , recruits);
			return "sczyres/doctor/singupinfofordoctor";
		}
		
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		String currDate = DateUtil.getCurrDate();
		DateCfgMsg regDateCfgMsg = new DateCfgMsg(recruitCfg);
		regDateCfgMsg.setRegDateMsg(currDate);
		if(regDateCfgMsg.getAllowReg()){
			return "sczyres/doctor/singup";	
		}else{
			model.addAttribute("regCfgMsg" ,regDateCfgMsg);
            return "sczyres/doctor/notallowsingup";			
		}
		
	}
	
	/**
	 * 学员调剂
	 * @return
	 */
	@RequestMapping("/swap")
	public String swap(Model model){
		SysUser user = GlobalContext.getCurrentUser();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		//是否确认录取过
		ResDoctorRecruit recruit = new ResDoctorRecruit();
		recruit.setDoctorFlow(user.getUserFlow());
		recruit.setRecruitYear(regYear);
		List<ResDoctorRecruit> recruits = this.doctorRecruitBiz.findDoctorRecruit(recruit , "CREATE_TIME" , null);
		for(ResDoctorRecruit rdr:recruits){
			if(GlobalConstant.FLAG_Y.equals(rdr.getRecruitFlag())){//目前是这个限制 ， 如果需要判断是否确认录取 是否强制学生点击拒绝录取
				model.addAttribute("msg" , "已经被录取不可调剂") ;
				return "sczyres/doctor/notallowswap";
			}
		}
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		String currDate = DateUtil.getCurrDate();
		DateCfgMsg regDateCfgMsg = new DateCfgMsg(recruitCfg);
		regDateCfgMsg.setSwapDateMsg(currDate);
		if(regDateCfgMsg.getAllowSwap()){
			SysOrgExample orgExample = new SysOrgExample();
			orgExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
			orgExample.setOrderByClause("ORDINAL");
			List<SysOrg> orgs = this.orgBiz.searchOrgByExample(orgExample);
			model.addAttribute("hospitals", orgs);
			return "sczyres/doctor/swap";
		}else{
			model.addAttribute("msg" , "当前调剂"+regDateCfgMsg.getMsg()) ;
			return "sczyres/doctor/notallowswap";
		}
		
		//是否在调剂日期中
	}
	
	@RequestMapping("/getrecruit")
	public String getRecruit(Model model){
		SysUser user = GlobalContext.getCurrentUser();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		SysOrgExample orgExample = new SysOrgExample();
		orgExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
		orgExample.setOrderByClause("ORDINAL");
		List<SysOrg> orgs = this.orgBiz.searchOrgByExample(orgExample);
		model.addAttribute("hospitals", orgs);
		ResDoctor doctor = doctorBiz.readDoctor(user.getUserFlow());
		model.addAttribute("doctor" , doctor);
		ResDoctorRecruit recruit = new ResDoctorRecruit();
		recruit.setDoctorFlow(user.getUserFlow());
		recruit.setRecruitYear(regYear);
		List<ResDoctorRecruit> recruits = this.doctorRecruitBiz.findDoctorRecruit(recruit , "CREATE_TIME" , null);
		if(!recruits.isEmpty()){
			recruit = recruits.get(0);
			model.addAttribute("recruit" , recruit);
			List<ResOrgSpeAssign> catspes = this.doctorRecruitBiz.findSpeAssign(recruit.getOrgFlow(), regYear);
			model.addAttribute("catspes" , catspes);
			if(StringUtil.isNotBlank(recruit.getCatSpeId())){
				List<SysDict> spes = this.doctorSingupBiz.findSpe(recruit.getCatSpeId());
				model.addAttribute("spes" , spes);	
			}
		}
		return "sczyres/doctor/recruit";
	}
	
	@RequestMapping("/saveRecruit")
	@ResponseBody
	public String saveRecruit(ResDoctorRecruitWithBLOBs recruit){
		SysUser user = GlobalContext.getCurrentUser();
		recruit.setDoctorFlow(user.getUserFlow());
		this.doctorSingupBiz.saveRecruit(recruit);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	@RequestMapping("/findcatspe")
	@ResponseBody
	public Object findCatSpe(String orgFlow){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		List<ResOrgSpeAssign> resultSpes = new ArrayList<ResOrgSpeAssign>();
		List<ResOrgSpeAssign> spes = this.doctorRecruitBiz.findSpeAssign(orgFlow, regYear);
		for(ResOrgSpeAssign spe:spes){
			if(spe.getAssignPlan()!=null && spe.getAssignPlan().compareTo(new BigDecimal(0))>0){
				resultSpes.add(spe);
			}
		}
		return resultSpes;
		
	}
	
	@RequestMapping("/findspe")
	@ResponseBody
	public Object findSpe(String catSpeId){
		return this.doctorSingupBiz.findSpe(catSpeId);
	}
	
	@RequestMapping("/submitSingup")
	@ResponseBody
	public String submitSingup(SingUpForm form){
		SysUser user = form.getUser();
		if (StringUtil.isBlank(user.getCretTypeId())) {
			user.setCretTypeId(CertificateTypeEnum.Shenfenzheng.getId());
			user.setCretTypeName(CertificateTypeEnum.Shenfenzheng.getName());
		}
		if(StringUtil.isNotBlank(user.getIdNo())){
			SysUser existUser = this.userBiz.findByIdNoAndCretTypeNotSelf(user.getUserFlow(), user.getIdNo(), user.getCretTypeId());
			if(existUser!=null){
				return "证件号码已存在";
			}
		}
		ResDoctor doctor = form.getDoctor();
		if(StringUtil.isNotBlank(user.getSexId())){
			user.setSexName(UserSexEnum.getNameById(user.getSexId()));	
		}
		if(StringUtil.isNotBlank(user.getCretTypeId())){
			user.setCretTypeName(CertificateTypeEnum.getNameById(user.getCretTypeId()));	
		}
		if(StringUtil.isNotBlank(user.getEducationId())){
			user.setEducationName(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));	
		}
		if(StringUtil.isNotBlank(user.getDegreeId())){
			user.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(user.getDegreeId()));	
		}
		if (StringUtil.isNotBlank(doctor.getDoctorTypeId())) {
			doctor.setDoctorTypeName(SczyRecDocTypeEnum.getNameById(doctor.getDoctorTypeId()));
		}
		this.doctorSingupBiz.submitSingup(form);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	@RequestMapping("/submitRecruit")
	@ResponseBody
	public String submitRecruit(ResDoctorRecruitWithBLOBs recruit){
		try{
			SysUser user = GlobalContext.getCurrentUser();
			recruit.setDoctorFlow(user.getUserFlow());
			this.doctorSingupBiz.submitRecruit(recruit);
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}catch(RuntimeException re){
			return re.getMessage();
		}
		
	}
	@RequestMapping("/msg")
	public String msg(Integer currentPage , Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(currentPage,10);
		List<InxInfo> messages = this.noticeBiz.findNotice(info);
		model.addAttribute("messages",messages);
		return "sczyres/doctor/msg";
	}
	
	@RequestMapping("/confirmRecruit")
	@ResponseBody
	public String confirmRecruit(ResDoctorRecruitWithBLOBs recruit,Model model){
		doctorRecruitBiz.editDoctorRecruit(recruit);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	@RequestMapping("/getsingupinfo")
	public String getSingUpInfo(String userFlow , Model model){
		showSingUpInfo(userFlow , model);
		return "sczyres/doctor/singupinfo";
	}
	
	@RequestMapping("/getsingupinfofordialog")
	public String getSingUpInfoForDialog(String userFlow , Model model){
		showSingUpInfo(userFlow , model);
		return "sczyres/doctor/singupinfofordialog";
	}
	
	@RequestMapping("/getsingupinfoaudit")
	public String getSingUpInfoForAudit(String userFlow , Model model){
		showSingUpInfo(userFlow , model);
		return "sczyres/doctor/singupinfoforaudit";
	}
	
	private void showSingUpInfo(String userFlow , Model model){
		SysUser user = this.userBiz.readSysUser(userFlow);
		model.addAttribute("user" , user);
		ResDoctor doctor = doctorBiz.readDoctor(userFlow);
		model.addAttribute("doctor" , doctor);
		PubUserResume resume = userResumeBiz.readPubUserResume(userFlow);
		if(resume!=null){
			String resumeXml = resume.getUserResume();
			ExtInfoForm extInfo = doctorSingupBiz.parseExtInfoXml(resumeXml);
			model.addAttribute("extInfo" ,extInfo);
		}
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResDoctorRecruit recruit = new ResDoctorRecruit();
		recruit.setDoctorFlow(user.getUserFlow());
		recruit.setRecruitYear(regYear);
		List<ResDoctorRecruit> recruits = this.doctorRecruitBiz.findDoctorRecruit(recruit , "CREATE_TIME" , null);
		model.addAttribute("recruits" , recruits);
	}
	
	
	/**
	 * 打印
	 * @param userFlow
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/print")
	public void print(String userFlow, HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map<String, Object> dataMap = new HashMap<String, Object>();
		String resRegYear=InitConfig.getSysCfg("res_reg_year");
		dataMap.put("resRegYear", resRegYear);
		SysUser sysUser = this.userBiz.readSysUser(userFlow);
		if(sysUser != null){
			dataMap.put("userName", sysUser.getUserName());
			dataMap.put("userBirthday", sysUser.getUserBirthday());
			dataMap.put("sexName", sysUser.getSexName());
			dataMap.put("nationName", sysUser.getNationName());
			dataMap.put("educationName", sysUser.getEducationName());
			dataMap.put("degreeName", sysUser.getDegreeName());
			dataMap.put("idNo", sysUser.getIdNo());
			dataMap.put("userPhone", sysUser.getUserPhone());
			dataMap.put("userAddress", sysUser.getUserAddress());
			dataMap.put("userEmail", sysUser.getUserEmail());
		}
		ResDoctor doctor = doctorBiz.readDoctor(userFlow);
		if(doctor != null){
			dataMap.put("foreignSkills", doctor.getForeignSkills());
			dataMap.put("specialized", doctor.getSpecialized());
			String doctorLicenseFlag =  doctor.getDoctorLicenseFlag();
			if(GlobalConstant.FLAG_Y.equals(doctorLicenseFlag)){
				doctorLicenseFlag = "有";
			}else if(GlobalConstant.FLAG_N.equals(doctorLicenseFlag)){
				doctorLicenseFlag = "无";
			}
			dataMap.put("doctorLicenseFlag", doctorLicenseFlag);
			dataMap.put("graduatedName", doctor.getGraduatedName());
			dataMap.put("graduationTime", doctor.getGraduationTime());
			dataMap.put("certificateNo", doctor.getCertificateNo());
			dataMap.put("degreeNo", doctor.getDegreeNo());
			dataMap.put("qualifiedNo", doctor.getQualifiedNo());
			dataMap.put("regNo", doctor.getRegNo());
			dataMap.put("workOrgName", doctor.getWorkOrgName());
			dataMap.put("doctorTypeName", doctor.getDoctorTypeName());
		}
		PubUserResume resume = userResumeBiz.readPubUserResume(userFlow);
		if(resume!=null){
			String resumeXml = resume.getUserResume();
			ExtInfoForm extInfo = doctorSingupBiz.parseExtInfoXml(resumeXml);
			if(extInfo != null){
				dataMap.put("nativePlace", extInfo.getNativePlace());
				dataMap.put("healthStatus", extInfo.getHealthStatus());
				dataMap.put("political", extInfo.getPolitical());
				dataMap.put("maritalStatus", extInfo.getMaritalStatus());
				dataMap.put("beforeCase", extInfo.getBeforeCase());
				dataMap.put("societyWork", extInfo.getSocietyWork());
				String yearGraduateFlag =  extInfo.getYearGraduateFlag();
				if(GlobalConstant.FLAG_Y.equals(yearGraduateFlag)){
					yearGraduateFlag = "是";
				}else if(GlobalConstant.FLAG_N.equals(yearGraduateFlag)){
					yearGraduateFlag = "否";
				}
				dataMap.put("yearGraduateFlag", yearGraduateFlag);
				dataMap.put("birthProvName", extInfo.getBirthProvName());
				dataMap.put("birthCityName", extInfo.getBirthCityName());
				dataMap.put("birthAreaName", extInfo.getBirthAreaName());
				dataMap.put("homeAddress", extInfo.getHomeAddress());
				dataMap.put("homePhome", extInfo.getHomePhome());
				dataMap.put("zipCode", extInfo.getZipCode());
				dataMap.put("otherWay", extInfo.getOtherWay());
				List<WorkResumeForm> workResumeList = extInfo.getWorkResumeList();
				if(workResumeList != null && !workResumeList.isEmpty()){
					List<ItemGroupData> yearPlanTargetList = new ArrayList<ItemGroupData>();
					for(WorkResumeForm wrf :workResumeList){
						ItemGroupData  igd = new ItemGroupData();
						Map<String , Object> objMap = new HashMap<String, Object>();
						objMap.put("clinicalRoundDate", wrf.getClinicalRoundDate());
						objMap.put("dateLength", wrf.getDateLength());
						objMap.put("hospitalName", wrf.getHospitalName());
						objMap.put("hospitalLevel", wrf.getHospitalLevel());
						objMap.put("deptName", wrf.getDeptName());
						objMap.put("postName", wrf.getPostName());
						objMap.put("witness", wrf.getWitness());
						objMap.put("witnessPost", wrf.getWitnessPost());
						objMap.put("witnessPhone", wrf.getWitnessPhone());
						igd.setObjMap(objMap);
						yearPlanTargetList.add(igd);
					}
					dataMap.put("yearPlanTargetList", yearPlanTargetList);
				}
			}
		}
		
		//插入头像图片
		String value = "";
		if (doctor != null) {
			String doctorHeadImg = StringUtil.defaultString(sysUser.getUserHeadImg());
			String cfgUrl = InitConfig.getSysCfg("upload_base_url");
			doctorHeadImg = cfgUrl+"/"+doctorHeadImg;
			if (StringUtil.isBlank(doctorHeadImg)) {
				value = "";
			} else {
				value = "<img src='"+doctorHeadImg+"' width='80' height='150'  alt='证件照'/>";
			}
		}
		dataMap.put("headImg", value);

		WordprocessingMLPackage temeplete = new WordprocessingMLPackage();
		String path = "/jsp/sczyres/print/printTemeplete.docx";//模板
		ServletContext context =  request.getServletContext();
		String watermark = GeneralMethod.getWatermark(GlobalConstant.FLAG_Y);
		temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
		if(temeplete!=null){
			String name = "培训学员注册申请表.docx"; 
			response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
			response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
			ServletOutputStream out = response.getOutputStream ();
			(new SaveToZipFile (temeplete)).save (out);
			out.flush ();
		}
	}
	
	@RequestMapping("/index")
	public String index(){
		SysUser user = GlobalContext.getCurrentUser();
		SysUserRole userRole = new SysUserRole();
		userRole.setUserFlow(user.getUserFlow());
		userRole.setWsId(GlobalConstant.RES_WS_ID);
		List<SysUserRole> userRoleList = userRoleBiz.searchUserRole(userRole);
		if(!userRoleList.isEmpty()){
			userRole = userRoleList.get(0);
		}
//		SysRole role = roleBiz.read(userRole.getRoleFlow()); 
//		if(role!=null){
//			setSessionAttribute(GlobalConstant.CURRENT_USER, user);	
//			return "redirect:"+getRoleUrl(role.getRoleFlow());
//		}
//		return null;
		return "redirect:"+this.getRoleUrl(userRole.getRoleFlow());
		
	}
	public String getRoleUrl(String roleFlow){
		if (StringUtil.isNotBlank(roleFlow)){
			if (roleFlow.equals(InitConfig.getSysCfg("res_global_role_flow"))) {//省级部门
				return "/sczyres/manage/home";
			} else if (roleFlow.equals(InitConfig.getSysCfg("res_admin_role_flow"))) {//医院管理员
				return "/sczyres/hosptial/home";
			} else if (roleFlow.equals(InitConfig.getSysCfg("res_doctor_role_flow"))) {//学员
				return "/sczyres/doctor/home";
			}
		}
		return "";
	}
	
	@RequestMapping("/patch")
	public String patch(Model model){
		try{
			ResDoctor doctor = new ResDoctor();
			doctor.setRecordStatus(GlobalConstant.FLAG_Y);
			List<ResDoctor> doctors = this.doctorBiz.searchByDoc(doctor);
			model.addAttribute("count" , doctors.size());
			int patchCount = 0;
			for(ResDoctor doc : doctors){
				String doctorFlow = doc.getDoctorFlow();
				PubUserResume resume = resumeBiz.readPubUserResume(doctorFlow);
				String resumeInfo = resume.getUserResume();
				ExtInfoForm extInfo = doctorSingupBiz.parseExtInfoXml(resumeInfo);
				if(extInfo==null){
					continue;
				}
				String workOrgName = extInfo.getSocietyWork();
				if(StringUtil.isNotBlank(workOrgName)){
					ResDoctor patch = new ResDoctor();
					patch.setDoctorFlow(doctorFlow);
					patch.setWorkOrgName(workOrgName);
					this.doctorSingupBiz.modDoctorByDoctorFlow(doctor);
					patchCount++;
				}
				
			}
			model.addAttribute("successCount" , patchCount);
		}catch(Exception e){
			e.printStackTrace();
			model.addAttribute("error" , e.getMessage());
		}
		
		return "sczyres/doctor/patch";
	}
	
	/**
	 * 打印准考证
	 * @param userFlow
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/printAdmissionCard")
	public void printAdmissionCard(String userFlow, HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map<String, Object> dataMap = new HashMap<String, Object>();
		String resRegYear=InitConfig.getSysCfg("res_reg_year");
		dataMap.put("resRegYear", resRegYear);
		SysUser sysUser = this.userBiz.readSysUser(userFlow);
		if(sysUser != null){
			dataMap.put("userName", sysUser.getUserName());
			dataMap.put("sexName", sysUser.getSexName());
			dataMap.put("idNo", sysUser.getIdNo());
		}
		
		//插入头像图片
		String value = "";
		ResDoctor doctor = doctorBiz.readDoctor(userFlow);
		if (doctor != null) {
			String doctorHeadImg = StringUtil.defaultString(sysUser.getUserHeadImg());
			String cfgUrl = InitConfig.getSysCfg("upload_base_url");
			doctorHeadImg = cfgUrl+"/"+doctorHeadImg;
			if (StringUtil.isBlank(doctorHeadImg)) {
				value = "";
			} else {
				value = "<img src='"+doctorHeadImg+"' width='80' height='150'  alt='证件照'/>";
			}
		}
		dataMap.put("headImg", value);

		WordprocessingMLPackage temeplete = new WordprocessingMLPackage();
		String path = "/jsp/sczyres/print/admissionCardTemeplete.docx";//准考证模板
		ServletContext context =  request.getServletContext();
		//String watermark = GeneralMethod.getWatermark(GlobalConstant.FLAG_N);
		temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,null,true);
		if(temeplete!=null){
			String name = resRegYear+"招生准考证.docx"; 
			response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
			response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
			ServletOutputStream out = response.getOutputStream ();
			(new SaveToZipFile (temeplete)).save (out);
			out.flush ();
		}
	}

}
