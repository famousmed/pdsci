package com.pinde.sci.ctrl.res;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.jspform.ItemGroupData;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.Docx4jUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.res.IResRecBiz;
import com.pinde.sci.biz.sch.ISchArrangeBiz;
import com.pinde.sci.biz.sch.ISchArrangeResultBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDeptExternalRelBiz;
import com.pinde.sci.biz.sch.ISchDoctorAbsenceBiz;
import com.pinde.sci.biz.sch.ISchDoctorDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationGroupBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.biz.test.ITestResultBiz;
import com.pinde.sci.common.DateTrans;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.res.GlobalRecTypeEnum;
import com.pinde.sci.enums.res.GroupRoleEnum;
import com.pinde.sci.enums.res.PreRecTypeEnum;
import com.pinde.sci.enums.res.RecDocCategoryEnum;
import com.pinde.sci.enums.res.RecStatusEnum;
import com.pinde.sci.enums.res.RegistryTypeEnum;
import com.pinde.sci.enums.res.ResDoctorStatusEnum;
import com.pinde.sci.enums.res.ResRecTypeEnum;
import com.pinde.sci.enums.sch.SchUnitEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.hbres.ResRecForm;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResRec;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDeptExternalRel;
import com.pinde.sci.model.mo.SchDoctorAbsence;
import com.pinde.sci.model.mo.SchDoctorDept;
import com.pinde.sci.model.mo.SchRotation;
import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SchRotationGroup;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.TestResult;
import com.pinde.sci.model.res.ResDoctorExt;

@Controller
@RequestMapping("/res/doc")
public class ResDocController extends GeneralController{
	private static Logger logger = LoggerFactory.getLogger(ResDocController.class);
	
	@Resource
	private ISchRotationBiz schRotationtBiz;
	@Resource
	private IDeptBiz deptBiz;
	@Resource
	private IResDoctorBiz resDoctorBiz;
	@Resource
	private IUserBiz userBiz;
	@Resource
	private ISchArrangeResultBiz schArrangeResultBiz;
	@Resource
	private IResDoctorProcessBiz resDoctorProcessBiz;
	@Autowired
	private IResRecBiz resRecBiz;
	@Autowired
	private ISchRotationDeptBiz rotationDeptBiz;
	@Autowired
	private ISchDeptBiz schDeptBiz;
	@Autowired
	private NoticeBiz noticeBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Resource
	private ISchRotationGroupBiz schRotationtGroupBiz;
	@Resource
	private ISchDoctorDeptBiz schDoctorDeptBiz;
	@Resource
	private ISchRotationDeptBiz schRotationDeptBiz;
	@Resource
	private ISchDoctorAbsenceBiz schDoctorAbsenceBiz;
	@Resource
	private IUserRoleBiz userRoleBiz;
	@Resource
	private ISchDeptExternalRelBiz deptExtRelBiz;
	@Resource
	private IFileBiz fileBiz;
	@Resource
	private ITestResultBiz resultBiz;
	@Resource
	private ISchArrangeBiz arrangeBiz;
	
	@RequestMapping(value={"/user/docList"},method={RequestMethod.GET,RequestMethod.POST})
	public String docList(ResDoctorExt resDoctorExt,SysUser user,Model model){
		resDoctorExt.setSysUser(user);
		List<ResDoctorExt> doctorExtList = resDoctorBiz.searchDocUser(resDoctorExt);
		model.addAttribute("doctorExtList",doctorExtList);
		return "res/doctor/user/docList";
	}
	
	@RequestMapping(value={"/user/docEditDoc"},method={RequestMethod.GET})
	public String docEditDoc(Model model){
		String flow = GlobalContext.getCurrentUser().getUserFlow();
		model.addAttribute("doctorFlow",flow);
		model.addAttribute("userFlow",flow);
		model.addAttribute("isMenu",true);
		return "redirect:/res/doc/user/editDoc";
	}
	
	@RequestMapping(value={"/user/editDoc"},method={RequestMethod.GET})
	public String editDoc(String doctorFlow,String userFlow,Model model){
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = resDoctorBiz.readDoctor(doctorFlow);
			model.addAttribute("doctor",doctor);
			
			SysDept dept = new SysDept();
			dept.setOrgFlow(doctor.getOrgFlow());
			List<SysDept> deptList = deptBiz.searchDept(dept);
			model.addAttribute("deptList",deptList);
		}
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user = userBiz.readSysUser(userFlow);
			model.addAttribute("user",user);
		}
		
		List<SchRotation> rotationList = schRotationtBiz.searchSchRotationByIsPublish();
		model.addAttribute("rotationList",rotationList);
		
