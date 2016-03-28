package com.pinde.sci.ctrl.irb;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbCfgBiz;
import com.pinde.sci.biz.irb.IIrbInfoBiz;
import com.pinde.sci.biz.irb.IIrbInfoUserBiz;
import com.pinde.sci.biz.irb.IIrbMeetingBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.IIrbResearcherBiz;
import com.pinde.sci.biz.irb.IIrbSecretaryBiz;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.DateTrans;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.gcp.GcpProjSubTypeEnum;
import com.pinde.sci.enums.irb.IrbAuthTypeEnum;
import com.pinde.sci.enums.irb.IrbDecisionEnum;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.irb.IrbReviewTypeEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.pub.QuickDatePickEnum;
import com.pinde.sci.enums.sys.RoleLevelEnum;
import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.form.irb.IrbDecisionDetailForm;
import com.pinde.sci.form.irb.IrbNoticeForm;
import com.pinde.sci.form.irb.IrbQuickOpinionForm;
import com.pinde.sci.form.irb.IrbReceiptNoticeForm;
import com.pinde.sci.model.irb.ApplyFileTemp;
import com.pinde.sci.model.irb.IrbForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbInfoUser;
import com.pinde.sci.model.mo.IrbMeeting;
import com.pinde.sci.model.mo.IrbMeetingUser;
import com.pinde.sci.model.mo.IrbProcess;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/irb/secretary")
public class IrbSecretaryController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(IrbSecretaryController.class);
	
	@Autowired
	private IIrbSecretaryBiz secretaryBiz;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IIrbCfgBiz irbCfgBiz;
	@Autowired
	private IIrbRecBiz irbRecBiz;
	@Autowired
	private IIrbInfoBiz irbInfoBiz;
	@Autowired
	private IIrbInfoUserBiz irbInfoUserBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IUserBiz sysUserBiz;
	@Autowired
	private IIrbUserBiz irbUserBiz;
	@Autowired
	private IIrbResearcherBiz irbResearcherBiz; 
	@Autowired
	private IIrbMeetingBiz irbMeetingBiz;
	@Autowired
	private IProjUserBiz pjUserBiz;
	@Autowired
	private IIrbResearcherBiz researcherBiz;
	
	
	@RequestMapping(value={"/index"},method={RequestMethod.GET})
	public String index(Model model){
		List<IrbMeeting> mList = this.irbMeetingBiz.searchIrbMeeting();
		if (mList != null && mList.size()>0) {
			IrbMeeting meeting = mList.get(mList.size()-1);
				model.addAttribute("meeting", meeting);
				
				IrbInfo irbInfo = irbInfoBiz.queryInfo(meeting.getIrbInfoFlow());
				model.addAttribute("irbInfo", irbInfo);
				
				IrbApply apply = new IrbApply();
				apply.setMeetingFlow(meeting.getMeetingFlow());
				List<IrbApply> irbList = irbApplyBiz.searchIrbApply(apply);
				Integer meetingReportIrbCount = 0;
				Integer meetingReviewIrbCount = 0;
				Integer approveCount = 0;
				Integer opinionCount = 0;
				for(IrbApply temp : irbList){
					if(IrbReviewTypeEnum.Fast.getId().equals(temp.getMeetingArrange())){
						meetingReportIrbCount++;
					}else if(IrbReviewTypeEnum.Meeting.getId().equals(temp.getMeetingArrange())){
						meetingReviewIrbCount++;
					}
					if(StringUtil.isNotBlank(temp.getIrbDecisionDate())){
						if(StringUtil.isNotBlank(temp.getApproveDate())){ 
							approveCount++;
						}else {
							opinionCount++;
						}
					}
				}
				
				model.addAttribute("meetingReportIrbCount",  meetingReportIrbCount);
				model.addAttribute("meetingReviewIrbCount",meetingReviewIrbCount);
				model.addAttribute("approveCount",approveCount);
				model.addAttribute("opinionCount",opinionCount);
				model.addAttribute("meetingUserList", irbMeetingBiz.filterUserList(meeting.getMeetingFlow()));
				
		}
		
		
		//提醒
		List<IrbApply> unAcceptIrbs = new ArrayList<IrbApply>();
		List<IrbApply> unReviewIrbs = new ArrayList<IrbApply>();
		List<IrbApply> unDecisionIrbs = new ArrayList<IrbApply>();
		List<IrbApply> unArchiveIrbs = new ArrayList<IrbApply>();
		List<IrbApply> trackIrbs = new ArrayList<IrbApply>();
		IrbApply irb = new IrbApply();
		List<IrbApply> applys = irbApplyBiz.queryIrbApply(irb);
		if(applys!=null && applys.size()>0){
			for(IrbApply apply : applys){
				//受理状态未填写受理通知
				if( IrbStageEnum.Handle.getId().equals(apply.getIrbStageId())){
					unAcceptIrbs.add(apply);
				} 
				//审查
				if(IrbStageEnum.Review.getId().equals(apply.getIrbStageId())){
					unReviewIrbs.add(apply);
				}
				//未传达决定
				if(IrbStageEnum.Decision.getId().equals(apply.getIrbStageId())){
					unDecisionIrbs.add(apply);
				}
				//未传达决定
				if(IrbStageEnum.Archive.getId().equals(apply.getIrbStageId())){
					unArchiveIrbs.add(apply);
				}
				//跟踪审查提醒
				if(StringUtil.isNotBlank(apply.getTrackDate())){
					String trackRemaind =  InitConfig.getSysCfg("irb_track_remaind");
					if(StringUtil.isBlank(trackRemaind)){ 
						trackRemaind = GlobalConstant.IRB_DEFAULT_TRACK_REMAIND;
					}
					if(DateUtil.signDaysBetweenTowDate(apply.getTrackDate(),DateUtil.getCurrDate())<Integer.parseInt(trackRemaind)
							&& DateUtil.signDaysBetweenTowDate( apply.getTrackDate(),DateUtil.getCurrDate())>0)
							{
						trackIrbs.add(apply);
					}
				}
			}
		}
		model.addAttribute("unAcceptIrbs", unAcceptIrbs);
		model.addAttribute("unReviewIrbs", unReviewIrbs);
		model.addAttribute("unDecisionIrbs", unDecisionIrbs);
		model.addAttribute("unArchiveIrbs", unArchiveIrbs);
		model.addAttribute("trackIrbs", trackIrbs);
		return "irb/view/secretary";
	}
	@RequestMapping(value={"/overview"},method={RequestMethod.GET})
	public String overview(String pickType,Model model){
		Map<String,Integer> applyCountMap = new HashMap<String, Integer>();
		IrbApply irb = new IrbApply();
		List<IrbApply> applys = irbApplyBiz.queryIrbApply(irb);
		if(applys!=null && applys.size()>0){
			String currYear =  DateUtil.getCurrDateTime("yyyy");
			String currMonth =  DateUtil.getCurrDateTime("MM");
			for(IrbApply apply : applys){
				if(StringUtil.isBlank(apply.getIrbNo())){//未受理的不计算
					continue;
				}
				if(StringUtil.isNotBlank(pickType) && StringUtil.isNotBlank(apply.getIrbAcceptedDate())){ 
					String applyYear = DateUtil.transDateTime(apply.getIrbAcceptedDate(),"yyyy-MM-dd","yyyy");
					String applyMonth = DateUtil.transDateTime(apply.getIrbAcceptedDate(),"yyyy-MM-dd","MM");
					if(!applyYear.equals(currYear)){
						continue;
					}
					if(QuickDatePickEnum.Month.getId().equals(pickType)){ 
						if(!currMonth.equals(applyMonth)){
							continue;
						} 
					}else if(QuickDatePickEnum.Season.getId().equals(pickType)){
						if(!GeneralMethod.getDateSeason(currMonth).equals(GeneralMethod.getDateSeason(applyMonth))){
							continue;
						}
					}
				}
				
				String subTypeId = apply.getProjSubTypeId();
				if(!GcpProjSubTypeEnum.Ky.getId().equals(subTypeId) &&
						!GcpProjSubTypeEnum.Qx.getId().equals(subTypeId)){
					subTypeId = ProjCategroyEnum.Yw.getId();
				}
				String isInit = GlobalConstant.FLAG_Y;
				if(!IrbTypeEnum.Init.getId().equals(apply.getIrbTypeId())){
					isInit = GlobalConstant.FLAG_N;
				}
				Integer count = applyCountMap.get(subTypeId+"_"+isInit);
				if(count==null){
					count = 0;
				}
				count++;
				applyCountMap.put(subTypeId+"_"+isInit, count);
			}
		}
		
		model.addAttribute("applyCountMap", applyCountMap);
		return "irb/view/secOverview";
	}
	
	@RequestMapping(value="/list")
	public String list(IrbApply irbApply,Model model){
		if(irbApply!=null){
			String stage = irbApply.getIrbStageId();
			if(irbApply!=null&&StringUtil.isNotBlank(irbApply.getProjName())){
				irbApply.setProjName("%"+irbApply.getProjName()+"%");
			}
			IrbApplyForm form = new IrbApplyForm();
			form.setIrbApply(irbApply);
			List<IrbForm> irbList = secretaryBiz.searchIrbListByForm(form);
			model.addAttribute("irbFormList", irbList);
			
			if(IrbStageEnum.Handle.getId().equals(stage)){
				return "irb/secretary/handle/list";
			}else if(IrbStageEnum.Review.getId().equals(stage)){
				return "irb/secretary/review/list";
			}else if(IrbStageEnum.Decision.getId().equals(stage)){
				return "irb/secretary/decision/list";
			}else if(IrbStageEnum.Archive.getId().equals(stage)){
				return "irb/secretary/archive/list";
			}
		}
		return "error/404";
	}
	/**
	 * 受理/处理项目
	 * @param irbFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/handle"},method={RequestMethod.GET})
	public String  handle(String irbFlow,Model model) throws Exception{
		IrbForm irbForm = secretaryBiz.readIrbForm(irbFlow);
		model.addAttribute("irbForm", irbForm);
		List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);	//主审委员（未过滤相同的人 如：主审委员方案和知情同意为同一个人）
		model.addAttribute("committeeList", committeeList);
		boolean allConfirm = this.checkAllConfirm(irbFlow, null);//已提交文件是否全部确认
		model.addAttribute("allConfirm", allConfirm);
		return "irb/secretary/handle/manage";
	}
	
	@RequestMapping(value={"/review"},method={RequestMethod.GET})
	public String  review(Model model){
		return "irb/secretary/review/manage";
	}
	/**
	 * 传达决定
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/decision"},method={RequestMethod.GET})
	public String  decision(String irbFlow, Model model) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			IrbForm irbForm = this.secretaryBiz.readIrbForm(irbFlow);
			model.addAttribute("irbForm", irbForm);
			List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);	//主审委员（未过滤相同的人 如：主审委员方案和知情同意为同一个人）
			model.addAttribute("committeeList", committeeList);
			
			IrbApply irb = irbForm.getIrb();
			String fileType = this.secretaryBiz.checkFileType(irb);//判断是批件还是意见
			model.addAttribute("fileType", fileType);
		}
		return "irb/secretary/decision/manage";
	}
	
	/**
	 * 加载文件存档列表
	 * @param projFlow
	 * @param irbFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/archive"},method={RequestMethod.GET})
	public String  archive(String irbFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			List<IrbArchiveForm> archiveFlielist = this.irbRecBiz.queryArchiveFile(irbFlow);
			IrbForm irbForm = this.secretaryBiz.readIrbForm(irbFlow);
			model.addAttribute("archiveFlielist", archiveFlielist);
			model.addAttribute("irbForm", irbForm);
			List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);	//主审委员（未过滤相同的人 如：主审委员方案和知情同意为同一个人）
			model.addAttribute("committeeList", committeeList);
		}
		return "irb/secretary/archive/archiveFile";
	}
	
	/**
	 * 保存存档文件
	 * @param form
	 * @return
	 */
	@RequestMapping(value="/saveApplyFile")
	@ResponseBody
	public String saveApplyFile(@RequestBody List<IrbArchiveForm> list,String irbFlow)throws Exception{
		if(list!=null&&!list.isEmpty()&&StringUtil.isNotBlank(irbFlow)){
			int result = this.irbRecBiz.saveArchiveFile(list, irbFlow);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 完成本次审查
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/finishApply"},method={RequestMethod.GET})
	@ResponseBody
	public String finishApply(String irbFlow,Model model){
		IrbApply irbApply = irbApplyBiz.queryByFlow(irbFlow);
		if(irbApply!=null){
			irbApply.setIrbStageId(IrbStageEnum.Filing.getId());
			irbApply.setIrbStageName(IrbStageEnum.Filing.getName());
			this.irbApplyBiz.changeStage(irbApply);
			this.irbResearcherBiz.saveProcess(irbApply, null);//插入process
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	
	@RequestMapping(value={"/approveFile"},method={RequestMethod.GET})
	public String  approveFile(Model model){
		return "irb/secretary/decision/approveFile";
	}
	@RequestMapping(value={"/irbMemberList"},method={RequestMethod.GET})
	public String  irbMemberList(Model model){
		return "irb/secretary/decision/irbMemberList";
	}
	@RequestMapping(value={"/selectCommittee"},method={RequestMethod.GET})
	public String  selectCommittee(Model model){
		return "irb/secretary/handle/selectCommittee";
	}
	/**
	 * 快审主审综合意见
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/quickOpinion")
	public String  quickOpinion(String irbFlow, Model model)throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			IrbApply irb = irbApplyBiz.queryByFlow(irbFlow);
			if(irb!=null){
				IrbInfo irbInfo = this.irbInfoBiz.queryInfo(irb.getIrbInfoFlow());//伦理委员会
				model.addAttribute("irbInfo", irbInfo);
			}
			IrbUser user = new IrbUser();
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			user.setIrbFlow(irbFlow);
			List<IrbUser> irbUserList = this.irbUserBiz.queryList(user);
			IrbQuickOpinionForm qForm = this.secretaryBiz.readQuickOpinion(irbFlow);
			model.addAttribute("irb", irb);
			model.addAttribute("irbUserList", irbUserList);
			model.addAttribute("qForm", qForm);
		}
		return "irb/secretary/review/quickOpinion";
	}
	@RequestMapping(value={"/archiveFile"},method={RequestMethod.GET})
	public String  archiveFile(Model model){
		return "irb/secretary/archive/archiveFile";
	}
	@RequestMapping(value={"/followReview"},method={RequestMethod.GET})
	public String followReview(Model model){
		List<IrbApply> irbApplyList = this.irbApplyBiz.searchTrackIrbList();
		List<String> pjFlowList = new ArrayList<String>();
		Map<String,IrbApply> irbMap = new HashMap<String,IrbApply>();
		Map<String, String> trackMap = new HashMap<String, String>();
		Date currDate = new Date();
		if (irbApplyList != null && irbApplyList.size()>0) {
			for (IrbApply apply:irbApplyList) {
				String projFlow = apply.getProjFlow();
				String irbFlow = apply.getIrbFlow();
				String trackdate = apply.getTrackDate();
				pjFlowList.add(projFlow);
				irbMap.put(projFlow, apply);
				//跟踪审查日期：N 超过跟踪审查日期；Y 距跟踪审查日期1个月
				Date trackDate = DateUtil.parseDate(trackdate, "yyyy-MM-dd");
				if(currDate.after(trackDate)){
					trackMap.put(irbFlow, GlobalConstant.FLAG_N);
				} else if(DateUtil.signDaysBetweenTowDate(trackDate,currDate)<=Long.parseLong(InitConfig.getSysCfg("irb_track_remaind"))){
					trackMap.put(irbFlow, GlobalConstant.FLAG_Y);
				}
			}
		}
		
		if(pjFlowList!=null && pjFlowList.size()>0){
			List<PubProj> projList = this.projBiz.searchProjByProjFlows(pjFlowList);
			Map<String,PubProj>projMap = new HashMap<String,PubProj>();
			if (projList != null && projList.size()>0) {
				for (PubProj proj:projList) {
					String projFlow = proj.getProjFlow();
					projMap.put(projFlow, proj);
				}
			}
			model.addAttribute("projMap", projMap);
		}
		
		model.addAttribute("pjFlowList", pjFlowList);
		model.addAttribute("irbMap", irbMap);
		model.addAttribute("trackMap", trackMap);
		return "irb/secretary/follow/list";
	}
	@RequestMapping(value={"/reviewList"},method={RequestMethod.GET})
	public String  reviewList(String projFlow,String isGcp, Model model){
		PubProj proj = projBiz.readProject(projFlow);
		if (proj != null) {
			model.addAttribute("projName", proj.getProjName());
		}
		IrbApply temp = new IrbApply();
		temp.setProjFlow(projFlow);
		List<IrbApply> irbApplyList = irbResearcherBiz.searchIrbApplyList(projFlow);
		Map<String,List<IrbUser>> committeeMap = new HashMap<String,List<IrbUser>>();
		Map<String,String> fileTypeMap = new HashMap<String,String>();
		if (irbApplyList != null && irbApplyList.size() > 0) {
			for (IrbApply irb:irbApplyList) {
				String irbFlow = irb.getIrbFlow();
				List<IrbUser> irbUserList = irbUserBiz.searchCommitteeList(irbFlow);
				List<IrbUser> filterList = null;	//过滤相同的人 如：主审委员方案和知情同意为同一个人
				List<String> userFlowList = new ArrayList<String>();
				if (irbUserList != null && irbUserList.size() > 0) {
					for (IrbUser user:irbUserList) {
						if (!userFlowList.contains(user.getUserFlow())) {
							if (filterList == null) {
								filterList = new ArrayList<IrbUser>();
							}
							filterList.add(user);
							userFlowList.add(user.getUserFlow());
						}
					}
				}
				committeeMap.put(irbFlow, filterList);
				
				String irbStage = irb.getIrbStageId();
				if (IrbStageEnum.Archive.getId().equals(irbStage) || IrbStageEnum.Filing.getId().equals(irbStage)) {//已完成传达决定
					if (StringUtil.isNotBlank(irb.getApproveDate())) {
						fileTypeMap.put(irbFlow, IrbRecTypeEnum.ApproveFile.getId());
					} else {
						fileTypeMap.put(irbFlow, IrbRecTypeEnum.OpinionFile.getId());
					}
				}
			}
		}
		model.addAttribute("irbApplyList", irbApplyList);
		model.addAttribute("committeeMap", committeeMap);
		model.addAttribute("fileTypeMap", fileTypeMap);
		if(GlobalConstant.FLAG_Y.equals(isGcp)){
			return "gcp/proj/irb/reviewList";
		}
		return "irb/secretary/follow/reviewList";
	}
	
	/**
	 * 形式审查主界面
	 * @return
	 */
	@RequestMapping(value="/showFormcheck")
	public String showFormcheck(String irbFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			IrbApply findApply = this.irbApplyBiz.queryByFlow(irbFlow);
			ApplyFileTemp applyFile = null;
			if(findApply!=null){
				String irbTypeId = findApply.getIrbTypeId();
				String projCategoryId = null;
				if(IrbTypeEnum.Init.getId().equals(irbTypeId)){//初始审查
					PubProj proj = this.projBiz.readProject(findApply.getProjFlow());
					if(proj!=null){
						projCategoryId = proj.getProjCategoryId();
					}
				}
				applyFile = new ApplyFileTemp();
				applyFile.setIrbType(irbTypeId);
				applyFile.setPjType(projCategoryId);
				List<ApplyFileTemp> fileList = this.irbCfgBiz.queryApplyFileList(applyFile);
				
				/*过滤已传文件，未传文件*/
				IrbRec irbRec = new IrbRec();
				irbRec.setIrbFlow(irbFlow);
				List<IrbApplyFileForm> uploadFiles = this.irbRecBiz.queryUploadFile(irbRec);//已传文件
				List<String> uploadFileIds = new ArrayList<String>();
				boolean allConfirm = true;//已提交的文件是否全部确认
				if(uploadFiles != null && !uploadFiles.isEmpty()){
					for (IrbApplyFileForm form : uploadFiles) {
						uploadFileIds.add(form.getFileTempId());
						if(allConfirm){
							allConfirm = form.isConfirm();
						}
					}
				}
				
				List<ApplyFileTemp> notUploadFiles = new ArrayList<ApplyFileTemp>();//未传文件
				Map<String,String> versionMap = new HashMap<String,String>();
				if (fileList != null && fileList.size() > 0) {
					for (ApplyFileTemp file : fileList) {
						if(!uploadFileIds.contains(file.getId())){
							notUploadFiles.add(file);
						}
						versionMap.put(file.getId()+"_version", file.getVersion());
						versionMap.put(file.getId()+"_versionDate", file.getVersionDate());
					}
				}
				
				model.addAttribute("uploadFiles", uploadFiles);
				model.addAttribute("notUploadFiles", notUploadFiles);
				model.addAttribute("versionMap", versionMap);
				model.addAttribute("findApply", findApply);
				model.addAttribute("allConfirm", allConfirm);
			}
		}
		return "irb/secretary/handle/formcheck";
	}
	/**
	 * 确认已传文件
	 * @param fileIds 文件id数组
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/fileConfirm")
	@ResponseBody
	public String fileConfirm(String[] fileIds,String irbFlow) throws Exception{
		if(fileIds!=null&&fileIds.length>0&&StringUtil.isNotBlank(irbFlow)){
			int result = this.secretaryBiz.fileConfirm(fileIds, irbFlow);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 生成补充修改通知
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/createNotice")
	@ResponseBody
	public String createNotice(@RequestBody IrbNoticeForm form) throws Exception{
		if(form!=null){
			String irbFlow = form.getIrbFlow();
			if(StringUtil.isNotBlank(irbFlow)){
				IrbApply curApply = this.irbApplyBiz.queryByFlow(irbFlow);
				if(curApply!=null){
					IrbRec irbRec = new IrbRec();
					irbRec.setProjFlow(curApply.getProjFlow());
					irbRec.setIrbFlow(curApply.getIrbFlow());
					irbRec.setIrbStageId(curApply.getIrbStageId());
					irbRec.setIrbStageName(curApply.getIrbStageName());
					irbRec.setRecTypeId(IrbRecTypeEnum.AddModNotice.getId());
					irbRec.setRecTypeName(IrbRecTypeEnum.AddModNotice.getName());
					int result = this.secretaryBiz.saveApplyAndModifyFile(form, irbRec);
					if(result==GlobalConstant.ONE_LINE){
						return GlobalConstant.OPRE_SUCCESSED;
					}
				}
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 受理通知
	 * @param irbFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/receiptNotice")
	public String  receiptNotice(String irbFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			IrbRec irbRec = new IrbRec();
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
			List<IrbApplyFileForm> irbFileList = this.irbRecBiz.queryUploadFile(irbRec);
			boolean allConfirm = this.checkAllConfirm(null, irbFileList);//上传的文件是否全部确认
			if(allConfirm){//全部确认
				IrbApply curApply = this.irbApplyBiz.queryByFlow(irbFlow);
				if(curApply!=null){
					PubProj proj = this.projBiz.readProject(curApply.getProjFlow());
					model.addAttribute("proj", proj);
					model.addAttribute("curApply", curApply);
					model.addAttribute("irbFileList", irbFileList);
				}
				IrbProcess process = this.secretaryBiz.queryLatestHandlePro(irbFlow);
				model.addAttribute("process", process);
				return "/irb/secretary/handle/receiptNotice";
			}
			//没有全部确认
			return "redirect:/irb/secretary/handle?irbFlow="+irbFlow+"&msg=notAllCheck";
		}
		return "redirect:/irb/secretary/list?stage="+IrbStageEnum.Handle.getId();
	}
	/**
	 * 保存受理通知
	 * @param form
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveRecNotice")
	@ResponseBody
	public String  saveRecNotice(IrbReceiptNoticeForm form,Model model){
		if(form!=null){
			int result = this.secretaryBiz.saveRecNotice(form);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 检查已提交文件是否全部确认
	 * @param irbFlow
	 * @param irbFileList
	 * @return
	 * @throws Exception
	 */
	public boolean checkAllConfirm(String irbFlow,List<IrbApplyFileForm> irbFileList) throws Exception{
		if(irbFileList==null&&StringUtil.isNotBlank(irbFlow)){
			IrbRec irbRec = new IrbRec();
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.ApplyFile.getId());
			irbFileList = this.irbRecBiz.queryUploadFile(irbRec);
		}
		boolean allConfirm = false;//上传的文件是否全部确认
		if(irbFileList!=null&&!irbFileList.isEmpty()){
			for (IrbApplyFileForm form : irbFileList) {
				allConfirm = true;
				allConfirm = allConfirm && form.isConfirm();
				if(!allConfirm){
					break;
				}
			}
		}
		return allConfirm;
	}
	/**
	 * 前端检查上传文件是否全部确认
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/checkAllConfirmJson")
	@ResponseBody
	public String checkAllConfirmJson(String irbFlow) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			boolean allConfirm = this.checkAllConfirm(irbFlow, null);
			if(allConfirm){
				return GlobalConstant.FLAG_Y;
			}
		}
		return GlobalConstant.FLAG_N;
	}
	/**
	 * 审查方式界面
	 * @param irbFlow
	 * @return
	 */
	@RequestMapping(value="/showCheckWay")
	public String showCheckWay(String irbFlow,Model model){
		if(StringUtil.isNotBlank(irbFlow)){
			IrbApply curIrbApply = this.irbApplyBiz.queryByFlow(irbFlow);
			if(curIrbApply!=null&&StringUtil.isNotBlank(curIrbApply.getIrbNo())){
				IrbInfo info = new IrbInfo();
				info.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				List<IrbInfo> infoList = this.irbInfoBiz.queryInfo(info);
				IrbInfo irbInfo = this.irbInfoBiz.queryInfo(curIrbApply.getIrbInfoFlow());
				model.addAttribute("infoList", infoList);
				model.addAttribute("curIrbApply", curIrbApply);
				model.addAttribute("irbInfo", irbInfo);
				return "/irb/secretary/handle/checkWay";
			}
			return "redirect:/irb/secretary/handle?irbFlow="+irbFlow;
		}
		return "redirect:/irb/secretary/list?stage="+IrbStageEnum.Handle.getId();
	}
	/**
	 * 保存审查方式
	 * @param irbApply
	 * @return
	 */
	@RequestMapping("/saveCheckWay")
	@ResponseBody
	public String saveCheckWay(IrbApply irbApply){
		if(irbApply!=null){
			irbApply.setReviewWayName(IrbReviewTypeEnum.getNameById(irbApply.getReviewWayId()));
			irbApply.setMeetingArrange(irbApply.getReviewWayId());
			int result = this.irbApplyBiz.edit(irbApply);
			if(result == GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 显示选择主审/顾问
	 * @param irbFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/chooseMember")
	public String chooseMember(String irbFlow,Model model){
		if(StringUtil.isNotBlank(irbFlow)){
			IrbApply curIrbApply = this.irbApplyBiz.queryByFlow(irbFlow);
			if(curIrbApply!=null&&StringUtil.isNotBlank(curIrbApply.getReviewWayId())){
				if(StringUtil.isNotBlank(curIrbApply.getIrbInfoFlow())){
					IrbInfoUser user = new IrbInfoUser();
					user.setIrbInfoFlow(curIrbApply.getIrbInfoFlow());
					user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
					List<IrbInfoUser> allUsers = this.irbInfoUserBiz.queryUserList(user);
					if(allUsers!=null&&!allUsers.isEmpty()){
						List<IrbInfoUser> ndUsers = new ArrayList<IrbInfoUser>();//非独立顾问
						
						String consulRoleFlow = null;//独立顾问的角色流水号
						SysRole sysRole = new SysRole();
						sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
						sysRole.setRoleLevelId(RoleLevelEnum.SysLevel.getId());
						sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						sysRole.setRoleName(GlobalConstant.INDEPENDENT_MEMBER);
						List<SysRole> roleList = roleBiz.search(sysRole);
						if (roleList != null && roleList.size() > 0) {
							consulRoleFlow = roleList.get(0).getRoleFlow();
						}
						if (allUsers != null && allUsers.size() > 0) {
							for (IrbInfoUser irbInfoUser : allUsers) {
								if(!consulRoleFlow.equals(irbInfoUser.getRoleFlow())){
									if(getItemCount(irbInfoUser,ndUsers)==0){
										ndUsers.add(irbInfoUser);
									}
								}
							}
						}
						model.addAttribute("ndUsers", ndUsers);
					}
					
					IrbUser temp = new IrbUser();
					temp.setIrbFlow(irbFlow);
					temp.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
					List<IrbUser> irbUserList = this.irbUserBiz.queryList(temp);
					List<IrbUser> committeePROList = null;
					List<String> committeePROFlowList = new ArrayList<String>();
					List<IrbUser> committeeList = null;
					List<String> committeeFlowList = new ArrayList<String>();
					if (irbUserList != null && irbUserList.size()>0) {
						for (IrbUser tem :irbUserList) {
							if(IrbAuthTypeEnum.CommitteePRO.getId().equals(tem.getAuthId())){	//主审委员_方案
								if (committeePROList == null) {
									committeePROList = new ArrayList<IrbUser>();
								}
								committeePROList.add(tem);
								committeePROFlowList.add(tem.getUserFlow());
							} else if (IrbAuthTypeEnum.CommitteeICF.getId().equals(tem.getAuthId())){	//主审委员_知情同意
								model.addAttribute("committeeICF",tem);
							}else if (IrbAuthTypeEnum.Consultant.getId().equals(tem.getAuthId())){	//独立顾问
								model.addAttribute("consultant",tem);
								model.addAttribute("authNote", tem.getAuthNote());	//咨询问题
							} else{
								if (committeeList == null) {
									committeeList = new ArrayList<IrbUser>();
								}
								committeeList.add(tem);
								committeeFlowList.add(tem.getUserFlow());
							}
						}
					}
					model.addAttribute("committeePROList",committeePROList);	//主审委员_方案
					model.addAttribute("committeePROFlowList",committeePROFlowList);	//主审委员_方案
					model.addAttribute("committeeList",committeeList);	//主审委员
					model.addAttribute("committeeFlowList",committeeFlowList);	//主审委员
				}
				model.addAttribute("curIrbApply", curIrbApply);
				return "/irb/secretary/handle/chooseMember";
			}
			return "redirect:/irb/secretary/handle?irbFlow="+irbFlow;
		}
		return "redirect:/irb/secretary/list?stage="+IrbStageEnum.Handle.getId();
	}
	private int getItemCount(IrbInfoUser user,List<IrbInfoUser> users){
		int count = 0;
		if(user!=null&&users!=null&&!users.isEmpty()){
			for (IrbInfoUser irbInfoUser : users) {
				if(irbInfoUser.getUserFlow().equals(user.getUserFlow())){
					count++;
				}
			}
		}
		return count;
	}
	/**
	 * 保存主审/顾问
	 * @param userFlow_fa
	 * @param userFlow_zqty
	 * @param userFlow_zswy
	 * @param userFlow_dlgw
	 * @param authNote
	 * @param irbFlow
	 * @return
	 */
	@RequestMapping(value="/saveChooseMember")
	@ResponseBody
	public String saveChooseMember(String[] userFlow_fa,String userFlow_zqty,String[] userFlow_zswy,String userFlow_dlgw,String authNote,String irbFlow,String dlgw,String operType){
		if(StringUtil.isNotBlank(irbFlow)){
			IrbApply curApply = this.irbApplyBiz.queryByFlow(irbFlow);
			if(curApply!=null){
				String projFlow = curApply.getProjFlow();
				//保存主审委员-方案
				if(userFlow_fa!=null && userFlow_fa.length>0){
					List<IrbUser> committeePROList = this.irbUserBiz.searchCommitteePROList(irbFlow);
					List<String> committeePROFlowList = new ArrayList<String>();
					Arrays.sort(userFlow_fa); //首先对数组排序
					if (committeePROList != null && committeePROList.size() > 0) {
						for (IrbUser user:committeePROList) {
							String userFlow = user.getUserFlow();
							committeePROFlowList.add(userFlow);
							if (Arrays.binarySearch(userFlow_fa, userFlow)<0) {	
								user.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
								this.irbUserBiz.edit(user);	
							}
						}
					}
					for (String userFlow : userFlow_fa) {
						if (!committeePROFlowList.contains(userFlow)) {
							saveMember(userFlow, IrbAuthTypeEnum.CommitteePRO, projFlow, irbFlow, null);
						}
					}
					
				}
				//保存主审委员-知情同意
				if (StringUtil.isNotBlank(userFlow_zqty)) {
					saveMember(userFlow_zqty, IrbAuthTypeEnum.CommitteeICF, projFlow, irbFlow, null);
				} else {
					IrbUser user = this.irbUserBiz.searchCommitteeICF(irbFlow);
					if (user != null && StringUtil.isNotBlank(user.getUserFlow())) {
						user.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						this.irbUserBiz.edit(user);
					}
				}
				//保存主审委员-知情同意
				if(userFlow_zswy!=null && userFlow_zswy.length>0){
					List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);
					List<String> committeeFlowList = new ArrayList<String>();
					Arrays.sort(userFlow_zswy); //首先对数组排序
					if (committeeList != null && committeeList.size() > 0) {
						for (IrbUser user:committeeList) {
							String userFlow = user.getUserFlow();
							committeeFlowList.add(userFlow);
							if (Arrays.binarySearch(userFlow_zswy, userFlow)<0) {	
								user.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
								this.irbUserBiz.edit(user);	
							}
						}
					}
					for (String userFlow : userFlow_zswy) {
						if (!committeeFlowList.contains(userFlow)) {
							saveMember(userFlow, IrbAuthTypeEnum.Committee, projFlow, irbFlow, null);
						}
					}
					
				}
				//保存独立顾问
				saveMember(userFlow_dlgw, IrbAuthTypeEnum.Consultant, projFlow, irbFlow, authNote);
				if (GlobalConstant.RECORD_STATUS_N.equals(dlgw)) {	//独立顾问选择“无”则删除原独立顾问
					IrbUser user = this.irbUserBiz.searchConsultant(irbFlow);
					if (user != null && StringUtil.isNotBlank(user.getUserFlow())) {
						user.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						this.irbUserBiz.edit(user);
					}
				}
				if (!"edit".equals(operType)) {
					//更改apply状态
					curApply.setIrbStageId(IrbStageEnum.Review.getId());
					curApply.setIrbStageName(IrbStageEnum.Review.getName());
					this.irbApplyBiz.changeStage(curApply);
				}
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	private void saveMember(String userFlow,IrbAuthTypeEnum authTypeEnum,String projFlow,String irbFlow,String authNote){
		if(StringUtil.isNotBlank(userFlow)){
			boolean old = false;
			//删除原主审委员_知情同意、独立顾问
			String authId = authTypeEnum.getId();
			if (IrbAuthTypeEnum.CommitteeICF.getId().equals(authId) || IrbAuthTypeEnum.Consultant.getId().equals(authId)) {
				IrbUser temp = new IrbUser();
				temp.setIrbFlow(irbFlow);
				temp.setAuthId(authId);
				temp.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				List<IrbUser> irbUserList = this.irbUserBiz.queryList(temp);
				if (irbUserList != null && irbUserList.size() > 0) {
					IrbUser oldUser = irbUserList.get(0);
					if (userFlow.equals(oldUser.getUserFlow())) {
						old = true;
						if(authTypeEnum.equals(IrbAuthTypeEnum.Consultant)){//独立顾问  修改咨询问题
							oldUser.setAuthNote(authNote);
							this.irbUserBiz.edit(oldUser);
						}
					} else {
						oldUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						this.irbUserBiz.edit(oldUser);
					}
				}
			}
			if (!old) {
				logger.debug("=userFlow=="+userFlow);
				SysUser sysUser = this.sysUserBiz.readSysUser(userFlow);
				IrbUser user = new IrbUser();
				user.setProjFlow(projFlow);
				user.setIrbFlow(irbFlow);
				user.setUserFlow(userFlow);
				if(sysUser!=null){
					user.setUserName(sysUser.getUserName());
				}
				user.setAuthId(authTypeEnum.getId());
				user.setAuthName(authTypeEnum.getName());
				user.setAuthTime(DateUtil.getCurrDateTime());
				user.setAuthUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				if(authTypeEnum.equals(IrbAuthTypeEnum.Consultant)){//独立顾问
					user.setAuthNote(authNote);
				}
				this.irbUserBiz.edit(user);
			}
		}
	}
	/**
	 * 保存快审主审综合意见
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveQuickOpinion")
	@ResponseBody
	public String saveQuickOpinion(IrbQuickOpinionForm form) throws Exception{
		if(form!=null){
			String reviewWayId = form.getReviewWayId();
			if(IrbReviewTypeEnum.Meeting.getId().equals(reviewWayId)){//提交会议审查
				form.setIrbDecisionId(null);
				form.setReviewOpinion(null);
			}
			int result =  this.secretaryBiz.saveQuickOpinion(form);
			IrbApply findApply = this.irbApplyBiz.queryByFlow(form.getIrbFlow());
			if(findApply!=null&&result==GlobalConstant.ONE_LINE){
				findApply.setMeetingArrange(reviewWayId);
				if(IrbReviewTypeEnum.Fast.getId().equals(reviewWayId)){//提交会议报告
					/*插入process*/
					IrbProcess process = new IrbProcess();
					process.setOperTime(form.getOperTime());
					this.irbResearcherBiz.saveProcess(findApply, process);
						
					/*更新审查决定、阶段状态*/
					findApply.setIrbDecisionId(form.getIrbDecisionId());
					findApply.setIrbDecisionName(IrbDecisionEnum.getNameById(form.getIrbDecisionId()));
					findApply.setIrbStageId(IrbStageEnum.Decision.getId());//传达决定
					findApply.setIrbStageName(IrbStageEnum.Decision.getName());
					if(StringUtil.isNotBlank(form.getIrbDecisionId())){	
						findApply.setIrbReviewDate(form.getOperTime());	//审查日期
					}
					this.irbApplyBiz.changeStage(findApply);
				}else{//提交会议审查
					this.irbApplyBiz.edit(findApply);
				}
			}
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 传达决定详细
	 * @param irbFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/decisionDetail")
	public String  decisionDetail(String irbFlow, Model model) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			IrbForm irbForm = this.secretaryBiz.readIrbForm(irbFlow);
			if(irbForm!=null&&irbForm.getIrb()!=null){
				IrbApply curApply = irbForm.getIrb();
				String fileType = this.secretaryBiz.checkFileType(curApply);//判断是批件还是意件
				String meetingFlow = curApply.getMeetingFlow();
				IrbMeeting meeting = this.irbMeetingBiz.readIrbMeeting(meetingFlow);//审查会议
				String fastId = IrbReviewTypeEnum.Fast.getId();
				//审查委员
				if (fastId.equals(curApply.getReviewWayId()) && fastId.equals(curApply.getMeetingArrange())) {	//快审并且没有提交会议审查
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
					model.addAttribute("filterUserList", filterUserList);
				} else {	//会审或者快审提交会审
					List<IrbMeetingUser> filterUserList = this.irbMeetingBiz.filterVoteUserList(meetingFlow);//审查委员（投票人员）
					model.addAttribute("filterUserList", filterUserList);
				}
			    /*主席委员*/
			    String irbInfoFlow = curApply.getIrbInfoFlow();
				IrbInfo irbInfo = this.irbInfoBiz.queryInfo(irbInfoFlow);
			    IrbInfoUser user = new IrbInfoUser();
			    user.setIrbInfoFlow(irbInfoFlow);
			    user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			    user.setRoleFlow(InitConfig.getSysCfg(GlobalConstant.IRB_SIGN_ROLE_FLOW));
			    user.setIrbInfoFlow(irbInfoFlow);
			    List<IrbInfoUser> infoUserList = this.irbInfoUserBiz.queryUserList(user);
			    
			    IrbDecisionDetailForm form = this.secretaryBiz.readDecDetail(irbFlow, fileType);//已保存的记录
				model.addAttribute("fileType", fileType);
				model.addAttribute("meeting", meeting);
				model.addAttribute("irbInfo", irbInfo);
				model.addAttribute("infoUserList", infoUserList);
				model.addAttribute("form", form);
				
				boolean haveApprove = this.secretaryBiz.isHaveApprove(curApply);
				model.addAttribute("haveApprove", haveApprove);
				
				if (form == null || form.getApplyFileForms() == null) {//未编辑审查文件，默认显示本次审查已确认文件
					List<IrbApplyFileForm> fileList =  this.irbRecBiz.queryConfirmFile(irbFlow);//本次审查已确认文件
					model.addAttribute("fileList", fileList);
				}
			}
			model.addAttribute("irbForm", irbForm);
		}
		return "irb/secretary/decision/approveFile";
	}
	
	/**
	 * 计算跟踪审查日期
	 */
	@RequestMapping(value="/showTrackDate")
	@ResponseBody
	public String  showTrackDate(String irbDecisionDate, String trackFrequency) throws Exception{
		String trackDate = "";
		if (StringUtil.isNotBlank(irbDecisionDate) && StringUtil.isNotBlank(trackFrequency)) {
			trackDate = DateTrans.newDateOfAddMonths(irbDecisionDate, Integer.parseInt(trackFrequency));
		}
		return trackDate;
	}
	
	/**
	 * 保存传达决定内容
	 * @param irbFlow
	 * @param form
	 * @return
	 */
	@RequestMapping(value="/saveDecDetail")
	@ResponseBody
	public String  saveDecDetail(String irbFlow, IrbDecisionDetailForm form) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)&&form!=null){
			int result = this.secretaryBiz.saveDecDetail(irbFlow, form);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 传达决定改状态
	 * @param irbFlow
	 * @return
	 */
	@RequestMapping(value="/changeApplyStage")
	@ResponseBody
	public String  changeApplyStage(String irbFlow,String date){
		if(StringUtil.isNotBlank(irbFlow)){
			IrbApply apply = this.irbApplyBiz.queryByFlow(irbFlow);
			/*插入process*/
			IrbProcess process = new IrbProcess();
			process.setOperTime(date);
			this.irbResearcherBiz.saveProcess(apply, process);
			
			apply.setIrbStageId(IrbStageEnum.Archive.getId());
			apply.setIrbStageName(IrbStageEnum.Archive.getName());
			this.irbApplyBiz.changeStage(apply);//改状态
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value="/modIrbApply",method={RequestMethod.POST})
	@ResponseBody
	public String  modIrbApply(IrbApply apply){
		if(StringUtil.isNotBlank(apply.getIrbFlow())){
			String validityDate = "";
			if (StringUtil.isNotBlank(apply.getApproveDate()) && StringUtil.isNotBlank(apply.getApproveValidity())) {
				validityDate = DateTrans.newDateOfAddMonths(apply.getApproveDate(), Integer.parseInt(apply.getApproveValidity()));
				apply.setApproveValidityDate(validityDate);
			}
			this.irbApplyBiz.modifyIrbApply(apply);//改状态
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	@RequestMapping(value="/reApply",method={RequestMethod.GET})
	@ResponseBody
	public String  reApply(IrbApply apply){
		if(StringUtil.isNotBlank(apply.getIrbFlow())){
			apply = irbApplyBiz.queryByFlow(apply.getIrbFlow());
			apply.setIrbNo("");
			apply.setIrbAcceptedDate("");
			apply.setReviewWayId("");
			apply.setReviewWayName("");
			//apply.setIrbInfoFlow("");
			apply.setIrbStageId(IrbStageEnum.Apply.getId());
			apply.setIrbStageName(IrbStageEnum.Apply.getName());
			this.irbApplyBiz.modifyIrbApply(apply);//改状态
			//irbResearcherBiz.handProcess(apply);
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value={"/userMain"},method={RequestMethod.GET,RequestMethod.POST})
	public String  userMain(String deptFlow, SysUser search,String type,Model model){
		IrbApply curApply = (IrbApply) this.getSessionAttribute(GlobalConstant.CURR_IRB);//当前apply
		String projFlow = "";
		String researcherFlow = "";
		if (curApply != null) {
			projFlow = curApply.getProjFlow();
			
			String roleFlow = InitConfig.getSysCfg("researcher_role_flow");
			PubProjUser pjUserSearch = new PubProjUser();
			pjUserSearch.setProjFlow(projFlow);
			pjUserSearch.setRoleFlow(roleFlow);
			List<PubProjUser> pjUserList = pjUserBiz.search(pjUserSearch);
			if (pjUserList !=  null && pjUserList.size()>0) {
				researcherFlow = pjUserList.get(0).getUserFlow();
			}
		}
		model.addAttribute("researcherFlow", researcherFlow);	
		
		PubProjUser pubProjUserSearch = new PubProjUser();
		if (StringUtil.isNotBlank(projFlow)) {
			pubProjUserSearch.setProjFlow(projFlow);
		}
		List<PubProjUser> pubProjUserList = pjUserBiz.search(pubProjUserSearch);
		Map<String,List<PubProjUser>> pubProjUserMap  = new HashMap<String, List<PubProjUser>>();
		for(PubProjUser pubProjUser : pubProjUserList){
			String userFlow = pubProjUser.getUserFlow();
			if(pubProjUserMap.containsKey(userFlow)){
				List<PubProjUser> list = pubProjUserMap.get(userFlow);
				list.add(pubProjUser);
			}else{
				List<PubProjUser> list = new ArrayList<PubProjUser>();
				list.add(pubProjUser);
				pubProjUserMap.put(userFlow, list);
			}
		}			
		model.addAttribute("pubProjUserMap", pubProjUserMap);	
		
		if (StringUtil.isNotBlank(type) && type.equals("search")) {
			model.addAttribute("userName", search.getUserName());
			model.addAttribute("deptFlow", search.getDeptFlow());
		} else {
			model.addAttribute("deptFlow", deptFlow);
			search.setDeptFlow(deptFlow);
		}
		
		//如果用户没有输入查询条件
		String temp = StringUtil.defaultString(search.getUserName())
				     +StringUtil.defaultString(search.getDeptFlow());
		if(StringUtil.isNotBlank(temp)){
			search.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			List<SysUser> sysUserList = sysUserBiz.searchUser(search);
			model.addAttribute("sysUserList",sysUserList);
		}
		
		List<SysDept> deptList = irbResearcherBiz.searchSysDept(GlobalContext.getCurrentUser().getOrgFlow());
		model.addAttribute("deptList", deptList);
		return "irb/secretary/handle/userMain";
	}
	/**
	 * 新增存档文件
	 * @param form
	 * @param file
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/addApplyFile")
	public String addApplyFile(IrbArchiveForm form,@RequestParam(value="file",required=true)MultipartFile file,Model model)throws Exception{
		String msg = GlobalConstant.SAVE_FAIL;
		PubFile pubFile = null;
		if(file.getSize() > 0 && form!=null){//附件
			pubFile = new PubFile();
			pubFile.setFileName(form.getName());
			byte[] b = new byte[(int) file.getSize()]; 
			file.getInputStream().read(b);
			pubFile.setFileContent(b); 
			String[] nameArray=file.getOriginalFilename().split("\\.");
			pubFile.setFileType(nameArray[nameArray.length-1]);
			pubFile.setFileSuffix(nameArray[nameArray.length-1]);
		}
		form.setRecType(IrbRecTypeEnum.ApplyFile.getId());
		int result = this.secretaryBiz.addApplyFile(form, pubFile);
		if(result==GlobalConstant.ONE_LINE){
			msg = GlobalConstant.SAVE_SUCCESSED;
		}
		model.addAttribute("msg", msg);
		return "irb/secretary/archive/file";
	}
	/**
	 * 显示存档文件新增界面
	 * @return
	 */
	@RequestMapping(value="/showAddApplyFile")
	public String showAddApplyFile(){
		return "irb/secretary/archive/file";
	}
	/**
	 * 删除存档文件
	 * @param ids
	 * @param irbFlow
	 * @return
	 */
	@RequestMapping(value="/delApplyFile")
	@ResponseBody
	public String delApplyFile(String[]ids,String irbFlow) throws Exception{
		if(ids!=null&&ids.length>0&&StringUtil.isNotBlank(irbFlow)){
			int result = this.irbRecBiz.operApplyFile(ids, irbFlow,"del");
			if(result == GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	/**
	 * 存档文件排序
	 * @param ids
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sortApplyFile")
	@ResponseBody
	public String sortApplyFile(String[]ids,String irbFlow) throws Exception{
		if(ids!=null&&ids.length>0&&StringUtil.isNotBlank(irbFlow)){
			int result = this.irbRecBiz.operApplyFile(ids, irbFlow,"sort");
			if(result == GlobalConstant.ONE_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value="/modIrbStage")
	public String modIrbStage() throws Exception{
		return "irb/secretary/handle/modIrbStage";
	}
	
	@RequestMapping(value={"/selReviewFile"},method={RequestMethod.GET})
	public String selReviewFile(String irbFlow,String fileType,Model model) throws Exception{
		IrbApply curApply = irbApplyBiz.queryByFlow(irbFlow);
		
		IrbDecisionDetailForm decisionForm = this.secretaryBiz.readDecDetail(irbFlow, fileType);//已保存的记录
		List<String> existFileFlow = new ArrayList<String>();
		if (decisionForm != null && decisionForm.getApplyFileForms() != null) {
			List<IrbApplyFileForm> fileForms = decisionForm.getApplyFileForms();
			for (IrbApplyFileForm fileForm:fileForms) {
				if (StringUtil.isNotBlank(fileForm.getFileFlow())) {
					existFileFlow.add(fileForm.getFileFlow());
				} else {
					existFileFlow.add(fileForm.getUrl());
				}
			}
		}
		
		List<IrbApply> applyList = researcherBiz.searchIrbApplyList(curApply.getProjFlow());
		Map<String,List<IrbApplyFileForm>> fileMap = new HashMap<String,List<IrbApplyFileForm>>();
		if(applyList!=null&&!applyList.isEmpty()){
			for (IrbApply irb : applyList) {
				List<IrbApplyFileForm> fileList = irbRecBiz.queryConfirmFile(irb.getIrbFlow());
				fileMap.put(irb.getIrbFlow(), fileList);
			}
		}
		
		model.addAttribute("irbFlow", irbFlow);
		model.addAttribute("existFileFlow", existFileFlow);
		model.addAttribute("applyList", applyList);
		model.addAttribute("fileMap", fileMap);
		model.addAttribute("fileType", fileType);
		
		return "irb/secretary/decision/reviewFile";
	}
	
	@RequestMapping(value="/saveReviewFile")
	@ResponseBody
	public String saveReviewFile(@RequestBody IrbDecisionDetailForm decisionForm) throws Exception{
		if(decisionForm!=null){
			int result = this.secretaryBiz.saveReviewFile(decisionForm);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
}

