package com.pinde.sci.ctrl.inx;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduUserBiz;
import com.pinde.sci.biz.inx.IInxEduBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
/**
 * 
 * @author tiger
 *
 */

@Controller
public class InxEduController extends GeneralController{
	
	private static Logger logger = LoggerFactory.getLogger(InxEduController.class);
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IInxEduBiz inxEduBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IEduUserBiz eduUserBiz;
 	
	@RequestMapping(value="/inx/edu",method={RequestMethod.GET})
	public String eduIndex(Model model){
		return "inx/edu/index";
	}
	
	/**
	 * ��ת��ע��
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/inx/edu/register",method={RequestMethod.GET})
	public String register(Model model){
		return "inx/edu/register";
	}
	
	/**
	 * ע��
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/inx/edu/register",method={RequestMethod.POST})
	@ResponseBody
	public String register(SysUser registerUser, String userPasswd2, String verifyCode, Model model){
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCode"));
		if (StringUtil.isBlank(verifyCode) || StringUtil.isBlank(sessionValidateCode) || !sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			return SpringUtil.getMessage("validateCode.notEquals");
		}
		//�Ƿ���ע��
		String userEmail = registerUser.getUserEmail();
		String userPasswd = registerUser.getUserPasswd();
		if(StringUtil.isNotBlank(userEmail) && StringUtil.isNotBlank(userPasswd)){
			SysUser user = userBiz.findByUserEmail(userEmail.trim());
			if(user != null){
				return GlobalConstant.USER_EMAIL_REPETE;
			}
			user = userBiz.findByUserCode(userEmail.trim());
			if(user != null){
				return GlobalConstant.USER_CODE_REPETE;
			}
			registerUser.setUserCode(userEmail.trim());//�û�����Ϊ����
			registerUser.setUserEmail(userEmail.trim());
			registerUser.setUserPasswd(userPasswd.trim());
			int result = inxEduBiz.registerUser(registerUser);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.USER_REG_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}	
	
	/**
	 * ��ת����¼
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/inx/edu/login",method={RequestMethod.GET})
	public String login(Model model){
		return "inx/edu/login";
	}
	
	/**
	 * ��¼
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/inx/edu/login",method={RequestMethod.POST})
	public String login(String userCode, String userPasswd, Model model){
		if(StringUtil.isNotBlank(userCode) && StringUtil.isNotBlank(userPasswd)){
			SysUser user = userBiz.findByUserCode(userCode.trim());
			if(user == null){
				user = userBiz.findByUserPhone(userCode.trim());
			}
			if(user == null){
				user = userBiz.findByUserEmail(userCode.trim());
			}
			if(user == null){
				model.addAttribute("message","�˺�/�������䲻���ڣ�");
				return "inx/edu/login";
			}else{
				String userFlow = user.getUserFlow();
				String enctyptPassword = PasswordHelper.encryptPassword(userFlow, userPasswd.trim());
				if(!user.getUserPasswd().equals(enctyptPassword)){
					model.addAttribute("message", "�˺Ż����벻��ȷ��");
					return "inx/edu/login";
				}else{
					//root�û����ж��Ƿ�����
					if(!GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
						if(UserStatusEnum.Locked.getId().equals(user.getStatusId())){
							model.addAttribute("message",SpringUtil.getMessage("userCode.locked"));
							return "inx/edu/login";
						}
						if(UserStatusEnum.Reged.getId().equals(user.getStatusId())){
							return userInfo(user.getUserFlow(), model);
						}
						if(UserStatusEnum.Added.getId().equals(user.getStatusId())){
							model.addAttribute("message",SpringUtil.getMessage("userCode.unActivated"));
							return "inx/edu/login";
						}
						if(!UserStatusEnum.Activated.getId().equals(user.getStatusId())){
							model.addAttribute("message",SpringUtil.getMessage("userCode.unActivated"));
							return "inx/edu/login";
						}
					}
					SysUserRole userRole = new SysUserRole();
					userRole.setUserFlow(userFlow);
					userRole.setWsId(GlobalConstant.EDU_WS_ID);
					List<SysUserRole> userRoleList = userRoleBiz.searchUserRole(userRole);
					List<String> roleFlowList=new ArrayList<String>();
					if(userRoleList != null && !userRoleList.isEmpty()){
					    for(SysUserRole sysUserRole:userRoleList){
					    	roleFlowList.add(sysUserRole.getRoleFlow());
					    }
					    GlobalContext.getSession().setAttribute(GlobalConstant.CURRENT_ROLE_LIST,roleFlowList);
						userRole = userRoleList.get(0);
						if(userRole != null){
							SysRole role = roleBiz.read(userRole.getRoleFlow());
							if(role != null){
								this.setSessionAttribute(GlobalConstant.CURRENT_USER, user);
								this.setSessionAttribute(GlobalConstant.CURRENT_VIEW, role.getRegPageId());
								EduUser eduUser = this.eduUserBiz.readEduUser(user.getUserFlow());
								this.setSessionAttribute(GlobalConstant.CURR_EDU_USER, eduUser);
								return "redirect:/"+ role.getRegPageId();
							}
						}
					}else{
						model.addAttribute("message","δ��Ȩ��¼��");
						return "inx/edu/login";
					}
				}
			}
		}
		return "inx/edu/login";
	}
	
	/**
	 * �˳�
	 * @param request
	 * @return
	 */
	@RequestMapping("/inx/edu/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "inx/edu/index";
	}
	
