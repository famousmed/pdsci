package com.pinde.sci.ctrl.res;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.res.IResAssessCfgBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.res.IResRecBiz;
import com.pinde.sci.biz.sch.ISchArrangeResultBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDoctorAbsenceBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.DateTrans;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.AfterRecTypeEnum;
import com.pinde.sci.enums.res.GlobalRecTypeEnum;
import com.pinde.sci.enums.res.RecStatusEnum;
import com.pinde.sci.enums.res.RegistryTypeEnum;
import com.pinde.sci.enums.res.ResAssessTypeEnum;
import com.pinde.sci.enums.res.ResRecTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.res.ResAssessCfgItemForm;
import com.pinde.sci.form.res.ResAssessCfgTitleForm;
import com.pinde.sci.model.irb.IrbSingleForm;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.ResAppeal;
import com.pinde.sci.model.mo.ResAssessCfg;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResRec;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDoctorAbsence;
import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserDept;
import com.pinde.sci.model.res.ResDoctorExt;
import com.pinde.sci.model.res.ResRecExt;
@Controller
@RequestMapping("/res/teacher")
public class ResTeacherController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(ResTeacherController.class);
	
	@Autowired
	private IResRecBiz resRecBiz;
	@Autowired
	private IResDoctorProcessBiz doctorProcessBiz;
	@Autowired
	private ISchArrangeResultBiz resultBiz;
	@Autowired
	private IResDoctorBiz doctorBiz;
	@Autowired
	private IResAssessCfgBiz assessCfgBiz;
	@Autowired
	private ISchDeptBiz schDeptBiz;
	@Resource
	private ISchRotationDeptBiz schRotationDeptBiz;
	@Resource
	private IUserBiz userBiz;
	@Resource
	private ISchDoctorAbsenceBiz schDoctorAbsenceBiz;
	@Autowired
	private NoticeBiz noticeBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	/**
	 * TODO 显示概况
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showView/{roleFlag}",method=RequestMethod.GET)
	public String showView(@PathVariable String roleFlag,/*String schDeptFlow,*/Model model){
//		Map<String,BigDecimal> countMap = this.resRecBiz.searchAuditCount(GlobalContext.getCurrentUser().getUserFlow(), roleFlag);
//		model.addAttribute("countMap", countMap);
		model.addAttribute("roleFlag", roleFlag);
//		
//		ResRec rec = new ResRec();
//		rec.setRecTypeId(ResRecTypeEnum.AfterSummary.getId());
//		//rec.setStatusId(RecStatusEnum.Submit.getId());
//		ResDoctorSchProcess process = new ResDoctorSchProcess();
//		process.setIsCurrentFlag(GlobalConstant.FLAG_Y);
//		List<ResRecExt> recExtList = this.resRecBiz.searchRegistryList(GlobalContext.getCurrentUser().getUserFlow(), roleFlag,rec,process);
//		model.addAttribute("recExtList",recExtList);
		
		SysUser user = GlobalContext.getCurrentUser();
		
		if(user!=null && StringUtil.isNotBlank(user.getDeptFlow())){
			//当前带教老师轮转科室列表
			List<String> schDeptFlows = new ArrayList<String>();
			List<SysUserDept> userDeptList = userBiz.searchUserDeptByUser(user.getUserFlow());
			if(userDeptList!=null && userDeptList.size()>0){
				List<String> deptFlows = new ArrayList<String>();
				for(SysUserDept sud : userDeptList){
					deptFlows.add(sud.getDeptFlow());
				}
				List<SchDept> schDeptList = schDeptBiz.searchDeptByDeotFlows(deptFlows);
				if(schDeptList!=null && schDeptList.size()>0){
					for(SchDept sd : schDeptList){
						schDeptFlows.add(sd.getSchDeptFlow());
					}
				}
			}
			
//			if(schDeptList!=null && schDeptList.size()>0){
//				schDeptFlow = StringUtil.defaultIfEmpty(schDeptFlow,schDeptList.get(0).getSchDeptFlow());
//				if(schDeptList!=null && schDeptList.size()>0){
//					model.addAttribute("schDeptList",schDeptList);
					
//					Map<String,String> deptNameMap = new HashMap<String, String>();
//					for(SchDept dept : schDeptList){
//						deptNameMap.put(dept.getSchDeptFlow(),dept.getSchDeptName());
//					}
//					model.addAttribute("schDeptName",deptNameMap.get(schDeptFlow));
//				}
//				model.addAttribute("schDeptFlow",schDeptFlow);
				
				//当前轮转医师
				ResDoctorSchProcess process = new ResDoctorSchProcess();
//				process.setSchDeptFlow(schDeptFlow);
				process.setIsCurrentFlag(GlobalConstant.FLAG_Y);
				
				List<ResDoctorSchProcess> processList = null;
						
				if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
					process.setTeacherUserFlow(user.getUserFlow());
					
					List<String> recTypeIds = new ArrayList<String>();
					
					for(RegistryTypeEnum regType : RegistryTypeEnum.values()){
						if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_registry_type_"+regType.getId()))){
							recTypeIds.add(regType.getId());
						}
					}
					
					//是否存在待审核数据
					List<Map<String,Object>> waitAuditMapList = resRecBiz.searchDoctorNotAuditCount(/*schDeptFlow*/null,user.getUserFlow(),GlobalConstant.FLAG_N,recTypeIds);
					if(waitAuditMapList!=null && waitAuditMapList.size()>0){
						Map<String,Object> waitAuditMap = new HashMap<String, Object>();
						for(Map<String,Object> map : waitAuditMapList){
							waitAuditMap.put((String)map.get("recKey"),map.get("finishCount"));
						}
						model.addAttribute("waitAuditMap",waitAuditMap);
					}
					List<Map<String,Object>> waitAuditAppealMapList = resRecBiz.searchNotAuditAppealCount(/*schDeptFlow*/null,user.getUserFlow(),GlobalConstant.FLAG_N);
					if(waitAuditAppealMapList!=null && waitAuditAppealMapList.size()>0){
						Map<String,Object> waitAuditAppealMap = new HashMap<String, Object>();
						for(Map<String,Object> map : waitAuditAppealMapList){
							waitAuditAppealMap.put((String)map.get("appealKey"),map.get("appealSum"));
						}
						model.addAttribute("waitAuditAppealMap",waitAuditAppealMap);
					}
					
					processList = doctorProcessBiz.searchDoctorProcess(process);
				}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
					process.setHeadUserFlow(user.getUserFlow());
					//带教老师审核情况
					List<Map<String,Object>> auditMapList = resRecBiz.searchTeacherAuditCount(user.getUserFlow(),GlobalConstant.FLAG_Y);
					List<Map<String,Object>> notAuditMapList = resRecBiz.searchTeacherAuditCount(user.getUserFlow(),GlobalConstant.FLAG_N);
					List<String> teacherFlows = new ArrayList<String>();
					if(auditMapList!=null && auditMapList.size()>0){
						Map<String,Map<String,Object>> auditMap = new HashMap<String, Map<String,Object>>();
						for(Map<String,Object> map : auditMapList){
							String teacherFlow = (String)map.get("teacherFlow");
							if(!teacherFlows.contains(teacherFlow)){
								teacherFlows.add(teacherFlow);
							}
							auditMap.put(teacherFlow,map);
						}
						model.addAttribute("auditMap",auditMap);
					}
					if(notAuditMapList!=null && notAuditMapList.size()>0){
						Map<String,Map<String,Object>> notAuditMap = new HashMap<String, Map<String,Object>>();
						for(Map<String,Object> map : notAuditMapList){
							String teacherFlow = (String)map.get("teacherFlow");
							if(!teacherFlows.contains(teacherFlow)){
								teacherFlows.add(teacherFlow);
							}
							notAuditMap.put(teacherFlow,map);
						}
						model.addAttribute("notAuditMap",notAuditMap);
					}
					model.addAttribute("teacherFlows",teacherFlows);
					
					//待入科查询
					List<SchArrangeResult> resultList = resultBiz.willInDoctor(user.getOrgFlow(),user.getUserFlow());
					if(resultList!=null && resultList.size()>0){
						List<String> doctorFlows = new ArrayList<String>();
						List<SchArrangeResult> willInResult = new ArrayList<SchArrangeResult>();
						for(SchArrangeResult result : resultList){
							if(!doctorFlows.contains(result.getDoctorFlow())){
								doctorFlows.add(result.getDoctorFlow());
								if(schDeptFlows.contains(result.getSchDeptFlow())){
									willInResult.add(result);
								}
							}
						}
						if(willInResult!=null && willInResult.size()>0){
							model.addAttribute("willInResult",willInResult);
							
							List<String> userFlows = new ArrayList<String>();
							for(SchArrangeResult sar : willInResult){
								userFlows.add(sar.getDoctorFlow());
							}
							
							List<SysUser> willInUserList = userBiz.searchSysUserByuserFlows(userFlows);
							if(willInUserList!=null && willInUserList.size()>0){
								Map<String,SysUser> willInUserMap = new HashMap<String, SysUser>();
								for(SysUser su : willInUserList){
									willInUserMap.put(su.getUserFlow(),su);
								}
								model.addAttribute("willInUserMap",willInUserMap);
							}
							
							List<ResDoctor> willInDoctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
							if(willInDoctorList!=null && willInDoctorList.size()>0){
								Map<String,ResDoctor> willInDoctorMap = new HashMap<String, ResDoctor>();
								for(ResDoctor rd : willInDoctorList){
									willInDoctorMap.put(rd.getDoctorFlow(),rd);
								}
								model.addAttribute("willInDoctorMap",willInDoctorMap);
							}
						}
					}
					
					//processList = doctorProcessBiz.searchDoctorProcess(process);
					processList = doctorProcessBiz.searchCurrentProcessByUserFlow(user.getUserFlow(),process.getIsCurrentFlag());
				}else if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(roleFlag)){
					processList = doctorProcessBiz.searchCurrentProcessByUserFlow(user.getUserFlow(),process.getIsCurrentFlag());
				}
				
				if(processList!=null && processList.size()>0){
					model.addAttribute("processList",processList);
					
					List<SchArrangeResult> resultList = new ArrayList<SchArrangeResult>();
					Map<String,String> finishPreMap = new HashMap<String, String>();
					
					List<String> userFlows = new ArrayList<String>();
					Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
					for(ResDoctorSchProcess processTemp : processList){
						userFlows.add(processTemp.getUserFlow());
						
						//计算登记百分比
//						resultList.clear();
//						String resultFlow = processTemp.getSchResultFlow();
//						SchArrangeResult result = resultBiz.readSchArrangeResult(resultFlow);
//						if(result!=null){
//							resultList.add(result);
//							Map<String,String> finishPre = resRecBiz.getFinishPer(resultList,processTemp.getUserFlow());
//							if(finishPre!=null){
//								finishPreMap.put(processTemp.getUserFlow(),finishPre.get(resultFlow));
//							}
//						}
						
						//轮转中记录
						processMap.put(processTemp.getUserFlow(),processTemp);
					}
					model.addAttribute("processMap",processMap);
					model.addAttribute("finishPreMap",finishPreMap);
					
					List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
					if(doctorList!=null && doctorList.size()>0){
						model.addAttribute("doctorList",doctorList);
						
						Map<String,ResDoctor> doctorMap = new HashMap<String, ResDoctor>();
						Map<String,Integer> categoryNum = new HashMap<String, Integer>();
						for(ResDoctor doctor : doctorList){
							String key = doctor.getDoctorCategoryName();
							if(categoryNum.get(key)==null){
								categoryNum.put(key,1);
							}else{
								categoryNum.put(key,categoryNum.get(key)+1);
							}
							doctorMap.put(doctor.getDoctorFlow(),doctor);
						}
						model.addAttribute("doctorMap",doctorMap);
						model.addAttribute("categoryNum",categoryNum);
						
						//读取用户信息
						List<SysUser> userList = userBiz.searchSysUserByuserFlows(userFlows);
						if(userList!=null && userList.size()>0){
							Map<String,SysUser> userMap = new HashMap<String, SysUser>();
							for(SysUser su : userList){
								userMap.put(su.getUserFlow(),su);
							}
							model.addAttribute("userMap",userMap);
						}
					}
					
					//出科小结情况
					List<ResRec> afterList = resRecBiz.searchByUserFlows(ResRecTypeEnum.AfterSummary.getId(),userFlows);
					if(afterList!=null && afterList.size()>0){
						Map<String,ResRec> afterMap = new HashMap<String, ResRec>();
						for(ResRec rec : afterList){
							afterMap.put(rec.getOperUserFlow()+rec.getSchDeptFlow(),rec);
						}
						model.addAttribute("afterMap",afterMap);
					}
					
					//出科成绩
					List<ResRec> evaluationList = resRecBiz.searchByUserFlowsWithBLOBs(ResRecTypeEnum.AfterEvaluation.getId(),userFlows);
					if(evaluationList!=null && evaluationList.size()>0){
						Map<String,String> evaluationMap = new HashMap<String, String>();
						Map<String, ResRec> recMap = new HashMap<String, ResRec>();
						for(ResRec rec : evaluationList){
							Map<String,String> scoreMap = resRecBiz.parseRecContent(rec.getRecContent());
							if(scoreMap!=null){
								evaluationMap.put(rec.getOperUserFlow()+rec.getSchDeptFlow(),scoreMap.get("totalScore"));
								recMap.put(rec.getOperUserFlow()+rec.getSchDeptFlow(),rec);
							}
						}
						model.addAttribute("evaluationMap", evaluationMap);
						model.addAttribute("recMap", recMap);
					}
				}
				
				//已出科医师
				process.setIsCurrentFlag(null);
				process.setSchFlag(GlobalConstant.FLAG_Y);
				List<ResDoctorSchProcess> afterProcessList = doctorProcessBiz.searchDoctorProcess(process);
				if(afterProcessList!=null && afterProcessList.size()>0){
					List<String> userFlows = new ArrayList<String>();
					for(ResDoctorSchProcess processTemp : afterProcessList){
						userFlows.add(processTemp.getUserFlow());
					}
					
					List<ResDoctor> afterDoctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
					model.addAttribute("afterDoctorList",afterDoctorList);
				}
				String currDate = DateUtil.getCurrDate();
				currDate = DateTrans.newDateOfAddMonths(currDate,1);
				
				List<ResDoctor> willInDoctorList = doctorBiz.searchMonthRotationDoctor(/*schDeptFlow*/null,currDate.substring(0,7));
				model.addAttribute("willInDoctorList",willInDoctorList);
			}
