package com.pinde.sci.ctrl.res;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.sci.common.GeneralController;
@Controller
@RequestMapping("/res/head")
public class ResHeadController extends GeneralController {
	private static Logger logger = LoggerFactory.getLogger(ResHeadController.class);
	
}
