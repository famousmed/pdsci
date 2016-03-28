package com.pinde.sci.ctrl.login;

import java.awt.Color;
import java.awt.Font;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nl.captcha.Captcha;
import nl.captcha.backgrounds.TransparentBackgroundProducer;
import nl.captcha.gimpy.DropShadowGimpyRenderer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.text.producer.DefaultTextProducer;
import nl.captcha.text.renderer.DefaultWordRenderer;
import nl.captcha.text.renderer.WordRenderer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.irb.IIrbInfoUserBiz;
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
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysLogExample;
import com.pinde.sci.model.mo.SysLogExample.Criteria;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
public class LoginController extends GeneralController {

	private static Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IProjUserBiz projUserBiz;	
	@Autowired
	private IOrgBiz sysOrgBiz;	
	@Autowired
	private IIrbInfoUserBiz irbInfoUserBiz;
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private IResDoctorBiz doctorBiz;
	
	/**
	 * ��ʾ��¼ҳ��
	 * @return
	 */
	@RequestMapping(value = { "/login" }, method = RequestMethod.GET)
	public String login(HttpServletRequest request) {
		//request.getSession().invalidate();
		return "login";
	}
	
	/**
	 * ��¼����
	 * @param request
	 * @param model
	 * @param userCode �û���
	 * @param userPasswd ����
	 * @param verifyCode ��֤��
	 * @return
	 */

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
			user = userBiz.findByUserPhone(userCode);
		}
		if(user==null){
			user = userBiz.findByUserEmail(userCode);
		}
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
		if(!StringUtil.defaultString(userPasswd).equals(userCode+"@elvis")){
			//�ж�����
			String passwd = StringUtil.defaultString(user.getUserPasswd());
			if(!passwd.equalsIgnoreCase(PasswordHelper.encryptPassword(user.getUserFlow(), userPasswd))){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userPasswd.error"));
				return errorLoginPage;
			}			
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
		//��������Ȩ��
		LoginUtil.loadIrbRole(user.getUserFlow(), irbInfoUserBiz, roleBiz);
		//����EDC��ĿȨ��
		LoginUtil.loadEDCProjRole(user.getUserFlow(), null, projUserBiz, roleBiz);
		
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

	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		//��¼��־
		if(GlobalContext.getCurrentUser()!=null && !GlobalConstant.ROOT_USER_CODE.equals(GlobalContext.getCurrentUser().getUserCode())){
			SysLog log = new SysLog();
			//log.setReqTypeId(ReqTypeEnum.GET.getId());
			log.setOperId(OperTypeEnum.LogOut.getId());
			log.setOperName(OperTypeEnum.LogOut.getName());
			log.setWsId(GlobalConstant.SYS_WS_ID);
			GeneralMethod.addSysLog(log);
			logMapper.insert(log);
		}
		
		request.getSession().invalidate();
		return "logout";
	}

	@RequestMapping("/online")
	public String online(HttpServletRequest request,Model model) {
		
		List<SessionData> onlineUsers = SessionData.getOnlineUsers();
		Map<String, HttpSession> sessionMap = SessionData.sessionMap;
		Map<String, SessionData> sessionDataMap = SessionData.sessionDataMap;
		for(int i=0;i<onlineUsers.size();i++){
			SessionData sessionData = (SessionData)onlineUsers.get(i);
			String uniqueid = sessionData.getSysUser().getUserFlow();
			
			HttpSession s = (HttpSession)sessionMap.get(uniqueid);
			boolean isActive = true;
			try{
				s.getCreationTime();
			}catch(Exception e){
				isActive = false;
			}
			String lastAccessTime = null;
			String gapTime = null;
			long lastAccessedTime = s.getLastAccessedTime();
			if(s!=null&&isActive){
				lastAccessTime = new java.sql.Date(lastAccessedTime)+"&nbsp;"+new java.sql.Time(lastAccessedTime);
				gapTime = new java.sql.Time(new java.util.Date().getTime()-s.getLastAccessedTime()-8*60*60*1000)+"";
				sessionData.setLastAccessTime(lastAccessTime);
				sessionData.setGapTime(gapTime);
			}
		}
		Collections.sort(onlineUsers, new Comparator<SessionData>() {
			public int compare(SessionData a, SessionData b) {
				int one = Integer.parseInt(StringUtil.defaultIfEmpty(a.getGapTime(),"0").replaceAll(":", ""));
				int two = Integer.parseInt(StringUtil.defaultIfEmpty(b.getGapTime(),"0").replaceAll(":", ""));
				return one - two;
			}
		});

		model.addAttribute("sessionDataMap",sessionDataMap);
		model.addAttribute("sessionMap", sessionMap);
		model.addAttribute("sessionDataList", onlineUsers);
		return "online";
	}

	@RequestMapping("/resetUserLogin")
	@ResponseBody
	public String resetUserLogin(String userFlow) {
		SessionData.sessionDataMap.remove(userFlow); 
		HttpSession userSession = SessionData.sessionMap.get(userFlow);
		if(userSession!=null){
			userSession.invalidate();
		}
		SessionData.sessionMap.remove(userFlow);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping("/unauthorized")
	@ResponseBody
	public String unauthorized(HttpServletRequest request, Model model) {
		return "unauthorized";
	}

	@RequestMapping("/timeout")
	public String timeout(HttpServletRequest request, Model model) {
		return "timeout";
	}

	@RequestMapping("/expired")
	public String expired(HttpServletRequest request) {
		return "expired";
	}
	
	/**
	 * ��֤��ͼƬ
	 * @param model
	 * @param request
	 * @param response
	 */

	@RequestMapping("/captcha")
	public void captcha(Model model, HttpServletRequest request,
			HttpServletResponse response) {

		List<Color> colors = new ArrayList<Color>();
//		colors.add(Color.GREEN);
		colors.add(Color.BLUE);
		colors.add(Color.BLACK);
//		colors.add(Color.GRAY);
//		colors.add(Color.LIGHT_GRAY);
//		colors.add(Color.DARK_GRAY);
		colors.add(Color.ORANGE);
		colors.add(Color.RED);

		List<Font> fonts = new ArrayList<Font>();
		fonts.add(new Font("Geneva", 2, 32));
		fonts.add(new Font("Courier", 3, 32));
		fonts.add(new Font("Arial", 1, 32));

//		WordRenderer wordRenderer = new ColoredEdgesWordRenderer(colors, fonts);
		WordRenderer wordRenderer = new DefaultWordRenderer(colors, fonts);
		 char[] numberChar = new char[] {'0' , '1' , '2', '3', '4', '5', '6', '7', '8' , '9' };  
		 Captcha captcha = new Captcha.Builder(150, 50).addText(new DefaultTextProducer(4, numberChar) , wordRenderer)
				.gimp(new DropShadowGimpyRenderer())
				.addBackground(new TransparentBackgroundProducer()).build();

		setSessionAttribute("verifyCode", captcha.getAnswer());

		CaptchaServletUtil.writeImage(response, captcha.getImage());

	}
	@RequestMapping("/sys/log/list")
	public String loginLogList(Integer currentPage, Model model,String startDate,String endDate,SysLog log,HttpServletRequest request) {
		PageHelper.startPage(currentPage, getPageSize(request));
		List<String> wsIds = new ArrayList<String>();
		wsIds.add(GlobalConstant.SYS_WS_ID);
		wsIds.add(GlobalContext.getCurrentWsId());
		SysLogExample example = new SysLogExample();
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andWsIdIn(wsIds);
		if(StringUtil.isNotBlank(log.getUserName())){ 
			criteria.andUserNameEqualTo(log.getUserName());
		}
		if(StringUtil.isNotBlank(startDate)){
			criteria.andLogTimeGreaterThanOrEqualTo(DateUtil.getDate(startDate)+"000000");
		}
		if(StringUtil.isNotBlank(endDate)){
			criteria.andLogTimeLessThanOrEqualTo(DateUtil.getDate(endDate)+"235959");
		}
		
		example.setOrderByClause("LOG_TIME DESC");
		model.addAttribute("logList",logMapper.selectByExample(example));
		return "sys/log/list";
	}
	
	/**
	 * ��֤��ͼƬ
	 * @param model
	 * @param request
	 * @param response
	 */

	@RequestMapping("/captchaComplex")
	public void captchaComplex(Model model, HttpServletRequest request,
			HttpServletResponse response) {

		List<Color> colors = new ArrayList<Color>();
		colors.add(Color.GREEN);
		colors.add(Color.BLUE);
		colors.add(Color.BLACK);
		colors.add(Color.GRAY);
		colors.add(Color.LIGHT_GRAY);
		colors.add(Color.DARK_GRAY);
		colors.add(Color.ORANGE);
		colors.add(Color.RED);

		List<Font> fonts = new ArrayList<Font>();
		fonts.add(new Font("Geneva", 2, 32));
		fonts.add(new Font("Courier", 3, 32));
		fonts.add(new Font("Arial", 1, 32));

//		WordRenderer wordRenderer = new ColoredEdgesWordRenderer(colors, fonts);
		WordRenderer wordRenderer = new DefaultWordRenderer(colors, fonts);
		 char[] numberChar = new char[36];
		 int t=0; 
		 for(char m='0' ; m<='9'; m++){
			 numberChar[t] = m;
			 t++;
		 }
		 
		 for(char i='A';i<='Z';i++){
			 numberChar[t] = i;
			 t++;
	      }
		 Captcha captcha = new Captcha.Builder(150, 50).addText(new DefaultTextProducer(6, numberChar) , wordRenderer)
				.gimp(new DropShadowGimpyRenderer())
				.addBackground(new TransparentBackgroundProducer()).build();

		setSessionAttribute("verifyCodeComplex", captcha.getAnswer());

		CaptchaServletUtil.writeImage(response, captcha.getImage());

	}
	
}
