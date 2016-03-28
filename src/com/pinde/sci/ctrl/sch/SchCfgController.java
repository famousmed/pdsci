package com.pinde.sci.ctrl.sch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResJointOrgBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDeptExternalRelBiz;
import com.pinde.sci.biz.sch.ISchDeptRelBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.ResJointOrg;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDeptExternalRel;
import com.pinde.sci.model.mo.SchDeptRel;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;

@Controller
@RequestMapping("/sch/cfg")
public class SchCfgController extends GeneralController{   
	
	private static Logger logger = LoggerFactory.getLogger(SchCfgController.class);
	
	@Resource
	private IDeptBiz deptBiz;
	@Resource
	private ISchDeptBiz schDeptBiz;
	@Resource
	private ISchDeptRelBiz deptRelBiz;
	@Resource
	private ISchDeptExternalRelBiz deptExtRelBiz;
	@Resource
	private IOrgBiz orgBiz;
	@Resource
	private IResJointOrgBiz jointOrgBiz;
	
	/**
	 * 轮转科室维护
	 * **/
	@RequestMapping(value = {"/deptcfg/{roleFlag}" }, method = RequestMethod.GET)
	public String deptcfg (@PathVariable String roleFlag,String orgFlow,Model model) throws Exception{
		model.addAttribute("roleFlag",roleFlag);
		setSessionAttribute("deptListScope",roleFlag);
		
		orgFlow = StringUtil.defaultIfEmpty(orgFlow,GlobalContext.getCurrentUser().getOrgFlow());
		model.addAttribute("orgFlow",orgFlow);
		
		SysDept dept = new SysDept();
		dept.setOrgFlow(orgFlow);
//		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> deptList = deptBiz.searchDept(dept);
		if(deptList!=null && deptList.size()>0){
			model.addAttribute("deptList",deptList);
			Map<String,SysDept> deptMap = new HashMap<String, SysDept>();
			for(SysDept deptTemp : deptList){
				deptMap.put(deptTemp.getDeptFlow(),deptTemp);
			}
			model.addAttribute("deptMap",deptMap);
		}
		
		Map<String, List<SchDept>> schDeptCountMap = schDeptBiz.searchSchDeptMap(orgFlow);
		model.addAttribute("schDeptCountMap",schDeptCountMap);
		
		List<SchDeptRel> deptRelList = deptRelBiz.searchRelByOrg(orgFlow);
		if(deptRelList!=null && deptRelList.size()>0){
			Map<String,List<SchDeptRel>> deptRelMap = new HashMap<String, List<SchDeptRel>>();
			for(SchDeptRel deptRel : deptRelList){
				String key = deptRel.getSchDeptFlow();
				if(deptRelMap.get(key)==null){
					List<SchDeptRel> deptRelListTemp = new ArrayList<SchDeptRel>();
					deptRelListTemp.add(deptRel);
					deptRelMap.put(key, deptRelListTemp);
				}else{
					deptRelMap.get(key).add(deptRel);
				}
			}
			model.addAttribute("deptRelMap",deptRelMap);
		}
		
		List<SchDeptExternalRel> deptExtRelList = deptExtRelBiz.searchSchDeptExtRel(orgFlow);
		if(deptExtRelList!=null && deptExtRelList.size()>0){
			Map<String,SchDeptExternalRel> deptExtRelMap = new HashMap<String, SchDeptExternalRel>();
			for(SchDeptExternalRel deptExtRel : deptExtRelList){
				deptExtRelMap.put(deptExtRel.getSchDeptFlow(),deptExtRel);
			}
			model.addAttribute("deptExtRelMap",deptExtRelMap);
		}
		return "sch/cfg/deptcfg";
	}
	
	@RequestMapping(value = {"/deptList" }, method = RequestMethod.GET)
	public String deptList (String deptFlow,Model model) throws Exception{
		List<SchDept> schDeptList = schDeptBiz.searchSchDept(deptFlow);
		model.addAttribute("schDeptList",schDeptList);
		
		SysDept sysDept = deptBiz.readSysDept(deptFlow);
		model.addAttribute("sysDept",sysDept);
		
		return "sch/cfg/deptList";
	}
	
