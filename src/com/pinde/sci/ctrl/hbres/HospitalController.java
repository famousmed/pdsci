package com.pinde.sci.ctrl.hbres;


import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.ExcleUtile;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.GradeManageBiz;
import com.pinde.sci.biz.hbres.IResDoctorRecruitBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResOrgSpeAssignBiz;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.RecruitTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResOrgSpeAssign;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.HospitalDoctorExportInfo;
import com.pinde.sci.model.res.ResDoctorRecruitExt;

@Controller
@RequestMapping("/hbres/singup/hospital")
public class HospitalController extends GeneralController {

	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IResOrgSpeAssignBiz speAssignBiz;
	@Autowired
	private IDictBiz dictBiz;
	@Autowired
	private IResDoctorRecruitBiz doctorRecruitBiz;
	@Autowired
	private IResDoctorBiz doctorBiz;
	@Autowired
	private GradeManageBiz gradeManage;
	
	
	/**
	 * 招录主页
	 * @return
	 */
	@RequestMapping(value="main")
	public String main(Model model){
		
		Map<String , Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dictTypeId", DictTypeEnum.DoctorTrainingSpe.getId());
		List<SysDict> doctorTrainingSpeList = this.doctorRecruitBiz.searchTrainSpeList(paramMap);
		model.addAttribute("doctorTrainingSpeList",doctorTrainingSpeList);
		
		int totalAssignPlan = 0;
		//int totalRetestNum = 0;
		//int totalRecruitNum = 0;
		int totalFillNum = 0;
		int totalConfirmCount = 0;
		
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		if (StringUtil.isNotBlank(orgFlow)) {
			String regYear = InitConfig.getSysCfg("res_reg_year");
			//组织专业对应的招录计划数map
			List<ResOrgSpeAssign> speAssignList = speAssignBiz.searchSpeAssign(orgFlow,regYear);
			if(speAssignList!=null && speAssignList.size()>0){
				Map<String,ResOrgSpeAssign> speAssignMap = new HashMap<String,ResOrgSpeAssign>();
				for(ResOrgSpeAssign rosa : speAssignList){
					speAssignMap.put(rosa.getSpeId(),rosa);
					if (rosa.getAssignPlan() != null) {
						totalAssignPlan += rosa.getAssignPlan().intValue();
					}
				}
				model.addAttribute("speAssignMap",speAssignMap);
			}
			
			//组织专业对应的填报志愿数和复试数map
			ResDoctorRecruit recruit = new ResDoctorRecruit();
			recruit.setOrgFlow(orgFlow);
			recruit.setRecruitYear(regYear);
			List<ResDoctorRecruit> doctorRecruit = doctorRecruitBiz.searchDoctorRecruit(recruit);
			if(doctorRecruit!=null && doctorRecruit.size()>0){
				//填报志愿人数
				Map<String,Integer> recruitNumMap = new HashMap<String,Integer>();
				//发送复试通知人数
				Map<String,Integer> retestNumMap = new HashMap<String,Integer>();
				//调剂人数(别的专业调剂到本专业的人数)
				Map<String , Integer> swapCountMap = new HashMap<String, Integer>();
				//确认录取人数
				Map<String, Integer> confirmCountMap = new HashMap<String, Integer>();
				for(ResDoctorRecruit rdr : doctorRecruit){
					//填报志愿数
					if (RecruitTypeEnum.Fill.getId().equals(rdr.getRecruitTypeId())) {
						totalFillNum++;
						Integer recruitNum = recruitNumMap.get(rdr.getSpeId());
						if(recruitNum==null){recruitNum=0;}
						recruitNum++;
						recruitNumMap.put(rdr.getSpeId(),recruitNum);
					}
					//已发送复试通知人数
					if(GlobalConstant.FLAG_Y.equals(rdr.getRetestFlag())){
						Integer retestCount = retestNumMap.get(rdr.getSpeId());
						if(retestCount==null){retestCount=0;}
						retestCount++;
						retestNumMap.put(rdr.getSpeId(), retestCount);
					}
					//调剂人数
					if(RecruitTypeEnum.Swap.getId().equals(rdr.getRecruitTypeId())){
						Integer swapNum = swapCountMap.get(rdr.getSpeId());
						if(swapNum==null){swapNum=0;}
						swapNum++;
						swapCountMap.put(rdr.getSpeId(), swapNum);
					}
					
					//确认录取人数
					if(GlobalConstant.FLAG_Y.equals(rdr.getConfirmFlag())){
						totalConfirmCount++;
						Integer confirmCount = confirmCountMap.get(rdr.getSpeId());
						if(confirmCount==null){confirmCount=0;}
						confirmCount++;
						confirmCountMap.put(rdr.getSpeId(), confirmCount);
					}
				}
				model.addAttribute("recruitNumMap",recruitNumMap);
				model.addAttribute("retestNumMap",retestNumMap);
				model.addAttribute("swapCountMap",swapCountMap);
				model.addAttribute("confirmCountMap",confirmCountMap);
			}
		}
		model.addAttribute("totalAssignPlan",totalAssignPlan);
		//model.addAttribute("totalRetestNum",totalRetestNum);
		//model.addAttribute("totalRecruitNum",totalRecruitNum);
		model.addAttribute("totalFillNum",totalFillNum);
		model.addAttribute("totalConfirmCount",totalConfirmCount);
		
		return "hbres/hospital/main";
	}
	
