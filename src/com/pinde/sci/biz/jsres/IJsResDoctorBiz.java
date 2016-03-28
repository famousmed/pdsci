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
	 * ���������Ϣ
	 * @param doctorInfoForm
	 * @return
	 */
	int saveDoctorInfo(JsResDoctorInfoForm doctorInfoForm);
	/**
	 * ����ϴ�ͼƬ�����ͼ���С
	 * @param uploadFile
	 * @return
	 */
	String checkImg(MultipartFile uploadFile);
	
	/**
	 * �����ļ���ָ����Ŀ¼
	 * @param oldFolderName
	 * @param file
	 * @param folderName
	 * @return
	 */
	String saveFileToDirs(String oldFolderName, MultipartFile file, String folderName);


}
