package com.pinde.sci.ctrl.pub;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduResumeBiz;
import com.pinde.sci.biz.pub.IAcademicResumeBiz;
import com.pinde.sci.biz.pub.IPubTrainBiz;
import com.pinde.sci.biz.pub.IPubTrainUserBiz;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.pub.IWorkResumeBiz;
import com.pinde.sci.biz.srm.IAchBookBiz;
import com.pinde.sci.biz.srm.IPatentBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.srm.ISatBiz;
import com.pinde.sci.biz.srm.IThesisBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.pub.AcademicResumeForm;
import com.pinde.sci.form.pub.EduResumeForm;
import com.pinde.sci.form.pub.WorkResumeForm;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubTrain;
import com.pinde.sci.model.mo.PubTrainUser;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SrmAchBook;
import com.pinde.sci.model.mo.SrmAchPatent;
import com.pinde.sci.model.mo.SrmAchSat;
import com.pinde.sci.model.mo.SrmAchThesis;
import com.pinde.sci.model.mo.SysUser;

/**
 * 履历
 * @author tiger
 *
 */
@Controller
@RequestMapping("/pub/resume")
public class ResumeController extends GeneralController{
	private static Logger logger = LoggerFactory.getLogger(ResumeController.class);
	
	private static String EDUCATION = "education";
	private static String WORK = "work";
	private static String ACADEMIC = "academic";
	private static String PROJ = "proj";
	private static String TRAIN = "train";
	private static String THESIS = "thesis";
	private static String BOOK = "book";
	private static String PATENT = "patent";
	private static String SAT = "sat";
	
	
	@Autowired
	private IPubUserResumeBiz userResumeBiz;
	@Autowired
	private IEduResumeBiz eduResumeBiz;
	@Autowired
	private IWorkResumeBiz workResumeBiz;
	@Autowired
	private IAcademicResumeBiz academicResumeBiz;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private IPubTrainBiz trainBiz;
	@Autowired
	private IPubTrainUserBiz trainUserBiz;
	@Autowired
    private IThesisBiz thesisBiz;
	@Autowired
	private IAchBookBiz bookBiz;
	@Autowired
	private IPatentBiz patentBiz;
	@Autowired
	private ISatBiz satBiz;
	@Autowired
	private IUserBiz userBiz;


	
	/**
	 * 加载个人信息页面
	 * @param type
	 * @param jsp
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/loadView",method={RequestMethod.GET})
	public String loadView(String userFlow,  String type, Model model) throws Exception{
		List<EduResumeForm> eduFormList = null;
		List<WorkResumeForm> workFormList = null;
		List<AcademicResumeForm> academicFormList = null;
		List<PubProj> projList = null;
		List<PubTrain> trainList = null;
		List<SrmAchThesis> thesisList = null;
		List<SrmAchBook> bookList = null;
		List<SrmAchPatent> patentList = null;
		List<SrmAchSat> satList = null;
		
		model.addAttribute("userFlow", userFlow);
		
		SysUser user = null;
		if(StringUtil.isNotBlank(userFlow)){
			user = userBiz.readSysUser(userFlow);
			if(null != user){
				PubUserResume resume = userResumeBiz.readPubUserResume(userFlow);
					if(StringUtil.isNotBlank(type)){
						//教育经历
						if(type.equals(EDUCATION)){
							eduFormList = eduResumeBiz.queryEduResumeList(resume);
							model.addAttribute("eduFormList", eduFormList);
							return "sys/user/resume/eduList";
						}
						//工作经历
						if(type.equals(WORK)){
							workFormList = workResumeBiz.queryWorkList(resume);
							model.addAttribute("workFormList", workFormList);
							return "sys/user/resume/workList";
						}
						//学会任职经历
						if(type.equals(ACADEMIC)){
							academicFormList = academicResumeBiz.queryAcademicList(resume);
							model.addAttribute("academicFormList", academicFormList);
							return "sys/user/resume/academicList";
						}
						//课题情况
						if(type.equals(PROJ)){
							PubProj proj = new PubProj();
							proj.setApplyUserFlow(user.getUserFlow());
							projList = projBiz.queryProjList(proj);
							model.addAttribute("projList", projList);
							return "sys/user/resume/projList";
						}
						//培训情况
						if(type.equals(TRAIN)){
							List<String> trainFlows = new ArrayList<String>();
							PubTrainUser trainUser = new PubTrainUser();
							trainUser.setUserFlow(user.getUserFlow());
							List<PubTrainUser> trianUserList = trainUserBiz.queryTrainUserList(trainUser);
							if(null != trianUserList && !trianUserList.isEmpty()){
								for(PubTrainUser u : trianUserList){
									String trainFlow = u.getTrainFlow();
									if(StringUtil.isNotBlank(trainFlow)){
										trainFlows.add(trainFlow);
									}
								}
								if(null != trainFlows && !trainFlows.isEmpty()){
									trainList = trainBiz.queryTrainList(null, null, trainFlows);
								}
							}
							model.addAttribute("trainList", trainList);
							return "sys/user/resume/trainList";
						}
						//-----------以下是成果------------
						if(type.equals(THESIS)){
							SrmAchThesis thesis = new SrmAchThesis();
							thesis.setApplyUserFlow(user.getUserFlow());
							thesis.setOperStatusId(AchStatusEnum.FirstAudit.getId());
							thesisList = thesisBiz.search(thesis, null);
							model.addAttribute("thesisList", thesisList);
							return "sys/user/resume/thesisList";
						}
						if(type.equals(BOOK)){
							SrmAchBook book = new SrmAchBook();
							book.setApplyUserFlow(user.getUserFlow());
							book.setOperStatusId(AchStatusEnum.FirstAudit.getId());
							bookList = bookBiz.search(book, null);
							model.addAttribute("bookList", bookList);
							return "sys/user/resume/bookList";
						}
						if(type.equals(PATENT)){
							SrmAchPatent patent = new SrmAchPatent();
							patent.setApplyUserFlow(user.getUserFlow());
							patent.setOperStatusId(AchStatusEnum.FirstAudit.getId());
							patentList = patentBiz.search(patent, null);
							model.addAttribute("patentList", patentList);
							return "sys/user/resume/patentList";
						}
						if(type.equals(SAT)){
							SrmAchSat sat = new SrmAchSat();
							sat.setApplyUserFlow(user.getUserFlow());
							sat.setOperStatusId(AchStatusEnum.FirstAudit.getId());
							satList = satBiz.search(sat, null);
							model.addAttribute("satList", satList);
							return "sys/user/resume/satList";
						}
					}
			}
		}	
		return null;
	}
	
	
	/**
	 * 跳转一条教育新增、修改界面
	 * @param recordId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editEdu",method={RequestMethod.POST,RequestMethod.GET})
	public String editEdu(String userFlow,String recordId, Model model) throws Exception{
		EduResumeForm eduForm = null;
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			eduForm =  eduResumeBiz.getEduResumeByRecordId(userFlow, recordId);
		}
		model.addAttribute("eduForm", eduForm);
		model.addAttribute("userFlow", userFlow);
		return "sys/user/resume/eduEdit";
	}
	
	
	/**
	 * 保存教育经历
	 * @param form
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveEdu",method={RequestMethod.POST})
	@ResponseBody
	public String saveEdu(String userFlow, EduResumeForm form, Model model) throws Exception{
		 if(StringUtil.isNotBlank(userFlow) && null != form){
			 SysUser user = userBiz.readSysUser(userFlow);
			 if(null != user){
				 int result =  eduResumeBiz.saveEduResume(user, form);
				 if(result != GlobalConstant.ZERO_LINE){
					 return GlobalConstant.SAVE_SUCCESSED;
				 }
			 }
		 }
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * 删除一条教育经历
	 * @param recordId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delEdu",method={RequestMethod.POST})
	@ResponseBody
	public String delEdu(String userFlow, String recordId, Model model) throws Exception{
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			int result = eduResumeBiz.delEduResumeByRecordId(userFlow, recordId);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	
	//----------------工作经历-------------------------
	/**
	 * 跳转一条工作新增、修改界面
	 * @param recordId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editWork",method={RequestMethod.POST,RequestMethod.GET})
	public String editWork(String userFlow, String recordId, Model model) throws Exception{
		WorkResumeForm workForm = null;
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			workForm =  workResumeBiz.getWorkResumeByRecordId(userFlow, recordId);
		}
		model.addAttribute("workForm", workForm);
		model.addAttribute("userFlow", userFlow);
		return "sys/user/resume/workEdit";
	}
	
	
	/**
	 * 保存工作经历
	 * @param form
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveWork",method={RequestMethod.POST})
	@ResponseBody
	public String saveWork(String userFlow, WorkResumeForm form, Model model) throws Exception{
		 if(StringUtil.isNotBlank(userFlow) && null != form){
			 SysUser user = userBiz.readSysUser(userFlow);
			 if(null != user){
				 int result =  workResumeBiz.saveWorkResume(user, form);
				 if(result != GlobalConstant.ZERO_LINE){
					 return GlobalConstant.SAVE_SUCCESSED;
				 }
			 }
		 }
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * 删除一条工作经历
	 * @param recordId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delWork",method={RequestMethod.POST})
	@ResponseBody
	public String delWork(String userFlow, String recordId, Model model) throws Exception{
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			int result = workResumeBiz.delWorkResumeByRecordId(userFlow, recordId);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	
	
	//-------------学会任职--------------
	
	/**
	 * 跳转一条工作新增、修改界面
	 * @param recordId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editAcademic",method={RequestMethod.POST,RequestMethod.GET})
	public String editAcademic(String userFlow, String recordId, Model model) throws Exception{
		AcademicResumeForm academicForm = null;
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			academicForm =  academicResumeBiz.getAcademicResumeByRecordId(userFlow, recordId);
		}
		model.addAttribute("academicForm", academicForm);
		model.addAttribute("userFlow", userFlow);
		return "sys/user/resume/academicEdit";
	}
	
	
	/**
	 * 保存工作经历
	 * @param form
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAcademic",method={RequestMethod.POST})
	@ResponseBody
	public String saveAcademic(String userFlow, AcademicResumeForm form, Model model) throws Exception{
		 if(StringUtil.isNotBlank(userFlow) && null != form){
			 SysUser user = userBiz.readSysUser(userFlow);
			 if(null != user){
				 int result =  academicResumeBiz.saveAcademicResume(user, form);
				 if(result != GlobalConstant.ZERO_LINE){
					 return GlobalConstant.SAVE_SUCCESSED;
				 }
			 }
		 }
		return GlobalConstant.SAVE_FAIL;
	}
	

	/**
	 * 删除一条学会任职
	 * @param recordId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delAcademic",method={RequestMethod.POST})
	@ResponseBody
	public String delAcademic(String userFlow, String recordId, Model model) throws Exception{
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(recordId)){
			int result = academicResumeBiz.delAcademicResumeByRecordId(userFlow, recordId);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/******************************论文********************************/
	
