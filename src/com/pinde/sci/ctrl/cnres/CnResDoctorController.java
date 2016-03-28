package com.pinde.sci.ctrl.cnres;


import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.docx4j.openpackaging.io.SaveToZipFile;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.pdf.DocumentVo;
import com.pinde.core.pdf.PdfDocumentGenerator;
import com.pinde.core.pdf.utils.ResourceLoader;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.Docx4jUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.core.util.VelocityUtil;
import com.pinde.sci.biz.cnres.ICnResExamBiz;
import com.pinde.sci.biz.cnres.ICnResGradeBiz;
import com.pinde.sci.biz.cnres.ICnResDoctorRecruitBiz;
import com.pinde.sci.biz.cnres.ICnResNoticeBiz;
import com.pinde.sci.biz.cnres.ICnResRecruitCfgBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResOrgSpeAssignBiz;
import com.pinde.sci.biz.res.IResRegBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.ResExamDoctorMapper;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.res.ExamTypeEnum;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResExam;
import com.pinde.sci.model.mo.ResExamDoctor;
import com.pinde.sci.model.mo.ResExamSite;
import com.pinde.sci.model.mo.ResGradeBorderline;
import com.pinde.sci.model.mo.ResOrgSpeAssign;
import com.pinde.sci.model.mo.ResRecruitCfg;
import com.pinde.sci.model.mo.ResReg;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysOrgExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.DateCfgMsg;
import com.pinde.sci.model.res.OrgRecruitInfo;

