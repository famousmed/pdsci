package com.pinde.sci.ctrl.sch;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.sch.ISchArrangeResultBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDeptRelBiz;
import com.pinde.sci.biz.sch.ISchDoctorAbsenceBiz;
import com.pinde.sci.biz.sch.ISchDoctorBiz;
import com.pinde.sci.biz.sch.ISchDoctorDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.sch.ISchRotationDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationGroupBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.DateTrans;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.RecDocCategoryEnum;
import com.pinde.sci.enums.res.RegistryTypeEnum;
import com.pinde.sci.enums.res.ResDoctorStatusEnum;
import com.pinde.sci.enums.res.ResRecTypeEnum;
import com.pinde.sci.enums.sch.SchRotationMedicineType;
import com.pinde.sci.enums.sch.SchStatusEnum;
import com.pinde.sci.enums.sch.SchUnitEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.sch.DoctorSearchForm;
import com.pinde.sci.form.sch.SchArrangeResultForm;
import com.pinde.sci.form.sch.SchRotationDeptForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDeptRel;
import com.pinde.sci.model.mo.SchDoctorAbsence;
import com.pinde.sci.model.mo.SchDoctorDept;
import com.pinde.sci.model.mo.SchRotation;
import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationDeptReq;
import com.pinde.sci.model.mo.SchRotationGroup;
import com.pinde.sci.model.mo.SysCfg;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/sch")
public class SchDocController extends GeneralController{   
	
	private static Logger logger = LoggerFactory.getLogger(SchDocController.class);
	
	@Resource
	private ISchDoctorBiz schDoctortBiz;
	@Resource
	private ISchRotationBiz schRotationtBiz;
	@Resource
	private ISchRotationDeptBiz schRotationDeptBiz;
	@Resource
	private ISchRotationGroupBiz schRotationtGroupBiz;
	@Resource
	private ISchDeptBiz schDeptBiz;
	@Resource
	private IDeptBiz sysDeptBiz;
	@Resource
	private ISchDoctorDeptBiz schDoctorDeptBiz;
	@Resource
	private ISchArrangeResultBiz schArrangeResultBiz;
	@Resource
	private ISchDoctorAbsenceBiz schDoctorAbsenceBiz;
	@Resource
	private IUserBiz userBiz;
	@Resource
	private IDictBiz dictBiz;
	@Resource
	private ISchDeptRelBiz deptRelBiz;
	@Resource
	private IResDoctorBiz doctorBiz;
	@Resource
	private IResDoctorProcessBiz processBiz;
	@Resource
	private IOrgBiz orgBiz;
	
	/**
	 * 医师信息列表
	 * */
	@RequestMapping(value = {"/doc/userInfo/list" },method = RequestMethod.GET)
	public String doctorList (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
		List<ResDoctor> doctorList = schDoctortBiz.searchResDoctorAll(GlobalContext.getCurrentUser().getOrgFlow(),doctorSearchForm);
		model.addAttribute("doctorList",doctorList);
		return "sch/doc/userInfo/list";
	}
	
	/**
	 * 医师信息查询  
	 * */
	@RequestMapping(value = {"/doc/userInfo/searchList" }, method = RequestMethod.POST)
	public String searchList (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
		return doctorList(doctorSearchForm,model);
	}
	
	/**
	 * 医师信息编辑
	 * */
	@RequestMapping(value = {"/doc/userInfo/editDoc" }, method = RequestMethod.GET)
	public String editDoc (ResDoctor doctor,Model model) throws Exception{
		if(doctor != null && StringUtil.isNotBlank(doctor.getDoctorFlow())){
			doctor = schDoctortBiz.readResDoctor(doctor.getDoctorFlow());
		}
		model.addAttribute("schDoctor",doctor);
		
		List<SchRotation> rotationList = schRotationtBiz.searchSchRotation();
		model.addAttribute("rotationList",rotationList);
		
		return "sch/doc/userInfo/editDoc";
	}
	
	@RequestMapping(value = "/doc/userInfo/saveDoctor",method={RequestMethod.POST})
	@ResponseBody
	public String saveDoctor(ResDoctor doctor, Model model) throws Exception{
		 if(null != doctor){
			 doctor.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			 doctor.setOrgName(GlobalContext.getCurrentUser().getOrgName());
//			 doctor.setSexName(UserSexEnum.getNameById(doctor.getSexId()));
			 doctor.setGraduatedName(DictTypeEnum.GraduateSchool.getDictNameById(doctor.getGraduatedId()));//DoctorGraduated
//			 doctor.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(doctor.getDegreeId()));
//			 doctor.setEducationName(DictTypeEnum.UserEducation.getDictNameById(doctor.getEducationId()));
			 doctor.setTrainingSpeName(DictTypeEnum.DoctorTrainingSpe.getDictNameById(doctor.getTrainingSpeId()));
			 SchRotation rotation = schRotationtBiz.readSchRotation(doctor.getRotationFlow());
			 if(rotation!=null){
				 doctor.setRotationName(rotation.getRotationName());
			 }
			 doctor.setDoctorStatusName(ResDoctorStatusEnum.getNameById(doctor.getDoctorStatusId()));
			 if(!StringUtil.isNotBlank(doctor.getRecordStatus())){
				 doctor.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			 }
			 int result = schDoctortBiz.saveResDoctor(doctor);
			 if(result != GlobalConstant.ZERO_LINE){
				 return GlobalConstant.SAVE_SUCCESSED;
			 }
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * TODO 轮转方案配置
	 * */
	@RequestMapping(value="/template/gToLocalList",method=RequestMethod.GET)
	public String gToLocalList(String orgFlow,Model model){
		if(StringUtil.isNotBlank(orgFlow)){
			List<SchRotation> updateList = getPlatformRotation(orgFlow);
			model.addAttribute("updateCount",updateList.size());
			return "redirect:/sch/template/gToLocalListInfo";
		}
		
		model.addAttribute("currRoleFlag",GlobalConstant.USER_LIST_GLOBAL);
		
		return "redirect:/sch/template/localList";
	}
	
	@RequestMapping(value="/template/gToLocalListInfo",method=RequestMethod.GET)
	@ResponseBody
	public String gToLocalListInfo(Integer updateCount){
		return "更新"+updateCount+"条方案！";
	}
	
	@RequestMapping(value="/template/localList",method=RequestMethod.GET)
	public String localList(String orgFlow,String currRoleFlag,Model model){
		model.addAttribute("currRoleFlag",currRoleFlag);
		model.addAttribute("roleFlag",GlobalConstant.USER_LIST_LOCAL);
		model.addAttribute("publishFlag",GlobalConstant.FLAG_Y);
		
		orgFlow = StringUtil.defaultIfEmpty(orgFlow,GlobalContext.getCurrentUser().getOrgFlow());
		model.addAttribute("orgFlow",orgFlow);
		
		List<SchRotation> updateList = getPlatformRotation(orgFlow);
		if(updateList!=null){
			model.addAttribute("updateCount",updateList.size());
		}
		return "redirect:/sch/template/list";
	}
	
	@RequestMapping(value = {"/template/list" },method = RequestMethod.GET)
	public String rotationList (String roleFlag,SchRotation rotation,Integer updateCount,String currRoleFlag,Model model){
		model.addAttribute("updateCount",updateCount);
		
		List<SchRotation> rotationList = schRotationtBiz.searchOrgStandardRotation(rotation);
		model.addAttribute("rotationList",rotationList);
		
		//配置表单使用
		if(GlobalConstant.ROOT_USER_FLOW.equals(GlobalContext.getCurrentUser().getUserFlow())){
			String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
			SysCfg cfg=new SysCfg();
			cfg.setWsId(wsId);
			List<SysCfg> sysCfgList=cfgBiz.search(cfg);
			Map<String, String> sysCfgMap=new HashMap<String, String>();
			for(SysCfg sysCfg:sysCfgList ){
				sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgValue());
				if(StringUtil.isNotBlank(sysCfg.getCfgBigValue())){
					sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgBigValue());				
				}
			}
			model.addAttribute("sysCfgMap",sysCfgMap);
		}
		return "sch/template/list";
	}
	
