package com.pinde.sci.ctrl.sys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.sys.ICfgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysCfgMapper;
import com.pinde.sci.model.mo.SysCfg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/sys/cfg")
public class CfgController extends GeneralController  {
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Resource
	private SysCfgMapper sysCfgMapper;
	@Autowired
	private ICfgBiz cfgBiz;
	@RequestMapping(value={"/main"})
	public String main(Model model){	
		return "sys/cfg/main";
	}
	
	@RequestMapping(value="/agreement",method={RequestMethod.GET})
	public ModelAndView agreement(HttpServletRequest request){
		String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		ModelAndView mav=new ModelAndView("sys/cfg/agreement");
		SysCfg cfg=new SysCfg();
		cfg.setWsId(wsId);
		List<SysCfg> sysCfgList=cfgBiz.search(cfg);
		Map<String, String> sysCfgMap=new HashMap<String, String>();
		for(SysCfg sysCfg:sysCfgList ){
			sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgValue());
			if(StringUtil.isNotBlank(sysCfg.getCfgBigValue())){
				sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgBigValue());				
			}
		}
		return mav.addObject("sysCfgMap",sysCfgMap);	
	}
	
	@RequestMapping(value="/edit",method={RequestMethod.GET})
	public ModelAndView edit(HttpServletRequest request){
		String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		ModelAndView mav=new ModelAndView("sys/cfg/"+wsId+"Cfg");
		SysCfg cfg=new SysCfg();
		cfg.setWsId(wsId);
		List<SysCfg> sysCfgList=cfgBiz.search(cfg);
		Map<String, String> sysCfgMap=new HashMap<String, String>();
		Map<String, String> sysCfgDescMap=new HashMap<String, String>();
		for(SysCfg sysCfg:sysCfgList ){
			if(StringUtil.isNotBlank(sysCfg.getCfgDesc())){
				sysCfgDescMap.put(sysCfg.getCfgCode(), sysCfg.getCfgDesc());
			}
			sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgValue());
			if(StringUtil.isNotBlank(sysCfg.getCfgBigValue())){
				sysCfgMap.put(sysCfg.getCfgCode(), sysCfg.getCfgBigValue());				
			}
		}
		mav.addObject("sysCfgDescMap",sysCfgDescMap);
		return mav.addObject("sysCfgMap",sysCfgMap);	
	}
	
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public String save(HttpServletRequest request){		
		String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		String [] cfgCodes =request.getParameterValues("cfgCode");
		if(cfgCodes!=null){
			List<SysCfg> sysCfgList = new ArrayList<SysCfg>();
			for(String cfgCode : cfgCodes){
				String sysCfgValue=request.getParameter(cfgCode);
				String sysCfgDesc=request.getParameter(cfgCode+"_desc");
				SysCfg cfg=new SysCfg();
				cfg.setCfgCode(cfgCode);
				cfg.setCfgValue(sysCfgValue);
				cfg.setCfgDesc(sysCfgDesc);
				String reqWsId = request.getParameter(cfgCode+"_ws_id");
				if(StringUtil.isBlank(reqWsId)){
					reqWsId = wsId;
				}
				cfg.setWsId(reqWsId);
				cfg.setWsName(InitConfig.getWorkStationName(cfg.getWsId()));
				if(StringUtil.isBlank(cfg.getWsName())){
					cfg.setWsName("全局公用配置");
				}

				String sysCfgBigValue=request.getParameter(cfgCode+"_big_value");
				cfg.setCfgBigValue(sysCfgBigValue);
				cfg.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				sysCfgList.add(cfg);
			}
			cfgBiz.save(sysCfgList);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value="/testEmail",method={RequestMethod.GET})
	public String testEmail(HttpServletRequest request){
		return "sys/cfg/tool/testEmail";
	}
	
	@RequestMapping(value="/sendEmail",method={RequestMethod.POST})
	@ResponseBody
	public String sendEmail(String receiver,String title,String content){
		msgBiz.addEmailMsg(receiver, title, content);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	@RequestMapping(value="/getErrorMsg",method={RequestMethod.GET})
	@ResponseBody
	public Integer getErrorMsg(String msgTypeId){
		return 	msgBiz.countErrorMsg(msgTypeId);
	}
	
	@RequestMapping(value={"/modMailPassword"})
	public String modMailPassword(Model model){	
		return "sys/user/modMailPasswd";
	}
	/**
	 * 保存需要审核的专业
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/saveTrainSpe"})
	@ResponseBody
	public String saveTrainSpe(Model model,String result,String cfgCode){
		SysCfg sysCfg=cfgBiz.read(cfgCode);
		if (sysCfg!=null) {
			sysCfg.setCfgBigValue(result);
		}
		List<SysCfg> saveCfgs=new ArrayList<SysCfg>();
		saveCfgs.add(sysCfg);
		cfgBiz.save(saveCfgs);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value={"/saveMailPassword"})
	public String saveMailPassword(String userFlow,String mailPassword,String weixinRemind){
		SysUser user = this.userBiz.readSysUser(userFlow);
		SysCfg cfg = cfgBiz.read(user.getUserEmail());
		if (cfg == null) {
			cfg = new SysCfg();
			cfg.setCfgCode(user.getUserEmail());
			cfg.setCfgValue(mailPassword);
			cfg.setWsId("mail");
			cfg.setCfgDesc("迈拓邮箱密码");
			GeneralMethod.setRecordInfo(cfg, true);
			cfg.setRecordStatus(weixinRemind);
			sysCfgMapper.insert(cfg);
		} else {
			cfg.setCfgValue(mailPassword);
			cfg.setCfgDesc("迈拓邮箱密码");
			GeneralMethod.setRecordInfo(cfg, false);
			cfg.setRecordStatus(weixinRemind);
			sysCfgMapper.updateByPrimaryKeySelective(cfg);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value={"/savePageSize"},method=RequestMethod.POST)
	@ResponseBody
	public String savePageSize(HttpServletRequest request){
		cfgBiz.savePageSize(request);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping(value="/spePage")
	public String spePage(Model model,String  trainCategoryType){
		model.addAttribute("trainCategoryType", trainCategoryType);
		return "sys/cfg/selectSpe";
	}
	@RequestMapping(value="/speMainPage")
	public String speMainPage(String cfgCode,Model model){
		model.addAttribute("cfgCode", cfgCode);
		return "sys/cfg/selectSpeMain";
	}
	
}