@Controller
@RequestMapping("/cnres/singup")
public class CnResDoctorController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(CnResDoctorController.class);

	@Autowired
	private IUserBiz userBiz;
	@Resource
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private IResOrgSpeAssignBiz speAssignBiz;
	@Autowired
	private ICnResNoticeBiz noticeBiz;
	@Autowired
	private ICnResGradeBiz gradeManage;
	@Autowired
	private ICnResRecruitCfgBiz recruitCfgBiz;
	@Autowired
	private ICnResExamBiz examManageBiz;
	@Autowired
	private IFileBiz pubFileBiz;
	@Resource
	private IResRegBiz resRegBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private ResExamDoctorMapper examDoctorMapper;
	@Autowired
	private ICnResDoctorRecruitBiz doctorRecruitBiz;
	
	/**
	 * 住院医师主界面
	 */
	@RequestMapping(value="/doctor")
	public String index(Model model){
		SysUser user = GlobalContext.getCurrentUser();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResDoctor doctor = resDoctorBiz.readDoctor(user.getUserFlow());
		ResReg reg = resRegBiz.searchResReg(user.getUserFlow(),regYear);
		if(UserStatusEnum.Activated.getId().equals(user.getStatusId())){//用户激活
			if (doctor != null && !RegStatusEnum.UnSubmit.getId().equals(doctor.getDoctorStatusId())
					&& !RegStatusEnum.Passing.getId().equals(doctor.getDoctorStatusId())
					&& !RegStatusEnum.UnPassed.getId().equals(doctor.getDoctorStatusId())) {//报名审核成功，则跳转个人页面
				return "cnres/doctor/home";
			} else if (reg == null || (reg != null && RegStatusEnum.UnSubmit.getId().equals(doctor.getDoctorStatusId()))){//非首次报名，继续操作：选择类型-信息登记
				model.addAttribute("doctor",doctor);
				model.addAttribute("user",user);
				return "inx/cnres/typeSelect1";
			} else if (RegStatusEnum.Passing.getId().equals(doctor.getDoctorStatusId())) {//状态为待审核，则显示待审核界面
				model.addAttribute("userEmail", user.getUserEmail());
				model.addAttribute("userIdno", user.getIdNo());
				model.addAttribute("userPhone", user.getUserPhone());
				return "inx/cnres/auditResult";
			} else if (RegStatusEnum.UnPassed.getId().equals(doctor.getDoctorStatusId())) {//状态为报名审核不通过，则显示审核不通过提示界面
				model.addAttribute("doctor",doctor);
				return "inx/cnres/notPass";
			}
		}
		return "/inx/cnres/login";
	}
	
	@RequestMapping(value="/doctorMain")
	public String doctorMain(Model model){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		SysUser currUser = GlobalContext.getCurrentUser();
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		String printEndDate = recruitCfg.getPrintEndDate();
		model.addAttribute("recruitCfg" , recruitCfg);
		String currDate = DateUtil.getCurrDate();
		
		
		ResExamDoctor examDoctor = resDoctorBiz.searchExamDoctor(currUser.getUserFlow(), ExamTypeEnum.Register.getId(), regYear);
		if(examDoctor != null){
			ResDoctor doctor = this.resDoctorBiz.readDoctor(examDoctor.getDoctorFlow());
			ResGradeBorderline gradeBorderline = this.gradeManage.findResGradeBorderlineByExamFlowAndSpeId(examDoctor.getExamFlow() , doctor.getSpecialized());
			
			if(gradeBorderline!=null && GlobalConstant.FLAG_Y.equals(gradeBorderline.getPublishFlag())){
				return "redirect:/cnres/singup/doctor/scoreSearch";
			}
			
	       if(currDate.compareTo(printEndDate)>0){
	    	   if(gradeBorderline==null || !GlobalConstant.FLAG_Y.equals(gradeBorderline.getPublishFlag())){
	   			model.addAttribute("scoreSearchMsg" , "分数未公布,请耐心等待");
	   		   }
			}
		}
		return "cnres/doctor/doctorMain";
	}
	
	@RequestMapping(value="/doctor/userInfo")
	public String userInfo(Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		model.addAttribute("user",currUser);
		
		ResDoctor doctor = resDoctorBiz.readDoctor(currUser.getUserFlow());
		model.addAttribute("doctor",doctor);
		return "cnres/doctor/user";
	}
	
	@RequestMapping("/doctor/noticelist")
	public String noticeList(Integer currentPage , Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(currentPage,10);
		List<InxInfo> infos = this.noticeBiz.findNotice(info);
		model.addAttribute("infos",infos);
		return "cnres/doctor/noticelist";
	}
	
	@RequestMapping("/doctor/printexamticket")
	@ResponseBody
	public Object printExamTicket(){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		String currDate = DateUtil.getCurrDate();
		DateCfgMsg printDateCfgMsg = new DateCfgMsg(recruitCfg);
		printDateCfgMsg.setPrintDateMsg(currDate);
		return printDateCfgMsg;
	}
	
	@RequestMapping(value="/doctor/scoreSearch")
	public String scoreSearch(String msg , Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResExamDoctor examDoctor = resDoctorBiz.searchExamDoctor(currUser.getUserFlow(), ExamTypeEnum.Register.getId(), regYear);
		if(examDoctor==null || examDoctor.getExamResult()==null){
			return "cnres/doctor/noresult";
		}
		model.addAttribute("examDoctor" , examDoctor);
		
		String examFlow = examDoctor.getExamFlow();
		ResDoctor doctor = this.resDoctorBiz.readDoctor(examDoctor.getDoctorFlow());
		
		//设置学员录取确认过期标记 
		this.doctorRecruitBiz.setDoctorConfirmFlagForOutOfDate(regYear, currUser.getUserFlow());
		
		BigDecimal gradeBorderline = this.gradeManage.findGradeBorderlineByExamFlowAndSpe(examFlow, doctor.getSpecialized());
		List<ResDoctorRecruit> doctorRecruits = this.gradeManage.findResDoctorRecruits(regYear, currUser.getUserFlow());
		//最新的一条招录记录
		ResDoctorRecruitWithBLOBs doctorRecruit = null;
		if(doctorRecruits!=null && doctorRecruits.size()>0){
			doctorRecruit = (ResDoctorRecruitWithBLOBs)this.doctorRecruitBiz.readResDoctorRecruit(doctorRecruits.get(0).getRecruitFlow());
			model.addAttribute("doctorRecruit" , doctorRecruit);
			Collections.reverse(doctorRecruits);
			model.addAttribute("doctorRecruits" , doctorRecruits);
		}
		
		boolean guoxianFlag = false;
		boolean isShowRecruits = true;
		//首先判断是否发布分数线和是否过线
		if(gradeBorderline==null){
			model.addAttribute("fillMsg" , "暂未发布分数线");
			isShowRecruits = false;
		}else if(examDoctor.getExamResult().compareTo(gradeBorderline)<0){
			model.addAttribute("fillMsg" , "未达志愿填报分数线,无法填报志愿");
			model.addAttribute("showCfgDate" , GlobalConstant.FLAG_N);
			isShowRecruits = false;
		}else if(examDoctor.getExamResult().compareTo(gradeBorderline)>=0){
			guoxianFlag = true;
		}
		//查询招录设置
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		model.addAttribute("recruitCfg" , recruitCfg);
		if(guoxianFlag){
			//默认不可以填报志愿
			String isCanFill = GlobalConstant.FLAG_N;
			//默认不显示确认录取/拒绝
			String isConfirm = GlobalConstant.FLAG_N;//N:请等待确认 Y:显示确认 F：确认过期
			//当学员不被录取或者拒绝录取时 是否可以再填 默认不可以
			String isSwapFill = GlobalConstant.FLAG_N;
			String wishBeginDate = recruitCfg.getWishBeginDate();
			String wishEndDate = recruitCfg.getWishEndDate();
			String admitBeginDate = recruitCfg.getAdmitBeginDate();
			String admitEndDate = recruitCfg.getAdmitEndDate();
			String swapBeginDate = recruitCfg.getSwapBeginDate();
			String swapEndDate = recruitCfg.getSwapEndDate();
			//获取当前日期
			String currDate = DateUtil.getCurrDate();
			//是否是志愿填报开放日期之间
			if(currDate.compareTo(wishBeginDate)>=0 && currDate.compareTo(wishEndDate)<=0){
				if(doctorRecruit==null){
					isCanFill = GlobalConstant.FLAG_Y;
				}
			}else if(currDate.compareTo(wishBeginDate)<0){
				model.addAttribute("fillMsg" , "填报志愿暂未开放,请耐心等待");
				isShowRecruits = false;
			}else{
				model.addAttribute("fillMsg" , "填报志愿时间已经截止");
			}
			
			//可以显示确认录取/拒绝
			if(currDate.compareTo(admitEndDate)<=0){
				isConfirm = GlobalConstant.FLAG_Y;
			}else if(currDate.compareTo(admitEndDate)>0){
				isConfirm = GlobalConstant.FLAG_F;
				model.addAttribute("fillMsg" , "确认录取结果时间已经截止");
			}
			
			//可以再次填报 再次期间 确认录取没有时间限制
			if(currDate.compareTo(swapBeginDate)>=0 && currDate.compareTo(swapEndDate)<=0){
				isConfirm = GlobalConstant.FLAG_Y;
				if(doctorRecruit!=null && (GlobalConstant.FLAG_N.equals(doctorRecruit.getRecruitFlag()) || GlobalConstant.FLAG_N.equals(doctorRecruit.getConfirmFlag()))){
					isSwapFill = GlobalConstant.FLAG_Y;
				}
			}else if(currDate.compareTo(swapEndDate)>0){
				isSwapFill = GlobalConstant.FLAG_F;
				isConfirm = GlobalConstant.FLAG_Y;
				model.addAttribute("fillMsg" , "学员调剂日期已经截止");
			}
			
			if(isCanFill.equals(GlobalConstant.FLAG_Y) || isSwapFill.equals(GlobalConstant.FLAG_Y)){
				SysOrgExample orgExample = new SysOrgExample();
				orgExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
				List<SysOrg> orgs = this.orgBiz.searchOrgByExample(orgExample);
				model.addAttribute("hospitals", orgs);
			}
			
			model.addAttribute("isShowRecruits" , isShowRecruits);
			model.addAttribute("isCanFill" , isCanFill);
			model.addAttribute("isConfirm" , isConfirm);
			model.addAttribute("isSwapFill" , isSwapFill);
		}
		
		return "cnres/doctor/cjcx";
	}
	
	@RequestMapping("/doctor/delrecruit")
	@ResponseBody
	public String delRecruit(String recruitFlow){
		ResDoctorRecruit exitRecruit = this.doctorRecruitBiz.readResDoctorRecruit(recruitFlow);
		if(exitRecruit!=null && GlobalConstant.FLAG_N.equals(exitRecruit.getRetestFlag())){
			ResDoctorRecruitWithBLOBs recruit = new ResDoctorRecruitWithBLOBs();
			recruit.setRecruitFlow(recruitFlow);
			recruit.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			this.doctorRecruitBiz.editDoctorRecruit(recruit);
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}else{
			return GlobalConstant.OPRE_FAIL_FLAG;
		}
	}
	
	@RequestMapping("/doctor/findspe")
	@ResponseBody
	public Object findSpe(String orgFlow){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		List<ResOrgSpeAssign> resultSpes = new ArrayList<ResOrgSpeAssign>();
		List<ResOrgSpeAssign> spes = this.speAssignBiz.searchSpeAssign(orgFlow, regYear);
		List<ResOrgSpeAssign> spe0700 = new ArrayList<ResOrgSpeAssign>();
		SysUser currUser = GlobalContext.getCurrentUser();
		
		if("03".equals(currUser.getEducationId())){
			for(ResOrgSpeAssign spe:spes){
				if("0700".equals(spe.getSpeId())){
					spe0700.add(spe);
				}
			}
			return spe0700;
		}else{
			for(ResOrgSpeAssign spe:spes){
				if(spe.getAssignPlan()!=null && spe.getAssignPlan().compareTo(new BigDecimal(0))>0){
					resultSpes.add(spe);
				}
			}
			return resultSpes;
		}
		
	}
	
	@RequestMapping("/doctor/submitrecruit")
	public String submitRecruit(ResDoctorRecruitWithBLOBs doctorRecruit , Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		doctorRecruit.setDoctorFlow(currUser.getUserFlow());
		if(StringUtil.isNotBlank(doctorRecruit.getOrgFlow())){
			SysOrg org = this.orgBiz.readSysOrg(doctorRecruit.getOrgFlow());
			doctorRecruit.setOrgName(org.getOrgName());
		}
		if(StringUtil.isNotBlank(doctorRecruit.getSpeId())){
			ResOrgSpeAssign spe = this.speAssignBiz.findSpeAssignByFlow(doctorRecruit.getSpeId());
			doctorRecruit.setSpeId(spe.getSpeId());
			doctorRecruit.setSpeName(spe.getSpeName());
		}
		//查询招录计划
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResOrgSpeAssign speAssign =this.speAssignBiz.searchSpeAssign(doctorRecruit.getOrgFlow() , regYear , doctorRecruit.getSpeId());
		if(speAssign!=null && speAssign.getAssignPlan()!=null && speAssign.getAssignPlan().compareTo(new BigDecimal(0))>0){
			//查询已确认招录人数
			ResDoctorRecruit searchRecruit = new ResDoctorRecruit();
			searchRecruit.setOrgFlow(doctorRecruit.getOrgFlow());
			searchRecruit.setSpeId(speAssign.getSpeId());
			searchRecruit.setRecruitYear(regYear);
			searchRecruit.setConfirmFlag(GlobalConstant.FLAG_Y);
			Integer confirmCount = doctorRecruitBiz.searchDoctorNum(searchRecruit);
			if(speAssign.getAssignPlan().compareTo(new BigDecimal(confirmCount))>0){
				this.gradeManage.submitRecruit(doctorRecruit);
				model.addAttribute("msg" , "志愿填报成功");
			}else{
				model.addAttribute("msg" , "所填志愿专业人数已满");
			}
		}else{
			model.addAttribute("msg" , "所填志愿专业没有招录计划");
		}
		
		return "redirect:/cnres/singup/doctor/scoreSearch";
	}
	
	@RequestMapping("/doctor/confirmrecruit")
	@ResponseBody
	public String confirmRecruit(ResDoctorRecruitWithBLOBs doctorRecruit){
		doctorRecruitBiz.editDoctorRecruit(doctorRecruit);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	@RequestMapping("/doctor/showjidirecruitinfo")
	public String showJidiRecruitInfo(Model model){
		SysOrgExample orgExample = new SysOrgExample();
		orgExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
		List<SysOrg> orgs = this.orgBiz.searchOrgByExample(orgExample);
		model.addAttribute("hospitals", orgs);
		
		Map<String , Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dictTypeId", DictTypeEnum.DoctorTrainingSpe.getId());
		List<SysDict> doctorTrainingSpeList = this.doctorRecruitBiz.searchTrainSpeList(paramMap);
		model.addAttribute("spes", doctorTrainingSpeList);
		
		return "cnres/doctor/jidirecruitinfo";
	}
	
	@RequestMapping("/doctor/getorgrecruitinfotable")
	public String getOrgRecruitInfoTable(String orgFlow , String speId , Model model){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		List<OrgRecruitInfo> orgRecruitInfos = new ArrayList<OrgRecruitInfo>();
		if(StringUtil.isNotBlank(orgFlow) && StringUtil.isBlank(speId)){
			//查询该医院下所有专业的招录情况
			SysOrg org = this.orgBiz.readSysOrg(orgFlow);
			List<ResOrgSpeAssign> speAssignList = speAssignBiz.searchSpeAssign(orgFlow,regYear);
			Integer planCount = null;
			OrgRecruitInfo orgRecruitInfo = null;
			for(ResOrgSpeAssign speAssign:speAssignList){
				String speName = speAssign.getSpeName();
				BigDecimal assignPlan = speAssign.getAssignPlan();
				if(assignPlan!=null){
					planCount = assignPlan.intValue();
				}
				ResDoctorRecruit searchRecruit = new ResDoctorRecruit();
				searchRecruit.setOrgFlow(orgFlow);
				searchRecruit.setSpeId(speAssign.getSpeId());
				searchRecruit.setRecruitYear(regYear);
				searchRecruit.setConfirmFlag(GlobalConstant.FLAG_Y);
				Integer confirmCount = doctorRecruitBiz.searchDoctorNum(searchRecruit);
				orgRecruitInfo = new OrgRecruitInfo(org.getOrgName() , speName , planCount , confirmCount);
				orgRecruitInfos.add(orgRecruitInfo);
			}
		}
		if(StringUtil.isBlank(orgFlow) && StringUtil.isNotBlank(speId)){
			//查询所有医院该专业的招录情况
			Integer planCount = null;
			OrgRecruitInfo orgRecruitInfo = null;
			List<ResOrgSpeAssign> orgSpeAssigns = this.speAssignBiz.searchSpeAssignBySpeIdAndYear(speId , regYear);
			for(ResOrgSpeAssign speAssign:orgSpeAssigns){
				String speAssignOrgFlow = speAssign.getOrgFlow();
				SysOrg org = this.orgBiz.readSysOrg(speAssignOrgFlow);
				BigDecimal assignPlan = speAssign.getAssignPlan();
				if(assignPlan!=null){
					planCount = assignPlan.intValue();
				}
				
				ResDoctorRecruit searchRecruit = new ResDoctorRecruit();
				searchRecruit.setOrgFlow(orgFlow);
				searchRecruit.setSpeId(speAssign.getSpeId());
				searchRecruit.setRecruitYear(regYear);
				searchRecruit.setConfirmFlag(GlobalConstant.FLAG_Y);
				Integer confirmCount = doctorRecruitBiz.searchDoctorNum(searchRecruit);
				orgRecruitInfo = new OrgRecruitInfo(org.getOrgName() , speAssign.getSpeName() , planCount , confirmCount);
				orgRecruitInfos.add(orgRecruitInfo);
			}
		}
		if(StringUtil.isNotBlank(orgFlow) && StringUtil.isNotBlank(speId)){
			//查询该医院该专业的招录情况
			Integer planCount = null;
			OrgRecruitInfo orgRecruitInfo = null;
			SysOrg org = this.orgBiz.readSysOrg(orgFlow);
			ResOrgSpeAssign speAssign =this.speAssignBiz.searchSpeAssign(orgFlow , regYear , speId);
			if(speAssign!=null){
				ResDoctorRecruit searchRecruit = new ResDoctorRecruit();
				searchRecruit.setOrgFlow(orgFlow);
				searchRecruit.setSpeId(speAssign.getSpeId());
				searchRecruit.setRecruitYear(regYear);
				searchRecruit.setConfirmFlag(GlobalConstant.FLAG_Y);
				Integer confirmCount = doctorRecruitBiz.searchDoctorNum(searchRecruit);
				orgRecruitInfo = new OrgRecruitInfo(org.getOrgName() , speAssign.getSpeName() , planCount , confirmCount);
				orgRecruitInfos.add(orgRecruitInfo);
			}
			
		}
		
		model.addAttribute("orgRecruitInfos" , orgRecruitInfos);
		
		return "cnres/doctor/orgRecruitInfoTable";
	}
	
	@RequestMapping("/doctor/showexamcard")
	public String showExamCard(Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		model.addAttribute("user" , currUser);
		ResDoctor doctor = resDoctorBiz.readDoctor(currUser.getUserFlow());
		model.addAttribute("doctor" , doctor);
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResExamDoctor examDoctor = resDoctorBiz.searchExamDoctor(currUser.getUserFlow(), ExamTypeEnum.Register.getId(), regYear);
		if (examDoctor != null) {
			model.addAttribute("examDoctor" , examDoctor);
			String examFlow = examDoctor.getExamFlow();
			ResExam exam = examManageBiz.findExamByFlow(examFlow);
			model.addAttribute("exam" , exam);
			ResExamSite examSite = examManageBiz.findExamSiteByCode(examDoctor.getSiteCode());
			model.addAttribute("examSite" , examSite);
		}
		return "cnres/doctor/examcard";
	}
	
	/**
	 * 打印
	 * @param recTypeId
	 * @param watermarkFlag
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/doctor/print")
	public void print(String recTypeId,String watermarkFlag,String printType, HttpServletRequest request,HttpServletResponse response)throws Exception{
		String templ = "";
		String fileName = "";
		WordprocessingMLPackage temeplete = new WordprocessingMLPackage();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		ResExamDoctor examDoctor = null;
		if ("ExamCard".equals(recTypeId)) {
			fileName = "准考证";
			SysUser currUser = GlobalContext.getCurrentUser();
			dataMap.put("userName", currUser.getUserName());
			dataMap.put("sexName", StringUtil.defaultString(currUser.getSexName()));
			dataMap.put("idNo", StringUtil.defaultString(currUser.getIdNo()));
			
			String regYear = InitConfig.getSysCfg("res_reg_year");
			
			String ticketNum = "";
			String siteName = "";
			String siteAddress = "";
			String rootCode = "";
			String examDate = "";
			String examTime = "";
			examDoctor = resDoctorBiz.searchExamDoctor(currUser.getUserFlow(), ExamTypeEnum.Register.getId(), regYear);
			if (examDoctor != null) {
				ticketNum = StringUtil.defaultString(examDoctor.getTicketNum());
				siteName = StringUtil.defaultString(examDoctor.getSiteName());
				rootCode = StringUtil.defaultString(examDoctor.getRoomCode());   
				String examFlow = examDoctor.getExamFlow();
				ResExam exam = examManageBiz.findExamByFlow(examFlow);
				if (exam != null) {
					examDate = StringUtil.defaultString(exam.getExamDate());
					examTime = StringUtil.defaultString(exam.getExamTime());
				}
				ResExamSite examSite = examManageBiz.findExamSiteByCode(examDoctor.getSiteCode());
				if (examSite != null) {
					siteAddress = StringUtil.defaultString(examSite.getSiteAddress());
				}
			}
			dataMap.put("ticketNum", ticketNum);
			dataMap.put("siteName", siteName);
			dataMap.put("siteAddress", siteAddress);
			dataMap.put("siteCode", rootCode);   //考场号，非考点号
			dataMap.put("examDate", examDate);
			dataMap.put("examTime", examTime);
			
			//插入头像图片
			String value = "";
			ResDoctor doctor = resDoctorBiz.readDoctor(currUser.getUserFlow());
			if (doctor != null) {
				String doctorHeadImg = StringUtil.defaultString(doctor.getDoctorHeadImg());
				String cfgUrl = InitConfig.getSysCfg("upload_base_url");
				doctorHeadImg = cfgUrl+"/"+doctorHeadImg;
				if (StringUtil.isBlank(doctorHeadImg)) {
					value = "";
				} else {
					value = "<img src='"+doctorHeadImg+"' width='80' height='150'  alt='证件照'/>";
				}
			}
			dataMap.put("headImg", value);
		}
		
		templ = recTypeId +"Template.docx";//模板
		String path = "/jsp/cnres/print/"+templ;
		ServletContext context =  request.getServletContext();
		String watermark = GeneralMethod.getWatermark(watermarkFlag);
		temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
		if(temeplete!=null){
			ServletOutputStream out = response.getOutputStream ();
			if ("pdf".equals(printType)) {
				String name = fileName+".pdf"; 
				response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
				response.setContentType ("application/pdf");
				Docx4jUtil.toPdf(temeplete,out);
			} else {
				
				String name = fileName+".docx"; 
				response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
				response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
				(new SaveToZipFile (temeplete)).save (out);
				if(examDoctor!=null){
					examDoctor.setTicketPrintFlag(GlobalConstant.FLAG_Y);
					GeneralMethod.setRecordInfo(examDoctor, false);
					examDoctorMapper.updateByPrimaryKeySelective(examDoctor);
				}
			}
			out.flush();
			
		}
	}
	
	/**
	 * 准考证pdf下载
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = {"/doctor/downPdfExamCard" },method={RequestMethod.GET})
	public void downPdfExamCard(final HttpServletResponse response) throws Exception{
		final Map<String,Object> dataMap = new HashMap<String,Object>();
		SysUser currUser = GlobalContext.getCurrentUser();
		dataMap.put("user", currUser);
		String doctorFlow = currUser.getUserFlow();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		
		ResExam exam = new ResExam();
		ResExamSite examSite = null;
		ResExamDoctor examDoctor = resDoctorBiz.searchExamDoctor(doctorFlow, ExamTypeEnum.Register.getId(), regYear);
		if (examDoctor != null) {
			exam = examManageBiz.findExamByFlow(examDoctor.getExamFlow());
			examSite = examManageBiz.findExamSiteByCode(examDoctor.getSiteCode());
		} else {
			examDoctor = new ResExamDoctor();
		}
		if (examSite==null) {
			examSite = new ResExamSite();
		}
		dataMap.put("exam", exam);
		dataMap.put("examSite", examSite);
		dataMap.put("examDoctor", examDoctor);
		
		//头像图片
		ResDoctor doctor = resDoctorBiz.readDoctor(currUser.getUserFlow());
		String doctorHeadImg = "";
		if (doctor != null) {
			doctorHeadImg = StringUtil.defaultString(doctor.getDoctorHeadImg());
			String cfgUrl = InitConfig.getSysCfg("upload_base_url");
			doctorHeadImg = cfgUrl+"/"+doctorHeadImg;
		}
		dataMap.put("doctorHeadImg", doctorHeadImg);
		
		
		//下载pdf
		final String fileName = "准考证";
		String outputFileClass = ResourceLoader.getPath("");
		String outputFile = new File(outputFileClass)
		.getParentFile().getParent() + "/load/" + fileName + ".pdf" ;
		
		File file = new File(outputFile);
		try {
			// 模板数据
			DocumentVo vo = new DocumentVo() {
				@Override
				public String findPrimaryKey() {
					return fileName;
				}
				@Override
				public Map<String, Object> fillDataMap() {
					return dataMap;
				}
			};
				
			String template = "examCardTemplate.html";
			PdfDocumentGenerator pdfGenerator = new PdfDocumentGenerator();
			// 生成pdf
			pdfGenerator.generate(template, vo, outputFile);
		} catch (Exception ex) {
			System.err.println(" \n pdf生成失败");
			ex.printStackTrace();
		}
		
		pubFileBiz.downFile(file,response);
	}
	
	@RequestMapping(value = {"/getMailContent" },method={RequestMethod.GET})
	@ResponseBody
	public String getMailContent(String userEmail){
		SysUser user = userBiz.findByUserEmail(userEmail);
		if (user != null && UserStatusEnum.Added.getId().equals(user.getStatusId())) {
			String activationCode = user.getUserFlow();//激活码
			String content = InitConfig.getSysCfg("res_reg_email_content");
			Map<String,String> dataMap = new HashMap<String,String>();
			dataMap.put("linkUrl", "<a href='"+InitConfig.getSysCfg("res_effective_url")+"?sid="+GlobalContext.getSession().getId()+"&activationCode="+activationCode+"'>"+InitConfig.getSysCfg("res_effective_url")+"?sid="+GlobalContext.getSession().getId()+"&activationCode="+activationCode+"</a>");
			dataMap.put("linkEmail",userEmail);
			try {
				content = VelocityUtil.evaluate(content, dataMap);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
			return content;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping("/modusercode")
	@ResponseBody
	public String modUserCode(SysUser user){
		//查询该userCode 是否存在
		SysUser exitUser = this.userBiz.findByUserCode(user.getUserCode());
		if(exitUser==null){
			this.userBiz.updateUser(user);
			user = this.userBiz.readSysUser(user.getUserFlow());
			setSessionAttribute(GlobalConstant.CURRENT_USER, user);	
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}else{
			return "该用户名已存在";
		}
		
	}
	
}