//		}
		
		//通知
		String beforeSevenDay = DateUtil.addHour(DateUtil.getCurrDateTime(),-7*24).substring(0,8);
		List<InxInfo> infos = this.noticeBiz.searchInfoByOrgBeforeDate(user.getOrgFlow(),beforeSevenDay);
		model.addAttribute("infos",infos);
		
		return "res/teacher/view";
	}
	/**
	 * 审核列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/auditList",method={RequestMethod.GET,RequestMethod.POST})
	public String auditList(String roleFlag,Model model){
		model.addAttribute("roleFlag",roleFlag);
		model.addAttribute("isCurrentFlag",GlobalConstant.FLAG_Y);
		return "redirect:/res/teacher/auditListContent";
	}
	
	/**
	 * 审核列表加载的内容
	 * @param recTypeId
	 * @param roleFlag
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/auditListContent",method={RequestMethod.GET,RequestMethod.POST})
	public String auditListContent(ResDoctor searchDoctor,String recTypeId,String roleFlag,ResDoctorSchProcess process,Integer currentPage,HttpServletRequest request,Model model){
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
//		ResDoctorSchProcess process = new ResDoctorSchProcess();
		Map<String,String> roleFlagMap = null;
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			process.setTeacherUserFlow(userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			process.setHeadUserFlow(userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(roleFlag)){
			roleFlagMap = new HashMap<String, String>();
			roleFlagMap.put("roleFlag",roleFlag);
			roleFlagMap.put("val",userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_ADMIN.equals(roleFlag)){
			roleFlagMap = new HashMap<String, String>();
			roleFlagMap.put("roleFlag",roleFlag);
			roleFlagMap.put("val",GlobalContext.getCurrentUser().getOrgFlow());
		}
//		if(StringUtil.isNotBlank(isCurrentFlag)){
//			process.setIsCurrentFlag(isCurrentFlag);
//		}
//		process.setStartDate(startDate);
//		process.setEndDate(endDate);
		//List<ResDoctorSchProcess> processList = doctorProcessBiz.searchDoctorProcess(process);
		
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		List<ResDoctorSchProcess> processList = doctorProcessBiz.searchProcessByDoctor(searchDoctor,process,roleFlagMap);
		if(processList!=null && processList.size()>0){
			model.addAttribute("processList",processList);
			
			List<SchArrangeResult> resultList = new ArrayList<SchArrangeResult>();
			Map<String,String> finishPreMap = new HashMap<String, String>();
			List<String> resultFlows = new ArrayList<String>();
			
			List<String> userFlows = new ArrayList<String>();
			List<String> schDeptFlows = new ArrayList<String>();
			for(ResDoctorSchProcess processTemp : processList){
				String resultFlow = processTemp.getSchResultFlow();
				if(!userFlows.contains(processTemp.getUserFlow())){
					userFlows.add(processTemp.getUserFlow());
				}
				if(!schDeptFlows.contains(processTemp.getSchDeptFlow())){
					schDeptFlows.add(processTemp.getSchDeptFlow());
				}
				resultFlows.add(resultFlow);
				if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
					resultList.clear();
					SchArrangeResult result = resultBiz.readSchArrangeResult(resultFlow);
					if(result!=null){
						resultList.add(result);
						Map<String,String> finishPre = resRecBiz.getFinishPer(resultList,processTemp.getUserFlow());
						if(finishPre!=null){
							finishPreMap.put(processTemp.getUserFlow(),finishPre.get(resultFlow));
						}
					}
				}
			}
			model.addAttribute("finishPreMap",finishPreMap);
			
			
			//岗前培训数据
			List<ResRec> recList = resRecBiz.searchRecByUserAndSchdept(userFlows, schDeptFlows, ResRecTypeEnum.PreTrainForm.getId(), null);
			if(recList!=null && recList.size()>0){
				Map<String,ResRec> preTrainMap = new HashMap<String, ResRec>();
				for(ResRec rec : recList){
					preTrainMap.put(rec.getOperUserFlow()+rec.getSchDeptFlow(),rec);
				}
				model.addAttribute("preTrainMap",preTrainMap);
			}
			
			//出科考核表数据
			List<ResRec> evaluationList = resRecBiz.searchRecByUserAndSchdept(userFlows, schDeptFlows, ResRecTypeEnum.AfterEvaluation.getId(), null);
			if(evaluationList!=null && evaluationList.size()>0){
				Map<String,ResRec> evaluationMap = new HashMap<String, ResRec>();
				for(ResRec rec : evaluationList){
					evaluationMap.put(rec.getOperUserFlow()+rec.getSchDeptFlow(),rec);
				}
				model.addAttribute("evaluationMap",evaluationMap);
			}
			
			//出科小结数据
			List<ResRec> summaryList = resRecBiz.searchRecByUserAndSchdept(userFlows, schDeptFlows, ResRecTypeEnum.AfterSummary.getId(), null);
			if(summaryList!=null && summaryList.size()>0){
				Map<String,ResRec> summaryMap = new HashMap<String, ResRec>();
				for(ResRec rec : summaryList){
					summaryMap.put(rec.getOperUserFlow()+rec.getSchDeptFlow(),rec);
				}
				model.addAttribute("summaryMap",summaryMap);
			}
			
			List<Map<String,Object>> finishCountMapList = resRecBiz.countRecWithDoc(userFlows,schDeptFlows);
			if(finishCountMapList!=null && finishCountMapList.size()>0){
				Map<String,Object> finishCountMap = new HashMap<String,Object>();
				for(Map<String,Object> map : finishCountMapList){
					finishCountMap.put((String)map.get("recKey"),map.get("finishCount"));
				}
				model.addAttribute("finishCountMap",finishCountMap);
			}
			
			List<Map<String,Object>> waitAuditCountMapList = resRecBiz.countRecWithDoc(userFlows,schDeptFlows,roleFlag);
			if(waitAuditCountMapList!=null && waitAuditCountMapList.size()>0){
				Map<String,Object> waitAuditCountMap = new HashMap<String,Object>();
				for(Map<String,Object> map : waitAuditCountMapList){
					waitAuditCountMap.put((String)map.get("recKey"),map.get("finishCount"));
				}
				model.addAttribute("waitAuditCountMap",waitAuditCountMap);
			}
			
			List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
			if(doctorList!=null && doctorList.size()>0){
				//List<String> rotationFlows = new ArrayList<String>();
				Map<String,ResDoctor> doctorMap = new HashMap<String,ResDoctor>();
				for(ResDoctor doctor : doctorList){
					doctorMap.put(doctor.getDoctorFlow(),doctor);
//					if(!rotationFlows.contains(doctor.getRotationFlow()) && StringUtil.isNotBlank(doctor.getRotationFlow())){
//						rotationFlows.add(doctor.getRotationFlow());
//					}
				}
				model.addAttribute("doctorMap",doctorMap);
				
				//用户信息
				List<SysUser> userList = userBiz.searchSysUserByuserFlows(userFlows);
				if(userList!=null && userList.size()>0){
					Map<String,SysUser> userMap = new HashMap<String, SysUser>();
					for(SysUser user : userList){
						userMap.put(user.getUserFlow(),user);
					}
					model.addAttribute("userMap",userMap);
				}
				
				//要求数计算
				List<SchArrangeResult> searchReqResultList = resultBiz.searchArrangeResultByResultFlow(resultFlows);
				if(searchReqResultList!=null && searchReqResultList.size()>0){
					Map<String,SchArrangeResult> resultMap = new HashMap<String, SchArrangeResult>();
					List<String> rotationFlows = new ArrayList<String>();
					List<String> standardDeptId = new ArrayList<String>();
					for(SchArrangeResult result : searchReqResultList){
						if(StringUtil.isNotBlank(result.getRotationFlow())){
							rotationFlows.add(result.getRotationFlow());
						}
						standardDeptId.add(StringUtil.defaultIfEmpty(result.getStandardDeptId(),""));
						resultMap.put(result.getResultFlow(),result);
					}
					model.addAttribute("resultMap",resultMap);
					
					if(rotationFlows.size()>0){
						List<Map<String,Object>> reqMapList = schRotationDeptBiz.countReqWithSchDept(rotationFlows,standardDeptId);
						if(reqMapList!=null && reqMapList.size()>0){
							Map<String,Object> reqMap = new HashMap<String,Object>();
							for(Map<String,Object> map : reqMapList){
								reqMap.put((String)map.get("reqKey"),map.get("reqSum"));
							}
							model.addAttribute("reqMap",reqMap);
						}
					}
				}
			}
			
			List<Map<String,Object>> appealCountMapList = resRecBiz.appealCountWithUser(userFlows,schDeptFlows);
			if(appealCountMapList!=null && appealCountMapList.size()>0){
				Map<String,Object> appealMap = new HashMap<String, Object>();
				for(Map<String,Object> map : appealCountMapList){
					appealMap.put((String)map.get("appealKey"),map.get("appealSum"));
				}
				model.addAttribute("appealMap",appealMap);
			}
			
			List<Map<String,Object>> waitAuditAppealCountMapList = resRecBiz.appealCountWithUser(userFlows,schDeptFlows,GlobalConstant.RES_ROLE_SCOPE_TEACHER);
			if(waitAuditAppealCountMapList!=null && waitAuditAppealCountMapList.size()>0){
				Map<String,Object> waitAuditAppealCountMap = new HashMap<String, Object>();
				for(Map<String,Object> map : waitAuditAppealCountMapList){
					waitAuditAppealCountMap.put((String)map.get("appealKey"),map.get("appealSum"));
				}
				model.addAttribute("waitAuditAppealCountMap",waitAuditAppealCountMap);
			}
		}
		
//		if(StringUtil.isNotBlank(recTypeId)){
//			ResRec rec = new ResRec();
//			rec.setRecTypeId(recTypeId);
//			//rec.setStatusId(RecStatusEnum.Submit.getId());
//			ResDoctorSchProcess process = null;
//			if(StringUtil.isNotBlank(isCurrentFlag)){
//				process = new ResDoctorSchProcess();
//				process.setIsCurrentFlag(isCurrentFlag);
//			}
//			List<ResRecExt> recExtTempList = this.resRecBiz.searchRegistryList(GlobalContext.getCurrentUser().getUserFlow(), roleFlag,rec,process);
//			if(recExtTempList!=null && recExtTempList.size()>0){
//				List<ResRecExt> recExtList = new ArrayList<ResRecExt>();
//				List<String> userFlows = new ArrayList<String>();
//				Map<String,Integer> countMap = new HashMap<String, Integer>();
//				for(ResRecExt recExt : recExtTempList){
//					String userFlow = recExt.getDoctorExt().getDoctorFlow();
//					
//					if(ResRecTypeEnum.AfterEvaluation.getId().equals(recExt.getRecTypeId()) || ResRecTypeEnum.AfterSummary.getId().equals(recExt.getRecTypeId())){
//						boolean auditAgree = false;
//						if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
//							auditAgree = !RecStatusEnum.TeacherAuditY.getId().equals(recExt.getAuditStatusId());
//						}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
//							auditAgree = !RecStatusEnum.HeadAuditY.getId().equals(recExt.getHeadAuditStatusId());
//						}
//						if(auditAgree){
//							recExtList.add(recExt);
//						}
//					}else{
//						if(!userFlows.contains(userFlow)){
//							recExtList.add(recExt);
//							userFlows.add(userFlow);
//							
//							String rotationFlow = recExt.getDoctorExt().getRotationFlow();
//							String schDeptFlow = recExt.getSchDeptFlow();
//							if(StringUtil.isNotBlank(rotationFlow) && StringUtil.isNotBlank(schDeptFlow)){
//								List<SchRotationDeptReq> deptReqList = schRotationDeptBiz.searchDeptReq(rotationFlow,schDeptFlow,recTypeId);
//								if(deptReqList!=null && deptReqList.size()>0){
//									for(SchRotationDeptReq deptReq : deptReqList){
//										if(countMap.get(userFlow+"reqCount")==null){
//											if(deptReq.getReqNum()!=null){
//												countMap.put(userFlow+"reqCount",deptReq.getReqNum().intValue());
//											}
//										}else{
//											if(deptReq.getReqNum()!=null){
//												countMap.put(userFlow+"reqCount",countMap.get(userFlow+"reqCount")+deptReq.getReqNum().intValue());
//											}
//										}
//									}
//								}
//							}
//						}
//						if(countMap.get(userFlow+"finishCount")==null){
//							countMap.put(userFlow+"finishCount",1);
//						}else{
//							countMap.put(userFlow+"finishCount",countMap.get(userFlow+"finishCount")+1);
//						}
//						
//						if(StringUtil.isBlank(recExt.getAuditStatusId())){
//							if(countMap.get(userFlow+"notAuditCount")==null){
//								countMap.put(userFlow+"notAuditCount",1);
//							}else{
//								countMap.put(userFlow+"notAuditCount",countMap.get(userFlow+"notAuditCount")+1);
//							}
//						}else{
//							if(countMap.get(userFlow+"auditCount")==null){
//								countMap.put(userFlow+"auditCount",1);
//							}else{
//								countMap.put(userFlow+"auditCount",countMap.get(userFlow+"auditCount")+1);
//							}
//						}
//					}
//				}
//				model.addAttribute("recExtList", recExtList);
//				model.addAttribute("countMap", countMap);
//			}
//		}
		return "res/teacher/auditList";
	}
	
	@RequestMapping(value="/recAuditList",method=RequestMethod.GET)
	public String recAuditList(String recTypeId,String roleFlag,String doctorFlow,String schDeptFlow,String processFlow,Model model){//String isCurrentFlag
		if(StringUtil.isNotBlank(doctorFlow)){
			List<ResRec> recList = resRecBiz.searchByRecForAudit(recTypeId,schDeptFlow,doctorFlow);
			model.addAttribute("recList", recList);
			
			List<ResAppeal> appealList = resRecBiz.searchAppealForAudit(recTypeId, schDeptFlow, doctorFlow);
			model.addAttribute("appealList", appealList);
			
			model.addAttribute("recTypeName",ResRecTypeEnum.getNameById(recTypeId));
			
			ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
			model.addAttribute("doctor",doctor);
			
			if(StringUtil.isNotBlank(processFlow)){
				ResDoctorSchProcess process = doctorProcessBiz.read(processFlow);
				model.addAttribute("process",process);
			}
		}
		
//		if(StringUtil.isNotBlank(doctorFlow)){
//			List<ResRecExt> recExtList = this.resRecBiz.searchAuditList(GlobalContext.getCurrentUser().getUserFlow(), roleFlag,recTypeId,doctorFlow,isCurrentFlag);
//			if(recExtList!=null && recExtList.size()>0){
//				Map<String,Map<String,String>> formDataMapMap = new HashMap<String, Map<String,String>>();
//				for(ResRecExt recEct : recExtList){
//					Map<String,String> formDataMap = resRecBiz.parseRecContent(recEct.getRecContent());
//					formDataMapMap.put(recEct.getRecFlow(), formDataMap);
//				}
//				model.addAttribute("formDataMapMap", formDataMapMap);
//				model.addAttribute("recExtList", recExtList);
//			}
			
//			SysUser user = userBiz.readSysUser(doctorFlow);
//			model.addAttribute("user", user);
//		}
		return "res/teacher/recAuditList";
	}
	
	@RequestMapping(value="/afterAudit",method=RequestMethod.GET)
	public String afterAudit(String processFlow){
		
		return "";
	}
	
	/**
	 * 显示审核界面
	 * @param recFlow
	 * @param recTypeId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showAudit",method=RequestMethod.GET)
	public String showAudit(String schDeptFlow,String operUserFlow,String recFlow,String recTypeId, Model model ){
		ResRec rec = this.resRecBiz.readResRec(recFlow);
		
		Map<String,String> formDataMap = resRecBiz.parseRecContent(rec.getRecContent());
		model.addAttribute("formDataMap", formDataMap);
		
		String rotationFlow = "";
		if(StringUtil.isNotBlank(operUserFlow)){
			ResDoctor doctor =  doctorBiz.readDoctor(operUserFlow);
			if(doctor!=null){
				rotationFlow = doctor.getRotationFlow();
//				List<SchRotationDeptReq> deptReqList = schRotationDeptBiz.searchDeptReq(doctor.getRotationFlow(),schDeptFlow,recTypeId);
//				model.addAttribute("deptReqList",deptReqList);
			}
		}
		
		String jspPath = resRecBiz.getFormPath(recTypeId, rec==null?null:rec.getRecVersion(),rotationFlow);
		model.addAttribute("jspPath", jspPath);
		
		String view = null;
		if(rec!=null){
			if(ResRecTypeEnum.AfterSummary.getId().equals(recTypeId)){//出科小结
				view = "res/teacher/audit/"+recTypeId;
			}else{
				
				view = "res/teacher/audit/common";
			}
			model.addAttribute("rec", rec);
		}
		return view;
	}
	
	@RequestMapping(value="/audit",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String audit(String recFlow,String roleFlag,String processFlow,String auditResult,String auditAppraise,HttpServletRequest req){
		if(StringUtil.isNotBlank(recFlow)){
			ResRec rec = resRecBiz.readResRec(recFlow);
			if(rec!=null){
				String recTypeId = rec.getRecTypeId();
				
				SysUser user = GlobalContext.getCurrentUser();
				
				String rotationFlow = "";
				String doctorFlow = rec.getOperUserFlow();
				ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
				if(doctor!=null){
					rotationFlow = doctor.getRotationFlow();
				}
				
				String elementName = "";
				String auditStatusName = "";
				if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
					rec.setAuditStatusId(auditResult);
					rec.setAuditStatusName(RecStatusEnum.getNameById(auditResult));
					rec.setAuditTime(DateUtil.getCurrDateTime());
					rec.setAuditUserFlow(user.getUserFlow());
					rec.setAuditUserName(user.getUserName());
					elementName = "deptAppraise";
					auditStatusName = RecStatusEnum.getNameById(auditResult);
				}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
					rec.setHeadAuditStatusId(auditResult);
					rec.setHeadAuditStatusName(RecStatusEnum.getNameById(auditResult));
					rec.setHeadAuditTime(DateUtil.getCurrDateTime());
					rec.setHeadAuditUserFlow(user.getUserFlow());
					rec.setHeadAuditUserName(user.getUserName());
					elementName = "deptHeadAutograth";
					auditStatusName = RecStatusEnum.getNameById(auditResult);
				}
//				if(RecStatusEnum.TeacherAuditN.getId().equals(auditResult) || RecStatusEnum.HeadAuditN.getId().equals(auditResult)){
//					rec.setStatusId(RecStatusEnum.Edit.getId());
//					rec.setStatusName(RecStatusEnum.Edit.getName());
//				}
				
				String recContent = rec.getRecContent();
				if(StringUtil.isNotBlank(recContent) && StringUtil.isNotBlank(auditAppraise)){
					try {
						Document doc = DocumentHelper.parseText(recContent);
						Element root = doc.getRootElement();
						if(root!=null){
							Element appraise = root.addElement(elementName);
							appraise.addAttribute("operTime",DateUtil.getCurrDateTime());
							appraise.addAttribute("operUserName",user.getUserName());
							appraise.addAttribute("auditStatusName",auditStatusName);
							appraise.setText(auditAppraise);
						}
						recContent = doc.asXML();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				if(ResRecTypeEnum.AfterSummary.getId().equals(rec.getRecTypeId())){
					String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
					String productType = StringUtil.defaultIfEmpty(InitConfig.getSysCfg("res_form_category_"+rotationFlow),InitConfig.getSysCfg("res_form_category"));//与对应开关保持一致
					if(StringUtil.isBlank(productType)){
						productType = GlobalConstant.RES_FORM_PRODUCT;
					}
					String currVer = InitConfig.resFormRequestUtil.getVersionMap().get(productType+"_"+recTypeId);
					if(StringUtil.isBlank(currVer)){
						currVer = InitConfig.resFormRequestUtil.getVersionMap().get(GlobalConstant.RES_FORM_PRODUCT+"_"+recTypeId);
					}
					if(StringUtil.isBlank(currVer)){
						currVer = GlobalConstant.RES_FORM_PRODUCT_VER;
					}
					Map<String,IrbSingleForm> singleFormMap = InitConfig.resFormRequestUtil.getFormMap().get(recTypeId);
					IrbSingleForm singleForm = singleFormMap.get(productType+"_"+currVer);
					if(singleForm == null){
						singleForm = singleFormMap.get(GlobalConstant.RES_FORM_PRODUCT+"_"+currVer);
					}
					if(singleForm == null){
						throw new RuntimeException("未发现表单 模版类型:"+productType+",表单类型:"+ResRecTypeEnum.getNameById(recTypeId)+",版本号:"+currVer);
					}
					recContent = resRecBiz.getRecContent(recTypeId, singleForm.getItemList(), req);
				}
				
				rec.setRecContent(recContent);
				
				int result = 0;
				if(GlobalConstant.FLAG_Y.equals(req.getParameter("isAgaree"))){
					ResDoctorSchProcess process = new ResDoctorSchProcess();
					process.setProcessFlow(processFlow);
					process.setSchFlag(GlobalConstant.FLAG_Y);
					process.setIsCurrentFlag(GlobalConstant.FLAG_N);
					
					if(StringUtil.isNotBlank(req.getParameter("total"))){
						String score = req.getParameter("total");
						Float f = Float.parseFloat(score);
						process.setSchScore(BigDecimal.valueOf(f));
					}
					result = resRecBiz.editAndOut(rec,process);
				}else{
					result = resRecBiz.edit(rec);
				}
				if(result!=GlobalConstant.ZERO_LINE){
					return GlobalConstant.OPRE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}	
	
	
	@RequestMapping(value="/tdUpdate",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String tdUpdate(ResRec rec){
		int result = resRecBiz.edit(rec);
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 *  TODO 考核审批
	 */
	@RequestMapping(value="/audit/{roleFlag}",method={RequestMethod.GET,RequestMethod.POST})
	public String audit(@PathVariable String roleFlag,Model model){
		model.addAttribute("isCurrentFlag",GlobalConstant.FLAG_Y);
		model.addAttribute("roleFlag",roleFlag);
		return "redirect:/res/teacher/auditListContent";
	}
	
	/**
	 * 一键审核
	 */
	@RequestMapping(value="/oneKeyAudit",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String oneKeyAudit(String recTypeId,String schDeptFlow,String operUserFlow){
		int result = resRecBiz.oneKeyAudit(recTypeId,schDeptFlow,operUserFlow);
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * 申述审批
	 */
	@RequestMapping(value="/appealAudit/{roleFlag}",method={RequestMethod.GET,RequestMethod.POST})
	public String appealAudit(@PathVariable String roleFlag,ResAppeal appeal,String isCurrentFlag,Model model){
		model.addAttribute("roleFlag",roleFlag);
		
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		if(appeal!=null && appeal.getAuditStatusId()==null){
			isCurrentFlag = GlobalConstant.FLAG_Y;
		}
		
		ResDoctorSchProcess doctorProcess = new ResDoctorSchProcess();
		doctorProcess.setIsCurrentFlag(isCurrentFlag);
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			doctorProcess.setTeacherUserFlow(userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			doctorProcess.setHeadUserFlow(userFlow);
		}
		List<ResDoctorSchProcess> doctorProcessList = doctorProcessBiz.searchDoctorProcess(doctorProcess);
		
		if(doctorProcessList!=null && doctorProcessList.size()>0){
			model.addAttribute("doctorProcessList",doctorProcessList);
			
			List<String> schDeptFlows = new ArrayList<String>();
			for(ResDoctorSchProcess doctorProcessTemp : doctorProcessList){
				schDeptFlows.add(doctorProcessTemp.getSchDeptFlow());
			}
			
			appeal.setAuditStatusId(RecStatusEnum.TeacherAuditN.getId());
			appeal.setStatusId(RecStatusEnum.Submit.getId());
			List<ResAppeal> appealList = resRecBiz.searchAppeal(schDeptFlows,appeal);
			if(appealList!=null && appealList.size()>0){
				Map<String,List<ResAppeal>> appealMap = new HashMap<String, List<ResAppeal>>();
				for(ResAppeal appealTemp : appealList){
					String key = appealTemp.getSchDeptFlow()+appealTemp.getOperUserFlow();
					if(appealMap.get(key)==null){
						List<ResAppeal> appealTempList = new ArrayList<ResAppeal>();
						appealTempList.add(appealTemp);
						appealMap.put(key,appealTempList);
					}else{
						appealMap.get(key).add(appealTemp);
					}
				}
				model.addAttribute("appealMap",appealMap);
			}
		}
		return "res/teacher/audit/appealAuditList";
	}

	/**
	 * 登记统计报表
	 */
	@RequestMapping(value="/registryReport/{roleFlag}",method=RequestMethod.GET)
	public String registryReport(@PathVariable String roleFlag,Model model){
		model.addAttribute("roleFlag",roleFlag);
		return "res/teacher/report/registryReportMain";
	}
	@RequestMapping(value="/registryReportList",method=RequestMethod.GET)
	public String registryReportList(String recTypeId,String roleFlag,String isCurrentFlag, Model model){
		if(StringUtil.isNotBlank(recTypeId)){
			ResDoctorSchProcess process = null;
			if(StringUtil.isNotBlank(isCurrentFlag)){
				process = new ResDoctorSchProcess();
				process.setIsCurrentFlag(isCurrentFlag);
			}
			
			ResRec rec = new ResRec();
			rec.setRecTypeId(recTypeId);
			//rec.setStatusId(RecStatusEnum.Submit.getId());
			List<ResRecExt> recExtList = this.resRecBiz.searchRegistryList(GlobalContext.getCurrentUser().getUserFlow(), roleFlag,rec,process);
			model.addAttribute("recExtList", recExtList);
		}
		return "res/teacher/report/registryReportList";
	}
	
	/**
	 * 申述查询
	 */
	@RequestMapping(value="/appealReport/{roleFlag}",method={RequestMethod.GET,RequestMethod.POST})
	public String appealReport(@PathVariable String roleFlag,String isCurrentFlag,ResAppeal appeal,Model model){
		model.addAttribute("roleFlag",roleFlag);

		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		if(appeal!=null && appeal.getRecTypeId()==null){
			isCurrentFlag = GlobalConstant.FLAG_Y;
		}
		
		ResDoctorSchProcess doctorProcess = new ResDoctorSchProcess();
		doctorProcess.setIsCurrentFlag(isCurrentFlag);
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			doctorProcess.setTeacherUserFlow(userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			doctorProcess.setHeadUserFlow(userFlow);
		}
		List<ResDoctorSchProcess> doctorProcessList = doctorProcessBiz.searchDoctorProcess(doctorProcess);
		
		if(doctorProcessList!=null && doctorProcessList.size()>0){
			model.addAttribute("doctorProcessList",doctorProcessList);
			
			List<String> schDeptFlows = new ArrayList<String>();
			for(ResDoctorSchProcess doctorProcessTemp : doctorProcessList){
				if(!schDeptFlows.contains(doctorProcessTemp.getSchDeptFlow())){
					schDeptFlows.add(doctorProcessTemp.getSchDeptFlow());
				}
			}
			
			List<ResAppeal> appealList = resRecBiz.searchAppeal(schDeptFlows,appeal);
			if(appealList!=null && appealList.size()>0){
				Map<String,List<ResAppeal>> appealMap = new HashMap<String, List<ResAppeal>>();
				for(ResAppeal appealTemp : appealList){
					String key = appealTemp.getSchDeptFlow()+appealTemp.getOperUserFlow();
					if(appealMap.get(key)==null){
						List<ResAppeal> appealTempList = new ArrayList<ResAppeal>();
						appealTempList.add(appealTemp);
						appealMap.put(key,appealTempList);
					}else{
						appealMap.get(key).add(appealTemp);
					}
				}
				model.addAttribute("appealMap",appealMap);
			}
		}
		return "res/teacher/report/appealReport";
	}
	
	/**
	 * TODO 出科情况查询
	 */
	@RequestMapping(value="/docoutReport/{roleFlag}",method={RequestMethod.GET,RequestMethod.POST})
	public String docoutReport(@PathVariable String roleFlag,String isCurrentFlag,ResRec rec,Model model){
		model.addAttribute("roleFlag",roleFlag);

		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		if(rec!=null && rec.getAuditStatusId()==null){
			isCurrentFlag = GlobalConstant.FLAG_Y;
		}
		
		ResDoctorSchProcess doctorProcess = new ResDoctorSchProcess();
		doctorProcess.setIsCurrentFlag(isCurrentFlag);
		doctorProcess.setSchFlag(GlobalConstant.FLAG_Y);
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			doctorProcess.setTeacherUserFlow(userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			doctorProcess.setHeadUserFlow(userFlow);
		}
		List<ResDoctorSchProcess> doctorProcessList = doctorProcessBiz.searchDoctorProcess(doctorProcess);
		
		if(doctorProcessList!=null && doctorProcessList.size()>0){
			model.addAttribute("doctorProcessList",doctorProcessList);
			
			List<String> schDeptFlows = new ArrayList<String>();
			for(ResDoctorSchProcess doctorProcessTemp : doctorProcessList){
				if(!schDeptFlows.contains(doctorProcessTemp.getSchDeptFlow())){
					schDeptFlows.add(doctorProcessTemp.getSchDeptFlow());
				}
			}
			
			Map<String,ResRec> recMap = new HashMap<String,ResRec>();
			
			rec.setRecTypeId(ResRecTypeEnum.AfterSummary.getId());
			//rec.setStatusId(RecStatusEnum.Submit.getId());
			List<ResRec> recSummaryList = resRecBiz.searchResRec(schDeptFlows,rec);
			if(recSummaryList!=null && recSummaryList.size()>0){
				for(ResRec recTemp : recSummaryList){
					String key = recTemp.getSchDeptFlow()+recTemp.getOperUserFlow()+"summary";
					recMap.put(key,recTemp);
				}
			}
			
			rec.setRecTypeId(ResRecTypeEnum.AfterEvaluation.getId());
			List<ResRec> recEvaluationList = resRecBiz.searchResRec(schDeptFlows,rec);
			Map<String,String> scoreMap = null;
			if(recEvaluationList!=null && recEvaluationList.size()>0){
				scoreMap = new HashMap<String, String>();
				for(ResRec recTemp : recEvaluationList){
					String key = recTemp.getSchDeptFlow()+recTemp.getOperUserFlow()+"evaluation";
					recMap.put(key,recTemp);
					if(StringUtil.isNotBlank(recTemp.getRecContent())){
						Map<String,String> recContentMap = resRecBiz.parseRecContent(recTemp.getRecContent());
						scoreMap.put(key,recContentMap.get("totalScore"));
					}
				}
			}
			model.addAttribute("recMap",recMap);
			model.addAttribute("scoreMap",scoreMap);
		}
		return "res/teacher/report/docoutReport";
	}
	
	/**
	 *  TODO 出科情况查询
	 */
	@RequestMapping(value="/prepareinReport/{roleFlag}",method={RequestMethod.GET,RequestMethod.POST})
	public String prepareinReport(@PathVariable String roleFlag,ResRec rec,Model model){
		model.addAttribute("roleFlag",roleFlag);

		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		ResDoctorSchProcess doctorProcess = new ResDoctorSchProcess();
		doctorProcess.setSchFlag(GlobalConstant.FLAG_Y);
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			doctorProcess.setTeacherUserFlow(userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			doctorProcess.setHeadUserFlow(userFlow);
		}
		List<ResDoctorSchProcess> doctorProcessList = doctorProcessBiz.searchDoctorProcess(doctorProcess);
		
		if(doctorProcessList!=null && doctorProcessList.size()>0){
			model.addAttribute("doctorProcessList",doctorProcessList);
			
			List<String> doctorFlows = new ArrayList<String>();
			for(ResDoctorSchProcess doctorProcessTemp : doctorProcessList){
				if(!doctorFlows.contains(doctorProcessTemp.getUserFlow())){
					doctorFlows.add(doctorProcessTemp.getUserFlow());
				}
			}
			List<SchArrangeResult> resultList = resultBiz.searchArrangeResultByDoctorFlows(doctorFlows);
			if(resultList!=null && resultList.size()>0){
				Map<String,Map<String,Object>> resultMap = new HashMap<String,Map<String,Object>>();
				
				Map<String,List<String>> resultFlowMap = new HashMap<String, List<String>>();
				Map<String,SchArrangeResult> allResultMap = new HashMap<String,SchArrangeResult>();
				for(SchArrangeResult result : resultList){
					allResultMap.put(result.getResultFlow(),result);
					if(resultFlowMap.get(result.getDoctorFlow())==null){
						List<String> resultFlowList = new ArrayList<String>();
						resultFlowList.add(result.getResultFlow());
						resultFlowMap.put(result.getDoctorFlow(),resultFlowList);
					}else{
						resultFlowMap.get(result.getDoctorFlow()).add(result.getResultFlow());
					}
				}
				
				Integer count = 0;
				for(ResDoctorSchProcess doctorProcessTemp : doctorProcessList){
					Map<String,Object> dataTempMap = new HashMap<String, Object>();
					
					String resultFlow = doctorProcessTemp.getSchResultFlow();
					
					dataTempMap.put("currentResult",allResultMap.get(resultFlow));
					List<String> resultFlowsTemp = resultFlowMap.get(doctorProcessTemp.getUserFlow());
					if(resultFlowsTemp!=null){
						int index = resultFlowsTemp.indexOf(resultFlow);
						if(index!=-1 && (index+1)<=(resultFlowsTemp.size()-1)){
							String nextFlow = resultFlowsTemp.get(index+1);
							dataTempMap.put("nextResult",allResultMap.get(nextFlow));
							count++;
						}
					}
					resultMap.put(doctorProcessTemp.getUserFlow(),dataTempMap);
				}
				
				model.addAttribute("resultMap",resultMap);
				model.addAttribute("count",count);
			}
			
		}
		
		return "res/teacher/report/prepareinReport";
	}
	
	/**
	 * 轮转计划列表
	 */
	@RequestMapping(value="/resultList",method={RequestMethod.GET,RequestMethod.POST})
	public String resultList(String doctorFlow,Model model){
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
			model.addAttribute("doctor",doctor);
			
			List<SchArrangeResult> resultList = resultBiz.searchSchArrangeResultByDoctor(doctorFlow);
			model.addAttribute("resultList",resultList);
		}
		return "res/teacher/report/resultList";
	}
	
	/**
	 * 带教老师考评查询
	 */
	@RequestMapping(value="/teacherScore/{roleFlag}",method={RequestMethod.GET,RequestMethod.POST})
	public String teacherScore(@PathVariable String roleFlag,String isCurrentFlag,String sessionNumber,Model model){
		model.addAttribute("roleFlag",roleFlag);
		
		SysUser user = GlobalContext.getCurrentUser();
		
		String cfgCodeId = ResAssessTypeEnum.TeacherAssess.getId();
		List<ResAssessCfgTitleForm> titleFormList = _getTitleFormList(cfgCodeId,user.getOrgFlow());
		model.addAttribute("titleFormList",titleFormList);
		
		String recTypeId = ResRecTypeEnum.TeacherGrade.getId();
		if(sessionNumber==null){
			isCurrentFlag = GlobalConstant.FLAG_Y;
		}
		List<ResRecExt> recExtList = resRecBiz.searchScoreList(user.getUserFlow(),roleFlag,sessionNumber,recTypeId,isCurrentFlag);
		if(recExtList!=null && recExtList.size()>0){
			if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
				model.addAttribute("recExtList",recExtList);
			}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
				Map<String,String> teacherMap = new HashMap<String,String>();
				Map<String,List<ResRecExt>> resExtMap = new HashMap<String, List<ResRecExt>>();
				for(ResRecExt recExt : recExtList){
					ResDoctorSchProcess doctorProcess = recExt.getProcess();
					if(doctorProcess != null){
						teacherMap.put(doctorProcess.getTeacherUserFlow(),doctorProcess.getTeacherUserName());
						if(resExtMap.get(doctorProcess.getTeacherUserFlow())==null){
							List<ResRecExt> recExtTempList = new ArrayList<ResRecExt>();
							recExtTempList.add(recExt);
							resExtMap.put(doctorProcess.getTeacherUserFlow(),recExtTempList);
						}else{
							resExtMap.get(doctorProcess.getTeacherUserFlow()).add(recExt);
						}
					}
				}
				model.addAttribute("teacherMap",teacherMap);
				model.addAttribute("resExtMap",resExtMap);
			}
			
			Map<String,Map<String,Object>> scoreMap = new HashMap<String, Map<String,Object>>();
			for(ResRecExt recExt : recExtList){
				Map<String,Object> scoreDate = resRecBiz.parseGradeXml(recExt.getRecContent());
				scoreMap.put(recExt.getSchDeptFlow()+recExt.getOperUserFlow(),scoreDate);
			}
			model.addAttribute("scoreMap",scoreMap);
		}
		
		return "res/teacher/teacherScore";
	}
	
	private List<ResAssessCfgTitleForm> _getTitleFormList(String cfgCodeId,String orgFlow){
		List<ResAssessCfgTitleForm> titleFormList = null;
		
		ResAssessCfg search = new ResAssessCfg();
		search.setCfgCodeId(cfgCodeId);
		search.setOrgFlow(orgFlow);
		List<ResAssessCfg> assessCfgList = assessCfgBiz.searchAssessCfgList(search);
		if(assessCfgList != null && !assessCfgList.isEmpty()){
			ResAssessCfg assessCfg = assessCfgList.get(0);
			try {
				Document dom = DocumentHelper.parseText(assessCfg.getCfgBigValue());
				String titleXpath = "//title";
				List<Element> titleElementList = dom.selectNodes(titleXpath);
				if(titleElementList != null && !titleElementList.isEmpty()){
					titleFormList = new ArrayList<ResAssessCfgTitleForm>();
					for(Element te :titleElementList){
						ResAssessCfgTitleForm titleForm = new ResAssessCfgTitleForm();
						titleForm.setId(te.attributeValue("id"));
						titleForm.setName(te.attributeValue("name"));
						List<Element> itemElementList = te.elements("item");
						List<ResAssessCfgItemForm> itemFormList = null;
						if(itemElementList != null && !itemElementList.isEmpty()){
							itemFormList = new ArrayList<ResAssessCfgItemForm>();
							for(Element ie : itemElementList){
								ResAssessCfgItemForm itemForm = new ResAssessCfgItemForm();
								itemForm.setId(ie.attributeValue("id"));
								itemForm.setName(ie.element("name") == null ? "" : ie.element("name").getTextTrim());
								itemForm.setScore(ie.element("score") == null ? "" : ie.element("score").getTextTrim());
								itemFormList.add(itemForm);
							}
						}
						titleForm.setItemList(itemFormList);
						titleFormList.add(titleForm);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return titleFormList;
	}
	
	@RequestMapping(value="/headScore",method={RequestMethod.GET,RequestMethod.POST})
	public String headScore(String isCurrentFlag,String sessionNumber,Model model){
		SysUser user = GlobalContext.getCurrentUser();
		
		String cfgCodeId = ResAssessTypeEnum.DeptAssess.getId();
		List<ResAssessCfgTitleForm> titleFormList = _getTitleFormList(cfgCodeId,user.getOrgFlow());
		model.addAttribute("titleFormList",titleFormList);
		
		String recTypeId = ResRecTypeEnum.DeptGrade.getId();
		if(sessionNumber==null){
			isCurrentFlag = GlobalConstant.FLAG_Y;
		}
		List<ResRecExt> recExtList = resRecBiz.searchScoreList(user.getUserFlow(),GlobalConstant.RES_ROLE_SCOPE_HEAD,sessionNumber,recTypeId,isCurrentFlag);
		if(recExtList!=null && recExtList.size()>0){
			model.addAttribute("recExtList",recExtList);
			
			Map<String,Map<String,Object>> scoreMap = new HashMap<String, Map<String,Object>>();
			for(ResRecExt recExt : recExtList){
				Map<String,Object> scoreDate = resRecBiz.parseGradeXml(recExt.getRecContent());
				scoreMap.put(recExt.getSchDeptFlow()+recExt.getOperUserFlow(),scoreDate);
			}
			model.addAttribute("scoreMap",scoreMap);
		}
		
		return "res/teacher/headScore";
	}
	
	@RequestMapping(value="/teacherAudit",method={RequestMethod.GET,RequestMethod.POST})
	public String teacherAudit(String isCurrentFlag,String schDeptFlow,Model model){
		SysUser user = GlobalContext.getCurrentUser();
		List<SchDept> deptList = schDeptBiz.searchSchDept(user.getDeptFlow());
		model.addAttribute("deptList",deptList);
		
		if(schDeptFlow==null){
			isCurrentFlag = GlobalConstant.FLAG_Y;
		}
		
		List<ResRecExt> recExtList = resRecBiz.searchTeacherAudit(schDeptFlow,isCurrentFlag,user.getUserFlow());
		if(recExtList!=null && recExtList.size()>0){
			Map<String,Map<String,Object>> auditCountMap = new HashMap<String, Map<String,Object>>();
			for(ResRecExt recExt : recExtList){
				ResDoctorSchProcess process = recExt.getProcess();
				if(process!=null){
					String key = process.getSchDeptFlow()+process.getTeacherUserFlow();
					if(auditCountMap.get(key)==null){
						Map<String,Object> dataMap = new HashMap<String, Object>();
						dataMap.put("schDeptName",process.getSchDeptName());
						dataMap.put("teacherUserName",process.getTeacherUserName());
						if(StringUtil.isNotBlank(recExt.getAuditStatusId())){
							dataMap.put("isNotAudit",0);
							dataMap.put("isAudit",1);
						}else{
							dataMap.put("isNotAudit",1);
							dataMap.put("isAudit",0);
						}
						auditCountMap.put(key,dataMap);
					}else{
						Map<String,Object> dataMap = auditCountMap.get(key);
						if(StringUtil.isNotBlank(recExt.getAuditStatusId())){
							dataMap.put("isAudit",(Integer)dataMap.get("isAudit")+1);
						}else{
							dataMap.put("isNotAudit",(Integer)dataMap.get("isNotAudit")+1);
						}
					}
				}
			}
			model.addAttribute("auditCountMap",auditCountMap);
		}
		
		return "res/teacher/teacherAudit";
	}
	
	/**
	 * 请假审批
	 * @param roleFlag
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/absenceAudit/{resRoleScope}"},method={RequestMethod.GET,RequestMethod.POST})
	public String absenceAudit(@PathVariable String resRoleScope, SchDoctorAbsence doctorAbsence, Integer currentPage, HttpServletRequest request,  Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		doctorAbsence.setOrgFlow(currUser.getOrgFlow());
		doctorAbsence.setIsRegister(GlobalConstant.FLAG_N);
		
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(resRoleScope)){//带教老师
			doctorAbsence.setTeacherFlow(currUser.getUserFlow());
		}
		if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(resRoleScope)){//科主任
			doctorAbsence.setHeadFlow(currUser.getUserFlow());
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		List<SchDoctorAbsence> doctorAbsenceList = schDoctorAbsenceBiz.searchSchDoctorAbsenceList(doctorAbsence);
		if(doctorAbsenceList!=null && !doctorAbsenceList.isEmpty()){
			List<String> fileFlowList = new ArrayList<String>();
			for(SchDoctorAbsence da : doctorAbsenceList){
				if(StringUtil.isNotBlank(da.getMakingFile())){
					fileFlowList.add(da.getMakingFile());
				}
			}
			Map<String,PubFile> fileMap = new HashMap<String, PubFile>();
			if(fileFlowList.size() > 0){
				List<PubFile> pubFileList =	fileBiz.searchFile(fileFlowList);
				for(PubFile file :pubFileList){
					fileMap.put(file.getFileFlow(), file);
				}
				model.addAttribute("fileMap", fileMap);
			}
		}
		model.addAttribute("doctorAbsenceList", doctorAbsenceList);
		model.addAttribute("resRoleScope", resRoleScope);
		
		// 医院管理员
		if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(resRoleScope)){
			List<SchDept> schDeptList = schDeptBiz.searchSchDeptList(currUser.getOrgFlow());
			model.addAttribute("schDeptList", schDeptList);
		}
		
		return "res/college/absenceAuditList";
	}
	
	/**
	 * 保存请假审批
	 * @param doctorAbsence
	 * @return
	 */
	@RequestMapping(value="/saveAbsenceAudit")
	@ResponseBody
	public String saveAbsenceAudit(SchDoctorAbsence doctorAbsence){
		if(StringUtil.isNotBlank(doctorAbsence.getAbsenceFlow())){
			int result = schDoctorAbsenceBiz.saveSchDoctorAbsence(doctorAbsence);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value="/log/add",method={RequestMethod.GET,RequestMethod.POST})
	public String addRecord(){
		return "res/log/add";
	}
	
	/**
	 * 缺勤登记
	 */
	@RequestMapping(value={"/absentManage/{resRoleScope}"},method={RequestMethod.GET,RequestMethod.POST})
	public String absentRegist(@PathVariable String resRoleScope,String firstFlag,SchDoctorAbsence doctorAbsence,ResDoctor doctor,Integer currentPage, HttpServletRequest request,  Model model){
		model.addAttribute("resRoleScope",resRoleScope);
		
		//默认选中界别
		if (!GlobalConstant.FLAG_N.equals(firstFlag)) {
			String sessionNumber = DictTypeEnum.DoctorSessionNumber.getSysDictList().get(0).getDictId();
			doctor.setSessionNumber(sessionNumber);
			doctorAbsence.setSessionNumber(sessionNumber);
		}
		model.addAttribute("firstFlag",firstFlag);
		
		SysUser currUser = GlobalContext.getCurrentUser();
		if(!GlobalConstant.RES_ROLE_SCOPE_CHARGE.equals(resRoleScope)){
			doctorAbsence.setOrgFlow(currUser.getOrgFlow());
			doctor.setOrgFlow(currUser.getOrgFlow());
		}
		
		List<ResDoctor> doctorList = null;
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(resRoleScope) || GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(resRoleScope)){
			Map<String,Object> paramMap = new HashMap<String,Object>();
			if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(resRoleScope)){//带教老师
				paramMap.put("teacherUserFlow", currUser.getUserFlow());
			}
			if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(resRoleScope)){//科主任
				paramMap.put("headUserFlow", currUser.getUserFlow());
			}
			paramMap.put("doctor", doctor);
			doctorList = doctorBiz.searchDocByteacher(paramMap);
		} else {
			//PageHelper.startPage(currentPage,getPageSize(request));
			doctor.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			doctorList = doctorBiz.searchByDoc(doctor);
		}
		model.addAttribute("doctorList",doctorList);
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("doctorAbsence", doctorAbsence);
		paramMap.put("absenceTeacherDay", InitConfig.getSysCfg("res_absence_teacher_day"));
		paramMap.put("absenceHeadDay", InitConfig.getSysCfg("res_absence_head_day"));
		paramMap.put("absenceManageDay", InitConfig.getSysCfg("res_absence_manage_day"));
		List<SchDoctorAbsence> doctorAbsenceList = schDoctorAbsenceBiz.searchDoctorAbsence(paramMap);
		
		if(doctorAbsenceList != null && doctorAbsenceList.size()>0){
			Map<String,List<SchDoctorAbsence>> docAbsenceMap = new HashMap<String,List<SchDoctorAbsence>>();
			for(SchDoctorAbsence docAbsence : doctorAbsenceList){
				if(docAbsenceMap.get(docAbsence.getDoctorFlow()) == null){
					List<SchDoctorAbsence> docAbsenceTempList = new ArrayList<SchDoctorAbsence>();
					docAbsenceTempList.add(docAbsence);
					docAbsenceMap.put(docAbsence.getDoctorFlow(),docAbsenceTempList);
				}else{
					docAbsenceMap.get(docAbsence.getDoctorFlow()).add(docAbsence);
				}
			}
			model.addAttribute("docAbsenceMap",docAbsenceMap);
		}
		
		// 医院管理员、平台管理
		if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(resRoleScope) || GlobalConstant.RES_ROLE_SCOPE_CHARGE.equals(resRoleScope)){
			List<SchDept> schDeptList = schDeptBiz.searchSchDeptList(currUser.getOrgFlow());
			model.addAttribute("schDeptList", schDeptList);
		}
		return "res/college/absenceList";
	}
	
	@RequestMapping(value="/teachPlanList",method={RequestMethod.GET,RequestMethod.POST})
	public String teachPlanList(String userFlow,String schDeptFlow,Model model){
		userFlow = StringUtil.defaultIfEmpty(userFlow,GlobalContext.getCurrentUser().getUserFlow());
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user = userBiz.readSysUser(userFlow);
			if(user!=null){
				String deptFlow = user.getDeptFlow();
				if(StringUtil.isNotBlank(deptFlow)){
					List<SchDept> schDeptList =  schDeptBiz.searchSchDept(deptFlow);
					model.addAttribute("schDeptList",schDeptList);
				}
			}
//			List<SchDept> schDeptList = schDeptBiz.searchTeachDept(userFlow);
//			model.addAttribute("schDeptList",schDeptList);
			
//			if(StringUtil.isNotBlank(schDeptFlow)){
//				List<SchDept> schDeptList =  new ArrayList<SchDept>();
//				SchDept dept = schDeptBiz.readSchDept(schDeptFlow);
//				schDeptList.add(dept);
//				model.addAttribute("schDeptList",schDeptList);
//			}
			
			List<ResRec> recList = resRecBiz.searchByRecWithBLOBs(ResRecTypeEnum.TeachRegistry.getId(),userFlow);
			if(recList!=null && recList.size()>0){
				Map<String,Map<String,Object>> contentMap = new HashMap<String, Map<String,Object>>();
				Map<String,ResRec> recMap = new HashMap<String, ResRec>();
				for(ResRec rec : recList){
					recMap.put(rec.getSchDeptFlow(),rec);
					
					String content = rec.getRecContent();
					Map<String,Object> recContentMap = resRecBiz.parseContent(content);
					contentMap.put(rec.getRecFlow(),recContentMap);
				}
				model.addAttribute("contentMap",contentMap);
				model.addAttribute("recMap",recMap);
			}
		}
		return "res/teacher/plan/list";
	}
	
	@RequestMapping(value="/editTeachPlan")
	public String editTeachPlan(String recFlow,String schDeptFlow,String recordFlow,Model model){
		model.addAttribute("user",GlobalContext.getCurrentUser());
		
		if(StringUtil.isNotBlank(schDeptFlow)){
			SchDept schDept = schDeptBiz.readSchDept(schDeptFlow);
			model.addAttribute("schDept",schDept);
		}
		
		if(StringUtil.isNotBlank(recFlow)){
			ResRec rec = resRecBiz.readResRec(recFlow);
			if(rec!=null){
				model.addAttribute("rec",rec);
				
				if(StringUtil.isNotBlank(recordFlow)){
					String content = rec.getRecContent();
					Map<String,Object> dataMap = resRecBiz.parseTeachPlanContent(content,recordFlow);
					model.addAttribute("dataMap",dataMap);
				}
			}
		}
		return "res/teacher/plan/edit";
	}
	
	@RequestMapping(value="/saveTeachPlan")
	@ResponseBody
	public String saveTeachPlan(String recFlow,String schDeptFlow,HttpServletRequest req){
		int result = resRecBiz.saveRegistryForm(ResRecTypeEnum.TeachRegistry.getId(),recFlow,schDeptFlow,null,req,null);
		if(GlobalConstant.ZERO_LINE!=result){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	@RequestMapping(value="/preTrainRecords",method={RequestMethod.GET,RequestMethod.POST})
	public String preTrainRecords(String isCurrentFlag,String userName,Model model){
		if(userName==null){
			isCurrentFlag = GlobalConstant.FLAG_Y;
			model.addAttribute("isCurrentFlag",isCurrentFlag);
		}
		ResDoctorSchProcess process = new ResDoctorSchProcess();
		process.setTeacherUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		process.setIsCurrentFlag(isCurrentFlag);
		
		ResDoctor doctor = new ResDoctor();
		doctor.setDoctorName(userName);
		List<ResDoctorSchProcess> processList = doctorProcessBiz.searchProcessByDoctor(doctor,process,null);
		if(processList!=null && processList.size()>0){
			model.addAttribute("processList",processList);
			
			List<String> userFlows = new ArrayList<String>();
			List<String> schDeptFlows = new ArrayList<String>();
			for(ResDoctorSchProcess processTemp : processList){
				String userFlow = processTemp.getUserFlow();
				String schDeptFlow = processTemp.getSchDeptFlow();
				if(!userFlows.contains(userFlow)){
					userFlows.add(userFlow);
				}
				if(!schDeptFlows.contains(schDeptFlow)){
					schDeptFlows.add(schDeptFlow);
				}
			}
			List<ResRec> recList = resRecBiz.searchRecByUserAndSchdept(userFlows, schDeptFlows, ResRecTypeEnum.PreTrainForm.getId(), null);
			if(recList!=null && recList.size()>0){
				Map<String,ResRec> recMap = new HashMap<String, ResRec>();
				for(ResRec rec : recList){
					recMap.put(rec.getOperUserFlow()+rec.getSchDeptFlow(),rec);
				}
				model.addAttribute("recMap",recMap);
			}
			
			List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
			if(doctorList!=null && doctorList.size()>0){
				Map<String,ResDoctor> doctorMap = new HashMap<String, ResDoctor>();
				for(ResDoctor doctorTemp : doctorList){
					doctorMap.put(doctorTemp.getDoctorFlow(),doctorTemp);
				}
				model.addAttribute("doctorMap",doctorMap);
			}
		}
		
		return "res/edu/teacher/preTrainRecords";
	}
	
	/**
	 * 年度培训表
	 * @param isCurrentFlag
	 * @param userName
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/annualTrainRecords",method={RequestMethod.GET,RequestMethod.POST})
	public String annualTrainRecords(String isCurrentFlag,String userName,Model model){
		if(userName==null){
			isCurrentFlag = GlobalConstant.FLAG_Y;
			model.addAttribute("isCurrentFlag",isCurrentFlag);
		}
		ResDoctorSchProcess process = new ResDoctorSchProcess();
		process.setTeacherUserFlow(GlobalContext.getCurrentUser().getUserFlow());
		process.setIsCurrentFlag(isCurrentFlag);
		
		ResDoctor doctor = new ResDoctor();
		doctor.setDoctorName(userName);
		List<ResDoctorSchProcess> processList = doctorProcessBiz.searchProcessByDoctor(doctor,process,null);
		if(processList!=null && processList.size()>0){
			List<String> userFlows = new ArrayList<String>();
			for(ResDoctorSchProcess processTemp : processList){
				if(!userFlows.contains(processTemp.getUserFlow())){
					userFlows.add(processTemp.getUserFlow());
				}
			}
			model.addAttribute("userFlows",userFlows);
			
			List<ResRec> recList = resRecBiz.searchRecByUserFlows(userFlows,ResRecTypeEnum.AnnualTrainForm.getId());
			if(recList!=null && recList.size()>0){
				Map<String,ResRec> recMap = new HashMap<String, ResRec>();
				for(ResRec rec : recList){
					recMap.put(rec.getOperUserFlow(),rec);
				}
				model.addAttribute("recMap",recMap);
			}
			
			List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
			if(doctorList!=null && doctorList.size()>0){
				Map<String,ResDoctor> doctorMap = new HashMap<String, ResDoctor>();
				for(ResDoctor doctorTemp : doctorList){
					doctorMap.put(doctorTemp.getDoctorFlow(),doctorTemp);
				}
				model.addAttribute("doctorMap",doctorMap);
			}
		}
		
		return "res/edu/teacher/annualTrainRecords";
	}
	
	/**
	 * 全局表单审核,基地主任
	 * @param recTypeId
	 * @param roleFlag
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/globalFormAudit/{roleFlag}",method={RequestMethod.GET,RequestMethod.POST})
	public String globalFormAudit(@PathVariable String roleFlag,String recTypeId,String userFlow,String deptFlow,Model model){
		model.addAttribute("roleFlag",roleFlag);
		
		userFlow = StringUtil.defaultIfEmpty(userFlow,GlobalContext.getCurrentUser().getUserFlow());
		if(StringUtil.isNotBlank(recTypeId)){
			//获取用户所有部门
			SysUser user = new SysUser();
			user.setUserFlow(userFlow);
			List<SysUserDept> sysDeptList = userBiz.getUserDept(user);
			if(sysDeptList!=null && sysDeptList.size()>0){
				List<String> deptFlows = new ArrayList<String>();
				for(SysUserDept sud : sysDeptList){
					String currDeptFlow = sud.getDeptFlow();
					if(!deptFlows.contains(currDeptFlow)){
						deptFlows.add(currDeptFlow);
					}
				}
				List<SysDept> sDeptList = deptBiz.searchDeptByFlows(deptFlows);
				model.addAttribute("sDeptList",sDeptList);
			}
			
			List<SchDept> deptList = null;
			if(StringUtil.isNotBlank(deptFlow)){
				deptList = schDeptBiz.searchSchDept(deptFlow);
			}else{
				//获取用户所有轮转科室
				deptList = schDeptBiz.userSchDept(userFlow);
			}
			if(deptList!=null && deptList.size()>0){
				List<String> schDeptFlows = new ArrayList<String>();
				for(SchDept sd : deptList){
					String currSdFlow = sd.getSchDeptFlow();
					if(!deptList.contains(currSdFlow)){
						schDeptFlows.add(currSdFlow);
					}
				}
				if(schDeptFlows.size()>0){
					List<ResRec> recList = resRecBiz.searchByDeptWithBLOBs(recTypeId,schDeptFlows);
					if(recList!=null && recList.size()>0){
						model.addAttribute("recList",recList);
						
						Map<String,List<Map<String,String>>> viewListMap = new HashMap<String, List<Map<String,String>>>();
						Map<String,List<ResRec>> recListMap = new HashMap<String, List<ResRec>>();
						List<String> userFlows = new ArrayList<String>();
						for(ResRec rec : recList){
							String content = rec.getRecContent();
							String key = rec.getRecFlow();
							String operUserFlow = rec.getOperUserFlow();
							
							List<Map<String,String>> viewMapList = resRecBiz.parseViewValue(content);
							viewListMap.put(key,viewMapList);
							
							if(recListMap.get(operUserFlow)==null){
								List<ResRec> recs = new ArrayList<ResRec>();
								recs.add(rec);
								recListMap.put(operUserFlow,recs);
								userFlows.add(operUserFlow);
							}else{
								recListMap.get(operUserFlow).add(rec);
							}
						}
						model.addAttribute("viewListMap",viewListMap);
						model.addAttribute("recListMap",recListMap);
						
						if(userFlows!=null && userFlows.size()>0){
							List<SysUser> userList = userBiz.searchSysUserByuserFlows(userFlows);
							model.addAttribute("userList",userList);
							
							List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
							if(doctorList!=null && doctorList.size()>0){
								Map<String,ResDoctor> doctorMap = new HashMap<String, ResDoctor>();
								for(ResDoctor doctor : doctorList){
									doctorMap.put(doctor.getDoctorFlow(),doctor);
								}
								model.addAttribute("doctorMap",doctorMap);
							}
						}
					}
				}
			}
		}
		return "/res/teacher/globalFormAudit";
	}

	@RequestMapping(value="/afterFormAudit/{roleFlag}",method={RequestMethod.GET,RequestMethod.POST})
	public String afterFormAudit(@PathVariable String roleFlag,Model model,ResDoctor doctor,ResDoctorSchProcess process, String schDeptFlow){
		model.addAttribute("roleFlag",roleFlag);
		
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		//process.setIsCurrentFlag(GlobalConstant.FLAG_Y);
		
		List<ResDoctorSchProcess> processList = null;
		Map<String,String> roleFlagMap = new HashMap<String, String>();
		roleFlagMap.put("roleFlag",roleFlag);
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			process.setTeacherUserFlow(userFlow);
			//processList = doctorProcessBiz.searchProcessByDoctor(doctor, process);
		}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			roleFlagMap.put("val",userFlow);
			//process.setHeadUserFlow(userFlow);
			//processList = doctorProcessBiz.searchProcessByDoctor(doctor, process);
		}else if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(roleFlag)){
			roleFlagMap.put("val",userFlow);
			//processList = doctorProcessBiz.searchCurrentProcessByUserFlow(userFlow,process.getIsCurrentFlag());
		}else if(GlobalConstant.RES_ROLE_SCOPE_ADMIN.equals(roleFlag)){
			roleFlagMap.put("val",GlobalContext.getCurrentUser().getOrgFlow());
			//processList = doctorProcessBiz.searchProcessByDoctor(doctor, process);
		}
		
		processList = doctorProcessBiz.searchProcessByDoctor(doctor, process,roleFlagMap);
		if(processList!=null && processList.size()>0){
			model.addAttribute("processList",processList);
			List<String> userFlows = new ArrayList<String>();
			for(ResDoctorSchProcess rdsp : processList){
				userFlows.add(rdsp.getUserFlow());
			}
			
			List<SysUser> userList = userBiz.searchSysUserByuserFlows(userFlows);
			if(userList!=null && userList.size()>0){
				Map<String,SysUser> userMap = new HashMap<String, SysUser>();
				for(SysUser su : userList){
					userMap.put(su.getUserFlow(),su);
				}
				model.addAttribute("userMap",userMap);
			}
			
			List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
			if(doctorList!=null && doctorList.size()>0){
				Map<String,ResDoctor> doctorMap = new HashMap<String, ResDoctor>();
				for(ResDoctor rd : doctorList){
					doctorMap.put(rd.getDoctorFlow(),rd);
				}
				model.addAttribute("doctorMap",doctorMap);
			}
		}
//		List<SysUser> userList = userBiz.searchAfterAuditUser(process,null);
//		model.addAttribute("userList",userList);
		
		List<String> recTypeIds = new ArrayList<String>();
		for(AfterRecTypeEnum afterRec : AfterRecTypeEnum.values()){
			if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("res_"+afterRec.getId()+"_form_flag"))){
				recTypeIds.add(afterRec.getId());
			}
		}
		List<ResRec> recList = resRecBiz.searchAfterAuditRec(process,null,recTypeIds,roleFlagMap);
		if(recList!=null && recList.size()>0){
			Map<String,ResRec> recMap = new HashMap<String, ResRec>();
			for(ResRec rec : recList){
				String key = rec.getOperUserFlow()+rec.getSchDeptFlow()+rec.getRecTypeId();
				recMap.put(key,rec);
			}
			model.addAttribute("recMap",recMap);
		}
		return "/res/teacher/afterFormAuditList";
	}
	
	
	@RequestMapping(value="/globalRegAudit/{roleFlag}",method={RequestMethod.GET,RequestMethod.POST})
	public String globalRegAudit(@PathVariable String roleFlag,Model model){
		model.addAttribute("roleFlag",roleFlag);
		
		return "/res/teacher/globalRegAudit";
	}
	@RequestMapping(value="/globalRegAuditList",method={RequestMethod.GET,RequestMethod.POST})
	public String globalRegAuditList(String roleFlag,String recTypeId,String doctorFlow,ResDoctorSchProcess process,String year,Model model, String operUserFlow){
		String url = "/res/teacher/globalRegAuditList";
		
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		//process.setIsCurrentFlag(GlobalConstant.FLAG_Y);
		Map<String,String> roleFlagMap = new HashMap<String, String>();
		roleFlagMap.put("roleFlag",roleFlag);
		if(GlobalConstant.RES_ROLE_SCOPE_TEACHER.equals(roleFlag)){
			process.setTeacherUserFlow(userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_HEAD.equals(roleFlag)){
			//process.setHeadUserFlow(userFlow);
			roleFlagMap.put("val",userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(roleFlag)){
			roleFlagMap.put("val",userFlow);
		}else if(GlobalConstant.RES_ROLE_SCOPE_ADMIN.equals(roleFlag)){
			roleFlagMap.put("val",GlobalContext.getCurrentUser().getOrgFlow());
		}
		
		roleFlagMap.put("year",year);
		
		List<ResDoctorSchProcess> processList = doctorProcessBiz.searchProcessByDoctor(null,process,roleFlagMap);
		if(processList!=null && processList.size()>0){
			model.addAttribute("processList",processList);
			
			List<String> userFlows = new ArrayList<String>();
			for(ResDoctorSchProcess rdsp : processList){
				userFlows.add(rdsp.getUserFlow());
			}
			
			List<SysUser> userList = userBiz.searchSysUserByuserFlows(userFlows);
			if(userList!=null && userList.size()>0){
				model.addAttribute("userList",userList);
				
				Map<String,SysUser> userMap = new HashMap<String, SysUser>();
				for(SysUser su : userList){
					userMap.put(su.getUserFlow(),su);
				}
				model.addAttribute("userMap",userMap);
			}
			
			List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
			if(doctorList!=null && doctorList.size()>0){
				Map<String,ResDoctor> doctorMap = new HashMap<String, ResDoctor>();
				for(ResDoctor rd : doctorList){
					doctorMap.put(rd.getDoctorFlow(),rd);
				}
				model.addAttribute("doctorMap",doctorMap);
			}
		}
		
		if(StringUtil.isNotBlank(recTypeId)){
			List<String> recTypeIds = new ArrayList<String>();
			recTypeIds.add(recTypeId);
			
			process.setUserFlow(doctorFlow);
			
			List<ResRec> recList = null;
			if(RegistryTypeEnum.AnnualTrainForm.getId().equals(recTypeId)){
				url = "/res/teacher/annualTrainFormList";
				if(StringUtil.isNotBlank(doctorFlow)){
					recList = resRecBiz.searchAfterAuditRec(process,null,recTypeIds,roleFlagMap);
					
					if(recList!=null && recList.size()>0){
						Map<String,Map<String,String>> recDataMap = new HashMap<String, Map<String,String>>();
						for(ResRec rr : recList){
							String recContent = rr.getRecContent();
							Map<String,String> dataMap = resRecBiz.parseRecContent(recContent);
							recDataMap.put(rr.getRecFlow(),dataMap);
						}
						model.addAttribute("recDataMap",recDataMap);
					}
				}
			}else{
				String recTypeName = GlobalRecTypeEnum.getNameById(recTypeId);
				model.addAttribute("recTypeName",recTypeName);
				recList = resRecBiz.searchAfterAuditRec(process,null,recTypeIds,roleFlagMap);
				if(recList!=null && recList.size()>0){
					Map<String,List<Map<String,String>>> viewListMap = new HashMap<String, List<Map<String,String>>>();
					for(ResRec recTemp : recList){
						List<Map<String,String>> viewInfoList = resRecBiz.parseViewValue(recTemp.getRecContent());
						viewListMap.put(recTemp.getRecFlow(),viewInfoList);
					}
					model.addAttribute("viewListMap",viewListMap);
				}
			}
			model.addAttribute("recList",recList);
		}
		return url;
	}

	/**
	 * 审核所有rec
	 * @param recFlows
	 * @param rec
	 * @return
	 */
	@RequestMapping(value="/auditRecs",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String auditRecs(String[] recFlows,ResRec rec){
		int result = resRecBiz.auditRecs(recFlows,rec);
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	@RequestMapping(value="/showDocAndUser",method={RequestMethod.GET,RequestMethod.POST})
	public String showDocAndUserInfo(String flow, Model model){
		if(StringUtil.isNotBlank(flow)){
			ResDoctor doctor=doctorBiz.searchByUserFlow(flow);
			model.addAttribute("doctor", doctor);
			SysUser user=userBiz.findByFlow(flow);
			model.addAttribute("user", user);
		}
		return "/res/teacher/showDocAndUserInfo";
	}
	
	
	@RequestMapping(value="/tutorView",method={RequestMethod.GET,RequestMethod.POST})
	public String tutorView(String sessionNumber,
			String doctorCategoryId,
			String trainingSpeId,
			//String specialized,
			//String deptFlow,
			String userName,
			//String doctorCode,
			//String idNo,
			Integer currentPage,
			String orgFlow,
			String deptFlow,
			Model model){
		
		SysUser currUser = GlobalContext.getCurrentUser();
		
		ResDoctorExt doctorExt = new ResDoctorExt();
		SysUser user = new SysUser();
		doctorExt.setSysUser(user);
		
		doctorExt.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		doctorExt.setSessionNumber(sessionNumber);
		doctorExt.setDoctorCategoryId(doctorCategoryId);
		doctorExt.setTrainingSpeId(trainingSpeId);
		doctorExt.setOrgFlow(orgFlow);
		//doctorExt.setSpecialized(specialized);
		//doctorExt.setDeptFlow(deptFlow);
		//doctorExt.setDoctorCode(doctorCode);
		
		user.setUserName(userName);
		//user.setIdNo(idNo);
		//user.setOrgFlow(orgFlow);
		user.setDeptFlow(deptFlow);

		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,10);
		
		doctorExt.setTutorFlow(currUser.getUserFlow());
		
		List<ResDoctorExt> doctorExtList = doctorBiz.searchDocUser(doctorExt);
		if(doctorExtList!=null && doctorExtList.size()>0){
			model.addAttribute("doctorExtList",doctorExtList);
			
			List<String> doctorFlows = new ArrayList<String>();
			for(ResDoctorExt doctorExtTemp : doctorExtList){
				doctorFlows.add(doctorExtTemp.getDoctorFlow());
			}
			
			List<Map<String,Object>> resultCountMapList = resultBiz.countResultByUser(doctorFlows);
			if(resultCountMapList!=null && resultCountMapList.size()>0){
				Map<String,Object> resultCountMap = new HashMap<String, Object>();
				for(Map<String,Object> map : resultCountMapList){
					resultCountMap.put((String)map.get("key"),map.get("value"));
				}
				model.addAttribute("resultCountMap",resultCountMap);
			}
			List<Map<String,Object>> processCountMapList = resRecBiz.countProcessByUser(doctorFlows);
			if(processCountMapList!=null && processCountMapList.size()>0){
				Map<String,Object> processCountMap = new HashMap<String, Object>();
				for(Map<String,Object> map : processCountMapList){
					processCountMap.put((String)map.get("key"),map.get("value"));
				}
				model.addAttribute("processCountMap",processCountMap);
			}
		}
		
		SysDept dept = new SysDept();
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		List<SysDept> deptList = deptBiz.searchDept(dept);
		model.addAttribute("deptList",deptList);
		
		List<SysOrg> orgList = orgBiz.searchSysOrg();
		model.addAttribute("orgList",orgList);
		
		model.addAttribute("scope",GlobalConstant.RES_ROLE_SCOPE_TUTOR);
		
		return "/res/teacher/tutor/registryNoteList";
	}
}