	/**
	 * 跳转一条论文新增、修改界面
	 * @param thesisFlow
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editThesis",method={RequestMethod.POST,RequestMethod.GET})
	public String editThesis(String thesisFlow, Model model) throws Exception{
		SrmAchThesis srmAchThesis = null;
		if(StringUtil.isNotBlank(thesisFlow)){
			srmAchThesis = thesisBiz.readThesis(thesisFlow);
			model.addAttribute("srmAchThesis", srmAchThesis);
		}
		return "sys/user/resume/thesisEdit";
	}
	
	/**
	 * 保存论文
	 * @param form
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveThesis",method={RequestMethod.POST})
	@ResponseBody
	public String saveThesis(String userFlow, SrmAchThesis srmAchThesis, Model model) throws Exception{
		 if(StringUtil.isNotBlank(userFlow) && null != srmAchThesis){
			 SysUser user = userBiz.readSysUser(userFlow);
			 if(null != user){
				 srmAchThesis.setApplyUserFlow(user.getUserFlow());
				 srmAchThesis.setApplyUserName(user.getUserName());
				 srmAchThesis.setApplyOrgFlow(user.getOrgFlow());
				 srmAchThesis.setApplyOrgName(user.getOrgName());
				 srmAchThesis.setTypeName(DictTypeEnum.ThesisType.getDictNameById(srmAchThesis.getTypeId()));
				 srmAchThesis.setProjSourceName(DictTypeEnum.ProjSource.getDictNameById(srmAchThesis.getProjSourceId()));
				 srmAchThesis.setOperStatusId(AchStatusEnum.FirstAudit.getId());
				 srmAchThesis.setOperStatusName(AchStatusEnum.FirstAudit.getName());
				 int result = thesisBiz.save(srmAchThesis);
				 if(result != GlobalConstant.ZERO_LINE){
					 return GlobalConstant.SAVE_SUCCESSED;
				 }
			 }
		 }
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * 删除一条论文
	 * @param recordId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delThesis",method={RequestMethod.POST})
	@ResponseBody
	public String delThesis(SrmAchThesis srmAchThesis, Model model) throws Exception{
		if(null != srmAchThesis){
			srmAchThesis.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = thesisBiz.save(srmAchThesis);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/******************************著作********************************/
	
