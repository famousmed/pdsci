package com.pinde.sci.ctrl.erp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpOaLicKeyBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.model.mo.ErpOaLicKey;

@Controller
@RequestMapping("erp/lic")
public class LicKeyController extends GeneralController{
   
	@Autowired
	private IErpOaLicKeyBiz erpOaLicKeyBiz;
	
	@RequestMapping(value="/auditBill")
	public String edit(String licFlow,Model model){
		if(StringUtil.isNotBlank(licFlow)){
			ErpOaLicKey erpOaLicKey=this.erpOaLicKeyBiz.readLicKey(licFlow);
			model.addAttribute("lic", erpOaLicKey);
		}
		return "erp/lic/edit";
	}
}