	/**
	 * 本地标准方案配置
	 */
	@RequestMapping(value = {"/template/orgDiyRotationList" },method = RequestMethod.GET)
	public String orgDiyRotationList (SchRotation rotation,Model model){
		model.addAttribute("schRotation",rotation);
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
//		rotation.setOrgFlow(orgFlow);
//		rotation.setRotationTypeId(SchRotationTypeEnum.Standard.getId());
//		if(rotation.getSessionNumber()==null){
//			rotation.setSessionNumber(DateUtil.getYear());
//		}
		List<SchRotation> rotationList = schRotationtBiz.searchOrgStandardRotation(rotation);
		model.addAttribute("rotationList",rotationList);
		
		//配置表单使用
		if(GlobalConstant.ROOT_USER_FLOW.equals(GlobalContext.getCurrentUser().getUserFlow())){
			String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
			SysCfg cfg=new SysCfg();
			cfg.setWsId(wsId);
			List<SysCfg> sysCfgList=cfgBiz.search(cfg);
			Map<String, String> sysCfgMap=new HashMap<String, String>();
			for(SysCfg sysCfg:sysCfgList ){
				sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgValue());
				if(StringUtil.isNotBlank(sysCfg.getCfgBigValue())){
					sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgBigValue());				
				}
			}
			model.addAttribute("sysCfgMap",sysCfgMap);
		}
		return "sch/template/orgDiyRotationList";
	}
	
	/**
	 * TODO 自动同步平台方案
	 * */
	private List<SchRotation> getPlatformRotation(String orgFlow){
		List<SchRotation> rotationList = schRotationtBiz.searchNotExistRotation(orgFlow);
		if(rotationList!=null && rotationList.size()>0){
			schRotationtBiz.saveLocalRotation(rotationList,orgFlow);
		}
		return rotationList;
	}
	
	/**
	 * 跳转至方案编辑页面
	 * */
	@RequestMapping(value = {"/template/editRotation"}, method = RequestMethod.GET)
	public String editRotation (String rotationFlow, String viewFlag, Model model){
		SchRotation rotation = null;
		if(StringUtil.isNotBlank(rotationFlow)){
			rotation = schRotationtBiz.readSchRotation(rotationFlow);
		}
		model.addAttribute("rotation",rotation);
		if(GlobalConstant.FLAG_Y.equals(viewFlag)){
			return "sch/template/viewRotation";
		}
		return "sch/template/editRotation";
	}
	
	@RequestMapping(value = "/template/saveRotation",method={RequestMethod.POST})
	@ResponseBody
	public String saveRotation(SchRotation rotation, Model model) throws Exception{
		 if(null != rotation){
			 if(StringUtil.isNotBlank(rotation.getSpeId())){
				 rotation.setSpeName(DictTypeEnum.DoctorTrainingSpe.getDictNameById(rotation.getSpeId()));
			 }else{
				 rotation.setSpeName("");
			 }
			 
			 if(StringUtil.isNotBlank(rotation.getDoctorCategoryId())){
				 rotation.setDoctorCategoryName(RecDocCategoryEnum.getNameById(rotation.getDoctorCategoryId()));
			 }else{
				 rotation.setDoctorCategoryName("");
			 }
			 
			 if(StringUtil.isNotBlank(rotation.getRotationTypeId())){
				 rotation.setRotationTypeName(SchRotationMedicineType.getNameById(rotation.getRotationTypeId()));
			 }else{
				 rotation.setRotationTypeName("");
			 }
			 
//			 if(StringUtil.isNotBlank(rotation.getRotationTypeId())){
//				 rotation.setRotationTypeName(SchRotationTypeEnum.getNameById(rotation.getRotationTypeId()));
//			 }else{
//				 rotation.setRotationTypeName("");
//			 }
			 
			 if(StringUtil.isNotBlank(rotation.getRotationFlow()) && StringUtil.isNotBlank(rotation.getRotationName())){
				 SchRotation oldRotation = schRotationtBiz.readSchRotation(rotation.getRotationFlow());
				 if(oldRotation!=null){
					 if(!oldRotation.getRotationName().equals(rotation.getRotationName())){
							ResDoctor doctor = new ResDoctor();
							doctor.setRotationFlow(rotation.getRotationFlow());
							doctor.setRotationName(rotation.getRotationName());
							doctorBiz.updateRedundancyData(doctor);
						}
				 }
			 }
			 
			 int result = schRotationtBiz.saveSchRotation(rotation);
			 if(result != GlobalConstant.ZERO_LINE){
				 return GlobalConstant.SAVE_SUCCESSED;
			 }
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value = "/template/publishRotation",method={RequestMethod.POST})
	@ResponseBody
	public String publishRotation(SchRotation rotation, Model model) throws Exception{
		 if(null != rotation){
			 int result = schRotationtBiz.saveSchRotation(rotation);
			 if(result != GlobalConstant.ZERO_LINE){
				 return GlobalConstant.SAVE_SUCCESSED;
			 }
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 轮转规则配置
	 * */
	@RequestMapping(value = {"/template/rule"},method = RequestMethod.GET)
	public String rule (String roleFlag,String rotationFlow,String orgFlow,String currRoleFlag,Model model){
		if(StringUtil.isNotBlank(orgFlow) && StringUtil.isNotBlank(currRoleFlag)){
			getPlatformRotation(orgFlow);
		}
		
		if(StringUtil.isNotBlank(rotationFlow)){
			SchRotation rotation = schRotationtBiz.readSchRotation(rotationFlow);
			model.addAttribute("rotation",rotation);
			
			List<SchRotationDept> standardRotationDeptList = schRotationDeptBiz.searchSchRotationDept(rotationFlow);
			if(standardRotationDeptList!=null && standardRotationDeptList.size()>0){
				model.addAttribute("standardRotationDeptList",standardRotationDeptList);
				
				Map<String,List<SchRotationDept>> standardGroupDeptMap = new HashMap<String, List<SchRotationDept>>();
				for(SchRotationDept rotationDept : standardRotationDeptList){
					String key = rotationDept.getGroupFlow();
					if(standardGroupDeptMap.get(key)==null){
						List<SchRotationDept> standardRotationDeptTempList = new ArrayList<SchRotationDept>(); 
						standardRotationDeptTempList.add(rotationDept);
						standardGroupDeptMap.put(key,standardRotationDeptTempList);
					}else{
						standardGroupDeptMap.get(key).add(rotationDept);
					}
				}
				model.addAttribute("standardGroupDeptMap",standardGroupDeptMap);
			}
			
			
			List<SchRotationGroup> standardRotationGroupList = schRotationtGroupBiz.searchSchRotationGroup(rotationFlow);
			model.addAttribute("standardRotationGroupList",standardRotationGroupList);
			
			if(!GlobalConstant.USER_LIST_GLOBAL.equals(roleFlag)){
				orgFlow = StringUtil.defaultIfEmpty(orgFlow,GlobalContext.getCurrentUser().getOrgFlow());
				
				List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchOrgSchRotationDept(rotationFlow,orgFlow);
				if(rotationDeptList!=null && rotationDeptList.size()>0){
					Map<String,List<SchRotationDept>> localRotationDeptListMap = new HashMap<String, List<SchRotationDept>>();
					for(SchRotationDept rotationDept : rotationDeptList){
						String key = rotationDept.getGroupFlow()+rotationDept.getStandardDeptId();
						if(localRotationDeptListMap.get(key)==null){
							List<SchRotationDept> rotationDeptListTemp = new ArrayList<SchRotationDept>();
							rotationDeptListTemp.add(rotationDept);
							localRotationDeptListMap.put(key,rotationDeptListTemp);
						}else{
							localRotationDeptListMap.get(key).add(rotationDept);
						}
					}
					model.addAttribute("localRotationDeptListMap",localRotationDeptListMap);
				}
				
				List<SchRotationGroup> rotationGroupList = schRotationtGroupBiz.searchOrgGroupOrAll(rotationFlow,orgFlow,null);
				if(rotationGroupList!=null && rotationGroupList.size()>0){
					model.addAttribute("rotationGroupList",rotationGroupList);
					
					Map<String,SchRotationGroup> localGroupMap = new HashMap<String, SchRotationGroup>();
					for(SchRotationGroup group : rotationGroupList){
						localGroupMap.put(group.getStandardGroupFlow(),group);
					}
					model.addAttribute("localGroupMap",localGroupMap);
				}
				
				//关联关系
				List<SchDeptRel> deptRelList = deptRelBiz.searchRelByOrg(orgFlow);
				if(deptRelList!=null && deptRelList.size()>0){
					Map<String,Map<String,SchDeptRel>> deptRelMap = new HashMap<String,Map<String,SchDeptRel>>();
					for(SchDeptRel deptRel : deptRelList){
						String key = deptRel.getStandardDeptId();
						if(deptRelMap.get(key)==null){
							Map<String,SchDeptRel> deptRelTempMap = new HashMap<String, SchDeptRel>();
							deptRelTempMap.put(deptRel.getSchDeptFlow(),deptRel);
							deptRelMap.put(key,deptRelTempMap);
						}else{
							deptRelMap.get(key).put(deptRel.getSchDeptFlow(),deptRel);
						}
					}
					model.addAttribute("deptRelMap",deptRelMap);
				}
				
				List<SysDept> sysDeptList = sysDeptBiz.searchDeptByOrg(orgFlow);
				if(sysDeptList!=null && sysDeptList.size()>0){
					List<String> deptFlows = new ArrayList<String>();
					for(SysDept dept : sysDeptList){
						deptFlows.add(dept.getDeptFlow());
					}
					List<SchDept> deptList = schDeptBiz.searchDeptByDeotFlows(deptFlows);
					model.addAttribute("deptList",deptList);
				}
			}else{
				int selNum = schDoctorDeptBiz.countRotationUse(rotationFlow);
				int rosteringNum = schArrangeResultBiz.countRotationUse(rotationFlow);
				model.addAttribute("useCount",selNum+rosteringNum);
			}
		}
		return "sch/template/rule";
	}
	
	/**
	 * TODO 关联的轮转科室
	 * */
	@RequestMapping(value = {"/template/relSchDept"},method = RequestMethod.POST)
	@ResponseBody
	public List<SchDeptRel> relSchDept(String standardDeptId,String orgFlow){
		orgFlow = StringUtil.defaultIfEmpty(orgFlow,GlobalContext.getCurrentUser().getOrgFlow());
		List<SchDeptRel> deptRelList = null;
		if(StringUtil.isNotBlank(standardDeptId)){
			deptRelList = deptRelBiz.searchRelByStandard(orgFlow, standardDeptId);
		}
		return deptRelList;
	}
	
	/**
	 * TODO 更新当前操作区域下的映射科室
	 * */
	@RequestMapping(value = "/template/reUpdateRotationDept",method={RequestMethod.POST})
	public String reUpdateRotationDept(String rotationFlow,String standardDeptId,String groupFlow,String orgFlow,Model model){
		orgFlow = StringUtil.defaultIfEmpty(orgFlow,GlobalContext.getCurrentUser().getOrgFlow());
		SysOrg org = orgBiz.readSysOrg(orgFlow);
		int result = schRotationDeptBiz.updateAreaRule(rotationFlow,standardDeptId,groupFlow,org);
		if(result!=GlobalConstant.ZERO_LINE){
			List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchDeptByStandard(rotationFlow,groupFlow,standardDeptId,orgFlow);
			model.addAttribute("rotationDeptList",rotationDeptList);
			
			List<SchDeptRel> deptRelList = deptRelBiz.searchRelByStandard(orgFlow,standardDeptId);
			model.addAttribute("deptRelList",deptRelList);
			
			SchRotationDept standardRotationDept =  schRotationDeptBiz.readStandardRotationDeptByLocal(rotationFlow,groupFlow,standardDeptId);
			model.addAttribute("standardRotationDept",standardRotationDept);
		}
		return "sch/template/ruleCfg";
	}
	
	/**
	 * TODO 微调轮转科室
	 * */
	@RequestMapping(value = {"/template/saveCfg"},method = RequestMethod.POST)
	@ResponseBody
	public String saveCfg(@RequestBody List<SchRotationDept> rotationDeptList,String groupFlow,Integer deptNum,Integer maxDeptNum,String orgFlow){
		orgFlow = StringUtil.defaultIfEmpty(orgFlow,GlobalContext.getCurrentUser().getOrgFlow());
		
		if(rotationDeptList!=null){
			for(SchRotationDept rotationDept : rotationDeptList){
				String standardDeptId = rotationDept.getStandardDeptId();
				String schDeptFlow = rotationDept.getSchDeptFlow();
				if(StringUtil.isNotBlank(standardDeptId)){
					rotationDept.setStandardDeptName(DictTypeEnum.StandardDept.getDictNameById(standardDeptId));
				}
				if(StringUtil.isNotBlank(schDeptFlow)){
					SchDept dept = schDeptBiz.readSchDept(schDeptFlow);
					rotationDept.setSchDeptName(dept.getSchDeptName());
					rotationDept.setDeptFlow(dept.getDeptFlow());
					rotationDept.setDeptName(dept.getDeptName());
				}
				
				if(StringUtil.isNotBlank(orgFlow)){
					SysOrg org = orgBiz.readSysOrg(orgFlow);
					if(org!=null){
						rotationDept.setOrgFlow(org.getOrgFlow());
						rotationDept.setOrgName(org.getOrgName());
					}
				}
			}
			
			SchRotationGroup group = null;
			if(StringUtil.isNotBlank(groupFlow)){
				group = new SchRotationGroup();
				group.setGroupFlow(groupFlow);
				group.setDeptNum(deptNum);
				if(maxDeptNum!=null && maxDeptNum!=0){
					group.setMaxDeptNum(maxDeptNum);
				}
			}
			schRotationDeptBiz.saveRotationDeptList(rotationDeptList,group);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * TODO 轮转规范
	 * */
	@RequestMapping(value = {"/template/rotationStandard"},method = RequestMethod.GET)
	public String rotationStandard(String recordFlow,Model model){
		SchRotationDept rotationDept = schRotationDeptBiz.readSchRotationDept(recordFlow);
		model.addAttribute("rotationDept",rotationDept);
		return "sch/template/rotationStandard";
	}
	
	@RequestMapping(value = {"/template/saveStandard"},method = RequestMethod.POST)
	@ResponseBody
	public String saveStandard(SchRotationDept rotationDept){
		if(rotationDept!=null){
			if(schRotationDeptBiz.saveSchRotationDept(rotationDept)!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * TODO 轮转要求
	 * */
	@RequestMapping(value = {"/template/rotationRequire"},method = RequestMethod.GET)
	public String rotationRequire(String recordFlow,String rotationFlow,Model model){
		SchRotation rotation = schRotationtBiz.readSchRotation(rotationFlow);
		model.addAttribute("rotation",rotation);
		
		List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchSchRotationDept(rotationFlow);
		model.addAttribute("rotationDeptList",rotationDeptList);
		
		SchRotationDept rotationDept = schRotationDeptBiz.readSchRotationDept(recordFlow);
		model.addAttribute("rotationDept",rotationDept);
		
		List<SchRotationGroup> groupList = schRotationtGroupBiz.searchSchRotationGroup(rotationFlow);
		if(groupList!=null && groupList.size()>0){
			Map<String,SchRotationGroup> groupMap = new HashMap<String, SchRotationGroup>();
			for(SchRotationGroup group : groupList){
				groupMap.put(group.getGroupFlow(),group);
			}
			model.addAttribute("groupMap",groupMap);
		}
		
		return "sch/template/rotationRequire";
	}
	
	@RequestMapping(value = {"/template/requireList"},method = RequestMethod.GET)
	public String requireList(SchRotationDeptReq deptReq,Model model){
		if(deptReq !=null){
			//默认添加其他项
			schRotationDeptBiz.defaultOtherItem(deptReq.getRelRecordFlow(),deptReq.getRecTypeId());
			
			List<SchRotationDeptReq> deptReqList = schRotationDeptBiz.searchDeptReqByRel(deptReq.getRelRecordFlow(),deptReq.getRecTypeId());
			model.addAttribute("deptReqList",deptReqList);
		}
		return "sch/template/requireList";
	}
	
	@RequestMapping(value = {"/template/editDeptReq"},method = RequestMethod.GET)
	public String editDeptReq(String reqFlow,Model model) throws Exception{
		SchRotationDeptReq deptReq = schRotationDeptBiz.readDeptReq(reqFlow);
		model.addAttribute("deptReq",deptReq);
		return "sch/template/editRequire";
	}
	
	@RequestMapping(value = {"/template/saveDeptReq"},method = RequestMethod.POST)
	@ResponseBody
	public String saveDeptReq(SchRotationDeptReq deptReq){
		String returnStrF = GlobalConstant.SAVE_FAIL;
		String returnStrS = GlobalConstant.SAVE_SUCCESSED;
		if(deptReq!=null){
			if(StringUtil.isNotBlank(deptReq.getRecordStatus()) && GlobalConstant.RECORD_STATUS_N.equals(deptReq.getRecordStatus())){
				returnStrF = GlobalConstant.DELETE_FAIL;
				returnStrS = GlobalConstant.DELETE_SUCCESSED;
			}
			if(!StringUtil.isNotBlank(deptReq.getReqFlow())){
				SchRotationDept rotationDept = schRotationDeptBiz.readSchRotationDept(deptReq.getRelRecordFlow());
				if(rotationDept!=null){
					deptReq.setOrgFlow(rotationDept.getOrgFlow());
					deptReq.setOrgName(rotationDept.getOrgName());
					deptReq.setStandardDeptId(rotationDept.getStandardDeptId());
					deptReq.setStandardDeptName(rotationDept.getStandardDeptName());
				}
				deptReq.setItemId(PkUtil.getUUID());
			}
			
			if(StringUtil.isNotBlank(deptReq.getRecTypeId())){
				deptReq.setRecTypeName(RegistryTypeEnum.getNameById(deptReq.getRecTypeId()));
			}
			
			if(schRotationDeptBiz.editDeptReq(deptReq)!=GlobalConstant.ZERO_LINE){
				return returnStrS;
			}
		}
		return returnStrF;
	}
	
	@RequestMapping(value = {"/template/readCaseReq"},method = RequestMethod.GET)
	@ResponseBody
	public SchRotationDeptReq readCaseReq(String relRecordFlow,String recTypeId){
		SchRotationDeptReq deptReq = null;
		if(StringUtil.isNotBlank(relRecordFlow) && StringUtil.isNotBlank(recTypeId)){
			List<SchRotationDeptReq> deptReqList = schRotationDeptBiz.searchDeptReqByRel(relRecordFlow,recTypeId);
			if(deptReqList!=null && deptReqList.size()>0){
				deptReq = deptReqList.get(0);
			}
		}
		return deptReq;
	}
	
	/**
	 * 轮转规则编辑
	 * */
	@RequestMapping(value = {"/template/deptcfg_edit"}, method = RequestMethod.GET)
	public String deptCfgEdit (String groupFlow,String rotationFlow,String roleFlag,Model model) throws Exception{
		if(StringUtil.isNotBlank(rotationFlow)){
			Map<String,SchRotationDept> rotationDeptMap = new HashMap<String,SchRotationDept>();
			List<SchRotationDept> rotationDeptList = null;
			if(StringUtil.isNotBlank(groupFlow)){
				rotationDeptList = schRotationtGroupBiz.readSchRotationDept(groupFlow);
				SchRotationGroup rotationGroup = schRotationtGroupBiz.readSchRotationGroup(groupFlow);
				model.addAttribute("rotationGroup",rotationGroup);
			}else{
				//rotationDeptList = schRotationDeptBiz.searchSchRotationDeptMust(rotationFlow);
			}
			if(rotationDeptList!=null && rotationDeptList.size()>0){
				for(SchRotationDept rotationDept : rotationDeptList){
					String key = null;
					if(GlobalConstant.USER_LIST_GLOBAL.equals(roleFlag)){
						key = rotationDept.getStandardDeptId();
					}else{
						key = rotationDept.getSchDeptFlow();
					}
					rotationDeptMap.put(key,rotationDept);
				}
				model.addAttribute("rotationDeptMap",rotationDeptMap);
			}
			
			SchRotation rotation = schRotationtBiz.readSchRotation(rotationFlow);
			model.addAttribute("rotation",rotation);
		}
		
//		List<SchDept> deptList = null;
//		if(GlobalConstant.USER_LIST_GLOBAL.equals(roleFlag)){
//			List<SysDict> dictList = dictBiz.searchDictListByDictTypeId(DictTypeEnum.StandardDept.getId());
//			if(dictList!=null && dictList.size()>0){
//				deptList = new ArrayList<SchDept>();
//				for(SysDict dict : dictList){
//					SchDept dept = new SchDept();
//					dept.setSchDeptFlow(dict.getDictId());
//					dept.setSchDeptName(dict.getDictName());
//					deptList.add(dept);
//				}
//			}
//		}else{
//			deptList = schDeptBiz.searchSchDeptList(GlobalContext.getCurrentUser().getOrgFlow());
//		}
//		model.addAttribute("deptList",deptList);
		
		return "sch/template/deptcfg_edit";
	}
	
	@RequestMapping(value = "/template/saveRotationDept",method={RequestMethod.POST})
	@ResponseBody
	public String saveRotationDept(@RequestBody SchRotationDeptForm rotationDeptFrom,String roleFlag,String rotationFlow,Model model){
		if(rotationDeptFrom != null && rotationDeptFrom.getRotationDeptList()!=null && rotationDeptFrom.getRotationDeptList().size()>0){
			if(GlobalConstant.USER_LIST_GLOBAL.equals(roleFlag)){
				for(SchRotationDept rotationDept : rotationDeptFrom.getRotationDeptList()){
					rotationDept.setStandardDeptId(rotationDept.getSchDeptFlow());
					rotationDept.setStandardDeptName(rotationDept.getSchDeptName());
					rotationDept.setSchDeptFlow(null);
					rotationDept.setSchDeptName(null);
				}
			}
			int result = schRotationDeptBiz.saveSchRotationDeptForm(rotationDeptFrom,rotationFlow);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value = "/template/saveRotationDeptOrd",method={RequestMethod.POST})
	@ResponseBody
	public String saveRotationDeptOrd(String[] recordFlow, Model model) throws Exception{
		int result = schRotationDeptBiz.saveRotationDeptOrd(recordFlow);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value = "/template/delRotationDept",method={RequestMethod.POST})
	@ResponseBody
	public String delRotationDept(String recordFlow,String groupFlow,String rotationFlow){
		int result = schRotationDeptBiz.delGroupOrRotationDept(recordFlow,groupFlow,rotationFlow);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * TODO 医师选科排班
	 * */
	@RequestMapping(value = {"/doc/seldept" },method = {RequestMethod.GET,RequestMethod.POST})
	public String selDept(ResDoctor doctor,Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		if(doctor.getSessionNumber()==null){
			doctor.setSessionNumber(DateUtil.getYear());
		}
		doctor.setOrgFlow(orgFlow);
		model.addAttribute("doctor",doctor);
		List<ResDoctor> doctorList = doctorBiz.searchSelDeptDoctor(doctor);
		if(doctorList!=null && doctorList.size()>0){
			model.addAttribute("doctorList",doctorList);
			
			List<String> rotationFlows = new ArrayList<String>();
			List<String> doctorFlows = new ArrayList<String>();
			for(ResDoctor doctorTemp : doctorList){
				String rotationFlow = doctorTemp.getRotationFlow();
				String doctorFlow = doctorTemp.getDoctorFlow();
				if(!rotationFlows.contains(rotationFlow)){
					rotationFlows.add(rotationFlow);
				}
				doctorFlows.add(doctorFlow);
			}
			
			//所有组合
			List<SchRotationGroup> groupList = schRotationtGroupBiz.searchOrgGroupByRotations(rotationFlows,orgFlow);
			if(groupList!=null && groupList.size()>0){
				Map<String,List<SchRotationGroup>> groupListMap = new HashMap<String, List<SchRotationGroup>>();
				for(SchRotationGroup group : groupList){
					String key = group.getRotationFlow();
					if(groupListMap.get(key)==null){
						List<SchRotationGroup> groupListTemp = new ArrayList<SchRotationGroup>();
						groupListTemp.add(group);
						groupListMap.put(key,groupListTemp);
					}else{
						groupListMap.get(key).add(group);
					}
				}
				model.addAttribute("groupListMap",groupListMap);
			}
			
			//所有组合内科室
			List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchOrgSelDeptByRotations(rotationFlows,orgFlow);
			if(rotationDeptList!=null && rotationDeptList.size()>0){
				Map<String,List<SchRotationDept>> rotationDeptListMap = new HashMap<String, List<SchRotationDept>>();
				for(SchRotationDept rotationDept : rotationDeptList){
					String key = rotationDept.getGroupFlow();
					if(rotationDeptListMap.get(key)==null){
						List<SchRotationDept> rotationDeptListTemp = new ArrayList<SchRotationDept>();
						rotationDeptListTemp.add(rotationDept);
						rotationDeptListMap.put(key,rotationDeptListTemp);
					}else{
						rotationDeptListMap.get(key).add(rotationDept);
					}
				}
				model.addAttribute("rotationDeptListMap",rotationDeptListMap);
			}
			
			//所有已选科室
			List<SchDoctorDept> doctorDeptList = schDoctorDeptBiz.searchDoctorDeptByDoctorFlows(doctorFlows);
			if(doctorDeptList!=null && doctorDeptList.size()>0){
				Map<String,SchDoctorDept> doctorDeptMap = new HashMap<String, SchDoctorDept>();
				for(SchDoctorDept doctorDept : doctorDeptList){
					String key = doctorDept.getDoctorFlow()+doctorDept.getGroupFlow()+doctorDept.getStandardDeptId()+doctorDept.getSchDeptFlow();
					doctorDeptMap.put(key,doctorDept);
				}
				model.addAttribute("doctorDeptMap",doctorDeptMap);
			}
			
			//排班数据
			List<SchArrangeResult> resultList = schArrangeResultBiz.searchArrangeResultByDoctorFlows(doctorFlows);
			if(resultList!=null && resultList.size()>0){
				Map<String,SchArrangeResult>  resultMap = new HashMap<String, SchArrangeResult>();
				for(SchArrangeResult result : resultList){
					String key = result.getDoctorFlow();
					if(resultMap.get(key)==null){
						resultMap.put(key, result);
					}
				}
				model.addAttribute("resultMap",resultMap);
			}
			
			//所有轮转方案
			List<SchRotation> rotationList = schRotationtBiz.searchRotationByrotationFlows(rotationFlows);
			if(rotationList!=null && rotationList.size()>0){
				Map<String,SchRotation> rotationMap = new HashMap<String, SchRotation>();
				for(SchRotation sr : rotationList){
					rotationMap.put(sr.getRotationFlow(),sr);
				}
				model.addAttribute("rotationMap",rotationMap);
			}
		}
		
		return "sch/doc/seldept";
	}
	
	/**
	 * TODO 排班镶嵌选科
	 * */
	@RequestMapping(value = {"/doc/toSelDept" },method = {RequestMethod.GET,RequestMethod.POST})
	public String toSelDept(String doctorFlow,Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		if(StringUtil.isNotBlank(doctorFlow)){///sch/arrange/rosteringHandDept
			//排班数据
			List<SchArrangeResult> resultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
			if(resultList!=null && resultList.size()>0){
				model.addAttribute("doctorFlow",doctorFlow);
				return "redirect:/sch/arrange/rosteringHandDept";
//				Map<String,SchArrangeResult>  resultMap = new HashMap<String, SchArrangeResult>();
//				for(SchArrangeResult result : resultList){
//					String key = result.getDoctorFlow();
//					if(resultMap.get(key)==null){
//						resultMap.put(key, result);
//					}
//				}
//				model.addAttribute("resultMap",resultMap);
			}
			
			ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
			if(doctor!=null){
				model.addAttribute("doctor",doctor);
				
				//List<String> rotationFlows = new ArrayList<String>();
				//List<String> doctorFlows = new ArrayList<String>();
				//for(ResDoctor doctorTemp : doctorList){
					//String rotationFlow = doctorTemp.getRotationFlow();
					//String doctorFlow = doctorTemp.getDoctorFlow();
					//if(!rotationFlows.contains(rotationFlow)){
						//rotationFlows.add(rotationFlow);
					//}
					//doctorFlows.add(doctorFlow);
				//}
				
				SchRotation rotation = schRotationtBiz.readSchRotation(doctor.getRotationFlow());
				model.addAttribute("rotation",rotation);
				
				//所有组合
				List<SchRotationGroup> groupList = schRotationtGroupBiz.searchOrgGroupOrAll(doctor.getRotationFlow(),orgFlow,GlobalConstant.FLAG_N);
				if(groupList!=null && groupList.size()>0){
					Map<String,List<SchRotationGroup>> groupListMap = new HashMap<String, List<SchRotationGroup>>();
					for(SchRotationGroup group : groupList){
						String key = group.getRotationFlow();
						if(groupListMap.get(key)==null){
							List<SchRotationGroup> groupListTemp = new ArrayList<SchRotationGroup>();
							groupListTemp.add(group);
							groupListMap.put(key,groupListTemp);
						}else{
							groupListMap.get(key).add(group);
						}
					}
					model.addAttribute("groupListMap",groupListMap);
				}
				
				//所有组合内科室
				List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchOrgSchRotationDeptGroup(doctor.getRotationFlow(),orgFlow);
				if(rotationDeptList!=null && rotationDeptList.size()>0){
					Map<String,List<SchRotationDept>> rotationDeptListMap = new HashMap<String, List<SchRotationDept>>();
					for(SchRotationDept rotationDept : rotationDeptList){
						String key = rotationDept.getGroupFlow();
						if(rotationDeptListMap.get(key)==null){
							List<SchRotationDept> rotationDeptListTemp = new ArrayList<SchRotationDept>();
							rotationDeptListTemp.add(rotationDept);
							rotationDeptListMap.put(key,rotationDeptListTemp);
						}else{
							rotationDeptListMap.get(key).add(rotationDept);
						}
					}
					model.addAttribute("rotationDeptListMap",rotationDeptListMap);
				}
				
				//所有已选科室
				List<SchDoctorDept> doctorDeptList = schDoctorDeptBiz.searchSchDoctorDept(doctorFlow);
				if(doctorDeptList!=null && doctorDeptList.size()>0){
					Map<String,SchDoctorDept> doctorDeptMap = new HashMap<String, SchDoctorDept>();
					for(SchDoctorDept doctorDept : doctorDeptList){
						String key = doctorDept.getDoctorFlow()+doctorDept.getGroupFlow()+doctorDept.getStandardDeptId()+doctorDept.getSchDeptFlow();
						doctorDeptMap.put(key,doctorDept);
					}
					model.addAttribute("doctorDeptMap",doctorDeptMap);
				}
			}
		}
		
		return "sch/arrange/rosteringHandSelDept";
	}
	
	/**
	 * TODO 操作选科
	 * */
	@RequestMapping(value = "/template/operSelDept",method={RequestMethod.POST})
	@ResponseBody
	public String operSelDept(String doctorFlow,String doctorDeptFlow,String rotationDeptFlow,String recordStatus,String schMonth){
		SchDoctorDept doctorDept = new SchDoctorDept();
		if(StringUtil.isNotBlank(doctorDeptFlow)){
			doctorDept.setRecordFlow(doctorDeptFlow);
		}else{
			ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
			if(doctor!=null){
				doctorDept.setDoctorFlow(doctor.getDoctorFlow());
				doctorDept.setDoctorName(doctor.getDoctorName());
				doctorDept.setRotationFlow(doctor.getRotationFlow());
				doctorDept.setRotationName(doctor.getRotationName());
				doctorDept.setSessionNumber(doctor.getSessionNumber());
				doctorDept.setOrgFlow(doctor.getOrgFlow());
				doctorDept.setOrgName(doctor.getOrgName());
			}
			SchRotationDept rotationDept = schRotationDeptBiz.readSchRotationDept(rotationDeptFlow);
			if(rotationDept!=null){
				doctorDept.setGroupFlow(rotationDept.getGroupFlow());
				doctorDept.setSchMonth(rotationDept.getSchMonth());
				doctorDept.setSchDeptFlow(rotationDept.getSchDeptFlow());
				doctorDept.setSchDeptName(rotationDept.getSchDeptName());
				doctorDept.setDeptFlow(rotationDept.getDeptFlow());
				doctorDept.setDeptName(rotationDept.getDeptName());
				doctorDept.setStandardDeptId(rotationDept.getStandardDeptId());
				doctorDept.setStandardDeptName(rotationDept.getStandardDeptName());
				doctorDept.setOrdinal(rotationDept.getOrdinal());
			}
			doctorDept.setIsRequired(GlobalConstant.FLAG_N);
		}
		if(StringUtil.isNotBlank(schMonth)){
			doctorDept.setSchMonth(schMonth);
		}
		doctorDept.setRecordStatus(recordStatus);
		schDoctorDeptBiz.editDoctorDept(doctorDept);
		return doctorDept.getRecordFlow();
	}
	
//	@RequestMapping(value = {"/doc/seldept" },method = RequestMethod.GET)
//	public String seldept(DoctorSearchForm doctorSearchForm,Model model){
//		//医师列表
//		List<ResDoctor> doctorList = schDoctortBiz.searchResDoctor(GlobalContext.getCurrentUser().getOrgFlow(),doctorSearchForm);
//		if(doctorList!=null && doctorList.size()>0){
//			List<String> doctorFlows = new ArrayList<String>();
//			List<String> rotationFlows = new ArrayList<String>();
// 			model.addAttribute("doctorList",doctorList);
// 			for(ResDoctor doctor : doctorList){
// 				String rotationFlow = doctor.getRotationFlow();
// 				doctorFlows.add(doctor.getDoctorFlow());
// 				if(!rotationFlows.contains(rotationFlow) && StringUtil.isNotBlank(rotationFlow)){
// 					rotationFlows.add(rotationFlow);
// 				}
// 			}
// 			//轮转方案
// 			List<SchRotation> rotationList = schRotationtBiz.searchRotationByrotationFlows(rotationFlows);
// 			if(rotationList != null && rotationList.size()>0){
// 				Map<String,SchRotation> rotationMap = new HashMap<String,SchRotation>();
// 				for(SchRotation rotation : rotationList){
// 					rotationMap.put(rotation.getRotationFlow(),rotation);
// 				}
// 				model.addAttribute("rotationMap",rotationMap);
// 			}
// 			
// 			//科室组
// 			List<SchRotationGroup> rotationGroupList = schRotationtGroupBiz.searchSchRotationGroupByorg(GlobalContext.getCurrentUser().getOrgFlow());
// 			if(rotationGroupList != null && rotationGroupList.size()>0){
// 				Map<String,List<SchRotationGroup>> rotationGroupMap = new HashMap<String,List<SchRotationGroup>>();
// 				for(SchRotationGroup rotationGroup : rotationGroupList){
// 					if(rotationGroupMap.get(rotationGroup.getRotationFlow()) == null){
// 						List<SchRotationGroup> rotationGroupTempList = new ArrayList<SchRotationGroup>();
// 						rotationGroupTempList.add(rotationGroup);
// 						rotationGroupMap.put(rotationGroup.getRotationFlow(),rotationGroupTempList);
// 					}else{
// 						rotationGroupMap.get(rotationGroup.getRotationFlow()).add(rotationGroup);
// 					}
// 				}
// 				model.addAttribute("rotationGroupMap",rotationGroupMap);
// 			}
// 			
// 			//已选科室
// 			List<SchDoctorDept> doctorDeptList = schDoctorDeptBiz.searchDoctorDeptByDoctorFlows(doctorFlows);
// 			if(doctorDeptList != null && doctorDeptList.size()>0){
// 				Map<String,List<SchDoctorDept>> doctorDeptMap = new HashMap<String,List<SchDoctorDept>>();
// 				for(SchDoctorDept doctorDept : doctorDeptList){
// 					if(doctorDeptMap.get(doctorDept.getDoctorFlow()) == null){
// 						List<SchDoctorDept> doctorDeptTempList = new ArrayList<SchDoctorDept>();
// 						doctorDeptTempList.add(doctorDept);
// 						doctorDeptMap.put(doctorDept.getDoctorFlow(),doctorDeptTempList);
// 					}else{
// 						doctorDeptMap.get(doctorDept.getDoctorFlow()).add(doctorDept);
// 					}
// 				}
// 				model.addAttribute("doctorDeptMap",doctorDeptMap);
// 			}
// 			
// 			//是否完成排班
// 			List<SchArrangeResult> resultList = schArrangeResultBiz.searchArrangeResultByDoctorFlows(doctorFlows);
// 			if(resultList!=null && resultList.size()>0){
// 				Map<String,Integer> resultMap = new HashMap<String, Integer>();
// 				for(SchArrangeResult result : resultList){
// 					if(resultMap.get(result.getDoctorFlow())==null){
// 						resultMap.put(result.getDoctorFlow(),1);
// 					}else{
// 						resultMap.put(result.getDoctorFlow(),(int)resultMap.get(result.getDoctorFlow())+1);
// 					}
// 				}
// 				model.addAttribute("resultMap",resultMap);
// 			}
//		}
//		return "sch/doc/seldept";
//	}
//	
//	@RequestMapping(value = {"/doc/searchSeldept" },method = RequestMethod.POST)
//	public String searchSeldept (DoctorSearchForm doctorSearchForm,Model model){
//		return seldept(doctorSearchForm,model);
//	}
	
	/**
	 * 轮转规则选择
	 * */
	@RequestMapping(value = {"/doc/seldept_item" }, method = RequestMethod.GET)
	public String seldeptItem (String doctorFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = schDoctortBiz.readResDoctor(doctorFlow);
			model.addAttribute("doctor",doctor);
			
			String rotationFlow = doctor.getRotationFlow();
			//科室组
			List<SchRotationGroup> rotationGroupList = schRotationtGroupBiz.searchSchRotationGroup(rotationFlow);
			model.addAttribute("rotationGroupList",rotationGroupList);
			
			//组合科室
			List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchSchRotationDeptGroup(rotationFlow);
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
					doctorDeptMap.put(doctorDept.getGroupFlow()+doctorDept.getStandardDeptId()+doctorDept.getSchDeptFlow(),doctorDept);
				}
				model.addAttribute("doctorDeptMap",doctorDeptMap);
			}
		}

		return "sch/doc/seldept_item";
	}
	
	@RequestMapping(value = "/doc/saveDoctorDept",method={RequestMethod.POST})
	@ResponseBody
	public String saveDoctorDept(SchDoctorDept doctorDept){
		if(doctorDept != null){
			int result = GlobalConstant.ZERO_LINE;
			SchDoctorDept doctorDeptTemp = schDoctorDeptBiz.readSchDoctorDeptByObj(doctorDept.getDoctorFlow(),doctorDept.getSchDeptFlow(),doctorDept.getGroupFlow(),doctorDept.getStandardDeptId());
			if(doctorDeptTemp != null){
				if(GlobalConstant.RECORD_STATUS_Y.equals(doctorDeptTemp.getRecordStatus())){
					doctorDeptTemp.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				}else{
					doctorDeptTemp.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				}
				result = saveSchDoctorDept(doctorDeptTemp);
			}else{
				result = saveSchDoctorDept(doctorDept);
			}
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}	
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	private int saveSchDoctorDept(SchDoctorDept doctorDept){
		doctorDept.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		doctorDept.setOrgName(GlobalContext.getCurrentUser().getOrgName());
		if(StringUtil.isNotBlank(doctorDept.getStandardDeptId())){
			doctorDept.setStandardDeptName(DictTypeEnum.StandardDept.getDictNameById(doctorDept.getStandardDeptId()));
		}
		return schDoctorDeptBiz.saveSchDoctorDept(doctorDept);
	}
	
	
	/**
	 * 医师信息查询  
	 * */
//	@RequestMapping(value = {"/arrange/searchRostering_hand" }, method = RequestMethod.POST)
//	public String searchRosteringHand (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
//		return rosteringHandList(doctorSearchForm,model);
//	}
	
//	@RequestMapping(value = {"/arrange/rosteringHand" }, method = RequestMethod.GET)
//	public String rosteringHandList (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
//		List<ResDoctor> doctorList = schDoctortBiz.searchResDoctor(GlobalContext.getCurrentUser().getOrgFlow(),doctorSearchForm);
//		model.addAttribute("doctorList",doctorList);
//		return "sch/arrange/rostering_hand";
//	}
	
	/**
	 * 手动排班
	 * */
	@RequestMapping(value = {"/arrange/rosteringHand" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String rosteringHandList (ResDoctor doctor,String rosteringType,Model model){
		SysUser user = GlobalContext.getCurrentUser();
		doctor.setOrgFlow(user.getOrgFlow());
		if(doctor.getSessionNumber()==null){
			doctor.setSessionNumber(DateUtil.getYear());
		}
		model.addAttribute("doctor",doctor);
		
		//如果按组分则查询组内人数
		if(GlobalConstant.FLAG_Y.equals(rosteringType)){
			ResDoctor doctorTemp = new ResDoctor();
			doctorTemp.setOrgFlow(user.getOrgFlow());
			doctorTemp.setDoctorCategoryId(RecDocCategoryEnum.Intern.getId());
			List<Map<String,Object>> groupCountMapList = doctorBiz.countGroupDoc(doctorTemp);
			if(groupCountMapList!=null && groupCountMapList.size()>0){
				Map<String,Object> groupCountMap = new HashMap<String, Object>();
				for(Map<String,Object> map : groupCountMapList){
					groupCountMap.put((String)map.get("key"),map.get("value"));
				}
				model.addAttribute("groupCountMap",groupCountMap);
			}
		}else{
			List<ResDoctor> doctorList = doctorBiz.searchByDoc(doctor);
			model.addAttribute("doctorList",doctorList);
		}
		return "sch/arrange/rosteringHand";
	}
	
	@RequestMapping(value = {"/arrange/rosteringHandDept"}, method = {RequestMethod.GET,RequestMethod.POST})
	public String rosteringHandDept(String doctorFlow,Model model){
		if(StringUtil.isNotBlank(doctorFlow)){
			
			ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
			
			if(doctor!=null){
				model.addAttribute("doctor",doctor);
				
				if(StringUtil.isNotBlank(doctor.getRotationFlow())){
					SchRotation rotation = schRotationtBiz.readSchRotation(doctor.getRotationFlow());
					model.addAttribute("rotation",rotation);
					
					List<SchRotationGroup> groupList = schRotationtGroupBiz.searchOrgGroupOrAll(doctor.getRotationFlow(),doctor.getOrgFlow(),null);
					if(groupList!=null && groupList.size()>0){
						Map<String,SchRotationGroup> groupMap = new HashMap<String, SchRotationGroup>();
						for(SchRotationGroup group : groupList){
							groupMap.put(group.getGroupFlow(),group);
						}
						model.addAttribute("groupMap",groupMap);
					}
				}
				
				//所有轮转科室供选修
				List<SysDept> sysDeptList = sysDeptBiz.searchDeptByOrg(doctor.getOrgFlow());
				if(sysDeptList!=null && sysDeptList.size()>0){
					List<String> deptFlows = new ArrayList<String>();
					for(SysDept dept : sysDeptList){
						deptFlows.add(dept.getDeptFlow());
					}
					List<SchDept> deptList = schDeptBiz.searchDeptByDeotFlows(deptFlows);
					if(deptList!=null && deptList.size()>0){
						model.addAttribute("schDeptList",deptList);
						
						List<String> schDeptFlows = new ArrayList<String>();
						for(SchDept schDept : deptList){
							schDeptFlows.add(schDept.getSchDeptFlow());
						}
						List<SchDeptRel> deptRelList = deptRelBiz.searchRelBySchDepts(schDeptFlows);
						if(deptRelList!=null && deptRelList.size()>0){
							Map<String,List<SchDeptRel>> deptRelMap = new HashMap<String, List<SchDeptRel>>();
							for(SchDeptRel deptRel : deptRelList){
								String key = deptRel.getSchDeptFlow();
								if(deptRelMap.get(key)==null){
									List<SchDeptRel> deptRelTempList = new ArrayList<SchDeptRel>();
									deptRelTempList.add(deptRel);
									deptRelMap.put(key,deptRelTempList);
								}else{
									deptRelMap.get(key).add(deptRel);
								}
							}
							model.addAttribute("deptRelMap",deptRelMap);
						}
					}
				}
				
				List<SchArrangeResult> resultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
				model.addAttribute("resultList",resultList);
				
				if(resultList==null || resultList.size()<=0){
					if(StringUtil.isNotBlank(doctor.getRotationFlow())){
						model.addAttribute("doctorFlow",doctorFlow);
						return "redirect:/sch/doc/toSelDept";
					}
				}else{
					Map<String,SchArrangeResult> resultMap = new HashMap<String, SchArrangeResult>();
					List<String> groupFlows = new ArrayList<String>();
					for(SchArrangeResult result : resultList){
						if(StringUtil.isBlank(result.getStandardDeptId())){
							resultMap.put(result.getSchDeptFlow(),result);
						}
						
						String groupFlow = result.getGroupFlow();
						if(!groupFlows.contains(groupFlow) && StringUtil.isNotBlank(groupFlow)){
							groupFlows.add(groupFlow);
						}
					}
					model.addAttribute("resultMap",resultMap);
					
					List<ResDoctorSchProcess> processList = processBiz.searchProcessByDoctor(doctorFlow);
					if(processList!=null && processList.size()>0){
						Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
						for(ResDoctorSchProcess process : processList){
							processMap.put(process.getSchResultFlow(),process);
						}
						model.addAttribute("processMap",processMap);
					}
					
					if(groupFlows.size()>0){
						List<SchRotationGroup> groupList = schRotationtGroupBiz.searchGroupByGroupFlows(groupFlows);
						if(groupList!=null && groupList.size()>0){
							model.addAttribute("groupList",groupList);
							
							Map<String,SchRotationGroup> groupMap = new HashMap<String, SchRotationGroup>();
							for(SchRotationGroup group : groupList){
								groupMap.put(group.getGroupFlow(),group);
							}
							model.addAttribute("groupMap",groupMap);
						}
					}
				}
			}
		}
		return "sch/arrange/rosteringHandDept";
	}
	
	/**
	 * 按组选科排班,选科页面
	 * @param doctor
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/arrange/groupSelAndRostering" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String groupSelAndRostering(ResDoctor doctor,Model model){
		SysUser user = GlobalContext.getCurrentUser();
		
		doctor.setOrgFlow(user.getOrgFlow());
		List<ResDoctor> doctorList = doctorBiz.searchByDoc(doctor);
		if(doctorList!=null && doctorList.size()>0){
			model.addAttribute("doctorList",doctorList);
			
			//获取一个方案
			String rotationFlow = doctorList.get(0).getRotationFlow();
			if(StringUtil.isNotBlank(rotationFlow)){
				SchRotation rotation = schRotationtBiz.readSchRotation(rotationFlow);
				model.addAttribute("rotation",rotation);
				
				List<SchRotationGroup> groupList = schRotationtGroupBiz.searchOrgGroupOrAll(rotationFlow,user.getOrgFlow(),GlobalConstant.FLAG_N);
				if(groupList!=null && groupList.size()>0){
					model.addAttribute("groupList",groupList);
					
					List<SchRotationDept> groupRotationDeptList = schRotationDeptBiz.searchOrgSchRotationDeptGroup(rotationFlow,user.getOrgFlow());
					if(groupRotationDeptList!=null && groupRotationDeptList.size()>0){
						Map<String,List<SchRotationDept>> rotationDeptListMap = new HashMap<String, List<SchRotationDept>>();
						for(SchRotationDept rotationDept : groupRotationDeptList){
							String key = rotationDept.getGroupFlow();
							if(rotationDeptListMap.get(key)==null){
								List<SchRotationDept> rotationDeptList = new ArrayList<SchRotationDept>();
								rotationDeptList.add(rotationDept);
								rotationDeptListMap.put(key,rotationDeptList);
							}else{
								rotationDeptListMap.get(key).add(rotationDept);
							}
						}
						model.addAttribute("rotationDeptListMap",rotationDeptListMap);
					}
				}
			}
			
			List<String> doctorFlows = new ArrayList<String>();
			for(ResDoctor doc : doctorList){
				doctorFlows.add(doc.getDoctorFlow());
			}
			
			Map<String,Boolean> isUseMap = new HashMap<String, Boolean>();
			
			List<SchDoctorDept> doctorDeptList = schDoctorDeptBiz.searchDoctorDeptByDoctorFlows(doctorFlows);
			if(doctorDeptList!=null && doctorDeptList.size()>0){
				for(SchDoctorDept docDept : doctorDeptList){
					String key = docDept.getDoctorFlow();
					if(isUseMap.get(key)==null){
						isUseMap.put(key,true);
						doctorFlows.remove(key);
					}
				}
			}
			
			List<SchArrangeResult> resultList = schArrangeResultBiz.searchArrangeResultByDoctorFlows(doctorFlows);
			if(resultList!=null && resultList.size()>0){
				for(SchArrangeResult result : resultList){
					String key = result.getDoctorFlow();
					if(isUseMap.get(key)==null){
						isUseMap.put(key,true);
					}
				}
			}
			
			model.addAttribute("isUseMap",isUseMap);
		}
		return "sch/arrange/groupSelAndRostering";
	}
	
	/**
	 * 清空选科排班
	 * @param doctorFlows
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/arrange/clearSelAndRostering" }, method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String clearSelAndRostering(String[] doctorFlows,Model model){
		if(doctorFlows!=null && doctorFlows.length>0){
			List<String> doctorFlowList = Arrays.asList(doctorFlows);
			doctorFlowList.toArray(doctorFlows);
			int result = doctorBiz.clearSelAndRostering(doctorFlowList);
			if(result!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	/**
	 * 生成排班数据
	 * */
	@RequestMapping(value = "/doc/createResults",method={RequestMethod.POST})
	@ResponseBody
	public String createResults(String doctorFlow){
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = doctorBiz.readDoctor(doctorFlow);
			if(doctor!=null){
				int result = schArrangeResultBiz.saveResultByDoctor(doctor);
				if(result!=GlobalConstant.ZERO_LINE){
					return GlobalConstant.OPRE_SUCCESSED_FLAG;
				}
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
//	@RequestMapping(value = {"/arrange/rostering_hand_dept" }, method = RequestMethod.GET)
//	public String rosteringHandDept (String doctorFlow,Model model) throws Exception{
//		if(StringUtil.isNotBlank(doctorFlow)){
//			ResDoctor doctor = schDoctortBiz.readResDoctor(doctorFlow);
//			model.addAttribute("doctor",doctor);
//			
//			SchRotation rotation = schRotationtBiz.readSchRotation(doctor.getRotationFlow());
//			model.addAttribute("rotationYear",rotation.getRotationYear());
//			
//			List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchSchRotationDeptMust(doctor.getRotationFlow());
//			model.addAttribute("rotationDeptList",rotationDeptList);
//			
//			if(GlobalConstant.FLAG_Y.equals(doctor.getSelDeptFlag())){
//				List<SchRotationDept> rotationDeptTempList = schRotationDeptBiz.searchSchRotationDeptGroup(doctor.getRotationFlow());
//				if(rotationDeptTempList != null && rotationDeptTempList.size()>0){
//					Map<String,SchRotationDept> rotationDeptMap = new HashMap<String,SchRotationDept>();
//					for(SchRotationDept rotationDept : rotationDeptTempList){
//						rotationDeptMap.put(rotationDept.getGroupFlow()+rotationDept.getSchDeptFlow(),rotationDept);
//					}
//					model.addAttribute("rotationDeptMap",rotationDeptMap);
//				}
//				
//				List<SchRotationGroup> rotationGroupList = schRotationtGroupBiz.searchSchRotationGroup(doctor.getRotationFlow());
//				if(rotationGroupList != null && rotationGroupList.size()>0){
//					Map<String,SchRotationGroup> rotationGroupMap = new HashMap<String,SchRotationGroup>();
//					for(SchRotationGroup rotationGroup : rotationGroupList){
//						rotationGroupMap.put(rotationGroup.getGroupFlow(),rotationGroup);
//					}
//					model.addAttribute("rotationGroupMap",rotationGroupMap);
//				}
//				
//				List<SchDoctorDept> doctorDeptList = schDoctorDeptBiz.searchSchDoctorDept(doctorFlow);
//				model.addAttribute("doctorDeptList",doctorDeptList);
//				
//				List<SchArrangeResult> resultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
//				if(resultList != null && resultList.size()>0){
//					Map<String,SchArrangeResult> resultMap = new HashMap<String,SchArrangeResult>();
//					for(SchArrangeResult arrResult : resultList){
//						resultMap.put(arrResult.getSchDeptFlow()+arrResult.getSchYear(),arrResult);
//					}
//					model.addAttribute("resultMap",resultMap);
//				}
//			}
//		}
//		return "sch/arrange/rostering_hand_dept";
//	}
	
	@RequestMapping(value = "/arrange/saveArrangeResult",method={RequestMethod.POST})
	@ResponseBody
	public String saveArrangeResult(@RequestBody SchArrangeResultForm arrangeResultForm, Model model) throws Exception{
		int result = GlobalConstant.ZERO_LINE;
		result = schArrangeResultBiz.saveSchArrangeResultForm(arrangeResultForm);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value = "/arrange/delArrangeResult",method={RequestMethod.POST})
	@ResponseBody
	public String delArrangeResult(String doctorFlow, Model model) throws Exception{
		int result = GlobalConstant.ZERO_LINE;
		result = schArrangeResultBiz.delArrangeResult(doctorFlow);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping(value = "/arrange/calculateDate",method={RequestMethod.GET})
	@ResponseBody
	public String calculateDate(String date,String step, Model model) throws Exception{
		return DateUtil.addMonthForArrange(date,step,false);
	}
	
	/**
	 * 终止医师
	 * */
	@RequestMapping(value = {"/doc/aid/terminat" },method = RequestMethod.GET)
	public String terminat (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
		List<ResDoctor> doctorList = schDoctortBiz.searchTerminatResDoctor(GlobalContext.getCurrentUser().getOrgFlow(),doctorSearchForm);
		model.addAttribute("doctorList",doctorList);
		return "sch/doc/aid/terminat";
	}
	
	@RequestMapping(value = {"/doc/aid/searchTerminat" }, method = RequestMethod.POST)
	public String searchTerminat (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
		return terminat(doctorSearchForm,model);
	}
	
	/**
	 * 新增终止
	 * */
	@RequestMapping(value = {"/doc/aid/editTerminat" }, method = RequestMethod.GET)
	public String editTerminat (Model model) throws Exception{
		List<ResDoctor> doctorList = schDoctortBiz.searchNotTerminatResDoctor(GlobalContext.getCurrentUser().getOrgFlow());
		model.addAttribute("doctorList",doctorList);
		return "sch/doc/aid/terminatEdit";
	}
	
	@RequestMapping(value = "doc/aid/saveTerminat",method={RequestMethod.POST})
	@ResponseBody
	public String saveTerminat(ResDoctor doctor, Model model) throws Exception{
		if(doctor != null){
			doctor.setDoctorStatusId(ResDoctorStatusEnum.Terminat.getId());
			doctor.setDoctorStatusName(ResDoctorStatusEnum.Terminat.getName());
			int result = schDoctortBiz.saveResDoctor(doctor);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 缺勤医师
	 * */
	@RequestMapping(value = {"/doc/aid/absence" },method = RequestMethod.GET)
	public String absence (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
		List<ResDoctor> doctorList = schDoctortBiz.searchResDoctor(GlobalContext.getCurrentUser().getOrgFlow(),doctorSearchForm);
		model.addAttribute("doctorList",doctorList);
		
		List<SchDoctorAbsence> docAbsenceList = schDoctorAbsenceBiz.searchSchDoctorAbsenceByOrg(GlobalContext.getCurrentUser().getOrgFlow());
		if(docAbsenceList != null && docAbsenceList.size()>0){
			Map<String,List<SchDoctorAbsence>> docAbsenceMap = new HashMap<String,List<SchDoctorAbsence>>();
			for(SchDoctorAbsence docAbsence : docAbsenceList){
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
		
		return "sch/doc/aid/absence";
	}
	
	@RequestMapping(value = {"/doc/aid/searchAbsence" }, method = RequestMethod.POST)
	public String searchAbsence (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
		return absence(doctorSearchForm,model);
	}
	
	/**
	 * 新增缺勤
	 * */
	@RequestMapping(value = {"/doc/aid/editAbsence" }, method = RequestMethod.GET)
	public String editAbsence (SchDoctorAbsence docAbsence,Model model) throws Exception{
		List<ResDoctor> doctorList = schDoctortBiz.searchResDoctor(GlobalContext.getCurrentUser().getOrgFlow());
		model.addAttribute("doctorList",doctorList);
		
		if(docAbsence != null && StringUtil.isNotBlank(docAbsence.getAbsenceFlow())){
			docAbsence = schDoctorAbsenceBiz.readSchDoctorAbsence(docAbsence.getAbsenceFlow());
		}
		model.addAttribute("docAbsence",docAbsence);
		
		return "sch/doc/aid/absenceEdit";
	}
	
	@RequestMapping(value = "doc/aid/saveAbsence",method={RequestMethod.POST})
	@ResponseBody
	public String saveAbsence(SchDoctorAbsence docAbsence, Model model) throws Exception{
		if(docAbsence != null){
			docAbsence.setTrainingSpeName(DictTypeEnum.DoctorTrainingSpe.getDictNameById(docAbsence.getTrainingSpeId()));
			docAbsence.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			docAbsence.setOrgName(GlobalContext.getCurrentUser().getOrgName());
			if(StringUtil.isNotBlank(docAbsence.getEndDate()) && StringUtil.isNotBlank(docAbsence.getStartDate())){
				docAbsence.setIntervalDay(String.valueOf(DateUtil.signDaysBetweenTowDate(docAbsence.getEndDate(),docAbsence.getStartDate())+1));
			}
			
			String schDeptFlow = docAbsence.getSchDeptFlow();
			if(StringUtil.isNotBlank(schDeptFlow)){
				SchDept dept = schDeptBiz.readSchDept(schDeptFlow);
				if(dept!=null){
					docAbsence.setDeptFlow(dept.getDeptFlow());
					docAbsence.setDeptName(dept.getDeptName());
				}
			}
			
			int result = schDoctorAbsenceBiz.saveSchDoctorAbsence(docAbsence);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value = "doc/aid/delAbsence",method={RequestMethod.POST})
	@ResponseBody
	public String delAbsence(String absenceFlow, Model model) throws Exception{
		if(StringUtil.isNotBlank(absenceFlow)){
			SchDoctorAbsence docAbsence = new SchDoctorAbsence();
			docAbsence.setAbsenceFlow(absenceFlow);
			docAbsence.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = schDoctorAbsenceBiz.saveSchDoctorAbsence(docAbsence);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	/**
	 * 科室轮转查询
	 * */
	@RequestMapping(value = {"/doc/schDept" },method = RequestMethod.GET)
	public String schDept (String startDate,String endDate,Model model){
		List<String> titleDate = null;
		
		if(!StringUtil.isNotBlank(startDate)){
			startDate = DateUtil.getCurrDate();
			endDate = DateTrans.newDateOfAddMonths(startDate,12);
			model.addAttribute("startDate",startDate);
			model.addAttribute("endDate",endDate);
		}
		
		if(StringUtil.isNotBlank(startDate) && StringUtil.isNotBlank(endDate)){
			if(SchUnitEnum.Week.getId().equals(InitConfig.getSysCfg("res_rotation_unit"))){
				titleDate = getWeeksByTwoDate(startDate,endDate);
			}else if(SchUnitEnum.Month.getId().equals(InitConfig.getSysCfg("res_rotation_unit"))){
				String schStartMonth = startDate.substring(0,7);
				String schEndMonth = endDate.substring(0,7);
				titleDate = getMonthsByTwoMonth(schStartMonth,schEndMonth);
			}else{
				String schStartMonth = startDate.substring(0,7);
				String schEndMonth = endDate.substring(0,7);
				titleDate = getMonthsByTwoMonth(schStartMonth,schEndMonth);
			}
			model.addAttribute("titleDate",titleDate);
			
			List<SchDept> schDeptList = schDeptBiz.searchSchDeptList(GlobalContext.getCurrentUser().getOrgFlow());
			model.addAttribute("schDeptList",schDeptList);
			
			List<SchArrangeResult> arrResultList = schArrangeResultBiz.searchArrangeResultByDateAndOrg(startDate, endDate,GlobalContext.getCurrentUser().getOrgFlow());
			if(arrResultList != null && arrResultList.size()>0){
				Map<String,List<SchArrangeResult>> resultListMap = new HashMap<String, List<SchArrangeResult>>();
				for(SchArrangeResult sar : arrResultList){
					String schDeptFlow = sar.getSchDeptFlow();
					String resultStartDate = sar.getSchStartDate();
					String resultEndDate = sar.getSchEndDate();
					if(StringUtil.isNotBlank(resultStartDate) && StringUtil.isNotBlank(resultEndDate)){
						if(SchUnitEnum.Week.getId().equals(InitConfig.getSysCfg("res_rotation_unit"))){
							List<String> weeks = getWeeksByTwoDate(resultStartDate,resultEndDate);
							if(weeks!=null){
								for(String week : weeks){
									String key = schDeptFlow+week;
									if(resultListMap.get(key)==null){
										List<SchArrangeResult> sarList = new ArrayList<SchArrangeResult>();
										sarList.add(sar);
										resultListMap.put(key,sarList);
									}else{
										resultListMap.get(key).add(sar);
									}
								}
							}
						}else{
							resultStartDate = startDate.substring(0,7);
							resultEndDate = endDate.substring(0,7);
							//计算该轮转科室该月人数
							List<String> months = getMonthsByTwoMonth(resultStartDate,resultEndDate);
							if(months!=null){
								for(String month : months){
									String key = schDeptFlow+month;
									if(resultListMap.get(key)==null){
										List<SchArrangeResult> sarList = new ArrayList<SchArrangeResult>();
										sarList.add(sar);
										resultListMap.put(key,sarList);
									}else{
										resultListMap.get(key).add(sar);
									}
								}
							}
						}
					}
				}
				model.addAttribute("resultListMap",resultListMap);
			}
		}
		return "sch/doc/schDept";
	}
	
	/**
	 * 获取两个月份之间的所有月
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	private List<String> getMonthsByTwoMonth(String startDate,String endDate){
		List<String> months = null;
		if(StringUtil.isNotBlank(startDate) && StringUtil.isNotBlank(endDate) && startDate.compareTo(endDate)<=0){
			months = new ArrayList<String>();
			months.add(startDate);
			if(!startDate.equals(endDate)){
				String currDate = startDate;
				while(!currDate.equals(endDate)){
					currDate = DateTrans.newMonthOfAddMonths(currDate,1);
					months.add(currDate);
				}
			}
		}
		return months;
	}
	
	/**
	 * 获取两个日期之间的所有周
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	private List<String> getWeeksByTwoDate(String startDate,String endDate){
		List<String> weeks = null;
		if(StringUtil.isNotBlank(startDate) && StringUtil.isNotBlank(endDate) && startDate.compareTo(endDate)<=0){
			weeks = new ArrayList<String>();
			String startYear = startDate.substring(0,4);
			String endYear = endDate.substring(0,4);
			if(startYear.equals(endYear)){
				long startDays = DateUtil.signDaysBetweenTowDate(startDate,startYear+"-01-01");
				long endDays = DateUtil.signDaysBetweenTowDate(endDate,startYear+"-01-01");
				long startWeek = weekFormat(startDays);
				long endWeek = weekFormat(endDays);
				while(startWeek<=endWeek){
					weeks.add(startYear+"-"+startWeek);
					startWeek++;
				}
			}else{
				int start = Integer.parseInt(startYear);
				int end = Integer.parseInt(endYear);
				while(start<=end){
					String currYear = String.valueOf(start);
					long dayNum = 0;
					if(startYear.equals(currYear)){
						dayNum = DateUtil.signDaysBetweenTowDate(startDate,startYear+"-01-01");
						long endNum = DateUtil.signDaysBetweenTowDate(currYear+"-12-31",currYear+"-01-01");
						long startWeek = weekFormat(dayNum);
						long endWeek = weekFormat(endNum);
						while(startWeek<=endWeek){
							weeks.add(currYear+"-"+startWeek);
							startWeek++;
						}
					}else if(endYear.equals(currYear)){
						dayNum = DateUtil.signDaysBetweenTowDate(endDate,currYear+"-01-01");
						long startWeek = 1;
						long endWeek = weekFormat(dayNum);
						while(startWeek<=endWeek){
							weeks.add(currYear+"-"+startWeek);
							startWeek++;
						}
					}else{
						dayNum = DateUtil.signDaysBetweenTowDate(currYear+"-12-31",currYear+"-01-01");
						long startWeek = 1;
						long endWeek = weekFormat(dayNum);
						while(startWeek<=endWeek){
							weeks.add(currYear+"-"+startWeek);
							startWeek++;
						}
					}
					start++;
				}
			}
		}
		return weeks;
	}
	
	private long weekFormat(long days){
		long result = 1;
		if(days!=0){
			result = (long)Math.ceil(days/7.0);
		}
		return result;
	}
	
	/**
	 * 医师轮转查询
	 * */
	@RequestMapping(value = {"/doc/schDoc" },method = RequestMethod.GET)
	public String schDoc (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
		if(doctorSearchForm != null && StringUtil.isNotBlank(doctorSearchForm.getDoctorCategoryId())){
			List<ResDoctor> doctorList = schDoctortBiz.searchResDoctor(GlobalContext.getCurrentUser().getOrgFlow(),doctorSearchForm);
			model.addAttribute("doctorList",doctorList);
			if(doctorList != null && doctorList.size()>0){
				List<String> doctorFlows = new ArrayList<String>();
				for(ResDoctor doctor : doctorList){
					doctorFlows.add(doctor.getDoctorFlow());
				}
//				List<SchArrangeResult> arrResultList = schArrangeResultBiz.searchArrangeResultByDoctorFlows(doctorFlows);
//				if(arrResultList != null && arrResultList.size()>0){
//					Map<String,List<SchArrangeResult>> arrResultMap = new HashMap<String,List<SchArrangeResult>>();
//					for(SchArrangeResult arrResult : arrResultList){
//						if(arrResultMap.get(arrResult.getDoctorFlow()) == null){
//							List<SchArrangeResult> arrResultTempList = new ArrayList<SchArrangeResult>();
//							arrResultTempList.add(arrResult);
//							arrResultMap.put(arrResult.getDoctorFlow(),arrResultTempList);
//						}else{
//							arrResultMap.get(arrResult.getDoctorFlow()).add(arrResult);
//						}
//					}
//					model.addAttribute("arrResultMap",arrResultMap);
//				}
				List<SysUser> userList = userBiz.searchSysUserByuserFlows(doctorFlows);
				if(userList!=null && userList.size()>0){
					Map<String,SysUser> userMap = new HashMap<String, SysUser>();
					for(SysUser user : userList){
						userMap.put(user.getUserFlow(),user);
					}
					model.addAttribute("userMap",userMap);
				}
			}
		}
		
		List<SchRotation> rotationList = schRotationtBiz.searchSchRotationByIsPublish();
		if(rotationList != null && rotationList.size()>0){
			Map<String,SchRotation> rotationMap = new HashMap<String,SchRotation>();
			for(SchRotation rotation : rotationList){
				rotationMap.put(rotation.getRotationFlow(),rotation);
			}
			model.addAttribute("rotationMap",rotationMap);
		}
		return "sch/doc/schDoc";
	}
	
	@RequestMapping(value = {"/doc/searchSchDoc" },method = RequestMethod.POST)
	public String searchSchDoc (DoctorSearchForm doctorSearchForm,Model model) throws Exception{
		return schDoc(doctorSearchForm,model);
	}
	
	@RequestMapping(value = {"/doc/rotationDetail" },method = RequestMethod.GET)
	public String rotationDetail(String doctorFlow,Model model){
		if(StringUtil.isNotBlank(doctorFlow)){
			ResDoctor doctor = schDoctortBiz.readResDoctor(doctorFlow);
			model.addAttribute("doctor",doctor);
			
			List<SchArrangeResult> arrResultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
			model.addAttribute("arrResultList",arrResultList);
			
			List<SchDoctorAbsence> absenceList = schDoctorAbsenceBiz.searchSchDoctorAbsenceByDoctor(doctorFlow);
			if(absenceList!=null && absenceList.size()>0){
				Map<String,Integer> absenceCount = new HashMap<String, Integer>();
				for(SchDoctorAbsence absence : absenceList){
					String key = absence.getSchDeptFlow();
					Integer day = 0;
					if(StringUtil.isNotBlank(absence.getIntervalDay())){
						day = Integer.parseInt(absence.getIntervalDay());
					}
					if(absenceCount.get(key)==null){
						absenceCount.put(key,day);
					}else{
						absenceCount.put(key,absenceCount.get(key)+day);
					}
				}
				model.addAttribute("absenceCount",absenceCount);
			}
		}
		return "sch/doc/rotationDetail";
	}
	
	@RequestMapping(value = {"/template/ruleView" },method = RequestMethod.GET)
	public String ruleView(String rotationFlow,Model model){
		SchRotation rotation = schRotationtBiz.readSchRotation(rotationFlow);
		model.addAttribute("rotation",rotation);
		
		List<SchRotationDept> rotationDeptList = schRotationDeptBiz.searchSchRotationDept(rotationFlow);
		List<SchRotationGroup> groupList = schRotationtGroupBiz.searchSchRotationGroup(rotationFlow);
		model.addAttribute("groupList",groupList);
		if(rotationDeptList!=null && rotationDeptList.size()>0){
			Map<String,List<SchRotationDept>> groupRotationDeptListMap = new HashMap<String, List<SchRotationDept>>();
			List<String> relRecordFlows = new ArrayList<String>();
			for(SchRotationDept rotationDept : rotationDeptList){
				relRecordFlows.add(rotationDept.getRecordFlow());
				String key = rotationDept.getGroupFlow();
				if(groupRotationDeptListMap.get(key)==null){
					List<SchRotationDept> rotationDeptTempList = new ArrayList<SchRotationDept>();
					rotationDeptTempList.add(rotationDept);
					groupRotationDeptListMap.put(key,rotationDeptTempList);
				}else{
					groupRotationDeptListMap.get(key).add(rotationDept);
				}
			}
			model.addAttribute("groupRotationDeptListMap",groupRotationDeptListMap);
			
			List<SchRotationDeptReq> rotationDeptReqList = schRotationDeptBiz.searchStandardReqByRelFlows(relRecordFlows);
			if(rotationDeptReqList!=null && rotationDeptReqList.size()>0){
				Map<String,List<SchRotationDeptReq>> reqMap = new HashMap<String,List<SchRotationDeptReq>>();
				for(SchRotationDeptReq req : rotationDeptReqList){
					String key = req.getRelRecordFlow()+req.getRecTypeId();
					if(reqMap.get(key)==null){
						List<SchRotationDeptReq> reqListTemp = new ArrayList<SchRotationDeptReq>();
						reqListTemp.add(req);
						reqMap.put(key,reqListTemp);
					}else{
						if(ResRecTypeEnum.CaseRegistry.getId().equals(req.getRecTypeId())){
							SchRotationDeptReq bigReq = reqMap.get(key).get(0);
							bigReq.setReqNum(req.getReqNum().add(bigReq.getReqNum()));
						}else{
							reqMap.get(key).add(req);
						}
					}
				}
				model.addAttribute("reqMap",reqMap);
			}
		}
		return "sch/template/ruleList";
	}
	
	@RequestMapping(value = {"/template/rotationClone"},method = RequestMethod.POST)
	@ResponseBody
	public String rotationClone(String rotationFlow,String rotationYear){
		int result = schRotationtBiz.rotationClone(rotationFlow,rotationYear);
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * TODO 计划审核
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/arrange/auditResult"},method = {RequestMethod.GET,RequestMethod.POST})
	public String auditResult(ResDoctor doctor,Model model){
		model.addAttribute("doctor",doctor);
		
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		doctor.setOrgFlow(orgFlow);

		List<SchDept> schDeptList = schDeptBiz.countDeptArea(doctor);
		model.addAttribute("schDeptList",schDeptList);
		
		if(doctor.getSessionNumber()==null){
			doctor.setSessionNumber(DateUtil.getYear());
		}
		Map<String,String> resultDateAreaMap = schArrangeResultBiz.countDateArea(doctor);
		if(resultDateAreaMap!=null){
			String minDate = resultDateAreaMap.get("min");
			String maxDate = resultDateAreaMap.get("max");
			
			String[] minDates = minDate.split("-");
			String[] maxDates = maxDate.split("-");
			
			Integer minYear = Integer.parseInt(minDates[0]);
			Integer minMonth = Integer.parseInt(minDates[1]);
			
			Integer maxYear = Integer.parseInt(maxDates[0]);
			Integer maxMonth = Integer.parseInt(maxDates[1]);
			
			Integer beforeMonth = (maxYear-minYear)*12+(maxMonth-minMonth);
			List<String> monthList = new ArrayList<String>();
			Map<String,Object> resultCountMap = new HashMap<String, Object>();
			Map<String,Object> resultSubmitCountMap = new HashMap<String, Object>();
			
			String startMonth = minDates[0]+"-"+minDates[1];
			for(int i = 0 ; i<beforeMonth ; i++){
				String currMonth = DateTrans.newMonthOfAddMonths(startMonth,i);
				monthList.add(currMonth);
				doctor.setSchStatusId(null);
				List<Map<String,Object>> currMonthCountList = schArrangeResultBiz.countMonthNum(currMonth,doctor);
				if(currMonthCountList!=null && currMonthCountList.size()>0){
					for(Map<String,Object> map : currMonthCountList){
						resultCountMap.put(map.get("schDeptFlow")+currMonth,map.get("countNum"));
					}
				}
				
				doctor.setSchStatusId(SchStatusEnum.Submit.getId());
				List<Map<String,Object>> currMonthSubmitCountList = schArrangeResultBiz.countMonthNum(currMonth,doctor);
				if(currMonthSubmitCountList!=null && currMonthSubmitCountList.size()>0){
					for(Map<String,Object> map : currMonthSubmitCountList){
						resultSubmitCountMap.put(map.get("schDeptFlow")+currMonth,map.get("countNum"));
					}
				}
			}
			String lastMonth = maxDates[0]+"-"+maxDates[1];
			monthList.add(lastMonth);
			doctor.setSchStatusId(null);
			List<Map<String,Object>> currMonthCountList = schArrangeResultBiz.countMonthNum(lastMonth,doctor);
			if(currMonthCountList!=null && currMonthCountList.size()>0){
				for(Map<String,Object> map : currMonthCountList){
					resultCountMap.put(map.get("schDeptFlow")+lastMonth,map.get("countNum"));
				}
			}
			
			doctor.setSchStatusId(SchStatusEnum.Submit.getId());
			List<Map<String,Object>> currMonthSubmitCountList = schArrangeResultBiz.countMonthNum(lastMonth,doctor);
			if(currMonthSubmitCountList!=null && currMonthSubmitCountList.size()>0){
				for(Map<String,Object> map : currMonthSubmitCountList){
					resultSubmitCountMap.put(map.get("schDeptFlow")+lastMonth,map.get("countNum"));
				}
			}
			model.addAttribute("resultCountMap",resultCountMap);
			model.addAttribute("resultSubmitCountMap",resultSubmitCountMap);
			model.addAttribute("monthList",monthList);
		}
		
		return "sch/doc/auditResult";
	}
	
	/**
	 * TODO 计划审核医师列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/template/doctorDetailList" },method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> doctorDetailList(String schDeptFlow,String month,ResDoctor doctorForm){
		Map<String,Object> dataMap = null;
		if(StringUtil.isNotBlank(month) && StringUtil.isNotBlank(schDeptFlow)){
			dataMap = new HashMap<String, Object>();
			String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			doctorForm.setOrgFlow(orgFlow);
			List<SchArrangeResult> resultList = schArrangeResultBiz.searchInMonthResult(schDeptFlow,month,doctorForm);
			if(resultList!=null && resultList.size()>0){
				dataMap.put("resultList",resultList);
				
				List<String> doctorFlows = new ArrayList<String>();
				for(SchArrangeResult result : resultList){
					doctorFlows.add(result.getDoctorFlow());
				}
				
				List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(doctorFlows);
				if(doctorList!=null && doctorList.size()>0){
					Map<String,ResDoctor> doctorMap = new HashMap<String, ResDoctor>();
					for(ResDoctor doctor : doctorList){
						doctorMap.put(doctor.getDoctorFlow(),doctor);
					}
					dataMap.put("doctorMap",doctorMap);
				}
			}
		}
		return dataMap;
	}
			
	/**
	 * TODO 计划审核通过
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/template/auditComplate" },method = RequestMethod.POST)
	@ResponseBody
	public String auditComplate(){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		doctorBiz.resultAudit(orgFlow);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * TODO 计划变更审核
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/arrange/auditResultChange"},method = RequestMethod.GET)
	public String auditResultChange(Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		
		ResDoctor doctor = new ResDoctor();
		doctor.setOrgFlow(orgFlow);
		doctor.setSchStatusId(SchStatusEnum.Submit.getId());
		List<ResDoctor> doctorList = doctorBiz.searchByDoc(doctor);
		if(doctorList!=null && doctorList.size()>0){
			model.addAttribute("doctorList",doctorList);
			
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
		}
		
		return "sch/doc/auditResultChange";
	}
	
	/**
	 * TODO 医师计划列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/template/doctorResultList"},method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> doctorResultList(String doctorFlow){
		Map<String,Object> resultProcessMap = null;
		if(StringUtil.isNotBlank(doctorFlow)){
			resultProcessMap = new HashMap<String, Object>();
			
			List<SchArrangeResult> resultList = schArrangeResultBiz.searchSchArrangeResultByDoctor(doctorFlow);
			resultProcessMap.put("resultList",resultList);
			
			List<ResDoctorSchProcess> processList = processBiz.searchProcessByDoctor(doctorFlow);
			if(processList!=null && processList.size()>0){
				Map<String,ResDoctorSchProcess> processMap = new HashMap<String, ResDoctorSchProcess>();
				for(ResDoctorSchProcess process : processList){
					processMap.put(process.getSchResultFlow(),process);
				}
				resultProcessMap.put("processMap",processMap);
			}
		}
		return resultProcessMap;
	}
	
	/**
	 * 保存自由排班结果
	 * @param doctorFlow
	 * @param addSchDeptFlows
	 * @param delResultFlows
	 * @return
	 */
	@RequestMapping(value = {"/template/saveFreeRostering"},method = RequestMethod.POST)
	@ResponseBody
	public String saveFreeRostering(String doctorFlow,String[] addSchDeptFlows,String[] delResultFlows){
		if(StringUtil.isNotBlank(doctorFlow)){
			int result = schArrangeResultBiz.editFreeRostering(doctorFlow,addSchDeptFlows,delResultFlows);
			if(GlobalConstant.ZERO_LINE!=result){
				ResDoctor doctor = (ResDoctor) getSessionAttribute("currDoctor");
				if(doctor!=null && doctorFlow.equals(doctor.getDoctorFlow())){
					doctor.setSchFlag(GlobalConstant.FLAG_N);
				}
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * 保存新顺序
	 * @param recordFlows
	 * @return
	 */
	@RequestMapping(value = {"/template/sortRotationDept"},method = RequestMethod.POST)
	@ResponseBody
	public String sortRotationDept(String[] recordFlows){
		int result = schRotationDeptBiz.saveRotationDeptOrd(recordFlows);
		if(GlobalConstant.ZERO_LINE!=result){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	/**
	 * 查询需轮转科室,以供排班
	 * @param rotationFlow
	 * @param selDepts
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/template/simulateResult"},method = RequestMethod.POST)
	public String simulateResult(String rotationFlow,String[] selDepts,Model model){
		String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
		List<SchRotationDept> mustRotationDeptList = schRotationDeptBiz.searchOrgSchRotationDeptMust(rotationFlow,orgFlow);
		
		if(selDepts!=null && selDepts.length>0){
			List<String> selDeptList = Arrays.asList(selDepts);
			List<SchRotationDept> selRotationDeptList = schRotationDeptBiz.searchRotationDeptByRecordFlows(selDeptList);
			if(mustRotationDeptList!=null){
				mustRotationDeptList.addAll(selRotationDeptList);
			}
		}
		model.addAttribute("rotationDeptList",mustRotationDeptList);
		return "/sch/arrange/groupRosteringHandDept";
	}
	
	
	@RequestMapping(value = {"/template/saveGroupResult"},method = RequestMethod.POST)
	@ResponseBody
	public String saveGroupResult(@RequestBody List<SchArrangeResult> resultList,String groupId){
		int result = schArrangeResultBiz.saveGroupResult(resultList,groupId,GlobalContext.getCurrentUser());
		if(result!=GlobalConstant.ZERO_LINE){
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
	
	
	@RequestMapping(value = {"/template/getUnrelCount"},method = RequestMethod.GET)
	@ResponseBody
	public int getUnrelCount(String orgFlow,String rotationFlow){
		int result = 0;
		if(StringUtil.isNotBlank(rotationFlow) && StringUtil.isNotBlank(orgFlow)){
			result = schRotationDeptBiz.getUnrelCount(orgFlow, rotationFlow);
		}
		return result;
	}
}