		/**
		 * 跳转一条著作新增、修改界面
		 * @param thesisFlow
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/editBook",method={RequestMethod.POST,RequestMethod.GET})
		public String editBook(String bookFlow, Model model) throws Exception{
			SrmAchBook srmAchBook = null;
			if(StringUtil.isNotBlank(bookFlow)){
				srmAchBook = bookBiz.readBook(bookFlow);
				model.addAttribute("srmAchBook", srmAchBook);
			}
			return "sys/user/resume/bookEdit";
		}
		
		/**
		 * 保存著作
		 * @param form
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/saveBook",method={RequestMethod.POST})
		@ResponseBody
		public String saveBook(String userFlow, SrmAchBook srmAchBook, Model model) throws Exception{
			 if(StringUtil.isNotBlank(userFlow) && null != srmAchBook){
				 SysUser user = userBiz.readSysUser(userFlow);
				 if(null != user){
					 srmAchBook.setApplyUserFlow(user.getUserFlow());
					 srmAchBook.setApplyUserName(user.getUserName());
					 srmAchBook.setApplyOrgFlow(user.getOrgFlow());
					 srmAchBook.setApplyOrgName(user.getOrgName());
					 srmAchBook.setTypeName(DictTypeEnum.AchBookType.getDictNameById(srmAchBook.getTypeId()));
					 srmAchBook.setPubPlaceName(DictTypeEnum.PlaceNameType.getDictNameById(srmAchBook.getPubPlaceId()));
					 srmAchBook.setOperStatusId(AchStatusEnum.FirstAudit.getId());
					 srmAchBook.setOperStatusName(AchStatusEnum.FirstAudit.getName());
					 int result = bookBiz.save(srmAchBook);
					 if(result != GlobalConstant.ZERO_LINE){
						 return GlobalConstant.SAVE_SUCCESSED;
					 }
				 }
			 }
			return GlobalConstant.SAVE_FAIL;
		}
		
		
		/**
		 * 删除一条著作
		 * @param recordId
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/delBook",method={RequestMethod.POST})
		@ResponseBody
		public String delBook(SrmAchBook srmAchBook, Model model) throws Exception{
			if(null != srmAchBook){
				srmAchBook.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				int result = bookBiz.save(srmAchBook);
				if(result != GlobalConstant.ZERO_LINE){
					return GlobalConstant.DELETE_SUCCESSED;
				}
			}
			return GlobalConstant.DELETE_FAIL;
		}
		
		/******************************专利********************************/
		
