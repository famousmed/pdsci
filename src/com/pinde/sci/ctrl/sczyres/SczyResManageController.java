package com.pinde.sci.ctrl.sczyres;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.hbres.RecruitCfgBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResOrgSpeAssignBiz;
import com.pinde.sci.biz.sczyres.DoctorRecruitBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.enums.sczyres.SpeCatEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResOrgSpeAssign;
import com.pinde.sci.model.mo.ResRecruitCfg;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysOrgExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysOrgExample.Criteria;
import com.pinde.sci.model.res.DateCfgMsg;
import com.pinde.sci.model.res.ResDoctorRecruitExt;

@Controller
@RequestMapping("/sczyres/manage")
public class SczyResManageController extends GeneralController{

	@Autowired
	private NoticeBiz noticeBiz;
	@Autowired
	private RecruitCfgBiz recruitCfgBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IResOrgSpeAssignBiz speAssignBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private DoctorRecruitBiz doctorRecruitBiz;
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private IUserBiz userBiz;
	
	@RequestMapping("/home")
	public String home(Integer currentPage , Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(currentPage,10);
		List<InxInfo> messages = this.noticeBiz.findNotice(info);
		model.addAttribute("messages",messages);
		ResDoctor doctor = new ResDoctor();
		//统计已报名
		doctor.setDoctorStatusId("");
		int singupCount = resDoctorBiz.findDoctorCountInOrg(doctor);
		model.addAttribute("singupCount" , singupCount);
		//统计审核通过
		doctor.setDoctorStatusId(RegStatusEnum.Passed.getId());
		int passedCount = resDoctorBiz.findDoctorCountInOrg(doctor);
		model.addAttribute("passedCount" , passedCount);
		//统计录取人数
		ResDoctorRecruit recruit = new ResDoctorRecruit();
		recruit.setRecruitFlag(GlobalConstant.FLAG_Y);
		int recruitCount = this.doctorRecruitBiz.findCountByRecruit(recruit);
		model.addAttribute("recruitCount" , recruitCount);
		return "sczyres/manage/index";
	}
	
	/**
	 * 招录设置
	 */
	@RequestMapping(value="/datecfg")
	public String dateCfg(Model model){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		model.addAttribute("recruitCfg" , recruitCfg);
		
		String currDate = DateUtil.getCurrDate();
		DateCfgMsg regDateCfgMsg = new DateCfgMsg(recruitCfg);
		regDateCfgMsg.setRegDateMsg(currDate);
		
		DateCfgMsg swapDateCfgMsg = new DateCfgMsg(recruitCfg);
		swapDateCfgMsg.setSwapDateMsg(currDate);
		
		model.addAttribute("regDateCfgMsg" , regDateCfgMsg);
		model.addAttribute("swapDateCfgMsg" , swapDateCfgMsg);
		return "sczyres/manage/dateCfg";
	}
	
	
	@RequestMapping("/savedatecfg")
	@ResponseBody
	public String saveDateCfg(ResRecruitCfg recruitCfg){
		this.recruitCfgBiz.saveRecruitCfg(recruitCfg);
	    return GlobalConstant.OPERATE_SUCCESSED;	
	}
	/**
	 * 招录计划
	 */
	@RequestMapping(value="/plan")
	public String plan(String assignYear , String source , String orgFlow , Model model){
		SysOrgExample example = new SysOrgExample();
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<String> types = new ArrayList<String>();
		types.add(OrgTypeEnum.Hospital.getId());
		criteria.andOrgTypeIdIn(types);
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
		ResDoctorRecruit recruit=new ResDoctorRecruit();
		List<SysOrg>orgList2=orgBiz.searchSysOrg();
		Map<String,Integer> recruitCountMap = new HashMap<String,Integer>();
		for(SysOrg rdr : orgList2){
			recruit.setOrgFlow(rdr.getOrgFlow());
			recruit.setRecruitFlag(GlobalConstant.FLAG_Y);
			int recruitCount=doctorRecruitBiz.findCountByRecruit(recruit);
			recruitCountMap.put(rdr.getOrgFlow(), recruitCount);
		}
		model.addAttribute("recruitCountMap", recruitCountMap);
		model.addAttribute("totalNum",totalNum);
		
		return "sczyres/manage/plan";
	}
	@RequestMapping(value="/planInfo")
	public String planInfo(String assignYear,String orgFlow,Model model){
		SysOrgExample example = new SysOrgExample();
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<String> types = new ArrayList<String>();
		types.add(OrgTypeEnum.Hospital.getId());
		criteria.andOrgTypeIdIn(types);
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
		
		return "sczyres/manage/planInfo";
	}
	
