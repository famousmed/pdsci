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
	 * ��ʾ����ίԱ��������
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
		List<IrbInfoUser> filterList = new ArrayList<IrbInfoUser>();//����һ���û������ɫ
		SysUser sysUser = null;
		for (IrbInfoUser irbUser : userList) {
			sysUser = this.userBiz.readSysUser(irbUser.getUserFlow());
			sysUserMap.put(irbUser.getRecordFlow(), sysUser);
			boolean canAdd = false;
			/*����һ���û������ɫ*/
			for (IrbInfoUser filterUser : filterList) {
				if(irbUser.getUserFlow().equals(filterUser.getUserFlow())&&irbUser.getIrbInfoFlow().equals(filterUser.getIrbInfoFlow())){
					filterUser.setRoleName(filterUser.getRoleName()+"��"+irbUser.getRoleName());
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
		if(GlobalConstant.FLAG_Y.equals(desction)){//��������������ίԱ���Աҳ��
			return "irb/secretary/decision/irbMemberList";
		}
		if(GlobalConstant.FLAG_N.equals(desction)){//��ȹ�����������ίԱ���Աҳ��
			return "irb/statistics/irbMemberList";
		}
		return "irb/cfg/info";
	}
	/**
	 * ��ʾ����ίԱ��༭
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
	 * �������޸�����ίԱ��
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
	 * ��ʾ��ӳ�Ա����
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
		
		List<SysDept> depList = this.irbInfoBiz.queryIrbDept();//��ѡ����
		/*��ѡ��ɫ�б�*/
		SysRole sysRole = new SysRole();
		sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
		sysRole.setRoleLevelId(RoleLevelEnum.SysLevel.getId());
		sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysRole> roleList = roleBiz.search(sysRole);
		/*��ѡ�û�*/
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
	 * �����Ա
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
				/*�û����*/
				user.setUserFlow(userFlow);
				user.setUserName(findUser.getUserName());
				/*��ɫ���*/
				user.setRoleFlow(roleFlow);
				String roleName = null;
				SysRole sysRole = InitConfig.getSysRole(roleFlow);
				if(sysRole!=null){
					roleName = sysRole.getRoleName();
				}
				user.setRoleName(roleName);
				/*����ίԱ�����*/
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
	 * ��ʾһ���û�����������ְ��
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
	 * ��ʾ�����ļ��嵥����
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
		if(!IrbTypeEnum.Init.getId().equals(applyFile.getIrbType())){//�ǳ���
			applyFile.setPjType(null);
		}else if(StringUtil.isEmpty(applyFile.getPjType())||StringUtil.isBlank(applyFile.getPjType())){
			applyFile.setPjType(ProjCategroyEnum.Yw.getId());
		}
		List<ApplyFileTemp> list = this.irbCfgBiz.queryApplyFileList(applyFile);
		model.addAttribute("list", list);
		return "irb/cfg/applyFile";
	}
	/**
	 * ��ʾ�����ļ��嵥�༭
	 * @return
	 */
	@RequestMapping(value="/applyFileEdit")
	public String showApplyFileEdit(ApplyFileTemp applyFile,Model model) throws Exception{
		if(applyFile!=null&&StringUtil.isNotBlank(applyFile.getId())){
			if(!IrbTypeEnum.Init.getId().equals(applyFile.getIrbType())){//�ǳ���
				applyFile.setPjType(null);
				}
			ApplyFileTemp findApplyFile = this.irbCfgBiz.queryApplyFile(applyFile);
			model.addAttribute("findApplyFile", findApplyFile);
		}
		return "irb/cfg/applyFileEdit";
	}
	
	/**
	 * ���������ļ��嵥
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
	 * �޸Ļ�ɾ�������ļ��嵥
	 * @param applyFile
	 * @param opera
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/operaApplyFile")
	@ResponseBody
	public String operaApplyFile(ApplyFileTemp applyFile,String opera) throws Exception{
		if(applyFile!=null&&StringUtil.isNotBlank(applyFile.getId())){
			if(!IrbTypeEnum.Init.getId().equals(applyFile.getIrbType())){//�ǳ���
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
	 * ����������
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