	/**
	 * 获取该基地改专业下的人员名单
	 * @param speId
	 * @return
	 */
	@RequestMapping("/getdoctors")
	public String getDoctors(String speId , String graduatedId , String key , String batchOper , Model model){
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("orgFlow", orgFlow);
		paramMap.put("recruitYear", regYear);
		paramMap.put("speId", speId);
		if(StringUtil.isNotBlank(graduatedId)){
			paramMap.put("graduatedId", graduatedId);	
		}
		if(StringUtil.isNotBlank(key)){
			paramMap.put("key", key);
		}
		List<ResDoctorRecruitExt> doctorRecruitExts = this.doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
		ResOrgSpeAssign currSpe = speAssignBiz.searchSpeAssign(orgFlow, regYear , speId);
		model.addAttribute("currSpe" , currSpe);
		if(StringUtil.isBlank(batchOper)){
			model.addAttribute("doctorRecruitExts", doctorRecruitExts);	
		}else if("1".equals(batchOper)){
			//只查需要复试通知的
			List<ResDoctorRecruitExt> needRetesDoctorExt = new ArrayList<ResDoctorRecruitExt>();
			for(ResDoctorRecruitExt rdre : doctorRecruitExts){
			     if(GlobalConstant.FLAG_N.equals(rdre.getRetestFlag())){
			    	 needRetesDoctorExt.add(rdre);
			     }	
			}
			model.addAttribute("doctorRecruitExts", needRetesDoctorExt);	
		}else if("2".equals(batchOper)){
			//只查需要录取通知
			List<ResDoctorRecruitExt> needRecruitDoctorExt = new ArrayList<ResDoctorRecruitExt>();
            for(ResDoctorRecruitExt rdre : doctorRecruitExts){
				if(rdre.getTotleResult()!=null && GlobalConstant.FLAG_N.equals(rdre.getAdmitFlag()) && StringUtil.isBlank(rdre.getRecruitFlag())){
					needRecruitDoctorExt.add(rdre);
				}
			}
            model.addAttribute("doctorRecruitExts", needRecruitDoctorExt);	
		}
		
		return "hbres/hospital/doctors";
	}
	
