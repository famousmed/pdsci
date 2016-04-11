package com.pinde.sci.biz.res.impl;

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
import com.pinde.sci.biz.edu.IEduStudentCourseBiz;
import com.pinde.sci.biz.hbres.GradeManageBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.res.IResRecBiz;
import com.pinde.sci.biz.res.IResRegBiz;
import com.pinde.sci.biz.sch.ISchArrangeResultBiz;
import com.pinde.sci.biz.sch.ISchRotationGroupBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.ResDoctorMapper;
import com.pinde.sci.dao.base.ResDoctorRecruitMapper;
import com.pinde.sci.dao.base.SchArrangeResultMapper;
import com.pinde.sci.dao.base.SchDoctorDeptMapper;
import com.pinde.sci.dao.res.ResDoctorExtMapper;
import com.pinde.sci.enums.res.RecDocCategoryEnum;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.enums.sch.SchStatusEnum;
import com.pinde.sci.form.hbres.ResDoctorTrainingSpeForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorExample;
import com.pinde.sci.model.mo.ResDoctorExample.Criteria;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.ResDoctorOrgHistory;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResExamDoctor;
import com.pinde.sci.model.mo.ResReg;
import com.pinde.sci.model.mo.SchArrangeResult;
import com.pinde.sci.model.mo.SchArrangeResultExample;
import com.pinde.sci.model.mo.SchDoctorDept;
import com.pinde.sci.model.mo.SchDoctorDeptExample;
import com.pinde.sci.model.mo.SchRotationGroup;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.res.ResDoctorExt;
import com.pinde.sci.model.sys.SysUserResDoctorExt;


@Service
@Transactional(rollbackFor=Exception.class)
public class ResDoctorBizImpl implements IResDoctorBiz{
	@Autowired
	private ResDoctorMapper doctorMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private ResDoctorExtMapper doctorExtMapper;
	@Autowired
	private ISchArrangeResultBiz schArrangeResultBiz;
	@Autowired
	private IResDoctorProcessBiz resDoctorProcessBiz;
	@Autowired
	private IResRecBiz resRecBiz;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private IResRegBiz resRegBiz;
	@Autowired
	private ISchRotationGroupBiz groupBiz;
	@Autowired
	private GradeManageBiz gradeManageBiz;
	@Autowired
	private ResDoctorRecruitMapper doctorRecruitMapper;
	@Autowired
	private SchArrangeResultMapper resultMapper;
	@Autowired
	private SchDoctorDeptMapper docDeptMapper;
	@Autowired
	private IPubUserResumeBiz userResumeBiz;
	@Autowired
	private IEduStudentCourseBiz studentCourseBiz;

	@Override
	public	List<ResDoctor> searchDoctor(){
		ResDoctorExample example = new ResDoctorExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return doctorMapper.selectByExample(example);
	}

