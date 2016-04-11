package com.pinde.sci.biz.edu.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.pinde.core.util.JaxbUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduUserBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.EduUserMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.edu.EduUserExtMapper;
import com.pinde.sci.enums.pub.UserNationEnum;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.res.CertificateTypeEnum;
import com.pinde.sci.enums.res.RecDocCategoryEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.MarriageTypeEnum;
import com.pinde.sci.enums.sys.PoliticsAppearanceEnum;
import com.pinde.sci.form.edu.EduUserExtInfoForm;
import com.pinde.sci.form.edu.EduUserForm;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.EduUserExample;
import com.pinde.sci.model.mo.EduUserExample.Criteria;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;
import com.pinde.sci.model.mo.SysUserRole;
import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;
@Service
@Transactional(rollbackFor=Exception.class)
public class EduUserBizImpl implements IEduUserBiz {
	@Autowired
	private EduUserMapper eduUserMapper;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private EduUserExtMapper eduUserExtMapper;
	@Autowired
	private SysUserMapper sysUserMapper;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	
	private static final String PERSONAL = "personal";
	private static final String BASICINFO = "basicInfo";
	private static final String DOMICILE = "domicile";
	private static final String FILE = "file";
	private static final String MAJOR = "major";
	private static final String POLITICS = "politics";
	private static final String PAY  = "pay ";
	private static final String ADMIT = "admit";
	private static final String DIRECTTRAIN = "directTrain";
	private static final String REMARK = "remark";
	
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
				return "success:eduImages/"+dateString+"/"+fileName;
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
		userBiz.saveUser(sysUser);	
		String userFlow = sysUser.getUserFlow();
		eduUser.setUserFlow(userFlow);
		addEduUser(eduUser);
		//角色
		SysUserRole userRole = new SysUserRole();
		userRole.setRoleFlow(PkUtil.getUUID());
		userRole.setUserFlow(userFlow);
		userRole.setWsId(GlobalConstant.EDU_WS_ID);
		//开关获取
		if(GlobalConstant.TEACHER_ROLE.equals(type)){
			userRole.setRoleFlow(InitConfig.getSysCfg("teacher_role_flow"));
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


	@Override
	public int saveEduUser(EduUser eduUser) {
		if(StringUtil.isNotBlank(eduUser.getUserFlow())){
			GeneralMethod.setRecordInfo(eduUser, false);
			return eduUserMapper.updateByPrimaryKeySelective(eduUser);
		}else{
			eduUser.setUserFlow(PkUtil.getUUID());
			return onlySaveEduUser(eduUser);
		}
	}
	
	private int onlySaveEduUser(EduUser eduUser){
		GeneralMethod.setRecordInfo(eduUser, true);
		return eduUserMapper.insertSelective(eduUser);
	}
	@Override
	public List<EduUser> search(EduUser eduUser) {
		EduUserExample example=new EduUserExample();
		 example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return eduUserMapper.selectByExample(example);
	}
	
	@Override
	public int save(EduUserForm form){
		if(form!=null){
			String docRole = InitConfig.getSysCfg("res_doctor_role_flow");
			SysUser user=form.getSysUser();
			EduUser eduUser=form.getEduUser();
			ResDoctor resDoctor=form.getResDoctor();
			resDoctor.setDoctorCategoryId(RecDocCategoryEnum.Graduate.getId());
			resDoctor.setDoctorCategoryName(RecDocCategoryEnum.Graduate.getName());
			
			if(user!=null){
				userBiz.saveUser(user);
				userRoleBiz.saveSysUserRole(user.getUserFlow(),docRole);
				if(resDoctor!=null){
					if(StringUtil.isNotBlank(resDoctor.getDoctorFlow())){
						resDoctorBiz.editDoctor(resDoctor);
					}else{
						String userFlow=user.getUserFlow();
						resDoctor.setDoctorFlow(userFlow);
						resDoctorBiz.onlySaveResDoctor(resDoctor);
					}
				}
				if(eduUser!=null){
					EduUserExtInfoForm eduUserExtInfoForm=form.getEduUserExtInfoForm();
					String content = JaxbUtil.convertToXml(eduUserExtInfoForm);
					eduUser.setContent(content);
					if(StringUtil.isNotBlank(eduUser.getUserFlow())){
						return saveEduUser(eduUser);
					}else{
						String userFlow=user.getUserFlow();
						eduUser.setUserFlow(userFlow);
						return onlySaveEduUser(eduUser);
					}
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public EduUser findByFlow(String userFlow) {
		return eduUserMapper.selectByPrimaryKey(userFlow);
	}
	@Override
	public List<EduUser> searchEduUserBySysUser(Map<String, Object> paramMap){
		return eduUserExtMapper.searchEduUserBySysUser(paramMap);
	}
	@Override
	public List<EduUser> searchEduByOrg(String orgFlow){
		EduUserExample example = new EduUserExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(orgFlow);
		return eduUserMapper.selectByExample(example);
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

	private int parseExcel(Workbook wb) {
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
			//获取表头
			Row titleR =  sheet.getRow(0);
			//获取表头单元格数
			int cell_num = titleR.getLastCellNum();
			String title = "";
			for(int i = 0 ; i <cell_num; i++){
				 title = titleR.getCell(i).getStringCellValue();  
				 colnames.add(title);
			}
			if(row_num<1){
				throw new RuntimeException("没有数据");
			}
			for(int i = 1;i <=row_num; i++){
				Row r =  sheet.getRow(i);
            	SysUser sysUser = new SysUser();
            	EduUser eduUser = new EduUser();
            	ResDoctor resDoctor = new ResDoctor();
            	EduUserExtInfoForm euInfo =new EduUserExtInfoForm();
            	EduUserForm eduUserForm=new EduUserForm();
            	eduUserForm.setEduUser(eduUser);
            	eduUserForm.setEduUserExtInfoForm(euInfo);
            	eduUserForm.setSysUser(sysUser);
            	eduUserForm.setResDoctor(resDoctor);
            	String period;//入学年级
            	String className;//班级
            	String sid;//学号
            	String userName;//姓名
            	String studentCode;//考生编号
            	String cretTypeId;//证件类型码
            	String idNo;//证件号码
            	String userBirthday;//出生日期
            	String nationId;//民族码
            	String sexId;//性别码
            	String maritalId;//婚姻状况id
            	String politicsStatusId;//政治面貌码
            	String admitTypeId;//录取类别码
            	String majorName;//专业名称
            	String userEmail;//邮箱地址
            	String userPhone;//手机号码
            	String weiXinId;//微信
				for(int j = 0; j < colnames.size(); j++){  
					String value = "";
				    Cell cell = r.getCell(j);
				    if(cell == null){
				    	continue;
				    }
					if(cell!=null && StringUtil.isNotBlank(cell.toString().trim())){
						if(cell.getCellType() == 1){  
							 value = cell.getStringCellValue().trim();  
						 }else{  
							 value = _doubleTrans(cell.getNumericCellValue()).trim();  
						 }  
					}
					if("入学年级".equals(colnames.get(j))){
						period = value;
						eduUser.setPeriod(period);
					}
					else if("班级".equals(colnames.get(j))){
						className = value;
						eduUser.setClassName(className);
						if(StringUtil.isNotBlank(className)){
							eduUser.setClassId(getClassIdByName(className));
						}
					}else if("学号".equals(colnames.get(j))){
						sid = value;
						eduUser.setSid(sid);
						sysUser.setUserCode(sid);
						resDoctor.setDoctorCode(sid);
					}else if("姓名".equals(colnames.get(j))){
						userName = value;
						sysUser.setUserName(userName);
						resDoctor.setDoctorName(userName);
					}else if("考生编号".equals(colnames.get(j))){
						studentCode = value;
						eduUser.setStudentCode(studentCode);
					}else if("证件类型码".equals(colnames.get(j))){
						cretTypeId = value;
						sysUser.setCretTypeId(cretTypeId);
						if(StringUtil.isNotBlank(cretTypeId)){
							sysUser.setCretTypeName(CertificateTypeEnum.getNameById(cretTypeId)); 
						}
					}else if("证件号码".equals(colnames.get(j))){
						idNo = value;
						sysUser.setIdNo(idNo);
					}else if("出生日期".equals(colnames.get(j))){
						userBirthday = value;
						sysUser.setUserBirthday(userBirthday);
					}else if("民族码".equals(colnames.get(j))){
						nationId = value;
						sysUser.setNationId(nationId);
						if(StringUtil.isNotBlank(nationId)){
							sysUser.setNationName(UserNationEnum.getNameById(nationId)); 
						}
					}else if("婚姻状况".equals(colnames.get(j))){
						maritalId = value;
						sysUser.setMaritalId(maritalId);
						if(StringUtil.isNotBlank(maritalId)){
							sysUser.setMaritalName(MarriageTypeEnum.getNameById(maritalId));
						}
					}else if("政治面貌码".equals(colnames.get(j))){
						politicsStatusId = value;
						sysUser.setPoliticsStatusId(politicsStatusId);
						if(StringUtil.isNotBlank(politicsStatusId)){
							sysUser.setPoliticsStatusName(PoliticsAppearanceEnum.getNameById(politicsStatusId));
						}
					}else if("性别码".equals(colnames.get(j))){
						sexId = value;
						sysUser.setSexId(trainSex(sexId));
						if(StringUtil.isNotBlank(sexId)){
							sysUser.setSexName(UserSexEnum.getNameById(sysUser.getSexId()));
						}
					}else if("电子邮箱".equals(colnames.get(j))){
						userEmail = value;
						sysUser.setUserEmail(userEmail);
					}else if("手机号码".equals(colnames.get(j))){
						userPhone = value;
						sysUser.setUserPhone(userPhone);
					}else if("微信号".equals(colnames.get(j))){
						weiXinId = value;
						sysUser.setWeiXinName(weiXinId);
					}else if("录取类别码".equals(colnames.get(j))){
						admitTypeId = value;
						eduUser.setAdmitTypeId(admitTypeId);
						eduUser.setAdmitTypeName(DictTypeEnum.AdmitType.getDictNameById(admitTypeId));
					}else if("录取专业名称".equals(colnames.get(j))){
						majorName = value;
						eduUser.setMajorName(majorName);
					}
				}
				SysUser currUser=GlobalContext.getCurrentUser();
				String orgFlow=currUser.getOrgFlow();
				String orgName=currUser.getOrgName();
				sysUser.setOrgFlow(orgFlow);
				sysUser.setOrgName(orgName);
				if(StringUtil.isBlank(sysUser.getUserCode())){
					continue;
				}
				//验证同一机构的用户登录名
				if(StringUtil.isNotBlank(sysUser.getOrgFlow()) && StringUtil.isNotBlank(sysUser.getUserCode())){
					List<SysUser> sysUserList = userBiz.searchUserByUserCode(sysUser.getUserCode());
					if(sysUserList != null && !sysUserList.isEmpty()){
						SysUser exitUser = sysUserList.get(0);
						sysUser.setUserFlow(exitUser.getUserFlow());
						eduUser.setUserFlow(exitUser.getUserFlow());
						resDoctor.setDoctorFlow(exitUser.getUserFlow());
					}		
				}
				save(eduUserForm);
				count ++;
			}
		}	
			
		return count;
	}
		
	private String trainSex(String sexId) {
		if("1".equals(sexId)){
			return UserSexEnum.Man.getId();
		}else if("2".equals(sexId)){
			return UserSexEnum.Woman.getId();
		}
		return null;
	}
	
	private String trainMajor(String majorName) {
		
		return null;
	}

	private String getClassIdByName(String className) {
		if("2015级硕士研究生一教班".equals(className)){
			return "1";
		}else if("2015级硕士研究生二教班".equals(className)){
			return "2";
		}else if("2015级硕士研究生三教班".equals(className)){
			return "3";
		}else if("2015级硕士研究生四教班".equals(className)){
			return "4";
		}else if("2015级硕士研究生五教班".equals(className)){
			return "5";
		}
		return null;
	}

	public static String _doubleTrans(double d){
        if((double)Math.round(d) - d == 0.0D)
            return String.valueOf((long)d);
        else
            return String.valueOf(d);
    }
			

	private Workbook createCommonWorkbook(InputStream inS) throws IOException, InvalidFormatException { 
		// 首先判断流是否支持mark和reset方法，最后两个if分支中的方法才能支持 
		if (!inS.markSupported()) { 
			// 还原流信息 
			inS = new PushbackInputStream(inS); 
		} 
		// EXCEL2003使用的是微软的文件系统 
		if (POIFSFileSystem.hasPOIFSHeader(inS)) { 
			return new HSSFWorkbook(inS); 
		} 
		// EXCEL2007使用的是OOM文件格式 
		if (POIXMLDocument.hasOOXMLHeader(inS)) { 
			// 可以直接传流参数，但是推荐使用OPCPackage容器打开 
			return new XSSFWorkbook(OPCPackage.open(inS)); 
		} 
		throw new IOException("不能解析的excel版本"); 
	}

	@Override
	public List<EduUser> searchEduUserByUserFlowList(List<String> userFlowList) {
		List<EduUser> eduUserList = null;
		if(userFlowList != null && !userFlowList.isEmpty()){
			EduUserExample example = new EduUserExample();
			Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			if(userFlowList != null && !userFlowList.isEmpty()){
				criteria.andUserFlowIn(userFlowList);
			}
			eduUserList = eduUserMapper.selectByExample(example);
		}
		return eduUserList;
	}
	@Override
	public EduUser findBySid(String sid) {
		EduUserExample example = new EduUserExample();
		Criteria criteria=example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andSidEqualTo(sid);
		List<EduUser> eduUserList = eduUserMapper.selectByExample(example);
		if(eduUserList.size()>0){
			return eduUserList.get(0);
		}		
		return null;
	}
	@Override
	public EduUser findBySidNotSelf(String userFlow,String sid) {
		EduUserExample example = new EduUserExample();
		Criteria criteria=example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andSidEqualTo(sid);
		criteria.andUserFlowNotEqualTo(userFlow);
		List<EduUser> eduUserList = eduUserMapper.selectByExample(example);
		if(eduUserList.size()>0){
			return eduUserList.get(0);
		}		
		return null;
	}
	@Override
	public List<EduUserExt> searchStudentCourseMaintainList(Map<String, Object> paramMap) {
		return eduUserExtMapper.searchStudentCourseMaintainList(paramMap);
	}

	@Override
	public List<EduUserExt> selectEduUserStudentCourseSun(SysUser sysUser,EduUser eduUser,EduCourse course) {
		Map<String, Object> map=new HashMap<String, Object>();
		if (sysUser!=null) {
			if (StringUtil.isNotBlank(sysUser.getIdNo()) || StringUtil.isNotBlank(sysUser.getUserName())) {
				map.put("sysUser", sysUser);
			}
		}
		if (eduUser!=null) {
			if (StringUtil.isNotBlank(eduUser.getSid())) {
				map.put("eduUser", eduUser);
			}
		}
		if (course!=null) {
			if (StringUtil.isNotBlank(course.getCourseName())) {
				map.put("course", course);
			}
		}
		List<EduUserExt> studentCourseList=eduUserExtMapper.selectEduUserStudentCourseSun(map);
		return studentCourseList;
	}


	@Override
	public List<EduUserExt> searchEduUserExtList(Map<String, Object> paramMap) {
		return eduUserExtMapper.searchEduUserExtList(paramMap);
	}
	@Override
	public List<EduUser> searchEduUser(EduUser eudUser) {
		EduUserExample example = new EduUserExample();
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return eduUserMapper.selectByExample(example);
	}

	@Override
	public EduUserExt searchEduUserCourseExtMajorSunList(String userFlow,String majorId,String period,String courseName) {
		Map<String, Object> map=new HashMap<String, Object>();
		if (StringUtil.isNotBlank(userFlow)) {
			map.put("userFlow",userFlow);
		}
		if (StringUtil.isNotBlank(majorId)) {
			map.put("majorId",majorId);
		}
		if (StringUtil.isNotBlank(period)) {
			map.put("period",period);
		}
		if (StringUtil.isNotBlank(courseName)) {
			map.put("courseName",courseName);
		}
		EduUserExt studentCourse=eduUserExtMapper.searchEduUserCourseExtMajorSunList(map);
		return studentCourse;
	}


}

