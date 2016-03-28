package com.pinde.sci.ctrl.irb;


import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbCommitteeBiz;
import com.pinde.sci.biz.irb.IIrbInfoBiz;
import com.pinde.sci.biz.irb.IIrbMeetingBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.IIrbSecretaryBiz;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.irb.IrbApplyFileTypeEnum;
import com.pinde.sci.enums.irb.IrbAuthTypeEnum;
import com.pinde.sci.enums.irb.IrbDecisionEnum;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.form.irb.IrbApplyFileForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.form.irb.IrbVoteForm;
import com.pinde.sci.form.irb.irbMeetingForm;
import com.pinde.sci.model.irb.IrbForm;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbMeeting;
import com.pinde.sci.model.mo.IrbRec;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/irb/committee")
public class IrbCommitteeController extends GeneralController{    
	@Autowired
	private IIrbCommitteeBiz committeeBiz;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IIrbSecretaryBiz secretaryBiz;
	@Autowired
	private IIrbRecBiz recBiz;
	@Autowired
	private IIrbUserBiz irbUserBiz;
	@Autowired
	private IIrbMeetingBiz irbMeetingBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IIrbInfoBiz irbInfoBiz;
	
	private static Logger logger = LoggerFactory.getLogger(IrbCommitteeController.class);

	@RequestMapping(value={"/index"},method={RequestMethod.GET})
	public String index(Model model){
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		String meetingDate = "";	//����������Ϣ�������������
		String meetingFlow ="";
		int meetingCount = 0;		//�μӻ�����
		irbMeetingForm	mForm = new irbMeetingForm();
		mForm.setUserFlow(userFlow);
		List<IrbMeeting> mList = this.irbMeetingBiz.searchList(mForm);
		if (mList != null && mList.size()>0) {
			meetingCount = mList.size();
			IrbMeeting meeting = mList.get(0);
			meetingDate = meeting.getMeetingDate();
			meetingFlow = meeting.getMeetingFlow();
		}
		model.addAttribute("meetingDate", meetingDate);
		model.addAttribute("meetingFlow", meetingFlow);
		model.addAttribute("meetingCount", meetingCount);
		
		int reviewCount = 0;	//������Ŀ��
		List<String> authIds = new ArrayList<String>();
		authIds.add(IrbAuthTypeEnum.CommitteePRO.getId());
		authIds.add(IrbAuthTypeEnum.CommitteeICF.getId());
		authIds.add(IrbAuthTypeEnum.Committee.getId());
		authIds.add(IrbAuthTypeEnum.Consultant.getId());
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userFlow", userFlow);
		paramMap.put("authIds", authIds);
		List<IrbApply> irbApplyList = irbApplyBiz.searchCommitteeIrbList(paramMap);
		if (irbApplyList != null) {
			reviewCount = irbApplyList.size();
		}
		model.addAttribute("reviewCount", reviewCount);
		
		paramMap.put("irbStageId", IrbStageEnum.Review.getId());
		List<IrbApply> unReviewIrbs = irbApplyBiz.searchUnReviewIrbs(paramMap);
		model.addAttribute("unReviewIrbs", unReviewIrbs);
		
		return "irb/view/committee";
	}
	