		/**
		 * 跳转一条专利新增、修改界面
		 * @param thesisFlow
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/editPatent",method={RequestMethod.POST,RequestMethod.GET})
		public String editPatent(String patentFlow, Model model) throws Exception{
			SrmAchPatent srmAchPatent = null;
			if(StringUtil.isNotBlank(patentFlow)){
				srmAchPatent = patentBiz.readPatent(patentFlow);
				model.addAttribute("srmAchPatent", srmAchPatent);
			}
			return "sys/user/resume/patentEdit";
		}
		
		/**
		 * 保存专利
		 * @param form
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/savePatent",method={RequestMethod.POST})
		@ResponseBody
		public String savePatent(String userFlow, SrmAchPatent srmAchPatent, Model model) throws Exception{
			 if(StringUtil.isNotBlank(userFlow) && null != srmAchPatent){
				 SysUser user = userBiz.readSysUser(userFlow);
				 if(null != user){
					 srmAchPatent.setApplyUserFlow(user.getUserFlow());
					 srmAchPatent.setApplyUserName(user.getUserName());
					 srmAchPatent.setApplyOrgFlow(user.getOrgFlow());
					 srmAchPatent.setApplyOrgName(user.getOrgName());
					 srmAchPatent.setTypeName(DictTypeEnum.PatentType.getDictNameById(srmAchPatent.getTypeId()));
					 srmAchPatent.setStatusName(DictTypeEnum.PatentStatus.getDictNameById(srmAchPatent.getStatusId()));
					 srmAchPatent.setOperStatusId(AchStatusEnum.FirstAudit.getId());
					 srmAchPatent.setOperStatusName(AchStatusEnum.FirstAudit.getName());
					 int result = patentBiz.save(srmAchPatent);
					 if(result != GlobalConstant.ZERO_LINE){
						 return GlobalConstant.SAVE_SUCCESSED;
					 }
				 }
			 }
			return GlobalConstant.SAVE_FAIL;
		}
		
		
		/**
		 * 删除一条专利
		 * @param recordId
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/delPatent",method={RequestMethod.POST})
		@ResponseBody
		public String delPatent(SrmAchPatent srmAchPatent, Model model) throws Exception{
			if(null != srmAchPatent){
				srmAchPatent.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				int result = patentBiz.save(srmAchPatent);
				if(result != GlobalConstant.ZERO_LINE){
					return GlobalConstant.DELETE_SUCCESSED;
				}
			}
			return GlobalConstant.DELETE_FAIL;
		}
		
		/******************************获奖********************************/
		
