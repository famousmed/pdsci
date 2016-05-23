package com.pinde.sci.ctrl.login;

import com.pinde.core.license.PdLicense;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysCfgMapper;
import com.pinde.sci.model.mo.SysCfg;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LicenseController extends GeneralController {

	private static Logger logger = LoggerFactory.getLogger(LicenseController.class);
	
	@Autowired
	private SysCfgMapper sysCfgMapper;
	
	/**
	 * 显示授权
	 * @return
	 */
	@RequestMapping(value = { "/license" }, method = RequestMethod.GET)
	public String license(HttpServletRequest request) {
		return "license";
	}
	
	/**
	 * 显示授权
	 * @return
	 */
	@RequestMapping(value = { "lic" }, method = RequestMethod.GET)
	public String lic(HttpServletRequest request) {
		return "lic";
	}
	
	/**
	 * 显示授权
	 * @return
	 */
	@RequestMapping(value = { "/lic/upload" }, method = RequestMethod.POST)
	@ResponseBody
	public String upload(MultipartFile licenseFile,HttpServletRequest request) {
		if(!"license.key".equals(licenseFile.getOriginalFilename())){
			return GlobalConstant.SAVE_FAIL+":文件名不对！";
		}
		String content = "";
		try {
			content = new String(licenseFile.getBytes(),"GBK");
			boolean check = PdLicense.checkLicense(content);
			if(check==false){
				return GlobalConstant.SAVE_FAIL+":不是有效的license.key！";
			}
		} catch (Exception e) {
			logger.error("license内容有误",e);
			return GlobalConstant.SAVE_FAIL+":不是有效的license.key！";
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