//		if(StringUtil.isNotBlank(doctorFlow)){
//			ResDoctor doctor = resDoctorBiz.readDoctor(doctorFlow);
//			model.addAttribute("doctor",doctor);
//			SysUser user = userBiz.readSysUser(doctorFlow);
//			model.addAttribute("user",user);
//			
//			SchRotation rotation = new SchRotation();
//			rotation.setDoctorCategoryId(doctor.getDoctorCategoryId());
//			rotation.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
//			List<SchRotation> rotationList = schRotationtBiz.searchRotationByRole(null,rotation);
//			model.addAttribute("rotationList",rotationList);
//		}
		return "res/doctor/user/editDoc";
	}
	
	@RequestMapping(value={"/user/saveDocSimple"},method={RequestMethod.POST})
	@ResponseBody
	public String saveDocSimple(SysUser user,ResDoctor doctor,String roleFlag){
//		if(doctor!=null){
//			if(GlobalConstant.USER_LIST_GLOBAL.equals(roleFlag)){
//				String orgFlow = doctor.getOrgFlow();
//				String rotationFlow = doctor.getrotationFlow();
//				if(StringUtil.isNotBlank(rotationFlow) && StringUtil.isNotBlank(orgFlow)){
//					SchRotation rotation = schRotationtBiz.readRotationByStandardAndOrg(orgFlow,rotationFlow);
//					if(rotation==null){
//						rotation = schRotationtBiz.readSchRotation(rotationFlow);
//						rotation.setRotationFlow(rotation.getRotationFlow());
//						rotation.setOrgFlow(orgFlow);
//						rotation.setRotationTypeId(SchRotationTypeEnum.Local.getId());
//						rotation.setRotationTypeName(SchRotationTypeEnum.Local.getName());
//						rotation.setRotationFlow(null);
//						if(GlobalConstant.ZERO_LINE==schRotationtBiz.saveSchRotation(rotation)){
//							return GlobalConstant.SAVE_FAIL;
//						}
//					}
//					doctor.setRotationFlow(rotation.getRotationFlow());
//				}
//			}
//		}
		return saveDoc(user,doctor,roleFlag);
	}
	
	@RequestMapping(value={"/user/saveDoc"},method={RequestMethod.POST})
	@ResponseBody
	public String saveDoc(SysUser user,ResDoctor doctor,String roleFlag){
		String orgFlow = "";
		String orgName = "";
		
		if(StringUtil.isNotBlank(doctor.getOrgFlow())){
			SysOrg org = orgBiz.readSysOrg(doctor.getOrgFlow());
			if(org!=null){
				orgFlow = org.getOrgFlow();
				orgName = org.getOrgName();
			}
		}else{
			orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			orgName = GlobalContext.getCurrentUser().getOrgName();
		}
		
		String doctorName = "";
		if(user!=null){
			if(StringUtil.isBlank(user.getUserFlow())){
				SysUser old = userBiz.findByUserCode(user.getUserCode());
				if(old!=null){
					return GlobalConstant.USER_CODE_REPETE;
				}	
				old = userBiz.findByIdNo(user.getIdNo());
				if(old!=null){
					return GlobalConstant.USER_ID_NO_REPETE;
				}		
				old = userBiz.findByUserPhone(user.getUserPhone());
				if(old!=null){
					return GlobalConstant.USER_PHONE_REPETE;
				}		
				old = userBiz.findByUserEmail(user.getUserEmail());
				if(old!=null){
					return GlobalConstant.USER_EMAIL_REPETE;
				}	
			}else{
				String userFlow = user.getUserFlow();
				SysUser old = userBiz.findByUserCodeNotSelf(userFlow,user.getUserCode());
				if(old!=null){
					return GlobalConstant.USER_CODE_REPETE;
				}	
				old = userBiz.findByIdNoNotSelf(userFlow,user.getIdNo());
				if(old!=null){
					return GlobalConstant.USER_ID_NO_REPETE;
				}		
				old = userBiz.findByUserPhoneNotSelf(userFlow,user.getUserPhone());
				if(old!=null){
					return GlobalConstant.USER_PHONE_REPETE;
				}		
				old = userBiz.findByUserEmailNotSelf(userFlow,user.getUserEmail());
				if(old!=null){
					return GlobalConstant.USER_EMAIL_REPETE;
				}	
			}
			
			user.setSexName(UserSexEnum.getNameById(user.getSexId()));
			SysDept dept = deptBiz.readSysDept(user.getDeptFlow());
			if(dept!=null){
				user.setDeptName(dept.getDeptName());
			}
//			user.setOrgFlow(orgFlow);
//			user.setOrgName(orgName);
			user.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow()); //人员记录所属机构与部门
			user.setOrgName(GlobalContext.getCurrentUser().getOrgName());
			user.setTitleName(DictTypeEnum.UserTitle.getDictNameById(user.getTitleId()));
			user.setPostName(DictTypeEnum.UserPost.getDictNameById(user.getPostId()));
			user.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(user.getDegreeId()));
			user.setEducationName(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));
			doctorName = user.getUserName();
		}
		if(doctor!=null){
			doctor.setDoctorName(doctorName);
			doctor.setOrgFlow(orgFlow);
			doctor.setOrgName(orgName);
			//doctor.setDeptFlow(user.getDeptFlow()); //???
			//doctor.setDeptName(user.getDegreeName());//????
			if(StringUtil.isNotBlank(doctor.getDoctorTypeId())){
				doctor.setDoctorTypeName(DictTypeEnum.DoctorType.getDictNameById(doctor.getDoctorTypeId()));
			}else{
				doctor.setDoctorTypeName("");
			}
			doctor.setGraduatedName(DictTypeEnum.GraduateSchool.getDictNameById(doctor.getGraduatedId()));
			doctor.setTrainingTypeName(DictTypeEnum.TrainingType.getDictNameById(doctor.getTrainingTypeId()));
			doctor.setTrainingSpeName(DictTypeEnum.DoctorTrainingSpe.getDictNameById(doctor.getTrainingSpeId()));
			SchRotation rotation = schRotationtBiz.readSchRotation(doctor.getRotationFlow());
			if(rotation!=null){
				doctor.setRotationName(rotation.getRotationName());
			}
			if(StringUtil.isNotBlank(doctor.getDoctorStatusId())){
				doctor.setDoctorStatusName(ResDoctorStatusEnum.getNameById(doctor.getDoctorStatusId()));
			}else{
				doctor.setDoctorStatusName("");
			}
			if(!StringUtil.isNotBlank(doctor.getRecordStatus())){
				doctor.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			}
			if(StringUtil.isNotBlank(doctor.getDoctorCategoryId())){
				doctor.setDoctorCategoryName(RecDocCategoryEnum.getNameById(doctor.getDoctorCategoryId()));
			}
			//根据医师状态，清空相应字段
			if (ResDoctorStatusEnum.Terminat.getId().equals(doctor.getDoctorStatusId())) {
				doctor.setCompleteNo("");
				doctor.setCompleteDate("");
			} else if (ResDoctorStatusEnum.Graduation.getId().equals(doctor.getDoctorStatusId())) {
				doctor.setTerminatReason("");
				doctor.setTerminatDate("");
			} else {
				doctor.setCompleteNo("");
				doctor.setCompleteDate("");
				doctor.setTerminatReason("");
				doctor.setTerminatDate("");
			}
		}
		if(GlobalConstant.ZERO_LINE!=resDoctorBiz.editDocUser(doctor, user)){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 医师主页1
	 */
	@RequestMapping(value="/beforeDoctorMain",method=RequestMethod.GET)
	public String beforeDoctorMain(){
		String url = (String)getSessionAttribute("viewUrl");
		if(!StringUtil.isNotBlank(url)){
			url = "/res/doc/doctorMain";
		}
		return "redirect:"+url;
	}
	
	/**
	 * 医师主页2
	 */
	@RequestMapping(value="/doctorMain",method=RequestMethod.GET)
	public String doctorMain(Model model){
		ResDoctor doctor = (ResDoctor) getSessionAttribute("currDoctor");
		model.addAttribute("doctor", doctor);
		if (doctor==null || GlobalConstant.FLAG_N.equals(InitConfig.getSysCfg("res_doctor_category_"+doctor.getDoctorCategoryId()+"_sch"))) {
			return "redirect:/resedu/student/studyCenter";
		}
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		ResDoctor dbDoctor = resDoctorBiz.readDoctor(userFlow);
		if(dbDoctor!=null){
//			if(!StringUtil.isNotBlank(doctor.getRotationFlow())){
//				schArrangeResultBiz.createFreeRosteringResult(doctor);
//			}
			if(!GlobalConstant.FLAG_Y.equals(dbDoctor.getSelDeptFlag()) && GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_doc_seldept"))){
				return "redirect:/res/doc/selDeptAndRosteringHand";
			}
			if(GlobalConstant.FLAG_Y.equals(dbDoctor.getSelDeptFlag()) && !GlobalConstant.FLAG_Y.equals(dbDoctor.getSchFlag()) && GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_doc_rostering"))){
				return "redirect:/res/doc/selDeptAndRosteringHand";
			}
		}
		return "redirect:/res/doc/searchRotationList";
	}
	
	/**
	 * 学习中心视图
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/studyCenter",method=RequestMethod.GET)
	public String studyCenter(Model model){
		return "res/edu/student/studyCenter";
	}
	
	/**
	 * 个人轮转计划
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/searchRotationList",method=RequestMethod.GET)
	public String searchRotationList(Model model){
		SysUser user = GlobalContext.getCurrentUser();
		String userFlow = user.getUserFlow();
		
		ResDoctor doctor = resDoctorBiz.readDoctor(userFlow);
		model.addAttribute("doctor", doctor);
		if(doctor!=null && GlobalConstant.FLAG_Y.equals(doctor.getSchFlag())){
//			List<String> doctorFlows = new ArrayList<String>();
//			doctorFlows.add(userFlow);
			List<SchArrangeResult> arrResultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(userFlow);
			if(arrResultList!=null&&!arrResultList.isEmpty()){
				List<String> schResultFlows = new ArrayList<String>();
				for (SchArrangeResult result : arrResultList) {
					schResultFlows.add(result.getResultFlow());
				}
				model.addAttribute("arrResultList", arrResultList);
				
				List<ResDoctorSchProcess> processList = resDoctorProcessBiz.searchByResultFlows(schResultFlows);
				if(processList!=null && processList.size()>0){
					Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
					Map<String,String> recContentMap = new HashMap<String, String>();
					for(ResDoctorSchProcess process : processList){
						processMap.put(process.getSchResultFlow(),process);
//						if(GlobalConstant.FLAG_Y.equals(process.getIsCurrentFlag())){
//							List<ResRec> sRecList = resRecBiz.searchByRecWithBLOBs(ResRecTypeEnum.AfterSummary.getId(),process.getSchDeptFlow(),process.getUserFlow());
//							if(sRecList!=null && sRecList.size()>0){
//								ResRec rec = sRecList.get(0);
//								recContentMap = resRecBiz.parseRecContent(rec.getRecContent());
//								recContentMap.put(process.getSchResultFlow(),recContentMap.get("isAgaree"));
//							}
//						}
						recContentMap.put(process.getSchResultFlow(),process.getSchFlag());
					}
					model.addAttribute("processMap", processMap);
					model.addAttribute("recContentMap", recContentMap);
				}
				
				List<SchDept> schDeptList = schDeptBiz.searchSchDeptList(doctor.getOrgFlow());
				if(schDeptList!=null && schDeptList.size()>0){
					Map<String,SchDept> schDeptMap = new HashMap<String, SchDept>();
					for(SchDept dept : schDeptList){
						schDeptMap.put(dept.getSchDeptFlow(),dept);
					}
					model.addAttribute("schDeptMap", schDeptMap);
				}
				
				Map<String,String> finishPerMap = resRecBiz.getFinishPer(arrResultList);
				model.addAttribute("finishPerMap", finishPerMap);
			}
		}
		//通知
		String beforeSevenDay = DateUtil.addHour(DateUtil.getCurrDateTime(),-7*24).substring(0,8);
		List<InxInfo> infos = this.noticeBiz.searchInfoByOrgBeforeDate(user.getOrgFlow(),beforeSevenDay);
		model.addAttribute("infos",infos);
		
		return "res/doctor/sch";
	}
	
	/**
	 * 公告列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/noticeList",method=RequestMethod.GET)
	public String noticeList(Integer currentPage ,HttpServletRequest request, Model model){
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		
		List<InxInfo> infos = this.noticeBiz.searchInfoByOrgBeforeDate(GlobalContext.getCurrentUser().getOrgFlow(),null);
		model.addAttribute("infos",infos);
		return "/res/notice/noticeList";
	}
	
	/**
	 * 轮转计划详情
	 * @param resultFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/rotationDetail",method=RequestMethod.GET)
	public String rotationDetail(String resultFlow,String schDeptFlow,Model model){
		/**
		
		if(StringUtil.isNotBlank(resultFlow)){
			ResDoctorProcess process = this.resDoctorProcessBiz.searchByResultFlow(resultFlow);
			model.addAttribute("process", process);
		}
		
		//参加活动数量
		List<ResRec> campaignList = resRecBiz.searchByRec(ResRecTypeEnum.CampaignRegistry.getId(),schDeptFlow,GlobalContext.getCurrentUser().getUserFlow());
		model.addAttribute("campaignList", campaignList);
		
		//科室考评
		List<ResRec> deptGradeList = resRecBiz.searchByRec(ResRecTypeEnum.DeptGrade.getId(),schDeptFlow,GlobalContext.getCurrentUser().getUserFlow());
		if(deptGradeList!=null && deptGradeList.size()>0){
			Map<String,Object> gradeMap = resRecBiz.parseGradeXml(deptGradeList.get(0).getRecContent());
			model.addAttribute("deptGrade", deptGradeList.get(0));
			model.addAttribute("deptGradeMap",gradeMap);
		}
		
		//带教老师考评
		List<ResRec> teacherGradeList = resRecBiz.searchByRec(ResRecTypeEnum.TeacherGrade.getId(),schDeptFlow,GlobalContext.getCurrentUser().getUserFlow());
		if(teacherGradeList!=null && teacherGradeList.size()>0){
			Map<String,Object> gradeMap = resRecBiz.parseGradeXml(teacherGradeList.get(0).getRecContent());
			model.addAttribute("teacherGrade", teacherGradeList.get(0));
			model.addAttribute("teacherGradeMap", gradeMap);
		}
		//return "res/doctor/main";
		 
		*/
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		
		return goDetailView(resultFlow,schDeptFlow,userFlow,model);
	}
	
	@RequestMapping(value="/goDetailView",method=RequestMethod.GET)
	public String goDetailView(String resultFlow,String schDeptFlow,String userFlow,Model model){
		
//		List<String> doctorFlows = new ArrayList<String>();
//		doctorFlows.add(userFlow);
//		List<SchArrangeResult> arrResultList = schArrangeResultBiz.searchArrangeResultByDoctorFlows(doctorFlows);
		List<SchArrangeResult> arrResultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(userFlow);
		if(arrResultList!=null&&!arrResultList.isEmpty()){
			List<String> schResultFlows = new ArrayList<String>();
			for (SchArrangeResult result : arrResultList) {
				schResultFlows.add(result.getResultFlow());
			}
			model.addAttribute("arrResultList", arrResultList);
			
			List<ResDoctorSchProcess> processList = resDoctorProcessBiz.searchByResultFlows(schResultFlows);
			if(processList!=null && processList.size()>0){
				Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
				for(ResDoctorSchProcess process : processList){
					processMap.put(process.getSchResultFlow(),process);
				}
				model.addAttribute("processMap", processMap);
			}
			
			Map<String,String> finishPerMap = resRecBiz.getFinishPer(arrResultList);
			model.addAttribute("finishPerMap", finishPerMap);
		}
		
		return "res/doctor/process";
	}
	
	/**
	 * 显示登记信息界面
	 * @return
	 */
	@RequestMapping(value="/registryView",method=RequestMethod.GET)
	public String registryView(String resultFlow,String schDeptFlow,Model model){
		
		return "res/doctor/registryView";
	}
	
	/**
	 * 显示选择带教老师和科主任界面
	 * @return
	 */
	@RequestMapping(value="/showChoose",method=RequestMethod.GET)
	public String showChoose(String schDeptFlow,Model model){
		if(StringUtil.isNotBlank(schDeptFlow)){
			SchDept dept = schDeptBiz.readSchDept(schDeptFlow);
			if(dept!=null){
				String deptFlow = dept.getDeptFlow();
				if(GlobalConstant.FLAG_Y.equals(dept.getIsExternal())){
					SchDeptExternalRel deptExtRel = deptExtRelBiz.readSchDeptExtRelBySchDept(schDeptFlow);
					if(deptExtRel!=null){
						deptFlow = deptExtRel.getRelDeptFlow();
					}
				}
				
//				List<String> roleFlows = new ArrayList<String>();
				String teacherRoleFlow = InitConfig.getSysCfg("res_teacher_role_flow");
				String headRoleFlow = InitConfig.getSysCfg("res_head_role_flow");
				
				List<SysUser> teacherList = userBiz.searchUserByDeptAndRole(deptFlow,teacherRoleFlow);
				model.addAttribute("teacherList",teacherList);
				
				List<SysUser> headList = userBiz.searchUserByDeptAndRole(deptFlow,headRoleFlow);
				model.addAttribute("headList",headList);
//				roleFlows.add(teacherRoleFlow);
//				roleFlows.add(headRoleFlow);
//				if(roleFlows.size()>0){
//					ResDoctor doctor = (ResDoctor)getSessionAttribute("currDoctor");
					
					//List<SysUserDept> userDeptList = userBiz.searchUserDeptByDept(deptFlow);
					
//					String orgFlow = doctor.getOrgFlow();
//					if(StringUtil.isNotBlank(orgFlow)){
//						List<SysUserRole> userRoleList = userRoleBiz.searchUserByRoles(roleFlows, orgFlow);
//						if(userRoleList!=null && userRoleList.size()>0){
//							Map<String,List<String>> userFlowsMap = new HashMap<String, List<String>>(); 
//							for(SysUserRole userRole : userRoleList){
//								String key = userRole.getRoleFlow();
//								if(userFlowsMap.get(key)==null){
//									List<String> userFlows = new ArrayList<String>();
//									userFlows.add(userRole.getUserFlow());
//									userFlowsMap.put(key,userFlows);
//								}else{
//									userFlowsMap.get(key).add(userRole.getUserFlow());
//								}
//							}
//							
//							
//							if(StringUtil.isNotBlank(deptFlow)){
//								List<SysUser> teacherList = userBiz.searchSysUserByuserFlows(userFlowsMap.get(teacherRoleFlow),deptFlow);
//								model.addAttribute("teacherList",teacherList);
//								List<SysUser> headList = userBiz.searchSysUserByuserFlows(userFlowsMap.get(headRoleFlow),deptFlow);
//								model.addAttribute("headList",headList);
//							}
//						}
//					}
//				}
			}
		}
		return "res/doctor/showChoose";
	}
	
	/**
	 * 选择带教老师或科主任
	 * @param resultFlow 轮转计划流水号
	 * @param roleFlow 角色流水号
	 * @param model
	 * @return
	 
	@RequestMapping(value="/chooseTeacherOrHead",method=RequestMethod.GET)
	public String chooseTeacherOrHead(String resultFlow,String roleFlow, Model model ){
		List<SysUser> userList = this.resDoctorBiz.searchTeacherOrHead(resultFlow, roleFlow);
		model.addAttribute("userList", userList);
		return "res/doctor/chooseTeacherOrHead";
	}*/
	
	/**
	 * 保存带教老师或科主任
	 * @param process
	 * @param resultFlow
	 * @param preResultFlow
	 * @return
	 */
	@RequestMapping(value="/saveChoose",method=RequestMethod.POST)
	@ResponseBody
	public String saveChoose(ResDoctorSchProcess process,String resultFlow,String preResultFlow){
		this.resDoctorBiz.saveChoose(process, resultFlow, preResultFlow);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	/**
	 * 显示修改轮转时间界面
	 * @param processFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showModifySchDate",method=RequestMethod.GET)
	public String showModifySchDate(String processFlow,Model model){
		ResDoctorSchProcess process = this.resDoctorProcessBiz.read(processFlow);
		model.addAttribute("process", process);
		return "res/doctor/modSchDate";
	}
	/**
	 * 显示修改带教老师和科主任界面
	 * @param processFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/changeDeptAndTeacher",method=RequestMethod.GET)
	public String changeDeptAndTeacher(String processFlow,Model model){
		ResDoctorSchProcess process = this.resDoctorProcessBiz.read(processFlow);
		if(process!=null){
			model.addAttribute("process", process);
			
			String schDeptFlow = process.getSchDeptFlow(); 
			if(StringUtil.isNotBlank(schDeptFlow)){
				SchDept dept = schDeptBiz.readSchDept(schDeptFlow);
				if(dept!=null){
					String deptFlow = dept.getDeptFlow();
					if(GlobalConstant.FLAG_Y.equals(dept.getIsExternal())){
						SchDeptExternalRel deptExtRel = deptExtRelBiz.readSchDeptExtRelBySchDept(schDeptFlow);
						if(deptExtRel!=null){
							deptFlow = deptExtRel.getRelDeptFlow();
						}
					}
					
					String teacherRoleFlow = InitConfig.getSysCfg("res_teacher_role_flow");
					String headRoleFlow = InitConfig.getSysCfg("res_head_role_flow");
					
					List<SysUser> teacherList = userBiz.searchUserByDeptAndRole(deptFlow,teacherRoleFlow);
					model.addAttribute("teacherList",teacherList);
					
					List<SysUser> headList = userBiz.searchUserByDeptAndRole(deptFlow,headRoleFlow);
					model.addAttribute("headList",headList);
				}
			}
		}
		return "res/doctor/changeDeptAndTeacher";
	}
	/**
	 * 修改轮转时间
	 * @param process
	 * @return
	 */
	@RequestMapping(value="/modifySchDate",method=RequestMethod.POST)
	@ResponseBody
	public String modifySchDate(ResDoctorSchProcess process){
		int result = this.resDoctorProcessBiz.edit(process);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 登记手册
	 */
	@RequestMapping(value="/registryNoteBook",method=RequestMethod.GET)
	public String registryNoteBook(String schDeptFlow,String resultFlow,Model model){
		SysUser user = GlobalContext.getCurrentUser();
		model.addAttribute("user",user);
		
		String userFlow = user.getUserFlow();
		
		ResDoctor doctor = resDoctorBiz.readDoctor(userFlow);
		model.addAttribute("doctor",doctor);
		
		if(StringUtil.isNotBlank(schDeptFlow)){
			SchDept dept = schDeptBiz.readSchDept(schDeptFlow);
			model.addAttribute("dept",dept);
		}
		
		List<String> doctorFlows = new ArrayList<String>();
		doctorFlows.add(userFlow);
		List<SchArrangeResult> arrResultList = schArrangeResultBiz.searchArrangeResultByDoctorFlows(doctorFlows);
		if(arrResultList!=null&&!arrResultList.isEmpty()){
			List<String> schResultFlows = new ArrayList<String>();
			for (SchArrangeResult result : arrResultList) {
				schResultFlows.add(result.getResultFlow());
			}
			model.addAttribute("arrResultList", arrResultList);
			
			List<ResDoctorSchProcess> processList = resDoctorProcessBiz.searchByResultFlows(schResultFlows);
			if(processList!=null && processList.size()>0){
				Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
				for(ResDoctorSchProcess process : processList){
					processMap.put(process.getSchResultFlow(),process);
				}
				model.addAttribute("processMap", processMap);
			}
			
			Map<String,String> finishPerMap = resRecBiz.getFinishPer(arrResultList);
			model.addAttribute("finishPerMap", finishPerMap);
		}
		
		SchArrangeResult result = schArrangeResultBiz.readSchArrangeResult(resultFlow);
		List<SchRotationDeptReq> deptReqList = rotationDeptBiz.searchStandardReqByResult(result);
		Map<String,Integer> countMap = new HashMap<String, Integer>();
		if(deptReqList!=null && deptReqList.size()>0){
			Map<String,List<SchRotationDeptReq>> reqMap = new HashMap<String, List<SchRotationDeptReq>>();
			for(SchRotationDeptReq req : deptReqList){
				String key = req.getRecTypeId()+req.getItemId()+"req";
				Integer num = req.getReqNum().intValue();
				if(countMap.get(key)==null){
					countMap.put(key,num);
				}else{
					countMap.put(key,countMap.get(key)+num);
				}
				
				if(reqMap.get(req.getRecTypeId())==null){
					List<SchRotationDeptReq> reqList = new ArrayList<SchRotationDeptReq>();
					reqList.add(req);
					reqMap.put(req.getRecTypeId(),reqList);
				}else{
					reqMap.get(req.getRecTypeId()).add(req);
				}
			}
			model.addAttribute("reqMap",reqMap);
		}
		
		List<String> recTypeIds = new ArrayList<String>();
		for(RegistryTypeEnum regType : RegistryTypeEnum.values()){
			if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_registry_type_"+regType.getId()))){
				recTypeIds.add(regType.getId());
			}
		}
		recTypeIds.add(ResRecTypeEnum.AfterSummary.getId());
		List<ResRec> recList = resRecBiz.searchByRecWithBLOBs(recTypeIds, schDeptFlow, userFlow);
		
		if(recList!=null && recList.size()>0){
			model.addAttribute("recList",recList);
			
			Map<String,List<ResRec>> recMap = new HashMap<String, List<ResRec>>();
			Map<String,Map<String,String>> recContentMap = new HashMap<String, Map<String,String>>();
			for(ResRec rec : recList){
				String key = rec.getRecTypeId()+rec.getItemId();
				
				if(recMap.get(rec.getRecTypeId())==null){
					List<ResRec> recs = new ArrayList<ResRec>();
					recs.add(rec);
					recMap.put(rec.getRecTypeId(),recs);
				}else{
					recMap.get(rec.getRecTypeId()).add(rec);
				}
				
				Map<String,String> content = resRecBiz.parseRecContent(rec.getRecContent());
				recContentMap.put(rec.getRecFlow(),content);
					
				if(RecStatusEnum.TeacherAuditY.getId().equals(rec.getAuditStatusId())){
					if(countMap.get(key+"audit")==null){
						countMap.put(key+"audit",1);
					}else{
						countMap.put(key+"audit",countMap.get(key+"audit")+1);
					}
				}
				
				if(countMap.get(key+"finish")==null){
					countMap.put(key+"finish",1);
				}else{
					countMap.put(key+"finish",countMap.get(key+"finish")+1);
				}
			}
			////
			model.addAttribute("recMap",recMap);
			model.addAttribute("recContentMap",recContentMap);
		}
		
		model.addAttribute("countMap",countMap);
		
		return "res/doctor/registryNoteBook";
	}
	
	/**
	 * 医师选科
	 */
	@RequestMapping(value="/selDept",method=RequestMethod.GET)
	public String selDept(Model model){
		String doctorFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		if(StringUtil.isNotBlank(doctorFlow)){
			List<SchArrangeResult> resultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
			model.addAttribute("resultList",resultList);
			
			ResDoctor doctor = resDoctorBiz.readDoctor(doctorFlow);
			String rotationFlow = "";
			if(doctor!=null){
				model.addAttribute("doctor",doctor);
				rotationFlow = doctor.getRotationFlow();
			}
			if(StringUtil.isNotBlank(rotationFlow)){
				//科室组
				List<SchRotationGroup> rotationGroupList = schRotationtGroupBiz.searchOrgGroupOrAll(rotationFlow,doctor.getOrgFlow(),GlobalConstant.FLAG_N);
				model.addAttribute("rotationGroupList",rotationGroupList);
				
				//组合科室
				List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchOrgSchRotationDeptGroup(rotationFlow,doctor.getOrgFlow());
				if(rotationDeptList != null && rotationDeptList.size()>0){
					Map<String,List<SchRotationDept>> rotationDeptMap = new HashMap<String,List<SchRotationDept>>();
					for(SchRotationDept rotationDept : rotationDeptList){
						if(rotationDeptMap.get(rotationDept.getGroupFlow()) == null){
							List<SchRotationDept> rotationDeptTempList = new ArrayList<SchRotationDept>();
							rotationDeptTempList.add(rotationDept);
							rotationDeptMap.put(rotationDept.getGroupFlow(),rotationDeptTempList);
						}else{
							rotationDeptMap.get(rotationDept.getGroupFlow()).add(rotationDept);
						}
					}
					model.addAttribute("rotationDeptMap",rotationDeptMap);
				}
			}
			if(StringUtil.isNotBlank(doctorFlow)){
				//已选科室
				List<SchDoctorDept> doctorDeptList = schDoctorDeptBiz.searchSchDoctorDept(doctorFlow);
				if(doctorDeptList != null && doctorDeptList.size()>0){
					Map<String,SchDoctorDept> doctorDeptMap = new HashMap<String,SchDoctorDept>();
					for(SchDoctorDept doctorDept : doctorDeptList){
						doctorDeptMap.put(doctorDept.getGroupFlow()+doctorDept.getSchDeptFlow(),doctorDept);
					}
					model.addAttribute("doctorDeptMap",doctorDeptMap);
				}
			}
		}
		return "res/doctor/arrange/seldeptItem";
	}
	
	/**
	 * 个人手动排班
	 */
	@RequestMapping(value="/rosteringHandDept",method=RequestMethod.GET)
	public String rosteringHandDept(Model model){
		String doctorFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = resDoctorBiz.readDoctor(doctorFlow);
			model.addAttribute("doctor",doctor);
			
			SchRotation rotation = schRotationtBiz.readSchRotation(doctor.getRotationFlow());
			model.addAttribute("rotationYear",rotation.getRotationYear());
			
			List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchOrgSchRotationDeptMust(doctor.getRotationFlow(),doctor.getOrgFlow());
			model.addAttribute("rotationDeptList",rotationDeptList);
			
			if(GlobalConstant.FLAG_Y.equals(doctor.getSelDeptFlag())){
				List<SchRotationDept> rotationDeptTempList = schRotationDeptBiz.searchOrgSchRotationDeptGroup(doctor.getRotationFlow(),doctor.getOrgFlow());
				if(rotationDeptTempList != null && rotationDeptTempList.size()>0){
					Map<String,SchRotationDept> rotationDeptMap = new HashMap<String,SchRotationDept>();
					for(SchRotationDept rotationDept : rotationDeptTempList){
						rotationDeptMap.put(rotationDept.getGroupFlow()+rotationDept.getSchDeptFlow(),rotationDept);
					}
					model.addAttribute("rotationDeptMap",rotationDeptMap);
				}
				
				List<SchRotationGroup> rotationGroupList = schRotationtGroupBiz.searchOrgGroupOrAll(doctor.getRotationFlow(),doctor.getOrgFlow(),GlobalConstant.FLAG_N);
				if(rotationGroupList != null && rotationGroupList.size()>0){
					Map<String,SchRotationGroup> rotationGroupMap = new HashMap<String,SchRotationGroup>();
					for(SchRotationGroup rotationGroup : rotationGroupList){
						rotationGroupMap.put(rotationGroup.getGroupFlow(),rotationGroup);
					}
					model.addAttribute("rotationGroupMap",rotationGroupMap);
				}
				
				List<SchDoctorDept> doctorDeptList = schDoctorDeptBiz.searchSchDoctorDept(doctorFlow);
				model.addAttribute("doctorDeptList",doctorDeptList);
				
				List<SchArrangeResult> resultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
				if(resultList != null && resultList.size()>0){
					Map<String,SchArrangeResult> resultMap = new HashMap<String,SchArrangeResult>();
					for(SchArrangeResult arrResult : resultList){
						resultMap.put(arrResult.getSchDeptFlow()+arrResult.getSchYear(),arrResult);
					}
					model.addAttribute("resultMap",resultMap);
				}
			}
		}
		return "res/doctor/arrange/rosteringHand";
	}
	
	/**
	 * TODO 选科+排班
	 */
	@RequestMapping(value="/selDeptAndRosteringHand",method=RequestMethod.GET)
	public String selDeptAndRosteringHand(Model model){
		//医师流水号
		String doctorFlow = GlobalContext.getCurrentUser().getUserFlow();
		//String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = resDoctorBiz.readDoctor(doctorFlow);
			if(doctor!=null){
				model.addAttribute("doctor",doctor);
				
				//Integer sessionNumber = Integer.parseInt(doctor.getSessionNumber());
				String rotationFlow = doctor.getRotationFlow();
				String orgFlow = doctor.getOrgFlow();
				
				SchRotation rotation = schRotationtBiz.readSchRotation(rotationFlow);
				model.addAttribute("rotation",rotation);
				
				if(StringUtil.isNotBlank(orgFlow)){
					int unRelCount = schRotationDeptBiz.getUnrelCount(orgFlow,rotationFlow);
					model.addAttribute("relFlag",unRelCount>0 && StringUtil.isNotBlank(rotationFlow));
				}
				
				List<SchRotationGroup> groupList = null;
				if(StringUtil.isNotBlank(orgFlow)){
					groupList = schRotationtGroupBiz.searchOrgGroupOrAll(rotationFlow,orgFlow,null);
				}
				if(groupList!=null && groupList.size()>0){
					Map<String,SchRotationGroup> stageGroupMap = new HashMap<String, SchRotationGroup>();
					for(SchRotationGroup group : groupList){
						stageGroupMap.put(group.getGroupFlow(),group);
					}
					model.addAttribute("stageGroupMap",stageGroupMap);
				}
				
				List<SchArrangeResult> resultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
				if(GlobalConstant.FLAG_Y.equals(doctor.getSelDeptFlag()) && (resultList==null || resultList.size()<1)){
					createRosting();
					resultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
				}
				
				if(!StringUtil.isNotBlank(doctor.getSchStatusId())){
					List<SysDept> sysDeptList = null;
					if (StringUtil.isNotBlank(doctor.getOrgFlow())) {
						sysDeptList = deptBiz.searchDeptByOrg(doctor.getOrgFlow());
					}
					if(sysDeptList!=null && sysDeptList.size()>0){
						List<String> deptFlows = new ArrayList<String>();
						for(SysDept dept : sysDeptList){
							deptFlows.add(dept.getDeptFlow());
						}
						List<SchDept> deptList = schDeptBiz.searchDeptByDeotFlows(deptFlows);
						model.addAttribute("schDeptList",deptList);
					}
				}
				
				if(resultList!=null && resultList.size()>0){
					model.addAttribute("resultList",resultList);
					
					Map<String,SchArrangeResult> resultMap = new HashMap<String, SchArrangeResult>();
					for(SchArrangeResult result : resultList){
						if(!StringUtil.isNotBlank(result.getStandardDeptId())){
							resultMap.put(result.getSchDeptFlow(),result);
						}
					}
					model.addAttribute("resultMap",resultMap);
					
					if(GlobalConstant.FLAG_Y.equals(doctor.getSchFlag())){
//						if(resultList!=null&&!resultList.isEmpty()){
//							List<String> schResultFlows = new ArrayList<String>();
//							for (SchArrangeResult result : resultList) {
//								schResultFlows.add(result.getResultFlow());
//							}
//							
//							List<ResDoctorSchProcess> processList = resDoctorProcessBiz.searchByResultFlows(schResultFlows);
//							if(processList!=null && processList.size()>0){
//								Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
//								Map<String,String> recContentMap = new HashMap<String, String>();
//								for(ResDoctorSchProcess process : processList){
//									processMap.put(process.getSchResultFlow(),process);
////									if(GlobalConstant.FLAG_Y.equals(process.getIsCurrentFlag())){
////										List<ResRec> sRecList = resRecBiz.searchByRecWithBLOBs(ResRecTypeEnum.AfterSummary.getId(),process.getSchDeptFlow(),process.getUserFlow());
////										if(sRecList!=null && sRecList.size()>0){
////											ResRec rec = sRecList.get(0);
////											recContentMap = resRecBiz.parseRecContent(rec.getRecContent());
////											recContentMap.put(process.getSchResultFlow(),recContentMap.get("isAgaree"));
////										}
////									}
////									recContentMap.put(process.getSchResultFlow(),process.getSchFlag());
//								}
//								model.addAttribute("processMap", processMap);
//								model.addAttribute("recContentMap", recContentMap);
//							}
//							
//							Map<String,String> finishPerMap = resRecBiz.getFinishPer(resultList);
//							model.addAttribute("finishPerMap", finishPerMap);
//						}
						
						//通知
//						InxInfo info = new InxInfo();
//						List<InxInfo> infos = this.noticeBiz.searchSevenDaysNotice(info);
//						model.addAttribute("infos",infos);
						return "redirect:/res/doc/searchRotationList";
					}else{
						if(resultList!=null&&!resultList.isEmpty()){
							List<String> schResultFlows = new ArrayList<String>();
							for (SchArrangeResult result : resultList) {
								schResultFlows.add(result.getResultFlow());
							}
							
							List<ResDoctorSchProcess> processList = resDoctorProcessBiz.searchByResultFlows(schResultFlows);
							if(processList!=null && processList.size()>0){
								Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
								for(ResDoctorSchProcess process : processList){
									processMap.put(process.getSchResultFlow(),process);
								}
								model.addAttribute("processMap", processMap);
							}
						}
						
						//科室组
						List<SchRotationGroup> rotationGroupList = schRotationtGroupBiz.searchOrgGroupOrAll(rotationFlow,doctor.getOrgFlow(),GlobalConstant.FLAG_N);
						if(rotationGroupList!=null && rotationGroupList.size()>0){
							model.addAttribute("rotationGroupList",rotationGroupList);
							Map<String,SchRotationGroup> groupMap = new HashMap<String, SchRotationGroup>();
							for(SchRotationGroup group : rotationGroupList){
								groupMap.put(group.getGroupFlow(),group);
							}
							model.addAttribute("groupMap",groupMap);
						}
					}
				}else{
					if(StringUtil.isNotBlank(rotationFlow)){
						//科室组
						List<SchRotationGroup> rotationGroupList = schRotationtGroupBiz.searchOrgGroupOrAll(rotationFlow,doctor.getOrgFlow(),GlobalConstant.FLAG_N);
						model.addAttribute("rotationGroupList",rotationGroupList);
						
						//组合科室
						List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchOrgSchRotationDeptGroup(rotationFlow,doctor.getOrgFlow());
						if(rotationDeptList != null && rotationDeptList.size()>0){
							Map<String,List<SchRotationDept>> rotationDeptMap = new HashMap<String,List<SchRotationDept>>();
							for(SchRotationDept rotationDept : rotationDeptList){
								if(rotationDeptMap.get(rotationDept.getGroupFlow()) == null){
									List<SchRotationDept> rotationDeptTempList = new ArrayList<SchRotationDept>();
									rotationDeptTempList.add(rotationDept);
									rotationDeptMap.put(rotationDept.getGroupFlow(),rotationDeptTempList);
								}else{
									rotationDeptMap.get(rotationDept.getGroupFlow()).add(rotationDept);
								}
							}
							model.addAttribute("rotationDeptMap",rotationDeptMap);
						}
						
						//已选科室
						List<SchDoctorDept> doctorDeptList = schDoctorDeptBiz.searchSchDoctorDept(doctorFlow);
						if(doctorDeptList != null && doctorDeptList.size()>0){
							Map<String,SchDoctorDept> doctorDeptMap = new HashMap<String,SchDoctorDept>();
							for(SchDoctorDept doctorDept : doctorDeptList){
								doctorDeptMap.put(doctorDept.getGroupFlow()+doctorDept.getSchDeptFlow(),doctorDept);
							}
							model.addAttribute("doctorDeptMap",doctorDeptMap);
						}
					}
				}
			}
		}
		return "res/doctor/arrange/selDeptAndRosteringHand";
	}
	
	/**
	 * TODO 保存选科
	 */
	@RequestMapping(value="/saveSelDept",method=RequestMethod.POST)
	@ResponseBody
	public String saveSelDept(String[] recordFlows,String[] schMonths){
		String doctorFlow = GlobalContext.getCurrentUser().getUserFlow();
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = resDoctorBiz.readDoctor(doctorFlow);
			
			List<String> recordFlowList = null;
			Map<String,String> schMonthMap = null;
			if(recordFlows!=null && recordFlows.length>0){
				schMonthMap = new HashMap<String, String>();
				recordFlowList = new ArrayList<String>();
				
				for(int i = 0 ; i<recordFlows.length ; i++){
					String recordFlow = recordFlows[i];
					recordFlowList.add(recordFlow);
					schMonthMap.put(recordFlow,schMonths[i]);
				}
			}
			int result = schRotationDeptBiz.saveSelDeptsAndResult(recordFlowList,schMonthMap,doctor);
			if(result!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * TODO 保存排班
	 */
	@RequestMapping(value="/createRosting",method=RequestMethod.GET)
	@ResponseBody
	public String createRosting(){
		String doctorFlow = GlobalContext.getCurrentUser().getUserFlow();
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = resDoctorBiz.readDoctor(doctorFlow);
			int result = schArrangeResultBiz.saveResultByDoctor(doctor);
			if(result!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * TODO 排序+计算方案
	 */
	@RequestMapping(value="/sortAndCalculate",method=RequestMethod.POST)
	@ResponseBody
	public String sortAndCalculate(String[] resultFlow,String startDate,boolean clear,Integer resultNum){
		if(resultFlow!=null && resultFlow.length>0){
			List<SchArrangeResult> resultList = new ArrayList<SchArrangeResult>();
			List<String> resultFlows = new ArrayList<String>();
			int seq = resultNum-(resultFlow.length);
			for(String resultFlowTemp : resultFlow){
				resultFlows.add(resultFlowTemp);
				SchArrangeResult result = new SchArrangeResult();
				result.setResultFlow(resultFlowTemp);
				result.setSchDeptOrder(BigDecimal.valueOf(seq++));
				resultList.add(result);
				if(clear){
					result.setSchStartDate("");
					result.setSchEndDate("");
				}
			}
			if(StringUtil.isNotBlank(startDate)){
				List<SchArrangeResult> resultListTemp = schArrangeResultBiz.searchArrangeResultByResultFlow(resultFlows);
				Map<String,String> schMonthMap = new HashMap<String, String>();
				for(SchArrangeResult monthResult : resultListTemp){
					schMonthMap.put(monthResult.getResultFlow(),monthResult.getSchMonth());
				}
				resultList = calculatePlan(resultList,startDate,schMonthMap);
			}
			int result = schArrangeResultBiz.saveSchArrangeResults(resultList);
			if(result!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * TODO 保存自定义时间
	 */
	@RequestMapping(value="/saveDiyDate",method=RequestMethod.POST)
	@ResponseBody
	public String saveDiyDate(SchArrangeResult result){
		if(result!=null){
			if(StringUtil.isNotBlank(result.getSchStartDate())){
				String endDate = calculateDate(result.getSchStartDate(),result.getSchMonth());
				result.setSchEndDate(endDate);
			}
			int resultFlag = schArrangeResultBiz.saveSchArrangeResult(result);
			if(resultFlag!=GlobalConstant.ZERO_LINE){
				if(StringUtil.isNotBlank(result.getSchEndDate())){
					return result.getSchEndDate();
				}else{
					return GlobalConstant.OPRE_SUCCESSED_FLAG;
				}
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * 自动计算排班日期
	 * @param startDate
	 * @param steps
	 * @return
	 */
	@RequestMapping(value="/getAutoCountResult",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String,String>> getAutoCountResult(String startDate,String[] steps){
		List<Map<String,String>> result = null;
		if(startDate!=null && startDate!=null && startDate.length()>0){
			result = new ArrayList<Map<String,String>>();
			for(String step : steps){
				Map<String,String> resultMap = new HashMap<String, String>();
				resultMap.put("start",startDate);
				String endDate = calculateDate(startDate,step);
				resultMap.put("end",endDate);
				startDate = DateUtil.addDate(endDate,1);
				result.add(resultMap);
			}
		}
		return result;
	}
	
	private List<SchArrangeResult> calculatePlan(List<SchArrangeResult> sortResult,String startDate,Map<String,String> schMonthMap){
		if(sortResult!=null && sortResult.size()>0){
			for(SchArrangeResult result : sortResult){
				String step = schMonthMap.get(result.getResultFlow());
				result.setSchStartDate(startDate);
				String endDate = calculateDate(startDate,step);
				result.setSchEndDate(endDate);
				startDate = DateUtil.addDate(endDate,1);
			}
		}
		return sortResult;
	}
	
	private String calculateDate(String date,String step){
		if(StringUtil.isNotBlank(date) && StringUtil.isNotBlank(step)){
			float stepFloat = Float.parseFloat(step);
			int stepInt = (int)stepFloat;
			float stepHalf = stepInt!=0?stepFloat%stepInt:stepFloat;
			if(SchUnitEnum.Week.getId().equals(InitConfig.getSysCfg("res_rotation_unit"))){
				if(stepInt!=0){
					date = DateUtil.addDate(date,stepInt*7);
				}
				if(stepHalf>0){
					date = DateUtil.addDate(date,3);
				}
			}else if(SchUnitEnum.Month.getId().equals(InitConfig.getSysCfg("res_rotation_unit"))){
				if(stepInt!=0){
					date = DateTrans.newDateOfAddMonths(date,stepInt);
				}
				if(stepHalf>0){
					date = DateUtil.addDate(date,15);
				}
			}
			date = DateUtil.addDate(date,-1);
		}
		return date;
	}
	
	/**
	 * TODO 确认排班
	 */
	@RequestMapping(value="/confirmRosting",method=RequestMethod.POST)
	@ResponseBody
	public String confirmRosting(ResDoctor doctor){
		if(doctor!=null){
			int result = resDoctorBiz.editDoctor(doctor);
			if(result!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * 教学登记
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/teachRegistryList",method=RequestMethod.GET)
	public String teachRegistryList(Integer currentPage, HttpServletRequest request, Model model) throws Exception{
		ResRec resRec = new ResRec();
		ResDoctor currDoctor = (ResDoctor)getSessionAttribute("currDoctor");
		//SysUser currUser = GlobalContext.getCurrentUser();
		resRec.setOrgFlow(currDoctor.getOrgFlow());
		resRec.setRecTypeId(ResRecTypeEnum.TeachRegistry.getId());
		resRec.setOperUserFlow(currDoctor.getDoctorFlow());
		PageHelper.startPage(currentPage,getPageSize(request));
		List<ResRecForm> resRecFormList = resRecBiz.searchResRecFormList(resRec);
		model.addAttribute("resRecFormList", resRecFormList);
		return "res/doctor/teachRegistryList";
	}
	
	
	/**
	 * 获取一条ResRec记录
	 * @param recFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/getResRecByRecFlow"},method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ResRecForm getResRecByRecFlow(String recFlow) throws Exception{
		ResRecForm resRec = null;
		if(StringUtil.isNotBlank(recFlow)){
			resRec = resRecBiz.getRecContentByRecFlow(recFlow);
		}
		return resRec;
	}
	
	/**
	 * 保存教学登记
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveResRecContent",method=RequestMethod.POST)
	@ResponseBody
	public String saveResRecContent(ResRecForm resRecForm,  Model model) throws Exception{
		int result = resRecBiz.saveResRecContent(resRecForm);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * 删除
	 * @param recFlow
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/delResRec")
	@ResponseBody
	public String delResRec(String recFlow) throws Exception{
		if(StringUtil.isNotBlank(recFlow)){
			ResRec resRec = new ResRec();
			resRec.setRecFlow(recFlow);
			resRec.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = resRecBiz.edit(resRec);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * 请假记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/absenceList")
	public String absenceList(Integer currentPage, HttpServletRequest request, Model model){
		SchDoctorAbsence doctorAbsence = new SchDoctorAbsence();
		doctorAbsence.setDoctorFlow(GlobalContext.getCurrentUser().getUserFlow());
		doctorAbsence.setIsRegister(GlobalConstant.FLAG_N);
		PageHelper.startPage(currentPage,getPageSize(request));
		List<SchDoctorAbsence> doctorAbsenceList = schDoctorAbsenceBiz.searchSchDoctorAbsenceList(doctorAbsence);
		model.addAttribute("doctorAbsenceList", doctorAbsenceList);
		return "res/intern/absenceList";
	}
	
	
	/**
	 * 新增请假记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editAbsence")
	public String editAbsence(String absenceFlow,String isRegister,String resRoleScope, Model model){
		SysUser user = GlobalContext.getCurrentUser();
		ResDoctorSchProcess doctorProcess = new ResDoctorSchProcess();
		
		if(StringUtil.isNotBlank(absenceFlow) || !GlobalConstant.FLAG_Y.equals(isRegister)){
			doctorProcess.setUserFlow(user.getUserFlow());
			if(StringUtil.isNotBlank(absenceFlow)){
				SchDoctorAbsence doctorAbsence = schDoctorAbsenceBiz.readSchDoctorAbsence(absenceFlow);
				model.addAttribute("doctorAbsence", doctorAbsence);
				if(doctorAbsence !=null && StringUtil.isNotBlank(doctorAbsence.getMakingFile())){
					PubFile pubFile = fileBiz.readFile(doctorAbsence.getMakingFile());
					model.addAttribute("file", pubFile);
				}
			}
		}
		//缺勤登记
		if (GlobalConstant.FLAG_Y.equals(isRegister)) {
			List<ResDoctor> doctorList = null;
			ResDoctor doctor = new ResDoctor();
			if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(resRoleScope) || GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(resRoleScope)){
				Map<String,Object> paramMap = new HashMap<String,Object>();
				if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(resRoleScope)){//带教老师
					paramMap.put("teacherUserFlow", user.getUserFlow());
				}
				if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(resRoleScope)){//科主任
					paramMap.put("headUserFlow", user.getUserFlow());
				}
				paramMap.put("doctor", doctor);
				doctorList = resDoctorBiz.searchDocByteacher(paramMap);
			} else {
				//PageHelper.startPage(currentPage,getPageSize(request));
				doctor.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				doctorList = resDoctorBiz.searchByDoc(doctor);
			}
			
//			if(!GlobalConstant.RES_ROLE_SCOPE_CHARGE.equals(resRoleScope)){
//				doctor.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
//			}
//			List<ResDoctor> doctorList = resDoctorBiz.searchByDoc(doctor);
			model.addAttribute("doctorList",doctorList);
		}
		model.addAttribute("isRegister",isRegister);
		
		if(GlobalConstant.RES_ROLE_SCOPE_DOCTOR.equals(resRoleScope)){
			ResDoctor doctor = resDoctorBiz.readDoctor(user.getUserFlow());
			if(doctor!=null && StringUtil.isNotBlank(doctor.getOrgFlow())){
				doctorProcess.setOrgFlow(doctor.getOrgFlow());
			}
		}else if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(resRoleScope)){//带教老师
			doctorProcess.setTeacherUserFlow(user.getUserFlow());
		}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(resRoleScope)){//科主任
			doctorProcess.setHeadUserFlow(user.getUserFlow());
		}else if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(resRoleScope)){
			doctorProcess.setOrgFlow(user.getOrgFlow());
		}
		List<ResDoctorSchProcess> processList = resDoctorProcessBiz.searchDoctorProcess(doctorProcess);
		model.addAttribute("processList", processList);
		return "res/intern/editAbsence";
	}
	
	
	/**
	 * 保存请假记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveDoctorAbsence")
	@ResponseBody
	public String saveDoctorAbsence(SchDoctorAbsence doctorAbsence, MultipartFile file){
		int result = schDoctorAbsenceBiz.editSchDoctorAbsence(doctorAbsence,file);
		if(GlobalConstant.ZERO_LINE != result){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 计算请假天数
	 * @param doctorAbsence
	 * @return
	 */
	@RequestMapping(value="/calculateAbsenceDay")
	@ResponseBody
	public Long calculateAbsenceDay(SchDoctorAbsence doctorAbsence){
		Long intervalDay = DateUtil.signDaysBetweenTowDate(doctorAbsence.getEndDate(),  doctorAbsence.getStartDate());
		return intervalDay;
	}
	
	
	/**
	 * 删除请假
	 * @param absenceFlow
	 * @return
	 */
	@RequestMapping(value="/delAbsence")
	@ResponseBody
	public String delAbsence(String absenceFlow){
		if(StringUtil.isNotBlank(absenceFlow)){
			SchDoctorAbsence doctorAbsence = new SchDoctorAbsence();
			doctorAbsence.setAbsenceFlow(absenceFlow);
			doctorAbsence.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = schDoctorAbsenceBiz.saveSchDoctorAbsence(doctorAbsence);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	
	@RequestMapping(value="/repealAbsence")
	@ResponseBody
	public String repealAbsence(String absenceFlow){
		if(StringUtil.isNotBlank(absenceFlow)){
			SchDoctorAbsence doctorAbsence = new SchDoctorAbsence();
			doctorAbsence.setAbsenceFlow(absenceFlow);
			doctorAbsence.setRepealAbsence(GlobalConstant.RECORD_STATUS_Y);
			doctorAbsence.setRepealAbsenceDate(DateUtil.getCurrDate());
			int result = schDoctorAbsenceBiz.saveSchDoctorAbsence(doctorAbsence);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value={"/user/saveGroupRelated"},method={RequestMethod.POST})
	@ResponseBody
	public String saveGroupRelated(String doctorFlow,String value,String type){
		ResDoctor doctor = resDoctorBiz.readDoctor(doctorFlow);
		if(doctor!=null){
			if ("groupId".equals(type)) {
				if (StringUtil.isNotBlank(value)) {
					doctor.setGroupId(value);
					doctor.setGroupName(DictTypeEnum.ResGroup.getDictNameById(value));
				} else {
					doctor.setGroupId("");
					doctor.setGroupName("");
				}
			} else if ("groupRoleId".equals(type)) {
				if (StringUtil.isNotBlank(value)) {
					doctor.setGroupRoleId(value);
					doctor.setGroupRoleName(GroupRoleEnum.getNameById(value));
				} else {
					doctor.setGroupRoleId("");
					doctor.setGroupRoleName("");
				}
			}
		}
		if(GlobalConstant.ZERO_LINE!=resDoctorBiz.editDoctor(doctor)){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value="/appraisalList")
	public String appraisalList(String doctorFlow, Model model){
		ResDoctor doctor = (ResDoctor)getSessionAttribute("currDoctor");
		model.addAttribute("doctor", doctor);
		if (doctor != null) {
			String groupId = doctor.getGroupId();
			if (StringUtil.isNotBlank(groupId)) {
				ResDoctor temp = new ResDoctor();
				temp.setGroupId(groupId);
				temp.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				List<ResDoctor> doctorList = resDoctorBiz.searchByDocNotSelf(temp,doctor.getDoctorFlow());
				
				if(doctorList!=null && doctorList.size()>0){
					model.addAttribute("doctorList", doctorList);
					
					List<String> doctorFlows = new ArrayList<String>();
					for(ResDoctor doctorTemp : doctorList){
						doctorFlows.add(doctorTemp.getDoctorFlow());
					}
					
					List<SysUser> userList = userBiz.searchSysUserByuserFlows(doctorFlows);
					if(userList!=null && userList.size()>0){
						Map<String,SysUser> userMap = new HashMap<String, SysUser>();
						for(SysUser user : userList){
							userMap.put(user.getUserFlow(),user);
						}
						model.addAttribute("userMap",userMap);
					}
					
					List<String> newDoctorFlows = resDoctorProcessBiz.searchRotationDoctor(doctorFlows);
					if(newDoctorFlows!=null && newDoctorFlows.size()>0){
						List<SchArrangeResult> resultList = schArrangeResultBiz.cutAfterResult(newDoctorFlows);
						if(resultList!=null && resultList.size()>0){
							Map<String,SchArrangeResult> currResultMap = new HashMap<String, SchArrangeResult>();
							Map<String,SchArrangeResult> nextResultMap = new HashMap<String, SchArrangeResult>();
							for(SchArrangeResult result : resultList){
								String key = result.getDoctorFlow();
								if(currResultMap.get(key)==null){
									currResultMap.put(key,result);
								}else if(nextResultMap.get(key)==null){
									nextResultMap.put(key,result);
								}
							}
							model.addAttribute("currResultMap",currResultMap);
							model.addAttribute("nextResultMap",nextResultMap);
						}
					}
					
					List<Map<String,Object>> absenceSumMapList = schDoctorAbsenceBiz.countAbsenceDays(doctorFlows);
					if(absenceSumMapList!=null && absenceSumMapList.size()>0){
						Map<Object,Object> absenceSumMap = new HashMap<Object, Object>();
						for(Map<String,Object> map : absenceSumMapList){
							absenceSumMap.put(map.get("doctorFlow"),map.get("countDay"));
						}
						model.addAttribute("absenceSumMap",absenceSumMap);
					}
				}
			}
		}
		return "res/doctor/archives/appraisalList";
	}
	
	@RequestMapping(value="/preTrainForm")
	public String preTrainForm(String roleFlag,String resultFlow,Model model){
		model.addAttribute("roleFlag",roleFlag);
		if(StringUtil.isNotBlank(resultFlow)){
			SchArrangeResult result = schArrangeResultBiz.readSchArrangeResult(resultFlow);
			if(result!=null){
				model.addAttribute("result",result);
				List<ResRec> recList = resRecBiz.searchByRecWithBLOBs(ResRecTypeEnum.PreTrainForm.getId(),result.getSchDeptFlow(),result.getDoctorFlow());
				if(recList!=null && recList.size()>0){
					ResRec rec = recList.get(0);
					model.addAttribute("rec", rec);
					String recContent = rec.getRecContent();
					Map<String,Map<String,String>> dataMap = resRecBiz.getPreTrainFormDataMap(recContent);
					model.addAttribute("dataMap",dataMap);
				}
			}
		}
		return "res/edu/student/preTrainForm";
	}
	
	
	/**
	 * 打印
	 * @param resultFlow
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/printPreTrainForm")
	public void printPreTrainForm(String processFlow, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(StringUtil.isNotBlank(processFlow)){
			if(StringUtil.isNotBlank(processFlow)){
				List<ResRec> recList = resRecBiz.searchRecByProcessWithBLOBs(processFlow,PreRecTypeEnum.PreTrainForm.getId());
				if(recList!=null && recList.size()>0){
					ResRec rec = recList.get(0);
					String schDeptName = rec.getSchDeptName();
					resultMap.put("schDeptName",schDeptName);
					String recContent = rec.getRecContent();
					Map<String, String> formDataMap = resRecBiz.parseRecContent(recContent);
					//Map<String, Map<String, String>> dataMap = resRecBiz.getPreTrainFormDataMap(recContent);
//					for(Map.Entry<String, Map<String, String>> entry : dataMap.entrySet()){
						//System.err.println("key:" + entry.getKey() + "--value:" + entry.getValue());
//						Map<String, String> childMap = entry.getValue();
//						for(Map.Entry<String, String> childEntry : childMap.entrySet()){
							//System.err.println("key:" + childEntry.getKey() + "--value:" + childEntry.getValue());
//							String entryValue = childEntry.getValue();
//							if(GlobalConstant.FLAG_Y.equals(entryValue)){
//								entryValue = "是";
//							}else if(GlobalConstant.FLAG_N.equals(entryValue)){
//								entryValue = "否";
//							}
//							resultMap.put(entry.getKey()+childEntry.getKey(), entryValue);
//						}
//					}
					for(String key : formDataMap.keySet()){
						String value = formDataMap.get(key);
						if(GlobalConstant.FLAG_Y.equals(value)){
							value = "是";
						}
						if(GlobalConstant.FLAG_N.equals(value)){
							value = "否";
						}
						resultMap.put(key,value);
					}
					
					WordprocessingMLPackage temeplete = new WordprocessingMLPackage();
					String path = "/jsp/res/edu/student/print/printTemeplete.docx";//模板
					ServletContext context =  request.getServletContext();
					String watermark = GeneralMethod.getWatermark(GlobalConstant.FLAG_N);
					temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), resultMap,watermark,true);
					if(temeplete!=null){
						String name = schDeptName + "岗前培训记录表.docx"; 
						response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
						response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
						ServletOutputStream out = response.getOutputStream ();
						(new SaveToZipFile (temeplete)).save (out);
						out.flush ();
					}
				}
			}
		}
	}
	
	@RequestMapping(value="/annualTrainForm")
	public String annualTrainForm(String roleFlag,String doctorFlow,Model model){
		model.addAttribute("roleFlag",roleFlag);
		ResDoctor doctor = (ResDoctor)getSessionAttribute("currDoctor");
		String orgFlow = doctor.getOrgFlow();
		if(StringUtil.isNotBlank(orgFlow)){
			List<SysDept> deptList = deptBiz.searchDeptByOrg(orgFlow);
			if(deptList!=null && deptList.size()>0){
				model.addAttribute("deptList",deptList);
				Map<String,SysDept> deptMap = new HashMap<String, SysDept>();
				for(SysDept dept : deptList){
					deptMap.put(dept.getDeptFlow(),dept);
				}
				model.addAttribute("deptMap",deptMap);
			}
		}
		List<ResRec> recList = resRecBiz.searchByRecWithBLOBs(ResRecTypeEnum.AnnualTrainForm.getId(),doctorFlow);
		if(recList!=null && recList.size()>0){
			ResRec rec = recList.get(0);
			model.addAttribute("rec", rec);
			String recContent = rec.getRecContent();
			Map<String,Object> formDataMap = resRecBiz.getAnnualTrainFormDataMap(recContent);
			model.addAttribute("formDataMap",formDataMap);
		}
		return "res/edu/student/annualTrainForm";
	}
	
	@RequestMapping(value="/annualtrainShow")
	public String annualtrainShow(String doctorFlow, String trainYear, Model model){
		if(StringUtil.isBlank(doctorFlow)){
			SysUser currUser = GlobalContext.getCurrentUser();
			doctorFlow = currUser.getUserFlow();
		}
		ResRec  search = new ResRec();
		search.setRecTypeId(RegistryTypeEnum.AnnualTrainForm.getId());
		search.setOperUserFlow(doctorFlow);
		List<ResRec> recList = resRecBiz.searchByRecWithBLOBs(search, trainYear);
		if(recList!=null&&recList.size()>0){
			Map<String,Map<String,String>> recContentMap = new HashMap<String, Map<String,String>>();
			for(ResRec rec : recList){
				Map<String,String> content = resRecBiz.parseRecContent(rec.getRecContent());
				recContentMap.put(rec.getRecFlow(),content);
			}
			model.addAttribute("recContentMap",recContentMap);
		}
		model.addAttribute("recList",recList);
		return "res/edu/student/annuaForm";
	}
	
	/**
	 * 年度培训记录打印
	 * @param resultFlow
	 * @param request
	 * @param response
	 * @param classHourSum
	 * @param academicSum
	 * @param academicSum_I
	 * @param academicSum_II
	 * @throws Exception
	 */
	@RequestMapping(value="/printAnnualTrain")
	public void printAnnualTrain(String userFlow, String trainYear, HttpServletRequest request, HttpServletResponse response) throws Exception{
		WordprocessingMLPackage temeplete;
		List<WordprocessingMLPackage> templates = new ArrayList<WordprocessingMLPackage>();
		if(StringUtil.isBlank(userFlow)){
			SysUser currUser = GlobalContext.getCurrentUser();
			userFlow = currUser.getUserFlow();
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("trainYear", trainYear);
		ResDoctor resDoctor = resDoctorBiz.readDoctor(userFlow);
		if(resDoctor != null){
			resultMap.put("doctorName", resDoctor.getDoctorName());
			resultMap.put("doctorCode", resDoctor.getDoctorCode());
		}
		ResRec resRec = new ResRec();
		resRec.setRecTypeId(RegistryTypeEnum.AnnualTrainForm.getId());
		resRec.setOperUserFlow(userFlow);
		List<ResRec> recList = resRecBiz.searchByRecWithBLOBs(resRec, trainYear);
		//if(recList!=null&&recList.size()>0){
			Map<String, List<ResRec>> resRecListMap = new HashMap<String, List<ResRec>>();
			for(ResRec rec : recList){
				String schDeptFlow =  rec.getSchDeptFlow();
				List<ResRec> tempList = resRecListMap.get(schDeptFlow);
				if(tempList == null){
					tempList = new ArrayList<ResRec>();
				}
				tempList.add(rec);
				resRecListMap.put(schDeptFlow, tempList);
			}
			List<WordprocessingMLPackage> reserveLeaderTemplates = new ArrayList<WordprocessingMLPackage>();
			ServletContext context =  request.getServletContext();
			String watermark = GeneralMethod.getWatermark(GlobalConstant.FLAG_Y);
			for(Entry<String, List<ResRec>> entry : resRecListMap.entrySet()){
				//System.err.println("key:" + entry.getKey() + "--value:" + entry.getValue());
				List<ResRec> printRecList = entry.getValue();
				Map<String,Map<String,String>> recContentMap = new HashMap<String, Map<String,String>>();
				List<ItemGroupData> itemGroupDataList = new ArrayList<ItemGroupData>();
				int i = 0;
				Double classHourScoreCount = new Double(0);
				Double academicSum = new Double(0);
				Double academicSum_I = new Double(0);
				Double academicSum_II = new Double(0);
				for(ResRec rec : printRecList){
					i++;
					Map<String,String> content = resRecBiz.parseRecContent(rec.getRecContent());
					recContentMap.put(rec.getRecFlow(),content);
					ItemGroupData  igd = new ItemGroupData();
					Map<String , Object> objMap = new HashMap<String, Object>();
					objMap.put("status", StringUtil.defaultString(String.valueOf(i)));
					String studyType = StringUtil.defaultString(content.get("studyType"));
					objMap.put("studyType", studyType);
					objMap.put("trainContent", StringUtil.defaultString(content.get("trainContent")));
					objMap.put("trainDate", StringUtil.defaultString(content.get("trainDate")));
					String academicScore = StringUtil.defaultString(content.get("academicScore"));
					String classHourScore = StringUtil.defaultString(content.get("classHourScore"));
					objMap.put("academicScore", academicScore +"/"+ classHourScore);
					objMap.put("remarks", StringUtil.defaultString(content.get("remarks")));
					igd.setObjMap(objMap);
					itemGroupDataList.add(igd);
					//统计学习类型
					if(StringUtil.isNotBlank(classHourScore)){
						classHourScoreCount += Double.valueOf(classHourScore); 
					}
					if(StringUtil.isNotBlank(academicScore)){
						if(studyType.equals("继续教育I类")){
							academicSum_I += Double.valueOf(academicScore);
						}else if(studyType.equals("继续教育II类")){
							academicSum_II += Double.valueOf(academicScore);
						}
						academicSum += Double.valueOf(academicScore);
					}
				}
				resultMap.put("itemGroupDataList", itemGroupDataList);
				resultMap.put("schDeptName", StringUtil.defaultString(printRecList.get(0).getSchDeptName()));
				resultMap.put("classHourScoreCount", _doubleTrans(classHourScoreCount));
				resultMap.put("academicSum", _doubleTrans(academicSum));
				resultMap.put("academicSum_I", _doubleTrans(academicSum_I));
				resultMap.put("academicSum_II", _doubleTrans(academicSum_II));
				resultMap.put("trainYear", trainYear);
				temeplete = new WordprocessingMLPackage();
				String path = "/jsp/res/edu/student/print/annualTrainTemeplete.docx";//模板
				WordprocessingMLPackage template2 = Docx4jUtil.convert(new File(context.getRealPath(path)), resultMap, watermark, true);
				reserveLeaderTemplates.add(template2);
			}
			//合并模板
			if (reserveLeaderTemplates.size() > 0) {
				templates.addAll(reserveLeaderTemplates);
				temeplete = Docx4jUtil.mergeDocx(templates);
			}else{
				temeplete = new WordprocessingMLPackage();
				String path = "/jsp/res/edu/student/print/annualTrainTemeplete.docx";//模板
				temeplete = Docx4jUtil.convert(new File(context.getRealPath(path)), resultMap, watermark, true);
			}
			if(temeplete!=null){
				String name = "年度培训记录.docx"; 
				response.setHeader("Content-disposition","attachment; filename="+new String(name.getBytes("gbk"),"ISO8859-1" ) +""); 
				response.setContentType ("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
				ServletOutputStream out = response.getOutputStream ();
				(new SaveToZipFile (temeplete)).save (out);
				out.flush ();
			}
		//}
	}
	
	/**
	 * @param d
	 * @return
	 */
	public static String _doubleTrans(double d){
        if((double)Math.round(d) - d == 0.0D)
            return String.valueOf((long)d);
        else
            return String.valueOf(d);
    }
	
	@RequestMapping(value="/speAbilityAssessList")
	public String speAbilityAssessList(String operUserFlow,String recTypeId,Model model){
		List<ResRec> recList=resRecBiz.searchByUserFlowAndTypeId(operUserFlow, recTypeId);
		//List<SysUser> userList=resRecBiz.searchByUserFlowAndTypeId(operUserFlow, recTypeId);
		
		if(StringUtil.isNotBlank(recTypeId)){
			String globalRecName = GlobalRecTypeEnum.getNameById(recTypeId);
			model.addAttribute("globalRecName",globalRecName);
		}
		
		if(recList!=null && recList.size()>0){
			model.addAttribute("recList", recList);
			Map<String,List<Map<String,String>>> viewListMap = new HashMap<String, List<Map<String,String>>>();
			for(ResRec recTemp : recList){
				List<Map<String,String>> viewInfoList = resRecBiz.parseViewValue(recTemp.getRecContent());
				viewListMap.put(recTemp.getRecFlow(),viewInfoList);
			}
			model.addAttribute("viewListMap",viewListMap);
		}
		return "res/edu/student/speAbilityAssess";
	}
	
	@RequestMapping(value="/assessSearch/{roleFlag}")
	public String assessSearch(@PathVariable String roleFlag,Model model){
		model.addAttribute("roleFlag",roleFlag);
		return "/res/doctor/assessSearch";
	}
	
	@RequestMapping(value="/userAssessList")
	public String userAssessList(String roleFlag,String userFlow,Model model,TestResult result){
		String currUserFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		List<ResDoctorSchProcess> processList = null;
		ResDoctorSchProcess process = new ResDoctorSchProcess();
		Map<String,String> roleFlagMap = new HashMap<String, String>();
		roleFlagMap.put("roleFlag",roleFlag);
		if(GlobalConstant.RES_ROLE_SCOPE_DOCTOR.equals(roleFlag)){
			userFlow = StringUtil.defaultIfEmpty(userFlow,currUserFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			
		}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			process.setHeadUserFlow(currUserFlow);
			processList = resDoctorProcessBiz.searchProcessByDoctor(null,process,roleFlagMap);
		}else if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(roleFlag)){
			roleFlagMap.put("val",currUserFlow);
			processList = resDoctorProcessBiz.searchProcessByDoctor(null,process,roleFlagMap);
		}else if(GlobalConstant.RES_ROLE_SCOPE_ADMIN.equals(roleFlag)){
			roleFlagMap.put("val",GlobalContext.getCurrentUser().getOrgFlow());
			processList = resDoctorProcessBiz.searchProcessByDoctor(null,process,roleFlagMap);
		}
		
		if(processList!=null && processList.size()>0){
			List<String> userFlows = new ArrayList<String>();
			for(ResDoctorSchProcess rdsp : processList){
				String flow = rdsp.getUserFlow();
				if(!userFlows.contains(flow)){
					userFlows.add(flow);
				}
			}
			
			List<SysUser> userList = userBiz.searchSysUserByuserFlows(userFlows);
			model.addAttribute("userList",userList);
		}
		
		if(StringUtil.isNotBlank(userFlow)){
			List<TestResult> resultList = resultBiz.searchResult(userFlow,result);
			model.addAttribute("resultList",resultList);
		}
		
		return "/res/doctor/userAssessList";
	}
	
	@RequestMapping(value="/getStartAndEnd")
	@ResponseBody
	public Map<String,String> getStartAndEnd(Integer weekNum){
		Map<String,String> result = null;
		if(weekNum!=null){
			String startDate = DateUtil.getYear()+"-01-01";
			if(weekNum>1){
				startDate = DateUtil.addDate(startDate,(weekNum-1)*7);
			}
			
			result = new HashMap<String, String>();
			result.put("start",startDate);
			String endDate = DateUtil.addDate(startDate,6);
			result.put("end",endDate);
		}
		return result;
	}
}
