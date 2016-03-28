package com.pinde.sci.ctrl.sys;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.common.GeneralController;

@Controller
@RequestMapping("/weixin")
public class WeixinController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(WeixinController.class);
	
	@RequestMapping(value={"/receive"},method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String receive(String signature,String timestamp,String nonce,String echostr,String message,HttpServletRequest request,HttpServletResponse response,Model model){
		System.out.println("signature="+signature);
		System.out.println("timestamp="+timestamp);
		System.out.println("echostr="+echostr);
		System.out.println("nonce="+nonce);
		System.out.println("message="+message);
		if(StringUtil.isNotBlank(echostr)){
			return echostr;
		}
		return "";
	}
	
	@RequestMapping(value={"/getToken"},method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String getToken(HttpServletRequest request,HttpServletResponse response,Model model){
		return "";
	}
	
	@RequestMapping(value={"/send"},method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String send(HttpServletRequest request,HttpServletResponse response,Model model){
		return "";
	}
	
}