		/**
		 * 跳转一条获奖新增、修改界面
		 * @param thesisFlow
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/editSat",method={RequestMethod.POST,RequestMethod.GET})
		public String editSat(String satFlow, Model model) throws Exception{
			SrmAchSat srmAchSat = null;
			if(StringUtil.isNotBlank(satFlow)){
				srmAchSat = satBiz.readSat(satFlow);
				model.addAttribute("srmAchSat", srmAchSat);
			}
			return "sys/user/resume/satEdit";
		}
		
		/**
		 * 保存获奖
		 * @param form
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/saveSat",method={RequestMethod.POST})
		@ResponseBody
		public String saveSat(String userFlow, SrmAchSat srmAchSat, Model model) throws Exception{
			 if(StringUtil.isNotBlank(userFlow) && null != srmAchSat){
				 SysUser user = userBiz.readSysUser(userFlow);
				 if(null != user){
					 srmAchSat.setApplyUserFlow(user.getUserFlow());
					 srmAchSat.setApplyUserName(user.getUserName());
					 srmAchSat.setApplyOrgFlow(user.getOrgFlow());
					 srmAchSat.setApplyOrgName(user.getOrgName());
					 srmAchSat.setPrizedGradeName(DictTypeEnum.PrizedGrade.getDictNameById(srmAchSat.getPrizedGradeId()));
					 srmAchSat.setPrizedLevelName(DictTypeEnum.PrizedLevel.getDictNameById(srmAchSat.getPrizedLevelId()));
					 srmAchSat.setAchTypeName(DictTypeEnum.AchType.getDictNameById(srmAchSat.getAchTypeId()));
					 srmAchSat.setOperStatusId(AchStatusEnum.FirstAudit.getId());
					 srmAchSat.setOperStatusName(AchStatusEnum.FirstAudit.getName());
					 int result = satBiz.save(srmAchSat);
					 if(result != GlobalConstant.ZERO_LINE){
						 return GlobalConstant.SAVE_SUCCESSED;
					 }
				 }
			 }
			return GlobalConstant.SAVE_FAIL;
		}
		
		
		/**
		 * 删除一条获奖
		 * @param recordId
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/delSat",method={RequestMethod.POST})
		@ResponseBody
		public String delSat(SrmAchSat srmAchSat, Model model) throws Exception{
			if(null != srmAchSat){
				srmAchSat.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				int result = satBiz.save(srmAchSat);
				if(result != GlobalConstant.ZERO_LINE){
					return GlobalConstant.DELETE_SUCCESSED;
				}
			}
			return GlobalConstant.DELETE_FAIL;
		}
}


