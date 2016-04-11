package com.pinde.sci.ctrl.gcp;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
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
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.gcp.IGcpCfgBiz;
import com.pinde.sci.biz.gcp.IGcpFinBiz;
import com.pinde.sci.biz.gcp.IGcpProjBiz;
import com.pinde.sci.biz.gcp.IGcpRecBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.gcp.GcpFundTypeEnum;
import com.pinde.sci.enums.gcp.GcpRecTypeEnum;
import com.pinde.sci.form.gcp.GCPMonitorForm;
import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.form.gcp.GcpEvaluationForm;
import com.pinde.sci.form.gcp.GcpFinishWorkForm;
import com.pinde.sci.form.gcp.GcpMeetingFileForm;
import com.pinde.sci.form.gcp.GcpMeetingForm;
import com.pinde.sci.form.gcp.GcpProvFilingForm;
import com.pinde.sci.form.gcp.GcpSumStampForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.irb.ProjOrgForm;
import com.pinde.sci.model.mo.GcpFund;
import com.pinde.sci.model.mo.GcpRec;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubProjUserExt;

@Controller
@RequestMapping("/gcp/rec")
public class GcpRecController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(GcpRecController.class);
	@Autowired
	private IGcpCfgBiz gcpCfgBiz;
	@Autowired
	private IGcpRecBiz gcpRecBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IGcpProjBiz gcpProjBiz;
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IGcpFinBiz gcpFinBiz;
	@Autowired
	private IProjUserBiz projUserBiz;
	
	/**
	 * ���ظ�����Ϣ
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/applyFile")
	public String applyFile(String projFlow, Model model) throws Exception{
		List<GcpCfgFileForm> fileList = gcpRecBiz.searchApplyFiles(projFlow);
		PubProj proj = this.pubProjBiz.readProject(projFlow);
		model.addAttribute("fileList", fileList);
		model.addAttribute("proj", proj);
		return "gcp/rec/applyFile/list";
	}
	
	/**
	 * �༭������Ϣ
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/editApplyFile")
	public String editApplyFile(String projFlow, Model model) throws Exception{
		List<GcpCfgFileForm> fileTemplateList = this.gcpCfgBiz.searchAppLyFileTemplateList();//��ѯ�ļ�ģ��
		model.addAttribute("fileTemplateList", fileTemplateList);
		if(StringUtil.isNotBlank(projFlow)){
			List<GcpCfgFileForm> fileList = gcpRecBiz.searchApplyFiles(projFlow);
			if(fileList != null && !fileList.isEmpty()){
				Map<String, GcpCfgFileForm> fileFormMap = new HashMap<String, GcpCfgFileForm>();
				for(GcpCfgFileForm form :fileList){
					fileFormMap.put(form.getId(), form);
				}
				model.addAttribute("fileFormMap", fileFormMap);
			}
		}
		return "gcp/rec/applyFile/edit";
	}
	
	/**
	 * ���渽��
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/saveMultipartFiles"},method={RequestMethod.POST})
	@ResponseBody
	public String saveMultipartFiles(@RequestParam(value="file", required=false)MultipartFile[] files, String[] id, String[] fileFlow, String[] fileName, String[] version, String[] versionDate, String projFlow, Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow) && files.length > 0){
			int result = gcpRecBiz.saveApplyFile(files, id, fileFlow, fileName, version, versionDate, projFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * ɾ������
	 * @param projFlow
	 * @param fileFlow_id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/delFileByIds"},method={RequestMethod.POST})
	@ResponseBody
	public String delFileByIds(String projFlow,String[] id) throws Exception{
		if(StringUtil.isNotBlank(projFlow) && id.length > 0){
			int result = gcpRecBiz.delFileByIds(projFlow, id);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * ��ʾ������������
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/evaluation")
	public String evaluation(String projFlow,Model model)throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			GcpEvaluationForm evalForm = this.gcpRecBiz.searchEvaluation(projFlow);
			model.addAttribute("evalForm", evalForm);
		}
		return "gcp/rec/evaluation/nydefy/info";
	}
//	@RequestMapping(value="/saveEvalWithFile")
//	@ResponseBody
//	public String saveEvalWithFile(String projFlow,String agree,String projectTime,@RequestParam(value="file" , required=false) MultipartFile file) throws Exception{
//		if(StringUtil.isNotBlank(projFlow)){
//			int result = this.gcpRecBiz.saveEval(projFlow, agree,projectTime, file);
//			if(result==GlobalConstant.ONE_LINE){
//				return GlobalConstant.SAVE_SUCCESSED;
//			}
//		}
//		return GlobalConstant.SAVE_FAIL;
//	}
	/**
	 * ��������������
	 * @param projFlow
	 * @param agree
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveEval")
	@ResponseBody
	public String saveEval(String projFlow,String agree,String projectTime,HttpServletRequest request) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			Map<String,Object> paramMap = new HashMap<String,Object>();
			_putAll(paramMap,request);
			
			int result = this.gcpRecBiz.saveEval(projFlow, paramMap);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	private void _putAll(Map<String,Object> paramMap,HttpServletRequest request){
		Enumeration<String> paramNames = request.getParameterNames();
		while(paramNames.hasMoreElements()){
			String paramName = paramNames.nextElement();
			System.err.println("paramName="+paramName); 
			String paramValue = request.getParameter(paramName);
			paramMap.put(paramName, paramValue);
		}
	}
	/**
	 * ��ʾ�༭������Ϣ
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editMeeting")
	public String editMeeting(String projFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			GcpMeetingForm meetingForm = this.gcpRecBiz.searchMeeting(projFlow);
			if(meetingForm==null || (meetingForm!=null && StringUtil.isBlank(meetingForm.getUser()))){
				//������Ŀ��Ա
				PubProjUserExt searchProjUserExt = new PubProjUserExt();
				searchProjUserExt.setProjFlow(projFlow);
				searchProjUserExt.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				List<PubProjUserExt> projUserExtList = projUserBiz.search(searchProjUserExt);
				model.addAttribute("projUserExtList", projUserExtList);
							
				List<PubProjUserExt> filterList = new ArrayList<PubProjUserExt>();//����һ���û������ɫ
				for(PubProjUserExt projUserExt : projUserExtList){
					String roleName = projUserExt.getRole().getRoleName();
					projUserExt.setAllRoleName(roleName);
					boolean canAdd = false;
					//����һ���û������ɫ
					for(PubProjUserExt filterUser : filterList){
						if(projUserExt.getUserFlow().equals(filterUser.getUserFlow())){
							filterUser.setAllRoleName(filterUser.getAllRoleName() +"��"+ roleName);
							canAdd = false;
							break;
						}else{
							canAdd = true;
						}
					}
					if(filterList.isEmpty() || canAdd){
						filterList.add(projUserExt);
					}
				}
				if(filterList!=null && filterList.size()>0){
					String meetingUserNames = "";
					for(PubProjUserExt userExt : filterList){
						if(StringUtil.isNotBlank(meetingUserNames)){
							meetingUserNames+="��";
						}
						meetingUserNames+=userExt.getUser().getUserName();
					}
					model.addAttribute("meetingUserNames", meetingUserNames);
				}
			}
			model.addAttribute("meetingForm", meetingForm);
		}
		return "gcp/rec/meeting/editMeeting";
	}
	/**
	 * ��ʾ������
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/startMeeting")
	public String startMeeting(String projFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			model.addAttribute("proj", proj);
			/*��Ŀ��Ա*/
			Map<String,String> userMap = this.gcpRecBiz.filterProjUser(projFlow);
			model.addAttribute("userMap", userMap);
			/*���Ա*/
			List<GCPMonitorForm> mFormList = gcpProjBiz.searchMonitor(projFlow);
			model.addAttribute("mFormList", mFormList);
			GcpMeetingForm meetingForm = this.gcpRecBiz.searchMeeting(projFlow);
			model.addAttribute("meetingForm", meetingForm);
			
			//���ѵ��˺�ſ��Կ�������
			GcpFund fund = new GcpFund();
			fund.setProjFlow(projFlow);
			fund.setFundTypeId(GcpFundTypeEnum.In.getId());
			List<GcpFund> fundList = gcpFinBiz.searchFundList(fund);
			if(fundList.size()>0){
				model.addAttribute("fundFlag", GlobalConstant.FLAG_Y);
			}else {
				model.addAttribute("fundFlag", GlobalConstant.FLAG_N);
			}
			
		}
		return "gcp/rec/meeting/start";
	}
	/**
	 * ���������Ϣ
	 * @param form
	 * @return
	 * @throws DocumentException
	 */
	@RequestMapping(value="/saveMeeting")
	@ResponseBody
	public String saveMeeting(GcpMeetingForm form) throws Exception{
		int result = this.gcpRecBiz.saveMeeting(form);
		if(result == GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	} 
	/**
	 * ��ʾ�༭����֪ͨ
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editNotice")
	public String editNotice(String projFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			model.addAttribute("proj", proj);
			GcpMeetingForm meetingForm = this.gcpRecBiz.searchMeeting(projFlow);
			model.addAttribute("meetingForm", meetingForm);
		}
		return "gcp/rec/meeting/editNotice";
	}
	/**
	 * ��ʾ�����ļ�
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/meetingFile")
	public String meetingFile(String projFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			GcpMeetingForm meetingForm = this.gcpRecBiz.searchMeeting(projFlow);
			model.addAttribute("meetingForm", meetingForm);
		}
		return "gcp/rec/meeting/file";
	}
	/**
	 * ��������ļ�
	 * @param files
	 * @param fileNames
	 * @param ids
	 * @param fileFlows
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveMeetingFiles")
	@ResponseBody
	public String saveMeetingFiles(@RequestParam(value="file",required=false) MultipartFile[] files,String[] ids,String[] fileFlows, String projFlow) throws Exception{
		if(files!=null&&StringUtil.isNotBlank(projFlow)){
			GcpMeetingForm form = new GcpMeetingForm();
			form.setProjFlow(projFlow);
			form.setSaveType("file");
			List<GcpMeetingFileForm> mForms = new ArrayList<GcpMeetingFileForm>();
			GcpMeetingFileForm fileForm = null;
			for (int i = 0; i < files.length; i++) {
				if(files[i].getSize()>0){
					fileForm = new GcpMeetingFileForm();
					if(i<files.length){
						fileForm.setFile(files[i]);
						fileForm.setFileName(files[i].getOriginalFilename());
					}
					if(i<ids.length){
						fileForm.setId(ids[i]);
					}
					if(i<fileFlows.length){
						fileForm.setFileFlow(fileFlows[i]);
					}
					mForms.add(fileForm);
				}
			}
			form.setFiles(mForms);
			int result = this.gcpRecBiz.saveMeeting(form);
			if(result == GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * ɾ�������ļ�
	 * @param ids
	 * @param projFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/delMeetingFiles")
	@ResponseBody
	public String delMeetingFiles(@RequestParam(value="delId",required=true)List<String> ids,String projFlow ) throws Exception{
		if(StringUtil.isNotBlank(projFlow)&&ids!=null&&!ids.isEmpty()){
			this.gcpRecBiz.delMeetingFiles(ids, projFlow);
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
	/**
	 * ʡ������
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/provFiling")
	public String provFiling(String projFlow,Model model)throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			//������Ϣ
			GcpProvFilingForm pfForm = this.gcpRecBiz.searchProvFiling(projFlow);
			//��Ŀ������Ϣ
			ProjInfoForm projInfoForm = gcpProjBiz.searchGeneralInfo(projFlow);
			model.addAttribute("projInfoForm", projInfoForm);
			//��Ŀ��Դ/CRO
			ProjInfoForm projInfoForm2 =gcpProjBiz.searchDeclarerAndCRO(projFlow);
			model.addAttribute("projInfoForm2", projInfoForm2);
			//�ٴ��о���λ
			ProjOrgForm projOrgForm = gcpProjBiz.searchLeader(projFlow);
			List<PubProjOrg> projOrgList = projOrgBiz.searchProjOrg(projFlow);
			projOrgForm.setProjOrgList(projOrgList);
			//��ͬ������
			List<PubProj> projList = new ArrayList<PubProj>();
			projList.add(projInfoForm.getProj());
			Map<String,Map<String,Object>> countMap = this.gcpFinBiz.countContract(projList,null);
			model.addAttribute("projOrgForm", projOrgForm);
			model.addAttribute("pfForm", pfForm);
			model.addAttribute("projInfoForm", projInfoForm);
			model.addAttribute("countMap", countMap);
		}
		return "gcp/rec/provFiling/info";
	}
	/**
	 * �༭ʡ������
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editProvFiling")
	public String editProvFiling(String projFlow,Model model)throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			GcpProvFilingForm pfForm = this.gcpRecBiz.searchProvFiling(projFlow);
			model.addAttribute("pfForm", pfForm);
		}
		return "gcp/rec/provFiling/edit";
	}
	/**
	 * ����ʡ������
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveProvFiling")
	@ResponseBody
	public String saveProvFiling(GcpProvFilingForm form) throws Exception{
		int result = this.gcpRecBiz.saveProvFiling(form);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * �ܽ����
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sumStamp")
	public String sumStamp(String projFlow,Model model)throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			GcpSumStampForm ssForm = this.gcpRecBiz.searchSumStamp(projFlow);
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			model.addAttribute("ssForm", ssForm);
			model.addAttribute("proj", proj);
		}
		return "gcp/rec/sumStamp/info";
	}
	/**
	 * �����ܽ����
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveSumStamp")
	@ResponseBody
	public String saveSumStamp(GcpSumStampForm form) throws Exception{
		int result = this.gcpRecBiz.saveSumStamp(form);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * �༭�ܽ����
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editSumStamp")
	public String editSumStamp(String projFlow,Model model)throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			GcpSumStampForm ssForm  = this.gcpRecBiz.searchSumStamp(projFlow);
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			model.addAttribute("ssForm", ssForm);
			model.addAttribute("proj", proj);
		}
		return "gcp/rec/sumStamp/edit";
	}
	/**
	 * �о���������
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/finishWork")
	public String finishWork(String projFlow,Model model)throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			model.addAttribute("proj", proj);
			GcpFinishWorkForm fwForm = this.gcpRecBiz.searchFinishWork(projFlow);
			model.addAttribute("fwForm", fwForm);
		}
		return "gcp/rec/finishWork/info";
	}
	/**
	 * �༭�о���������
	 * @param projFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editFinishWork")
	public String editFinishWork(String projFlow,Model model)throws Exception{
		if(StringUtil.isNotBlank(projFlow)){
			PubProj proj = this.pubProjBiz.readProject(projFlow);
			model.addAttribute("proj", proj);
			GcpFinishWorkForm fwForm  = this.gcpRecBiz.searchFinishWork(projFlow);
			model.addAttribute("fwForm", fwForm);
		}
		return "gcp/rec/finishWork/edit";
	}
	/**
	 * �����о���������
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveFinishWork")
	@ResponseBody
	public String saveFinishWork(GcpFinishWorkForm form) throws Exception{
		int result = this.gcpRecBiz.saveFinishWork(form);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/archiveFile")
	public String archiveFile(String projFlow,Model model) throws Exception{
		//����projFlow��recTypeId�����ļ��鵵rec��¼
		GcpRec gcpRec=gcpRecBiz.searchOne(projFlow, GcpRecTypeEnum.Archive.getId());
		 //��ȡ�鵵�ļ��嵥
		GcpCfgFileForm fileForm=new GcpCfgFileForm();
		List<GcpCfgFileForm> fileList = this.gcpCfgBiz.searchFinishFileTemplateList(fileForm);
		//��Ŵ�xml��ȡ����file����
		List<GcpCfgFileForm> fileXmlFormList=new ArrayList<GcpCfgFileForm>();
		//����xml�ڵ�
		if(null!=gcpRec){
		  if(StringUtil.isNotBlank(gcpRec.getRecContent())){
			Document document = DocumentHelper.parseText(gcpRec.getRecContent());
			//��ȡ���н׶νڵ�
			List<Element> stageNodeList = (List<Element>)document.selectNodes("/archive//stage");
			for(Element stageEl:stageNodeList){
				List<Element> fileNodeList= (List<Element>)stageEl.selectNodes("file");
				if(null!=fileNodeList && !fileNodeList.isEmpty()){
					for(Element fileEl:fileNodeList){
						GcpCfgFileForm file = new GcpCfgFileForm();
						file.setId(fileEl.attributeValue("id"));
						file.setFileName(fileEl.elementTextTrim("fileName"));
						file.setStage(stageEl.attributeValue("id"));
						fileXmlFormList.add(file);
					}
				}
			}
			
		  }
		}
		//����ļ��鵵״̬
		Map<String,String> map=new HashMap<String, String>();
		for(GcpCfgFileForm file:fileXmlFormList){
			map.put(file.getId(), GlobalConstant.RECORD_STATUS_Y);
		}
		model.addAttribute("map", map);
		model.addAttribute("fileList", fileList);
		return "gcp/rec/archive/list";
	}
	
	@RequestMapping(value="/saveArchive")
	@ResponseBody
	public String saveArchive(@RequestBody ArrayList<GcpCfgFileForm> fileFormList,String projFlow) throws DocumentException{
		SysUser currUser=GlobalContext.getCurrentUser();
		GcpRec gcpRec=gcpRecBiz.searchOne(projFlow, GcpRecTypeEnum.Archive.getId());
		if(null==gcpRec){
			PubProj proj=pubProjBiz.readProject(projFlow);
			GcpRec rec=new GcpRec();
			if(null!=proj){	
				rec.setProjFlow(projFlow);
				rec.setGcpStageId(proj.getProjStageId());
				rec.setGcpStageName(proj.getProjStageName());
				rec.setRecTypeId(GcpRecTypeEnum.Archive.getId());
				rec.setRecTypeName(GcpRecTypeEnum.Archive.getName());
				rec.setOperTime(DateUtil.getCurrDateTime());
				rec.setOperUserFlow(currUser.getUserFlow());
				rec.setOperUserName(currUser.getUserName());
			}else{
				return GlobalConstant.SAVE_FAIL;
			}
			int result = gcpProjBiz.saveArchiveToRec(fileFormList, rec);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}else{
			int result = gcpProjBiz.saveArchiveToRec(fileFormList, gcpRec);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		
		return GlobalConstant.SAVE_FAIL;
	}
}
