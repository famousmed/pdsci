package com.pinde.sci.biz.jsres;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.form.jsres.JsResDoctorInfoForm;
import com.pinde.sci.form.jsres.UserResumeExtInfoForm;
import com.pinde.sci.model.jsres.JsResDoctorExt;

/**
 * @author tiger
 *
 */
public interface IJsResDoctorBiz {

	/**
	 * 保存个人信息
	 * @param doctorInfoForm
	 * @return
	 */
	int saveDoctorInfo(JsResDoctorInfoForm doctorInfoForm);
	/**
	 * 检查上传图片的类型及大小
	 * @param uploadFile
	 * @return
	 */
	String checkImg(MultipartFile uploadFile);
	
	/**
	 * 保存文件至指定的目录
	 * @param oldFolderName
	 * @param file
	 * @param folderName
	 * @return
	 */
	String saveFileToDirs(String oldFolderName, MultipartFile file, String folderName);


}
