package com.pinde.sci.ctrl.inx;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.sci.common.GeneralController;

@Controller
@RequestMapping("/inx/pharmasun")
public class InxPharmasunController extends GeneralController{
	
	@RequestMapping(value="",method={RequestMethod.GET})
	public String index(Model model){
		return "inx/pharmasun/index";
	}
	@RequestMapping(value="/ctms",method={RequestMethod.GET})
	public String ctms(Model model){
		return "inx/pharmasun/ctms";
	}
	@RequestMapping(value="/edc",method={RequestMethod.GET})
	public String edc(Model model){
		return "inx/pharmasun/edc";
	}
	@RequestMapping(value="/irb",method={RequestMethod.GET})
	public String irb(Model model){
		return "inx/pharmasun/irb";
	}
}