	/**
	 * 编辑部门
	 * **/
	@RequestMapping(value = {"/editDept" }, method = RequestMethod.GET)
	public String editDept (String schDeptFlow,String orgFlow,Model model) throws Exception{
		orgFlow = StringUtil.defaultIfEmpty(orgFlow,GlobalContext.getCurrentUser().getOrgFlow());
		model.addAttribute("orgFlow",orgFlow);
		
		if(StringUtil.isNotBlank(schDeptFlow)){
			SchDept dept = schDeptBiz.readSchDept(schDeptFlow);
			model.addAttribute("schDept",dept);
			
			List<SchDeptRel> deptRelList = deptRelBiz.searchRelBySchDept(schDeptFlow);
			if(deptRelList!=null && deptRelList.size()>0){
				Map<String,SchDeptRel> deptRelMap = new HashMap<String, SchDeptRel>();
				for(SchDeptRel deptRel : deptRelList){
					deptRelMap.put(deptRel.getStandardDeptId(),deptRel);
				}
				model.addAttribute("deptRelMap",deptRelMap);
			}
			
			if(dept!=null && GlobalConstant.FLAG_Y.equals(dept.getIsExternal())){
				SchDeptExternalRel deptExtRel = deptExtRelBiz.readSchDeptExtRelBySchDept(schDeptFlow);
				model.addAttribute("deptExtRel",deptExtRel);
			}
		}
		
		if(StringUtil.isNotBlank(orgFlow)){
			SysDept dept = new SysDept();
			dept.setOrgFlow(orgFlow);
			List<SysDept> deptList = deptBiz.searchDept(dept);
			model.addAttribute("deptList",deptList);
			
			List<ResJointOrg> jointOrgList = jointOrgBiz.searchResJointByOrgFlow(orgFlow);
			model.addAttribute("jointOrgList",jointOrgList);
		}
		
		return "sch/cfg/deptEdit";
	}
	
