package com.pinde.sci.ctrl.sczyres;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.ExcleUtile;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResJointOrgBiz;
import com.pinde.sci.biz.sczyres.DoctorRecruitBiz;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.RecruitTypeEnum;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.enums.sczyres.SczyResOrgLevelEnum;
import com.pinde.sci.enums.sczyres.SpeCatEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.sczyres.ExportDoctorInfo;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResJointOrg;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorExt;
import com.pinde.sci.model.res.ResDoctorRecruitExt;

@RequestMapping("/sczyres/hosptial")
@Controller
public class HosptialController extends GeneralController{

	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private DoctorRecruitBiz doctorRecruitBiz;
	@Autowired
	private NoticeBiz noticeBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IResJointOrgBiz resJointBiz;
	@Autowired
	private IDictBiz dictBiz;
	
	@RequestMapping("/home")
	public String home(Integer currentPage , Model model){
		SysUser user = GlobalContext.getCurrentUser();
		InxInfo info = new InxInfo();
		PageHelper.startPage(currentPage,10);
		List<InxInfo> messages = this.noticeBiz.findNotice(info);
		model.addAttribute("messages",messages);
		ResDoctor doctor = new ResDoctor();
		doctor.setOrgFlow(user.getOrgFlow());
		//统计待审核
		doctor.setDoctorStatusId(RegStatusEnum.Passing.getId());
		int passingCount = resDoctorBiz	.findDoctorCountInOrg(doctor);
		model.addAttribute("passingCount" , passingCount);
		//统计已报名
		doctor.setDoctorStatusId("");
		int singupCount = resDoctorBiz.findDoctorCountInOrg(doctor);
		model.addAttribute("singupCount" , singupCount);
		//统计审核通过
		doctor.setDoctorStatusId(RegStatusEnum.Passed.getId());
		int passedCount = resDoctorBiz.findDoctorCountInOrg(doctor);
		model.addAttribute("passedCount" , passedCount);
		
		List<ResJointOrg> jointOrgs = resJointBiz.searchResJointByOrgFlow(user.getOrgFlow());
		//是否有协同基地
		if(!jointOrgs.isEmpty()){
			model.addAttribute("showJointOrg",true);	
		}
		return "sczyres/hosptial/index";
	}
	
	/**
	 * 审核页面
	 */
	@RequestMapping(value="/audit")
	public String audit(String statusId,Model model,Integer currentPage,String key){
		SysUser user = GlobalContext.getCurrentUser();
		PageHelper.startPage(currentPage,10);
		if(StringUtil.isBlank(statusId)){
			statusId = RegStatusEnum.Passing.getId();
		}
		
		List<ResDoctorExt> userList = null;
		Map<String , Object> paramMap = new HashMap<String, Object>();
		paramMap.put("sessionNumber" , InitConfig.getSysCfg("res_reg_year"));
		paramMap.put("statusId", statusId);
		paramMap.put("key", key);
		paramMap.put("orgFlow", user.getOrgFlow());
		if (RegStatusEnum.Passing.getId().equals(statusId)) {
			userList = resDoctorBiz.searchDocUser(paramMap);
		} else {
			userList = resDoctorBiz.searchRegUser(paramMap);
		}
		
		model.addAttribute("statusId", statusId);
		model.addAttribute("userList",userList);
		model.addAttribute("key",key);
		return "sczyres/hosptial/audit";
	}
	
