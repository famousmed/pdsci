package com.pinde.sci.ctrl.res;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorOrgHistoryBiz;
import com.pinde.sci.biz.res.IResJointOrgBiz;
import com.pinde.sci.biz.sch.ISchDoctorAbsenceBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.ResDoctorStatusEnum;
import com.pinde.sci.enums.sch.SchStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorOrgHistory;
import com.pinde.sci.model.mo.ResJointOrg;
import com.pinde.sci.model.mo.SchDoctorAbsence;
import com.pinde.sci.model.mo.SchRotation;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorExt;
@Controller
@RequestMapping("/res/platform")
public class ResPlatformController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(ResPlatformController.class);
	
	@Resource
	private ISchRotationBiz schRotationtBiz;
	@Resource
	private IOrgBiz orgBiz;
	@Resource
	private IUserBiz userBiz;
	@Resource
	private IResDoctorBiz doctorBiz;
	@Autowired
	private NoticeBiz noticeBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IResDoctorOrgHistoryBiz orgHistoryBiz;
	@Autowired
	private ISchDoctorAbsenceBiz absenceBiz;
	@Resource
	private IResJointOrgBiz jointBiz;
	
	/**
	 * TODO 轮转信息列表 
	 * */
	@RequestMapping(value="/rotation",method=RequestMethod.GET)
	public String rotation(Model model){
		model.addAttribute("roleFlag",GlobalConstant.USER_LIST_GLOBAL);
		
		return "redirect:/sch/template/list";
	}
	
	/**
	 * TODO 医院维护
	 * */
	@RequestMapping(value="/hospitalList",method={RequestMethod.GET,RequestMethod.POST})
	public String hospitalList(SysOrg sysOrg,Integer currentPage,HttpServletRequest request,Model model){
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		List<SysOrg> orgList = orgBiz.searchOrderBy(sysOrg);
		if(orgList!=null && orgList.size()>0){
			model.addAttribute("orgList",orgList);
			List<String> orgFlows = new ArrayList<String>();
			for(SysOrg org : orgList){
				orgFlows.add(org.getOrgFlow());
			}
			String roleFlow = InitConfig.getSysCfg("res_admin_role_flow");
			List<SysUser> userList = userBiz.searchUserByRoleAndOrgFlows(roleFlow,orgFlows);
			if(userList!=null && userList.size()>0){
				Map<String,SysUser> userMap = new HashMap<String, SysUser>();
				for(SysUser user : userList){
					if(userMap.get(user.getOrgFlow())==null){
						userMap.put(user.getOrgFlow(),user);
					}
				}
				model.addAttribute("userMap",userMap);
			}
		}
		//协同医院
		List<ResJointOrg> jointList = jointBiz.searchJointOrgAll();
		if(jointList!=null &&jointList.size()>0){
			Map<String,List<ResJointOrg>> jointOrgMap = new HashMap<String,List<ResJointOrg>>();
			for(ResJointOrg jointOrg : jointList){
				String key = jointOrg.getOrgFlow();
				if(jointOrgMap.get(key)==null){
					List<ResJointOrg> jointOrgList = new ArrayList<ResJointOrg>();
					jointOrgList.add(jointOrg);
					jointOrgMap.put(key,jointOrgList);
				}else{
					jointOrgMap.get(key).add(jointOrg);
				}
			}
			model.addAttribute("jointOrgMap",jointOrgMap);
		}
		
		return "/res/college/hospitalList";
	}
	
	/**
	 * TODO 医院详情
	 * */
	@RequestMapping(value="/hospitalDetail",method=RequestMethod.GET)
	public String hospitalDetail(Model model){
		
		return "/res/college/hosInfo";
	}
	
	/**
	 * TODO 医院详情
	 * */
	@RequestMapping(value="/internList",method=RequestMethod.GET)
	public String internList(Model model){
		
		return "/res/college/internList";
	}
	
	/**
	 * TODO 学院信息列表
	 * */
	@RequestMapping(value="/userInfoList",method={RequestMethod.GET,RequestMethod.POST})
	public String internList(ResDoctorExt doctor,Integer currentPage,HttpServletRequest request,Model model){
		if(doctor!=null && StringUtil.isNotBlank(doctor.getDoctorCategoryId())){
			if(currentPage==null){
				currentPage=1;
			}
			PageHelper.startPage(currentPage,getPageSize(request));
			
			//doctor.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<ResDoctorExt> doctorList = doctorBiz.searchDocUser(doctor);
			model.addAttribute("doctorList",doctorList);
		}
		return "/res/college/userInfoList";
	}
	
	/**
	 * TODO 学院计划分配信息
	 * */
	@RequestMapping(value="/trainPlan",method={RequestMethod.GET,RequestMethod.POST})
	public String trainPlan(ResDoctor doctor,Model model){
		if(doctor!=null){
			if(StringUtil.isNotBlank(doctor.getDoctorCategoryId())){
				Map<String,Object> countMap = new HashMap<String, Object>();
				List<Map<String,Object>> planCountMap = doctorBiz.searchTrainPlanCount(doctor,GlobalConstant.FLAG_Y);
				if(planCountMap!=null && planCountMap.size()>0){
					for(Map<String,Object> map : planCountMap){
						countMap.put(map.get("key")+"plan",map.get("value"));
					}
				}
				List<Map<String,Object>> notPlanCountMap = doctorBiz.searchTrainPlanCount(doctor,GlobalConstant.FLAG_N);
				if(notPlanCountMap!=null && notPlanCountMap.size()>0){
					for(Map<String,Object> map : notPlanCountMap){
						countMap.put(map.get("key")+"notPlan",map.get("value"));
					}
				}
				model.addAttribute("countMap",countMap);
				
				String sessionNumber = null;
				String doctorCategoryId = null;
				if(doctor!=null){
					sessionNumber = doctor.getSessionNumber();
					doctorCategoryId = doctor.getDoctorCategoryId();
				}
				List<SchRotation> rotationList =  schRotationtBiz.searchSchRotationForPlatform(doctorCategoryId);
				if(rotationList!=null && rotationList.size()>0){
					Map<String,List<SchRotation>> rotationMap = new HashMap<String, List<SchRotation>>();
					for(SchRotation rotation : rotationList){
						if(rotationMap.get(rotation.getSpeId())==null){
							List<SchRotation> rotationTempList = new ArrayList<SchRotation>();
							rotationTempList.add(rotation);
							rotationMap.put(rotation.getSpeId(),rotationTempList);
						}else{
							rotationMap.get(rotation.getSpeId()).add(rotation);
						}
					}
					model.addAttribute("rotationMap",rotationMap);
				}
				
				List<Map<String,String>> selRotationMapList = doctorBiz.searGroupRotation(doctor);
				if(selRotationMapList!=null && selRotationMapList.size()>0){
					Map<String,Map<String,String>> selRotationMap = new HashMap<String, Map<String,String>>();
					for(Map<String,String> map : selRotationMapList){
						Map<String,String> rotationTempMap = new HashMap<String, String>();
						rotationTempMap.put("name",map.get("name"));
						rotationTempMap.put("flow",map.get("flow"));
						selRotationMap.put(map.get("key"),rotationTempMap);
					}
					model.addAttribute("selRotationMap",selRotationMap);
				}
			}
		}
		return "/res/college/trainPlan";
	}
	
	/**
	 * TODO 学员计划分配
	 * */
	@RequestMapping(value="/allotRotation",method={RequestMethod.POST})
	@ResponseBody
	public String allotRotation(ResDoctor doctor,Model model){
		if(doctor!=null){
			if(doctorBiz.modifyResDoctorRotation(doctor)!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * TODO 通知公告
	 * */
	@RequestMapping(value="/notice/{roleFlag}",method={RequestMethod.POST,RequestMethod.GET})
	public String notice(@PathVariable String roleFlag,Integer currentPage ,HttpServletRequest request, Model model){
		model.addAttribute("roleFlag", roleFlag);
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		List<InxInfo> infos = null;
		//searchInfoByOrgBeforeDate扩展
		if(GlobalConstant.USER_LIST_CHARGE.equals(roleFlag)){
			infos = this.noticeBiz.searchInfoByOrgBeforeDate(null,null);
		}else{
			SysUser user = GlobalContext.getCurrentUser();
			String userOrgFlow= user.getOrgFlow();
			infos = this.noticeBiz.searchInfoByOrgBeforeDate(userOrgFlow,null);
		}
		
		model.addAttribute("infos",infos);
		return "/res/notice/notice";
	}	
	
	@ResponseBody
	@RequestMapping("/saveNotice/{roleFlag}")
	public String saveNotice(@PathVariable String roleFlag,InxInfo info){
		if(StringUtil.isNotBlank(info.getColumnId())){
			info.setColumnName(DictTypeEnum.InfoColumn.getDictNameById(info.getColumnId()));
		}
		if(!GlobalConstant.USER_LIST_CHARGE.equals(roleFlag)){
			SysUser user = GlobalContext.getCurrentUser();
			String userOrgFlow= user.getOrgFlow();
			String userOrgName=user.getOrgName();
			info.setOrgFlow(userOrgFlow);
			info.setOrgName(userOrgName);
		}
		noticeBiz.editInfo(info);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	@RequestMapping("/findNoticeByFlow")
	@ResponseBody
	public Object findNoticeByFlow(String infoFlow){
		return this.noticeBiz.findNoticByFlow(infoFlow);
	}
	
	@RequestMapping(value="/noticeView")
	public String message(Model model,String infoFlow) throws Exception{
		model.addAttribute("msg", noticeBiz.findNoticByFlow(infoFlow));
		return "/res/notice/message";
	}
	
	@ResponseBody
	@RequestMapping("/delNotice")
	public String delNotice(String infoFlow){
		this.noticeBiz.delNotice(infoFlow);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	/**
	 * TODO 用户编辑
	 */
	@RequestMapping(value={"/editDocSimple"},method={RequestMethod.GET})
	public String editDocSimple(String doctorFlow,Model model){
		model.addAttribute("roleFlag",GlobalConstant.USER_LIST_GLOBAL);
		model.addAttribute("doctorFlow",doctorFlow);
		
		return "redirect:/res/manager/editDocSimple";
	}
	
	
	@RequestMapping(value={"/doctorStatistics"},method={RequestMethod.GET,RequestMethod.POST})
	public String doctorStatistics(String orgName,String sessionNumber,String speId,Model model){
		SysOrg org = new SysOrg();
		org.setOrgTypeId(OrgTypeEnum.Hospital.getId());
		org.setOrgName(orgName);
		List<SysOrg> orgList = orgBiz.searchOrderBy(org);
		if(orgList!=null && orgList.size()>0){
			model.addAttribute("orgList",orgList);
			
			List<String> orgFlows = new ArrayList<String>();
			for(SysOrg orgTemp : orgList){
				orgFlows.add(orgTemp.getOrgFlow());
			}
			
			ResDoctor doctor = new ResDoctor();
			doctor.setSessionNumber(sessionNumber);
			doctor.setTrainingSpeId(speId);
			
			List<Map<String,Object>> countResultMapList = doctorBiz.countDocByOrg(orgFlows,doctor);
			Map<String,Object> allCountMap = parseCountMapList(countResultMapList);
			model.addAttribute("allCountMap",allCountMap);
			
			doctor.setDoctorStatusId(ResDoctorStatusEnum.Training.getId());
			List<Map<String,Object>> countTrainingResultMapList = doctorBiz.countDocByOrg(orgFlows,doctor);
			Map<String,Object> countTrainingResultMap = parseCountMapList(countTrainingResultMapList);
			model.addAttribute("countTrainingResultMap",countTrainingResultMap);
			
			doctor.setDoctorStatusId(ResDoctorStatusEnum.Graduation.getId());
			List<Map<String,Object>> countGraduationResultMapList = doctorBiz.countDocByOrg(orgFlows,doctor);
			Map<String,Object> countGraduationResultMap = parseCountMapList(countGraduationResultMapList);
			model.addAttribute("countGraduationResultMap",countGraduationResultMap);
		}
		return "/res/college/doctorStatistics";
	}
	
	private Map<String,Object> parseCountMapList(List<Map<String,Object>> countResultMapList){
		Map<String,Object> countResultMap = null;
		if(countResultMapList!=null && countResultMapList.size()>0){
			countResultMap = new HashMap<String, Object>();
			for(Map<String,Object> map : countResultMapList){
				countResultMap.put((String)map.get("key"),map.get("value"));
			}
		}
		return countResultMap;
	}
	
	/**
	 * TODO 学员分配
	 */
	@RequestMapping(value={"/doctorAllot"})
	public String doctorAllot(Model model,Integer currentPage,SysOrg sysOrg,HttpServletRequest request){
		SysUser user = GlobalContext.getCurrentUser();//当前用户
		String orgFlow = user.getOrgFlow();
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		List<SysOrg> sysOrgList=orgBiz.searchByOrgNotSelf(orgFlow,sysOrg);
		model.addAttribute("sysOrgList", sysOrgList);
		List<SysDept> deptList=deptBiz.searchDeptByOrg(orgFlow);
		model.addAttribute("deptList", deptList);
		return "/res/college/doctorAllot";
	}
	
	/**
	 * 变更报表
	 * @param orgHistory
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/turnSearch"},method={RequestMethod.GET,RequestMethod.POST})
	public String turnSearch(ResDoctorOrgHistory orgHistory,Model model){
		orgHistory.setChangeStatusId(SchStatusEnum.AuditY.getId());
		List<ResDoctorOrgHistory> orgHistoryList = orgHistoryBiz.searchIsInDocByDocOrgHis(orgHistory);
		if(orgHistoryList!=null && orgHistoryList.size()>0){
			model.addAttribute("orgHistoryList",orgHistoryList);
			List<String> userFlows = new ArrayList<String>();
			for(ResDoctorOrgHistory history : orgHistoryList){
				String userFlow = history.getDoctorFlow();
				if(!userFlows.contains(userFlow)){
					userFlows.add(userFlow);
				}
			}
			
			List<SysUser> userList = userBiz.searchSysUserByuserFlows(userFlows);
			if(userList!=null && userList.size()>0){
				Map<String,SysUser> userMap = new HashMap<String, SysUser>();
				for(SysUser user : userList){
					userMap.put(user.getUserFlow(),user);
				}
				model.addAttribute("userMap",userMap);
			}
			
			List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
			if(doctorList!=null && doctorList.size()>0){
				Map<String,ResDoctor> doctorMap = new HashMap<String, ResDoctor>();
				for(ResDoctor doctor : doctorList){
					doctorMap.put(doctor.getDoctorFlow(),doctor);
				}
				model.addAttribute("doctorMap",doctorMap);
			}
		}
		return "/res/college/turnSearch";
	}
	
	
	@RequestMapping(value={"/absenceAudit"},method={RequestMethod.GET,RequestMethod.POST})
	public String absenceAudit(SchDoctorAbsence absence,Integer currentPage,HttpServletRequest request,Model model){
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		
		List<SchDoctorAbsence> absenceList = absenceBiz.searchSchDoctorAbsenceList(absence);
		model.addAttribute("absenceList",absenceList);
		return "/res/college/absenceAudit";
	}
	
	/**
	 * ResDoctor和sysUser(扩展在ResDoctorExt)查询
	 * @param model
	 * @param resDoctorExt
	 * @param currentPage
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/stuManaList/{roleFlag}")
	public String stuManaList(@PathVariable String roleFlag,Model model,ResDoctorExt resDoctorExt,Integer currentPage,HttpServletRequest request){
		model.addAttribute("roleFlag", roleFlag);
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,getPageSize(request));
		List<ResDoctorExt> resDocExtList=null;
		if(GlobalConstant.USER_LIST_CHARGE.equals(roleFlag)){
			resDocExtList=doctorBiz.searchDocUser(resDoctorExt);
		}else{
			SysUser user = GlobalContext.getCurrentUser();
			String userOrgFlow= user.getOrgFlow();
			resDoctorExt.setOrgFlow(userOrgFlow);
			resDocExtList=doctorBiz.searchDocUser(resDoctorExt);
		}
		model.addAttribute("resDocExtList", resDocExtList);
		return "/res/college/stuManaList";
	} 
	/**
	 * jointRead页面保存
	 * @param orgFlow
	 * @param jointOrgFlows
	 * @param delJointFlows
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public String save(String orgFlow,String[] jointOrgFlows,String[] delJointFlows){
		List<ResJointOrg> jointOrgList = new ArrayList<ResJointOrg>();
		//勾上复选框保存
		if(jointOrgFlows!=null && jointOrgFlows.length>0){
			List<String> orgFlows = new ArrayList<String>();
			orgFlows.add(orgFlow);
			List<String> jointOrgFlowList = Arrays.asList(jointOrgFlows);
			orgFlows.addAll(jointOrgFlowList);
			List<SysOrg> orgList=orgBiz.searchOrgFlowIn(orgFlows);
			if(orgList!=null && orgList.size()>0){
				Map<String,SysOrg> orgMap = new HashMap<String,SysOrg>();
				for(SysOrg org : orgList){
					orgMap.put(org.getOrgFlow(),org);
				}
				for(String jointOrgFlow : jointOrgFlows){
					ResJointOrg jointOrg = new ResJointOrg();
					jointOrg.setOrgFlow(orgFlow);
					jointOrg.setOrgName(orgMap.get(orgFlow).getOrgName());
					jointOrg.setJointOrgFlow(jointOrgFlow);
					jointOrg.setJointOrgName(orgMap.get(jointOrgFlow).getOrgName());
					jointOrgList.add(jointOrg);
				}
			}
		}
		//去掉复选框保存
		if(delJointFlows!=null && delJointFlows.length>0){
			for(String jointFlow : delJointFlows){
				ResJointOrg jointOrg = new ResJointOrg();
				jointOrg.setJointFlow(jointFlow);
				jointOrg.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				jointOrgList.add(jointOrg);
			}
		}
		int result=jointBiz.editJointOrgList(jointOrgList);
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 
	 * @param flow
	 * @param model
	 * @return
	 */
	@RequestMapping("/jointAll")
	public String jointAll(String flow,Model model){
		if(StringUtil.isNotBlank(flow)){
			SysOrg org=orgBiz.readSysOrg(flow) ;
			model.addAttribute("org", org);
			//查询
			List<SysOrg> resultList = orgBiz.searchOrgNotSelf(flow);
			model.addAttribute("resultList", resultList);
			//jointRead页面checkbox框保存之后默认选中
			List<ResJointOrg> jointList=jointBiz.searchResJointByOrgFlow(flow);
			if(jointList!=null && jointList.size()>0){
				Map<String,ResJointOrg> jointMap = new HashMap<String, ResJointOrg>();
				for(ResJointOrg joint : jointList){
					jointMap.put(joint.getJointOrgFlow(),joint);
				}
				model.addAttribute("jointMap",jointMap);
			}
		}
		return "/res/college/jointRead";
	}
}