package com.pinde.sci.biz.njmuedu.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.njmuedu.INjmuEduStudentCourseBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduUserBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.EduUserMapper;
import com.pinde.sci.dao.njmuedu.NjmuEduUserExtMapper;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.njmuedu.EduUserExt;
@Service
@Transactional(rollbackFor=Exception.class)
public class NjmuEduUserBizImpl implements INjmuEduUserBiz {
	@Autowired
	private EduUserMapper eduUserMapper;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private NjmuEduUserExtMapper eduUserExtMapper;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private INjmuEduStudentCourseBiz studentCourseBiz;
	
	@Override
	public int addEduUser(EduUser eduUser) {
		String userFlow = eduUser.getUserFlow();
		if(StringUtil.isNotBlank(userFlow)){
			EduUser search = readEduUser(userFlow);
			if(search == null){
				GeneralMethod.setRecordInfo(eduUser, true);
				return eduUserMapper.insert(eduUser);
			}else{
				GeneralMethod.setRecordInfo(eduUser, false);
				return eduUserMapper.updateByPrimaryKeySelective(eduUser);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public EduUser readEduUser(String userFlow) {
		if(StringUtil.isNotBlank(userFlow)){
			return eduUserMapper.selectByPrimaryKey(userFlow);
		}
		return null;
	}

	@Override
	public int saveUserAndEduUser(SysUser sysUser, EduUser eduUser) {
		String userCode = sysUser.getUserCode();
		if(StringUtil.isNotBlank(userCode)){
			sysUser.setUserCode(userCode.trim());
		}
		String userPhone =  sysUser.getUserPhone();
		if(StringUtil.isNotBlank(userPhone)){
			sysUser.setUserPhone(userPhone.trim());
		}
		String idNo = sysUser.getIdNo();
		if(StringUtil.isNotBlank(idNo)){
			sysUser.setIdNo(idNo.trim());
		}
		String userEmail = sysUser.getUserEmail();
		if(StringUtil.isNotBlank(userEmail)){
			sysUser.setUserEmail(userEmail.trim());
		}
		String orgFlow = sysUser.getOrgFlow();
		SysOrg sysOrg = null;
		if(StringUtil.isNotBlank(orgFlow)){
			sysOrg = orgBiz.readSysOrg(orgFlow);
			sysUser.setOrgName(sysOrg.getOrgName());
		}
		String majorId = eduUser.getMajorId();
		if(StringUtil.isNotBlank(majorId)){
			eduUser.setMajorName(DictTypeEnum.CourseMajor.getDictNameById(majorId));
		}
		userBiz.saveUser(sysUser);	
		eduUser.setUserFlow(sysUser.getUserFlow());
		return addEduUser(eduUser);
	}

	@Override
	public String uploadImg(MultipartFile file) {
		if(file!=null){
			List<String> mimeList = new ArrayList<String>();
			if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")))){
				mimeList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")).split(","));
			}
			List<String> suffixList = new ArrayList<String>();
			if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")))){
				suffixList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")).split(","));
			}
			
			String fileType = file.getContentType();//MIME类型;
			String fileName = file.getOriginalFilename();//文件名
			String suffix = fileName.substring(fileName.lastIndexOf("."));//后缀名
			if(!(mimeList.contains(fileType)&&suffixList.contains(suffix))){
				return GlobalConstant.UPLOAD_IMG_TYPE_ERROR;
			}
			long limitSize = Long.parseLong(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_limit_size")));//图片大小限制
			if(file.getSize()>limitSize*1024*1024){
				return GlobalConstant.UPLOAD_IMG_SIZE_ERROR +limitSize +"M" ;
			}
			try {
				/*创建目录*/
				String dateString = DateUtil.getCurrDate2();
				String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+File.separator+"eduImages"+File.separator + dateString ;
				File fileDir = new File(newDir);
				if(!fileDir.exists()){
					fileDir.mkdirs();
				}
				/*文件名*/
				fileName = file.getOriginalFilename();
				fileName = PkUtil.getUUID()+fileName.substring(fileName.lastIndexOf("."));
				File newFile = new File(fileDir, fileName); 
				file.transferTo(newFile);
				return "success:/eduImages/"+dateString+"/"+fileName;
			} catch (Exception e) {
				e.printStackTrace();
				return GlobalConstant.UPLOAD_FAIL;
			}
		}
		return GlobalConstant.UPLOAD_FAIL;
	}

	@Override
	public List<EduUserExt> searchList(EduUserExt userExt) {
		return this.eduUserExtMapper.selectList(userExt);
	}

	@Override
	public List<EduUserExt> searchEduUserForManage(Map<String, Object> paramMap) {
		return this.eduUserExtMapper.searchEduUserForManage(paramMap);
	}

	@Override
	public List<EduUserExt> searchEduUserForCourseDetail(
			Map<String, Object> paramMap) {
		return this.eduUserExtMapper.searchEduUserForCourseDetail(paramMap);
	}

	@Override
	public int saveUserAndRole(SysUser sysUser, EduUser eduUser,String type) {
		if(StringUtil.isNotBlank(sysUser.getSexId())){
			sysUser.setSexName(UserSexEnum.getNameById(sysUser.getSexId()));
		}
		if(StringUtil.isNotBlank(sysUser.getTitleId())){
			sysUser.setTitleName(DictTypeEnum.UserTitle.getDictNameById(sysUser.getTitleId()));
		}
		if(StringUtil.isNotBlank(sysUser.getEducationId())){
			sysUser.setEducationName(DictTypeEnum.UserEducation.getDictNameById(sysUser.getEducationId()));
		}
		if(StringUtil.isNotBlank(sysUser.getDegreeId())){
			sysUser.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(sysUser.getDegreeId()));
		}
		if(StringUtil.isNotBlank(eduUser.getMajorId())){
			eduUser.setMajorName(DictTypeEnum.NjmuCourseMajor.getDictNameById(eduUser.getMajorId()));
		}
		userBiz.saveUser(sysUser);	
		String userFlow = sysUser.getUserFlow();
		eduUser.setUserFlow(userFlow);
		addEduUser(eduUser);
		//角色
		SysUserRole userRole = new SysUserRole();
		userRole.setUserFlow(userFlow);
		userRole.setWsId(GlobalConstant.NJMUEDU_WS_ID);
		//开关获取
		if(GlobalConstant.TEACHER_ROLE.equals(type)){
			userRole.setRoleFlow(InitConfig.getSysCfg("njmuedu_teacher_role_flow"));
		}
		if(GlobalConstant.STUDENT_ROLE.equals(type)){
			userRole.setRoleFlow(InitConfig.getSysCfg("njmuedu_student_role_flow"));
			//插入必修课
			studentCourseBiz.insertRequireCourse(userFlow);
		}
		userRole.setAuthTime(DateUtil.getCurrDateTime());
		return userRoleBiz.saveSysUserRole(userRole);
		
	}
	@Override
	public EduUserExt readEduUserInfo(String userFlow) {
		return eduUserExtMapper.readEduUserInfo(userFlow);
	}

	@Override
	public List<EduUserExt> searchEduAndCourseList(
			Map<String, Object> paramMap) {		 
		return eduUserExtMapper.searchEduAndCourseList(paramMap);
	}

	@Override
	public List<EduUserExt> searchEduUserByFlows(List<String> teacherFlowList) {
		Map<String, Object> paramMap=new HashMap<String, Object>();
		paramMap.put("teacherFlowList", teacherFlowList);
		return eduUserExtMapper.searchEduUserList(paramMap);
	}
}