	/**
	 * 用户信息审核
	 */
	@RequestMapping(value="/userAudit")
	@ResponseBody
	public String hospital(SysUser user,ResDoctor doctor,Model model){
		this.resDoctorBiz.auditDoctor(user, doctor);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping("/recruitDoctor")
	public String recruitDoctor(String status , String speId , String key , Model model){
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		SysOrg org = orgBiz.readSysOrg(orgFlow);
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("orgFlow", orgFlow);
		paramMap.put("recruitYear", regYear);
		paramMap.put("doctorStatusId", RegStatusEnum.Passed.getId());
		if(StringUtil.isNotBlank(status)){
			if(SczyResOrgLevelEnum.Joint.getId().equals(org.getOrgLevelId())){
				if(GlobalConstant.FLAG_Y.equals(status)){
					paramMap.put("admitFlag", status);
				}else{
					paramMap.put("recruitFlag", status);	
				}
				
			}else{
				paramMap.put("recruitFlag", status);	
			}
			
		}
		if(StringUtil.isNotBlank(speId)){
			paramMap.put("speId", speId);
		}
		if(StringUtil.isNotBlank(key)){
			paramMap.put("key", key);
		}
		List<ResDoctorRecruitExt> doctorRecruitExts = this.doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
		List<ResDoctorRecruitExt> resultDoctorRecruitExts = new ArrayList<ResDoctorRecruitExt>();
		if(StringUtil.isBlank(status)){
			for(ResDoctorRecruitExt rdre : doctorRecruitExts){
				if(SczyResOrgLevelEnum.Main.getId().equals(org.getOrgLevelId())){
					if(StringUtil.isBlank(rdre.getRecruitFlag())){
						resultDoctorRecruitExts.add(rdre);
					}
				}
				if(SczyResOrgLevelEnum.Joint.getId().equals(org.getOrgLevelId())){
					if(StringUtil.isBlank(rdre.getAdmitFlag()) && !RecruitTypeEnum.Swap.getId().equals(rdre.getRecruitTypeId())){
						resultDoctorRecruitExts.add(rdre);
					}
				}
			}
		}else if(GlobalConstant.FLAG_Y.equals(status)){
			if(SczyResOrgLevelEnum.Joint.getId().equals(org.getOrgLevelId())){
				for(ResDoctorRecruitExt rdre : doctorRecruitExts){
					if( (GlobalConstant.FLAG_Y.equals(rdre.getAdmitFlag()) && GlobalConstant.FLAG_Y.equals(rdre.getRecruitFlag())) || 
						(GlobalConstant.FLAG_Y.equals(rdre.getAdmitFlag()) && StringUtil.isBlank(rdre.getRecruitFlag()))	
							){
						resultDoctorRecruitExts.add(rdre);
					}
				}
			}else{
				resultDoctorRecruitExts = doctorRecruitExts;
			}
		}else{
			resultDoctorRecruitExts = doctorRecruitExts;
		}
		model.addAttribute("doctorRecruitExts", resultDoctorRecruitExts);	
		return "sczyres/hosptial/doctorrecruit";
	}
	
	@RequestMapping("/recruitDoctorForJointOrg")
	public String recruitDoctorForJointOrg(String status , String key , Model model){
		
		if(GlobalConstant.FLAG_F.equals(status)){
			return singupForJointOrg(status , key , model);
		}
		
		if(StringUtil.isBlank(status)){
			status = GlobalConstant.FLAG_Y;
		}
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("recruitYear", regYear);
		paramMap.put("doctorStatusId", RegStatusEnum.Passed.getId());
		if(GlobalConstant.FLAG_Y.equals(status)){
			paramMap.put("admitFlag", GlobalConstant.FLAG_Y);
		}
		if(GlobalConstant.FLAG_N.equals(status)){
			paramMap.put("recruitFlag", GlobalConstant.FLAG_N);
		}
		List<ResJointOrg> jointOrgs = resJointBiz.searchResJointByOrgFlow(orgFlow);
		List<String> jointOrgFlows = new ArrayList<String>();
		for(ResJointOrg jointOrg:jointOrgs){
			jointOrgFlows.add(jointOrg.getJointOrgFlow());
		}
		if(!jointOrgFlows.isEmpty()){
			paramMap.put("jointOrgs", jointOrgFlows);	
		}
		if(StringUtil.isNotBlank(key)){
			paramMap.put("key", key);
		}
		List<ResDoctorRecruitExt> doctorRecruitExts = this.doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
		List<ResDoctorRecruitExt> resultDoctorRecruitExts = new ArrayList<ResDoctorRecruitExt>();
		for(ResDoctorRecruitExt rdre : doctorRecruitExts){
			if(!RecruitTypeEnum.Swap.getId().equals(rdre.getRecruitTypeId())){
				if(GlobalConstant.FLAG_Y.equals(status)){
					if(!GlobalConstant.FLAG_N.equals(rdre.getRecruitFlag())){
						resultDoctorRecruitExts.add(rdre);
					}
				}else{
					resultDoctorRecruitExts.add(rdre);
				}
			}
		}
		model.addAttribute("doctorRecruitExts", resultDoctorRecruitExts);	
		return "sczyres/hosptial/doctorrecruitinfoforjointorg";
	}
	
	/**
	 * 协同基地-报名名单
	 * @param status
	 * @param key
	 * @param model
	 * @return
	 */
	public String singupForJointOrg(String status , String key , Model model){
		SysUser user = GlobalContext.getCurrentUser();
		List<ResJointOrg> jointOrgs = resJointBiz.searchResJointByOrgFlow(user.getOrgFlow());
		List<String> jointOrgFlows = new ArrayList<String>();
		for(ResJointOrg jointOrg:jointOrgs){
			jointOrgFlows.add(jointOrg.getJointOrgFlow());
		}
		List<ResDoctorExt> userList = null;
		Map<String , Object> paramMap = new HashMap<String, Object>();
		paramMap.put("sessionNumber" , InitConfig.getSysCfg("res_reg_year"));
		paramMap.put("key", key);
		if(!jointOrgFlows.isEmpty()){
			paramMap.put("jointOrgs", jointOrgFlows);
		}
		userList = resDoctorBiz.searchRegUser(paramMap);
		model.addAttribute("userList",userList);
		return "sczyres/hosptial/singupforjointorg";
	}
	
	/**
	 * 查询被上级部门调剂到本基地和下属协同基地的学员
	 * @param key
	 * @param model
	 * @return
	 */
	@RequestMapping("/recruitDoctorForSwap")
	public String recruitDoctorForSwap(String status,String key , Model model){
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		//是否有协同基地
		List<ResJointOrg> jointOrgs = resJointBiz.searchResJointByOrgFlow(orgFlow);
		if(!jointOrgs.isEmpty()){
			model.addAttribute("showJointOrg" , true);
		}
		List<String> jointOrgFlows=new ArrayList<String>();
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("recruitTypeId",RecruitTypeEnum.Swap.getId() );
		paramMap.put("recruitYear", regYear);
		if(StringUtil.isBlank(status)){
			status=GlobalConstant.FLAG_Y;
		}
		if (StringUtil.isEquals(status, GlobalConstant.FLAG_Y)) {
			paramMap.put("orgFlow", orgFlow);
		}
		if (StringUtil.isEquals(status, GlobalConstant.FLAG_N)){
			for(ResJointOrg res:jointOrgs){
				jointOrgFlows.add(res.getJointOrgFlow());
			}
		}
		if (StringUtil.isNotBlank(key)) {
			paramMap.put("key", key);
		}
		if (!jointOrgFlows.isEmpty()) {
			paramMap.put("jointOrgs", jointOrgFlows);
		}
		List<ResDoctorRecruitExt> doctorRecruitExts = this.doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
		model.addAttribute("doctorRecruitExts", doctorRecruitExts);	
		List<String> swapRecruitDoctors = new ArrayList<String>();
		for(ResDoctorRecruitExt rdre:doctorRecruitExts){
			swapRecruitDoctors.add(rdre.getDoctorFlow());
		}
		if(!swapRecruitDoctors.isEmpty()){
			Map<String, ResDoctorRecruit> noRecruitMap = this.doctorRecruitBiz.findNoRecruitDoctorRecruit(swapRecruitDoctors);
			model.addAttribute("noRecruitMap" , noRecruitMap);
		}
		
		return "sczyres/hosptial/doctorrecruitinfoforswap";
	}
	@RequestMapping("/orgRecruitInfo")
	public String orgRecruitInfo(Model model ,String id) {
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		String orgId=null;  
		List<SysDict>dictList=null;
		if (StringUtil.isBlank(id)||StringUtil.isEquals(id, SpeCatEnum.Zy.getId()) ) {
			id=SpeCatEnum.Zy.getId();
			dictList=DictTypeEnum.sysListDictMap.get(DictTypeEnum.ZySpe.getId());
			orgId=SpeCatEnum.Zy.getId();
		}
		if (StringUtil.isEquals(id,SpeCatEnum.Zyqk.getId())) {
		   dictList=DictTypeEnum.sysListDictMap.get(DictTypeEnum.ZyqkSpe.getId());
			orgId=SpeCatEnum.Zyqk.getId();
		}
		//录取总数
		ResDoctorRecruit recruit=new ResDoctorRecruit();
		recruit.setOrgFlow(orgFlow);
		recruit.setCatSpeId(orgId);
		recruit.setRecruitFlag(GlobalConstant.FLAG_Y);
		Map<String,Integer> recruitCountMap = new HashMap<String,Integer>();
		for(SysDict rdr : dictList){
			recruit.setSpeId(rdr.getDictId());
			int recruitCount=doctorRecruitBiz.findCountByRecruit(recruit);
			recruitCountMap.put(rdr.getDictId(), recruitCount);
		}
		model.addAttribute("recruitCountMap", recruitCountMap);
		return "sczyres/hosptial/orgRecruitInfo";
	}
	@RequestMapping("/gradeedit")
	public String gradeEdit(String recruitFlow , Model model){
		ResDoctorRecruit recruit = this.doctorRecruitBiz.readResDoctorRecruit(recruitFlow);
		model.addAttribute("recruit" , recruit);
		return "sczyres/hosptial/gradeedit";
	}
	
	/**
	 * 成绩保存
	 * @param recruit
	 * @return
	 */
	@RequestMapping("/savegrade")
	@ResponseBody
	public String saveGrade(ResDoctorRecruitWithBLOBs recruit){
		if(StringUtil.isNotBlank(recruit.getRecruitFlow())){
		    this.doctorRecruitBiz.editDoctorRecruit(recruit);
		    return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * 不录取的操作
	 * @return
	 */
	@RequestMapping("/notrecruit")
	@ResponseBody
	public String notrecruit(String recruitFlow){
		ResDoctorRecruitWithBLOBs recruit = new ResDoctorRecruitWithBLOBs();
		recruit.setRecruitFlow(recruitFlow);
		recruit.setRecruitFlag(GlobalConstant.FLAG_N);
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		SysOrg org = orgBiz.readSysOrg(orgFlow);
		if(SczyResOrgLevelEnum.Joint.getId().equals(org.getOrgLevelId())){
			recruit.setAdmitFlag(GlobalConstant.FLAG_N);
		}
		
		this.doctorRecruitBiz.recruit(recruit);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	@RequestMapping("/openAdmitPage")
	public String openAdmitPage(String recruitFlow , Model model){
		ResDoctorRecruit recruit = this.doctorRecruitBiz.readResDoctorRecruit(recruitFlow);
		model.addAttribute("recruit" , recruit);
		SysUser user = this.userBiz.readSysUser(recruit.getDoctorFlow());
		model.addAttribute("user" , user);
		return "sczyres/hosptial/noticeRecruitMain";
	}
	/**
	 *显示结构信息 
	 */
	@RequestMapping("/orgInfo")
	public String showOrgInfo(Model model) {
		SysUser user = GlobalContext.getCurrentUser();
		SysOrg org = this.orgBiz.readSysOrg(user.getOrgFlow());
		model.addAttribute("org" , org);
		return "sczyres/hosptial/orgInfo";
	}
	/**
	 * 更新结构简介
	 */
	@RequestMapping("/updateInfo")
	@ResponseBody
	public String updateInfo(String orgInfo){
		SysUser user = GlobalContext.getCurrentUser();
		SysOrg org = new SysOrg();
		org.setOrgFlow(user.getOrgFlow());
		org.setOrgInfo(orgInfo);
		orgBiz.update(org);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	/**
	 * 录取
	 * @param recruit
	 * @return
	 */
	@RequestMapping("/recruit")
	@ResponseBody
	public String recruit(ResDoctorRecruitWithBLOBs recruit){
		//是主基地还是协同基地的操作
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		SysOrg org = orgBiz.readSysOrg(orgFlow);
		if(SczyResOrgLevelEnum.Main.getId().equals(org.getOrgLevelId())){
			recruit.setRecruitFlag(GlobalConstant.FLAG_Y);
		}
		if(SczyResOrgLevelEnum.Joint.getId().equals(org.getOrgLevelId())){
			recruit.setAdmitFlag(GlobalConstant.FLAG_Y);
		}
		
		this.doctorRecruitBiz.recruit(recruit);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * 导出报名审核通过的学员
	 * @param orgFlow
	 * @param type
	 * @param response
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping("/exportpasseddoctor")
	public void exportPassedDoctor(String orgFlow , HttpServletResponse response) throws IOException, Exception{
		String regYear = InitConfig.getSysCfg("res_reg_year");
		Map<String,Object> paramMap = new HashMap<String,Object>();
		if(StringUtil.isNotBlank(orgFlow)){
			paramMap.put("orgFlow", orgFlow);	
		}
		paramMap.put("recruitYear", regYear);
		paramMap.put("doctorStatusId", RegStatusEnum.Passed.getId());
		List<ResDoctorRecruitExt> doctorRecruitExts = this.doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
	    String fileName = "报名审核通过学员名单.xls";
	    createExcle(response, fileName, doctorRecruitExts, GlobalConstant.FLAG_Y);
		
	}
	
	/**
	 * 导出报名审核通过的学员
	 * @param orgFlow
	 * @param type
	 * @param response
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping("/exportrecruitdoctor")
	public void exportRecruitDoctor(String orgFlow , HttpServletResponse response) throws IOException, Exception{
		String regYear = InitConfig.getSysCfg("res_reg_year");
		Map<String,Object> paramMap = new HashMap<String,Object>();
		if(StringUtil.isNotBlank(orgFlow)){
			paramMap.put("orgFlow", orgFlow);	
		}
		paramMap.put("recruitYear", regYear);
		paramMap.put("doctorStatusId", RegStatusEnum.Passed.getId());
		paramMap.put("recruitFlag", GlobalConstant.FLAG_Y);
		List<ResDoctorRecruitExt> doctorRecruitExts = this.doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
	    String fileName = "录取学员名单.xls";
	    createExcle(response, fileName, doctorRecruitExts, null);
		
	}
	
	private String[] getExportTitle(){
		String[] titles = new String[]{
				"orgName:基地名称",
				"doctorName:姓名",
				"sex:性别",
				"idNo:身份证号",
				"graduatedName:毕业院校",
				"graduationTime:毕业时间",
				"doctorType:身份类型",
				"educationName:学历",
				"degreeName:学位",
				"specialized:毕业专业",
				"workOrgName:现工作单位",
				"speName:填报专业名称",
				"doctorLicenseFlag:是否执业医师",
				"qualifiedNo:执业医师资格证号",
				"email:邮箱",
				"userPhone:联系方式",
				"swap:填报类型"
		};
		
		return titles;
	}
	
	private void createExcle(HttpServletResponse response , String fileName , List<ResDoctorRecruitExt> doctorRecruitExts , String opertype) throws IOException, Exception{
		List<ExportDoctorInfo> dataList = new ArrayList<ExportDoctorInfo>();
		ExportDoctorInfo hdei = null;
		for(ResDoctorRecruitExt rdre:doctorRecruitExts){
			boolean exportFlag = false;
			if(GlobalConstant.FLAG_Y.equals(opertype)){
                if(RecruitTypeEnum.Fill.getId().equals(rdre.getRecruitTypeId())){
                	exportFlag = true;
				}
			}else{
				exportFlag = true;
			}
			
			if(exportFlag){
				hdei = new ExportDoctorInfo();
				hdei.setOrgName(rdre.getDoctor().getOrgName());
				hdei.setDoctorName(rdre.getSysUser().getUserName());
				hdei.setSex(rdre.getSysUser().getSexName());
				hdei.setIdNo(rdre.getSysUser().getIdNo());
				hdei.setGraduatedName(rdre.getDoctor().getGraduatedName());
				hdei.setGraduationTime(rdre.getDoctor().getGraduationTime());
				hdei.setDoctorType(rdre.getDoctor().getDoctorTypeName());
				hdei.setEducationName(rdre.getSysUser().getEducationName());
				hdei.setDegreeName(rdre.getSysUser().getDegreeName());
				hdei.setSpecialized(rdre.getDoctor().getSpecialized());
				hdei.setWorkOrgName(rdre.getDoctor().getWorkOrgName());
				hdei.setSpeName(rdre.getSpeName());
				hdei.setDoctorLicenseFlag(GlobalConstant.FLAG_Y.equals(rdre.getDoctor().getDoctorLicenseFlag())?"是":"否");
				hdei.setQualifiedNo(rdre.getDoctor().getQualifiedNo());
				hdei.setUserPhone(rdre.getSysUser().getUserPhone());
				hdei.setEmail(rdre.getSysUser().getUserEmail());
				hdei.setSwap(rdre.getRecruitTypeName());
				dataList.add(hdei);
			}
				
		}
		String[] titles = getExportTitle();
		fileName = URLEncoder.encode(fileName, "UTF-8");
	    ExcleUtile.exportSimpleExcle(titles, dataList, ExportDoctorInfo.class, response.getOutputStream());
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.setContentType("application/octet-stream;charset=UTF-8");  
	}
	
	@RequestMapping("/test")
	@ResponseBody
	public String test(@RequestBody SysUser user){
		System.out.println(user.getUserName()+"--"+user.getOrgFlow());
		return "1";
	}
}