	/**
	 * ��Ŀ����б�
	 * @param proj
	 * @param irbApply
	 * @param role
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list/{role}")
	public String  list(PubProj proj,IrbApply irbApply,@PathVariable String role,String reviewStatus,Model model){
		String view = "irb/committee/irbSerList";
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		List<IrbApply> irbApplyList = null;
		Map<String,Object> paramMap = new HashMap<String, Object>();
		if (StringUtil.isBlank(reviewStatus)) {
			reviewStatus = "unreview";
		}
		paramMap.put("reviewStatus", reviewStatus);
		if(GlobalConstant.IRB_COMMITTEE_USER.equals(role)){//ίԱ
			view = "irb/committee/irbList";
			List<String> authIds = new ArrayList<String>();
			authIds.add(IrbAuthTypeEnum.CommitteePRO.getId());
			authIds.add(IrbAuthTypeEnum.CommitteeICF.getId());
			authIds.add(IrbAuthTypeEnum.Committee.getId());
			authIds.add(IrbAuthTypeEnum.Consultant.getId());
			paramMap.put("userFlow", userFlow);
			paramMap.put("authIds", authIds);
			paramMap.put("meetingDate", irbApply.getMeetingDate());
			String projName = irbApply.getProjName();
			if (StringUtil.isNotBlank(projName)) {
				projName = "%"+irbApply.getProjName()+"%";
			}
			paramMap.put("projName", projName);
			paramMap.put("irbTypeId", irbApply.getIrbTypeId());
			irbApplyList = irbApplyBiz.searchCommitteeIrbList(paramMap);
		} else {
			irbApply.setIrbStageId(IrbStageEnum.Review.getId());
			irbApplyList = irbApplyBiz.searchIrbs(irbApply);
		}
		model.addAttribute("irbApplyList", irbApplyList);
		
		List<String> projFlowList = new ArrayList<String>();
		Map<String,List<IrbUser>> committeesMap = new HashMap<String,List<IrbUser>>();//����ίԱmap
		if (irbApplyList != null && irbApplyList.size() >0) {
			for (IrbApply temp:irbApplyList) {
				String irbFlow = temp.getIrbFlow();
				if (!projFlowList.contains(temp.getProjFlow())) {
					projFlowList.add(temp.getProjFlow());
				}
				//����ίԱ
				List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);	//����ίԱ
				List<String> userFlowList = new ArrayList<String>();
				List<IrbUser> filterList = new ArrayList<IrbUser>();	//�������󷽰���֪��ͬ��Ϊͬһ���˵����
				if (committeeList != null && committeeList.size() > 0) {
					for (IrbUser user:committeeList) {
						if (!userFlowList.contains(user.getUserFlow())) {
							filterList.add(user);
							userFlowList.add(user.getUserFlow());
						}
					}
				}
				committeesMap.put(irbFlow, filterList);
			}
		}
		model.addAttribute("committeesMap", committeesMap);
		
		if (projFlowList != null && projFlowList.size() > 0 ) {
			Map<String,Object> projMap = new HashMap<String, Object>();
			List<PubProj> projList = projBiz.searchProjByProjFlows(projFlowList);
			if (projList != null && projList.size() > 0) {
				for (PubProj tempProj:projList) {
					projMap.put(tempProj.getProjFlow(), tempProj);
				}
			}
			model.addAttribute("projMap", projMap);
		}
		return view;
	}
	/**
	 * ��������б�
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/meetingList")
	public String  meetingList(irbMeetingForm mForm, Model model){
		if(mForm==null){
			mForm = new irbMeetingForm();
		}
		mForm.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		List<IrbMeeting> mList = this.irbMeetingBiz.searchList(mForm);
		List<irbMeetingForm> mFormList = this.irbMeetingBiz.queryFormList(mList);
		model.addAttribute("mFormList", mFormList);
		return "irb/committee/meetingList";
	}
	@RequestMapping(value={"/meeting"},method={RequestMethod.GET})
	public String  meeting(Model model){
		return "irb/committee/agenda";
	}
	/**
	 * ίԱͶƱ
	 * @param irbFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/vote"},method={RequestMethod.GET})
	public String  vote(String irbFlow, Model model)throws Exception {
		if(StringUtil.isNotBlank(irbFlow)){
			IrbApply irb = irbApplyBiz.queryByFlow(irbFlow);
			model.addAttribute("irb", irb);
			List<IrbVoteForm> voteFormList = this.committeeBiz.queryIrbVoteList(irbFlow, GlobalContext.getCurrentUser().getUserFlow());
			if(voteFormList!=null&&!voteFormList.isEmpty()){
				model.addAttribute("voteForm", voteFormList.get(0));
			}
			IrbUser temp = new IrbUser();
			temp.setIrbFlow(irbFlow);
			temp.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			List<IrbUser> users = irbUserBiz.queryList(temp);
			String suggest = "";
			if (users != null && users.size() > 0) {
				suggest = users.get(0).getAuthNote();
			}
			model.addAttribute("suggest", suggest);
		}
		return "irb/committee/vote";
	}
	@RequestMapping(value={"/viewIrbFile"},method={RequestMethod.GET})
	public String  viewIrbFile(Model model){
		return "irb/committee/viewIrbFile";
	}
	@RequestMapping(value={"/viewSingleFile"},method={RequestMethod.GET})
	public String  viewSingleFile(Model model){
		return "irb/committee/viewSingleFile";
	}
	/**
	 * ��ȡ��鹤����
	 * @param irbAuthTypeId
	 * @param irbFlow
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/irbWorksheet")
	public String irbWorksheet(String irbAuthTypeId,String irbFlow,String irbUserFlow,Model model ) throws Exception{
		if(StringUtil.isNotBlank(irbAuthTypeId)&&StringUtil.isNotBlank(irbFlow)){
			IrbApply curIrbApply = this.irbApplyBiz.queryByFlow(irbFlow);
			if(curIrbApply!=null){
				String irbTypeId = curIrbApply.getIrbTypeId();
				String projFlow = curIrbApply.getProjFlow();
				PubProj proj = this.projBiz.readProject(projFlow);
				model.addAttribute("proj", proj);
				
				String category = proj.getProjCategoryId();
				String formFileName = "";
				if(IrbTypeEnum.Init.getId().equals(irbTypeId)){
					if(IrbAuthTypeEnum.CommitteePRO.getId().equals(irbAuthTypeId)){//����
						formFileName = IrbRecTypeEnum.InitWorksheetPRO.getId();
					}else if(IrbAuthTypeEnum.CommitteeICF.getId().equals(irbAuthTypeId)){//֪��ͬ����
						formFileName = IrbRecTypeEnum.InitWorksheetICF.getId();
					}
				}else if(IrbTypeEnum.Retrial.getId().equals(irbTypeId)){
					formFileName = IrbRecTypeEnum.RetrialWorksheet.getId();
				}else if(IrbTypeEnum.Revise.getId().equals(irbTypeId)){
					formFileName = IrbRecTypeEnum.ReviseWorksheet.getId();
				}else if(IrbTypeEnum.Schedule.getId().equals(irbTypeId)){
					formFileName = IrbRecTypeEnum.ScheduleWorksheet.getId();
				}else if(IrbTypeEnum.Sae.getId().equals(irbTypeId)){
					formFileName = IrbRecTypeEnum.SaeWorksheet.getId();
				}else if(IrbTypeEnum.Violate.getId().equals(irbTypeId)){
					formFileName = IrbRecTypeEnum.ViolateWorksheet.getId();
				}else if(IrbTypeEnum.Terminate.getId().equals(irbTypeId)){
					formFileName = IrbRecTypeEnum.TerminateWorksheet.getId();
				}else if(IrbTypeEnum.Finish.getId().equals(irbTypeId)){
					formFileName = IrbRecTypeEnum.FinishWorksheet.getId();
				}
				if(IrbAuthTypeEnum.Consultant.getId().equals(irbAuthTypeId)){//����������ѯ��
					formFileName = IrbRecTypeEnum.IndepConsultantWorksheet.getId();
				}
				
				if(StringUtil.isNotBlank(formFileName)){ 
					String productType = InitConfig.getSysCfg("irb_form_category");
					if(StringUtil.isEmpty(productType)||StringUtil.isBlank(productType)){
						productType = GlobalConstant.IRB_FORM_PRODUCT;
					}
					String currVer = "";	//���ѱ����������汾��ͨ��irbRec��ȡ
					IrbRec irbRec = new IrbRec();
					irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
					irbRec.setIrbFlow(curIrbApply.getIrbFlow());
					irbRec.setRecTypeId(formFileName);
					IrbUser irbUser = this.irbUserBiz.query(irbUserFlow);
					if(irbUser!=null){
						irbRec.setOperUserFlow(irbUser.getUserFlow());
						model.addAttribute("irbUserName", irbUser.getUserName());
						model.addAttribute("userFlow", irbUser.getUserFlow());
						if(IrbAuthTypeEnum.Consultant.getId().equals(irbAuthTypeId)){//����������ѯ��
							model.addAttribute("authNote", irbUser.getAuthNote());	//��ѯ����
						}
					}
					model.addAttribute("irbUserFlow", irbUserFlow);
					IrbRec rec = recBiz.readIrbRec(irbRec);
					if (rec != null) {
						currVer = rec.getRecVersion();
					} else {
						currVer = InitConfig.formRequestUtil.getVersionMap().get(formFileName);
					}
					if(StringUtil.isEmpty(currVer)||StringUtil.isBlank(currVer)){
						currVer = GlobalConstant.IRB_FORM_PRODUCT_VER;
					}
					Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
					IrbSingleForm singleForm = 	null;
					if(IrbAuthTypeEnum.Consultant.getId().equals(irbAuthTypeId)){//����������ѯ��
						singleForm = singleFormMap.get(productType+"_all_"+currVer);
					}else{
						singleForm = singleFormMap.get(productType+"_"+category+"_"+currVer);
						if(singleForm == null){
							logger.info("δ���ø���Ŀ���ͱ���Ĭ��ʹ��ҩ�������!");
							singleForm = 	singleFormMap.get(productType+"_"+ProjCategroyEnum.Yw.getId()+"_"+currVer);
						}  
					}
					if(singleForm == null){
						throw new RuntimeException("δ���ֱ� ��Ŀ���:"+proj.getProjCategoryName()+",����������:"+IrbTypeEnum.getNameById(curIrbApply.getIrbTypeId())+",ģ������:"+productType+",�汾��:"+currVer);
					}
					model.addAttribute("formFileName", formFileName);
					String jspPath = singleForm.getJspPath();
					if(StringUtil.isNotBlank(jspPath)){
						if(IrbAuthTypeEnum.Consultant.getId().equals(irbAuthTypeId)){//����������ѯ��
							jspPath = MessageFormat.format(jspPath,singleForm.getProductType(),singleForm.getVersion());
						}else{
							jspPath = MessageFormat.format(jspPath,singleForm.getProductType(),singleForm.getCategory(),singleForm.getVersion());
						}
					}
					
					Map<String,String> formDataMap = new HashMap<String, String>();
					if(rec != null && StringUtil.isNotBlank(rec.getRecContent())){
						String content = rec.getRecContent();
						try {
							Document document = DocumentHelper.parseText(content);
							Element rootElement = document.getRootElement();
							List<Element> elements = rootElement.elements();
							for(Element element : elements){
								List<Node> valueNodes = element.selectNodes("value");
								if(valueNodes != null && valueNodes.size()>0){
									String value = "";
									for(Node node : valueNodes){
										if(StringUtil.isNotBlank(value)){
											value+=",";
										}
										value += node.getText();
									}
									formDataMap.put(element.getName(), value);
								}else {
									formDataMap.put(element.getName(), element.getText());
								}
							}
						} catch (DocumentException e) {
							e.printStackTrace();
						}
					}
					model.addAttribute("formDataMap", formDataMap);
					
					//��ȡ����/֪��ͬ��汾�źͰ汾����
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
					model.addAttribute("proVersion", proVersion);
					model.addAttribute("proVersionDate", proVersionDate);
					model.addAttribute("icfVersion", icfVersion);
					model.addAttribute("icfVersionDate", icfVersionDate);
					
					//��ȡ��ʼ�������������
					if(IrbTypeEnum.Init.getId().equals(irbTypeId)){
						String applyFormName = IrbRecTypeEnum.InitApplication.getId();
						IrbRec applyRec = recBiz.readIrbRec(curIrbApply.getIrbFlow(),applyFormName);
						if(applyRec != null){
							String content = applyRec.getRecContent();
							try {
								Document document = DocumentHelper.parseText(content);
								Element rootElement = document.getRootElement();
								
								String researchType = "";	//�о�����
								Node researchTypeNode = rootElement.selectSingleNode("researchType");
								if (researchTypeNode != null) {
									researchType = researchTypeNode.getText();
								}
								model.addAttribute("researchType", researchType);
								
								String obserStudyType = "";	//�۲����о�����
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
									if (obserStudyType.indexOf("2")>-1) {	//�ع��Է�����ǰհ���о������ͬʱѡ����Ӧ�ļ�һ�ɰ�ǰհ���о�
										obserStudyType = "2";
									}
								}
								model.addAttribute("obserStudyType", obserStudyType);
								
								String informException = "";	//֪��ͬ�������
								Node informExceptionNode = rootElement.selectSingleNode("informException");
								if (informExceptionNode != null) {
									informException = informExceptionNode.getText();
								}
								model.addAttribute("informException", informException);
								
							} catch (DocumentException e) {
								e.printStackTrace();
							}
						}
					}
					
					IrbForm irbForm = secretaryBiz.readIrbForm(irbFlow);
					model.addAttribute("irbForm", irbForm);
					
					IrbInfo irbInfo = irbInfoBiz.queryInfo(curIrbApply.getIrbInfoFlow());//����ίԱ��
					model.addAttribute("irbInfo", irbInfo);
					
					return jspPath;
				}
			}
		}
		return "error/404";
	}
	/**
	 * ίԱ������
	 * @param irbFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/review/{role}")
	public String  review(String irbFlow,@PathVariable String role, Model model) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			IrbForm irbForm = secretaryBiz.readIrbForm(irbFlow);
			IrbUser irbUser = new IrbUser();
			irbUser.setIrbFlow(irbFlow);
			if(GlobalConstant.IRB_COMMITTEE_USER.equals(role)){
				SysUser curUser = GlobalContext.getCurrentUser();
				irbUser.setUserFlow(curUser.getUserFlow());
			}
			irbUser.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<IrbUser> irbUserList = this.irbUserBiz.queryList(irbUser);
			model.addAttribute("irbUserList", irbUserList);
			model.addAttribute("irbForm", irbForm);
			model.addAttribute("role", role);
		}
		return "irb/committee/review";
	}
	/**
	 * �����ļ��嵥	
	 * @param irbFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/fileList")
	public String fileList(String irbFlow, Model model) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			List<IrbApplyFileForm> applyFileFormList = recBiz.queryConfirmFile(irbFlow);
			model.addAttribute("applyFileFormList", applyFileFormList);
		}
		return "irb/committee/fileList";
	}
	/**
	 * ��������
	 * @param formFileName
	 * @param irbFlow
	 * @param req
	 * @return
	 */
	@RequestMapping(value="/saveWorksheet")
	@ResponseBody
	public String saveWorksheet(String formFileName,String irbFlow,String irbUserFlow,HttpServletRequest req) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)&&StringUtil.isNotBlank(formFileName)){
			String userFlow = "";
			String authId ="";
			IrbUser irbUser = this.irbUserBiz.query(irbUserFlow);
			if(irbUser!=null){
				userFlow = irbUser.getUserFlow();
				authId = irbUser.getAuthId();
			}
			IrbApply currIrb = this.irbApplyBiz.queryByFlow(irbFlow);
			if(currIrb != null){ 
				String projFlow = currIrb.getProjFlow();
				PubProj proj = this.projBiz.readProject(projFlow);
				String category = proj.getProjCategoryId();
				
				String productType = InitConfig.getSysCfg("irb_form_category");
				if(StringUtil.isBlank(productType)){
					productType = GlobalConstant.IRB_FORM_PRODUCT;
				}
				IrbRec irbRec = new IrbRec();
				irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				irbRec.setIrbFlow(currIrb.getIrbFlow());
				irbRec.setRecTypeId(formFileName);
				irbRec.setOperUserFlow(userFlow);
				IrbRec rec = recBiz.readIrbRec(irbRec);
				String currVer = "";
				if (rec != null) {
					currVer = rec.getRecVersion();
				} else {
					currVer = InitConfig.formRequestUtil.getVersionMap().get(formFileName);
				}
				if(StringUtil.isBlank(currVer)){
					currVer = GlobalConstant.IRB_FORM_PRODUCT_VER;
				}
				Map<String,IrbSingleForm> singleFormMap = InitConfig.formRequestUtil.getFormMap().get(formFileName);
				if(singleFormMap != null){
					IrbSingleForm singleForm = 	null;
					if(IrbRecTypeEnum.IndepConsultantWorksheet.getId().equals(formFileName)){//����������ѯ��
						singleForm = singleFormMap.get(productType+"_all_"+currVer);
					}else{
						singleForm = singleFormMap.get(productType+"_"+category+"_"+currVer);
						if(singleForm == null){
							logger.info("δ���ø���Ŀ���ͱ���Ĭ��ʹ��ҩ�������!");
							singleForm = singleFormMap.get(productType+"_"+ProjCategroyEnum.Yw.getId()+"_"+currVer);
						}  
					}
					if(singleForm == null){
						throw new RuntimeException("δ���ֱ�: ��Ŀ���"+proj.getProjCategoryName()+",����������:"+IrbTypeEnum.getNameById(currIrb.getIrbTypeId())+",ģ������:"+productType+",�汾��:"+currVer);
					}
					logger.info(formFileName+"=="+singleForm.getItemList().size()+"==="); 
					String recTypeName = IrbRecTypeEnum.getNameById(formFileName);
					String recContent = _getRecContent(formFileName, singleForm.getItemList(), req,irbUser); 
					if(rec == null){
						rec = new IrbRec();
					}
					rec.setProjFlow(projFlow);
					rec.setIrbFlow(irbFlow);
					rec.setIrbStageId(currIrb.getIrbStageId());
					rec.setIrbStageName(currIrb.getIrbStageName());
					rec.setRecTypeId(formFileName);
					rec.setRecTypeName(recTypeName);
					rec.setRecVersion(currVer);
					rec.setRecContent(recContent);
					rec.setOperUserFlow(userFlow);
					recBiz.edit(rec);
					/*����浵�ļ�*/
					List<String> recTypeIdList = new ArrayList<String>();
					/*����*/
					recTypeIdList.add(IrbRecTypeEnum.InitWorksheetPRO.getId());
					recTypeIdList.add(IrbRecTypeEnum.InitWorksheetICF.getId());
					recTypeIdList.add(IrbRecTypeEnum.RetrialWorksheet.getId());
					recTypeIdList.add(IrbRecTypeEnum.ReviseWorksheet.getId());
					recTypeIdList.add(IrbRecTypeEnum.ScheduleWorksheet.getId());
					recTypeIdList.add(IrbRecTypeEnum.SaeWorksheet.getId());
					recTypeIdList.add(IrbRecTypeEnum.ViolateWorksheet.getId());
					recTypeIdList.add(IrbRecTypeEnum.FinishWorksheet.getId());
					/*����������ѯ��*/
					recTypeIdList.add(IrbRecTypeEnum.IndepConsultantWorksheet.getId());
					if(recTypeIdList.contains(formFileName)){
						IrbArchiveForm form = new IrbArchiveForm();
						form.setIrbFlow(irbFlow);
						if(!IrbRecTypeEnum.InitWorksheetPRO.getId().equals(formFileName)&&!IrbRecTypeEnum.InitWorksheetICF.getId().equals(formFileName)&&!IrbRecTypeEnum.IndepConsultantWorksheet.getId().equals(formFileName)){
							SysUser sysUser = this.userBiz.readSysUser(userFlow);
							if(sysUser!=null){
								recTypeName +="��"+sysUser.getUserName()+"��";
							}
						}
						form.setName(recTypeName);
						form.setRecType(formFileName);
						form.setFileFlow(null);
						String url = req.getContextPath()+"/irb/committee/irbWorksheet?irbFlow="+irbFlow+"&irbAuthTypeId="+authId+"&irbUserFlow="+irbUserFlow;
						form.setUrl(url);
						this.recBiz.saveArchiveFile(form);
					}
					return GlobalConstant.SAVE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	private String _getRecContent(String formName,List<Element> list,HttpServletRequest req,IrbUser irbUser) { 
		Element rootEle = DocumentHelper.createElement(formName);
		if(list !=null && list.size()>0){
			for(Element itemEle : list){
				String multiple = itemEle.attributeValue("multiple");
				if(GlobalConstant.FLAG_N.equals(multiple) || StringUtil.isBlank(multiple)){
					String elementName = itemEle.attributeValue("name");
					String value = req.getParameter(elementName);
					Element element = DocumentHelper.createElement(elementName); 
					if (StringUtil.isNotBlank(value)) {
						element.setText(value);
					}
					rootEle.add(element);
					//��ȡ��������������������IRB_USER����
					if (StringUtil.isNotBlank(value) && irbUser != null) {
						if (GlobalConstant.IRB_FORM_SUGGEST.equals(elementName)) {//ίԱ������
							irbUser.setAuthNote(value);
						}
						if (GlobalConstant.IRB_FORM_DECISION.equals(elementName)) {//ίԱ������
							String decisionName = IrbDecisionEnum.getNameById(value);
							irbUser.setAuthDecision(decisionName);
						}
					}
				} else {
					String elementName = itemEle.attributeValue("name");
					String[] values = req.getParameterValues(elementName);
					Element element = DocumentHelper.createElement(elementName); 
					if(values!=null && values.length>0){
						for(String value : values){
							Element valueEle = DocumentHelper.createElement("value"); 
							if (StringUtil.isNotBlank(value)) {
								valueEle.setText(value);
							}
							element.add(valueEle);
						}
					}
					rootEle.add(element);
				}
			}
		}
		if (irbUser != null) {
			irbUserBiz.edit(irbUser);
		}
		return rootEle.asXML();
	}
	/**
	 * ����ίԱͶƱ
	 * @param form
	 * @return
	 */
	@RequestMapping(value="/saveVote")
	@ResponseBody
	public String saveVote(IrbVoteForm form,String irbFlow) throws Exception{
		if(form!=null&&StringUtil.isNotBlank(irbFlow)){
			if(GlobalConstant.IRB_DECISION_CONFLICT.equals(form.getDecisionId())){//�����ͻ
				form.setConflict(GlobalConstant.FLAG_Y);
				form.setDecisionId(null);
			}
			SysUser curUser = GlobalContext.getCurrentUser();
			form.setUserFlow(curUser.getUserFlow());
			form.setUserName(curUser.getUserName());
			int result = this.committeeBiz.saveVote(form, irbFlow,null);
			if(result == GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
}

