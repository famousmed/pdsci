package com.pinde.sci.ctrl.sample;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.common.GeneralController;

@Controller
@RequestMapping("/pub/fileUpload")
public class FileUploadController extends GeneralController{

	/*** 
     * 保存文件 
     * @param file 
     * @return 
     */  
    private boolean saveFile(MultipartFile file , HttpServletRequest request) {  
        // 判断文件是否为空  
        if (!file.isEmpty()) {  
            try {  
                // 文件保存路径  
                String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/"  
                        + file.getOriginalFilename();  
                // 转存文件  
                file.transferTo(new File(filePath));  
                return true;  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
        return false;  
    }  
    
    @RequestMapping("/upload")  
    public String filesUpload(@RequestParam("files") MultipartFile[] files , HttpServletRequest request) {  
        //判断file数组不能为空并且长度大于0  
        if(files!=null&&files.length>0){  
            //循环获取file数组中得文件  
            for(int i = 0;i<files.length;i++){  
                MultipartFile file = files[i];  
                //保存文件  
                saveFile(file , request);  
            }  
        }  
        // 重定向  
        return "redirect:/pub/fileUpload/showFileUploadUI";  
    }  
    
    @RequestMapping("/showFileUploadUI")
    public String showUploadUI(){
    	return "sample/fileUpload";
    }

}