	@RequestMapping(value = "/saveDept",method={RequestMethod.POST})
	@ResponseBody
	public String saveDept(SchDept dept,String[] standardDeptId,SchDeptExternalRel deptExtRel) throws Exception{
		 if(null != dept){
			 String orgFlow = dept.getOrgFlow();
			 if(StringUtil.isNotBlank(orgFlow)){
				 SysOrg org = orgBiz.readSysOrg(orgFlow);
				 
				 dept.setOrgFlow(org.getOrgFlow());
				 dept.setOrgName(org.getOrgName());
			 }
			 if(StringUtil.isNotBlank(dept.getDeptFlow())){
				 SysDept sysDept = deptBiz.readSysDept(dept.getDeptFlow());
				 if(sysDept!=null){
					 dept.setDeptName(sysDept.getDeptName());
				 }
			 }
			 int result = 0;
			 if(GlobalConstant.FLAG_Y.equals(dept.getIsExternal())){
				 result = schDeptBiz.saveSchDeptAndRedAndExtRel(dept,standardDeptId,deptExtRel);
			 }else{
				 result = schDeptBiz.saveSchDeptAndRed(dept,standardDeptId);
			 }
			 if(result != GlobalConstant.ZERO_LINE){
				 return GlobalConstant.SAVE_SUCCESSED;
			 }
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value = "/delDept",method={RequestMethod.POST})
	@ResponseBody
	public String delDept(SchDept dept,Model model) throws Exception{
		if(null != dept){
			dept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = schDeptBiz.delSchDept(dept);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping(value = "/searchDeptListByOrg",method={RequestMethod.POST})
	@ResponseBody
	public List<SysDept> searchDeptListByOrg(String orgFlow){
		List<SysDept> deptList = null;
		if(StringUtil.isNotBlank(orgFlow)){
			deptList = deptBiz.searchDeptByOrg(orgFlow);
		}
		return deptList;
	}
	
	@RequestMapping(value = "/searchSchDeptListByDept",method={RequestMethod.POST})
	@ResponseBody
	public List<SchDept> searchSchDeptListByDept(String deptFlow){
		List<SchDept> schDeptList = null;
		if(StringUtil.isNotBlank(deptFlow)){
			schDeptList = schDeptBiz.searchSchExternalDeptListByDept(deptFlow);
		}
		return schDeptList;
	}
	
	/**
	 * TODO 标准科室与轮转科室关系页面
	 * */
	@RequestMapping(value = {"/schDeptRelCfg" },method = RequestMethod.GET)
	public String schDeptRelCfg(String orgFlow,Model model){
		orgFlow = StringUtil.defaultIfEmpty(orgFlow,GlobalContext.getCurrentUser().getOrgFlow());
		if(StringUtil.isNotBlank(orgFlow)){
			List<SchDept> deptList = schDeptBiz.searchSchDeptList(orgFlow);
			model.addAttribute("deptList",deptList);
			
			List<SchDeptRel> deptRelList = deptRelBiz.searchRelByOrg(orgFlow);
			if(deptRelList!=null && deptRelList.size()>0){
				Map<String,Map<String,String>> deptRelMap = new HashMap<String,Map<String,String>>();
				for(SchDeptRel deptRel : deptRelList){
					String key = deptRel.getSchDeptFlow();
					if(deptRelMap.get(key)==null){
						Map<String,String> deptRelTempMap = new HashMap<String, String>();
						deptRelTempMap.put(deptRel.getStandardDeptId(),deptRel.getStandardDeptName());
						deptRelMap.put(key,deptRelTempMap);
					}else{
						deptRelMap.get(key).put(deptRel.getStandardDeptId(),deptRel.getStandardDeptName());
					}
				}
				model.addAttribute("deptRelMap",deptRelMap);
			}
		}
		return "sch/cfg/schDeptRelCfg";
	}
	
	/**
	 * TODO 加载已关联科室
	 * */
	@RequestMapping(value = "/loadRelDept",method={RequestMethod.POST})
	@ResponseBody
	public List<SchDeptRel> loadRelDept(String schDeptFlow){
		List<SchDeptRel> deptRelList = null;
		if(StringUtil.isNotBlank(schDeptFlow)){
			deptRelList = deptRelBiz.searchRelBySchDept(schDeptFlow);
		}
		return deptRelList;
	}
	
	/**
	 * TODO 保存关系
	 * */
	@RequestMapping(value = "/saveDeptRel",method={RequestMethod.POST})
	@ResponseBody
	public String saveDeptRel(SchDeptRel deptRel){
		if(deptRel!=null){
			String orgFlow = StringUtil.defaultIfEmpty(deptRel.getOrgFlow(),GlobalContext.getCurrentUser().getOrgFlow());
			if(StringUtil.isNotBlank(orgFlow)){
				SysOrg org = orgBiz.readSysOrg(orgFlow);
				if(org!=null){
					deptRel.setOrgFlow(orgFlow);
					deptRel.setOrgName(org.getOrgName());
				}
			}
			
			if(StringUtil.isNotBlank(deptRel.getSchDeptFlow())){
				SchDept dept = schDeptBiz.readSchDept(deptRel.getSchDeptFlow());
				if(dept!=null){
					deptRel.setSchDeptName(dept.getSchDeptName());
					deptRel.setDeptFlow(dept.getDeptFlow());
					deptRel.setDeptName(dept.getDeptName());
				}
			}
			if(StringUtil.isNotBlank(deptRel.getStandardDeptId())){
				deptRel.setStandardDeptName(DictTypeEnum.StandardDept.getDictNameById(deptRel.getStandardDeptId()));
			}
		}
		deptRelBiz.editDeptRel(deptRel);
		return deptRel.getRecordFlow();
	}
	
	/**
	 * TODO 部门与轮转科室1:1映射
	 * */
	@RequestMapping(value = "/mapTheDept",method={RequestMethod.POST})
	@ResponseBody
	public String mapTheDept(String orgFlow,String[] deptFlow){
		orgFlow = StringUtil.defaultIfEmpty(orgFlow,GlobalContext.getCurrentUser().getOrgFlow());
		if(deptFlow!=null && deptFlow.length>0){
			List<String> deptFlows = new ArrayList<String>();
			for(String flow : deptFlow){
				deptFlows.add(flow);
			}
			int result = schDeptBiz.mapDeptRel(orgFlow,deptFlows);
			if(result!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}
		}
		return GlobalConstant.OPRE_FAIL_FLAG;
	}
}

