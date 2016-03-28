package com.pinde.sci.ctrl.sys;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.edu.UserPageEnum;
import com.pinde.sci.enums.njmudu.NjmuUserPageEnum;
import com.pinde.sci.enums.srm.RegPageEnum;
import com.pinde.sci.enums.sys.RoleLevelEnum;
import com.pinde.sci.model.mo.SysRole;

@Controller  
@RequestMapping("/sys/role")
public class RoleController extends GeneralController{

	@SuppressWarnings("unused")
	private static final Logger log = LoggerFactory.getLogger(RoleController.class); 
	
	@Autowired
	private IRoleBiz roleBiz; 
	
	/**
	 * 显示角色列表
	 * @param sysRole
	 * @param model
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = "/list",method={RequestMethod.POST,RequestMethod.GET})
	public String list(String currWsId,String roleName,Model model,HttpServletRequest request) {
		SysRole sysRole = new SysRole();
		if(StringUtil.isBlank(currWsId)){ 
			currWsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		}
		sysRole.setWsId(currWsId);
		
		if (StringUtil.isNotBlank(roleName)) {	//按角色名称检索
			sysRole.setRoleName(roleName);
		}
		List<SysRole> sysRoleList = roleBiz.search(sysRole);
		model.addAttribute("sysRoleList", sysRoleList);
		return "sys/role/list";
	}
	
	/**
	 * 编辑角色
	 * @param roleFlow
	 * @param model
	 * @param request
	 * @return
	 */	
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public String edit(@RequestParam(value="roleFlow",required=false) String roleFlow,Model model,HttpServletRequest request) {
		if(StringUtil.isNotBlank(roleFlow)){
			SysRole sysRole = roleBiz.read(roleFlow);
			model.addAttribute("sysRole", sysRole);
		}
		SysRole sysRole = new SysRole();
		sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
		sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysRole> sysRoleList = roleBiz.search(sysRole);
		model.addAttribute("sysRoleList", sysRoleList);
		return "sys/role/edit";
	}
	
	/**
	 * 保存角色
	 * @param sysRole
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public String save(SysRole sysRole,Model model,HttpServletRequest request) throws Exception{		
		sysRole.setWsName(InitConfig.getWorkStationName(sysRole.getWsId()));
		if(StringUtil.isNotBlank(sysRole.getParentRoleFlow())){
			String parentRoleName = null;
			SysRole parentRole = InitConfig.getSysRole(sysRole.getParentRoleFlow());
			if(parentRole!=null){
				parentRoleName = parentRole.getRoleName();
			}
			sysRole.setParentRoleName(parentRoleName);
		}
		sysRole.setRoleLevelName(RoleLevelEnum.getNameById(sysRole.getRoleLevelId()));
		if(StringUtil.isNotBlank(sysRole.getRegPageId())){
			if(GlobalConstant.EDU_WS_ID.equals(getSessionAttribute(GlobalConstant.CURRENT_WS_ID))){  
				sysRole.setRegPageName(UserPageEnum.getNameById(sysRole.getRegPageId()));
			}else if (GlobalConstant.NJMUEDU_WS_ID.equals(getSessionAttribute(GlobalConstant.CURRENT_WS_ID))){
				sysRole.setRegPageName(NjmuUserPageEnum.getNameById(sysRole.getRegPageId()));
			}else {
				sysRole.setRegPageName(RegPageEnum.getNameById(sysRole.getRegPageId()));
			}
		}
		if(GlobalConstant.FLAG_N.equals(sysRole.getAllowRegFlag())){
			sysRole.setRegPageId("");
			sysRole.setRegPageName("");
		}
		roleBiz.save(sysRole);
		InitConfig._loadRole(request.getServletContext());
		return GlobalConstant.SAVE_SUCCESSED;
		
	}

	
	/**
	 * 保存角色排序码
	 * @param sysRole
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveOrder",method=RequestMethod.POST)
	@ResponseBody
	public String saveOrder(String [] roleFlow,Model model,HttpServletRequest request) throws Exception{
		roleBiz.saveOrder(roleFlow);
		InitConfig._loadRole(request.getServletContext());
		return GlobalConstant.SAVE_SUCCESSED;
		
	}
	
	/**
	 * 删除角色
	 * @param roleFlow
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/delete",method=RequestMethod.GET) 
	@ResponseBody
	public String delete(@RequestParam(value="roleFlow",required=true) String roleFlow,@RequestParam(value="recordStatus",required=true) String recordStatus) {
		roleBiz.delete(roleFlow,recordStatus);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	/**
	 * 显示角色所拥有的功能
	 * @param roleFlow
	 * @param wsId
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/getpop",method=RequestMethod.GET)
	public String getpop(@RequestParam(value="roleFlow",required=true) String roleFlow,
						 @RequestParam(value="wsId",required=true) String wsId,Model model) {
		SysRole sysRole = roleBiz.read(roleFlow);
		model.addAttribute("sysRole", sysRole);
		model.addAttribute("workStation", InitConfig.getWorkStation(wsId));
		List<String> menuIds = roleBiz.getPopedom(roleFlow);
		model.addAttribute("menuIds", menuIds);	
		return "sys/role/popedom";
	}
	
	/**
	 * 保存角色对应的功能
	 * @param sysRole
	 * @param menuIds
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/savepop",method=RequestMethod.POST)
	@ResponseBody
	public String savepop(SysRole sysRole,@RequestParam(value="menuId",required=false) String [] menuIds,Model model) {
		roleBiz.savePop(sysRole, menuIds);
		return GlobalConstant.SAVE_SUCCESSED;
	}

}
