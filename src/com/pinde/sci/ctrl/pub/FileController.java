package com.pinde.sci.ctrl.pub;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.srm.ISrmAchFileBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.util.P2FConst;

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
	@RequestMapping(value = {"/swfview" }, method = RequestMethod.GET)
	public String swfview(String projFlow,String fileFlow,Model model) throws Exception{
		PubFile file = pubFileBiz.readFile(fileFlow);
		String fileName = file.getFileName();
		fileName = URLEncoder.encode(fileName, "UTF-8");
		
		String dir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir")) + 
				File.separator + "swfFile" + File.separator + projFlow;
		File fileDir = new File(dir);
		if (!fileDir.exists()) {
            fileDir.mkdirs();
        }
		String oriFileName = fileFlow+"."+file.getFileSuffix();
		String oriFileDri = dir+File.separator+ oriFileName;
		
		
		String swfFileName = oriFileName +".swf";
		String swfFileDri =  dir+File.separator+ swfFileName;
		
		boolean convertFlag = false;
		File swfFile = new File( swfFileDri);
		
	
		
		boolean isImgFile = false;
		String suffixs = "jpg/jpeg/png/bmp/gif";
		if(suffixs.toLowerCase().indexOf(file.getFileSuffix().toLowerCase())>-1){
			isImgFile = true;
		}
	
		if(!isImgFile){
			if(!swfFile.exists()){
				//Éú³Éfile
				byte[] data =  file.getFileContent();
				
			    FileOutputStream outputStream = new FileOutputStream(oriFileDri);
			    if (data != null) {
			    	outputStream.write(data); 
			    }
			    outputStream.flush();  
			    outputStream.close();  
			    try
				{
			    	//ComThread.InitSTA();
			    	ComThread.InitMTA(true);
			    	
					ActiveXComponent p2f = new ActiveXComponent("Print2Flash4.Server"); 
					// Setup interface and protection options
					ActiveXComponent defProfile = new ActiveXComponent(p2f.getProperty("DefaultProfile").toDispatch());
					defProfile.setProperty("InterfaceOptions", P2FConst.INTDRAG | 
							P2FConst.INTZOOMSLIDER | P2FConst.INTZOOMBOX | P2FConst.INTFITWIDTH |
							P2FConst.INTFITPAGE | P2FConst.INTPREVPAGE | P2FConst.INTGOTOPAGE|
							P2FConst.INTNEXTPAGE | P2FConst.INTSEARCHBOX | P2FConst.INTSEARCHBUT|
							P2FConst.INTROTATE | P2FConst.INTPRINT | P2FConst.INTNEWWIND|
							P2FConst.INTBACKBUTTON | P2FConst.INTBACKBUTTONAUTO|
							P2FConst.INTFORWARDBUTTON | P2FConst.INTFORWARDBUTTONAUTO );
					defProfile.setProperty("ProtectionOptions", P2FConst.PROTDISPRINT | P2FConst.PROTENAPI);
					defProfile.setProperty("DocumentType", P2FConst.FLASH | P2FConst.HTML5);
					
					// Convert document
					p2f.invoke("ConvertFile", oriFileDri);
					logger.info("Conversion completed successfully  =="+oriFileDri );
					convertFlag = true;
					
					 System.err.println("Got here2==========="+ComThread.class); 
					
				}catch (Exception e){
					logger.info("An error occurred at conversion: "+e.toString());
				}
				finally {
					ComThread.Release();
				}
			}else {
				convertFlag = true;
			}
		}
		if(convertFlag){
			String swfFileUrl = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_url")) + 
					File.separator + "swfFile" + File.separator + projFlow+File.separator +swfFileName;
			model.addAttribute("url", swfFileUrl);
		}else {
			String imgFileUrl = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_url")) + 
					File.separator + "swfFile" + File.separator + projFlow+File.separator +oriFileName;
			model.addAttribute("url", imgFileUrl);
		}
		model.addAttribute("file", file);
		model.addAttribute("convertFlag", convertFlag);
		return "pub/file/swfview";
	}
	
}
