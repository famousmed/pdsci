package com.pinde.sci.biz.jsres.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.JaxbUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.jsres.IJsResDoctorBiz;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.jsres.JsResDoctorInfoForm;
import com.pinde.sci.form.jsres.UserResumeExtInfoForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;
@Service
@Transactional(rollbackFor=Exception.class)
public class JsResDoctorBizImpl implements IJsResDoctorBiz{

	@Autowired
	private IPubUserResumeBiz userResumeBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;

	@Override
	public int saveDoctorInfo(JsResDoctorInfoForm doctorInfoForm) {
		SysUser user = doctorInfoForm.getUser();
		if(StringUtil.isNotBlank(user.getSexId())){
			user.setSexName(UserSexEnum.getNameById(user.getSexId()));
		}else{
			user.setSexName("");
		}
		if(StringUtil.isNotBlank(user.getEducationId())){
			user.setEducationName(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));
		}else{
			user.setEducationName("");
		}
		if(StringUtil.isNotBlank(user.getDegreeId())){
			user.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(user.getDegreeId()));
		}else{
			user.setEducationName("");
		}
		userBiz.saveUser(user);
		
		UserResumeExtInfoForm userResumeExt = doctorInfoForm.getUserResumeExt();
		PubUserResume pubUserResume = userResumeBiz.readPubUserResume(user.getUserFlow());
		if(pubUserResume == null){
			pubUserResume = new PubUserResume();
		}
		//JavaBeanת����xml
		String xmlContent = JaxbUtil.convertToXml(userResumeExt);
		pubUserResume.setUserResume(xmlContent);
		userResumeBiz.savePubUserResume(user, pubUserResume);
		
		ResDoctor doctor = doctorInfoForm.getDoctor();
		return resDoctorBiz.editDoctor(doctor);
	}
	

	@Override
	public String checkImg(MultipartFile file) {
		List<String> mimeList = new ArrayList<String>();
		if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")))){
			mimeList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")).split(","));
		}
		List<String> suffixList = new ArrayList<String>();
		if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")))){
			suffixList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix").toLowerCase()).split(","));
		}
		String fileType = file.getContentType();//MIME����;
		String fileName = file.getOriginalFilename();//�ļ���
		String suffix = fileName.substring(fileName.lastIndexOf("."));//��׺��
		if(!(mimeList.contains(fileType) &&  suffixList.contains(suffix.toLowerCase()))){
			return "���ϴ� "+InitConfig.getSysCfg("inx_image_support_suffix")+"��ʽ���ļ�";
		}
		long limitSize = Long.parseLong(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_limit_size")));//ͼƬ��С����
		if(file.getSize() > limitSize*1024*1024){
			return GlobalConstant.UPLOAD_IMG_SIZE_ERROR +limitSize +"M" ;
		}
		return GlobalConstant.FLAG_Y;//��ִ�б���
	}
	
	@Override
	public String saveFileToDirs(String oldFolderName, MultipartFile file, String folderName){
		String path = GlobalConstant.FLAG_N;
		if(file.getSize() > 0){
			//����Ŀ¼
			String dateString = DateUtil.getCurrDate2();
			String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+File.separator + folderName + File.separator+ dateString ;
			File fileDir = new File(newDir);
			if(!fileDir.exists()){
				fileDir.mkdirs();
			}
			//�ļ���
			String originalFilename = file.getOriginalFilename();
			originalFilename = PkUtil.getUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
			File newFile = new File(fileDir, originalFilename); 
			try {
				file.transferTo(newFile);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("�����ļ�ʧ�ܣ�");
			}
			
			//ɾ��ԭ�ļ�
			if(StringUtil.isNotBlank(oldFolderName)){
				try {
					oldFolderName = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir")) + File.separator + oldFolderName;
					File imgFile = new File(oldFolderName);
					if(imgFile.exists()){
						imgFile.delete();
					}
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("ɾ���ļ�ʧ�ܣ�");
				}
			}
			path = folderName + "/"+dateString+"/"+originalFilename;
		}
		
		return path;
	}
}
