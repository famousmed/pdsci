package com.pinde.sci.ctrl.res;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import oracle.net.aso.s;

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
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorOrgHistoryBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.res.IResRecBiz;
import com.pinde.sci.biz.sch.ISchArrangeResultBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDoctorDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.RecStatusEnum;
import com.pinde.sci.enums.res.ResRecTypeEnum;
import com.pinde.sci.enums.sch.SchStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.form.hbres.ResDoctorTrainingSpeForm;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.ResAppeal;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorOrgHistory;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResRec;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDoctorDept;
import com.pinde.sci.model.mo.SchRotation;
import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.res.ResDoctorExt;
import com.pinde.sci.model.res.ResDoctorSchProcessExt;
@Controller
@RequestMapping("/res/manager")
public class ResManagerController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(ResManagerController.class);
	
	@Autowired
	private IResRecBiz resRecBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private ISchDeptBiz schDeptBiz;
	@Autowired
	private ISchArrangeResultBiz resultBiz;
	@Autowired
	private ISchRotationDeptBiz rotationDeptBiz;
	@Autowired
	private IResDoctorBiz doctorBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IResDoctorProcessBiz processBiz;
	@Resource
	private ISchRotationBiz schRotationtBiz;
	@Resource
	private IOrgBiz orgBiz;
	@Resource
	private ISchArrangeResultBiz schArrangeResultBiz;
	@Resource
	private IResDoctorOrgHistoryBiz docOrgHisBiz;
	@Resource
	private ISchDoctorDeptBiz doctorDeptBiz;
	@Autowired
	private NoticeBiz noticeBiz;
	
	/**
	 * TODO 培训查询
	 */
	@RequestMapping(value="/registryNote/{scope}",method={RequestMethod.POST,RequestMethod.GET})
	public String registryNote(@PathVariable String scope,String sessionNumber,
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
		
		if(GlobalConstant.RES_ROLE_SCOPE_MANAGER.equals(scope)){
			doctorExt.setOrgFlow(currUser.getOrgFlow());
		}else if(GlobalConstant.RES_ROLE_SCOPE_CHARGE.equals(scope)){
			doctorExt.getSysUser().setOrgFlow(currUser.getOrgFlow());
		}
		
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
		
		model.addAttribute("scope",scope);
		if(GlobalConstant.USER_LIST_GLOBAL.equals(scope)){
			List<SysOrg> orgList = orgBiz.searchSysOrg();
			model.addAttribute("orgList",orgList);
		}
		
		return "res/manager/registryNoteList";
	}
	
	/**
	 * TODO 培训医师概况
	 */
	@RequestMapping(value="/doctorDetail")
	public String doctorDetail(String doctorFlow,String isProcess, Model model){
		String goPath = "/res/manager/doctorDetail";
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
			model.addAttribute("doctor",doctor);
			
			SysUser user = userBiz.readSysUser(doctorFlow);
			model.addAttribute("user",user);
			
			if(user!=null){
				List<SchDept> schDeptList = schDeptBiz.searchSchDeptList(user.getOrgFlow());
				if(schDeptList!=null && schDeptList.size()>0){
					Map<String,SchDept> schDeptMap = new HashMap<String, SchDept>();
					for(SchDept schDept : schDeptList){
						schDeptMap.put(schDept.getSchDeptFlow(),schDept);
					}
					model.addAttribute("schDeptMap",schDeptMap);
				}
			}
			
			List<ResDoctorSchProcess> processList = processBiz.searchProcessByDoctor(doctorFlow);
			if(processList!=null && processList.size()>0){
				model.addAttribute("processList",processList);
				
				Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
				for(ResDoctorSchProcess process : processList){
					processMap.put(process.getSchResultFlow(),process);
				}
				model.addAttribute("processMap",processMap);
			}
			
			List<SchArrangeResult> resultList = resultBiz.searchSchArrangeResultByDoctor(doctorFlow);
			if(resultList!=null && resultList.size()>0){
				model.addAttribute("resultList",resultList);
				model.addAttribute("resultFlow",resultList.get(0).getResultFlow());
				model.addAttribute("schDeptFlow",resultList.get(0).getSchDeptFlow());
				
				Map<String,String> perMap = resRecBiz.getFinishPer(resultList, doctorFlow);
				model.addAttribute("perMap",perMap);
				
//				Map<String,SchArrangeResult> resultMap = new HashMap<String, SchArrangeResult>();
//				for(SchArrangeResult result : resultList){
//					resultMap.put(result.getResultFlow(),result);
//				}
//				model.addAttribute("resultMap",resultMap);
			}
			if(GlobalConstant.FLAG_Y.equals(isProcess)){
				if(user!=null){
					model.addAttribute("userFlow",user.getUserFlow());
				}
				goPath = "redirect:/res/doc/goDetailView";
			}
		}
		
		return goPath;
	}
	
	/**
	 * TODO 出科考核表
	 */
	@RequestMapping(value="/evaluation")
	public String evaluation(String doctorFlow,String schDeptFlow,Model model){
		List<ResRec> recList = resRecBiz.searchByRec(ResRecTypeEnum.AfterEvaluation.getId(),schDeptFlow,doctorFlow);
		if(recList!=null && recList.size()>0){
			model.addAttribute("recFlow",recList.get(0).getRecFlow());
		}
		model.addAttribute("recTypeId",ResRecTypeEnum.AfterEvaluation.getId());
		model.addAttribute("roleFlag",GlobalConstant.RES_ROLE_SCOPE_DOCTOR);
		model.addAttribute("schDeptFlow",schDeptFlow);
		return "redirect:/res/rec/showRegistryForm";
	}
	
	
	/**
	 * TODO 登记统计报表main
	 */
	@RequestMapping(value="/registryReportMain",method={RequestMethod.POST,RequestMethod.GET})
	public String registryReportMain(Model model){
		
		return "res/manager/registryReportMain";
	}
	
	/**
	 * TODO 考核手册列表
	 */
	@RequestMapping(value="/registryReportList")
	public String registryReportList(String recTypeId,
			String itemName,
			String sessionNumber,
			String specialized,
			//String deptFlow,
			String userName,
			String doctorCode,
			String startDate,
			String endDate,
			Model model){
		
		ResDoctorSchProcessExt processExt = new ResDoctorSchProcessExt();
		ResDoctorExt doctorExt = new ResDoctorExt();
		SysUser user = new SysUser();
		processExt.setDoctorExt(doctorExt);
		doctorExt.setSysUser(user);
		
		processExt.setStartDate(startDate);
		processExt.setEndDate(endDate);
		
		doctorExt.setSessionNumber(sessionNumber);
		doctorExt.setSpecialized(specialized);
		doctorExt.setDoctorCode(doctorCode);
		
		user.setUserName(userName);
		
		List<ResDoctorSchProcessExt> processExtList = resRecBiz.searchProcessExt(processExt);
		if(processExtList!=null && processExtList.size()>0){
			model.addAttribute("processExtList",processExtList);
			
			List<String> rotationFlows = new ArrayList<String>();
			List<String> schDeptFlows = new ArrayList<String>();
			List<String> userFlows = new ArrayList<String>();
			
			for(ResDoctorSchProcessExt processExtTemp : processExtList){
				String rotationFlow = processExtTemp.getDoctorExt().getRotationFlow();
				String schdeptFlow = processExtTemp.getSchDeptFlow();
				String userFlow = processExtTemp.getUserFlow();
				
				if(!rotationFlows.contains(rotationFlow)){
					rotationFlows.add(rotationFlow);
				}
				
				if(!schDeptFlows.contains(schdeptFlow)){
					schDeptFlows.add(schdeptFlow);
				}
				
				if(!userFlows.contains(userFlow)){
					userFlows.add(userFlow);
				}
			}
			
			List<SchRotationDeptReq> deptReqList = rotationDeptBiz.searchReqByRotationAndSchDept(rotationFlows,schDeptFlows,recTypeId,itemName);
			if(deptReqList!=null && deptReqList.size()>0){
				Map<String,List<SchRotationDeptReq>> deptReqMap = new HashMap<String,List<SchRotationDeptReq>>();
				for(SchRotationDeptReq deptReqTemp : deptReqList){
					String key = deptReqTemp.getRotationFlow()+deptReqTemp.getStandardDeptId();
					
					if(deptReqMap.get(key)==null){
						List<SchRotationDeptReq> deptReqTempList = new ArrayList<SchRotationDeptReq>();
						deptReqTempList.add(deptReqTemp);
						deptReqMap.put(key,deptReqTempList);
					}else{
						if(ResRecTypeEnum.CaseRegistry.getId().equals(recTypeId)){
							BigDecimal reqNum = deptReqMap.get(key).get(0).getReqNum();
							deptReqMap.get(key).get(0).setReqNum(reqNum.add(deptReqTemp.getReqNum()));
						}else{
							deptReqMap.get(key).add(deptReqTemp);
						}
					}
				}
				model.addAttribute("deptReqMap",deptReqMap);
			}
			
			List<ResRec> recList = resRecBiz.searchRecByUserAndSchdept(userFlows,schDeptFlows,recTypeId,itemName);
			if(recList!=null && recList.size()>0){
				Map<String,Integer> countMap = new HashMap<String, Integer>();
				for(ResRec rec : recList){
					String key = rec.getOperUserFlow()+rec.getSchDeptFlow()+StringUtil.defaultString(rec.getItemId());
					
					if(countMap.get(key+"finish")==null){
						countMap.put(key+"finish",1);
					}else{
						countMap.put(key+"finish",countMap.get(key+"finish")+1);
					}
					
					if(RecStatusEnum.TeacherAuditY.getId().equals(rec.getAuditStatusId())){
						if(countMap.get(key+"audit")==null){
							countMap.put(key+"audit",1);
						}else{
							countMap.put(key+"audit",countMap.get(key+"audit")+1);
						}
					}
				}
				model.addAttribute("countMap",countMap);
			}
		}
		
		String path = "error/404";
		if(StringUtil.isNotBlank(recTypeId) && recTypeId.length()>1){
			String head = recTypeId.substring(0,1).toLowerCase();
			String body = recTypeId.substring(1);
			path = "/res/manager/"+head+body+"ReportList";
		}
		return path;
	}
	
	/**
	 * TODO 数据详情
	 */
	@RequestMapping(value="/recDetail",method={RequestMethod.POST,RequestMethod.GET})
	public String recDetail(String itemName,String rotationFlow,String userFlow,String schDeptFlow,String recTypeId,Model model,Integer currentPage){
		if(StringUtil.isNotBlank(itemName)){
			SchRotationDeptReq deptReq = rotationDeptBiz.readDeptReq(itemName);
			if(deptReq!=null){
				itemName = deptReq.getItemId();
			}
		}
		
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,10);
		
		List<ResRec> recList = resRecBiz.searchByRecWithBLOBs(recTypeId, schDeptFlow, userFlow,itemName);
		if(recList!=null && recList.size()>0){
			Map<String,Map<String,String>> recContentMap = new HashMap<String, Map<String,String>>();
			for(ResRec rec : recList){
				String recContent = rec.getRecContent();
				if(StringUtil.isNotBlank(recContent)){
					Map<String,String> contentMap = resRecBiz.parseRecContent(recContent);
					recContentMap.put(rec.getRecFlow(),contentMap);
				}
			}
			model.addAttribute("doctorName",recList.get(0).getOperUserName());
			model.addAttribute("schDeptName",recList.get(0).getSchDeptName());
			model.addAttribute("recContentMap",recContentMap);
			model.addAttribute("recList",recList);
		}
		if(StringUtil.isNotBlank(rotationFlow) && StringUtil.isNotBlank(schDeptFlow)){
			List<SchRotationDeptReq> deptReqList = rotationDeptBiz.searchDeptReqByItemId(rotationFlow, schDeptFlow,itemName);
			if(deptReqList!=null && deptReqList.size()>0){
				Map<String,SchRotationDeptReq> deptReqMap = new HashMap<String, SchRotationDeptReq>();
				for(SchRotationDeptReq req : deptReqList){
					deptReqMap.put(req.getReqFlow(),req);
				}
				model.addAttribute("deptReqMap",deptReqMap);
			}
		}
		return "/res/manager/recDetailList";
	}
	
	/**
	 * TODO 申述查询
	 */
	@RequestMapping(value="/appealList")
	public String appealList(Model model){
		
		return "/res/manager/appealList";
	}
	
	/**
	 * TODO 出科情况查询
	 */
	@RequestMapping(value="/afterInfoList")
	public String afterInfoList(Model model){
		
		return "/res/manager/afterInfoList";
	}
	
	/**
	 * TODO 人员维护
	 */
	@RequestMapping(value="/userList")
	public String userList(ResDoctorExt doctor,Integer currentPage,HttpServletRequest request,Model model){
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		
		if(StringUtil.isNotBlank(doctor.getDoctorCategoryId())){
			doctor.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			doctor.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			List<ResDoctorExt> doctorList = doctorBiz.searchDocUser(doctor);
			model.addAttribute("doctorList",doctorList);
		}
		
		return "/res/manager/userList";
	}
	@RequestMapping(value="/manageUser")
	public String manageUser(Integer currentPage,SysUser user,HttpServletRequest request,Model model){
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		user.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		List<SysUser> sysUserList = userBiz.searchResManageUser(user);
//		List<SysUser> sysUserList = userBiz.searchUser(user);
		model.addAttribute("sysUserList", sysUserList);
		
		String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		List<SysUserRole> sysUserRoleList = userRoleBiz.getByOrgFlow(null,wsId);
		Map<String,List<String>> sysUserRoleMap  = new HashMap<String, List<String>>();
		for(SysUserRole sysUserRole : sysUserRoleList){
			String userFlow = sysUserRole.getUserFlow();
			if(sysUserRoleMap.containsKey(userFlow)){
				List<String> list = sysUserRoleMap.get(userFlow);
				list.add(sysUserRole.getRoleFlow());
			}else{
				List<String> list = new ArrayList<String>();
				list.add(sysUserRole.getRoleFlow());
				sysUserRoleMap.put(userFlow, list);
			}
		}			
		model.addAttribute("sysUserRoleMap", sysUserRoleMap);
		return "/res/manager/manageUser";
	}
	
	/**
	 * TODO 用户编辑
	 */
	@RequestMapping(value={"/editDocSimple"},method={RequestMethod.GET})
	public String editDocSimple(String roleFlag,String doctorFlow,Model model){
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
			model.addAttribute("doctor",doctor);
			SysUser user = userBiz.readSysUser(doctorFlow);
			model.addAttribute("user",user);
			
//			if(GlobalConstant.USER_LIST_GLOBAL.equals(roleFlag)){
//				SchRotation rotation = schRotationtBiz.readSchRotation(doctor.getRotationFlow());
//				if(rotation!=null){
//					doctor.setRotationFlow(rotation.getRotationFlow());
//				}
//			}
			
			model.addAttribute("rotationInUse",false);
			List<SchDoctorDept> doctorDeptList = doctorDeptBiz.searchSchDoctorDept(doctorFlow);
			if(doctorDeptList!=null && doctorDeptList.size()>0){
				model.addAttribute("rotationInUse",true);
			}else{
				List<SchArrangeResult> resultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
				if(resultList!=null && resultList.size()>0){
					model.addAttribute("rotationInUse",true);
				}
			}
		}
		
		if(GlobalConstant.USER_LIST_GLOBAL.equals(roleFlag)){
			SysOrg searchOrg = new SysOrg();
			searchOrg.setOrgTypeId(OrgTypeEnum.Hospital.getId());
			List<SysOrg> orgList = orgBiz.searchSysOrg(searchOrg);
			model.addAttribute("orgList",orgList);
		}
		List<SchRotation> rotationList = schRotationtBiz.searchSchRotationByIsPublish();
		model.addAttribute("rotationList",rotationList);
		
		
		SysDept dept = new SysDept();
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		dept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		List<SysDept> deptList = deptBiz.searchDept(dept);
		model.addAttribute("deptList",deptList);
		
		//所有导师
		String tutorRoleFlow = InitConfig.getSysCfg("res_tutor_role_flow");
		if(StringUtil.isNotBlank(tutorRoleFlow)){
			SysUserRole searchObj = new SysUserRole();
			searchObj.setRoleFlow(tutorRoleFlow);
			List<SysUserRole> tutorRoleList = userRoleBiz.searchUserRole(searchObj);
			if(tutorRoleList!=null && tutorRoleList.size()>0){
				List<String> userFlows = new ArrayList<String>();
				for(SysUserRole sur : tutorRoleList){
					userFlows.add(sur.getUserFlow());
				}
				List<SysUser> tutorList = userBiz.searchSysUserByuserFlows(userFlows);
				model.addAttribute("tutorList",tutorList);
			}
		}
		
		return "res/doctor/user/editDocSimple";
	}
	
	@RequestMapping(value={"/trainingSpeCountList"}, method={RequestMethod.GET,RequestMethod.POST})
	public String trainingSpeCountList(ResDoctor doctor, Model model){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		doctor.setOrgFlow(GlobalContext.getCurrentUser().getUserFlow());
		//String regYear = InitConfig.getSysCfg("res_reg_year");
		if(StringUtil.isNotBlank(doctor.getSessionNumber())){
			paramMap.put("doctor", doctor);
			List<ResDoctorTrainingSpeForm> trainingSpeFormList =  doctorBiz.trainingSpeCountList(paramMap);
			if(trainingSpeFormList != null && !trainingSpeFormList.isEmpty()){
				Map<String, String> trainingSpeFormMap =  new HashMap<String, String>();
				for(ResDoctorTrainingSpeForm form : trainingSpeFormList){
					trainingSpeFormMap.put(form.getSpeId(), form.getDoctorCount());
				}
				model.addAttribute("trainingSpeFormMap", trainingSpeFormMap);
			}
		}
		return "res/manager/trainingSpeCountList";
	}
	
	/**
	 * TODO 医师登记详情
	 */
	@RequestMapping(value={"/doctorRegistryDetatil"}, method={RequestMethod.GET,RequestMethod.POST})
	public String doctorRegistryDetatil(String userFlow,Model model){
//		List<String> doctorFlows = new ArrayList<String>();
//		doctorFlows.add(userFlow);
//		List<SchArrangeResult> arrResultList = schArrangeResultBiz.searchArrangeResultByDoctorFlows(doctorFlows);
		if(StringUtil.isNotBlank(userFlow)){
			List<SchArrangeResult> arrResultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(userFlow);
			if(arrResultList!=null&&!arrResultList.isEmpty()){
				List<String> schResultFlows = new ArrayList<String>();
				for (SchArrangeResult result : arrResultList) {
					schResultFlows.add(result.getResultFlow());
				}
				model.addAttribute("arrResultList", arrResultList);
				
				List<ResDoctorSchProcess> processList = processBiz.searchByResultFlows(schResultFlows);
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
		}
		return "res/manager/doctor/process";
	}
	
	@RequestMapping(value="/requireDataList",method={RequestMethod.GET,RequestMethod.POST})
	public String requireDataList(String schDeptFlow,String rotationFlow,String recTypeId,String resultFlow,Model model){
		
		Map<String,Integer> recCountMap = new HashMap<String, Integer>();
		
		String userFlow = GlobalContext.getCurrentUser().getUserFlow();
		
		if(StringUtil.isNotBlank(recTypeId) && StringUtil.isNotBlank(schDeptFlow) && StringUtil.isNotBlank(rotationFlow)){
			List<ResRec> recList = resRecBiz.searchByRecWithBLOBs(recTypeId,schDeptFlow,userFlow);
			if(recList!=null && recList.size()>0){
				model.addAttribute("recList",recList);
				
				//Map<String,Map<String,String>> recMap = new HashMap<String, Map<String,String>>();
				Map<String,List<Map<String,String>>> viewListMap = new HashMap<String, List<Map<String,String>>>();
				Map<String,List<ResRec>> recListMap = new HashMap<String,List<ResRec>>();
				for(ResRec recTemp : recList){
					//Map<String,String> formDataMap = resRecBiz.parseRecContent(recTemp.getRecContent());
					//recMap.put(recTemp.getRecFlow(),formDataMap);
					
					List<Map<String,String>> viewInfoList = resRecBiz.parseViewValue(recTemp.getRecContent());
					viewListMap.put(recTemp.getRecFlow(),viewInfoList);
					
					//String itemName = StringUtil.defaultIfEmpty(recTemp.getItemName(),"other");
					
					String itemId = recTemp.getItemId();
					
					if(recListMap.get(itemId)==null){
						List<ResRec> recTempList = new ArrayList<ResRec>();
						recTempList.add(recTemp);
						recListMap.put(itemId,recTempList);
					}else{
						recListMap.get(itemId).add(recTemp);
					}
					
					if(RecStatusEnum.TeacherAuditY.getId().equals(recTemp.getAuditStatusId())){
						if(recCountMap.get("auditCount")==null){
							recCountMap.put("auditCount",1);
						}else{
							recCountMap.put("auditCount",recCountMap.get("auditCount")+1);
						}
						
						if(recCountMap.get(itemId+"auditCount")==null){
							recCountMap.put(itemId+"auditCount",1);
						}else{
							recCountMap.put(itemId+"auditCount",recCountMap.get(itemId+"auditCount")+1);
						}
					}
					
					if(recCountMap.get("finishCount")==null){
						recCountMap.put("finishCount",1);
					}else{
						recCountMap.put("finishCount",recCountMap.get("finishCount")+1);
					}
					
					if(recCountMap.get(itemId+"finishCount")==null){
						recCountMap.put(itemId+"finishCount",1);
					}else{
						recCountMap.put(itemId+"finishCount",recCountMap.get(itemId+"finishCount")+1);
					}
					
					if(recCountMap.get(recTemp.getRecTypeId()+"finish")==null){
						recCountMap.put(recTemp.getRecTypeId()+"finish",1);
					}else{
						recCountMap.put(recTemp.getRecTypeId()+"finish",recCountMap.get(recTemp.getRecTypeId()+"finish")+1);
					}
				}
				//model.addAttribute("recMap",recMap);
				model.addAttribute("viewListMap",viewListMap);
				model.addAttribute("recListMap",recListMap);
			}
			
			List<ResAppeal> appealList = resRecBiz.searchAppeal(recTypeId,schDeptFlow,userFlow);
			if(appealList!=null && appealList.size()>0){
				Map<String,ResAppeal> appealMap = new HashMap<String,ResAppeal>();
				for(ResAppeal appeal : appealList){
					appealMap.put(appeal.getItemId(),appeal);
					
//					if(RecStatusEnum.TeacherAuditY.getId().equals(appeal.getAuditStatusId())){
//						if(recCountMap.get("appealCount")==null){
//							recCountMap.put("appealCount",appeal.getAppealNum().intValue());
//						}else{
//							recCountMap.put("appealCount",recCountMap.get("appealCount")+appeal.getAppealNum().intValue());
//						}
//						
//						if(recCountMap.get(appeal.getItemName()+"appealCount")==null){
//							recCountMap.put(appeal.getItemName()+"appealCount",appeal.getAppealNum().intValue());
//						}else{
//							recCountMap.put(appeal.getItemName()+"appealCount",recCountMap.get(appeal.getItemName()+"appealCount")+appeal.getAppealNum().intValue());
//						}
//					}
				}
				model.addAttribute("appealMap",appealMap);
			}
		}
		
		//计算要求数
		if(StringUtil.isNotBlank(resultFlow)){
			SchArrangeResult result = schArrangeResultBiz.readSchArrangeResult(resultFlow);
			
			List<SchRotationDeptReq> deptReqList = rotationDeptBiz.searchStandardReqByResult(result,recTypeId);
			if(deptReqList!=null && deptReqList.size()>0){
				model.addAttribute("deptReqList",deptReqList);
				
				Map<String,SchRotationDeptReq> deptReqMap = new HashMap<String, SchRotationDeptReq>();
				for(SchRotationDeptReq deptReqTemp : deptReqList){
					deptReqMap.put(deptReqTemp.getReqFlow(),deptReqTemp);
					if(recCountMap.get(deptReqTemp.getRecTypeId()+"reqNum")==null){
						recCountMap.put(deptReqTemp.getRecTypeId()+"reqNum",deptReqTemp.getReqNum().intValue());
					}else{
						recCountMap.put(deptReqTemp.getRecTypeId()+"reqNum",recCountMap.get(deptReqTemp.getRecTypeId()+"reqNum")+deptReqTemp.getReqNum().intValue());
					}
				}
				
				model.addAttribute("deptReqMap",deptReqMap);
			}
		}
		
		model.addAttribute("recCountMap",recCountMap);
		
		return "res/manager/doctor/registryView";
	}
	
	/**
	 * 培训视图 TODO
	 * */
	@RequestMapping(value="/processView",method={RequestMethod.GET})
	public String processView(String resultFlow,String processFlow,Model model){
		SchArrangeResult result = schArrangeResultBiz.readSchArrangeResult(resultFlow);
		if(result!=null){
			model.addAttribute("result",result);
			List<SchArrangeResult> results = new ArrayList<SchArrangeResult>();
			results.add(result);
			Map<String,String> recFinishMap = resRecBiz.getFinishPer(results);
			model.addAttribute("recFinishMap",recFinishMap);
			
			//要求数
			List<SchRotationDeptReq> deptReqList = rotationDeptBiz.searchStandardReqByResult(result);
			if(deptReqList!=null && deptReqList.size()>0){
				Map<String,BigDecimal> reqNumMap = new HashMap<String,BigDecimal>();
				for(SchRotationDeptReq req : deptReqList){
					String key = req.getRecTypeId();
					if(reqNumMap.get(key)==null){
						reqNumMap.put(key,req.getReqNum());
					}else{
						reqNumMap.put(key,reqNumMap.get(key).add(req.getReqNum()));
					}
				}
				model.addAttribute("reqNumMap",reqNumMap);
			}
		}
		
		ResDoctorSchProcess process = processBiz.read(processFlow);
		if(process!=null){
			model.addAttribute("process",process);
			
			String schDeptFlow = process.getSchDeptFlow();
			
			//申述数
			List<Map<String,Object>> appealCountList = resRecBiz.searchAppealCount(schDeptFlow,GlobalContext.getCurrentUser().getUserFlow());
			if(appealCountList!=null && appealCountList.size()>0){
				Map<Object,Object> appealCount = new HashMap<Object, Object>();
				for(Map<String,Object> map : appealCountList){
					appealCount.put(map.get("appealKey"),map.get("appealSum"));
				}
				model.addAttribute("appealCount",appealCount);
			}
			
			//带教老师,科室考评
			List<String> recTypeIds = new ArrayList<String>();
			recTypeIds.add(ResRecTypeEnum.DeptGrade.getId());
			recTypeIds.add(ResRecTypeEnum.TeacherGrade.getId());
			recTypeIds.add(ResRecTypeEnum.AfterEvaluation.getId());
			
			List<ResRec> deptGradeList = resRecBiz.searchByRecWithBLOBs(recTypeIds,schDeptFlow,GlobalContext.getCurrentUser().getUserFlow());
			
			if(deptGradeList!=null && deptGradeList.size()>0){
				for(ResRec rec : deptGradeList){
					String recTypeId = rec.getRecTypeId();
					if(ResRecTypeEnum.DeptGrade.getId().equals(recTypeId)){
						Map<String,Object> gradeMap = resRecBiz.parseGradeXml(rec.getRecContent());
						model.addAttribute("deptGrade",rec);
						model.addAttribute("deptGradeMap", gradeMap);
					}else if(ResRecTypeEnum.TeacherGrade.getId().equals(recTypeId)){
						Map<String,Object> gradeMap = resRecBiz.parseGradeXml(rec.getRecContent());
						model.addAttribute("teacherGrade",rec);
						model.addAttribute("teacherGradeMap", gradeMap);
					}else if(ResRecTypeEnum.AfterEvaluation.getId().equals(recTypeId)){
						model.addAttribute("evaluation",rec);
					}
				}
			}
		}
		
		return "res/manager/doctor/processView";
	}
	
	/**
	 * 轮转变更
	 */
	@RequestMapping(value={"/rotationChangeMain"}, method={RequestMethod.GET,RequestMethod.POST})
	public String orgSpanAudit(Model model){
		
		return "res/manager/rotationChangeMain";
	}
	
	@RequestMapping(value={"/rotationChangeList"}, method={RequestMethod.GET,RequestMethod.POST})
	public String rotationChangeList(ResDoctor doctor,String type,Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		
		List<ResDoctor> doctorList = null;
		ResDoctorOrgHistory docOrgHis = new ResDoctorOrgHistory();
		
		if("toOut".equals(type)){
			doctor.setOrgFlow(orgFlow);
			doctorList = doctorBiz.searchDoctorForChange(doctor,null);
		}else if("outing".equals(type)){
			docOrgHis.setHistoryOrgFlow(orgFlow);
			docOrgHis.setChangeStatusId(SchStatusEnum.Submit.getId());
			doctorList = doctorBiz.searchDoctorForChange(doctor,docOrgHis);
		}else if("isOut".equals(type)){
			docOrgHis.setHistoryOrgFlow(orgFlow);
			docOrgHis.setChangeStatusId(SchStatusEnum.AuditY.getId());
			doctorList = doctorBiz.searchDoctorForChange(doctor,docOrgHis);
		}else if("willIn".equals(type)){
			docOrgHis.setOrgFlow(orgFlow);
			docOrgHis.setChangeStatusId(SchStatusEnum.Submit.getId());
			doctorList = doctorBiz.searchDoctorForChange(doctor,docOrgHis);
		}else if("isIn".equals(type)){
			docOrgHis.setOrgFlow(orgFlow);
			docOrgHis.setChangeStatusId(SchStatusEnum.AuditY.getId());
			doctorList = doctorBiz.searchDoctorForChange(doctor,docOrgHis);
		}
//		switch(type){
//			case "toOut" :
//				doctor.setOrgFlow(orgFlow);
//				doctorList = doctorBiz.searchDoctorForChange(doctor,null);
//				break;
//			case "outing" :
//				docOrgHis.setHistoryOrgFlow(orgFlow);
//				docOrgHis.setChangeStatusId(SchStatusEnum.Submit.getId());
//				doctorList = doctorBiz.searchDoctorForChange(doctor,docOrgHis);
//				break;
//			case "isOut" :
//				docOrgHis.setHistoryOrgFlow(orgFlow);
//				docOrgHis.setChangeStatusId(SchStatusEnum.AuditY.getId());
//				doctorList = doctorBiz.searchDoctorForChange(doctor,docOrgHis);
//				break;
//			case "willIn" :
//				docOrgHis.setOrgFlow(orgFlow);
//				docOrgHis.setChangeStatusId(SchStatusEnum.Submit.getId());
//				doctorList = doctorBiz.searchDoctorForChange(doctor,docOrgHis);
//				break;
//			case "isIn" :
//				docOrgHis.setOrgFlow(orgFlow);
//				docOrgHis.setChangeStatusId(SchStatusEnum.AuditY.getId());
//				doctorList = doctorBiz.searchDoctorForChange(doctor,docOrgHis);
//		}
		
		if(doctorList!=null && doctorList.size()>0){
			model.addAttribute("doctorList",doctorList);
			
			List<String> doctorFlows = new ArrayList<String>();
			for(ResDoctor doctorTemp : doctorList){
				doctorFlows.add(doctorTemp.getDoctorFlow());
			}
			
			List<ResDoctorOrgHistory> docOrgHistoryList = docOrgHisBiz.searchHistoryByDoctorFlows(doctorFlows);
			if(docOrgHistoryList!=null && docOrgHistoryList.size()>0){
				Map<String,ResDoctorOrgHistory> okDocOrgHisMap = new HashMap<String, ResDoctorOrgHistory>();
				Map<String,ResDoctorOrgHistory> nkDocOrgHisMap = new HashMap<String, ResDoctorOrgHistory>();
				
				for(ResDoctorOrgHistory docOrgHisTemp : docOrgHistoryList){
					String ok = docOrgHisTemp.getDoctorFlow()+docOrgHisTemp.getHistoryOrgFlow();
					String nk = docOrgHisTemp.getDoctorFlow()+docOrgHisTemp.getOrgFlow();
					
					okDocOrgHisMap.put(ok,docOrgHisTemp);
					nkDocOrgHisMap.put(nk,docOrgHisTemp);
				}
				
				model.addAttribute("okDocOrgHisMap",okDocOrgHisMap);
				model.addAttribute("nkDocOrgHisMap",nkDocOrgHisMap);
			}
			
			List<SysUser> userList = userBiz.searchSysUserByuserFlows(doctorFlows);
			if(userList!=null && userList.size()>0){
				Map<String,SysUser> userMap = new HashMap<String, SysUser>();
				for(SysUser user : userList){
					userMap.put(user.getUserFlow(),user);
				}
				model.addAttribute("userMap",userMap);
			}
		}
		
		return "res/manager/rotationChangeList";
	}
	
	@RequestMapping(value={"/docOrgHisEdit"}, method={RequestMethod.POST})
	@ResponseBody
	public String docOrgHisEdit(ResDoctorOrgHistory docOrgHis){
		if(StringUtil.isNotBlank(docOrgHis.getTrainingSpeId())){
			docOrgHis.setTrainingSpeName(DictTypeEnum.DoctorTrainingSpe.getDictNameById(docOrgHis.getTrainingSpeId()));
		}
		int result = docOrgHisBiz.editDocOrgHistory(docOrgHis);
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	@RequestMapping(value={"/agreeTurnIn"}, method={RequestMethod.GET})
	@ResponseBody
	public String agreeTurnIn(String doctorFlow,String recordFlow,String rotationFlow){
		ResDoctorOrgHistory docOrgHis = null;
		ResDoctor doctor = null;
		if(StringUtil.isNotBlank(recordFlow)){
			docOrgHis = docOrgHisBiz.readDocOrgHistory(recordFlow);
			if(docOrgHis!=null){
				docOrgHis.setChangeStatusId(SchStatusEnum.AuditY.getId());
				docOrgHis.setChangeStatusName(SchStatusEnum.AuditY.getName());
				docOrgHis.setInDate(DateUtil.getCurrDate());
				
				doctor = new ResDoctor();
				doctor.setDoctorFlow(doctorFlow);
				doctor.setOrgFlow(docOrgHis.getOrgFlow());
				doctor.setOrgName(docOrgHis.getOrgName());
				doctor.setSchFlag("");
				doctor.setSelDeptFlag("");
				doctor.setRotationFlow("");
				doctor.setRotationName("");
				
				if(StringUtil.isNotBlank(rotationFlow)){
					SchRotation rotation = schRotationtBiz.readSchRotation(rotationFlow);
					
					if(rotation!=null){
						doctor.setRotationFlow(rotation.getRotationFlow());
						doctor.setRotationName(rotation.getRotationName());
					}
				}
			}
		}
		
		int result = docOrgHisBiz.editDocOrgHistoryAndDoc(docOrgHis,doctor);
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	@RequestMapping(value={"/rotationList"}, method={RequestMethod.GET})
	@ResponseBody
	public List<SchRotation> rotationList(String orgFlow){
		List<SchRotation> rotationList = null;
		if(StringUtil.isNotBlank(orgFlow)){
			rotationList = schRotationtBiz.searchSchRotationByIsPublish();
		}
		return rotationList;
	}
	
	@RequestMapping(value={"/selRole"}, method={RequestMethod.GET})
	@ResponseBody
	public String rotationList(String userFlow,String roleFlow){
		userRoleBiz.saveSysUserRole(userFlow,roleFlow);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 医院视图
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/view"})
	public String view(String deptFlow,Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		
		//获取本机构所有科室
		List<SysDept> deptList = deptBiz.searchDeptByOrg(currUser.getOrgFlow());
		model.addAttribute("deptList",deptList);
		
		
		//通知
		String beforeSevenDay = DateUtil.addHour(DateUtil.getCurrDateTime(),-7*24).substring(0,8);
		List<InxInfo> infos = noticeBiz.searchInfoByOrgBeforeDate(currUser.getOrgFlow(),beforeSevenDay);
		model.addAttribute("infos",infos);
		
		model.addAttribute("roleFlag",GlobalConstant.RES_ROLE_SCOPE_ADMIN);
		
		//获取当前机构正在轮转的学员的轮转信息
		List<ResDoctorSchProcess> processList = processBiz.searchProcessByOrg(currUser.getOrgFlow());
		List<String> userFlows = new ArrayList<String>();
		if(processList!=null && processList.size()>0){
			Map<String,List<ResDoctorSchProcess>> processListMap = new HashMap<String, List<ResDoctorSchProcess>>();
			for(ResDoctorSchProcess rdsp : processList){
				userFlows.add(rdsp.getUserFlow());
				
				String key = rdsp.getDeptFlow();
				if(processListMap.get(key)==null){
					List<ResDoctorSchProcess> rdspList = new ArrayList<ResDoctorSchProcess>();
					rdspList.add(rdsp);
					processListMap.put(key,rdspList);
				}else{
					processListMap.get(key).add(rdsp);
				}
			}
			model.addAttribute("processListMap",processListMap);
			
		}
		
		//待入科查询
		List<SchArrangeResult> resultList = resultBiz.willInDoctor(currUser.getOrgFlow(),null);
		if(resultList!=null && resultList.size()>0){
			List<String> doctorFlows = new ArrayList<String>();
			Map<String,List<SchArrangeResult>> willInResultListMap = new HashMap<String, List<SchArrangeResult>>();
			for(SchArrangeResult result : resultList){
				if(!doctorFlows.contains(result.getDoctorFlow())){
					doctorFlows.add(result.getDoctorFlow());
					String key = result.getDeptFlow();
					if(willInResultListMap.get(key)==null){
						List<SchArrangeResult> sarList = new ArrayList<SchArrangeResult>();
						sarList.add(result);
						willInResultListMap.put(key,sarList);
					}else{
						willInResultListMap.get(key).add(result);
					}
					userFlows.add(result.getDoctorFlow());
				}
			}
			model.addAttribute("willInResultListMap",willInResultListMap);
		}
		
		//获取用户和医师信息
		if(userFlows.size()>0){
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
		return "res/manager/view";
	}
	
}
