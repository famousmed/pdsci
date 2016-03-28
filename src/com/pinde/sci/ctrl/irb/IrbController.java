package com.pinde.sci.ctrl.irb;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.docx4j.openpackaging.io.SaveToZipFile;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.jspform.ItemGroupData;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.Docx4jUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduResumeBiz;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbCommitteeBiz;
import com.pinde.sci.biz.irb.IIrbInfoBiz;
import com.pinde.sci.biz.irb.IIrbInfoUserBiz;
import com.pinde.sci.biz.irb.IIrbMeetingBiz;
import com.pinde.sci.biz.irb.IIrbMeetingUserBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.IIrbResearcherBiz;
import com.pinde.sci.biz.irb.IIrbSecretaryBiz;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.biz.pub.IAcademicResumeBiz;
import com.pinde.sci.biz.pub.IPubPatientAeBiz;
import com.pinde.sci.biz.pub.IPubTrainBiz;
import com.pinde.sci.biz.pub.IPubTrainUserBiz;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.pub.IWorkResumeBiz;
import com.pinde.sci.biz.srm.IAchBookBiz;
import com.pinde.sci.biz.srm.IPatentBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.srm.ISatBiz;
import com.pinde.sci.biz.srm.IThesisBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.NumTrans;
import com.pinde.sci.enums.gcp.GcpProjSubTypeEnum;
import com.pinde.sci.enums.irb.IrbApplyFileTypeEnum;
import com.pinde.sci.enums.irb.IrbAuthTypeEnum;
import com.pinde.sci.enums.irb.IrbDecisionEnum;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.irb.IrbReviewTypeEnum;
import com.pinde.sci.enums.irb.IrbTrainCategoryEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.pub.ProjOrgTypeEnum;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.form.irb.IrbDecisionDetailForm;
import com.pinde.sci.form.irb.IrbMinutesForm;
import com.pinde.sci.form.irb.IrbPrintForm;
import com.pinde.sci.form.irb.IrbQuickOpinionForm;
import com.pinde.sci.form.irb.IrbVoteForm;
import com.pinde.sci.form.pub.AcademicResumeForm;
import com.pinde.sci.form.pub.EduResumeForm;
import com.pinde.sci.form.pub.WorkResumeForm;
import com.pinde.sci.model.irb.CodeValues;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbInfoUser;
import com.pinde.sci.model.mo.IrbMeeting;
import com.pinde.sci.model.mo.IrbMeetingUser;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubPatientAe;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubTrain;
import com.pinde.sci.model.mo.PubTrainUser;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SrmAchBook;
import com.pinde.sci.model.mo.SrmAchPatent;
import com.pinde.sci.model.mo.SrmAchSat;
import com.pinde.sci.model.mo.SrmAchThesis;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;


@Controller
@RequestMapping("/irb")
public class IrbController extends GeneralController{  
	
	private static Integer DEFAULT_START_PAGE_INDEX = 1;//默认起始分页索引
	private static Integer DEFAULT_PAGE_SIZE = 15;//默认分页数大小
	private static String President = "主席";
	private static String Committee = "委员";
	private static String Consultant = "独立顾问";
	private static String Secretary = "秘书";
	private static final String GCP_CURR_PROJ = "gcpCurrProj";
	
	@Autowired
	private IIrbResearcherBiz researcherBiz;
	@Autowired
	private IIrbApplyBiz applyBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IIrbInfoBiz irbInfoBiz;
	@Autowired
	private IIrbMeetingBiz meetingBiz;
	@Autowired
	private IIrbMeetingUserBiz meetingUserBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IPubTrainBiz pubTrainBiz;
	@Autowired
	private IPubTrainUserBiz pubTrainUserBiz;
	@Autowired
	private IIrbUserBiz irbUserBiz;
	@Autowired
	private IIrbInfoUserBiz infoUserBiz;
	@Autowired
	private IIrbRecBiz recBiz;
	@Autowired
	private IIrbSecretaryBiz secretaryBiz;
	@Autowired
	private IIrbCommitteeBiz irbCommitteeBiz;
	@Autowired
	private IPubUserResumeBiz userResumeBiz;
	@Autowired
	private IAcademicResumeBiz academicResumeBiz;
	@Autowired
	private IEduResumeBiz eduResumeBiz;
	@Autowired
	private IWorkResumeBiz workResumeBiz;
	@Autowired
    private IThesisBiz thesisBiz;
	@Autowired
	private IAchBookBiz bookBiz;
	@Autowired
	private IPatentBiz patentBiz;
	@Autowired
	private ISatBiz satBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IPubPatientAeBiz patientAeBiz;
	
