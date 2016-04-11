package com.pinde.sci.biz.njmuedu.impl;

import java.io.File;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.njmuedu.INjmuEduCourseFileBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.EduCourseFileMapper;
import com.pinde.sci.model.mo.EduCourseFile;
import com.pinde.sci.model.mo.EduCourseFileExample;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class NjmuEduCourseFileBizImpl implements INjmuEduCourseFileBiz{
	@Autowired
	private EduCourseFileMapper courseFileMapper;
	@Autowired
	private IFileBiz fileBiz;
	
	@Override
	public int saveCourseFile(EduCourseFile courseFile) {
		if(StringUtil.isNotBlank(courseFile.getRecordFlow())){
			GeneralMethod.setRecordInfo(courseFile, false);
			 return courseFileMapper.updateByPrimaryKeySelective(courseFile);
		}else{
			courseFile.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(courseFile, true);
			return courseFileMapper.insert(courseFile);
		}
	}
	
	@Override
	public List<EduCourseFile> searchCourseFileList(EduCourseFile courseFile) {
		EduCourseFileExample example = new EduCourseFileExample();
		com.pinde.sci.model.mo.EduCourseFileExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(courseFile.getCourseFlow())){
			criteria.andCourseFlowEqualTo(courseFile.getCourseFlow());
		}
		if(StringUtil.isNotBlank(courseFile.getFileName())){
			criteria.andFileNameLike("%" + courseFile.getFileName() + "%");
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return courseFileMapper.selectByExample(example);
	}
	
	@Override
	public int operateFile(MultipartFile file, String courseFlow) throws Exception {
		SysUser currUser = GlobalContext.getCurrentUser();
		if(file.getSize() > 0 && currUser != null){
			//创建目录
			String dateString = DateUtil.getCurrDate2();
			String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+File.separator+"eduFiles"+File.separator+ dateString ;
			File fileDir = new File(newDir);
			if(!fileDir.exists()){
				fileDir.mkdirs();
			}
			//文件名
			String originalFilename = file.getOriginalFilename();
			
			EduCourseFile courseFile = new EduCourseFile();
			courseFile.setFileName(originalFilename);
			
			String uuIdFilename = PkUtil.getUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
			File newFile = new File(fileDir, uuIdFilename); 
			file.transferTo(newFile);
		
			String fileDirString = "/eduFiles/"+dateString+"/"+uuIdFilename;
			courseFile.setFileDir(fileDirString);
			
			courseFile.setCourseFlow(courseFlow);
			courseFile.setUserFlow(currUser.getUserFlow());
			courseFile.setUserName(currUser.getUserName());
			return saveCourseFile(courseFile);
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int delCourseFile(String recordFlow) {
		if(StringUtil.isNotBlank(recordFlow)){
			EduCourseFile courseFile = readCourseFile(recordFlow);
			if(courseFile != null){
				String fileDir = courseFile.getFileDir();
				String uploadFileDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir")) + File.separator + fileDir;
				File uploadFile = new File(uploadFileDir);
				if(uploadFile.exists()){
					uploadFile.delete();
				}
				courseFile.setFileDir(null);
				courseFile.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				GeneralMethod.setRecordInfo(courseFile, false);
				return courseFileMapper.updateByPrimaryKey(courseFile);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public EduCourseFile readCourseFile(String recordFlow) {
		if(StringUtil.isNotBlank(recordFlow)){
			return courseFileMapper.selectByPrimaryKey(recordFlow);
		}
		return null;
	}

}
