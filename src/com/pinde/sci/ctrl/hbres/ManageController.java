package com.pinde.sci.ctrl.hbres;


import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.GradeManageBiz;
import com.pinde.sci.biz.hbres.IResDoctorRecruitBiz;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.hbres.RecruitCfgBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResOrgSpeAssignBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.enums.res.OrgLevelEnum;
import com.pinde.sci.enums.res.RecDocCategoryEnum;
import com.pinde.sci.enums.res.RecDocTypeEnum;
import com.pinde.sci.enums.res.RecruitTypeEnum;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResOrgSpeAssign;
import com.pinde.sci.model.mo.ResRecruitCfg;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysLogExample;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysOrgExample;
import com.pinde.sci.model.mo.SysOrgExample.Criteria;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.DateCfgMsg;
import com.pinde.sci.model.res.ResDoctorExt;

@Controller
@RequestMapping("/hbres/singup")
public class ManageController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(ManageController.class);

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
	private NoticeBiz noticeBiz;
	@Autowired
	private GradeManageBiz gradeManageBiz;
    @Autowired
	private RecruitCfgBiz recruitCfgBiz;
    @Autowired
	private IResDoctorRecruitBiz doctorRecruitBiz;
	
	/**
	 * 管理员主界面
	 */
	@RequestMapping(value="/manage/{role}")
	public String index(@PathVariable String role,Model model,Integer currentPage){
		InxInfo info = new InxInfo(); 
		PageHelper.startPage(currentPage, 10);
		List<InxInfo> notices = noticeBiz.findNotice(info);
		model.addAttribute("messages" , notices);
		
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		
		if (GlobalConstant.USER_LIST_GLOBAL.equals(role)) { //省级部门
			//待审核
			Map<String, Object> regParamMap = new HashMap<String, Object>();
			regParamMap.put("sessionNumber", regYear);
			List<String> regStatus = new ArrayList<String>();
			regStatus.add(RegStatusEnum.Passing.getId());
			regParamMap.put("status", regStatus);
			regParamMap.put("categoryId", RecDocCategoryEnum.Doctor.getId());
			Integer regCount = this.resDoctorBiz.searchResDoctorUserCount(regParamMap);
			
			//总报名人数
			Map<String, Object> totleCountParamMap = new HashMap<String, Object>();
			totleCountParamMap.put("regYear", regYear);
			Integer totleCount = this.resDoctorBiz.searchResRegUserCount(totleCountParamMap);
			
			//审核通过
			Map<String, Object> activatedCountParamMap = new HashMap<String, Object>();
			activatedCountParamMap.put("regYear", regYear);
			List<String> activatedCountParamMapStatus = new ArrayList<String>();
			activatedCountParamMapStatus.add(RegStatusEnum.Passed.getId());
			activatedCountParamMap.put("status", activatedCountParamMapStatus);
			Integer activatedCount = this.resDoctorBiz.searchResRegUserCount(activatedCountParamMap);
			
			model.addAttribute("regCount", regCount);
			model.addAttribute("totleCount", totleCount);
			model.addAttribute("activatedCount", activatedCount);
			
			return "hbres/manage/index";
		} else if (GlobalConstant.USER_LIST_LOCAL.equals(role)) { //医院管理员
			//志愿填报数
			ResDoctorRecruit recruit = new ResDoctorRecruit();
			recruit.setOrgFlow(orgFlow);
			recruit.setRecruitYear(regYear);
			recruit.setRecruitTypeId(RecruitTypeEnum.Fill.getId());
			int volunNum = doctorRecruitBiz.searchDoctorNum(recruit);
			model.addAttribute("volunNum", volunNum);
			
			//复试数
			ResDoctorRecruit recruit1 = new ResDoctorRecruit();
			recruit1.setOrgFlow(orgFlow);
			recruit1.setRecruitYear(regYear);
			recruit1.setRecruitTypeId(RecruitTypeEnum.Fill.getId());
			recruit1.setRetestFlag(GlobalConstant.FLAG_Y);
			int retestNum = doctorRecruitBiz.searchDoctorNum(recruit1);
			model.addAttribute("retestNum", retestNum);
			
			//录取数
			ResDoctorRecruit recruit2 = new ResDoctorRecruit();
			recruit2.setOrgFlow(orgFlow);
			recruit2.setRecruitYear(regYear);
			recruit2.setRecruitFlag(GlobalConstant.FLAG_Y);
			recruit2.setConfirmFlag(GlobalConstant.FLAG_Y);
			int recruitNum = doctorRecruitBiz.searchDoctorNum(recruit2);
			model.addAttribute("recruitNum", recruitNum);
			
			return "hbres/hospital/index";
		}
		
		InxInfo temp = new InxInfo();
		PageHelper.startPage(1,6);
		List<InxInfo> infos = this.noticeBiz.findNoticeWithBLOBs(temp);
		model.addAttribute("infos",infos);
		return "/inx/hbres/login";
	}
	
	/**
	 * 审核页面
	 */
	@RequestMapping(value="/manage/audit")
	public String audit(String statusId,Model model,Integer currentPage,String key){
		PageHelper.startPage(currentPage,10);
		if(StringUtil.isBlank(statusId)){
			statusId = RegStatusEnum.Passing.getId();
		}
		
		List<ResDoctorExt> userList = null;
		Map<String , Object> paramMap = new HashMap<String, Object>();
		paramMap.put("sessionNumber" , InitConfig.getSysCfg("res_reg_year"));
		paramMap.put("statusId", statusId);
		paramMap.put("key", key);
		if (RegStatusEnum.Passing.getId().equals(statusId)) {
			userList = resDoctorBiz.searchDocUser(paramMap);
		} else {
			userList = resDoctorBiz.searchRegUser(paramMap);
		}
		
		model.addAttribute("statusId", statusId);
		model.addAttribute("userList",userList);
		model.addAttribute("key",key);
		return "hbres/manage/audit";
	}
	
	/**
	 * 用户信息
	 */
	@RequestMapping(value="/manage/userInfo")
	public String userInfo(String userFlow,Model model){
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user = userBiz.readSysUser(userFlow);
			if(user!=null){
				model.addAttribute("user",user);
				
				ResDoctor doctor = resDoctorBiz.readDoctor(userFlow);
				model.addAttribute("doctor",doctor);
			}
		}
		
		return "hbres/manage/infoAudit";
	}
	
	/**
	 * 用户信息审核
	 */
	@RequestMapping(value="/manage/userAudit")
	@ResponseBody
	public String hospital(SysUser user,ResDoctor doctor,Model model){
		this.resDoctorBiz.auditDoctor(user, doctor);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	/**
	 * 用户退回
	 */
	@RequestMapping(value="/manage/withdrawUser")
	@ResponseBody
	public String withdrawUser(ResDoctor doctor,Model model){
		this.resDoctorBiz.withdrawDoctor(doctor);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping(value="/hospital")
	public String hospital(Model model) throws Exception{
		SysOrgExample example = new SysOrgExample();
		example.createCriteria().andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
		example.setOrderByClause("ordinal");
		List<SysOrg> orgList = orgBiz.searchOrgByExample(example);
		model.addAttribute("orgList", orgList);
		return "hbres/manage/old_hospital";
	}
	
	@RequestMapping(value="/accounts")
	public String accounts(Model model) throws Exception{
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		SysLogExample example = new SysLogExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(user.getUserFlow());
		example.setOrderByClause("create_time desc");
		List<SysLog> logs = logMapper.selectByExample(example);
		if(logs!=null && logs.size()>0){
			model.addAttribute("log", logs.get(0));
		}
		return "hbres/accounts";
	}
	
	@RequestMapping("/noticemanage")
	public String noticeManage(Integer currentPage , Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(currentPage,5);
		List<InxInfo> infos = this.noticeBiz.findNotice(info);
		model.addAttribute("infos",infos);
		return "hbres/manage/notice";
	}
	
	@RequestMapping(value="/spe")
	public String spe(Model model) throws Exception{
		return "hbres/manage/spe";
	}
	
	/**
	 * 基地维护
	 */
	@RequestMapping(value="/manage/orgCfg")
	public String orgCfg(String isCountry,Model model){
		SysOrgExample example = new SysOrgExample();
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(isCountry)){
			criteria.andOrgLevelIdEqualTo(OrgLevelEnum.CountryOrg.getId());
		}else {
			criteria.andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
		}
		example.setOrderByClause("ORDINAL");
		List<SysOrg> orgList = orgBiz.searchOrgByExample(example);
		model.addAttribute("orgList",orgList);
		return "hbres/manage/org";
	}
	
	/**
	 * 招录计划
	 */
	@RequestMapping(value="/manage/plan")
	public String plan(String assignYear , String source , String orgFlow , Model model){
		SysOrgExample example = new SysOrgExample();
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
		example.setOrderByClause("ORDINAL");
		List<SysOrg> orgList = orgBiz.searchOrgByExample(example);
		model.addAttribute("orgList",orgList);
		
		int totalNum = 0;
		if(StringUtil.isNotBlank(assignYear)){
			List<ResOrgSpeAssign> speAssignList = speAssignBiz.searchSpeAssign(assignYear);
			if(speAssignList!=null && speAssignList.size()>0){
				Map<String,Integer> speAssignNumMap = new HashMap<String,Integer>();
				for(ResOrgSpeAssign rosa : speAssignList){
					if (rosa.getAssignPlan() != null) {
						int num = 0;
						if (speAssignNumMap.get(rosa.getOrgFlow()) != null) {
							num = speAssignNumMap.get(rosa.getOrgFlow());
						}
						num += rosa.getAssignPlan().intValue();
						speAssignNumMap.put(rosa.getOrgFlow(),num);
						if(!GlobalConstant.USER_LIST_LOCAL.equals(source) || rosa.getOrgFlow().equals(orgFlow)){
							totalNum += rosa.getAssignPlan().intValue();	
						}
						
					}
				}
				model.addAttribute("speAssignNumMap",speAssignNumMap);
			}
		}
		model.addAttribute("totalNum",totalNum);
		
		return "hbres/manage/plan";
	}
	
	@RequestMapping(value="/manage/planInfo")
	public String planInfo(String assignYear,String orgFlow,Model model){
		SysOrgExample example = new SysOrgExample();
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
		example.setOrderByClause("ORDINAL");
		List<SysOrg> orgList = orgBiz.searchOrgByExample(example);
		model.addAttribute("orgList",orgList);
		model.addAttribute("orgFlow",orgFlow);
		
		if(StringUtil.isNotBlank(assignYear)){
			List<ResOrgSpeAssign> speAssignList = speAssignBiz.searchSpeAssign(orgFlow,assignYear);
			if(speAssignList!=null && speAssignList.size()>0){
				Map<String,ResOrgSpeAssign> speAssignMap = new HashMap<String,ResOrgSpeAssign>();
				for(ResOrgSpeAssign rosa : speAssignList){
					speAssignMap.put(rosa.getSpeId(),rosa);
				}
				model.addAttribute("speAssignMap",speAssignMap);
			}
		}
		
		return "hbres/manage/planInfo";
	}
	
	/**
	 * 招录计划保存
	 */
	@RequestMapping(value="/manage/savePlan")
	@ResponseBody
	public String savePlan(ResOrgSpeAssign speAssign){
		if(speAssign!=null){
			if(StringUtil.isNotBlank(speAssign.getSpeId())){
				speAssign.setSpeName(DictTypeEnum.DoctorTrainingSpe.getDictNameById(speAssign.getSpeId()));
			}
			if (StringUtil.isNotBlank(speAssign.getRecordFlow())) {
				ResOrgSpeAssign assign = speAssignBiz.findSpeAssignByFlow(speAssign.getRecordFlow());
				assign.setAssignPlan(speAssign.getAssignPlan());
				speAssign = assign;
			}
			if(GlobalConstant.ZERO_LINE!=speAssignBiz.editSpeAssignUnSelective(speAssign)){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value={"/modPasswd"})
	public String modPasswd(Model model){	
		return "hbres/manage/modPasswd";
	}
	
	/**
	 * 招录设置
	 */
	@RequestMapping(value="/manage/datecfg")
	public String dateCfg(Model model){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		model.addAttribute("recruitCfg" , recruitCfg);
		
		String currDate = DateUtil.getCurrDate();
		DateCfgMsg regDateCfgMsg = new DateCfgMsg(recruitCfg);
		regDateCfgMsg.setRegDateMsg(currDate);
		
		DateCfgMsg printDateCfgMsg = new DateCfgMsg(recruitCfg);
		printDateCfgMsg.setPrintDateMsg(currDate);
		
		DateCfgMsg wishDateCfgMsg = new DateCfgMsg(recruitCfg);
		wishDateCfgMsg.setWishDateMsg(currDate);
		
		DateCfgMsg admitDateCfgMsg = new DateCfgMsg(recruitCfg);
		admitDateCfgMsg.setAdmitDateMsg(currDate);
		
		DateCfgMsg swapDateCfgMsg = new DateCfgMsg(recruitCfg);
		swapDateCfgMsg.setSwapDateMsg(currDate);
		
		model.addAttribute("regDateCfgMsg" , regDateCfgMsg);
		model.addAttribute("printDateCfgMsg" , printDateCfgMsg);
		model.addAttribute("wishDateCfgMsg" , wishDateCfgMsg);
		model.addAttribute("admitDateCfgMsg" , admitDateCfgMsg);
		model.addAttribute("swapDateCfgMsg" , swapDateCfgMsg);
		return "hbres/manage/dateCfg";
	}
	
	
	@RequestMapping("/manage/savedatecfg")
	@ResponseBody
	public String saveDateCfg(ResRecruitCfg recruitCfg){
		this.recruitCfgBiz.saveRecruitCfg(recruitCfg);
	    return GlobalConstant.OPERATE_SUCCESSED;	
	}

	@RequestMapping("/adminMod")
	public String adminMod(String key,Model model){
		if(StringUtil.isNotBlank(key)){
			Map<String , Object> paramMap = new HashMap<String, Object>();
			paramMap.put("key", key);
			List<ResDoctorExt> userList = resDoctorBiz.searchDocUser(paramMap);
			if(userList!=null&&userList.size()>0){
				SysUser user = userList.get(0).getSysUser();
				model.addAttribute("user", user);
				model.addAttribute("doctor", userList.get(0));
				String regYear = InitConfig.getSysCfg("res_reg_year");
				List<ResDoctorRecruit> doctorRecruits = gradeManageBiz.findResDoctorRecruits(regYear, user.getUserFlow());
				Collections.reverse(doctorRecruits);
				model.addAttribute("doctorRecruits" , doctorRecruits);
			}
		}
		return "hbres/adminMod";
	}
	
	@RequestMapping("/saveAdminMod")
	@ResponseBody
	public String saveAdminMod(SysUser user,ResDoctor doctor){
		//医师类型
		if(StringUtil.isNotBlank(doctor.getDoctorTypeId())){
			doctor.setDoctorTypeName(RecDocTypeEnum.getNameById(doctor.getDoctorTypeId()));
		}
		//毕业院校
		String graduatedId = doctor.getGraduatedId();
		if(StringUtil.isNotBlank(graduatedId)){
			List<SysDict> graduatedNames = DictTypeEnum.sysListDictMap.get(DictTypeEnum.GraduateSchool.getId());
			for(SysDict dict:graduatedNames){
				String graduatedName = dict.getDictName();
				if(dict.getDictId().equals(graduatedId)){
					doctor.setGraduatedName(graduatedName);
				}
			}
		}
		//学历
		if(StringUtil.isNotBlank(user.getEducationId())) {
			user.setEducationName(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));
		} else {
			user.setEducationName("");
		}
		//学位
		if(StringUtil.isNotBlank(user.getDegreeId())){
			user.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(user.getDegreeId()));
		}else{
			user.setDegreeName("");
		}
		int result = resDoctorBiz.editDoctorUser(doctor, user);
		if(GlobalConstant.ZERO_LINE!=result){
			return GlobalConstant.SAVE_SUCCESSED;	
		}
	    return GlobalConstant.SAVE_FAIL;	
	}
	
	@RequestMapping("/resetDoctorRecruit")
	@ResponseBody
	public String resetDoctorRecruit(String doctorFlow){
		
		int result = resDoctorBiz.resetDoctorRecruit(doctorFlow);
		if(GlobalConstant.ZERO_LINE!=result){
			return GlobalConstant.OPRE_SUCCESSED;	
		}
	    return GlobalConstant.OPRE_FAIL;	
	}
	
}
