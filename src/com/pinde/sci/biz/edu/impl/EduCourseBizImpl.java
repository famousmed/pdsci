package com.pinde.sci.biz.edu.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduCourseChapterBiz;
import com.pinde.sci.biz.edu.IEduCoursePeriodRefBiz;
import com.pinde.sci.biz.edu.IEduCourseRequireRefBiz;
import com.pinde.sci.biz.edu.IEduCourseScoreRefBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.EduCourseMapper;
import com.pinde.sci.dao.base.EduCourseScheduleMapper;
import com.pinde.sci.dao.base.EduStudentCourseMapper;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.edu.EduCourseExtMapper;
import com.pinde.sci.dao.edu.EduStudentCourseExtMapper;
import com.pinde.sci.enums.edu.EduCourseStatusEnum;
import com.pinde.sci.enums.edu.EduCourseTypeEnum;
import com.pinde.sci.enums.edu.EduStudyStatusEnum;
import com.pinde.sci.enums.edu.PeriodUserScopeEnum;
import com.pinde.sci.enums.edu.RequiredUserScopeEnum;
import com.pinde.sci.enums.edu.ScoreUserScopeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.OperTypeEnum;
import com.pinde.sci.enums.sys.ReqTypeEnum;
import com.pinde.sci.form.edu.EduCourseForm;
import com.pinde.sci.form.edu.EduCourseSearchConditionForm;
import com.pinde.sci.form.edu.EduFileForm;
import com.pinde.sci.form.edu.EduStudentCourseForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseExample;
import com.pinde.sci.model.mo.EduCoursePeriodRef;
import com.pinde.sci.model.mo.EduCourseRequireRef;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.EduCourseScheduleExample;
import com.pinde.sci.model.mo.EduCourseScoreRef;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.EduStudentCourseExample;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysUserExample;
import com.pinde.sci.model.mo.EduStudentCourseExample.Criteria;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysUser;
import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;

@Service
@Transactional(rollbackFor = Exception.class)
public class EduCourseBizImpl implements IEduCourseBiz{