	/**
	 * 获取学员详细信息
	 * @param recruitFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="doctorInfo")
	public String doctorInfo(String recruitFlow , Model model){
		ResDoctorRecruit recruit = doctorRecruitBiz.readResDoctorRecruit(recruitFlow);
		ResDoctor doctor = doctorBiz.readDoctor(recruit.getDoctorFlow());
		SysUser user = userBiz.readSysUser(recruit.getDoctorFlow());
		model.addAttribute("recruit", recruit);
		model.addAttribute("doctor", doctor);
		model.addAttribute("user", user);
		//查询招录历史
		List<ResDoctorRecruit> doctorRecruits = this.gradeManage.findResDoctorRecruits(recruit.getRecruitYear(), recruit.getDoctorFlow());
		Collections.reverse(doctorRecruits);
		model.addAttribute("doctorRecruits" , doctorRecruits);
		return "hbres/hospital/doctorInfo";
	}
	
	/**
	 * 显示复试通知页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="noticeRetestMain")
	public String noticeRetestMain(Model model){
		return "hbres/hospital/noticeRetestMain";
	}
	
	@RequestMapping("/gradeedit")
	public String gradeEdit(String recruitFlow , Model model){
		ResDoctorRecruit recruit = this.doctorRecruitBiz.readResDoctorRecruit(recruitFlow);
		model.addAttribute("recruit" , recruit);
		return "hbres/hospital/gradeedit";
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
			ResDoctorRecruit oldRecruit = this.doctorRecruitBiz.readResDoctorRecruit(recruit.getRecruitFlow());
		    BigDecimal examResult = oldRecruit.getExamResult();
		    BigDecimal operResult = recruit.getOperResult();
		    BigDecimal auditonResult = recruit.getAuditionResult();
		    BigDecimal totalResult = null;
		    //总成绩=(笔试分*100/150)*0.4 + 面试分*0.2 + 操作技能分*0.4
		    if(examResult != null && operResult != null && auditonResult != null){
		    	totalResult = new BigDecimal(0);
		    	totalResult = examResult.multiply(new BigDecimal(100))
		    			.divide(new BigDecimal(150) , 3 , BigDecimal.ROUND_HALF_UP)
		    			.multiply(new BigDecimal(0.4))
						.add(operResult.multiply(new BigDecimal(0.4)))
						.add(auditonResult.multiply(new BigDecimal(0.2)));
				totalResult = totalResult.setScale(2,BigDecimal.ROUND_HALF_UP);
				recruit.setTotleResult(totalResult);
		    }
		    this.doctorRecruitBiz.editDoctorRecruit(recruit);
		    return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
		
	}
	
	/**
	 * 显示录取通知的界面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="noticeRecruitMain")
	public String noticeRecruitMain(Model model){
		String title = "录取通知内容";
		model.addAttribute("title" , title);
		return "hbres/hospital/noticeRecruitMain";
	}
	
	/**
	 * 确认录取
	 * @param doctorFlows
	 * @param admitNotice
	 * @return
	 */
	@RequestMapping(value="/noticeRecruit")
	@ResponseBody
	public String noticeRecruit(String[] recruitFlows,String admitNotice) {
		this.doctorRecruitBiz.noticeRecruit(admitNotice,recruitFlows);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * 不录取
	 * @return
	 */
	@RequestMapping("/notrecruit")
	@ResponseBody
	public String notRecruit(String recruitFlow){
		ResDoctorRecruitWithBLOBs recruit = new ResDoctorRecruitWithBLOBs();
		recruit.setRecruitFlow(recruitFlow);
		recruit.setRecruitFlag(GlobalConstant.FLAG_N);
		this.doctorRecruitBiz.editDoctorRecruit(recruit);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	@RequestMapping(value="noticeSwapMain")
	public String noticeSwapMain(String recruitFlow , String speId , Model model){
		String title = "调剂通知内容";
		model.addAttribute("title" , title);
		model.addAttribute("noticeType" , "swap");
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
	    String regYear = InitConfig.getSysCfg("res_reg_year");
		List<ResOrgSpeAssign> speAssignList = speAssignBiz.searchSpeAssign(orgFlow,regYear);
		List<ResOrgSpeAssign> spes = new ArrayList<ResOrgSpeAssign>();
		for(ResOrgSpeAssign spe:speAssignList){
			if(!spe.getSpeId().equals(speId)  && spe.getAssignPlan()!=null && spe.getAssignPlan().compareTo(new BigDecimal(0))>0){
				spes.add(spe);
			}
		}
		model.addAttribute("spes" , spes);
		return "hbres/hospital/noticeRecruitMain";
	}
	
	@RequestMapping("/swaprecruit")
	@ResponseBody
	public String swapRecruit(String recruitFlow , String speFlow , String swapNotice){
		this.doctorRecruitBiz.swapRecruit(recruitFlow, speFlow, swapNotice);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * 各专业报考志愿人员统计
	 * @param model
	 * @return
	 */
//	@RequestMapping(value="retest")
//	public String retest(String key,Model model){
//		model.addAttribute("key",key);
//		Map<String , Object> paramMap = new HashMap<String, Object>();
//		paramMap.put("dictTypeId", DictTypeEnum.DoctorTrainingSpe.getId());
//		paramMap.put("key", key);
//		List<SysDict> doctorTrainingSpeList = this.doctorRecruitBiz.searchTrainSpeList(paramMap);
//		model.addAttribute("doctorTrainingSpeList",doctorTrainingSpeList);
//		
//		int totalAssignPlan = 0;
//		int totalRetestNum = 0;
//		
//		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
//		String orgFlow = user.getOrgFlow();
//		if (StringUtil.isNotBlank(orgFlow)) {
//			String regYear = InitConfig.getSysCfg("res_reg_year");
//			//组织专业对应的招录计划数map
//			List<ResOrgSpeAssign> speAssignList = speAssignBiz.searchSpeAssign(orgFlow,regYear);
//			if(speAssignList!=null && speAssignList.size()>0){
//				Map<String,ResOrgSpeAssign> speAssignMap = new HashMap<String,ResOrgSpeAssign>();
//				for(ResOrgSpeAssign rosa : speAssignList){
//					speAssignMap.put(rosa.getSpeId(),rosa);
//					if (rosa.getAssignPlan() != null) {
//						totalAssignPlan += rosa.getAssignPlan().intValue();
//					}
//				}
//				model.addAttribute("speAssignMap",speAssignMap);
//			}
//			
//			//组织专业对应的填报志愿数和复试数map
//			ResDoctorRecruit recruit = new ResDoctorRecruit();
//			recruit.setOrgFlow(orgFlow);
//			recruit.setRecruitYear(regYear);
//			//recruit.setOrdinal(1);//第一志愿
//			List<ResDoctorRecruit> doctorRecruit = doctorRecruitBiz.searchDoctorRecruit(recruit);
//			if(doctorRecruit!=null && doctorRecruit.size()>0){
//				Map<String,Integer> recruitNumMap = new HashMap<String,Integer>();
//				Map<String,Integer> retestNumMap = new HashMap<String,Integer>();
//				for(ResDoctorRecruit rdr : doctorRecruit){
//					//填报志愿数
//					int recruitNum = 0;
//					if (recruitNumMap.get(rdr.getSpeId()) != null) {
//						recruitNum = recruitNumMap.get(rdr.getSpeId());
//					}
//					recruitNum++;
//					recruitNumMap.put(rdr.getSpeId(),recruitNum);
//					//复试数
//					if (GlobalConstant.FLAG_Y.equals(rdr.getRetestFlag())) {
//						int retestNum = 0;
//						if (retestNumMap.get(rdr.getSpeId()) != null) {
//							retestNum = retestNumMap.get(rdr.getSpeId());
//						}
//						retestNum++;
//						retestNumMap.put(rdr.getSpeId(),retestNum);
//						totalRetestNum++;
//					}
//				}
//				model.addAttribute("recruitNumMap",recruitNumMap);
//				model.addAttribute("retestNumMap",retestNumMap);
//			}
//		}
//		model.addAttribute("totalAssignPlan",totalAssignPlan);
//		model.addAttribute("totalRetestNum",totalRetestNum);
//		
//		return "hbres/hospital/retest";
//	}
	
//	@RequestMapping(value="retestUsers")
//	public String retestUsers(String speId,String assignPlan,String userName,String graduatedId,
//			Integer currentPage,Model model){
//		String speName = DictTypeEnum.DoctorTrainingSpe.getDictNameById(speId);
//		model.addAttribute("speName", speName);
//		model.addAttribute("speId", speId);
//		model.addAttribute("assignPlan", assignPlan);
//		model.addAttribute("currPage", currentPage==null?1:currentPage);
//		
//		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
//		String orgFlow = user.getOrgFlow();
//		String regYear = InitConfig.getSysCfg("res_reg_year");
//		
//		//复试人数
//		ResDoctorRecruit recruit = new ResDoctorRecruit();
//		recruit.setOrgFlow(orgFlow);
//		recruit.setRecruitYear(regYear);
//		recruit.setSpeId(speId);
//		//recruit.setOrdinal(1);//第一志愿
//		recruit.setRetestFlag(GlobalConstant.FLAG_Y);
//		int retestNum = doctorRecruitBiz.searchDoctorNum(recruit);
//		model.addAttribute("retestNum", retestNum);
//		
//		PageHelper.startPage(currentPage,10);
//		Map<String,Object> paramMap = new HashMap<String,Object>();
//		paramMap.put("orgFlow", orgFlow);
//		paramMap.put("recruitYear", regYear);
//		paramMap.put("speId", speId);
//		paramMap.put("ordinal", 1);//第一志愿
//		paramMap.put("userName", userName);
//		paramMap.put("graduatedId", graduatedId);
//		List<ResDoctorRecruitExt> doctorRecruitExts = doctorRecruitBiz.searchDoctorRecruitExt(paramMap);
//		model.addAttribute("doctorRecruitExts", doctorRecruitExts);
//		return "hbres/hospital/retestUsers";
//	}
	
	

	
	
	
	/**
	 * 通知复试（单个操作）
	 * @param doctorFlow
	 * @param speId
	 * @param retestNotice
	 * @return
	 */
	@RequestMapping(value="/noticeRetestSingle")
	@ResponseBody
	public String noticeRetestSingle(String recruitFlow,String retestNotice) {
		this.doctorRecruitBiz.noticeRetest(recruitFlow , retestNotice);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	/**
	@RequestMapping(value="/noticeRetestConfirm")
	@ResponseBody
	public String noticeRetestConfirm(String[] speIds) {
		String recruitYear = InitConfig.getSysCfg("res_reg_year");
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("orgFlow", orgFlow);
		paramMap.put("recruitYear", recruitYear);
		paramMap.put("speIds", speIds);
		paramMap.put("ordinal", 1);//第一志愿
		String noticeNum = this.doctorRecruitBiz.searchNoticeDoctorNum(paramMap);
		return noticeNum;
	}*/
	
	/**
	 * 通知复试（批量操作）
	 * @param retestNotice
	 * @return
	 */
	@RequestMapping(value="/noticeRetestBatch")
	@ResponseBody
	public String noticeRetestBatch(String[] recruitFlows,String retestNotice) {
		this.doctorRecruitBiz.noticeRetestBatch(recruitFlows,retestNotice);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
//	@RequestMapping(value="gradeinput")
//	public String gradeinput(String key,
//			Integer currentPage,Model model){
//		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
//		String orgFlow = user.getOrgFlow();
//		String regYear = InitConfig.getSysCfg("res_reg_year");
//		
//		//复试人员列表
//		PageHelper.startPage(currentPage,10);
//		Map<String,Object> paramMap = new HashMap<String,Object>();
//		paramMap.put("orgFlow", orgFlow);
//		paramMap.put("recruitYear", regYear);
//		paramMap.put("retestFlag", GlobalConstant.FLAG_Y);
//		paramMap.put("ordinal", 1);//第一志愿
//		paramMap.put("key", key);
//		List<ResDoctorRecruitExt> doctorRecruitExts = doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
//		model.addAttribute("doctorRecruitExts", doctorRecruitExts);
//		model.addAttribute("key", key);
//		return "hbres/hospital/gradeinput";
//	}
	
//	@RequestMapping("/inputGrade")
//	@ResponseBody
//	public String inputGrade(String doctorFlow,String result,String resultType){
//		String regYear = InitConfig.getSysCfg("res_reg_year");
//		ResDoctorRecruit docRecruit = null;
//		ResDoctorRecruit recruit = new ResDoctorRecruit();
//		recruit.setDoctorFlow(doctorFlow);
//		recruit.setRecruitYear(regYear);
//		List<ResDoctorRecruit> docRecruits = doctorRecruitBiz.searchDoctorRecruit(recruit);
//		if (docRecruits != null && docRecruits.size() > 0) {
//			docRecruit = docRecruits.get(0);
//		}
//		if (docRecruit != null) {
//			BigDecimal totalResult = docRecruit.getTotleResult();
//			BigDecimal examResult = docRecruit.getExamResult();
//			BigDecimal operResult = docRecruit.getOperResult();
//			BigDecimal auditonResult = docRecruit.getAuditionResult();
//			BigDecimal res = null;
//			if (StringUtil.isNotBlank(result)) {
//				res = new BigDecimal(result);
//			}
//			//更新数据
//			if ("operResult".equals(resultType)) {
//				operResult = res;
//				docRecruit.setOperResult(operResult);
//			}
//			if ("auditionResult".equals(resultType)) {
//				auditonResult = res;
//				docRecruit.setAuditionResult(auditonResult);
//			}
//			
//			//计算总成绩（笔试成绩*40%+技能操作考试*40%+面试成绩*20%）
//			if (examResult != null && operResult != null && auditonResult != null) {
//				totalResult = examResult.multiply(new BigDecimal(0.4))
//						.add(operResult.multiply(new BigDecimal(0.4)))
//						.add(auditonResult.multiply(new BigDecimal(0.2)));
//				totalResult = totalResult.setScale(1,BigDecimal.ROUND_HALF_UP);
//				docRecruit.setTotleResult(totalResult);
//			} else {
//				docRecruit.setTotleResult(null);
//			}
//			this.doctorRecruitBiz.editRecruitUnSelective(docRecruit);
//			return GlobalConstant.OPRE_SUCCESSED;
//		}
//		return GlobalConstant.OPRE_FAIL;
//	}
	
//	@RequestMapping(value="recruitNotice")
//	public String recruitNotice(Model model){
//		Map<String , Object> paramMap = new HashMap<String, Object>();
//		paramMap.put("dictTypeId", DictTypeEnum.DoctorTrainingSpe.getId());
//		List<SysDict> doctorTrainingSpeList = this.doctorRecruitBiz.searchTrainSpeList(paramMap);
//		model.addAttribute("doctorTrainingSpeList",doctorTrainingSpeList);
//		
//		int totalAssignPlan = 0;
//		int totalRetestNum = 0;
//		int totalRecruitNum = 0;
//		
//		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
//		String orgFlow = user.getOrgFlow();
//		if (StringUtil.isNotBlank(orgFlow)) {
//			String regYear = InitConfig.getSysCfg("res_reg_year");
//			//组织专业对应的招录计划数map
//			List<ResOrgSpeAssign> speAssignList = speAssignBiz.searchSpeAssign(orgFlow,regYear);
//			if(speAssignList!=null && speAssignList.size()>0){
//				Map<String,ResOrgSpeAssign> speAssignMap = new HashMap<String,ResOrgSpeAssign>();
//				for(ResOrgSpeAssign rosa : speAssignList){
//					speAssignMap.put(rosa.getSpeId(),rosa);
//					if (rosa.getAssignPlan() != null) {
//						totalAssignPlan += rosa.getAssignPlan().intValue();
//					}
//				}
//				model.addAttribute("speAssignMap",speAssignMap);
//			}
//			
//			//组织专业对应的填报志愿数和复试数map
//			ResDoctorRecruit recruit = new ResDoctorRecruit();
//			recruit.setOrgFlow(orgFlow);
//			recruit.setRecruitYear(regYear);
//			//recruit.setOrdinal(1);//第一志愿
//			List<ResDoctorRecruit> doctorRecruit = doctorRecruitBiz.searchDoctorRecruit(recruit);
//			if(doctorRecruit!=null && doctorRecruit.size()>0){
//				Map<String,Integer> recruitNumMap = new HashMap<String,Integer>();
//				Map<String,Integer> retestNumMap = new HashMap<String,Integer>();
//				Map<String,Integer> recruitYNumMap = new HashMap<String,Integer>();
//				for(ResDoctorRecruit rdr : doctorRecruit){
//					//填报志愿数
//					int recruitNum = 0;
//					if (recruitNumMap.get(rdr.getSpeId()) != null) {
//						recruitNum = recruitNumMap.get(rdr.getSpeId());
//					}
//					recruitNum++;
//					recruitNumMap.put(rdr.getSpeId(),recruitNum);
//					//复试数
//					if (GlobalConstant.FLAG_Y.equals(rdr.getRetestFlag())) {
//						int retestNum = 0;
//						if (retestNumMap.get(rdr.getSpeId()) != null) {
//							retestNum = retestNumMap.get(rdr.getSpeId());
//						}
//						retestNum++;
//						retestNumMap.put(rdr.getSpeId(),retestNum);
//						totalRetestNum++;
//					}
//					//预录取数
//					if (GlobalConstant.FLAG_Y.equals(rdr.getRecruitFlag())) {
//						int recruitYNum = 0;
//						if (recruitYNumMap.get(rdr.getSpeId()) != null) {
//							recruitYNum = recruitYNumMap.get(rdr.getSpeId());
//						}
//						recruitYNum++;
//						recruitYNumMap.put(rdr.getSpeId(),recruitYNum);
//						totalRecruitNum++;
//					}
//				}
//				model.addAttribute("recruitNumMap",recruitNumMap);
//				model.addAttribute("retestNumMap",retestNumMap);
//				model.addAttribute("recruitYNumMap",recruitYNumMap);
//			}
//		}
//		model.addAttribute("totalAssignPlan",totalAssignPlan);
//		model.addAttribute("totalRetestNum",totalRetestNum);
//		model.addAttribute("totalRecruitNum",totalRecruitNum);
//		
//		return "hbres/hospital/recruitNotice";
//	}
//	
//	@RequestMapping(value="recruitUsers")
//	public String recruitUsers(String speId,String assignPlan,String key,Model model){
//		String speName = DictTypeEnum.DoctorTrainingSpe.getDictNameById(speId);
//		model.addAttribute("speName", speName);
//		model.addAttribute("speId", speId);
//		model.addAttribute("assignPlan", assignPlan);
//		
//		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
//		String orgFlow = user.getOrgFlow();
//		String regYear = InitConfig.getSysCfg("res_reg_year");
//		
//		//复试人数
//		ResDoctorRecruit recruit = new ResDoctorRecruit();
//		recruit.setOrgFlow(orgFlow);
//		recruit.setRecruitYear(regYear);
//		recruit.setSpeId(speId);
//		//recruit.setOrdinal(1);//第一志愿
//		recruit.setRetestFlag(GlobalConstant.FLAG_Y);
//		int retestNum = doctorRecruitBiz.searchDoctorNum(recruit);
//		model.addAttribute("retestNum", retestNum);
//		
//		//预录取人数
//		ResDoctorRecruit recruit1 = new ResDoctorRecruit();
//		recruit1.setOrgFlow(orgFlow);
//		recruit1.setRecruitYear(regYear);
//		recruit1.setSpeId(speId);
//		//recruit1.setOrdinal(1);//第一志愿
//		recruit1.setRetestFlag(GlobalConstant.FLAG_Y);
//		recruit1.setRecruitFlag(GlobalConstant.FLAG_Y);
//		int recruitNum = doctorRecruitBiz.searchDoctorNum(recruit1);
//		model.addAttribute("recruitNum", recruitNum);
//		
//		Map<String,Object> paramMap = new HashMap<String,Object>();
//		paramMap.put("orgFlow", orgFlow);
//		paramMap.put("recruitYear", regYear);
//		paramMap.put("speId", speId);
//		paramMap.put("ordinal", 1);//第一志愿
//		paramMap.put("retestFlag", GlobalConstant.FLAG_Y);
//		paramMap.put("key", key);
//		List<ResDoctorRecruitExt> doctorRecruitExts = doctorRecruitBiz.readDoctorRecruitExt(paramMap);
//		model.addAttribute("doctorRecruitExts", doctorRecruitExts);
//		model.addAttribute("key", key);
//		return "hbres/hospital/recruitUsers";
//	}
	
	
	
//	/**
//	 * 录取结果
//	 * @return
//	 */
//	@RequestMapping(value={"/recruitResultList"})
//	public String recruitResultList(Model model){
//		Map<String , Object> paramMap = new HashMap<String, Object>();
//		paramMap.put("dictTypeId", DictTypeEnum.DoctorTrainingSpe.getId());
//		List<SysDict> doctorTrainingSpeList = this.doctorRecruitBiz.searchTrainSpeList(paramMap);
//		model.addAttribute("doctorTrainingSpeList", doctorTrainingSpeList);
//		
//		//计划招收人数map
//		int assignPlanCount = 0;
//		int recruitCount = 0;
//		int confirmCount = 0;
//		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
//		String regYear = InitConfig.getSysCfg("res_reg_year");
//		List<ResOrgSpeAssign> speAssignList = speAssignBiz.searchSpeAssign(orgFlow,regYear);
//		if(speAssignList != null && !speAssignList.isEmpty()){
//			Map<String, ResOrgSpeAssign> assignPlanMap = new HashMap<String, ResOrgSpeAssign>();
//			for(ResOrgSpeAssign rosa : speAssignList){
//				assignPlanMap.put(rosa.getSpeId(), rosa);
//				if(rosa.getAssignPlan() != null) {//计划招收总人数
//					assignPlanCount += rosa.getAssignPlan().intValue();
//				}
//			}
//			model.addAttribute("assignPlanMap", assignPlanMap);
//		}
//		model.addAttribute("assignPlanCount", assignPlanCount);
//		//预录取
//		ResDoctorRecruit recruit = new ResDoctorRecruit();
//		recruit.setOrgFlow(orgFlow);
//		recruit.setRecruitYear(regYear);
//		//recruit.setOrdinal(1);//第一志愿
//		recruit.setRecruitFlag(GlobalConstant.RECORD_STATUS_Y);
//		List<ResDoctorRecruit> doctorRecruitList = doctorRecruitBiz.searchDoctorRecruit(recruit);
//		if(doctorRecruitList != null && !doctorRecruitList.isEmpty()){
//			Map<String, Integer> recruitCountMap = new HashMap<String, Integer>();
//			Map<String, Integer> confirmCountMap = new HashMap<String, Integer>();
//			for(ResDoctorRecruit rdr : doctorRecruitList){
//				//预录取人数
//				if(StringUtil.isNotBlank("")){//调剂录取   rdr.getSwapSpeId()
////					if(recruitCountMap.get(rdr.getSwapSpeId()) != null){
////						recruitCount = recruitCountMap.get(rdr.getSwapSpeId());
////					}
////					recruitCount++;
////					recruitCountMap.put(rdr.getSwapSpeId(), recruitCount);
////					//确认录取人数
////					if(GlobalConstant.FLAG_Y.equals(rdr.getConfirmFlag())){
////						if(confirmCountMap.get(rdr.getSwapSpeId()) != null) {
////							confirmCount = confirmCountMap.get(rdr.getSwapSpeId());
////						}
////						confirmCount++;
////						confirmCountMap.put(rdr.getSwapSpeId(), confirmCount);
////					}
//				}else{//第一志愿录取
//					if(recruitCountMap.get(rdr.getSpeId()) != null) {
//						recruitCount = recruitCountMap.get(rdr.getSpeId());
//					}
//					recruitCount++;
//					recruitCountMap.put(rdr.getSpeId(), recruitCount);
//					//确认录取人数
//					if(GlobalConstant.FLAG_Y.equals(rdr.getConfirmFlag())){
//						if(confirmCountMap.get(rdr.getSpeId()) != null) {
//							confirmCount = confirmCountMap.get(rdr.getSpeId());
//						}
//						confirmCount++;
//						confirmCountMap.put(rdr.getSpeId(), confirmCount);
//					}
//				}
//			}
//			model.addAttribute("recruitCountMap", recruitCountMap);
//			model.addAttribute("confirmCountMap", confirmCountMap);
//		}
//		model.addAttribute("recruitCount", recruitCount);
//		model.addAttribute("confirmCount", confirmCount);
//		
//		return "hbres/hospital/recruitResultList";
//	}
	
	
//	/**
//	 * 确认录取--人员名单
//	 * @param speId
//	 * @param assignPlan
//	 * @param key
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value="/confirmUserList")
//	public String confirmUserList(String speId, String key, Model model){
//		model.addAttribute("speName", DictTypeEnum.DoctorTrainingSpe.getDictNameById(speId));
//		
//		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
//		String regYear = InitConfig.getSysCfg("res_reg_year");
//		//人员名单
//		Map<String,Object> paramMap = new HashMap<String,Object>();
//		paramMap.put("orgFlow", orgFlow);
//		paramMap.put("recruitYear", regYear);
//		paramMap.put("speId", speId);
//		paramMap.put("ordinal", 1);//第一志愿录取
//		paramMap.put("swapFlag", GlobalConstant.FLAG_Y);//调剂录取
//		paramMap.put("swapSpeId", speId);
//		paramMap.put("recruitFlag", GlobalConstant.FLAG_Y);
//		paramMap.put("key", key);
//		//paramMap.put("confirmFlag", GlobalConstant.FLAG_Y);
//		List<ResDoctorRecruitExt> doctorRecruitExts = doctorRecruitBiz.readDoctorRecruitExt(paramMap);
//		model.addAttribute("doctorRecruitExts", doctorRecruitExts);
//		return "hbres/hospital/confirmUserList";
//	}
//	
	@RequestMapping("/exportdoctor")
	public void exportDoctor(HttpServletResponse response) throws IOException, Exception{
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("orgFlow", orgFlow);
		paramMap.put("recruitYear", regYear);
		List<ResDoctorRecruitExt> doctorRecruitExts = this.doctorRecruitBiz.selectDoctorRecruitExt(paramMap);
		String[] titles = new String[]{
				"userName:姓名",
				"sexName:性别",
				"idNo:身份证号",
				"userPhone:手机号",
				"userEmail:邮箱",
				"graduatedName:毕业院校",
				"specialized:毕业专业",
				"graduationTime:毕业时间",
				"educationName:学历",
				"examResult:笔试成绩",
				"speName:填报专业",
				"swap:服从调剂"
		};
		List<HospitalDoctorExportInfo> dataList = new ArrayList<HospitalDoctorExportInfo>();
		HospitalDoctorExportInfo hdei = null;
		for(ResDoctorRecruitExt rdre:doctorRecruitExts){
			if(RecruitTypeEnum.Fill.getId().equals(rdre.getRecruitTypeId())){
				hdei = new HospitalDoctorExportInfo();
				hdei.setUserName(rdre.getSysUser().getUserName());
				hdei.setSexName(rdre.getSysUser().getSexName());
				hdei.setIdNo(rdre.getSysUser().getIdNo());
				hdei.setUserPhone(rdre.getSysUser().getUserPhone());
				hdei.setUserEmail(rdre.getSysUser().getUserEmail());
				hdei.setGraduatedName(rdre.getDoctor().getGraduatedName());
				hdei.setSpecialized(rdre.getDoctor().getSpecialized());
				hdei.setGraduationTime(rdre.getDoctor().getGraduationTime());
				hdei.setEducationName(rdre.getSysUser().getEducationName());
				hdei.setExamResult(rdre.getExamResult().toString());
				hdei.setSpeName(rdre.getSpeName());
				hdei.setSwap(rdre.getSwapFlag());
				dataList.add(hdei);
			}
		}
	    String fileName = "基地填报学员名单.xls";
	    fileName = URLEncoder.encode(fileName, "UTF-8");
	    ExcleUtile.exportSimpleExcle(titles, dataList, HospitalDoctorExportInfo.class, response.getOutputStream());
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.setContentType("application/octet-stream;charset=UTF-8");  
		
	}
	
	/**
	 * 开放给基地的特殊操作
	 * @param recruitFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/getSpecifiedOper")
	public String getSpecifiedOper(String recruitFlow , Model model){
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		List<ResOrgSpeAssign> spes = this.speAssignBiz.searchSpeAssign(orgFlow, regYear);
		model.addAttribute("spes", spes);
		return "hbres/hospital/specifiedoper";
	}
	
	/**
	 * 基地帮学员确认
	 * @param recruitFlow
	 * @return
	 */
	@RequestMapping("/hospitalOperDoctorConfirm")
	@ResponseBody
	public String hospitalOperDoctorConfirm(String recruitFlow){
		ResDoctorRecruitWithBLOBs recruit = new ResDoctorRecruitWithBLOBs();
		recruit.setRecruitFlow(recruitFlow);
		recruit.setConfirmFlag(GlobalConstant.FLAG_Y);
		this.doctorRecruitBiz.modResDoctorRecruitByRecruitFlow(recruit , false);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	/**
	 * 基地帮学员调专业
	 * @param recruitFlow
	 * @param speId
	 * @return
	 */
	@RequestMapping("/hospitalOperChangeSpe")
	@ResponseBody
	public String hospitalOperChangeSpe(String recruitFlow , String speId){
		SysUser user = (SysUser) getSessionAttribute(GlobalConstant.CURRENT_USER);
		String orgFlow = user.getOrgFlow();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResOrgSpeAssign currSpe = speAssignBiz.searchSpeAssign(orgFlow, regYear , speId);
		ResDoctorRecruitWithBLOBs recruit = new ResDoctorRecruitWithBLOBs();
		recruit.setRecruitFlow(recruitFlow);
		recruit.setSpeId(speId);
		recruit.setSpeName(currSpe.getSpeName());
		this.doctorRecruitBiz.modResDoctorRecruitByRecruitFlow(recruit , false);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	/**
	 * 基地帮学员回到不录取状态
	 * @param recruitFlow
	 * @return
	 */
	@RequestMapping("/hospitalOperNoRecruit")
	@ResponseBody
	public String hospitalOperNoRecruit(String recruitFlow){
		ResDoctorRecruitWithBLOBs recruit = (ResDoctorRecruitWithBLOBs)this.doctorRecruitBiz.readResDoctorRecruit(recruitFlow);
		recruit.setRecruitFlag(GlobalConstant.FLAG_N);
		recruit.setAdmitFlag(GlobalConstant.FLAG_N);
		recruit.setAdmitNotice("");
		recruit.setConfirmFlag("");
		this.doctorRecruitBiz.modResDoctorRecruitByRecruitFlow(recruit , true);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
}