	/**
	 * 招录计划保存
	 */
	@RequestMapping(value="/savePlan")
	@ResponseBody
	public String savePlan(ResOrgSpeAssign speAssign){
		if(speAssign!=null){
			if(StringUtil.isNotBlank(speAssign.getSpeId())){
				speAssign.setSpeName(SpeCatEnum.getNameById(speAssign.getSpeId()));
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
	@RequestMapping(value="/spe")
	public String spe(Model model) throws Exception{
		return "sczyres/manage/spe";
	}
	
	/**
	 * 基地维护
	 */
	@RequestMapping(value="/org")
	public String orgCfg(String isCountry,Model model){
		SysOrgExample example = new SysOrgExample();
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<String> types = new ArrayList<String>();
		types.add(OrgTypeEnum.Hospital.getId());
		criteria.andOrgTypeIdIn(types);
		example.setOrderByClause("ORDINAL");
		List<SysOrg> orgList = orgBiz.searchOrgByExample(example);
		model.addAttribute("orgList",orgList);
		return "sczyres/manage/org";
	}
	@RequestMapping("/noticemanage")
	public String noticeManage(Integer currentPage , Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(currentPage,5);
		List<InxInfo> infos = this.noticeBiz.findNotice(info);
		model.addAttribute("infos",infos);
		return "sczyres/manage/notice";
	}
	
	
	@RequestMapping("/showDocRecruit")
	public String showDocRecruit(String orgFlow , String confirmFlag , Model model){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("recruitYear", regYear);
		paramMap.put("recruitFlag", GlobalConstant.FLAG_Y);
		if (StringUtil.isNotBlank(orgFlow)) {
			paramMap.put("orgFlow", orgFlow);
		}
		if(GlobalConstant.FLAG_Y.equals(confirmFlag)){
			paramMap.put("confirmFlag", confirmFlag);
		}
		if(GlobalConstant.NULL.equals(confirmFlag)){
			paramMap.put("confirmFlagIsNull", confirmFlag);
		}
		List<ResDoctorRecruitExt> doctorRecruitExts = this.doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
		model.addAttribute("doctorRecruitExts" , doctorRecruitExts);
		ResDoctorRecruit recruit = new ResDoctorRecruit();
		recruit.setOrgFlow(orgFlow);
		recruit .setRecruitFlag(GlobalConstant.FLAG_Y);
		int recruitCount=doctorRecruitBiz.findCountByRecruit(recruit);
		//录取人数
		model.addAttribute("recruitCount", recruitCount);
		recruit .setConfirmFlag(GlobalConstant.FLAG_Y);
		int confirmCount=doctorRecruitBiz.findCountByRecruit(recruit);
		//确认录取人数
		model.addAttribute("confirmCount", confirmCount);
		SysOrgExample orgExample = new SysOrgExample();
		orgExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
		orgExample.setOrderByClause("ORDINAL");
		List<SysOrg> orgs = this.orgBiz.searchOrgByExample(orgExample);
		model.addAttribute("hospitals", orgs);
	    return "sczyres/manage/showRecruitDoctor";
	}
	
	/**
	 * 查看招录的整体情况
	 * @param orgFlow
	 * @param speId
	 * @param model
	 * @return
	 */
	@RequestMapping("/showRecruit")
	public String showRecruit(String orgFlow , String speId , Model model){
		//查询出所有基地
		SysOrgExample orgExample = new SysOrgExample();
		orgExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
		orgExample.setOrderByClause("ORDINAL");
		List<SysOrg> orgs = this.orgBiz.searchOrgByExample(orgExample);
		model.addAttribute("hospitals", orgs);
		List<SysDict> spes = new ArrayList<SysDict>();
		//查询出所有专业
		List<SysDict> zySpes = DictTypeEnum.sysListDictMap.get(DictTypeEnum.ZySpe.getId());
		for(SysDict zyspe:zySpes){
			SysDict spe = new SysDict();
			spe.setDictId(SpeCatEnum.Zy.getId()+"."+zyspe.getDictId());
			spe.setDictName(zyspe.getDictName());
			spes.add(spe);
		}
		List<SysDict> zyqkSpes = DictTypeEnum.sysListDictMap.get(DictTypeEnum.ZyqkSpe.getId());
		for(SysDict zyqkspe:zyqkSpes){
			SysDict spe = new SysDict();
			spe.setDictId(SpeCatEnum.Zyqk.getId()+"."+zyqkspe.getDictId());
			spe.setDictName(zyqkspe.getDictName());
			spes.add(spe);
		}
		model.addAttribute("spes" , spes);
		ResDoctorRecruit recruit = new ResDoctorRecruit();
		recruit.setRecruitFlag(GlobalConstant.FLAG_Y);
		Map<String , String> countResultMap = new HashMap<String, String>();
		//如果orgFlow不为空，speId为空 查询该基地下所有专业的录取人数
		if(StringUtil.isNotBlank(orgFlow)&&StringUtil.isBlank(speId)){
			recruit.setOrgFlow(orgFlow);
			for(SysDict spe:spes){
				String[] spedata = spe.getDictId().split("\\.");
				recruit.setCatSpeId(spedata[0]);
				recruit.setSpeId(spedata[1]);
				int count = this.doctorRecruitBiz.findCountByRecruit(recruit);
				countResultMap.put(spe.getDictId(), String.valueOf(count));
			}
			model.addAttribute("countResultMap", countResultMap);
			
		}
		//如果orgFlow为空，speId不为空 ， 查询所有基地该专业的录取人数
		if(StringUtil.isBlank(orgFlow)&&StringUtil.isNotBlank(speId)){
			String[] spedata = speId.split("\\.");
			recruit.setCatSpeId(spedata[0]);
			recruit.setSpeId(spedata[1]);
			for(SysOrg org:orgs){
				recruit.setOrgFlow(org.getOrgFlow());
				int count = this.doctorRecruitBiz.findCountByRecruit(recruit);
				countResultMap.put(org.getOrgFlow(), String.valueOf(count));
			}
			model.addAttribute("countResultMap", countResultMap);
		}
		//如果orgFlow,speId都不为空，查询该基地该专业的录取人数
		if(StringUtil.isNotBlank(orgFlow)&&StringUtil.isNotBlank(speId)){
			String[] spedata = speId.split("\\.");
			recruit.setCatSpeId(spedata[0]);
			recruit.setSpeId(spedata[1]);
			recruit.setOrgFlow(orgFlow);
			int count = this.doctorRecruitBiz.findCountByRecruit(recruit);
			model.addAttribute("recruitCount" , count);
		}
		return "sczyres/manage/jidirecruitinfo";
	}
	
	/**
	 * 学员调剂
	 * @return
	 */
	@RequestMapping("/swap")
	public String swap(String key , Model model){
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		String currDate = DateUtil.getCurrDate();
		DateCfgMsg regDateCfgMsg = new DateCfgMsg(recruitCfg);
		regDateCfgMsg.setSwapDateMsg(currDate);
		if(!regDateCfgMsg.getAllowSwap()){
			model.addAttribute("msg" , "当前调剂"+regDateCfgMsg.getMsg()) ;
			return "sczyres/doctor/notallowswap";
		}
		
		//首先查询出未被录取的学员
		Map<String,Object> paramMap = new HashMap<String,Object>();
		//paramMap.put("orgFlow", orgFlow);
		
		paramMap.put("recruitYear", regYear);
		paramMap.put("doctorStatusId", RegStatusEnum.Passed.getId());
		paramMap.put("recruitFlag", GlobalConstant.FLAG_N);
		if(StringUtil.isNotBlank(key)){
			paramMap.put("key", key);
		}
		List<ResDoctorRecruitExt> doctorRecruitExts = this.doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
		model.addAttribute("doctorRecruitExts", doctorRecruitExts);	
		if(!doctorRecruitExts.isEmpty()){
			List<String> noRecruitDoctors = new ArrayList<String>();
			for(ResDoctorRecruitExt dre:doctorRecruitExts){
				noRecruitDoctors.add(dre.getDoctorFlow());
			}
			Map<String , ResDoctorRecruit> swapRecruitMap = this.doctorRecruitBiz.findSwapDoctorRecruit(noRecruitDoctors);
			model.addAttribute("swapRecruitMap" , swapRecruitMap);
		}
		
		return "sczyres/manage/swaprecruit";
	}
	
	@RequestMapping("/openSwapPage")
	public String openSwapPage(String doctorFlow , String recruitFlow , Model model){
		ResDoctorRecruit recruit = this.doctorRecruitBiz.readResDoctorRecruit(recruitFlow);
		model.addAttribute("recruit" , recruit);
		SysUser user = this.userBiz.readSysUser(recruit.getDoctorFlow());
		model.addAttribute("user" , user);
		SysOrgExample orgExample = new SysOrgExample();
		orgExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId());
		orgExample.setOrderByClause("ORDINAL");
		List<SysOrg> orgs = this.orgBiz.searchOrgByExample(orgExample);
		model.addAttribute("hospitals", orgs);
		return "sczyres/manage/swapRecruitMain";
	}
	
	@RequestMapping("/swapRecruit")
	@ResponseBody
	public String swapRecruit(ResDoctorRecruitWithBLOBs recruit){
		this.doctorRecruitBiz.swapRecruit(recruit);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
//	@RequestMapping(value="/accounts")
//	public String accounts(Model model) throws Exception{
//		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
//		SysLogExample example = new SysLogExample();
//		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(user.getUserFlow());
//		example.setOrderByClause("create_time desc");
//		List<SysLog> logs = logMapper.selectByExample(example);
//		if(logs!=null && logs.size()>0){
//			model.addAttribute("log", logs.get(0));
//		}
//		return "sczyres/accounts";
//	}
}
