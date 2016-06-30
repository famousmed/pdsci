package com.pinde.sci.ctrl.inx;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.sci.common.GeneralController;
import com.pinde.sci.model.mo.InxColumn;
/**
 * 
 * @author tiger
 *
 */

@Controller
public class InxController extends GeneralController{
	
	@RequestMapping(value="/inx/jsatcm",method={RequestMethod.GET})
	public String zxyyy( Model model){
		return "inx/jsatcm/index";
	}
	@RequestMapping(value="/inx/nydefy",method={RequestMethod.GET})
	public String nydefy( Model model){
		return "inx/nydefy/index";
	}
	@RequestMapping(value="/inx/ctfh",method={RequestMethod.GET})
	public String ctfh( Model model){
		return "inx/ctfh/index";
	}
}
