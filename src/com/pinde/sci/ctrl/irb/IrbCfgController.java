package com.pinde.sci.ctrl.irb;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbCfgBiz;
import com.pinde.sci.biz.irb.IIrbInfoBiz;
import com.pinde.sci.biz.irb.IIrbInfoUserBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.sys.RoleLevelEnum;
import com.pinde.sci.form.sys.SysUserForm;
import com.pinde.sci.model.irb.ApplyFileTemp;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbInfoUser;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/irb/cfg")
public class IrbCfgController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(IrbCfgController.class);
	@Autowired
	private IIrbInfoBiz irbInfoBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IIrbInfoUserBiz irbInfoUserBiz;
	@Autowired
	private IIrbCfgBiz irbCfgBiz ;
	/**
	 * 显示伦理委员会主界面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/info")
	public String info(Model model,String recordFlow,String desction){
		IrbInfo info = new IrbInfo();
		info.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<IrbInfo> infoList = this.irbInfoBiz.queryInfo(info);
		IrbInfo findInfo = null;
		if(StringUtil.isEmpty(recordFlow)||StringUtil.isBlank(recordFlow)){
			if(infoList!=null&&!infoList.isEmpty()){
				findInfo = infoList.get(0);
				recordFlow = findInfo.getRecordFlow();
			}
		}else{
			findInfo = this.irbInfoBiz.queryInfo(recordFlow);
		}
		IrbInfoUser user = new IrbInfoUser();
		user.setIrbInfoFlow(recordFlow);
		user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<IrbInfoUser> userList = this.irbInfoUserBiz.queryUserList(user); 
		Map<String, SysUser> sysUserMap = new LinkedHashMap<String, SysUser>();
		List<IrbInfoUser> filterList = new ArrayList<IrbInfoUser>();//过滤一个用户多个角色
		SysUser sysUser = null;
		for (IrbInfoUser irbUser : userList) {
			sysUser = this.userBiz.readSysUser(irbUser.getUserFlow());
			sysUserMap.put(irbUser.getRecordFlow(), sysUser);
			boolean canAdd = false;
			/*过滤一个用户多个角色*/
			for (IrbInfoUser filterUser : filterList) {
				if(irbUser.getUserFlow().equals(filterUser.getUserFlow())&&irbUser.getIrbInfoFlow().equals(filterUser.getIrbInfoFlow())){
					filterUser.setRoleName(filterUser.getRoleName()+"，"+irbUser.getRoleName());
					canAdd = false;
					break;
				}else{
					canAdd = true;
				}
			}
			if(filterList.isEmpty()||canAdd){
				filterList.add(irbUser);
			}
		}
		model.addAttribute("infoList", infoList);
		model.addAttribute("findInfo", findInfo);
		model.addAttribute("userList", filterList);
		model.addAttribute("sysUserMap", sysUserMap);
		if(GlobalConstant.FLAG_Y.equals(desction)){//传达决定里的伦理委员会成员页面
			return "irb/secretary/decision/irbMemberList";
		}
		if(GlobalConstant.FLAG_N.equals(desction)){//年度工作报告伦理委员会成员页面
			return "irb/statistics/irbMemberList";
		}
		return "irb/cfg/info";
	}
	/**
	 * 显示伦理委员会编辑
	 * @return
	 */
	@RequestMapping(value="/showEdit")
	public String showEdit(String recordFlow,Model model){
		if(StringUtil.isNotBlank(recordFlow)){
			IrbInfo info = this.irbInfoBiz.queryInfo(recordFlow);
			model.addAttribute("info", info);
		}
		return "irb/cfg/editInfo";
	}
	
	/**
	 * 新增或修改伦理委员会
	 * @param info
	 * @return
	 */
	@RequestMapping(value="/editInfo")
	@ResponseBody
	public String editInfo(IrbInfo info){
		if(info!=null){
			int editResult = this.irbInfoBiz.editInfo(info);
			if(editResult==1){
				IrbInfo search = new IrbInfo();
				search.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				List<IrbInfo> irbInfoList = irbInfoBiz.queryInfo(search);
				setSessionAttribute("irbInfoList", irbInfoList);
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	/**
	 * 显示添加成员界面
	 * @param recordFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showAddUser")
	public String showAddUser(String recordFlow,String deptFlow,String roleFlow,String userName,Model model){
		if(StringUtil.isNotBlank(recordFlow)){
			IrbInfo info = this.irbInfoBiz.queryInfo(recordFlow);
			model.addAttribute("info", info);
		}
		
		List<SysDept> depList = this.irbInfoBiz.queryIrbDept();//可选部门
		/*可选角色列表*/
		SysRole sysRole = new SysRole();
		sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
		sysRole.setRoleLevelId(RoleLevelEnum.SysLevel.getId());
		sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysRole> roleList = roleBiz.search(sysRole);
		/*可选用户*/
		if((StringUtil.isEmpty(roleFlow)||StringUtil.isBlank(roleFlow))&&roleList!=null&&!roleList.isEmpty()){
			roleFlow = roleList.get(0).getRoleFlow();
		}
		SysUserForm form = new SysUserForm();
		form.setIrbInfoFlow(recordFlow);
		form.setRoleFlow(roleFlow);
		SysUser sysUser = new SysUser();
		sysUser.setDeptFlow(deptFlow);
		if(StringUtil.isNotBlank(userName)){
			sysUser.setUserName("%"+userName+"%");
		}
		form.setUser(sysUser);
		List<SysUser> userList = this.irbInfoBiz.queryIrbUser(form);
		
		model.addAttribute("userList", userList);
		model.addAttribute("depList", depList);
		model.addAttribute("roleList", roleList);
		return "irb/cfg/addUser";
	}
	
	/**
	 * 保存成员
	 * @param userFlows
	 * @param recordFlow
	 * @param roleFlow
	 * @return
	 */
	@RequestMapping(value="/saveUsers")
	@ResponseBody
	public String saveUsers(String[]userFlows,String recordFlow,String roleFlow){
		if(userFlows!=null&&userFlows.length>0&&StringUtil.isNotBlank(recordFlow)&&StringUtil.isNotBlank(roleFlow)){
			List<IrbInfoUser> users = new ArrayList<IrbInfoUser>();
			IrbInfoUser user = null;
			for (String userFlow : userFlows) {
				user = new IrbInfoUser();
				SysUser findUser = this.userBiz.readSysUser(userFlow);
				/*用户相关*/
				user.setUserFlow(userFlow);
				user.setUserName(findUser.getUserName());
				/*角色相关*/
				user.setRoleFlow(roleFlow);
				String roleName = null;
				SysRole sysRole = InitConfig.getSysRole(roleFlow);
				if(sysRole!=null){
					roleName = sysRole.getRoleName();
				}
				user.setRoleName(roleName);
				/*伦理委员会相关*/
				user.setIrbInfoFlow(recordFlow);
				users.add(user);
			}
			this.irbInfoUserBiz.editUsers(users);
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	@RequestMapping(value="/editUser")
	@ResponseBody
	public String editUser(IrbInfoUser user){
		if(user!=null){
		  int result = this.irbInfoUserBiz.edit(user);
		  if(result==GlobalConstant.ONE_LINE){
			  return GlobalConstant.OPRE_SUCCESSED;
		  }
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 显示一个用户的所有伦理职务
	 * @param userFlow
	 * @param irbInfoFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/showAllRoleUser")
	public String showAllRoleUser(String userFlow,String irbInfoFlow,Model model){
		IrbInfoUser user = new IrbInfoUser();
		user.setIrbInfoFlow(irbInfoFlow);
		user.setUserFlow(userFlow);
		user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<IrbInfoUser> userList = this.irbInfoUserBiz.queryUserList(user);
		model.addAttribute("userList", userList);
		return "irb/cfg/allRoleUser";
	}
	/**
	 * 显示送审文件清单界面
	 * @return
	 */
	@RequestMapping(value="/applyFile")
	public String showApplyFile(ApplyFileTemp applyFile,Model model) throws Exception{
		if(applyFile==null){
			applyFile = new ApplyFileTemp();
		}
		if(StringUtil.isEmpty(applyFile.getIrbType())||StringUtil.isBlank(applyFile.getIrbType())){
			applyFile.setIrbType(IrbTypeEnum.Init.getId());
		}
		if(!IrbTypeEnum.Init.getId().equals(applyFile.getIrbType())){//非初审
			applyFile.setPjType(null);
		}else if(StringUtil.isEmpty(applyFile.getPjType())||StringUtil.isBlank(applyFile.getPjType())){
			applyFile.setPjType(ProjCategroyEnum.Yw.getId());
		}
		List<ApplyFileTemp> list = this.irbCfgBiz.queryApplyFileList(applyFile);
		model.addAttribute("list", list);
		return "irb/cfg/applyFile";
	}
	/**
	 * 显示送审文件清单编辑
	 * @return
	 */
	@RequestMapping(value="/applyFileEdit")
	public String showApplyFileEdit(ApplyFileTemp applyFile,Model model) throws Exception{
		if(applyFile!=null&&StringUtil.isNotBlank(applyFile.getId())){
			if(!IrbTypeEnum.Init.getId().equals(applyFile.getIrbType())){//非初审
				applyFile.setPjType(null);
				}
			ApplyFileTemp findApplyFile = this.irbCfgBiz.queryApplyFile(applyFile);
			model.addAttribute("findApplyFile", findApplyFile);
		}
		return "irb/cfg/applyFileEdit";
	}
	
	/**
	 * 保存送审文件清单
	 * @param applyFile
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editApplyFile")
	@ResponseBody
	public String editApplyFile(ApplyFileTemp applyFile) throws Exception{
		if(applyFile!=null){
			int saveResult =  this.irbCfgBiz.saveApplyFile(applyFile);
			if(saveResult== GlobalConstant.ONE_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 修改或删除送审文件清单
	 * @param applyFile
	 * @param opera
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/operaApplyFile")
	@ResponseBody
	public String operaApplyFile(ApplyFileTemp applyFile,String opera) throws Exception{
		if(applyFile!=null&&StringUtil.isNotBlank(applyFile.getId())){
			if(!IrbTypeEnum.Init.getId().equals(applyFile.getIrbType())){//非初审
				applyFile.setPjType(null);
			}
			int operaResult = this.irbCfgBiz.operaApplyFile(applyFile, opera);
			if(operaResult== GlobalConstant.ONE_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 保存排序码
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveIrbInfoUserOrder",method=RequestMethod.POST)
	@ResponseBody
	public String saveIrbInfoUserOrder(String [] userFlow,String irbInfoFlow,Model model,HttpServletRequest request) throws Exception{
		irbInfoUserBiz.saveOrder(userFlow,irbInfoFlow);
		return GlobalConstant.SAVE_SUCCESSED;
		
	}
	
}
