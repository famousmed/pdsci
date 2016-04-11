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
public class InxJsszyyxhzxController extends GeneralController{
	
	@RequestMapping(value="/inx/jsszyyxhzx",method={RequestMethod.GET})
	public String queryAllData(InxColumn column, Model model){
		return "inx/jsszyyxhzx/index";
	}
		
}