	@Override
	public	ResDoctor readDoctor(String recordFlow){
		return doctorMapper.selectByPrimaryKey(recordFlow);
	}
	@Override
	public	int editDoctor(ResDoctor doctor){
		if(doctor!=null){
			checkSelDeptFlag(doctor);
			if(StringUtil.isNotBlank(doctor.getDoctorFlow())){
				GeneralMethod.setRecordInfo(doctor, false);
				return doctorMapper.updateByPrimaryKeySelective(doctor);
			}else{
				doctor.setDoctorFlow(PkUtil.getUUID());
				return onlySaveResDoctor(doctor);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public int onlySaveResDoctor(ResDoctor resDoctor){
		GeneralMethod.setRecordInfo(resDoctor, true);
		resDoctor.setSelDeptFlag(GlobalConstant.FLAG_N);
		resDoctor.setSchFlag(GlobalConstant.FLAG_N);
		return doctorMapper.insertSelective(resDoctor);
	}
	
	@Override
	public	int updateDocSelFlag(String orgFlow){
		return doctorExtMapper.updateDocSelFlag(orgFlow);
	}
	
	private void checkSelDeptFlag(ResDoctor doctor){
		if(doctor!=null && StringUtil.isNotBlank(doctor.getRotationFlow()) && StringUtil.isBlank(doctor.getSelDeptFlag())){
			List<SchRotationGroup> groupList = groupBiz.searchSchRotationGroup(doctor.getRotationFlow());
			if(groupList==null || groupList.size()<1){
				doctor.setSelDeptFlag(GlobalConstant.FLAG_Y);
			}
		}
	}
	
	@Override
	public int editDocUser(ResDoctor doctor,SysUser user){
		if(doctor!=null && user!=null){
//			if(GlobalConstant.RECORD_STATUS_N.equals(doctor.getRecordStatus())){
//				user.setStatusId(UserStatusEnum.Locked.getId());
//				user.setStatusDesc(UserStatusEnum.Locked.getName());
//			}else{
//				user.setStatusId(UserStatusEnum.Activated.getId());
//				user.setStatusDesc(UserStatusEnum.Activated.getName());
//			}
			
			String docRole = InitConfig.getSysCfg("res_doctor_role_flow");
			SysUserRole userRole = null;
			if(StringUtil.isNotBlank(user.getUserFlow()) && StringUtil.isNotBlank(docRole)){
				userRole = userRoleBiz.readUserRole(user.getUserFlow(),docRole);
			}
			
			userBiz.saveUser(user);
			
			if(userRole == null){
				userRole = new SysUserRole();
				userRole.setUserFlow(user.getUserFlow());
				userRole.setOrgFlow(user.getOrgFlow());
				String currWsId = (String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
				userRole.setWsId(currWsId);
				userRole.setRoleFlow(InitConfig.getSysCfg("res_doctor_role_flow"));
				userRole.setAuthTime(DateUtil.getCurrDate());
				userRole.setAuthUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				userRoleBiz.saveSysUserRole(userRole);
			}
			
			
			if(!StringUtil.isNotBlank(doctor.getDoctorFlow())){
				doctor.setDoctorFlow(user.getUserFlow());
				GeneralMethod.setRecordInfo(doctor, true);
				
//				if(GlobalConstant.RECORD_STATUS_N.equals(doctor.getRecordStatus())){
//					doctor.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
//				}
				checkSelDeptFlag(doctor);
				doctor.setSelDeptFlag(GlobalConstant.FLAG_N);
				doctor.setSchFlag(GlobalConstant.FLAG_N);
				doctorMapper.insertSelective(doctor);
			}else{
				editDoctor(doctor);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int editDocUserFromRegister(ResDoctor doctor,SysUser user){
		if(doctor!=null && user!=null){
			String userFlow = user.getUserFlow();
			String regYear = InitConfig.getSysCfg("res_reg_year");
			
			//判断是否已提交
			ResDoctor exitDoctor = this.doctorMapper.selectByPrimaryKey(userFlow);
			ResReg recentReg = resRegBiz.searchRecentYearResReg(user.getUserFlow()); 
			if (exitDoctor != null && 
					!RegStatusEnum.UnSubmit.getId().equals(exitDoctor.getDoctorStatusId())&& 
					regYear.equals(recentReg.getRegYear())) {
				return GlobalConstant.ZERO_LINE;
			}
			doctor.setDoctorStatusId(RegStatusEnum.UnSubmit.getId());
			doctor.setDoctorStatusName(RegStatusEnum.UnSubmit.getName());
			doctor.setSessionNumber(regYear);
			userBiz.saveUser(user);
			if(StringUtil.isNotBlank(doctor.getDoctorFlow())){
				if(exitDoctor!=null){
					GeneralMethod.setRecordInfo(doctor, false);
					return doctorMapper.updateByPrimaryKeySelective(doctor);
				}else{
					doctor.setDoctorFlow(userFlow);
					doctor.setDoctorCategoryId(RecDocCategoryEnum.Doctor.getId());
					doctor.setDoctorCategoryName(RecDocCategoryEnum.Doctor.getName());
					GeneralMethod.setRecordInfo(doctor, true);
					doctor.setSelDeptFlag(GlobalConstant.FLAG_N);
					doctor.setSchFlag(GlobalConstant.FLAG_N);
					return doctorMapper.insertSelective(doctor);
				}
				
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	/**
	 * 检查文件大小及类型
	 * @param file
	 * @return
	 */
	@Override
	public String checkFile(MultipartFile file) {
		List<String> mimeList = new ArrayList<String>();
		if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")))){
			mimeList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")).split(","));
		}
		List<String> suffixList = new ArrayList<String>();
		if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")))){
			suffixList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix").toLowerCase()).split(","));
		}
		String fileType = file.getContentType();//MIME类型;
		String fileName = file.getOriginalFilename();//文件名
		String suffix = fileName.substring(fileName.lastIndexOf("."));//后缀名
		if(!(mimeList.contains(fileType) &&  suffixList.contains(suffix.toLowerCase()))){
			return "请上传 "+InitConfig.getSysCfg("inx_image_support_suffix")+"格式的文件";
		}
		long limitSize = Long.parseLong(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_limit_size")));//图片大小限制
		if(file.getSize() > limitSize*1024*1024){
			return GlobalConstant.UPLOAD_IMG_SIZE_ERROR +limitSize +"M" ;
		}
		return GlobalConstant.FLAG_Y;//可执行保存
	}
	
	@Override
	public List<ResDoctor> searchByDoc(ResDoctor doctor){
		ResDoctorExample example = new ResDoctorExample();
		Criteria criteria = example.createCriteria();
		setCriteria(doctor,criteria);
		return doctorMapper.selectByExample(example);
	}
	
	@Override
	public List<ResDoctor> searchByDocNotSelf(ResDoctor doctor,String doctorFlow){
		ResDoctorExample example = new ResDoctorExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y).andDoctorFlowNotEqualTo(doctorFlow);
		setCriteria(doctor,criteria);
		return doctorMapper.selectByExample(example);
	}
	
	private Criteria setCriteria(ResDoctor doctor,Criteria criteria){
		if(doctor!=null){
			if(StringUtil.isNotBlank(doctor.getSessionNumber())){
				criteria.andSessionNumberEqualTo(doctor.getSessionNumber());
			}
			if(StringUtil.isNotBlank(doctor.getTrainingSpeId())){
				criteria.andTrainingSpeIdEqualTo(doctor.getTrainingSpeId());
			}
			if(StringUtil.isNotBlank(doctor.getGraduatedId())){
				criteria.andGraduatedIdEqualTo(doctor.getGraduatedId());
			}
			if(StringUtil.isNotBlank(doctor.getRecordStatus())){
				criteria.andRecordStatusEqualTo(doctor.getRecordStatus());
			}
			if(StringUtil.isNotBlank(doctor.getDoctorCategoryId())){
				criteria.andDoctorCategoryIdEqualTo(doctor.getDoctorCategoryId());
			}
			if(StringUtil.isNotBlank(doctor.getOrgFlow())){
				criteria.andOrgFlowEqualTo(doctor.getOrgFlow());
			}
			if(StringUtil.isNotBlank(doctor.getDoctorName())){
				criteria.andDoctorNameEqualTo(doctor.getDoctorName());
			}
			if(StringUtil.isNotBlank(doctor.getSchStatusId())){
				criteria.andSchStatusIdEqualTo(doctor.getSchStatusId());
			}
			if(StringUtil.isNotBlank(doctor.getDeptFlow())){
				criteria.andDeptFlowEqualTo(doctor.getDeptFlow());
			}
			if(StringUtil.isNotBlank(doctor.getGroupId())){
				criteria.andGroupIdEqualTo(doctor.getGroupId());
			}
		}
		return criteria;
	}
	
	@Override
	public List<ResDoctorExt> searchDocUser(ResDoctorExt resDoctorExt){
		return doctorExtMapper.searchResDoctorUser(resDoctorExt);
	}
	
	@Override
	public List<SysUserResDoctorExt> searchSysUserAndResDoctor(SysUserResDoctorExt userDoctorExt,List<String> checkUserFlowList,String schDeptFlow){
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("userDoctorExt", userDoctorExt);
		if(checkUserFlowList!=null && !checkUserFlowList.isEmpty()){
			paramMap.put("checkUserFlowList", checkUserFlowList);
		}
		if(StringUtil.isNotBlank(schDeptFlow)){
			paramMap.put("schDeptFlow", schDeptFlow);
		}
		return doctorExtMapper.searchSysUserAndResDoctor(paramMap);
	}
	
	@Override
	public List<ResDoctorExt> searchDocUser(Map<String , Object> paramMap){
		return doctorExtMapper.searchResDoctorUserForAudit(paramMap);
	}
	
	@Override
	public List<ResDoctorExt> searchRegUser(Map<String , Object> paramMap){
		return doctorExtMapper.searchResRegUserForAudit(paramMap);
	}
	

	@Override
	public ResDoctor searchByUserFlow(String userFlow) {
		return doctorMapper.selectByPrimaryKey(userFlow);
	}

	@Override
	public List<SysUser> searchTeacherOrHead(String resultFlow, String roleFlow) {
		List<SysUser> userList = null;
		if(StringUtil.isNotBlank(resultFlow)&&StringUtil.isNotBlank(roleFlow)){
			SchArrangeResult result = this.schArrangeResultBiz.readSchArrangeResult(resultFlow);
			if(result!=null){
				SysUserRole userRole = new SysUserRole();
				userRole.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
				userRole.setRoleFlow(roleFlow);
				List<SysUserRole> userRoleList = userRoleBiz.searchUserRole(userRole);
				List<String> userFlows = new ArrayList<String>();
				if(userRoleList!=null&&!userRoleList.isEmpty()){
					for (SysUserRole sur : userRoleList) {
						userFlows.add(sur.getUserFlow());
					}
				}
				userList = this.userBiz.searchSysUserByuserFlows(userFlows,result.getDeptFlow());
			}
		}
		return userList;
	}

	@Override
	public void saveChoose(ResDoctorSchProcess process, String resultFlow, String preResultFlow) {
		SchArrangeResult result = this.schArrangeResultBiz.readSchArrangeResult(resultFlow);
		if(result!=null){
			ResDoctor doctor = readDoctor(result.getDoctorFlow());
			if(doctor!=null){
				process.setUserFlow(doctor.getDoctorFlow());
				process.setOrgFlow(doctor.getOrgFlow());
				process.setOrgName(doctor.getOrgName());
				
				doctor.setDeptFlow(result.getDeptFlow());
				doctor.setDeptName(result.getDeptName());
				editDoctor(doctor);
			}
			process.setDeptFlow(result.getDeptFlow());
			process.setDeptName(result.getDeptName());
			process.setSchDeptFlow(result.getSchDeptFlow());
			process.setSchDeptName(result.getSchDeptName());
			process.setSchResultFlow(resultFlow);
			process.setSchStartDate(result.getSchStartDate());
			process.setSchEndDate(result.getSchEndDate());
			process.setSchFlag(GlobalConstant.FLAG_N);
			process.setIsCurrentFlag(GlobalConstant.FLAG_Y);
			process.setSchPer((short)0);
			process.setStartDate(DateUtil.getCurrDate());
			if(StringUtil.isNotBlank(process.getTeacherUserFlow())){
				SysUser teacher = userBiz.readSysUser(process.getTeacherUserFlow());
				process.setTeacherUserName(teacher.getUserName());
			}
			if(StringUtil.isNotBlank(process.getHeadUserFlow())){
				SysUser head = userBiz.readSysUser(process.getHeadUserFlow());
				process.setHeadUserName(head.getUserName());
			}
			this.resDoctorProcessBiz.edit(process);
			
//			if(StringUtil.isNotBlank(preResultFlow)){
//				ResDoctorSchProcess preProcess = this.resDoctorProcessBiz.searchByResultFlow(preResultFlow);
//				if(preProcess!=null){
//					preProcess.setIsCurrentFlag(GlobalConstant.FLAG_N);
//					//preProcess.setSchFlag(GlobalConstant.FLAG_Y);
//					this.resDoctorProcessBiz.edit(preProcess);
//				}
//			}
		}
	}
	
	@Override
	public List<ResDoctor> searchDoctorByuserFlow(List<String> userFlows){
		ResDoctorExample example = new ResDoctorExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDoctorFlowIn(userFlows);
		return doctorMapper.selectByExample(example);
	}
//	@Override
//	public List<SysUser> searchResDoctorByuserFlows(List<String> userFlows){
//		if(userFlows != null && !userFlows.isEmpty()){
//			ResDoctorExample example = new ResDoctorExample();
//			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDoctorFlowIn(userFlows);
//			return doctorMapper.selectByExample(example);
//		}
//		return null;
//	}
	
	@Override
	public String saveImg(String oldImg,MultipartFile file, String folderName){
		String path = GlobalConstant.FLAG_N;
		if(file.getSize() > 0){
			//创建目录
			String dateString = DateUtil.getCurrDate2();
			String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+File.separator + folderName + File.separator+ dateString ;
			File fileDir = new File(newDir);
			if(!fileDir.exists()){
				fileDir.mkdirs();
			}
			//文件名
			String originalFilename = file.getOriginalFilename();
			originalFilename = PkUtil.getUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
			File newFile = new File(fileDir, originalFilename); 
			try {
				file.transferTo(newFile);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("保存图片失败！");
			}
			//删除原图片
			if(StringUtil.isNotBlank(oldImg)){
				try {
					oldImg = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir")) + File.separator + oldImg;
					File imgFile = new File(oldImg);
					if(imgFile.exists()){
						imgFile.delete();
					}
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("删除图片失败！");
				}
			}
			path = folderName + "/"+dateString+"/"+originalFilename;
		}
		
		return path;
	}

	@Override
	public Integer searchResDoctorUserCount(Map<String, Object> paramMap) {
		Integer i = this.doctorExtMapper.searchResDoctorUserCount(paramMap);
		if(i==null){
			i = 0;
		}
		return i;
	}
	
	@Override
	public Integer searchResRegUserCount(Map<String, Object> paramMap) {
		Integer i = this.doctorExtMapper.searchResRegUserCount(paramMap);
		if(i==null){
			i = 0;
		}
		return i;
	}

	@Override
	public void auditDoctor(SysUser user, ResDoctor doctor) {
		String statusId = doctor.getDoctorStatusId();
		if(StringUtil.isNotBlank(statusId)){
			doctor.setDoctorStatusName(RegStatusEnum.getNameById(statusId));
			editDoctor(doctor);
			String userFlow = user.getUserFlow();
			String regYear = InitConfig.getSysCfg("res_reg_year");
			ResReg reg = resRegBiz.searchResReg(userFlow,regYear);
			if (reg == null) {
				reg = new ResReg();
				reg.setUserFlow(userFlow);
				reg.setUserName(doctor.getDoctorName());
				reg.setRegYear(regYear);
			}
			reg.setStatusId(statusId);
			reg.setStatusName(RegStatusEnum.getNameById(statusId));
			resRegBiz.editResReg(reg);
			
			SysUser exitUser = userBiz.readSysUser(userFlow);
//			String title = InitConfig.getSysCfg("res_audit_email_title");
//			String content = "";
//			if(RegStatusEnum.UnPassed.getId().equals(statusId)){
//				content = InitConfig.getSysCfg("res_audit_fail_email_content");
//			}else if(RegStatusEnum.Passed.getId().equals(statusId)){
//				content = InitConfig.getSysCfg("res_audit_success_email_content");
//			}
//			this.msgBiz.addEmailMsg(exitUser.getUserEmail() , title, content);
//			if(StringUtil.isNotBlank(doctor.getDisactiveReason())){
//				this.msgBiz.addSysMsg(exitUser.getUserFlow(), "审核通知", doctor.getDisactiveReason());	
//			}
			if(RegStatusEnum.Passed.getId().equals(statusId)){
				//审核通过
				this.msgBiz.addSysMsg(exitUser.getUserFlow(), "您的报名材料审核结果：通过.", doctor.getDisactiveReason());
			}else {
				//审核不通过
				this.msgBiz.addSysMsg(exitUser.getUserFlow(), "您的报名材料审核结果：未通过.", doctor.getDisactiveReason());
			}
		}
	}
	
	@Override
	public ResDoctor searchResDoctor(String userFlow,String regYear){
		ResDoctor doctor = null;
		ResDoctorExample example = new ResDoctorExample();
		Criteria criteria = example.createCriteria();
		criteria.andDoctorFlowEqualTo(userFlow).andSessionNumberEqualTo(regYear);
		List<ResDoctor> list = doctorMapper.selectByExample(example);
		if (list != null && list.size() >0) {
			doctor = list.get(0);
		}
		return doctor;
	}
	
	@Override
	public int submitUserInfo(SysUser user, ResDoctor doctor) {
		if(user != null && doctor != null){
			userBiz.saveUser(user);
			editDoctor(doctor);
			String userFlow = user.getUserFlow();
			String regYear = InitConfig.getSysCfg("res_reg_year");
			ResReg reg = resRegBiz.searchResReg(userFlow,regYear);
			if (reg == null) {
				reg = new ResReg();
				reg.setUserFlow(userFlow);
				reg.setUserName(doctor.getDoctorName());
				reg.setRegYear(regYear);
				resRegBiz.editResReg(reg);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	
	@Override
	public List<Map<String,Object>> searchTrainPlanCount(ResDoctor doctor,String countType){
		return doctorExtMapper.searchTrainPlanCount(doctor, countType);
	}
	
	@Override
	public List<Map<String,Object>> countDocByOrg(List<String> orgFlows,ResDoctor doctor){
		return doctorExtMapper.countDocByOrg(orgFlows,doctor);
	}
	
	@Override
	public int modifyResDoctorRotation(ResDoctor doctor){
		return doctorExtMapper.modifyResDoctorRotation(doctor);
	}
	
	@Override
	public List<Map<String,String>> searGroupRotation(ResDoctor doctor){
		return doctorExtMapper.searGroupRotation(doctor);
	}
	
	@Override
	public ResExamDoctor searchExamDoctor(String doctorFlow,String examType,String examYear) {
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("doctorFlow", doctorFlow);
		paramMap.put("examType", examType);
		paramMap.put("examYear", examYear);
		return doctorExtMapper.searchExamDoctor(paramMap);
	}

	@Override
	public List<ResDoctorExt> searchRegisterList(Map<String, Object> paramMap) {
		return doctorExtMapper.searchRegisterList(paramMap);
	}
	
	@Override
	public void withdrawDoctor(ResDoctor doctor) {
		editDoctor(doctor);
		SysUser exitUser = userBiz.readSysUser(doctor.getDoctorFlow());
		String title = InitConfig.getSysCfg("res_audit_email_title");
		String content = InitConfig.getSysCfg("res_reedit_email_content");
		this.msgBiz.addEmailMsg(exitUser.getUserEmail() , title, content);
	}

	@Override
	public List<ResDoctorTrainingSpeForm> trainingSpeCountList(Map<String, Object> paramMap) {
		return doctorExtMapper.trainingSpeCountList(paramMap);
	}
	
	@Override
	public List<ResDoctor> searchMonthRotationDoctor(String schDeptFlow,String month){
		return doctorExtMapper.searchMonthRotationDoctor(schDeptFlow,month);
	}
	
	@Override
	public int resultAudit(String orgFlow){
		ResDoctorExample example = new ResDoctorExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andSchStatusIdEqualTo(SchStatusEnum.Submit.getId())
		.andOrgFlowEqualTo(orgFlow);
		
		ResDoctor doctor = new ResDoctor();
		doctor.setSchStatusId(SchStatusEnum.AuditY.getId());
		doctor.setSchStatusName(SchStatusEnum.AuditY.getName());
		doctor.setSchFlag(GlobalConstant.FLAG_Y);
		
		return doctorMapper.updateByExampleSelective(doctor,example);
	}
	
	@Override
	public List<ResDoctor> searchSelDeptDoctor(ResDoctor doctor){
		return doctorExtMapper.searchSelDeptDoctor(doctor);
	}
	
	@Override
	public List<ResDoctor> searchDoctorForChange(ResDoctor doctor,ResDoctorOrgHistory docOrgHis){
		return doctorExtMapper.searchDoctorForChange(doctor,docOrgHis);
	}
	
	@Override
	public List<ResDoctor> searchDocByteacher(Map<String , Object> paramMap){
		return doctorExtMapper.searchDocByteacher(paramMap);
	}
	
	@Override
	public int editDoctorUser(ResDoctor doctor,SysUser user){
		if(doctor!=null && user!=null){
			userBiz.saveUser(user);
			editDoctor(doctor);
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int resetDoctorRecruit(String doctorFlow){
		if (StringUtil.isNotBlank(doctorFlow)) {
			String regYear = InitConfig.getSysCfg("res_reg_year");
			List<ResDoctorRecruit> doctorRecruits = gradeManageBiz.findResDoctorRecruits(regYear,doctorFlow);
			ResDoctorRecruitWithBLOBs recruit = null;
			if (doctorRecruits != null && doctorRecruits.size() >0) {
				int size = doctorRecruits.size();
				if (size == 1) {
					recruit = new ResDoctorRecruitWithBLOBs();
					recruit.setRecruitFlow(doctorRecruits.get(0).getRecruitFlow());
					recruit.setAdmitFlag(GlobalConstant.FLAG_N);
					recruit.setRecruitFlag("");
					recruit.setAdmitNotice("");
					this.doctorRecruitMapper.updateByPrimaryKeySelective(recruit);
				} else {
					for (int i=0;i<size;i++) {
						if (i==0) {
							recruit = new ResDoctorRecruitWithBLOBs();
							recruit.setRecruitFlow(doctorRecruits.get(0).getRecruitFlow());
							recruit.setAdmitFlag(GlobalConstant.FLAG_N);
							recruit.setRecruitFlag("");
							recruit.setAdmitNotice("");
							this.doctorRecruitMapper.updateByPrimaryKeySelective(recruit);
						} else {
							ResDoctorRecruit docRecruit = doctorRecruits.get(i);
							docRecruit.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
							this.doctorRecruitMapper.updateByPrimaryKey(docRecruit);
						}
					}
				}
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int updateRedundancyData(ResDoctor doctor){
		return doctorExtMapper.updateRedundancyData(doctor);
	}

	@Override
	public int findDoctorCountInOrg(ResDoctor doctor) {
		ResDoctorExample example = new ResDoctorExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(doctor.getDoctorStatusId())){
			criteria.andDoctorStatusIdEqualTo(doctor.getDoctorStatusId());	
		}
		if(StringUtil.isNotBlank(doctor.getOrgFlow())){
			criteria.andOrgFlowEqualTo(doctor.getOrgFlow());
		}
		return this.doctorMapper.countByExample(example);
	}
	
	@Override
	public List<Map<String,Object>> countGroupDoc(ResDoctor doctor){
		return doctorExtMapper.countGroupDoc(doctor);
	}
	
	@Override
	public int clearSelAndRostering(List<String> doctorFlowList){
		if(doctorFlowList!=null && doctorFlowList.size()>0){
			//删除选科数据
			SchDoctorDept docDept = new SchDoctorDept();
			docDept.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			SchDoctorDeptExample docDeptExample = new SchDoctorDeptExample();
			docDeptExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDoctorFlowIn(doctorFlowList);
			docDeptMapper.updateByExampleSelective(docDept,docDeptExample);
			
			//删除排班数据
			SchArrangeResult result = new SchArrangeResult();
			result.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			SchArrangeResultExample resultExample = new SchArrangeResultExample();
			resultExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDoctorFlowIn(doctorFlowList);
			resultMapper.updateByExampleSelective(result,resultExample);
			
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public Map<String, Map<String, Object>> courseFlowResDoctorMap(
			List<EduCourseExt> eduCourseList) {
		if (eduCourseList!=null&&!eduCourseList.isEmpty()) {
		List<String> courseFlowList=new ArrayList<String>();
		Map<String,Map<String,Object>> studentCourseMap=new HashMap<String, Map<String,Object>>();
		Map<String, Object> sysUserMap=null;
		for (EduCourse course : eduCourseList) {
			if (!courseFlowList.contains(course.getCourseFlow())) {
				courseFlowList.add(course.getCourseFlow());
				sysUserMap=new HashMap<String, Object>();
				studentCourseMap.put(course.getCourseFlow(),sysUserMap);
			}
		}
		List<EduStudentCourse> eduStudentCourseList=studentCourseBiz.searchStudentCourseList(courseFlowList);
		
		for (EduStudentCourse eduStudentCourse : eduStudentCourseList) {
			ResDoctor doctor=searchByUserFlow(eduStudentCourse.getUserFlow());
			studentCourseMap.get(eduStudentCourse.getCourseFlow()).put(eduStudentCourse.getUserFlow(), doctor);
		}
		return studentCourseMap;
		}
		return null;
		
	}
	@Override
	public ResDoctor findByFlow(String doctorFlow) {
		return doctorMapper.selectByPrimaryKey(doctorFlow);
	}
} 
 