	/**
	 * ���伤���봦��
	 * @param activationCode
	 * @param model
	 * @return
	 */
	@RequestMapping("/inx/edu/completeUserInfo")
	public String completeUserInfo(String activationCode, Model model){
		if(StringUtil.isBlank(activationCode)){
			return "inx/edu/index";
		}else{
			SysUser sysUser = userBiz.readSysUser(activationCode);
			if(sysUser != null){
				//�Ѽ�����ת����ҳ
				if(UserStatusEnum.Activated.getId().equals(sysUser.getStatusId())){
					return "inx/edu/index";
				}
			    String disabledTime = DateUtil.addHour(sysUser.getCreateTime(), new Integer(InitConfig.getSysCfg("edu_effective_time")));
			    Date disabledTimeDate = DateUtil.parseDate(disabledTime, "yyyyMMddHHmmss");
			    String currTime = DateUtil.getCurrDateTime();
			    Date currTimeDate = DateUtil.parseDate(currTime, "yyyyMMddHHmmss");
				if(disabledTimeDate.after(currTimeDate)){
					model.addAttribute("sysUser", sysUser);
					//��ѯѧУ
					SysOrg sysOrg = new SysOrg();
					sysOrg.setOrgTypeId(OrgTypeEnum.University.getId());
					sysOrg.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
					List<SysOrg> orgList = orgBiz.searchOrg(sysOrg);
					model.addAttribute("orgList", orgList);
					
					EduUser eduUser = eduUserBiz.readEduUser(activationCode);
					model.addAttribute("eduUser", eduUser);
					
					return "inx/edu/completeUserInfo";
				}else{//������ʧЧ
					String userEmail =  sysUser.getUserEmail();
					model.addAttribute("userEmail", userEmail);
					sysUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
					userBiz.updateUser(sysUser);
					return "inx/edu/disableCode";
				}
			}
		}
		return "inx/edu/completeUserInfo";
	}
	
	/**
	 * ������������
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/inx/edu/userInfo")
	public String userInfo(String userFlow, Model model){
		if(StringUtil.isNotBlank(userFlow)){
			SysUser sysUser = userBiz.readSysUser(userFlow);
			model.addAttribute("sysUser", sysUser);
			//��ѯѧУ
			SysOrg sysOrg = new SysOrg();
			sysOrg.setOrgTypeId(OrgTypeEnum.University.getId());
			sysOrg.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<SysOrg> orgList = orgBiz.searchOrg(sysOrg);
			model.addAttribute("orgList", orgList);
			
			EduUser eduUser = eduUserBiz.readEduUser(userFlow);
			model.addAttribute("eduUser", eduUser);
		}
		return "inx/edu/completeUserInfo";
	}
	
	/**
	 * �����ʼ�������
	 * @param userEmail ����
	 * @param reSend �Ƿ����·���
	 * @param model
	 * @return
	 */
	@RequestMapping("/inx/edu/sendEmail")
	public String sendEmailInfo(String userEmail,String reSend,Model model){
		if(StringUtil.isNotBlank(userEmail)){
			SysUser findUser = this.userBiz.findByUserEmail(userEmail);
			if(findUser!=null){
				this.inxEduBiz.sendEmail(userEmail, findUser.getUserFlow());
			}
			model.addAttribute("userEmail", userEmail);
			model.addAttribute("reSend", reSend);
		}
		return "redirect:/inx/edu/showEmailInfo";
	}
	@RequestMapping("/inx/edu/showEmailInfo")
	public String showEmailInfo(String userEmail,String reSend,Model model){
		model.addAttribute("userEmail", userEmail);
		model.addAttribute("reSend", reSend);
		return "inx/edu/sendEmail";
	}
	
	/**
	 * �����������
	 * @param sysUser
	 * @param eduUser
	 * @return
	 */
	@RequestMapping("/inx/edu/saveUserInfo")
	@ResponseBody
	public String saveUserInfo(SysUser sysUser, EduUser eduUser){
		String checkResult = checkIdNo(sysUser);
		if(checkResult != null){
			return checkResult;
		}
		int result = eduUserBiz.saveUserAndEduUser(sysUser, eduUser);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * ���������ύ���
	 * @param sysUser
	 * @param eduUser
	 * @return
	 */
	@RequestMapping("/inx/edu/submitUserInfo")
	@ResponseBody
	public String submitUserInfo(SysUser sysUser, EduUser eduUser){
		String checkResult = checkIdNo(sysUser);
		if(checkResult != null){
			return checkResult;
		}
		sysUser.setStatusId(UserStatusEnum.Reged.getId());
		sysUser.setStatusDesc(UserStatusEnum.Reged.getName());
		int result = eduUserBiz.saveUserAndEduUser(sysUser, eduUser);
		if(result != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}

	/**
	 * ���֤��Ψһ
	 * @param sysUser
	 */
	private String checkIdNo(SysUser sysUser) {
		String userFlow = sysUser.getUserFlow();
		String idNo = sysUser.getIdNo();
		if(StringUtil.isNotBlank(userFlow) && StringUtil.isNotBlank(idNo)){
			SysUser user = userBiz.findByIdNo(idNo.trim());
			if(user != null){
				if(!user.getUserFlow().equals(userFlow)){
					return GlobalConstant.USER_ID_NO_REPETE;
				}
			}
		}
		return null;
	}
	@RequestMapping("/inx/edu/disableCode")
	public String disableCode(){
		return "inx/edu/disableCode";
	}
}
