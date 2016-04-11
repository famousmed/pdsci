package com.pinde.sci.ctrl.edc;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.SessionData;
import com.pinde.sci.common.util.LoginUtil;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.sys.OperTypeEnum;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;

@Controller
@RequestMapping("/enso")
public class EnSoAuthController extends GeneralController{   
	
	private static Logger logger = LoggerFactory.getLogger(EnSoAuthController.class);
	private static String doctorRole = "e077662c58d24b2daa2e7d0a0fb5be7a";
	
	@Autowired
	private SysUserMapper userMapper; 
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IProjUserBiz projUserBiz;	
	
	
	@RequestMapping(value={"/oauth/{sessionid}"},method={RequestMethod.GET})
	public String ensoAuth(@PathVariable String sessionid,Model model,HttpServletRequest request){
		model.addAttribute("sessionid", sessionid);
		return "inx/enso/login";
	}
	
	//已查看模块分类型显示
	@RequestMapping(value={"/oauth/login/{sessionid}"},method={RequestMethod.GET})
	public String login(@PathVariable String sessionid,Model model,HttpServletRequest request){
		logger.debug("sessionid==="+sessionid);
		String url = "http://www.enso.net.cn/checklogin/"+sessionid+"/c6289c8201b745df94436abdee882c2c";
		String response =
				//"{'success' : true,'user' :{'userid':'1234567890','username':'enso','realname':'恩索测试','mobile':'15252452508'}}";
			//{"success":false,"msg":认证失败,"user":{}}
				_get(url);
		logger.debug("response ==="+response);
		Map responseMap = JSON.parseObject(response, Map.class);
		boolean success = (Boolean) responseMap.get("success");
//		JSONArray array =  (JSONArray) responseMap.get("userlist");
		if(success){
			JSONObject user = (JSONObject) responseMap.get("user");
			String userid  = user.getString("userid");
			String username = user.getString("username");
			String realname = user.getString("realname");
			String gender = user.getString("gender");
			String identitycode =user.getString("identitycode");
			String mobile = (String) user.getString("mobile");
			String email = (String) user.getString("email");
			
			//获取用户信息
			SysUser sysUser = new SysUser();
			sysUser.setUserFlow(userid);
			sysUser.setUserCode(username);
			sysUser.setUserPasswd(PasswordHelper.encryptPassword(userid, "123456")); 
			sysUser.setUserName(realname);
			sysUser.setUserPhone(mobile);
			sysUser.setUserEmail(email);
			sysUser.setIdNo(identitycode);
			sysUser.setStatusId(UserStatusEnum.Activated.getId());
			sysUser.setStatusDesc(UserStatusEnum.Activated.getName());
			
			if(userMapper.selectByPrimaryKey(userid)!=null){
				GeneralMethod.setRecordInfo(sysUser, false);
				userMapper.updateByPrimaryKeySelective(sysUser);
			}else {
				GeneralMethod.setRecordInfo(sysUser, true);
				userMapper.insertSelective(sysUser);
				
				//add role
				SysUserRole role = new SysUserRole();
				role.setUserFlow(sysUser.getUserFlow());
				role.setRoleFlow(doctorRole);
				role.setWsId("edc");
				role.setAuthTime(DateUtil.getCurrDateTime());
				role.setAuthUserFlow("enso");
				userRoleBiz.saveSysUserRole(role);
			}
				
			if(!GlobalConstant.ROOT_USER_CODE.equals(sysUser.getUserCode())){
				if(UserStatusEnum.Locked.getId().equals(sysUser.getStatusId())){
					model.addAttribute("authFailNote", "用户被锁定");
					return "inx/enso/authFail";
				}
			}
			
			//设置当前用户
			setSessionAttribute(GlobalConstant.CURRENT_USER, sysUser);
			
			//加载系统权限
			LoginUtil.loadSysRole(sysUser.getUserFlow(), userRoleBiz, roleBiz);
			//加载EDC项目权限
			LoginUtil.loadEDCProjRole(sysUser.getUserFlow(), null, projUserBiz, roleBiz);
			List<String> currUserWorkStationIdList = (List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WORKSTATION_ID_LIST);
			if (currUserWorkStationIdList != null && currUserWorkStationIdList.size() > 0) {
				//在线用户功能使用
				SessionData sessionData = new SessionData();
				sessionData.setSysUser(sysUser);
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
			}else {
				model.addAttribute("authFailNote", "用户未赋权");
				return "inx/enso/authFail";
			}
			return "redirect:/main?time="+new Date();
		}else {
			model.addAttribute("authFailNote", "认证失败");
			return "inx/enso/authFail";
		}
	}
	
	private static String _get(String url){
		HttpClient httpClient = new HttpClient();
		GetMethod request = new GetMethod(url); 
		HttpMethodParams param = request.getParams();
		param.setContentCharset("UTF-8");  
		
		StringBuffer buf = new StringBuffer();
		BufferedReader in = null;
		try {
			httpClient.executeMethod(request);  
			InputStream stream = request.getResponseBodyAsStream();  
			in = new BufferedReader(new InputStreamReader(stream, "UTF-8")); 
			String line;  
			while (null != (line = in.readLine())) {  
				buf.append(line).append("\n");  
			}  
			request.releaseConnection();
		} catch (Exception e) {
			e.printStackTrace();
			if (in != null) {  
				try {  
					in.close();  
				} catch (Exception e1) {  
//					e1.printStackTrace();  
				}  
			}  
		}   

		String result = buf.toString();  
		return result;  

	}
}

