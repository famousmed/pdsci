package com.pinde.sci.ctrl.pub;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.srm.ISrmAchFileBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.SrmAchFile;

@Controller
@RequestMapping("/pub/file")
public class FileController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(FileController.class);
	
	@Autowired
	private IFileBiz pubFileBiz; 
	@Autowired
	private ISrmAchFileBiz achFileBiz;
	
	
	@RequestMapping(value = {"/down" }, method = RequestMethod.GET)
	public void down (String fileFlow, final HttpServletResponse response) throws Exception{
		PubFile	file  =  pubFileBiz.readFile(fileFlow);
		pubFileBiz.down(file,response);
	}
	
	@RequestMapping(value = {"/achDown" }, method = RequestMethod.GET)
	public void achDown(String fileFlow, final HttpServletResponse response) throws Exception{
		SrmAchFile file = this.achFileBiz.readAchFile(fileFlow);
		pubFileBiz.down(file,response);
	}
	
	
	
}
