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
     * �����ļ� 
     * @param file 
     * @return 
     */  
    private boolean saveFile(MultipartFile file , HttpServletRequest request) {  
        // �ж��ļ��Ƿ�Ϊ��  
        if (!file.isEmpty()) {  
            try {  
                // �ļ�����·��  
                String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/"  
                        + file.getOriginalFilename();  
                // ת���ļ�  
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
        //�ж�file���鲻��Ϊ�ղ��ҳ��ȴ���0  
        if(files!=null&&files.length>0){  
            //ѭ����ȡfile�����е��ļ�  
            for(int i = 0;i<files.length;i++){  
                MultipartFile file = files[i];  
                //�����ļ�  
                saveFile(file , request);  
            }  
        }  
        // �ض���  
        return "redirect:/pub/fileUpload/showFileUploadUI";  
    }  
    
    @RequestMapping("/showFileUploadUI")
    public String showUploadUI(){
    	return "sample/fileUpload";
    }

}