	@Autowired
	private EduCourseExtMapper eduCourseExtMapper;
	@Autowired
	private EduCourseMapper eduCourseMapper;
	@Autowired
	private EduStudentCourseMapper eduStudentCourseMapper;
	@Autowired
	private EduCourseScheduleMapper eduCourseScheduleMapper;
	@Autowired
	private IEduCourseChapterBiz chapterBiz;
	@Autowired
	private IEduCourseRequireRefBiz requireRefBiz;
	@Autowired
	private IEduCourseScoreRefBiz scoreRefBiz;
	@Autowired
	private IEduCoursePeriodRefBiz periodRefBiz;
//	@Autowired
//	private IUserBiz userBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private EduStudentCourseExtMapper studentCourseExtMapper;
	@Autowired
	private SysLogMapper logMapper;
	@Resource
	private SysUserMapper sysUserMapper;
	@Resource
	private IUserBiz iUserBiz;
	@Resource
	private IDictBiz iDict; 
	@Override
	public List<EduCourse> searchStuCourseList(
			EduCourse eduCourse,SysUser sysUser,String studyStatus) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		  if(eduCourse!=null){
			  paramMap.put("eduCourse", eduCourse); 
		  }
		  if(sysUser!=null){
			  paramMap.put("sysUser", sysUser);
		  }
		  if(studyStatus!=null){
			  paramMap.put("studyStatus", studyStatus);
		  }	
		List<EduCourse> stuCourseList=eduCourseExtMapper.searchStuCourseList(paramMap);
		return stuCourseList;
	}
	

	@Override
	public EduCourseExt searchOneWithChapters(String courseFlow) {
		EduCourseExt courseExt = null;
		if(StringUtil.isNotBlank(courseFlow)){
			courseExt = this.eduCourseExtMapper.selectOneWithChapters(courseFlow);
		}
		return courseExt;
	}
	
	@Override
	public EduFileForm saveFile(MultipartFile file, String type) throws Exception {
		if(file.getSize() > 0){
			String dateString = DateUtil.getCurrDate2();
			String newDir = "";
			if("reseduCourseVideo".equals(type)){
				newDir+=StringUtil.defaultString(InitConfig.getSysCfg("upload_stream_dir"))+File.separator+type+File.separator+ dateString;
			}else{
				newDir+=StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+File.separator+type+File.separator+ dateString;
			}
			File fileDir = new File(newDir);
			if(!fileDir.exists()){
				fileDir.mkdirs();
			}
			String fileSuffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			String filename = PkUtil.getUUID() + fileSuffix;
			File newFile = new File(fileDir, filename); 
			file.transferTo(newFile);
			String fileUrl =File.separator + type + File.separator + dateString + File.separator + filename;
			//�ж��ļ��Ƿ��ϴ��ɹ�
			String url=newDir+File.separator+filename;
	    	File checkFile=new File(url);
	    	if(checkFile.isFile()){
	    		EduFileForm fileForm=new EduFileForm();
	    		fileForm.setFileUrl(fileUrl.replace("\\", "/"));
	    		if("reseduCourseVideo".equals(type)){
//	    			Encoder encoder = new Encoder();
//		    		MultimediaInfo m = encoder.getInfo(checkFile);
////		            BigDecimal ls = BigDecimal.valueOf(m.getDuration()).divide(new BigDecimal(1000));
//		            BigDecimal minTime=ls.divide(new BigDecimal(60),0,BigDecimal.ROUND_DOWN);
//		            BigDecimal secTime=ls.remainder(new BigDecimal(60)).setScale(0,BigDecimal.ROUND_HALF_DOWN);
////					String min=String.valueOf(minTime);
////					if(min.length()==1){
////						min="0"+min;
////					}
////					String sec=String.valueOf(secTime);
////					if(sec.length()==1){
////						sec="0"+sec;
////					}
//		            fileForm.setMin(min);
//					fileForm.setSec(sec);
	    		}
	    		return fileForm;
	    	}
		}
		return null;
	}
	
	@Override
	public int editCourse(EduCourse course, MultipartFile file) throws Exception{
		if(file.getSize() > 0){
			//����Ŀ¼
			String dateString = DateUtil.getCurrDate2();
			String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+File.separator+"eduImages"+File.separator+ dateString ;
			File fileDir = new File(newDir);
			if(!fileDir.exists()){
				fileDir.mkdirs();
			}
			//�ļ���
			String originalFilename = file.getOriginalFilename();
			originalFilename = PkUtil.getUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
			File newFile = new File(fileDir, originalFilename); 
			file.transferTo(newFile);
			
			//ɾ��ԭͼƬ
			String oldCourseImg = course.getCourseImg();
			if(StringUtil.isNotBlank(oldCourseImg)){
				try {
					oldCourseImg = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir")) + File.separator + oldCourseImg;
					File imgFile = new File(oldCourseImg);
					if(imgFile.exists()){
						imgFile.delete();
					}
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("ɾ��ͼƬʧ�ܣ�");
				}
			}
			
			String courseImg = "eduImages/"+dateString+"/"+originalFilename;
			course.setCourseImg(courseImg);//ͼƬ·��
		}
		String courseTypeId = course.getCourseTypeId();
		if(StringUtil.isNotBlank(courseTypeId)){
			course.setCourseTypeName(EduCourseTypeEnum.getNameById(courseTypeId));
		}
		String courseMajorId = course.getCourseMajorId();
		if(StringUtil.isNotBlank(courseMajorId)){
			course.setCourseMajorName(DictTypeEnum.CourseMajor.getDictNameById(courseMajorId));
		}
		return saveCourse(course);
	}
	
	

	@Override
	public int saveCourse(EduCourse course) {
		if(StringUtil.isNotBlank(course.getCourseFlow())){
			GeneralMethod.setRecordInfo(course, false);
			return eduCourseMapper.updateByPrimaryKeySelective(course);
		}else{
			course.setCourseFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(course, true);
			return eduCourseMapper.insert(course);
		}
	}
	
	@Override
	public List<EduCourse> searchTchCourseList(EduCourse eduCourse,SysUser sysUser) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		if(sysUser!=null){
			paramMap.put("user",sysUser);
		}
		if(eduCourse!=null){
			paramMap.put("course", eduCourse);
		}
		List<EduCourse> stuCourseList=eduCourseExtMapper.searchTchCourseList(paramMap);
		return stuCourseList;
	}

	@Override
	public List<SysUser> searchUserByTch(SysUser sysUser) {
		List<SysUser> stuList=eduCourseExtMapper.searchUserByTch(sysUser);
		return stuList;
	}

	@Override
	public List<EduCourse> searchCourseList(EduCourse course,EduCourseSearchConditionForm form) {
		EduCourseExample example = new EduCourseExample();
		com.pinde.sci.model.mo.EduCourseExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(course.getCourseName())){
			criteria.andCourseNameLike("%"+ course.getCourseName()+"%");
		}
		if(StringUtil.isNotBlank(course.getCourseCategoryId())){
			criteria.andCourseCategoryIdEqualTo(course.getCourseCategoryId());
		}
		if(StringUtil.isNotBlank(course.getCreateUserFlow())){
			criteria.andCreateUserFlowEqualTo(course.getCreateUserFlow());
		}
		if(StringUtil.isNotBlank(course.getCreateUserName())){
			criteria.andCreateUserNameLike("%"+course.getCreateUserName()+"%");
		}
		if(StringUtil.isNotBlank(course.getDeptFlow())){
			criteria.andDeptFlowEqualTo(course.getDeptFlow());
		}
		if(form!=null){
			if(StringUtil.isNotBlank(form.getUpLoadTimeStart())){
				criteria.andUploadTimeGreaterThanOrEqualTo(form.getUpLoadTimeStart());
			}
			if(StringUtil.isNotBlank(form.getUpLoadTimeEnd())){
				criteria.andUploadTimeLessThanOrEqualTo(form.getUpLoadTimeEnd());
			}
			if(form.getCourseStatusIdList()!=null && !form.getCourseStatusIdList().isEmpty()){
				criteria.andCourseStatusIdIn(form.getCourseStatusIdList());
			}
		}
		example.setOrderByClause("create_time desc,NLSSORT(COURSE_NAME,'NLS_SORT = SCHINESE_PINYIN_M')");
		return eduCourseMapper.selectByExample(example);
	}

	@Override
	public EduCourse readCourse(String courseFlow) {
		if(StringUtil.isNotBlank(courseFlow)){
			return eduCourseMapper.selectByPrimaryKey(courseFlow);
		}
		return null;
	}


	@Override
	public int deleteCourseImg(String courseFlow) {
		if(StringUtil.isNotBlank(courseFlow)){
			EduCourse course = readCourse(courseFlow);
			if(course != null){ //�޸Ŀγ�ɾ��
				String img = course.getCourseImg();
				if(StringUtil.isNotBlank(img)){
					try {
						img = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))  + File.separator + img;
						File file = new File(img);
						if(file.exists()){
							boolean delRestlt = file.delete();
							if(delRestlt){//ɾ���ɹ�
								course.setCourseImg(null);
								return eduCourseMapper.updateByPrimaryKey(course);
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
						throw new RuntimeException("ɾ��ͼƬʧ�ܣ�");
					}
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int delCourse(String courseFlow) {
		if(StringUtil.isNotBlank(courseFlow)){
			EduCourse course = readCourse(courseFlow);
			if(course != null){ //�޸Ŀγ�ɾ��
				try {
					String courseImg = course.getCourseImg();
					courseImg = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+ File.separator  + courseImg;
					File imgFile = new File(courseImg);
					if(imgFile.exists()){
						boolean delRestlt = imgFile.delete();
						if(delRestlt){//ɾ��ͼƬ�ɹ�
							
						}
					}
					course.setCourseImg(null);
					course.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
					return eduCourseMapper.updateByPrimaryKey(course);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("ɾ��ͼƬʧ�ܣ�");
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int countUserSelectOneCourse(EduCourse eduCourse) {
		EduStudentCourseExample example=new EduStudentCourseExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(eduCourse.getCourseFlow())){
			criteria.andCourseFlowEqualTo(eduCourse.getCourseFlow());
		}
		
		return eduStudentCourseMapper.countByExample(example);
	}

	@Override
	public List<EduCourse> searchAllCourseList(EduCourse eduCourse,String sort) {
		EduCourseExample example=new EduCourseExample();
		com.pinde.sci.model.mo.EduCourseExample.Criteria criteria=example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(eduCourse.getCourseName())){
			criteria.andCourseNameLike("%"+eduCourse.getCourseName()+"%");
		}
		if(StringUtil.isNotBlank(eduCourse.getCourseMajorId())){
			criteria.andCourseMajorIdEqualTo(eduCourse.getCourseMajorId());
		}
		if(StringUtil.isNotBlank(sort)){
			example.setOrderByClause(sort+" desc");
		}
		return eduCourseMapper.selectByExample(example);
	}

	@Override
	public List<SysUser> userSelectOneCourseList(String courseFlow) {
		List<SysUser> userList=eduCourseExtMapper.searchUserByCourse(courseFlow);
		return userList;
	}
	@Override
	public List<EduCourseSchedule> searchScheduleList(EduCourseSchedule schedule) {
		EduCourseScheduleExample example = new EduCourseScheduleExample();
		com.pinde.sci.model.mo.EduCourseScheduleExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(schedule!=null){
			if(StringUtil.isNotBlank(schedule.getUserFlow())){
				criteria.andUserFlowEqualTo(schedule.getUserFlow());
			}
			if(StringUtil.isNotBlank(schedule.getChapterFlow())){
				criteria.andChapterFlowEqualTo(schedule.getChapterFlow());
			}
			if(StringUtil.isNotBlank(schedule.getCourseFlow())){
				criteria.andCourseFlowEqualTo(schedule.getCourseFlow());
			}
			if(StringUtil.isNotBlank(schedule.getStudyStatusId())){
				criteria.andStudyStatusIdEqualTo(schedule.getStudyStatusId());
			}
			example.setOrderByClause("modify_time desc");
		}
		List<EduCourseSchedule> schList = this.eduCourseScheduleMapper.selectByExample(example);
		
		return schList;
	}

	@Override
	public int countUserAllCredit(String userFlow) {
		return eduCourseExtMapper.countUserAllCredit(userFlow);
	}

	@Override
	public Map<String, Object> countUserByStudyStatus(String courseFlow) {
		Map<String, Object> resultMap=new HashMap<String, Object>();
		Map<String, Object> paramMap=new HashMap<String, Object>();
		for(EduStudyStatusEnum status:EduStudyStatusEnum.values()){
			paramMap.put("courseFlow", courseFlow);
			paramMap.put("studyStatusId",status.getId());
			int count=this.eduCourseExtMapper.countUserByStudyStatus(paramMap);
			resultMap.put(status.getId(), count);
		}
		return resultMap;
	}

	@Override
	public List<EduStudentCourse> searchStudentCourse(EduStudentCourse eduStudentCourse) {
		EduStudentCourseExample example = new EduStudentCourseExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(eduStudentCourse.getUserFlow())){
			criteria.andUserFlowEqualTo(eduStudentCourse.getUserFlow());
		}
		if(StringUtil.isNotBlank(eduStudentCourse.getCourseFlow())){
			criteria.andCourseFlowEqualTo(eduStudentCourse.getCourseFlow());
		}
		return eduStudentCourseMapper.selectByExample(example);
	}

	@Override
	public List<EduCourse> searchCourseListByCourseFlowList(List<String> courseFlowList) {
		if(courseFlowList != null && !courseFlowList.isEmpty()){
			EduCourseExample example = new EduCourseExample();
			example.createCriteria().andCourseFlowIn(courseFlowList).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			//example.setOrderByClause("CREATE_TIME DESC");
			return eduCourseMapper.selectByExample(example);
		}
		return null;
	}

	@Override
	public int chooseCourse(String userFlow, String courseFlow) {
		if(StringUtil.isNotBlank(userFlow)&&StringUtil.isNotBlank(courseFlow)){
			EduStudentCourse eduStudentCourse = new EduStudentCourse();
			eduStudentCourse.setRecordFlow(PkUtil.getUUID());
			eduStudentCourse.setUserFlow(userFlow);
			eduStudentCourse.setCourseFlow(courseFlow);
			eduStudentCourse.setStudyStatusId(EduStudyStatusEnum.Underway.getId());
			eduStudentCourse.setStudyStatusName(EduStudyStatusEnum.Underway.getName());
			eduStudentCourse.setChooseTime(DateUtil.getCurrDateTime());
			eduStudentCourse.setAchieveCredit(GlobalConstant.FLAG_N);
			GeneralMethod.setRecordInfo(eduStudentCourse, true);
			return this.eduStudentCourseMapper.insertSelective(eduStudentCourse);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<EduCourse> searchCourseByCondition(String condition) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("condition", condition);
		return this.eduCourseExtMapper.searchCourseByCondition(paramMap);
	}

	@Override
	public Map<String, Map<String, Object>> searchCourseInfoAndCountByEduUserExt(
			List<EduUserExt> eduUserExtList) {
		Map<String, Map<String, Object>> searchAndCountCourseMap=new HashMap<String, Map<String,Object>>();
		Map<String, Object> searchCourseMap=new HashMap<String, Object>();
		Map<String, Object> countCourseMap=new HashMap<String, Object>();
		if(eduUserExtList!=null && !eduUserExtList.isEmpty()){
		 for(EduUserExt eduUserExt:eduUserExtList){
		  if(eduUserExt!=null){
			 if(eduUserExt.getSysUser()!=null){
				 Map<String,Object> paramMap=new HashMap<String, Object>();
			     paramMap.put("user",eduUserExt.getSysUser());
				 paramMap.put("course", null);
				 List<EduCourse> tchCourseList=eduCourseExtMapper.searchTchCourseList(paramMap);
				 int courseAmount=0;
				 if(tchCourseList!=null && !tchCourseList.isEmpty()){
					 courseAmount=tchCourseList.size();
				 }
				 searchCourseMap.put(eduUserExt.getUserFlow(),tchCourseList);
				 countCourseMap.put(eduUserExt.getUserFlow(), courseAmount);
			 }
		  }				    
		  }
		}
		searchAndCountCourseMap.put("searchCourseMap", searchCourseMap);
		searchAndCountCourseMap.put("countCourseMap", countCourseMap);
		return searchAndCountCourseMap;
	}

	@Override
	public List<EduCourseExt> searchTeacherChapterInfo(Map<String, Object> paramMap) {
		return eduCourseExtMapper.searchTeacherChapterInfo(paramMap);
	}

	@Override
	public List<EduCourse> searchStudentCreditCourses(String userFlow) {
		List<EduCourse> courseList = null;
		if(StringUtil.isNotBlank(userFlow)){
			courseList = this.eduCourseExtMapper.selectStudentCreditCourses(userFlow);
		}
		return courseList;
	}

	@Override
	public String saveResEduCourse(EduCourse course, EduCourseChapter chapter,
			EduCourseForm form) {
		SysUser currUser=GlobalContext.getCurrentUser();
		String courseFlow="";
		String oldCourseFlow="";
	    if(course!=null){
	    	oldCourseFlow=course.getCourseFlow();
	    	//����γ���Ϣ
	    	courseFlow=saveCourseReturnFlow(course);
	    	//���������¼
	    	String userListScope=(String) GlobalContext.getSessionAttribute(GlobalConstant.USER_LIST_SCOPE);
	    	if(GlobalConstant.USER_LIST_PERSONAL.equals(userListScope)){
	    		if(StringUtil.isBlank(oldCourseFlow)){
	    			saveLog(course,currUser,ReqTypeEnum.POST.getId(),"����");
	    		}
	    	}else if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){
	    		if(StringUtil.isNotBlank(oldCourseFlow)){
	    			saveLog(course,currUser,ReqTypeEnum.PUT.getId(),"�޸�");
	    		}
	    	}
	    	//�������/�Ʒ�/��ѧʱ��Ա��Χ
	    	if(form!=null){
	    		this.requireRefBiz.saveRequiredRefs(form.getRequiredDoctorTrainingSpeList(), courseFlow, RequiredUserScopeEnum.Major.getId());
	    		this.requireRefBiz.saveRequiredRefs(form.getRequiredSchDeptList(), courseFlow, RequiredUserScopeEnum.Dept.getId());
	    		this.requireRefBiz.saveRequiredRefs(form.getRequiredUserFlowList(), courseFlow, RequiredUserScopeEnum.User.getId());
	    		this.scoreRefBiz.saveScoreRefs(form.getScoreDoctorTrainingSpeList(), courseFlow, ScoreUserScopeEnum.Major.getId());
	    		this.scoreRefBiz.saveScoreRefs(form.getScoreSchDeptList(), courseFlow, ScoreUserScopeEnum.Dept.getId());
	    		this.scoreRefBiz.saveScoreRefs(form.getScoreUserFlowList(), courseFlow, ScoreUserScopeEnum.User.getId());
	    		this.periodRefBiz.savePeriodRefs(form.getPeriodDoctorTrainingSpeList(), courseFlow, PeriodUserScopeEnum.Major.getId());
	    		this.periodRefBiz.savePeriodRefs(form.getPeriodSchDeptList(), courseFlow, PeriodUserScopeEnum.Dept.getId());
	    		this.periodRefBiz.savePeriodRefs(form.getPeriodUserFlowList(), courseFlow, PeriodUserScopeEnum.User.getId());
	    	}
	    	
	    }
		return courseFlow;
	}

	@Override
	public void saveLog(EduCourse course,SysUser user,String reqType,String operName) {
		if(!GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
			SysLog log=new SysLog();
	    	log.setReqTypeId(reqType);
	    	log.setOperId(OperTypeEnum.Course.getId());
	    	log.setOperName(OperTypeEnum.Course.getName());
	    	log.setResourceFlow(course.getCourseFlow());
	    	log.setLogDesc(user.getUserName()+operName+"�˿γ̣�");
	    	log.setResourceFlow(course.getCourseFlow());
	    	GeneralMethod.addSysLog(log);
	    	logMapper.insert(log);
		}
	}

	@Override
	public String saveCourseReturnFlow(EduCourse course) {
		if(StringUtil.isNotBlank(course.getCourseFlow())){
			GeneralMethod.setRecordInfo(course, false);
		    eduCourseMapper.updateByPrimaryKeySelective(course);
		    return course.getCourseFlow();
		}else{
			course.setCourseFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(course, true);
			eduCourseMapper.insert(course);
			return course.getCourseFlow();
		}
	}
	
	@Override
	public String checkRole(){
		List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST);
		String doctorRoleFlow=InitConfig.getSysCfg("res_doctor_role_flow");
		String tchRoleFlow=InitConfig.getSysCfg("res_teacher_role_flow");
		String headRoleFlow=InitConfig.getSysCfg("res_head_role_flow");
		String adminRoleFlow=InitConfig.getSysCfg("res_admin_role_flow");
		String chargeRoleFlow=InitConfig.getSysCfg("res_charge_role_flow");
		if(currRoleList!=null && !currRoleList.isEmpty()){
			if(currRoleList.contains(doctorRoleFlow)){
				return GlobalConstant.RES_ROLE_SCOPE_DOCTOR;
			}else if(currRoleList.contains(tchRoleFlow)){
				return GlobalConstant.RES_ROLE_SCOPE_TEACHER;
			}else if(currRoleList.contains(headRoleFlow)){
				return GlobalConstant.RES_ROLE_SCOPE_HEAD;
			}else if(currRoleList.contains(adminRoleFlow)){
				return GlobalConstant.RES_ROLE_SCOPE_ADMIN;
			}else if(currRoleList.contains(chargeRoleFlow)){
				return GlobalConstant.RES_ROLE_SCOPE_CHARGE;
			}else{
				return "";
			}
		}
		return null;
	}
	
	@Override
	public Map<String,Object> searchEduCourseRefMap(String courseFlow,String type){
		Map<String,Object> refMap=new HashMap<String, Object>();
		//�����ˮ��
		List<String> requireMajorList=new ArrayList<String>();
		List<String> requireDeptList=new ArrayList<String>();
		List<String> requireUserList=new ArrayList<String>();
		List<String> scoreMajorList=new ArrayList<String>();
		List<String> scoreDeptList=new ArrayList<String>();
		List<String> scoreUserList=new ArrayList<String>();
		List<String> periodMajorList=new ArrayList<String>();
		List<String> periodDeptList=new ArrayList<String>();
		List<String> periodUserList=new ArrayList<String>();
		//���ȫ����Ϣ
		List<EduCourseRequireRef> requireMajors=new ArrayList<EduCourseRequireRef>();
		List<EduCourseRequireRef> requireDepts=new ArrayList<EduCourseRequireRef>();
		List<EduCourseScoreRef> scoreMajors=new ArrayList<EduCourseScoreRef>();
		List<EduCourseScoreRef> scoreDepts=new ArrayList<EduCourseScoreRef>();
		List<EduCoursePeriodRef> periodMajors=new ArrayList<EduCoursePeriodRef>();
		List<EduCoursePeriodRef> periodDepts=new ArrayList<EduCoursePeriodRef>();
		//����
		EduCourseRequireRef requireRef=new EduCourseRequireRef();
		requireRef.setCourseFlow(courseFlow);
		List<EduCourseRequireRef> requireRefList=requireRefBiz.searchRequireRefs(requireRef);
		if(requireRefList!=null && !requireRefList.isEmpty()){
			for(EduCourseRequireRef ref:requireRefList){
				if(RequiredUserScopeEnum.Major.getId().equals(ref.getRefTypeId())){
					if("show".equals(type)){
						requireMajors.add(ref);
					}else{
						requireMajorList.add(ref.getRefFlow());
					}
				}
				if(RequiredUserScopeEnum.Dept.getId().equals(ref.getRefTypeId())){
					if("show".equals(type)){
						requireDepts.add(ref);
					}else{
						requireDeptList.add(ref.getRefFlow());
					}
				}
				if(RequiredUserScopeEnum.User.getId().equals(ref.getRefTypeId())){
					requireUserList.add(ref.getRefFlow());
				}
			}
			refMap.put("requireMajorList", requireMajorList);
			refMap.put("requireMajors", requireMajors);
			refMap.put("requireDeptList", requireDeptList);
			refMap.put("requireDepts", requireDepts);
			refMap.put("requireUserList", requireUserList);
		}
		//�Ʒ�
		EduCourseScoreRef scoreRef=new EduCourseScoreRef();
	    scoreRef.setCourseFlow(courseFlow);
	    List<EduCourseScoreRef> scoreRefList=scoreRefBiz.searchScoreRefs(scoreRef);
	    if(scoreRefList!=null && !scoreRefList.isEmpty()){
			for(EduCourseScoreRef ref:scoreRefList){
				if(ScoreUserScopeEnum.Major.getId().equals(ref.getRefTypeId())){
					if("show".equals(type)){
					  scoreMajors.add(ref);
					}else{
					   scoreMajorList.add(ref.getRefFlow());
					}
				}
				if(ScoreUserScopeEnum.Dept.getId().equals(ref.getRefTypeId())){
					if("show".equals(type)){
						scoreDepts.add(ref);
					}else{
						scoreDeptList.add(ref.getRefFlow());
					}
					
				}
				if(ScoreUserScopeEnum.User.getId().equals(ref.getRefTypeId())){
					scoreUserList.add(ref.getRefFlow());
				}
			}
			refMap.put("scoreMajorList", scoreMajorList);
			refMap.put("scoreMajors", scoreMajors);
			refMap.put("scoreDeptList", scoreDeptList);
			refMap.put("scoreDepts", scoreDepts);
			refMap.put("scoreUserList", scoreUserList);
		}
	    //��ѧʱ
	    EduCoursePeriodRef periodRef=new EduCoursePeriodRef();
	    periodRef.setCourseFlow(courseFlow);
	    List<EduCoursePeriodRef> periodRefList=this.periodRefBiz.searchPeriodRefs(periodRef);
	    if(periodRefList!=null && !periodRefList.isEmpty()){
			for(EduCoursePeriodRef ref:periodRefList){
				if(PeriodUserScopeEnum.Major.getId().equals(ref.getRefTypeId())){
					if("show".equals(type)){
						periodMajors.add(ref);
					}else{
						periodMajorList.add(ref.getRefFlow());
					}
				}
				if(PeriodUserScopeEnum.Dept.getId().equals(ref.getRefTypeId())){
					if("show".equals(type)){
						periodDepts.add(ref);
					}else{
						periodDeptList.add(ref.getRefFlow());
					}
					
				}
				if(PeriodUserScopeEnum.User.getId().equals(ref.getRefTypeId())){
					periodUserList.add(ref.getRefFlow());
				}
			}
			refMap.put("periodMajorList", periodMajorList);
			refMap.put("periodMajors", periodMajors);
		    refMap.put("periodDeptList", periodDeptList);
		    refMap.put("periodDepts", periodDepts);
		    refMap.put("periodUserList", periodUserList);
		}
		return refMap;
	}

	@Override
	public List<EduCourse> searchCourseList(EduCourse course) {
		EduCourseExample example = new EduCourseExample();
		com.pinde.sci.model.mo.EduCourseExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(course!=null){
			if(StringUtil.isNotBlank(course.getCourseName())){
				criteria.andCourseNameLike("%"+ course.getCourseName()+"%");
			}
			if(StringUtil.isNotBlank(course.getCourseTypeId())){
				criteria.andCourseTypeIdEqualTo(course.getCourseTypeId());
			}
			if (StringUtil.isNotBlank(course.getGradationId())) {
				criteria.andGradationIdEqualTo(course.getGradationId());
			}
			if (StringUtil.isNotBlank(course.getCourseCategoryId())) {
				criteria.andCourseCategoryIdEqualTo(course.getCourseCategoryId());
			}
			if (StringUtil.isNotBlank(course.getCourseTypeId())) {
				criteria.andCourseTypeIdEqualTo(course.getCourseTypeId());
			}
			if (StringUtil.isNotBlank(course.getCourseCode())) {
				criteria.andCourseCodeEqualTo(course.getCourseCode());
			}
		}
		example.setOrderByClause("COURSE_MAJOR_ID,NLSSORT(COURSE_NAME,'NLS_SORT = SCHINESE_PINYIN_M')");
		return eduCourseMapper.selectByExample(example);
	}

	
	@Override
	public List<SysUser> userSelectOneCourseListNotIncludeSelf(
			List<String> userFlowList,String courseFlow) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		if(userFlowList!=null && !userFlowList.isEmpty()){
			paramMap.put("userFlowList", userFlowList);
		}
		if(StringUtil.isNotBlank(courseFlow)){
			paramMap.put("courseFlow", courseFlow);
		}
		List<SysUser> userList=eduCourseExtMapper.searchUserByCourseNotIncludeSelf(paramMap);
		return userList;
	}


	@Override
	public void changeCourseStatus(EduCourse course, SysUser user,String type) {
		if(EduCourseStatusEnum.Publish.getId().equals(type)){
			saveLog(course,user,ReqTypeEnum.PUT.getId(),"����");
		}else if(EduCourseStatusEnum.Disabled.getId().equals(type)){
			saveLog(course,user,ReqTypeEnum.PUT.getId(),"ͣ��");
		}
		saveCourse(course);
	}
	
	@Override
	public List<EduStudentCourseForm> searchCourse(Map<String,Object> paramMap) {
		List<EduStudentCourseForm> courseFormList = eduCourseExtMapper.searchCourse(paramMap);
		return courseFormList;
	}
	@Override
	public List<EduCourseExt> selectCourseList(String userFlow,List<String> deptFlow,EduCourse eduCourse,ResDoctor resDoctor,SysUser sysUser) {
		Map<String, Object> map=new HashMap<String, Object>();
		if (StringUtil.isNotBlank(userFlow)) {
			map.put("userFlows", userFlow);
		}
		if (deptFlow!=null && deptFlow.size()>0) {
			map.put("deptFlow", deptFlow);
		}
		if (eduCourse!=null) {
			if (StringUtil.isNotBlank(eduCourse.getCourseName()) 
					|| StringUtil.isNotBlank(eduCourse.getCourseCategoryName())
					|| StringUtil.isNotBlank(eduCourse.getDeptFlow())) {
				map.put("eduCourse", eduCourse);
			}
			
		}
		if (resDoctor!=null) {
			if (StringUtil.isNotBlank(resDoctor.getDoctorCode())) {
				map.put("resDoctor", resDoctor);
			}
		
		}
		if (sysUser!=null) {
			if (StringUtil.isNotBlank(sysUser.getUserName())) {
				map.put("sysUser", sysUser);
			}
			
		}
		
		List<EduCourseExt> eduCourseList =eduCourseExtMapper.selectCourseList(map);
		return eduCourseList;
	}


	@Override
	public List<EduCourse> selectCourse(String userFlow,EduCourse course,List<String> deptFlow) {
		Map<String,Object> map=new HashMap<String, Object>();
		if (userFlow!=null) {
			map.put("userFlow", userFlow);
		}
		if (course!=null) {
			if (StringUtil.isNotBlank(course.getCourseName()) ||
					StringUtil.isNotBlank(course.getCourseCategoryName())) {
				map.put("educourse",course);
			}
		}
		if (deptFlow!=null && !deptFlow.isEmpty()) {
			map.put("deptList",deptFlow);
		}
		List<EduCourse> list=eduCourseExtMapper.seleEduCourse(map);
		return list;
	}


	@Override
	public int importCourseFromExcel(MultipartFile file) {
		InputStream is = null;
		try {
			is =  file.getInputStream();
			byte[] fileData = new byte[(int)file.getSize()];  
			is.read(fileData); 
			Workbook wb = createCommonWorkbook(new ByteInputStream(fileData, (int)file.getSize() ));
			return parseExcel(wb);
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}finally{
			try {
				is.close();
			} catch (IOException e) {
				throw new RuntimeException(e.getMessage());
			}
		}
	}
	
	private Workbook createCommonWorkbook(InputStream inS) throws IOException, InvalidFormatException { 
		// �����ж����Ƿ�֧��mark��reset�������������if��֧�еķ�������֧�� 
		if (!inS.markSupported()) { 
			// ��ԭ����Ϣ 
			inS = new PushbackInputStream(inS); 
		} 
		// EXCEL2003ʹ�õ���΢����ļ�ϵͳ 
		if (POIFSFileSystem.hasPOIFSHeader(inS)) { 
			return new HSSFWorkbook(inS); 
		} 
		// EXCEL2007ʹ�õ���OOM�ļ���ʽ 
		if (POIXMLDocument.hasOOXMLHeader(inS)) { 
			// ����ֱ�Ӵ��������������Ƽ�ʹ��OPCPackage������ 
			return new XSSFWorkbook(OPCPackage.open(inS)); 
		} 
		throw new IOException("���ܽ�����excel�汾"); 
	} 
	
	
	private int parseExcel(Workbook wb){
		int count = 0;
		int sheetNum = wb.getNumberOfSheets();
		if(sheetNum>0){
			List<String> colnames = new ArrayList<String>();
			Sheet sheet;
			try{
				sheet = (HSSFSheet)wb.getSheetAt(0);
			}catch(Exception e){
				sheet = (XSSFSheet)wb.getSheetAt(0);
			}
			int row_num = sheet.getLastRowNum(); 
			//��ȡ��ͷ
			Row titleR =  sheet.getRow(0);
			//��ȡ��ͷ��Ԫ����
			int cell_num = titleR.getLastCellNum();
			String title = "";
			for(int i = 0 ; i <cell_num; i++){
				 title = titleR.getCell(i).getStringCellValue();  
				 colnames.add(title);
			}
			for(int i = 1;i <row_num+1; i++){
				
				Row r =  sheet.getRow(i);
				EduCourse course=new EduCourse();
				String courseName;
				String gradationName;
				String courseTypeName;
				String gradationId;
				String courseTypeId;
				String courseCode;
				String courseNameEn;
				String courseCredit;
				String coursePeriod;
				String coursePeriodTeach;
				String coursePeriodExper;
				String coursePeriodMachine;
				String coursePeriodOther;
				String deptName;
				String deptId;
				
				EduCourse eduCourse=new EduCourse();
				for(int j = 0; j < colnames.size(); j++){  
					String value = "";
				    Cell cell = r.getCell(j);
					if(cell!=null && StringUtil.isNotBlank(cell.toString().trim())){
						if(cell.getCellType() == 1){  
							 value = cell.getStringCellValue().trim();  
						 }else{  
							 value = _doubleTrans(cell.getNumericCellValue()).trim();  
						 }  
					}
					if("����".equals(colnames.get(j))) {
						courseCode = value;
						course.setCourseCode(courseCode);
					}else if("��������".equals(colnames.get(j))){
						courseName = value;
						course.setCourseName(courseName);
					}else if("�ڿβ��".equals(colnames.get(j))){
						gradationName = value;
						course.setGradationName(gradationName);
					}else if("�γ����".equals(colnames.get(j))){
						courseTypeName = value;
						course.setCourseTypeName(courseTypeName);
					}else if("Ӣ������".equals(colnames.get(j))){
						courseNameEn = value;
						course.setCourseNameEn(courseNameEn);
					}else if("ѧ��".equals(colnames.get(j))){
						courseCredit = value;
						course.setCourseCredit(courseCredit);
					}else if("��ѧʱ".equals(colnames.get(j))){
						coursePeriod = value;
						course.setCoursePeriod(coursePeriod);
					}else if("����ѧʱ".equals(colnames.get(j))){
						coursePeriodTeach = value;
						course.setCoursePeriodTeach(coursePeriodTeach);
					}else if("ʵ��ѧʱ".equals(colnames.get(j))){
						coursePeriodExper = value;
						course.setCoursePeriodExper(coursePeriodExper);
					}else if("�ϻ�ѧʱ".equals(colnames.get(j))){
						coursePeriodMachine = value;
						course.setCoursePeriodMachine(coursePeriodMachine);
					}else if("����ѧʱ".equals(colnames.get(j))){
						coursePeriodOther = value;
						course.setCoursePeriodOther(coursePeriodOther);
					}else if("�е���λ".equals(colnames.get(j))){
						deptName = value;
						course.setDeptName(deptName);
					}
				}
				//ִ�б���
					
					List<SysDict> courseTypeList=sysDict(course.getCourseTypeName(),null);
					List<SysDict> gradationList=sysDict(null,course.getGradationName());
					
					eduCourse.setCourseCode(course.getCourseCode());
					List<EduCourse> ecourseList=searchCourseList(eduCourse);
					EduCourse exitCourses=null;
					if (ecourseList!=null&&!ecourseList.isEmpty()) {
						exitCourses=ecourseList.get(0);
					}
					if (exitCourses!=null ) {
						exitCourses.setCourseCode(course.getCourseCode());
						exitCourses.setCourseName(course.getCourseName());
						exitCourses.setGradationName(course.getGradationName());
						exitCourses.setCourseTypeName(course.getCourseTypeName());
						exitCourses.setCourseNameEn(course.getCourseNameEn());
						exitCourses.setCourseCredit(course.getCourseCredit());
						exitCourses.setCoursePeriodTeach(course.getCoursePeriodTeach());
						exitCourses.setCoursePeriod(course.getCoursePeriod());
						exitCourses.setCoursePeriodExper(course.getCoursePeriodExper());
						exitCourses.setCoursePeriodMachine(course.getCoursePeriodMachine());
						exitCourses.setCoursePeriodOther(course.getCoursePeriodOther());
						exitCourses.setDeptName(course.getDeptName());
						exitCourses.setCourseTypeId(courseTypeList.get(0).getDictId());
						exitCourses.setGradationId(gradationList.get(0).getDictId());
						saveCourse(exitCourses);
					}else{
						course.setGradationId(gradationList.get(0).getDictId());
						course.setCourseTypeId(courseTypeList.get(0).getDictId());
						saveCourse(course);
					}
				count ++;
			}
		}
		return count;
	}
	
	public static String _doubleTrans(double d){
        if((double)Math.round(d) - d == 0.0D)
            return String.valueOf((long)d);
        else
            return String.valueOf(d);
    }
	

		
	public List<SysDict> sysDict(String CourseTypeName,String GradationName){
		SysDict dict=new SysDict();
		if (StringUtil.isNotBlank(CourseTypeName)) {
			dict.setDictTypeId("XjCourseType");
			dict.setDictName(CourseTypeName);
		}
		
		if (StringUtil.isNotBlank(GradationName)) {
			dict.setDictTypeId("TrainType");
			dict.setDictName(GradationName);
		}
		
		List<SysDict> dictList=iDict.searchDictList(dict);
		return dictList;
	}
	@Override
	public List<EduCourse> searchCourseNameByCourseFlowList(
			List<String> courseFlowList, EduCourse course) {
		EduCourseExample example = new EduCourseExample();
		com.pinde.sci.model.mo.EduCourseExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(courseFlowList != null && !courseFlowList.isEmpty()){
			criteria.andCourseFlowIn(courseFlowList);
		}
		if(StringUtil.isNotBlank(course.getCourseName())){
			criteria.andCourseNameLike("%"+ course.getCourseName()+"%");
		}
		return eduCourseMapper.selectByExample(example);
	}
	
	
	
}