	/**
	 * 批件有效期提醒
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/validity")
	public String validity(Integer currentPage,HttpServletRequest request, Model model){
		if(currentPage==null){
			currentPage = DEFAULT_START_PAGE_INDEX;
		}
		IrbApplyForm form = new IrbApplyForm();
		IrbApply apply = new IrbApply();
		apply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		apply.setApproveValidityDate(GlobalConstant.SPECIAL_PARAM);
		form.setIrbApply(apply);
		PageHelper.startPage(currentPage, getPageSize(request));
		List<IrbApply> irbApplyList = this.applyBiz.queryList(form);
		
		if(irbApplyList!=null&&!irbApplyList.isEmpty()){
			Map<String, String> vDateMap = new HashMap<String, String>();
			Map<String, PubProj> projMap = new HashMap<String, PubProj>();
			Date now = new Date();
			for (IrbApply ia : irbApplyList) {
				String irbFlow = ia.getIrbFlow();
				/*对应项目*/
				projMap.put(irbFlow, projBiz.readProject(ia.getProjFlow()));
				/*判断有效期 Y:距离有效期x天，N:超过有效期*/
				Date validityDate = DateUtil.parseDate(ia.getApproveValidityDate(), "yyyy-MM-dd");
				if(now.after(validityDate)){
					vDateMap.put(irbFlow, GlobalConstant.FLAG_N);
					continue;
				}else if(DateUtil.signDaysBetweenTowDate(validityDate,now)<=Long.parseLong(InitConfig.getSysCfg("irb_validity_remaind"))){
					vDateMap.put(irbFlow, GlobalConstant.FLAG_Y);
				}
			}
			model.addAttribute("vDateMap", vDateMap);
			model.addAttribute("projMap", projMap);
		}
		model.addAttribute("irbApplyList", irbApplyList);
		return "irb/search/validity";
	}
	
	/**
	 * 审查项目查询
	 * @param irb
	 * @param proj
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/projIrbList"},method={RequestMethod.GET,RequestMethod.POST})
	public String projIrbList(PubProj proj,String conditionFlag,String deptFlow,String irbTypeId,String currentPage, Model model){
		List<IrbApply> irbList = null;
		List<String> projFlowList = new ArrayList<String>();
		proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		if(StringUtil.isNotBlank(conditionFlag)){
			if(StringUtil.isNotBlank(deptFlow)){
				proj.setApplyDeptFlow(deptFlow);
			}
			List<PubProj> projList = researcherBiz.searchProjList(proj);
			if(null != projList && !projList.isEmpty()){
				for(PubProj p : projList){
					String projFlow =  p.getProjFlow();
					projFlowList.add(projFlow);
				}
			}
			if(!projFlowList.isEmpty()){
				irbList = applyBiz.queryIrbApplyListByProjFlows(projFlowList,irbTypeId);
				model.addAttribute("irbList", irbList);
			}
		}
		SysDept sysDept = new SysDept();
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		sysDept.setOrgFlow(orgFlow);
		List<SysDept> sysDeptList = deptBiz.searchDept(sysDept);
		model.addAttribute("sysDeptList",sysDeptList);
		return "irb/search/irblist";
	}
	/**
	 * 审查会议查询
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/meetingSearch"},method={RequestMethod.GET,RequestMethod.POST})
	public String meetingSearch(String meetingStartDate, String meetingEndDate, Model model){
		
		List<IrbMeeting> meetingList = meetingBiz.queryMeetingList(meetingStartDate, meetingEndDate); 
		Map<String, List<IrbApply>> meetingMap = new HashMap<String, List<IrbApply>>();
		Map<String, List<IrbMeetingUser>> meetingUserMap = new HashMap<String, List<IrbMeetingUser>>();
		
		//组织会议关联项目Map
		List<IrbApply> irbApplyList = applyBiz.queryIrbMeeting();
		for(IrbApply apply : irbApplyList){
			List<IrbApply> temp = meetingMap.get(apply.getMeetingFlow());
			if(temp == null){
				temp = new ArrayList<IrbApply>();
			}
			temp.add(apply);
			meetingMap.put(apply.getMeetingFlow(), temp);
		}

		//组织会议关联参会人员Map
		List<IrbMeetingUser> meetingUserList = meetingUserBiz.searchMeetingUserList(new IrbMeetingUser());
		Map<String, String> meetUserMap = new HashMap<String, String>();
		for(IrbMeetingUser meetingUser : meetingUserList){
			if (!meetUserMap.containsKey(meetingUser.getMeetingFlow()+"_"+meetingUser.getUserFlow())) {
				List<IrbMeetingUser> temp = meetingUserMap.get(meetingUser.getMeetingFlow());
				if(temp == null){
					temp = new ArrayList<IrbMeetingUser>();
				}
				temp.add(meetingUser);
				meetingUserMap.put(meetingUser.getMeetingFlow(), temp);
				
				meetUserMap.put(meetingUser.getMeetingFlow()+"_"+meetingUser.getUserFlow(), "");
			}
		}
			
		model.addAttribute("meetingList", meetingList);
		model.addAttribute("meetingMap", meetingMap);
		model.addAttribute("meetingUserMap", meetingUserMap);
		return "irb/search/meeting";
	}
	@RequestMapping(value={"/overview"},method={RequestMethod.GET})
	public String overview(String startDate,String endDate,String type,IrbApply irb, Model model,String irbApplyDate){
		if(StringUtil.isNotBlank(irbApplyDate)){
			startDate = irbApplyDate+"-01-01";
			endDate = irbApplyDate+"-12-31";
		}
		List<IrbApply> applyList = applyBiz.queryIrbApply(startDate,endDate,irb);
		if(applyList != null && !applyList.isEmpty()){
			//-----------伦理审查类别---------------
			if("irb".equals(type) || StringUtil.isBlank(type)){
				Map<String,Integer> irbCountMap = new HashMap<String, Integer>();
				List<Integer> fastCountList = new ArrayList<Integer>();
				List<Integer> meetingCountList = new ArrayList<Integer>();
				Map<String,List<Integer>> fastTypeCountMap = new HashMap<String, List<Integer>>();
				Map<String,List<Integer>> meetingTypeCountMap = new HashMap<String, List<Integer>>();
				IrbTypeEnum[] typeEnums = IrbTypeEnum.values();
				//遍历审查类型
				for(IrbTypeEnum e : typeEnums){
					int fastCount = 0;//会议报告统计
					int meetingCount = 0;//会议审查统计
					for(IrbApply a : applyList){
						if(StringUtil.isNotBlank(a.getIrbTypeId())){
							if(a.getIrbTypeId().equals(e.getId())){
								//会议审查方式
								String meetingArrange = a.getMeetingArrange();
								if(StringUtil.isNotBlank(meetingArrange)){
									if(meetingArrange.equals(IrbReviewTypeEnum.Fast.getId())){//会议报告
										fastCount += 1;
									}
									if(meetingArrange.equals(IrbReviewTypeEnum.Meeting.getId())){//会议审查
										meetingCount += 1;
				 					}
								}
							}
						}
					}
					fastCountList.add(fastCount);
					meetingCountList.add(meetingCount);
					fastTypeCountMap.put(e.getId(), fastCountList);
					meetingTypeCountMap.put(e.getId(), meetingCountList);
					//总计
					irbCountMap.put(e.getId(),fastCount+meetingCount);
				}
				model.addAttribute("fastTypeCountMap", fastTypeCountMap);
				model.addAttribute("meetingTypeCountMap", meetingTypeCountMap);
				model.addAttribute("irbCountMap", irbCountMap);
			}else if("proj".equals(type)){
				//-----------研究类别---------------
				Map<String,Integer> projCountMap = new HashMap<String, Integer>();
				List<Integer> gcpFastCountList = new ArrayList<Integer>();
				List<Integer> gcpMeetingCountList = new ArrayList<Integer>();
				Map<String,List<Integer>> gcpFastTypeCountMap = new HashMap<String, List<Integer>>();
				Map<String,List<Integer>> gcpMeetingTypeCountMap = new HashMap<String, List<Integer>>();
				
				GcpProjSubTypeEnum[]  gcpProjSubTypeEnums = GcpProjSubTypeEnum.values();
				for(GcpProjSubTypeEnum e : gcpProjSubTypeEnums){
					int fastCount = 0;//会议报告统计
					int meetingCount = 0;//会议审查统计
					for(IrbApply a : applyList){
						if(StringUtil.isNotBlank(a.getProjSubTypeId())){
							if(a.getProjSubTypeId().equals(e.getId())){
								//会议审查方式
								String meetingArrange = a.getMeetingArrange();
								if(StringUtil.isNotBlank(meetingArrange)){
									if(meetingArrange.equals(IrbReviewTypeEnum.Fast.getId())){//会议报告
										fastCount += 1;
									}
									if(meetingArrange.equals(IrbReviewTypeEnum.Meeting.getId())){//会议审查
										meetingCount += 1;
				 					}
								}
							}
						}
					}
					gcpFastCountList.add(fastCount);
					gcpMeetingCountList.add(meetingCount);
					gcpFastTypeCountMap.put(e.getId(), gcpFastCountList);
					gcpMeetingTypeCountMap.put(e.getId(), gcpMeetingCountList);
					//总计
					projCountMap.put(e.getId(),fastCount+meetingCount);
				}
				model.addAttribute("gcpFastTypeCountMap", gcpFastTypeCountMap);
				model.addAttribute("gcpMeetingTypeCountMap", gcpMeetingTypeCountMap);
				model.addAttribute("projCountMap", projCountMap);
			}else if("dec".equals(type)){
				
				//---------------决定类别-----------------
				Map<String,Integer> decCountMap = new HashMap<String, Integer>();
				List<Integer> decFastCountList = new ArrayList<Integer>();
				List<Integer> decMeetingCountList = new ArrayList<Integer>();
				Map<String,List<Integer>> decFastTypeCountMap = new HashMap<String, List<Integer>>();
				Map<String,List<Integer>> decMeetingTypeCountMap = new HashMap<String, List<Integer>>();
				
				IrbDecisionEnum[] irbDecisionEnums = IrbDecisionEnum.values();
				for(IrbDecisionEnum e : irbDecisionEnums){
					int fastCount = 0;//会议报告统计
					int meetingCount = 0;//会议审查统计
					for(IrbApply a : applyList){
						if(StringUtil.isNotBlank(a.getIrbDecisionId())){
							if(a.getIrbDecisionId().equals(e.getId())){
								//会议审查方式
								String meetingArrange = a.getMeetingArrange();
								if(StringUtil.isNotBlank(meetingArrange)){
									if(meetingArrange.equals(IrbReviewTypeEnum.Fast.getId())){//会议报告
										fastCount += 1;
									}
									if(meetingArrange.equals(IrbReviewTypeEnum.Meeting.getId())){//会议审查
										meetingCount += 1;
				 					}
								}
							}
						}
					}
					decFastCountList.add(fastCount);
					decMeetingCountList.add(meetingCount);
					decFastTypeCountMap.put(e.getId(), decFastCountList);
					decMeetingTypeCountMap.put(e.getId(), decMeetingCountList);
					decCountMap.put(e.getId(), fastCount+meetingCount);
				}
				model.addAttribute("decFastTypeCountMap", decFastTypeCountMap);
				model.addAttribute("decMeetingTypeCountMap", decMeetingTypeCountMap);
				model.addAttribute("decCountMap", decCountMap);
			}
		}
		if(irb!=null&&StringUtil.isNotBlank(irb.getIrbInfoFlow())){//年度工作报告
			return "irb/statistics/"+type+"_overview";
		}
		return "irb/statistics/overview";
	}
	@RequestMapping(value={"/committeeReview"},method={RequestMethod.GET,RequestMethod.POST})
	public String committeeReview(String year,String irbInfoFlow, Model model){
		Map<String, List<IrbUser>> irbUserMap = new HashMap<String, List<IrbUser>>();
		Map<String, List<IrbMeetingUser>> meetingUserMap = new HashMap<String, List<IrbMeetingUser>>();
		
		if(StringUtil.isEmpty(year)||StringUtil.isBlank(year)){
			year = DateUtil.getYear();
			model.addAttribute("currYear", year);
		}
		year += "-%";
		
		/*伦理委员会*/
		IrbInfo info = new IrbInfo();
		info.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<IrbInfo> irbInfoList = irbInfoBiz.queryInfo(info);
		if(StringUtil.isEmpty(irbInfoFlow)||StringUtil.isBlank(irbInfoFlow)){
			if(irbInfoList!=null&&!irbInfoList.isEmpty()){
				irbInfoFlow = irbInfoList.get(0).getRecordFlow();
			}
		}
		
		if(StringUtil.isNotBlank(irbInfoFlow)){
			IrbInfoUser user = new IrbInfoUser();
			user.setIrbInfoFlow(irbInfoFlow);
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<IrbInfoUser> infoUserList = infoUserBiz.queryUserList(user);
			
			List<IrbInfoUser> filterList = new ArrayList<IrbInfoUser>();//过滤一个用户多个角色
			for (IrbInfoUser irbUser : infoUserList) {
				boolean canAdd = false;
				/*过滤一个用户多个角色*/
				for (IrbInfoUser filterUser : filterList) {
					if(irbUser.getUserFlow().equals(filterUser.getUserFlow())&&irbUser.getIrbInfoFlow().equals(filterUser.getIrbInfoFlow())){
						filterUser.setRoleName(filterUser.getRoleName()+"，"+irbUser.getRoleName());
						canAdd = false;
						break;
					}else{
						canAdd = true;
					}
				}
				if(filterList.isEmpty()||canAdd){
					filterList.add(irbUser);
				}
			}
			
			//主审项目数Map
			List<IrbUser> irbUserList = irbUserBiz.queryIrbUserList(year);
			Map<String, List<IrbUser>> iuFilterMap = new HashMap<String, List<IrbUser>>();//过滤一次审查中既是方案又是知情同意主审委员的记录
			for(IrbUser irbU :irbUserList){
				List<IrbUser> uList = iuFilterMap.get(irbU.getUserFlow()+"_"+irbU.getIrbFlow());
				if(uList == null){
					uList = new ArrayList<IrbUser>();
				}
				uList.add(irbU);
				iuFilterMap.put(irbU.getUserFlow()+"_"+irbU.getIrbFlow(), uList);
				
				if (uList.size() == 1) {//过滤一次审查中既是方案又是知情同意主审委员的记录
					List<IrbUser> iuList = irbUserMap.get(irbU.getUserFlow());
					if(iuList == null){
						iuList = new ArrayList<IrbUser>();
					}
					iuList.add(irbU);
					irbUserMap.put(irbU.getUserFlow(), iuList);
				}
			}
			
			//参加议会数Map
			List<IrbMeetingUser> meetingUserList = meetingUserBiz.searchMeetingUserList(year);
			Map<String, List<IrbMeetingUser>> muFilterMap = new HashMap<String, List<IrbMeetingUser>>();//过滤一次会议中有多个角色的记录
			for(IrbMeetingUser mu : meetingUserList){
				List<IrbMeetingUser> uList = muFilterMap.get(mu.getUserFlow()+"_"+mu.getMeetingFlow());
				if(uList == null){
					uList = new ArrayList<IrbMeetingUser>();
				}
				uList.add(mu);
				muFilterMap.put(mu.getUserFlow()+"_"+mu.getMeetingFlow(), uList);
				
				if (uList.size() == 1) {//过滤一次会议中有多个角色的记录
					List<IrbMeetingUser> muList = meetingUserMap.get(mu.getUserFlow());
					if(muList == null){
						muList = new ArrayList<IrbMeetingUser>();
					}
					muList.add(mu);
					meetingUserMap.put(mu.getUserFlow(), muList);
				}
			}
			
			model.addAttribute("filterList", filterList);
			model.addAttribute("irbUserMap", irbUserMap);
			model.addAttribute("meetingUserMap", meetingUserMap);	
		}
		return "irb/statistics/committeeReview";
	}
	/**
	 * 年度工作报告
	 * @param year 年度
	 * @param irbInfoFlow 伦理委员会
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/yearReport")
	public String yearReport(String year,String irbInfoFlow, Model model){
		/*伦理委员会*/
		IrbInfo info = new IrbInfo();
		info.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<IrbInfo> irbInfoList = irbInfoBiz.queryInfo(info);
		if(StringUtil.isEmpty(year)||StringUtil.isBlank(year)){
			year = DateUtil.getYear();
			model.addAttribute("currYear", year);
		}
		if(StringUtil.isEmpty(irbInfoFlow)||StringUtil.isBlank(irbInfoFlow)){
			if(irbInfoList!=null&&!irbInfoList.isEmpty()){
				irbInfoFlow = irbInfoList.get(0).getRecordFlow();
			}
		}
		/*年度会议情况*/
		IrbMeeting meeting = new IrbMeeting();
		meeting.setMeetingDate(year);
		meeting.setIrbInfoFlow(irbInfoFlow);
		List<IrbMeeting> mList = this.meetingBiz.searchList(meeting);
		Map<String,Object> mMap = new HashMap<String,Object>();
		if(mList!=null){
			/*计算年度审查会议数*/
			long mCount = 0l;
			mCount = mList.size();
			mMap.put("mCount", mCount);
			/*计算平均会议时间*/
			long sumMeetTime = 0l;//总会议时间
			List<String> meetingFlows = new ArrayList<String>();
			for (IrbMeeting m : mList) {
				Date startDate = DateUtil.parseDate(m.getMeetingStartTime(), "HH:mm");
				Date endDate = DateUtil.parseDate(m.getMeetingEndTime(), "HH:mm");
				long minutes = DateUtil.signMinutesBetweenTowDate(startDate, endDate);
				sumMeetTime += minutes;
				meetingFlows.add(m.getMeetingFlow());
			}
			String avgMeetTime = DateUtil.formatMinutes(Math.round(Double.valueOf(sumMeetTime)/Double.valueOf(mCount)));
			mMap.put("avgMeetTime", avgMeetTime);
			/*计算平均每次会议审查/报告项目数*/
			IrbApply irb = new IrbApply();
			irb.setIrbReviewDate(year);
			irb.setIrbInfoFlow(irbInfoFlow);
			irb.setMeetingArrange(IrbReviewTypeEnum.Meeting.getId());
			long sumMeeting = this.applyBiz.queryIrbApplyCount(irb) ;//总会议审查数
			irb.setMeetingArrange(IrbReviewTypeEnum.Fast.getId());
			long sumFast = this.applyBiz.queryIrbApplyCount(irb) ;//总会议报告数
			long avgMeeting = Math.round(Double.valueOf(sumMeeting)/Double.valueOf(mCount));
			long avgFast = Math.round(Double.valueOf(sumFast)/Double.valueOf(mCount));
			mMap.put("avgMeeting", avgMeeting);
			mMap.put("avgFast", avgFast);
			/*计算平均到会委员数(注：未过滤角色)*/
			long sumMeetingMember = 0l;
			if(meetingFlows.size()>0){
				sumMeetingMember = this.meetingUserBiz.queryMeetingUserCount(meetingFlows);
			}
			long avgMeetingMember = Math.round(Double.valueOf(sumMeetingMember)/Double.valueOf(mCount));
			mMap.put("avgMeetingMember", avgMeetingMember);
			model.addAttribute("mMap", mMap);
		}
		/*年度培训情况*/
		PubTrain train = new PubTrain();
		train.setTrainDate(year);
		train.setTrainCategoryId(IrbTrainCategoryEnum.Inner.getId());
		List<PubTrain> innerList = this.pubTrainBiz.queryTrainList(train, null, null);
		train.setTrainCategoryId(IrbTrainCategoryEnum.Out.getId());
		List<PubTrain> outList = this.pubTrainBiz.queryTrainList(train, null, null);
		Map<String,Long> userCountMap = new HashMap<String,Long>();
		if(innerList!=null&&!innerList.isEmpty()){
			for (PubTrain pubTrain : innerList) {
				PubTrainUser trainUser = new PubTrainUser();
				String trainFlow = pubTrain.getTrainFlow();
				trainUser.setTrainFlow(trainFlow);
				userCountMap.put(trainFlow, this.pubTrainUserBiz.queryTrainUserCount(trainUser));
			}
		}
		if(outList!=null&&!outList.isEmpty()){
			for (PubTrain pubTrain : outList) {
				PubTrainUser trainUser = new PubTrainUser();
				String trainFlow = pubTrain.getTrainFlow();
				trainUser.setTrainFlow(trainFlow);
				userCountMap.put(trainFlow, this.pubTrainUserBiz.queryTrainUserCount(trainUser));
			}
		}
		model.addAttribute("irbInfoList", irbInfoList);
		model.addAttribute("innerList", innerList);
		model.addAttribute("outList", outList);
		model.addAttribute("userCountMap", userCountMap);
		return "irb/statistics/yearReport";
	}
	/**
	 * 伦理打印（表单）
	 * @param irbFlow
	 * @param recTypeId
	 * @param watermarkFlag Y:加水印
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/print")
	public void print(IrbPrintForm form, HttpServletRequest request,HttpServletResponse response)throws Exception{
		String templ = "";
		String fileName = "";
		String irbFlow = form.getIrbFlow();
		IrbApply curIrbApply = this.applyBiz.queryByFlow(irbFlow);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		String recTypeId = form.getRecTypeId();
		String informException = "";
		String productType = "";
		String currVer = "";
		
		if(recTypeId!=null){
			IrbInfo irbInfo = null;
			PubProj proj = null;
			String category = "";
			if (curIrbApply!=null) {
				irbInfo = this.irbInfoBiz.queryInfo(curIrbApply.getIrbInfoFlow());
				String projFlow = curIrbApply.getProjFlow();
				proj = this.projBiz.readProject(projFlow);
			}
			if (proj == null) {
				proj = (PubProj)getSessionAttribute(GCP_CURR_PROJ);
			}
			if (proj != null) {
				category = proj.getProjCategoryId();
			}
			IrbRecTypeEnum  recTypeEnum = null;
			for (IrbRecTypeEnum recEnum : IrbRecTypeEnum.values()) {
				if(recEnum.getId().equals(recTypeId)){
					recTypeEnum = recEnum;
					break;
				}
			}
			fileName = IrbRecTypeEnum.getNameById(recTypeId);
			if(recTypeEnum!=null&&GlobalConstant.FLAG_Y.equals(recTypeEnum.getIsForm())){//表单
				/*从表单配置文件获取singleForm*/
				productType = InitConfig.getSysCfg("irb_form_category");
				if(StringUtil.isEmpty(productType)||StringUtil.isBlank(productType)){
					productType = GlobalConstant.IRB_FORM_PRODUCT;
				}
				IrbRec irbRec = new IrbRec();
				irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				irbRec.setIrbFlow(irbFlow);
				irbRec.setRecTypeId(recTypeId);
				if(recTypeId.endsWith("Worksheet")){//非初审工作表
					irbRec.setOperUserFlow(form.getUserFlow());
				}
				IrbRec rec = recBiz.readIrbRec(irbRec);
				String content = "";
				if (rec != null) {
					currVer = rec.getRecVersion();
					content = rec.getRecContent();
				}
				//GCP系统严重不良事件表单的打印
				String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
				if (GlobalConstant.GCP_WS_ID.equals(wsId) && IrbRecTypeEnum.SaeApplication.getId().equals(recTypeId)) {
					String recordFlow = form.getRecordFlow();
					PubPatientAe patientAe = patientAeBiz.readPatientAe(recordFlow);
					if(patientAe != null){
						content = patientAe.getAeInfo();
					}
				}
				
				if (StringUtil.isBlank(currVer)) {
					currVer = InitConfig.formRequestUtil.getVersionMap().get(recTypeId);
				}
				if(StringUtil.isBlank(currVer)){
					currVer = GlobalConstant.IRB_FORM_PRODUCT_VER;
				}
				Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(recTypeId);
				IrbSingleForm singleForm = 	null;
				if(IrbRecTypeEnum.IndepConsultantWorksheet.getId().equals(recTypeId)){//独立顾问咨询表
					singleForm = singleFormMap.get(productType+"_all_"+currVer);
				}else{
					singleForm = singleFormMap.get(productType+"_"+category+"_"+currVer);
					if(singleForm == null){
						singleForm = 	singleFormMap.get(productType+"_"+ProjCategroyEnum.Yw.getId()+"_"+currVer);
					}  
				}
				if(singleForm == null){
					throw new RuntimeException("未发现表单 项目类别:"+proj.getProjCategoryName()+",伦理审查类别:"+IrbTypeEnum.getNameById(curIrbApply.getIrbTypeId())+",模版类型:"+productType+",版本号:"+currVer);
				}
				List<Element> itemElements = singleForm.getItemList();
				
				Map<String,Object> savedValueMap = new HashMap<String,Object>();
				if(StringUtil.isNotBlank(content)){
					Document document = DocumentHelper.parseText(content);
					Element rootElement = document.getRootElement();
					List<Element> elements = rootElement.elements();
					/*存储的表单的值*/
					for(Element element : elements){
						String itemName = element.getName();
						List<Node> valueNodes = element.selectNodes("value");
						if(valueNodes!=null&&!valueNodes.isEmpty()){
							List<String> values = new ArrayList<String>();
							for (Node node : valueNodes) {
								values.add(node.getText());
							}
							savedValueMap.put(itemName, values);
						}else{
							savedValueMap.put(itemName, element.getTextTrim());
						}
					}
				}
				informException = savedValueMap.get("informException")==null?"":String.valueOf(savedValueMap.get("informException"));//知情同意的例外选项值
				for (Element itemEl : itemElements) {
					String itemName = itemEl.attributeValue("name");
					Map<String,CodeValues> codeMap = singleForm.getItemCodeMap().get(itemName);//获取codeMap
					if("decision".equals(itemName)){//审查决定
						codeMap = new LinkedHashMap<String,CodeValues>();
						String irbTypeid = curIrbApply.getIrbTypeId();
						for (IrbDecisionEnum dEnum : IrbDecisionEnum.values()) {
							if(dEnum.getIrbTypeId().contains(irbTypeid)){
								CodeValues values = new CodeValues();
								values.setText(dEnum.getName());
								codeMap.put(dEnum.getId(), values);
							}
						}
					}
					if(codeMap!=null&&!codeMap.isEmpty()){//单选或多选
					    String isMultiple = itemEl.attributeValue("multiple");
						StringBuilder values = new StringBuilder();
						int i = 0;
						/*组拼结果字符串*/
						for (Map.Entry<String, CodeValues> entry : codeMap.entrySet()) {
							i++;
							boolean isChecked = false;
							if(GlobalConstant.FLAG_Y.equals(isMultiple)){//多选
								List<String> savedValues = null;
								if (StringUtil.isNotBlank(String.valueOf(savedValueMap.get(itemName)))) {
									savedValues = (List<String>) savedValueMap.get(itemName);
								}
								if(savedValues!=null&&!savedValues.isEmpty()){
									for (String value : savedValues) {
										if(StringUtil.isEquals(entry.getKey(), value)){
											isChecked = true;
											break;
										}
									}
								}
							}else if(StringUtil.isEquals(entry.getKey(), String.valueOf(savedValueMap.get(itemName)))){//单选
								isChecked = true;
							}
							CodeValues codeValues = entry.getValue();
							String remark = "";
							String text = "";
							String newLine = GlobalConstant.FLAG_N;
							if(codeValues!=null){
								remark = codeValues.getRemark();
								text = codeValues.getText();
								newLine = codeValues.getNewLine();
							}
							if(StringUtil.isNotBlank(remark)){//备注
								values.append(remark+"\n");
							}
							if(isChecked){//选中
								values.append("■"+text+"，");
							}else{
								values.append("□"+text+"，");
							}
							if(i == codeMap.size()) {
								values.deleteCharAt(values.length()-1);	//去掉选项最后的逗号
							}
							if(GlobalConstant.FLAG_Y.equals(newLine)){//换行
								values.append("\n");
							}
						}
						dataMap.put(itemName, values.toString());
					}else{
						dataMap.put(itemName, savedValueMap.get(itemName)==null?"":String.valueOf(savedValueMap.get(itemName)));
					}
				}
				
				//初审申请表--研究类型
				if (recTypeId.indexOf(IrbTypeEnum.Init.getId()) > -1 && recTypeId.endsWith("Application")) {
					String itemName = "researchType";
					String researchType = String.valueOf(savedValueMap.get(itemName));
					Map<String,CodeValues> codeMap = singleForm.getItemCodeMap().get(itemName);//获取codeMap
					for (Map.Entry<String, CodeValues> entry : codeMap.entrySet()) {
						String text = "";
						CodeValues codeValues = entry.getValue();
						if(codeValues!=null){
							text = codeValues.getText();
						}
						if (entry.getKey().equals(researchType)) {
							text = "■" + text;
						} else {
							text = "□" + text;
						}
						dataMap.put(itemName+entry.getKey(), text);
					}
				}
				
				/*其他附加的值*/
				if(recTypeId.indexOf("Worksheet") > -1){//工作表
					dataMap.put("projName", StringUtil.defaultString(proj.getProjName()));
					dataMap.put("projDeclarer", StringUtil.defaultString(proj.getProjDeclarer()));
					dataMap.put("irbNo", StringUtil.defaultString(curIrbApply.getIrbNo()));
					if(irbInfo!=null){
						dataMap.put("irbName", StringUtil.defaultString(irbInfo.getIrbName()));
					}
					String userFlow = form.getUserFlow();
					String userName = "";
					if (StringUtil.isNotBlank(userFlow)) {
						SysUser user = userBiz.readSysUser(userFlow);
						if (user != null) {
							userName = user.getUserName();
						}
					}
					dataMap.put("userName",userName);
					
					//获取方案/知情同意版本号和版本日期
					String proVersion = "";
					String proVersionDate = "";
					String icfVersion = "";
					String icfVersionDate = "";
					IrbRec temp = new IrbRec();
					temp.setIrbFlow(irbFlow);
					List<IrbApplyFileForm> uploadFiles = this.recBiz.queryUploadFile(temp);
					if(uploadFiles!=null&&!uploadFiles.isEmpty()){
						for (IrbApplyFileForm uFile : uploadFiles) {
							if (StringUtil.isNotBlank(uFile.getFileType())) {
								if (IrbApplyFileTypeEnum.Pro.getId().equals(uFile.getFileType())) {
									proVersion = StringUtil.defaultString(uFile.getVersion());
									proVersionDate = StringUtil.defaultString(uFile.getVersionDate());
								} else if (IrbApplyFileTypeEnum.Icf.getId().equals(uFile.getFileType())) {
									icfVersion = StringUtil.defaultString(uFile.getVersion());
									icfVersionDate = StringUtil.defaultString(uFile.getVersionDate());
								}
							}
						}
					}
					dataMap.put("proVersion",proVersion);
					dataMap.put("proVersionDate",proVersionDate);
					dataMap.put("icfVersion",icfVersion);
					dataMap.put("icfVersionDate",icfVersionDate);
				}
				if(recTypeId.endsWith("Application")){//申请表
					dataMap.put("projName", StringUtil.defaultString(proj.getProjName()));
					dataMap.put("projDeclarer", StringUtil.defaultString(proj.getProjDeclarer()));
					dataMap.put("projSubTypeName", StringUtil.defaultString(proj.getProjSubTypeName()));
					dataMap.put("applyDeptName", StringUtil.defaultString(proj.getApplyDeptName()));
					dataMap.put("applyUserName", StringUtil.defaultString(proj.getApplyUserName()));
				}
			}
		}
		if (recTypeId.indexOf(IrbTypeEnum.Init.getId()) > -1) {
			if (recTypeId.endsWith("Application")) {
				if (StringUtil.isNotBlank(informException)) {
					recTypeId = IrbRecTypeEnum.InitApplication.getId() + informException;
				}
			} else if (recTypeId.indexOf("Worksheet") > -1) {
				IrbRec applyRec = recBiz.readIrbRec(curIrbApply.getIrbFlow(),IrbRecTypeEnum.InitApplication.getId());
				if(applyRec != null){
					String content = applyRec.getRecContent();
					try {
						Document document = DocumentHelper.parseText(content);
						Element rootElement = document.getRootElement();
						
						Node researchTypeNode = rootElement.selectSingleNode("researchType");
						if (researchTypeNode != null && StringUtil.isNotBlank(researchTypeNode.getText())) {
							String researchType = researchTypeNode.getText();	//研究类型
							if ("1".equals(researchType)) {
								recTypeId += "1";
							} else if ("2".equals(researchType)) {
								String obserStudyType = "";	//观察性研究类型
								Node obserStudyTypeNode = rootElement.selectSingleNode("obserStudyType");
								if (obserStudyTypeNode != null) {
									List<Node> valueNodes = obserStudyTypeNode.selectNodes("value");
									if(valueNodes != null && valueNodes.size()>0){
										String value = "";
										for(Node node : valueNodes){
											if(StringUtil.isNotBlank(value)){
												value+=",";
											}
											value += node.getText();
										}
										obserStudyType = value;
									}
								}
								if (StringUtil.isNotBlank(obserStudyType)) {
									if (obserStudyType.indexOf("2")>-1) {	//回顾性分析与前瞻性研究：如果同时选，对应文件一律按前瞻性研究
										obserStudyType = "2";
									}
									if ("1".equals(obserStudyType)) {
										recTypeId += "2";
									} else if ("2".equals(obserStudyType)) {
										recTypeId += "3";
									}
								}
							}
						}
						
						if (recTypeId.indexOf(IrbRecTypeEnum.InitWorksheetICF.getId()) > -1) {
							String informExcept = "";	//知情同意的例外
							Node informExceptionNode = rootElement.selectSingleNode("informException");
							if (informExceptionNode != null && StringUtil.isNotBlank(informExceptionNode.getText())) {
								informExcept = informExceptionNode.getText();
								recTypeId = IrbRecTypeEnum.InitWorksheetICF.getId() + informExcept;
							}
						}
					} catch (DocumentException e) {
						e.printStackTrace();
					}
				}
			}
		}
		templ = recTypeId +"Template.docx";//模板
		
		String path = "/jsp/irb/form/"+productType+"/print/"+currVer+"/"+templ;
		ServletContext context =  request.getServletContext();
		String watermark = GeneralMethod.getWatermark(form.getWatermarkFlag());
		WordprocessingMLPackage temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
		if(temeplete!=null){
			response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
			String name = fileName+".docx";
			response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
			ServletOutputStream out = response.getOutputStream ();
			(new SaveToZipFile (temeplete)).save (out);
			out.flush ();
		}
	}
	/**
	 * 伦理打印(非表单)
	 * @param irbFlow
	 * @param recTypeId
	 * @param watermarkFlag Y:加水印
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/printOther")
	public void printOther(IrbPrintForm form, HttpServletRequest request,HttpServletResponse response)throws Exception{
		String templ = "";
		String fileName = "";
		String irbFlow = form.getIrbFlow();
		IrbApply curIrbApply = this.applyBiz.queryByFlow(irbFlow);
		IrbInfo irbInfo = null;
		if (curIrbApply != null) {
			irbInfo = this.irbInfoBiz.queryInfo(curIrbApply.getIrbInfoFlow());
		}
		WordprocessingMLPackage temeplete = new WordprocessingMLPackage();
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		String recTypeId = form.getRecTypeId();
		if(recTypeId!=null&&curIrbApply!=null){
			String projFlow = curIrbApply.getProjFlow();
			PubProj proj = this.projBiz.readProject(projFlow);
			if (!"receiptNotice".equals(recTypeId) && !"voteForm".equals(recTypeId) && !"minutes".equals(recTypeId)) {
				fileName = IrbRecTypeEnum.getNameById(recTypeId);
			}
			String projName = "";
			String projDeclarer = "";
			String projSubTypeName = "";
			String projApplyUserName = "";
			String applyOrgName = "";
			if(proj!=null){
				projName = StringUtil.defaultIfEmpty(proj.getProjName(), "");
				projDeclarer = StringUtil.defaultIfEmpty(proj.getProjDeclarer(), "");
				projSubTypeName = StringUtil.defaultIfEmpty(proj.getProjSubTypeName(), "");
				projApplyUserName = StringUtil.defaultIfEmpty(proj.getApplyUserName(), "");
				applyOrgName = StringUtil.defaultIfEmpty(proj.getApplyOrgName(), "");
			}
			/*******************快审主审综合意见************************/
			if(IrbRecTypeEnum.QuickOpinion.getId().equals(recTypeId)){
				if(irbInfo!=null){
					dataMap.put("irbName", irbInfo.getIrbName());
				}
				dataMap.put("projName", projName+"  "+projSubTypeName+"  "+projDeclarer);
				dataMap.put("irbTypeName", curIrbApply.getIrbTypeName());
				dataMap.put("irbNo", curIrbApply.getIrbNo());
				IrbUser user = new IrbUser();
				user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				user.setIrbFlow(irbFlow);
				List<IrbUser> irbUserList = this.irbUserBiz.queryList(user);
				List<ItemGroupData> data = new ArrayList<ItemGroupData>();
				/*组拼各委员审查数据*/
				for (IrbUser irbUser : irbUserList) {
					String authId = irbUser.getAuthId();
					if(!IrbAuthTypeEnum.Consultant.getId().equals(authId)){
						ItemGroupData tmp = new ItemGroupData();
						Map<String, Object> objMap = new HashMap<String , Object>();
						String userName = irbUser.getUserName();
						if(IrbAuthTypeEnum.CommitteePRO.getId().equals(authId)){
							userName += "：方案";
						}
						if(IrbAuthTypeEnum.CommitteeICF.getId().equals(authId)){
							userName += "：知情同意书";
						}
						objMap.put("irbUser_userName", userName);
						objMap.put("irbUser_authDecision", irbUser.getAuthDecision());
						objMap.put("irbUser_authNote", irbUser.getAuthNote());
						tmp.setObjMap(objMap);
						data.add(tmp);
					}
				}
				IrbQuickOpinionForm qForm = this.secretaryBiz.readQuickOpinion(irbFlow);
				dataMap.put("irbUser", data);
				dataMap.put("decision", StringUtil.defaultIfEmpty(curIrbApply.getIrbDecisionName(), ""));
				if(qForm!=null){
					dataMap.put("reviewOpinion", qForm.getReviewOpinion());
					dataMap.put("preCommitteeName", qForm.getOperUserName());
					dataMap.put("signDate", qForm.getOperTime());
				}
			}
			/*******************会议审查决定表************************/
			else if(IrbRecTypeEnum.MeetingDecision.getId().equals(recTypeId)){
				if(irbInfo!=null){
					dataMap.put("irbName", irbInfo.getIrbName());
				}
				dataMap.put("projName", projName+"  "+projSubTypeName+"  "+projDeclarer);
				dataMap.put("irbTypeName", curIrbApply.getIrbTypeName());
				String meetingFlow = curIrbApply.getMeetingFlow();
				List<IrbMeetingUser> filterUserList = this.meetingBiz.filterVoteUserList(meetingFlow);//投票人员
				List<String> userFlowList = new ArrayList<String>();
				if (filterUserList != null && filterUserList.size() > 0) {
					for (IrbMeetingUser user:filterUserList) {
						userFlowList.add(user.getUserFlow());
					}
				}
				List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irbFlow, null);
				Map<String, Integer> voteCountMap = new HashMap<String, Integer>();	//统计各决定投票数
				Map<String, String> voteMap = new HashMap<String, String>();
				int cCount = 0;//冲突数
				if(formList != null && formList.size() > 0){
					for (IrbVoteForm voteform : formList) {
						String userFlow = voteform.getUserFlow();
						String decId = StringUtil.defaultIfEmpty(voteform.getDecisionId(), "");
						voteMap.put("vote_"+userFlow,decId);
						if (userFlowList.contains(userFlow)) {	//过滤已经删除的参会人员
							if (StringUtil.isNotBlank(decId)) {
								int dCount = 1;
								if (voteCountMap.get(decId) != null) {
									dCount = voteCountMap.get(decId) +1;
								}
								voteCountMap.put(decId, dCount);
							}
							if(GlobalConstant.FLAG_Y.equals(voteform.getConflict())){
								voteMap.put("conflict_"+userFlow,GlobalConstant.FLAG_Y);
								cCount++;
							}
						}
					}
				}
				voteCountMap.put(GlobalConstant.IRB_DECISION_CONFLICT, cCount);
				String conflictString = "因利益冲突退出";
				/*投票数打印数据*/
				String irbTypeId = curIrbApply.getIrbTypeId();
				List<ItemGroupData> voteData = new ArrayList<ItemGroupData>();
				for (IrbDecisionEnum irbDecisionEnum : IrbDecisionEnum.values()) {
					if(StringUtil.countMatches(irbDecisionEnum.getIrbTypeId(),irbTypeId)==1){
						Map<String, Object> objMap = new HashMap<String , Object>();
						objMap.put("vote_name", irbDecisionEnum.getName());
						String decId = irbDecisionEnum.getId();
						objMap.put("vote_count", voteCountMap.get(decId)!=null?String.valueOf(voteCountMap.get(decId)):"0");
						String checked = "";
						if(StringUtil.isEquals(curIrbApply.getIrbDecisionId(), decId)){
							checked = "√";
						}
						objMap.put("vote_checked", checked);
						ItemGroupData tmp = new ItemGroupData();
						tmp.setObjMap(objMap);
						voteData.add(tmp);
					}
				}
				/*利益冲突打印数据*/
				Map<String, Object> objMap = new HashMap<String , Object>();
				objMap.put("vote_name", conflictString);
				Integer conflictCount = voteCountMap.get(GlobalConstant.IRB_DECISION_CONFLICT);
				objMap.put("vote_count", conflictCount!=null?String.valueOf(conflictCount):"0");
				objMap.put("vote_checked", "");
				ItemGroupData tmp = new ItemGroupData();
				tmp.setObjMap(objMap);
				voteData.add(tmp);
				dataMap.put("vote", voteData);
				/*投票详情打印数据*/
				List<ItemGroupData> voteDetailData = new ArrayList<ItemGroupData>();
				for (IrbMeetingUser user:filterUserList) {
					ItemGroupData userTmp = new ItemGroupData();
					Map<String, Object> userObjMap = new HashMap<String , Object>();
					userObjMap.put("voteDetail_userName", user.getUserName());
					String decision = "";
					String userFlow = user.getUserFlow();
					if(StringUtil.isNotBlank(voteMap.get("vote_"+userFlow))){
						decision = IrbDecisionEnum.getNameById(voteMap.get("vote_"+userFlow));
					}else if(GlobalConstant.FLAG_Y.equals(voteMap.get("conflict_"+userFlow))){
						decision = conflictString;
					}
					userObjMap.put("voteDetail_decision", decision );
					userTmp.setObjMap(userObjMap);
					voteDetailData.add(userTmp);
				}
				dataMap.put("voteDetail", voteDetailData);
			}
			/*******************批件或意见************************/
			else if(IrbRecTypeEnum.ApproveFile.getId().equals(recTypeId)||IrbRecTypeEnum.OpinionFile.getId().equals(recTypeId)){
				String fileType = this.secretaryBiz.checkFileType(curIrbApply);//判断是批件还是意件
				String meetingFlow = curIrbApply.getMeetingFlow();
				IrbMeeting meeting = this.meetingBiz.readIrbMeeting(meetingFlow);//审查会议
				List<IrbApplyFileForm> fileList = null;
				IrbDecisionDetailForm dForm = this.secretaryBiz.readDecDetail(irbFlow, fileType);//已保存的记录
				if (dForm != null) {
					fileList = dForm.getApplyFileForms();
				}
				if (dForm == null || fileList == null) {
					fileList =  this.recBiz.queryConfirmFile(irbFlow);//默认显示本次审查已确认的送审文件
				}
			    dataMap.put("irbNo", StringUtil.defaultIfEmpty(curIrbApply.getIrbNo(), ""));
			    dataMap.put("projName", projName);
			    dataMap.put("projDeclarer", projDeclarer);
			    dataMap.put("applyOrgName", applyOrgName);
			    dataMap.put("projApplyUserName", projApplyUserName);
			    dataMap.put("irbTypeName", StringUtil.defaultString(curIrbApply.getIrbTypeName()));
			    dataMap.put("reviewWayName", StringUtil.defaultString(curIrbApply.getReviewWayName()));
			    dataMap.put("irbReviewDate", StringUtil.defaultString(curIrbApply.getIrbReviewDate()));
			    String meetingAddress = "";
			    if (IrbReviewTypeEnum.Fast.getId().equals(curIrbApply.getReviewWayId())) {
			    	meetingAddress = InitConfig.getSysCfg("irb_review_address");
			    } else {
			    	if (meeting != null) {
			    		meetingAddress = meeting.getMeetingAddress();
			    	}
			    }
			    dataMap.put("meetingAddress", StringUtil.defaultString(meetingAddress));
			    
			    StringBuilder mUsers = new StringBuilder();
			    if (IrbReviewTypeEnum.Fast.getId().equals(curIrbApply.getReviewWayId()) && IrbReviewTypeEnum.Fast.getId().equals(curIrbApply.getMeetingArrange())) {	//快审并且没有提交会议审查
					List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);//主审委员
					List<String> userFlowList = new ArrayList<String>();
					List<IrbUser> filterUserList = new ArrayList<IrbUser>();	//过滤主审方案和知情同意为同一个人的情况
					if (committeeList != null && committeeList.size() > 0) {
						for (IrbUser user:committeeList) {
							if (!userFlowList.contains(user.getUserFlow())) {
								filterUserList.add(user);
								userFlowList.add(user.getUserFlow());
							}
						}
					}
				    if (filterUserList != null && filterUserList.size() >0 ) {
				    	 for (IrbUser user : filterUserList) {
						    mUsers.append(user.getUserName()).append("、");
						 }
				    }
				} else {	//会审或者快审提交会审
					List<IrbMeetingUser> filterUserList = meetingBiz.filterVoteUserList(meetingFlow);//审查委员（投票人员）
				    if (filterUserList != null && filterUserList.size() >0 ) {
				    	 for (IrbMeetingUser mUser : filterUserList) {
						    mUsers.append(mUser.getUserName()).append("、");
						 }
				    }
				}
			    if (mUsers.length() > 0) {
			    	mUsers.deleteCharAt(mUsers.length()-1);
			    }
			    dataMap.put("mUsers", mUsers.toString());
			    
			    StringBuilder files = new StringBuilder();
				int fileNum = 0;
				if (fileList != null && fileList.size() > 0) {
					for (int i=0;i<fileList.size();i++) {
				    	IrbApplyFileForm file = fileList.get(i);
				    	files.append(file.getFileName());
				    	if(StringUtil.isNotBlank(file.getVersion())){
				    		files.append(" 版本号：").append(file.getVersion());
				    	}
				    	if(StringUtil.isNotBlank(file.getVersionDate())){
				    		files.append(" 版本日期：").append(file.getVersionDate());
				    	}
				    	files.append("\n");
				    	fileNum++;
					}
				}
				if (fileNum > 1) {
					files.deleteCharAt(files.length()-1);	//去掉选项最后的\n
				}
			    dataMap.put("files", files.toString());
			    dataMap.put("irbDecisionName", StringUtil.defaultString(curIrbApply.getIrbDecisionName()));
			    dataMap.put("irbDecisionDate", StringUtil.defaultString(curIrbApply.getIrbDecisionDate()));
			    String approveValidity = StringUtil.defaultString(curIrbApply.getApproveValidity());
			    dataMap.put("approveValidity", "".equals(approveValidity)?"":approveValidity+"个月");
			    String trackDate = StringUtil.defaultString(curIrbApply.getTrackDate());
				dataMap.put("trackDate", trackDate);
			    String opinion = "";
			    String chairman = "";
			    String formIrbInfo = "";
			    if(dForm!=null){
			    	opinion = StringUtil.defaultString(dForm.getOpinion());
			    	if (StringUtil.isNotBlank(opinion) && opinion.indexOf("\n")<0) {
			    		opinion += "\n";
			    	}
			    	formIrbInfo = StringUtil.defaultString(dForm.getIrbInfo());
			    	chairman = StringUtil.defaultString(dForm.getChairman());
			    }
			    dataMap.put("opinion", opinion);
			    dataMap.put("formIrbInfo", formIrbInfo);
			    dataMap.put("chairman",chairman );
			    String contact = "";
			    String contactPhone = "";
			    String contactMobile = "";
			    if(irbInfo!=null){
			    	contact = StringUtil.defaultString(irbInfo.getContactUser());
			    	contactPhone = StringUtil.defaultString(irbInfo.getContactPhone());
			    	contactMobile = StringUtil.defaultString(irbInfo.getContactMobile());
			    } 
			    dataMap.put("contact",contact+"  "+contactPhone +"  "+contactMobile );
			    
			    if ((IrbRecTypeEnum.ApproveFile.getId().equals(recTypeId) || IrbRecTypeEnum.OpinionFile.getId().equals(recTypeId)) && StringUtil.isBlank(trackDate)) {	//word不显示跟踪审查日期行
			    	recTypeId += "A";
			    }
			}
			/*******************文件存档************************/
			else if(IrbRecTypeEnum.Archive.getId().equals(recTypeId)){
				List<IrbArchiveForm> archiveFlielist = this.recBiz.queryArchiveFile(irbFlow);
				List<ItemGroupData> fileData = new ArrayList<ItemGroupData>();
				if(archiveFlielist!=null&&!archiveFlielist.isEmpty()){
					for (int i = 0; i < archiveFlielist.size(); i++) {
						ItemGroupData tmp = new ItemGroupData();
						Map<String, Object> objMap = new HashMap<String , Object>();
						objMap.put("fileData_No", String.valueOf(i+1));
						objMap.put("fileData_fileName", StringUtil.defaultIfEmpty(archiveFlielist.get(i).getName(), ""));
						objMap.put("fileData_date", StringUtil.defaultIfEmpty(archiveFlielist.get(i).getDate(), ""));
						tmp.setObjMap(objMap);
						fileData.add(tmp);
					}
				}
				dataMap.put("fileData", fileData);
				dataMap.put("projName", projName+"  "+projSubTypeName);
				dataMap.put("projDeclarer", projDeclarer);
				if(irbInfo!=null){
					dataMap.put("irbName", irbInfo.getIrbName());
				}
			}
			/*******************受理通知************************/
			else if("receiptNotice".equals(recTypeId)){
				dataMap.put("applyUserName", projApplyUserName);
				dataMap.put("projName", projName+"  "+projSubTypeName);
				dataMap.put("projDeclarer", projDeclarer);
				dataMap.put("irbTypeName", StringUtil.defaultString(curIrbApply.getIrbTypeName()));
				dataMap.put("irbNo", StringUtil.defaultString(curIrbApply.getIrbNo()));
				
				List<IrbApplyFileForm> fileList =  this.recBiz.queryConfirmFile(irbFlow);//已确认文件
				StringBuilder files = new StringBuilder();
				int fileNum = 1;
				if (fileList != null && fileList.size() > 0) {
					for (int i=0;i<fileList.size();i++) {
				    	IrbApplyFileForm file = fileList.get(i);
				    	if (GlobalConstant.FLAG_Y.equals(file.getShowNotice())) {
				    		files.append(file.getFileName());
					    	if(StringUtil.isNotBlank(file.getVersion())){
					    		files.append(" 版本号：").append(file.getVersion());
					    	}
					    	if(StringUtil.isNotBlank(file.getVersionDate())){
					    		files.append(" 版本日期：").append(file.getVersionDate());
					    	}
					    	files.append("\n");
					    	fileNum++;
				    	}
					}
				}
				if (fileNum >1) {
					files.deleteCharAt(files.length()-1);	//去掉选项最后的\n
				}
			    dataMap.put("files", files.toString());
			    
				dataMap.put("irbName", irbInfo==null?"":StringUtil.defaultString(irbInfo.getIrbName()));
				IrbProcess process = this.secretaryBiz.queryLatestHandlePro(irbFlow);
				dataMap.put("operUserName", process==null?"":StringUtil.defaultString(process.getOperUserName()));
				dataMap.put("irbAcceptedDate", StringUtil.defaultString(curIrbApply.getIrbAcceptedDate()));
				fileName = "受理通知";
			}
			/*******************投票单************************/
			else if("voteForm".equals(recTypeId)){
				dataMap.put("projName", StringUtil.defaultString(proj.getProjShortName())+"  "+projSubTypeName+"  "+StringUtil.defaultString(proj.getProjShortDeclarer()));
				dataMap.put("irbTypeName", StringUtil.defaultString(curIrbApply.getIrbTypeName()));
				StringBuilder decisionNames = new StringBuilder();
				String irbTypeId = curIrbApply.getIrbTypeId();
				for (IrbDecisionEnum dEnum : IrbDecisionEnum.values()) {
					if(dEnum.getIrbTypeId().contains(irbTypeId)){
						decisionNames.append("□" + dEnum.getName() + "，" + " ");
					}
				}
				if (decisionNames.length() >1) {
					decisionNames.deleteCharAt(decisionNames.length()-1);	//去掉选项最后的" "
					decisionNames.deleteCharAt(decisionNames.length()-1);	//去掉选项最后的"，"
				}
				dataMap.put("decisionNames", decisionNames.toString());
				String meetingFlow = form.getMeetingFlow();
				String meetingDate = "";
				IrbMeeting irbMeeting = meetingBiz.readIrbMeeting(meetingFlow);
				if (irbMeeting != null) {
					meetingDate = StringUtil.defaultString(irbMeeting.getMeetingDate());
				}
				dataMap.put("meetingDate", meetingDate);
				
				fileName = "投票单";
			}
			/*******************审查记录************************/
			else if("minutes".equals(recTypeId)){
				dataMap.put("projName", StringUtil.defaultString(curIrbApply.getProjName()));
				dataMap.put("irbTypeName", StringUtil.defaultString(curIrbApply.getIrbTypeName()));
				dataMap.put("irbNo", StringUtil.defaultString(curIrbApply.getIrbNo()));
				dataMap.put("applyUserName", StringUtil.defaultString(proj.getApplyUserName()));
				String isLeader = "";
				if (proj != null) {
					String content = proj.getProjInfo();
					if (StringUtil.isNotBlank(content)) {
						Document doc = DocumentHelper.parseText(content);
						Node isLeaderNode = doc.selectSingleNode("projInfo/generalInfo/isLeader");
						if (isLeaderNode != null) {
							isLeader = StringUtil.defaultString(isLeaderNode.getText());
						}
					}
				}

				if (StringUtil.isNotBlank(isLeader)) {
					isLeader = ProjOrgTypeEnum.getNameById(isLeader);
				}
				dataMap.put("isLeader", isLeader);
				dataMap.put("irbDecision", StringUtil.defaultString(curIrbApply.getIrbDecisionName()));
				
				StringBuilder preCommittee = new StringBuilder();
				//主审委员
				List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);//主审委员
				List<String> userFlowList = new ArrayList<String>();
				if (committeeList != null && committeeList.size() > 0) {
					for (IrbUser user:committeeList) {
						if (!userFlowList.contains(user.getUserFlow())) {
							preCommittee.append(user.getUserName() + "，");
							userFlowList.add(user.getUserFlow());
						}
					}
					preCommittee.deleteCharAt(preCommittee.length()-1);//去掉选项最后的逗号
				}
				dataMap.put("preCommittee", preCommittee.toString());
				
				IrbMinutesForm minForm = this.meetingBiz.readMinutes(irbFlow);//审查记录
				dataMap.put("title", minForm==null?"":StringUtil.defaultString(minForm.getTitle()));
				dataMap.put("question", minForm==null?"":StringUtil.defaultString(minForm.getQuestion()));
				dataMap.put("discussion", minForm==null?"":StringUtil.defaultString(minForm.getDiscussion()));
				//投票意见
				StringBuilder votes = new StringBuilder();
				String irbTypeId = curIrbApply.getIrbTypeId();
				List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irbFlow, null);
				for (IrbDecisionEnum de : IrbDecisionEnum.values()) {
					if(StringUtil.countMatches(de.getIrbTypeId(),irbTypeId)==1){
						int dCount = 0;//投票数
						if(formList!=null && formList.size() > 0){
							for (IrbVoteForm voteForm : formList) {
								if(de.getId().equals(voteForm.getDecisionId())){
									dCount++;
								}
							}
						}
						votes.append(de.getName() + "" + dCount + "票,");
					}
				}
				if (votes.length() > 1) {
					votes.deleteCharAt(votes.length()-1);//去掉选项最后的逗号
				}
				dataMap.put("votes", votes.toString());
				
				fileName = StringUtil.defaultString(curIrbApply.getProjShortName())+"_审查记录";
			}
		}
		/*******************主要研究者履历************************/
		 if("researcherResume".equals(recTypeId)){
				String userFlow = form.getUserFlow();
				if(StringUtil.isNotBlank(userFlow)){
					SysUser user = userBiz.readSysUser(userFlow);
					fileName = "主要研究者履历（" + StringUtil.defaultString(user.getUserName())+"）";
					if (user != null) {
						String birthDay = user.getUserBirthday();
						PubUserResume resume = userResumeBiz.readPubUserResume(userFlow);
						
						//基本信息
						dataMap.put("userName", user.getUserName());
						dataMap.put("sexName", user.getSexName());
						dataMap.put("userBirthday", birthDay);
						if (StringUtil.isNotBlank(birthDay)) {
							dataMap.put("userAge", DateUtil.calculateAge(birthDay));
						}
						dataMap.put("userCode", user.getUserCode());
						dataMap.put("idNo", user.getIdNo());
						dataMap.put("educationName", user.getEducationName());
						dataMap.put("degreeName", user.getDegreeName());
						dataMap.put("orgName", user.getOrgName());
						dataMap.put("deptName", user.getDeptName());
						dataMap.put("postName", user.getPostName());
						dataMap.put("titleName", user.getTitleName());
						dataMap.put("userPhone", user.getUserPhone());
						dataMap.put("userEmail", user.getUserEmail());
						
						//插入头像图片
						String value = "";
						String userHeadImg = StringUtil.defaultString(user.getUserHeadImg());
						if (StringUtil.isBlank(userHeadImg)) {
							value = "";
						} else {
							String cfgUrl = InitConfig.getSysCfg("upload_base_url");
							userHeadImg = cfgUrl+"/"+userHeadImg;
							value = "<img src='"+userHeadImg+"' width='80' height='90'  alt='头像'/>";
						}
						dataMap.put("userHeadImg", value);
						
						List<Map<String, String>> eduList = new ArrayList<Map<String, String>>();
						//教育经历
						List<EduResumeForm> eduFormList = eduResumeBiz.queryEduResumeList(resume);
						if (eduFormList != null && eduFormList.size() > 0) {
							for (int i=0;i<eduFormList.size();i++) {
								EduResumeForm edu = eduFormList.get(i);
								Map<String, String> objMap = new HashMap<String , String>();
								objMap.put("edu_startDate", StringUtil.defaultString(edu.getStartDate()));
								objMap.put("edu_endDate", StringUtil.defaultString(edu.getEndDate()));
								objMap.put("edu_college", StringUtil.defaultString(edu.getCollege()));
								objMap.put("edu_major", StringUtil.defaultString(edu.getMajor()));
								objMap.put("edu_education", StringUtil.defaultString(edu.getEducation()));
								objMap.put("edu_degree", StringUtil.defaultString(edu.getDegree()));
								eduList.add(objMap);
							}
						}
						dataMap.put("edu", eduList);

						
						//工作经历
						List<WorkResumeForm> workFormList = workResumeBiz.queryWorkList(resume);
						List<Map<String, String>> workList = new ArrayList<Map<String, String>>();
						if (workFormList != null && workFormList.size() > 0) {
							for (int i=0;i<workFormList.size();i++) {
								WorkResumeForm work = workFormList.get(i);
								Map<String, String> objMap = new HashMap<String , String>();
								objMap.put("work_startDate", StringUtil.defaultString(work.getStartDate()));
								objMap.put("work_endDate", StringUtil.defaultString(work.getEndDate()));
								objMap.put("work_orgName", StringUtil.defaultString(work.getOrgName()));
								objMap.put("work_department", StringUtil.defaultString(work.getDepartment()));
								objMap.put("work_title", StringUtil.defaultString(work.getTitle()));
								workList.add(objMap);
							}
						}
						dataMap.put("work", workList);
						
						//学会任职
						List<AcademicResumeForm> academicFormList = academicResumeBiz.queryAcademicList(resume);
						List<Map<String, String>> acadeList = new ArrayList<Map<String, String>>();
						if (academicFormList != null && academicFormList.size() > 0) {
							for (int i=0;i<academicFormList.size();i++) {
								AcademicResumeForm acade = academicFormList.get(i);
								Map<String, String> objMap = new HashMap<String , String>();
								objMap.put("aca_startDate", StringUtil.defaultString(acade.getStartDate()));
								objMap.put("aca_academicName", StringUtil.defaultString(acade.getAcademicName()));
								objMap.put("aca_title", StringUtil.defaultString(acade.getTitle()));
								acadeList.add(objMap);
							}
						}
						dataMap.put("aca", acadeList);
						
						//课题情况
						PubProj temp = new PubProj();
						temp.setApplyUserFlow(userFlow);
						List<PubProj> projList = projBiz.queryProjList(temp);
						List<Map<String, String>> proList = new ArrayList<Map<String, String>>();
						if (projList != null && projList.size() > 0) {
							for (int i=0;i<projList.size();i++) {
								PubProj pro = projList.get(i);
								Map<String, String> objMap = new HashMap<String , String>();
								objMap.put("pro_projStartTime", StringUtil.defaultString(pro.getProjStartTime()));
								objMap.put("pro_projEndTime", StringUtil.defaultString(pro.getProjEndTime()));
								objMap.put("pro_projNo", StringUtil.defaultString(pro.getProjNo()));
								objMap.put("pro_projName", StringUtil.defaultString(pro.getProjName()));
								objMap.put("pro_projSubTypeName", StringUtil.defaultString(pro.getProjSubTypeName()));
								objMap.put("pro_projDeclarer", StringUtil.defaultString(pro.getProjDeclarer()));
								proList.add(objMap);
							}
						}
						dataMap.put("pro", proList);
						
						//培训情况
						List<String> trainFlows = new ArrayList<String>();
						PubTrainUser trainUser = new PubTrainUser();
						trainUser.setUserFlow(userFlow);
						List<PubTrainUser> trianUserList = pubTrainUserBiz.queryTrainUserList(trainUser);
						if(trianUserList != null && trianUserList.size() > 0){
							for(PubTrainUser u : trianUserList){
								String trainFlow = u.getTrainFlow();
								if(StringUtil.isNotBlank(trainFlow)){
									trainFlows.add(trainFlow);
								}
							}
							if(trainFlows != null && trainFlows.size() > 0){
								List<PubTrain> trainList = pubTrainBiz.queryTrainList(null, null, trainFlows);
								List<Map<String, String>> traList = new ArrayList<Map<String, String>>();
								if (trainList != null && trainList.size() > 0) {
									for (int i=0;i<trainList.size();i++) {
										PubTrain train = trainList.get(i);
										Map<String, String> objMap = new HashMap<String , String>();
										objMap.put("trainDate", StringUtil.defaultString(train.getTrainDate()));
										objMap.put("trainDays", StringUtil.defaultString(train.getTrainDays()));
										objMap.put("trainName", StringUtil.defaultString(train.getTrainName()));
										objMap.put("trainOrg", StringUtil.defaultString(train.getTrainOrg()));
										objMap.put("trainAddress", StringUtil.defaultString(train.getTrainAddress()));
										objMap.put("trainTypeName", StringUtil.defaultString(train.getTrainTypeName()));
										objMap.put("trainCateName", StringUtil.defaultString(train.getTrainCategoryName()));
										traList.add(objMap);
									}
								}
								dataMap.put("train", traList);
							}
						}
						
						//论文
						SrmAchThesis thesis = new SrmAchThesis();
						thesis.setApplyUserFlow(userFlow);
						thesis.setOperStatusId(AchStatusEnum.FirstAudit.getId());
						List<SrmAchThesis> thesisList = thesisBiz.search(thesis, null);
						List<Map<String, String>> theList = new ArrayList<Map<String, String>>();
						if (thesisList != null && thesisList.size() > 0) {
							for (int i=0;i<thesisList.size();i++) {
								SrmAchThesis the = thesisList.get(i);
								Map<String, String> objMap = new HashMap<String , String>();
								objMap.put("the_thesisName", StringUtil.defaultString(the.getThesisName()));
								objMap.put("the_publishJour", StringUtil.defaultString(the.getPublishJour()));
								objMap.put("the_publishDate", StringUtil.defaultString(the.getPublishDate()));
								objMap.put("the_typeName", StringUtil.defaultString(the.getTypeName()));
								objMap.put("the_projSourceName", StringUtil.defaultString(the.getProjSourceName()));
								theList.add(objMap);
							}
						}
						dataMap.put("the", theList);
						
						//著作
						SrmAchBook book = new SrmAchBook();
						book.setApplyUserFlow(userFlow);
						book.setOperStatusId(AchStatusEnum.FirstAudit.getId());
						List<SrmAchBook> bookList = bookBiz.search(book, null);
						List<Map<String, String>> booList = new ArrayList<Map<String, String>>();
						if (bookList != null && bookList.size() > 0) {
							for (int i=0;i<bookList.size();i++) {
								SrmAchBook  boo = bookList.get(i);
								Map<String, String> objMap = new HashMap<String , String>();
								objMap.put("book_bookName", StringUtil.defaultString(boo.getBookName()));
								objMap.put("book_publishDate", StringUtil.defaultString(boo.getPublishDate()));
								objMap.put("book_publishOrg", StringUtil.defaultString(boo.getPublishOrg()));
								objMap.put("book_typeName", StringUtil.defaultString(boo.getTypeName()));
								objMap.put("book_pubPlaceName", StringUtil.defaultString(boo.getPubPlaceName()));
								booList.add(objMap);
							}
						}
						dataMap.put("book", booList);
						
						//专利
						SrmAchPatent patent = new SrmAchPatent();
						patent.setApplyUserFlow(userFlow);
						patent.setOperStatusId(AchStatusEnum.FirstAudit.getId());
						List<SrmAchPatent> patentList = patentBiz.search(patent, null);
						List<Map<String, String>> patList = new ArrayList<Map<String, String>>();
						if (patentList != null && patentList.size() > 0) {
							for (int i=0;i<patentList.size();i++) {
								SrmAchPatent  paten = patentList.get(i);
								Map<String, String> objMap = new HashMap<String , String>();
								objMap.put("pat_patentName", StringUtil.defaultString(paten.getPatentName()));
								objMap.put("pat_typeName", StringUtil.defaultString(paten.getTypeName()));
								objMap.put("pat_statusName", StringUtil.defaultString(paten.getStatusName()));
								objMap.put("pat_applyCode", StringUtil.defaultString(paten.getApplyCode()));
								objMap.put("pat_applyDate", StringUtil.defaultString(paten.getApplyDate()));
								patList.add(objMap);
							}
						}
						dataMap.put("pat", patList);
						
						//获奖
						SrmAchSat sat = new SrmAchSat();
						sat.setApplyUserFlow(userFlow);
						sat.setOperStatusId(AchStatusEnum.FirstAudit.getId());
						List<SrmAchSat> satList = satBiz.search(sat, null);
						List<Map<String, String>> saList = new ArrayList<Map<String, String>>();
						if (satList != null && satList.size() > 0) {
							for (int i=0;i<satList.size();i++) {
								SrmAchSat  sa = satList.get(i);
								Map<String, String> objMap = new HashMap<String , String>();
								objMap.put("sat_satName", StringUtil.defaultString(sa.getSatName()));
								objMap.put("sat_prizedGradeName", StringUtil.defaultString(sa.getPrizedGradeName()));
								objMap.put("sat_prizedLevelName", StringUtil.defaultString(sa.getPrizedLevelName()));
								objMap.put("sat_prizedDate", StringUtil.defaultString(sa.getPrizedDate()));
								objMap.put("sat_achTypeName", StringUtil.defaultString(sa.getAchTypeName()));
								saList.add(objMap);
							}
						}
						dataMap.put("sat", saList);
					}	
				}
			}
		 /*******************会议签到表************************/
		 if("meetingRegist".equals(recTypeId)){
			 String irbName ="";
			 String meetingDate = "";
			 String meetingFlow = form.getMeetingFlow();
			 IrbMeeting irbMeeting = meetingBiz.readIrbMeeting(meetingFlow);
			 if(irbMeeting != null){
				 IrbInfoUser irbInfoUser = new IrbInfoUser();
				 irbInfoUser.setIrbInfoFlow(irbMeeting.getIrbInfoFlow());
				 List<IrbInfoUser> infoUserList = infoUserBiz.queryUserList(irbInfoUser);
				 if(infoUserList != null && infoUserList.size()>0){
					 List<String> userFlows = new ArrayList<String>();
					 List<Map<String,String>> userInfo= new ArrayList<Map<String,String>>();
					 for(int i = 0 ; i < infoUserList.size() ; i++){
						 String userFlow = infoUserList.get(i).getUserFlow();
						 if(!userFlows.contains(userFlow)){
							 userFlows.add(userFlow);
							 SysUser user = userBiz.readSysUser(userFlow);
							 if(user != null){
								 Map<String,String> userMap = new HashMap<String,String>();
								 userMap.put("u_uName",StringUtil.defaultString(user.getUserName()));
								 userMap.put("u_sName",StringUtil.defaultString(user.getSexName()));
								 userMap.put("u_deptName",StringUtil.defaultString(user.getDeptName()));
								 userInfo.add(userMap);
							 }
						 }
					 }
					 irbName = StringUtil.defaultString(irbMeeting.getIrbName());
					 meetingDate = StringUtil.defaultString(irbMeeting.getMeetingDate());
					 dataMap.put("irbName", irbName);
					 dataMap.put("meetingDate", meetingDate);
					 dataMap.put("u",userInfo);
					 fileName = meetingDate + "会议签到表";
				 }
			 }
		 }
		 /*******************会议议程************************/
		if("meetingAgenda".equals(recTypeId)){
			String meetingFlow = form.getMeetingFlow();
			IrbMeeting meeting = meetingBiz.readIrbMeeting(meetingFlow);
			if (meeting != null) {
				fileName = StringUtil.defaultString(meeting.getMeetingDate()) + "会议议程";
				
				//会议信息
				dataMap.put("meetingDate", StringUtil.defaultString(meeting.getMeetingDate()));
				dataMap.put("meetingStartTime", StringUtil.defaultString(meeting.getMeetingStartTime()));
				dataMap.put("meetingEndTime", StringUtil.defaultString(meeting.getMeetingEndTime()));
				dataMap.put("meetingAddress", StringUtil.defaultString(meeting.getMeetingAddress()));
				dataMap.put("meetingHost", StringUtil.defaultString(meeting.getMeetingHost()));
				dataMap.put("irbName", StringUtil.defaultString(meeting.getIrbName()));
			
				StringBuilder committee = new StringBuilder();
				StringBuilder consultant = new StringBuilder();
				StringBuilder secretary = new StringBuilder();
				List<IrbMeetingUser> meetingUserList = meetingBiz.searchIrbMeetingUser(meetingFlow);
				List<String> committeeFlowList = new ArrayList<String>();
				if (meetingUserList != null && meetingUserList.size() >0 ) {
					for (IrbMeetingUser muser:meetingUserList) {
						String userFlow = muser.getUserFlow();
						String usetName = muser.getUserName();
						String roleName = muser.getRoleName();
						if (StringUtil.isNotBlank(roleName)) {
							if (roleName.indexOf(President) > -1 || roleName.indexOf(Committee) > -1) {
								if (!committeeFlowList.contains(userFlow)) {	//过滤人员既是主席又是委员的情况
									committee.append(usetName + "，");
									committeeFlowList.add(userFlow);
								}
							} else if (roleName.indexOf(Consultant) > -1) {
								consultant.append(usetName + "，");
							} else if (roleName.indexOf(Secretary) > -1) {
								secretary.append(usetName + "，");
							}
						}
					}
				}
				if (committee.length()>0) {
					committee.deleteCharAt(committee.length()-1);//去掉选项最后的逗号
				} else {
					committee.append("无");
				}
				if (consultant.length()>0) {
					consultant.deleteCharAt(consultant.length()-1);//去掉选项最后的逗号
				} else {
					consultant.append("无");
				}
				if (secretary.length()>0) {
					secretary.deleteCharAt(secretary.length()-1);//去掉选项最后的逗号
				} else {
					secretary.append("无");
				}
				dataMap.put("committee", committee.toString());
				dataMap.put("consultant", consultant.toString());
				dataMap.put("secretary", secretary.toString());
				
				IrbApply irbApply = new IrbApply();
				irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				irbApply.setMeetingFlow(meetingFlow);
				List<IrbApply> list = this.applyBiz.searchIrbs(irbApply);
				List<Map<String, String>> fList = new ArrayList<Map<String, String>>();	//快审
				List<Map<String, String>> mList = new ArrayList<Map<String, String>>();//会审
				if(list!=null && list.size() > 0){
					for (IrbApply irb : list) {
						String irbflow = irb.getIrbFlow();
						String meetingArrange = irb.getMeetingArrange();
						PubProj proj = projBiz.readProject(irb.getProjFlow());
						Map<String, String> fastMap = new HashMap<String , String>();
						Map<String, String> meetMap = new HashMap<String , String>();
						if (IrbReviewTypeEnum.Meeting.getId().equals(meetingArrange)) {
							meetMap.put("m_projName", StringUtil.defaultString(irb.getProjShortName()));
							meetMap.put("m_applyUserName", StringUtil.defaultString(proj.getApplyUserName()));
							meetMap.put("m_irbTypeName", StringUtil.defaultString(irb.getIrbTypeName()));
							meetMap.put("m_irbNo", StringUtil.defaultString(irb.getIrbNo()));
							mList.add(meetMap);
						} else {
							fastMap.put("f_projName", StringUtil.defaultString(irb.getProjShortName()));
							fastMap.put("f_applyUserName", StringUtil.defaultString(proj.getApplyUserName()));
							fastMap.put("f_irbTypeName", StringUtil.defaultString(irb.getIrbTypeName()));
							fastMap.put("f_irbNo", StringUtil.defaultString(irb.getIrbNo()));
							fastMap.put("f_irbDecision", StringUtil.defaultString(irb.getIrbDecisionName()));
							fList.add(fastMap);
						}
						StringBuilder preCommittee = new StringBuilder();
						//主审委员
						List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbflow);//主审委员
						List<String> userFlowList = new ArrayList<String>();
						if (committeeList != null && committeeList.size() > 0) {
							for (IrbUser user:committeeList) {
								if (!userFlowList.contains(user.getUserFlow())) {
									preCommittee.append(user.getUserName() + "，");
									userFlowList.add(user.getUserFlow());
								}
							}
							preCommittee.deleteCharAt(preCommittee.length()-1);//去掉选项最后的逗号
						}
						fastMap.put("f_preCommittee", preCommittee.toString());
						meetMap.put("m_preCommittee", preCommittee.toString());
						
						String irbConsult = "";
						IrbUser consultantUser = this.irbUserBiz.searchConsultant(irbflow);//独立顾问
						if (consultantUser != null) {
							irbConsult = consultantUser.getUserName();
						}
						meetMap.put("m_irbConsult", irbConsult);
						
					}
				}
				dataMap.put("f", fList);
				dataMap.put("m", mList);
			}
		}
		
		 /*******************会议记录************************/
		if("meetingRecord".equals(recTypeId)){
			String meetingFlow = form.getMeetingFlow();
			IrbMeeting meeting = meetingBiz.readIrbMeeting(meetingFlow);
			String lastDate = "";
			
			if (meeting != null) {
				fileName = StringUtil.defaultString(meeting.getMeetingDate()) + "会议记录";

				List<IrbMeeting> meetingList= meetingBiz.searchIrbMeeting()	;
				for(int i=0;i<meetingList.size();i++){
					IrbMeeting temp = meetingList.get(i);
					if(temp.getMeetingFlow().equals(meetingFlow)&&i>0){
						lastDate = meetingList.get(i-1).getMeetingDate();
						break;
					}else {
						lastDate = temp.getMeetingDate();
					}
				}
				
				//会议信息
				dataMap.put("meetingDate", StringUtil.defaultString(meeting.getMeetingDate()));
				dataMap.put("meetingStartTime", StringUtil.defaultString(meeting.getMeetingStartTime()));
				dataMap.put("meetingEndTime", StringUtil.defaultString(meeting.getMeetingEndTime()));
				dataMap.put("meetingAddress", StringUtil.defaultString(meeting.getMeetingAddress()));
				dataMap.put("meetingHost", StringUtil.defaultString(meeting.getMeetingHost()));
				dataMap.put("irbName", StringUtil.defaultString(meeting.getIrbName()));
				System.err.println("lastDate="+lastDate); 
				dataMap.put("lastDate", StringUtil.defaultString(lastDate)+"会议记录");
				
				StringBuilder committee = new StringBuilder();
				StringBuilder consultant = new StringBuilder();
				StringBuilder secretary = new StringBuilder();
				List<IrbMeetingUser> meetingUserList = meetingBiz.searchIrbMeetingUser(meetingFlow);
				List<String> committeeFlowList = new ArrayList<String>();
				if (meetingUserList != null && meetingUserList.size() >0 ) {
					for (IrbMeetingUser muser:meetingUserList) {
						String userFlow = muser.getUserFlow();
						String usetName = muser.getUserName();
						String roleName = muser.getRoleName();
						if (StringUtil.isNotBlank(roleName)) {
							if (roleName.indexOf(President) > -1 || roleName.indexOf(Committee) > -1) {
								if (!committeeFlowList.contains(userFlow)) {	//过滤人员既是主席又是委员的情况
									committee.append(usetName + "，");
									committeeFlowList.add(userFlow);
								}
							} else if (roleName.indexOf(Consultant) > -1) {
								consultant.append(usetName + "，");
							} else if (roleName.indexOf(Secretary) > -1) {
								secretary.append(usetName + "，");
							}
						}
					}
				}
				if (committee.length()>0) {
					committee.deleteCharAt(committee.length()-1);//去掉选项最后的逗号
				} else {
					committee.append("无");
				}
				if (consultant.length()>0) {
					consultant.deleteCharAt(consultant.length()-1);//去掉选项最后的逗号
				} else {
					consultant.append("无");
				}
				if (secretary.length()>0) {
					secretary.deleteCharAt(secretary.length()-1);//去掉选项最后的逗号
				} else {
					secretary.append("无");
				}
				dataMap.put("committee", committee.toString());
				dataMap.put("consultant", consultant.toString());
				dataMap.put("secretary", secretary.toString());
				
				List<WordprocessingMLPackage> templates = new ArrayList<WordprocessingMLPackage>();
				
				templ = recTypeId +"Template.docx";//会议信息模板
				String path = "/jsp/irb/print/"+templ;
				ServletContext context =  request.getServletContext();
				String watermark = GeneralMethod.getWatermark(form.getWatermarkFlag());
				WordprocessingMLPackage meetingTemeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
				
				List<WordprocessingMLPackage> fastTemplates = new ArrayList<WordprocessingMLPackage>();
				List<WordprocessingMLPackage> meetTemplates = new ArrayList<WordprocessingMLPackage>();
				IrbApply irbApply = new IrbApply();
				irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				irbApply.setMeetingFlow(meetingFlow);
				List<IrbApply> list = this.applyBiz.searchIrbs(irbApply);
				int fastNum = 0;
				Map<String,List<IrbApply>> irbTypeMap = new HashMap<String,List<IrbApply>>();
				if(list!=null && list.size() > 0){
					for (int i=0;i<list.size();i++) {
						IrbApply irb = list.get(i);
						String irbflow = irb.getIrbFlow();
						String irbType = irb.getIrbTypeId();
						String reviewWay = irb.getReviewWayId();
						String meetingArrange = irb.getMeetingArrange();
						if (IrbReviewTypeEnum.Meeting.getId().equals(meetingArrange)) {
							reviewWay = meetingArrange;
						}
						PubProj proj = projBiz.readProject(irb.getProjFlow());
						if (IrbReviewTypeEnum.Fast.getId().equals(reviewWay)) {
							fastNum++;
							dataMap.put("n", String.valueOf(fastNum));
							dataMap.put("projName", StringUtil.defaultString(irb.getProjName()));
							dataMap.put("applyUserName", StringUtil.defaultString(proj.getApplyUserName()));
							dataMap.put("irbTypeName", StringUtil.defaultString(irb.getIrbTypeName()));
							dataMap.put("irbNo", StringUtil.defaultString(irb.getIrbNo()));
							IrbMinutesForm minForm = this.meetingBiz.readMinutes(irbflow);//审查记录
							dataMap.put("reportMinutes", minForm==null?"":StringUtil.defaultString(minForm.getReportMinutes()));
							dataMap.put("irbDecision", StringUtil.defaultString(irb.getIrbDecisionName()));
							templ = "irbFastTemplate.docx";//快审模板
							path = "/jsp/irb/print/"+templ;
							WordprocessingMLPackage fastTemeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
							fastTemplates.add(fastTemeplete);
						} else {
							List<IrbApply> tempList = irbTypeMap.get(irbType);
							if (tempList == null) {
								tempList = new ArrayList<IrbApply>();
							}
							tempList.add(irb);
							irbTypeMap.put(irbType, tempList);
						}
					}
				}
				//会审
				for (int m=0;m<IrbTypeEnum.values().length;m++) {
					IrbTypeEnum typeEnum = IrbTypeEnum.values()[m];
					String irbType = typeEnum.getId();
					String irbTypeName = typeEnum.getName();
					List<IrbApply> tempList = irbTypeMap.get(irbType);
					if(tempList!=null && tempList.size() > 0){
						for (int i=0;i<tempList.size();i++) {
							IrbApply irb = tempList.get(i);
							String irbflow = irb.getIrbFlow();
							PubProj proj = projBiz.readProject(irb.getProjFlow());
							StringBuilder preCommittee = new StringBuilder();
							//主审委员
							List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbflow);//主审委员
							List<String> userFlowList = new ArrayList<String>();
							if (committeeList != null && committeeList.size() > 0) {
								for (IrbUser user:committeeList) {
									if (!userFlowList.contains(user.getUserFlow())) {
										preCommittee.append(user.getUserName() + "，");
										userFlowList.add(user.getUserFlow());
									}
								}
								preCommittee.deleteCharAt(preCommittee.length()-1);//去掉选项最后的逗号
							}
							dataMap.put("preCommittee", preCommittee.toString());
							//审查记录
							IrbMinutesForm minForm = this.meetingBiz.readMinutes(irbflow);
							dataMap.put("meetFlag", m==0&&i==0?"二、会议审查项目":"");
							dataMap.put("irbTypeName", i==0?"("+NumTrans.transNum(String.valueOf(m+1))+")"+irbTypeName:"");
							dataMap.put("n", String.valueOf(i+1));
							dataMap.put("projName", StringUtil.defaultString(irb.getProjName()));
							dataMap.put("applyUserName", StringUtil.defaultString(proj.getApplyUserName()));
							dataMap.put("irbNo", StringUtil.defaultString(irb.getIrbNo()));
							String isLeader = "";
							if (proj != null) {
								String content = proj.getProjInfo();
								if (StringUtil.isNotBlank(content)) {
									Document doc = DocumentHelper.parseText(content);
									Node isLeaderNode = doc.selectSingleNode("projInfo/generalInfo/isLeader");
									if (isLeaderNode != null) {
										isLeader = StringUtil.defaultString(isLeaderNode.getText());
									}
								}
							}
							if (StringUtil.isNotBlank(isLeader)) {
								isLeader = ProjOrgTypeEnum.getNameById(isLeader);
							}
							dataMap.put("isLeader", isLeader);
							dataMap.put("irbDecision", StringUtil.defaultString(irb.getIrbDecisionName()));
							dataMap.put("title", minForm==null?"":StringUtil.defaultString(minForm.getTitle()));
							dataMap.put("question", minForm==null?"":StringUtil.defaultString(minForm.getQuestion()));
							dataMap.put("discussion", minForm==null?"":StringUtil.defaultString(minForm.getDiscussion()));
							//投票意见
							StringBuilder votes = new StringBuilder();
							String irbTypeId = irb.getIrbTypeId();
							List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irbflow, null);
							for (IrbDecisionEnum de : IrbDecisionEnum.values()) {
								if(StringUtil.countMatches(de.getIrbTypeId(),irbTypeId)==1){
									int dCount = 0;//投票数
									if(formList!=null && formList.size() > 0){
										for (IrbVoteForm voteForm : formList) {
											if(de.getId().equals(voteForm.getDecisionId())){
												dCount++;
											}
										}
									}
									votes.append(de.getName() + "" + dCount + "票,");
								}
							}
							if (votes.length() > 1) {
								votes.deleteCharAt(votes.length()-1);//去掉选项最后的逗号
							}
							dataMap.put("votes", votes.toString());
							templ = "irbMeetTemplate.docx";//会审模板
							path = "/jsp/irb/print/"+templ;
							WordprocessingMLPackage meetTemeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
							meetTemplates.add(meetTemeplete);
						}
					} else{
						dataMap.put("meetFlag", m==0?"二、会议审查项目":"");
						dataMap.put("irbTypeName", "("+NumTrans.transNum(String.valueOf(m+1))+")"+irbTypeName+"(无)");
						templ = "irbMeetNoneTemplate.docx";//会审模板
						path = "/jsp/irb/print/"+templ;
						WordprocessingMLPackage meetNoneTemeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
						meetTemplates.add(meetNoneTemeplete);
					}
				}
					
				//合并模板
				templates.add(meetingTemeplete);
				if (fastTemplates.size() > 0) {
					templates.addAll(fastTemplates);
				}
				if (meetTemplates.size() > 0) {
					templates.addAll(meetTemplates);
				}
				temeplete = Docx4jUtil.mergeDocx(templates);
			}
		}
		
		/*******************年度工作报告************************/
		 if("yearReport".equals(recTypeId)){
			String year = form.getYear();
			String irbInfoFlow = form.getIrbInfoFlow();
			String irbName = "";
			if(StringUtil.isNotBlank(irbInfoFlow)){
				IrbInfo irbinfo = irbInfoBiz.queryInfo(irbInfoFlow);
				if (irbinfo != null) {
					irbName = irbinfo.getIrbName();
				}
			}
			/*伦理委员会人员名单*/
			List<Map<String, String>> irbInfoList = new ArrayList<Map<String, String>>();
			IrbInfoUser user = new IrbInfoUser();
			user.setIrbInfoFlow(irbInfoFlow);
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<IrbInfoUser> userList = this.infoUserBiz.queryUserList(user); 
			List<IrbInfoUser> filterList = new ArrayList<IrbInfoUser>();//过滤一个用户多个角色
			for (IrbInfoUser irbUser : userList) {
				boolean canAdd = false;
				//过滤一个用户多个角色
				for (IrbInfoUser filterUser : filterList) {
					if(irbUser.getUserFlow().equals(filterUser.getUserFlow())&&irbUser.getIrbInfoFlow().equals(filterUser.getIrbInfoFlow())){
						filterUser.setRoleName(filterUser.getRoleName()+"，"+irbUser.getRoleName());
						canAdd = false;
						break;
					}else{
						canAdd = true;
					}
				}
				if(filterList.isEmpty()||canAdd){
					filterList.add(irbUser);
				}
			}
			SysUser sysUser = null;
			Map<String, String> irbMap = null;
			if (filterList != null && filterList.size() >0) {
				for (IrbInfoUser irbUser : filterList) {
					irbMap = new HashMap<String , String>();
					sysUser = this.userBiz.readSysUser(irbUser.getUserFlow());
					irbMap.put("r_user", sysUser.getUserName());
					irbMap.put("r_sex", sysUser.getSexName());
					irbMap.put("r_org", sysUser.getOrgName());
					irbMap.put("r_title", sysUser.getTitleName());
					irbMap.put("r_role", irbUser.getRoleName());
					irbInfoList.add(irbMap);
				}
			}
			dataMap.put("r", irbInfoList);
			
			/*年度审查情况*/
			IrbApply temp = new IrbApply();
			temp.setIrbInfoFlow(irbInfoFlow);
			temp.setIrbReviewDate(year);
			List<IrbApply> mList = null;
			List<IrbApply> fList = null;
			//伦理审查类别
			List<Map<String, String>> scList = new ArrayList<Map<String, String>>();
			Map<String, String> scMap = null;
			IrbTypeEnum[] typeEnums = IrbTypeEnum.values();
			int scmNum = 0;
			int scfNum = 0;
			for(IrbTypeEnum e : typeEnums){
				scMap = new HashMap<String, String>();
				temp.setIrbTypeId(e.getId());
				temp.setMeetingArrange(IrbReviewTypeEnum.Meeting.getId());
				mList = applyBiz.queryIrbApply("","",temp);
				temp.setMeetingArrange(IrbReviewTypeEnum.Fast.getId());
				fList = applyBiz.queryIrbApply("","",temp);
				scMap.put("sc_scName", e.getScName());
				scMap.put("sc_mNum", mList==null?"0":mList.size()+"");
				scMap.put("sc_fNum", fList==null?"0":fList.size()+"");
				scMap.put("sc_total", (mList==null?0:mList.size())+(fList==null?0:fList.size())+"");
				scmNum += mList==null?0:mList.size();
				scfNum += fList==null?0:fList.size();
				scList.add(scMap);
			}
			//合计
			scMap = new HashMap<String , String>();
			scMap.put("sc_scName", "合计");
			scMap.put("sc_mNum", scmNum+"");
			scMap.put("sc_fNum", scfNum+"");
			scMap.put("sc_total", scmNum+scfNum+"");
			scList.add(scMap);
			//研究类别
			temp = new IrbApply();
			temp.setIrbInfoFlow(irbInfoFlow);
			temp.setIrbReviewDate(year);
			List<Map<String, String>> yjList = new ArrayList<Map<String, String>>();
			Map<String, String> yjMap = null;
			GcpProjSubTypeEnum[]  gcpProjSubTypeEnums = GcpProjSubTypeEnum.values();
			int yjmNum = 0;
			int yjfNum = 0;
			for(GcpProjSubTypeEnum e : gcpProjSubTypeEnums){
				yjMap = new HashMap<String, String>();
				temp.setProjSubTypeId(e.getId());
				temp.setMeetingArrange(IrbReviewTypeEnum.Meeting.getId());
				mList = applyBiz.queryIrbApply("","",temp);
				temp.setMeetingArrange(IrbReviewTypeEnum.Fast.getId());
				fList = applyBiz.queryIrbApply("","",temp);
				yjMap.put("yj_scName", e.getName());
				yjMap.put("yj_mNum", mList==null?"0":mList.size()+"");
				yjMap.put("yj_fNum", fList==null?"0":fList.size()+"");
				yjMap.put("yj_total", (mList==null?0:mList.size())+(fList==null?0:fList.size())+"");
				yjmNum += mList==null?0:mList.size();
				yjfNum += fList==null?0:fList.size();
				yjList.add(yjMap);
			}
			//合计
			yjMap = new HashMap<String , String>();
			yjMap.put("yj_scName", "合计");
			yjMap.put("yj_mNum", yjmNum+"");
			yjMap.put("yj_fNum", yjfNum+"");
			yjMap.put("yj_total", yjmNum+yjfNum+"");
			yjList.add(yjMap);
			//决定 类别
			temp = new IrbApply();
			temp.setIrbInfoFlow(irbInfoFlow);
			temp.setIrbReviewDate(year);
			List<Map<String, String>> jdList = new ArrayList<Map<String, String>>();
			Map<String, String> jdMap = null;
			IrbDecisionEnum[] irbDecisionEnums = IrbDecisionEnum.values();
			int jdmNum = 0;
			int jdfNum = 0;
			for(IrbDecisionEnum e : irbDecisionEnums){
				jdMap = new HashMap<String, String>();
				temp.setIrbDecisionId(e.getId());
				temp.setMeetingArrange(IrbReviewTypeEnum.Meeting.getId());
				mList = applyBiz.queryIrbApply("","",temp);
				temp.setMeetingArrange(IrbReviewTypeEnum.Fast.getId());
				fList = applyBiz.queryIrbApply("","",temp);
				jdMap.put("jd_scName", e.getName());
				jdMap.put("jd_mNum", mList==null?"0":mList.size()+"");
				jdMap.put("jd_fNum", fList==null?"0":fList.size()+"");
				jdMap.put("jd_total", (mList==null?0:mList.size())+(fList==null?0:fList.size())+"");
				jdmNum += mList==null?0:mList.size();
				jdfNum += fList==null?0:fList.size();
				jdList.add(jdMap);
			}
			//合计
			jdMap = new HashMap<String , String>();
			jdMap.put("jd_scName", "合计");
			jdMap.put("jd_mNum", jdmNum+"");
			jdMap.put("jd_fNum", jdfNum+"");
			jdMap.put("jd_total", jdmNum+jdfNum+"");
			jdList.add(jdMap);
			dataMap.put("sc", scList);
			dataMap.put("yj", yjList);
			dataMap.put("jd", jdList);
			
			/*年度会议情况*/
			IrbMeeting meeting = new IrbMeeting();
			meeting.setMeetingDate(year);
			meeting.setIrbInfoFlow(irbInfoFlow);
			List<IrbMeeting> meetList = this.meetingBiz.searchList(meeting);
			if(meetList!=null){
				/*计算年度审查会议数*/
				long mCount = 0l;
				mCount = meetList.size();
				dataMap.put("mCount", mCount+"");
				/*计算平均会议时间*/
				long sumMeetTime = 0l;//总会议时间
				List<String> meetingFlows = new ArrayList<String>();
				for (IrbMeeting m : meetList) {
					Date startDate = DateUtil.parseDate(m.getMeetingStartTime(), "HH:mm");
					Date endDate = DateUtil.parseDate(m.getMeetingEndTime(), "HH:mm");
					long minutes = DateUtil.signMinutesBetweenTowDate(startDate, endDate);
					sumMeetTime += minutes;
					meetingFlows.add(m.getMeetingFlow());
				}
				String avgMeetTime = DateUtil.formatMinutes(Math.round(Double.valueOf(sumMeetTime)/Double.valueOf(mCount)));
				dataMap.put("avgTime", avgMeetTime);
				/*计算平均每次会议审查/报告项目数*/
				IrbApply irb = new IrbApply();
				irb.setIrbReviewDate(year);
				irb.setIrbInfoFlow(irbInfoFlow);
				irb.setMeetingArrange(IrbReviewTypeEnum.Meeting.getId());
				long sumMeeting = this.applyBiz.queryIrbApplyCount(irb) ;//总会议审查数
				irb.setMeetingArrange(IrbReviewTypeEnum.Fast.getId());
				long sumFast = this.applyBiz.queryIrbApplyCount(irb) ;//总会议报告数
				long avgMeeting = Math.round(Double.valueOf(sumMeeting)/Double.valueOf(mCount));
				long avgFast = Math.round(Double.valueOf(sumFast)/Double.valueOf(mCount));
				dataMap.put("avgNum", avgMeeting+"/"+avgFast);
				/*计算平均到会委员数(注：未过滤角色)*/
				long sumMeetingMember = 0l;
				if(meetingFlows.size()>0){
					sumMeetingMember = this.meetingUserBiz.queryMeetingUserCount(meetingFlows);
				}
				long avgMeetingMember = Math.round(Double.valueOf(sumMeetingMember)/Double.valueOf(mCount));
				dataMap.put("avgMember", avgMeetingMember+"");
			}
			/*年度培训情况*/
			List<Map<String, String>> inners = new ArrayList<Map<String, String>>();
			List<Map<String, String>> outs = new ArrayList<Map<String, String>>();
			Map<String, String> trainMap = null;
			PubTrainUser trainUser = null;
			PubTrain train = new PubTrain();
			train.setTrainDate(year);
			train.setTrainCategoryId(IrbTrainCategoryEnum.Inner.getId());
			List<PubTrain> innerList = this.pubTrainBiz.queryTrainList(train, null, null);
			train.setTrainCategoryId(IrbTrainCategoryEnum.Out.getId());
			List<PubTrain> outList = this.pubTrainBiz.queryTrainList(train, null, null);
			if(innerList!=null&&!innerList.isEmpty()){
				for (PubTrain pubTrain : innerList) {
					trainMap = new HashMap<String,String>();
					trainMap.put("i_trainOrg", pubTrain.getTrainOrg());
					trainMap.put("i_trainName", pubTrain.getTrainName());
					trainMap.put("i_typeName", pubTrain.getTrainTypeName());
					trainMap.put("i_date", pubTrain.getTrainDate());
					trainUser = new PubTrainUser();
					trainUser.setTrainFlow(pubTrain.getTrainFlow());
					trainMap.put("i_user", this.pubTrainUserBiz.queryTrainUserCount(trainUser)+"");
					inners.add(trainMap);
				}
			}
			if(outList!=null&&!outList.isEmpty()){
				for (PubTrain pubTrain : outList) {
					trainMap = new HashMap<String,String>();
					trainMap.put("o_trainOrg", pubTrain.getTrainOrg());
					trainMap.put("o_trainName", pubTrain.getTrainName());
					trainMap.put("o_typeName", pubTrain.getTrainTypeName());
					trainMap.put("o_date", pubTrain.getTrainDate());
					trainUser = new PubTrainUser();
					trainUser.setTrainFlow(pubTrain.getTrainFlow());
					trainMap.put("o_user", this.pubTrainUserBiz.queryTrainUserCount(trainUser)+"");
					outs.add(trainMap);
				}
			}
			dataMap.put("i", inners);
			dataMap.put("o", outs);
			dataMap.put("year", year+"年");
			dataMap.put("irbName", irbName);
			fileName = year + "年" + irbName + "年度工作报告";
		 }
		
		templ = recTypeId +"Template.docx";//模板
		String path = "/jsp/irb/print/"+templ;
		ServletContext context =  request.getServletContext();
		String watermark = GeneralMethod.getWatermark(form.getWatermarkFlag());
		if (!"meetingRecord".equals(recTypeId)) {
			temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), dataMap,watermark,true);
		}
		if(temeplete!=null){
			response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
			String name = fileName+".docx"; 
			response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
			ServletOutputStream out = response.getOutputStream ();
			(new SaveToZipFile (temeplete)).save (out);
			out.flush ();
		}
	}
}

