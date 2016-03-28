package com.pinde.sci.ctrl.login;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysCfgMapper;
import com.pinde.sci.model.mo.SysCfg;

@Controller
public class LicenseController extends GeneralController {

	private static Logger logger = LoggerFactory.getLogger(LicenseController.class);
	
	@Resource
	private SysCfgMapper sysCfgMapper;
	
	/**
	 * 显示授权
	 * @return
	 */
	@RequestMapping(value = { "/license","lic" }, method = RequestMethod.GET)
	public String license(HttpServletRequest request) {
		return "license";
	}
	
	/**
	 * 显示授权
	 * @return
	 */
	@RequestMapping(value = { "/license/upload" }, method = RequestMethod.POST)
	@ResponseBody
	public String upload(MultipartFile licenseFile,HttpServletRequest request) {
		if(!"license.key".equals(licenseFile.getOriginalFilename())){
			return GlobalConstant.SAVE_FAIL;
		}
		String content = "";
		try {
			content = new String(licenseFile.getBytes(),"GBK");
		} catch (Exception e) {
			logger.error("license内容有误",e);
		} 
		SysCfg cfg = cfgBiz.read("license.key");
		if (cfg == null) {
			cfg = new SysCfg();
			cfg.setCfgCode("license.key");
			cfg.setCfgBigValue(content);
			cfg.setWsId("sys");
			cfg.setCfgDesc("授权文件");
			GeneralMethod.setRecordInfo(cfg, true);
			cfg.setRecordStatus("Y");
			sysCfgMapper.insert(cfg);
		} else {
			cfg.setCfgBigValue(content);
			cfg.setWsId("sys");
			cfg.setCfgDesc("授权文件");
			GeneralMethod.setRecordInfo(cfg, false);
			cfg.setRecordStatus("Y");
			sysCfgMapper.updateByPrimaryKeySelective(cfg);
		}
		InitConfig.refresh(request.getServletContext());
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
}
