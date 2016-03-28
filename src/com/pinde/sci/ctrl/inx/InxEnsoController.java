package com.pinde.sci.ctrl.inx;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.sci.common.GeneralController;

@Controller
@RequestMapping("/inx/enso")
public class InxEnsoController extends GeneralController{
	
	@RequestMapping(value="",method={RequestMethod.GET})
	public String index(Model model){
		return "inx/enso/index";
	}
}
