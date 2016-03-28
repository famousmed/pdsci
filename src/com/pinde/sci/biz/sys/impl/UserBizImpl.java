package com.pinde.sci.biz.sys.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.core.util.VelocityUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.edu.IEduStudentCourseBiz;
import com.pinde.sci.biz.edu.IEduUserBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduUserBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.WeixinQiYeUtil;
import com.pinde.sci.dao.base.SysDeptMapper;
import com.pinde.sci.dao.base.SysUserDeptMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.sys.SysUserExtMapper;
import com.pinde.sci.enums.edu.EduCourseTypeEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.res.CertificateTypeEnum;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.FstuStudy;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.SchRotationDeptExample;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserDept;
import com.pinde.sci.model.mo.SysUserDeptExample;
import com.pinde.sci.model.mo.SysUserExample;
import com.pinde.sci.model.mo.SysUserExample.Criteria;
import com.pinde.sci.model.mo.SysUserRole;
import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;

@Service
@Transactional(rollbackFor=Exception.class)
public class UserBizImpl implements IUserBiz {

	private static Logger logger = LoggerFactory.getLogger(UserBizImpl.class);
	
	@Resource
	private SysUserMapper sysUserMapper;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IEduCourseBiz eduCourseBiz;
	@Autowired
	private SysUserExtMapper userExtMapper;
	@Resource
	private SysDeptMapper sysDeptMapper;
	@Autowired
	private IEduUserBiz eduUserBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private SysUserDeptMapper userDeptMapper;
	@Autowired
	private INjmuEduUserBiz njmueduUserBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IEduStudentCourseBiz studentCourseBiz;
	
	@Override
	public SysUser readSysUser(String sysUserFlow) {
		return sysUserMapper.selectByPrimaryKey(sysUserFlow);
	}
	
	@Override
	public int addUser(SysUser user) {
		user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), GlobalConstant.INIT_PASSWORD));
		user.setStatusId(UserStatusEnum.Activated.getId());
		user.setStatusDesc(UserStatusEnum.Activated.getName());
		GeneralMethod.setRecordInfo(user, true);
		return sysUserMapper.insert(user);
	}
	
	@Override
	public int insertUser(SysUser user) {
		GeneralMethod.setRecordInfo(user, true);
		return sysUserMapper.insert(user);
	}
	
	@Override
	public SysUser searcherUserByOrgFlow(String orgFlow){
		SysUserExample sysUserExample = new SysUserExample();
		sysUserExample.createCriteria().andOrgFlowEqualTo(orgFlow);
		List<SysUser> userList = sysUserMapper.selectByExample(sysUserExample);
		SysUser user = null;
		if(userList!=null && userList.size()>0){
			user = userList.get(0);
		}
		return user;
	}
	
	@Override
	public int saveUser(SysUser user,String roleFlow) {
		if(user != null){
			boolean haveRole = StringUtil.isNotBlank(user.getUserFlow());
			saveUser(user);
			if(!haveRole){
				SysUserRole userRole = new SysUserRole();
				userRole.setUserFlow(user.getUserFlow());
				userRole.setOrgFlow(user.getOrgFlow());
				userRole.setWsId((String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
				userRole.setRoleFlow(roleFlow);
				userRole.setAuthTime(DateUtil.getCurrDateTime());
				userRole.setAuthUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				userRoleBiz.saveSysUserRole(userRole);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveUser(SysUser user) {
		String currWsId = (String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		String userFlow = user.getUserFlow();
		if(StringUtil.isNotBlank(userFlow)){
			GeneralMethod.setRecordInfo(user, false);
			int ret = sysUserMapper.updateByPrimaryKeySelective(user);
			if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("sys_weixin_qiye_flag"))){
				//全部同步后saveUser改称update
				user = sysUserMapper.selectByPrimaryKey(userFlow);
				boolean result = false;
				if(StringUtil.isNotBlank(InitConfig.getSysCfg("sys_weixin_qiye_dept_id"))){
					 result = WeixinQiYeUtil.saveUser(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"), InitConfig.getSysCfg("sys_weixin_qiye_dept_id"), user);
				}else{
					if(StringUtil.isNotBlank(user.getDeptFlow())){
						SysDept sysDept = sysDeptMapper.selectByPrimaryKey(user.getDeptFlow());
						String deptCode = null;
						if(sysDept!=null){
							deptCode = sysDept.getDeptCode();
						}
						result = WeixinQiYeUtil.saveUser(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"), deptCode, user);
					}
				}
				logger.debug("wei xin qi ye saveuser is "+result);
			}
			if(GlobalConstant.EDU_WS_ID.equals(currWsId)){//edu工作站
				EduUser findEduUser = this.eduUserBiz.readEduUser(userFlow);
				if(findEduUser==null){
					EduUser eduUser = new EduUser();
					eduUser.setUserFlow(userFlow);
					GeneralMethod.setRecordInfo(eduUser, true);
					this.eduUserBiz.addEduUser(eduUser);
				}
			}
			if(GlobalConstant.NJMUEDU_WS_ID.equals(currWsId)){//njmuedu工作站
				EduUser findEduUser = this.eduUserBiz.readEduUser(userFlow);
				if(findEduUser==null){
					EduUser eduUser = new EduUser();
					eduUser.setUserFlow(userFlow);
					GeneralMethod.setRecordInfo(eduUser, true);
					this.njmueduUserBiz.addEduUser(eduUser);
				}
			}
			return ret;
		}else{
			user.setUserFlow(PkUtil.getUUID());
			user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), GlobalConstant.INIT_PASSWORD));
			user.setStatusId(UserStatusEnum.Activated.getId());
			user.setStatusDesc(UserStatusEnum.Activated.getName());
			if(StringUtil.isBlank(user.getCretTypeId())){
				//默认证件类型是身份证
				user.setCretTypeId(CertificateTypeEnum.Shenfenzheng.getId());
				user.setCretTypeName(CertificateTypeEnum.Shenfenzheng.getName());
			}else{
				try{
					user.setCretTypeName(CertificateTypeEnum.getNameById(user.getCretTypeId()));
				}catch(Exception e){
					e.printStackTrace();
				}finally{
					user.setCretTypeId(CertificateTypeEnum.Shenfenzheng.getId());
					user.setCretTypeName(CertificateTypeEnum.Shenfenzheng.getName());
				}
			}
			GeneralMethod.setRecordInfo(user, true);
			
			if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("sys_weixin_qiye_flag"))){
				boolean result = false;
				if(StringUtil.isNotBlank(InitConfig.getSysCfg("sys_weixin_qiye_dept_id"))){
					result = WeixinQiYeUtil.createUser(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"), InitConfig.getSysCfg("sys_weixin_qiye_dept_id"), user);
				}else{
					if(StringUtil.isNotBlank(user.getDeptFlow())){
						SysDept sysDept = sysDeptMapper.selectByPrimaryKey(user.getDeptFlow());
						String deptCode = null;
						if(sysDept!=null){
							deptCode = sysDept.getDeptCode();
						}
						result = WeixinQiYeUtil.createUser(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"), deptCode, user);
					}
				}
				logger.debug("wei xin qi ye createUser is "+result);
			}
			int ret = sysUserMapper.insert(user);
			if(GlobalConstant.EDU_WS_ID.equals(currWsId)){//edu工作站
				EduUser eduUser = new EduUser();
				eduUser.setUserFlow(userFlow);
				GeneralMethod.setRecordInfo(eduUser, true);
				this.eduUserBiz.addEduUser(eduUser);
			}
			if(GlobalConstant.NJMUEDU_WS_ID.equals(currWsId)){//njmuedu工作站
				EduUser eduUser = new EduUser();
				eduUser.setUserFlow(userFlow);
				GeneralMethod.setRecordInfo(eduUser, true);
				this.njmueduUserBiz.addEduUser(eduUser);
			}
			return ret;
		}
		
	}
	
	@Override
	public List<SysUser> searchUser(SysUser sysUser) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		setUserCriteria(criteria , sysUser);
		sysUserExample.setOrderByClause(" NLSSORT(USER_NAME,'NLS_SORT = SCHINESE_PINYIN_M')");
		if(StringUtil.isNotBlank(sysUser.getUserName())){ 
			criteria.andUserNameLike("%"+sysUser.getUserName()+"%");
		}
		if(StringUtil.isNotBlank(sysUser.getOrgFlow())){ 
			criteria.andOrgFlowEqualTo(sysUser.getOrgFlow());
		}
		if(StringUtil.isNotBlank(sysUser.getOrgName())){ 
			criteria.andOrgNameLike("%"+sysUser.getOrgName()+"%");
		}
		if(StringUtil.isNotBlank(sysUser.getIdNo())){ 
			criteria.andIdNoEqualTo(sysUser.getIdNo());
		}
		if(StringUtil.isNotBlank(sysUser.getUserCode())){ 
			criteria.andUserCodeEqualTo(sysUser.getUserCode());
		}
		return sysUserMapper.selectByExample(sysUserExample);
	}
	
	@Override
	public List<SysUser> searchUserByRoleAndOrgFlows(String roleFlow,List<String> orgFlows) {
		return userExtMapper.searchUserByRoleAndOrgFlows(roleFlow,orgFlows);
	}
	
	@Override
	public List<SysUser> searchUserByOrgFlow(SysUser sysUser , List<String> orgFlows) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(sysUser.getOrgFlow())){
			criteria.andOrgFlowEqualTo(sysUser.getOrgFlow());
		}else if(orgFlows!=null &&!orgFlows.isEmpty()){
			criteria.andOrgFlowIn(orgFlows);
		}
		setUserCriteria(criteria , sysUser);
		sysUserExample.setOrderByClause(" NLSSORT(USER_NAME,'NLS_SORT = SCHINESE_PINYIN_M')");
		return sysUserMapper.selectByExample(sysUserExample);
	}
	
	private void setUserCriteria(Criteria criteria , SysUser sysUser){
		if(StringUtil.isNotBlank(sysUser.getUserName())){
			criteria.andUserNameLike("%"+sysUser.getUserName()+"%");
		}
		if(StringUtil.isNotBlank(sysUser.getSrmExpertFlag())){
			criteria.andSrmExpertFlagEqualTo(sysUser.getSrmExpertFlag());
		}
		if(StringUtil.isNotBlank(sysUser.getIdNo())){
			criteria.andIdNoEqualTo(sysUser.getIdNo());
		}
		if(StringUtil.isNotBlank(sysUser.getUserPhone())){
			criteria.andUserPhoneEqualTo((sysUser.getUserPhone()));
		}
		if(StringUtil.isNotBlank(sysUser.getUserEmail())){
			criteria.andUserEmailEqualTo(sysUser.getUserEmail());
		}
		if(StringUtil.isNotBlank(sysUser.getStatusId())){
			criteria.andStatusIdEqualTo(sysUser.getStatusId());
		}
		if(StringUtil.isNotBlank(sysUser.getDeptFlow())){
			criteria.andDeptFlowEqualTo(sysUser.getDeptFlow());
		}
		if(StringUtil.isNotBlank(sysUser.getOrgFlow())){
			criteria.andOrgFlowEqualTo(sysUser.getOrgFlow());
		}
		if(StringUtil.isNotBlank(sysUser.getOrgName())){ 
			criteria.andOrgNameLike("%"+sysUser.getOrgName()+"%");
		}
	}

	@Override
	public SysUser findByUserCode(String userCode) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andUserCodeEqualTo(userCode);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()>0){
			return sysUserList.get(0);
		}		
		return null;
	}
	@Override
	public SysUser findByUserCodeAndOrgFlow(String userCode,String orgFlow) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andUserCodeEqualTo(userCode).andOrgFlowEqualTo(orgFlow); 
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()>0){
			return sysUserList.get(0);
		}		
		return null;
	}

	@Override
	public SysUser findByIdNo(String idNo) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andIdNoEqualTo(idNo);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()>0){
			return sysUserList.get(0);
		}		
		return null;
	}

	@Override
	public SysUser findByUserPhone(String userPhone) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andUserPhoneEqualTo(userPhone);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()>0){
			return sysUserList.get(0);
		}		
		return null;
	}

	@Override
	public SysUser findByUserEmail(String userEmail) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andUserEmailEqualTo(userEmail);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()>0){
			return sysUserList.get(0);
		}		
		return null;
	}
	
	@Override
	public SysUser findByUserName(String userName) {
		SysUserExample sysUserExample = new SysUserExample();
		Criteria criteria = sysUserExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andUserNameEqualTo(userName);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size() > 0){
			return sysUserList.get(0);
		}		
		return null;
	}

	@Override
	public SysUser findByUserCodeNotSelf(String userFlow,String userCode) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andUserCodeEqualTo(userCode);
		criteria.andUserFlowNotEqualTo(userFlow);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()>0){
			return sysUserList.get(0);
		}		
		return null;
	}

	@Override
	public SysUser findByIdNoNotSelf(String userFlow,String idNo) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andIdNoEqualTo(idNo);
		criteria.andUserFlowNotEqualTo(userFlow);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()>0){
			return sysUserList.get(0);
		}		
		return null;
	}

	@Override
	public SysUser findByUserPhoneNotSelf(String userFlow,String userPhone) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andUserPhoneEqualTo(userPhone);
		criteria.andUserFlowNotEqualTo(userFlow);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()>0){
			return sysUserList.get(0);
		}		
		return null;
	}

	@Override
	public SysUser findByUserEmailNotSelf(String userFlow,String userEmail) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andUserEmailEqualTo(userEmail);
		criteria.andUserFlowNotEqualTo(userFlow);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()>0){
			return sysUserList.get(0);
		}		
		return null;
	}
	
	@Override
	public int updateUser(SysUser sysUser) {
		if(StringUtil.isNotBlank(sysUser.getUserFlow())){
			GeneralMethod.setRecordInfo(sysUser, false);
			return sysUserMapper.updateByPrimaryKeySelective(sysUser);		
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public void modifyUserByExample(SysUser user) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria = sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		if(StringUtil.isNotBlank(user.getOrgFlow())){
			criteria.andOrgFlowEqualTo(user.getOrgFlow());
		}
		this.sysUserMapper.updateByExampleSelective(user, sysUserExample);
		
	}
	
	@Override
	public List<SysUser> searchSysUserByuserFlows(List<String> userFlows){
		if(userFlows != null && !userFlows.isEmpty()){
			SysUserExample sysUserExample = new SysUserExample();
			sysUserExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowIn(userFlows);
			return sysUserMapper.selectByExample(sysUserExample);
		}
		return null;
	}
	
	@Override
	public List<SysUser> searchSysUserByuserFlows(List<String> userFlows,String deptFlow){
		if(userFlows != null && !userFlows.isEmpty()){
			SysUserExample sysUserExample = new SysUserExample();
			sysUserExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowIn(userFlows).andDeptFlowEqualTo(deptFlow);
			return sysUserMapper.selectByExample(sysUserExample);
		}
		return null;
	}
	
	@Override
	public List<SysUser> searchSysUserByOrgFlows(List<String> orgFlows){
		SysUserExample sysUserExample = new SysUserExample();
		sysUserExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowIn(orgFlows);
		return sysUserMapper.selectByExample(sysUserExample);
	}

	@Override
	public void activateUser(SysUser user) {
		user.setStatusId(UserStatusEnum.Activated.getId());
		user.setStatusDesc(UserStatusEnum.Activated.getName());
		saveUser(user);
		if(GlobalConstant.EDU_WS_ID.equals((String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID))){
			/*edu 插入必修课*/
			EduCourse course = new EduCourse();
			course.setCourseTypeId(EduCourseTypeEnum.Required.getId());
			List<EduCourse> courseList = this.eduCourseBiz.searchCourseList(course);
			if(courseList!=null&&!courseList.isEmpty()){
				String userFlow = user.getUserFlow();
				for (EduCourse ec : courseList) {
					this.eduCourseBiz.chooseCourse(userFlow, ec.getCourseFlow());
				}
			}
		}
	}

	@Override
	public List<SysUser> searchUserListByOrgFlow(Map<String, Object> paramMap) {
		return userExtMapper.searchUserListByOrgFlow(paramMap);
	}

	@Override
	public List<SysUser> findUserByOrgFlowAndRoleFlow(String orgFlow,
			String roleFlow) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(StringUtil.isNotBlank(orgFlow)){
			paramMap.put("orgFlow", orgFlow);
		}
		if(StringUtil.isNotBlank(roleFlow)){
			paramMap.put("roleFlow", roleFlow);
		}
		return this.userExtMapper.selectUserByOrgFlowAndRoleFlow(paramMap);
	}

	@Override
	public List<SysUser> searchUserByStatus(SysUser user) {
		SysUserExample sysUserExample=new SysUserExample();
		sysUserExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andStatusIdEqualTo(user.getStatusId());
		sysUserExample.setOrderByClause(" NLSSORT(USER_NAME,'NLS_SORT = SCHINESE_PINYIN_M')");
		return sysUserMapper.selectByExample(sysUserExample);
	}

	@Override
	public List<SysUser> searchUserByMenu(Map<String, Object> paramMap) {
		List<SysUser> userList=this.userExtMapper.selectUserByMenuId(paramMap);
		return userList;
	}
	
	@Override
	public void sendResetPassEmail(String userEmail,String userFlow) {
		if(StringUtil.isNotBlank(userEmail)){
			String actionId = userFlow;
			String content = InitConfig.getSysCfg("sys_resetpasswd_email_content");
			Map<String,String> dataMap = new HashMap<String,String>();
			dataMap.put("linkUrl", "<a href='"+InitConfig.getSysCfg("sys_resetpasswd_url")+"?sid="+GlobalContext.getSession().getId()+"&actionId="+actionId+"'>"+InitConfig.getSysCfg("sys_resetpasswd_url")+"?sid="+GlobalContext.getSession().getId()+"&actionId="+actionId+"</a>");
			dataMap.put("linkEmail",userEmail);
			try {
				content = VelocityUtil.evaluate(content, dataMap);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
			this.msgBiz.addEmailMsg(userEmail, InitConfig.getSysCfg("sys_resetpasswd_email_title"), content);
		}
	}
	
	@Override
	public void authUserEmail(SysUser user) {
		if(user != null){
			String actionId = user.getUserFlow();
			String userEmail = user.getUserEmail();
			String content = InitConfig.getSysCfg("user_email_auth_email_content");
			Map<String,String> dataMap = new HashMap<String,String>();
			dataMap.put("linkUrl", "<a href='"+InitConfig.getSysCfg("user_email_auth_url")+"?sid="+GlobalContext.getSession().getId()+"&actionId="+actionId+"'>"+InitConfig.getSysCfg("user_email_auth_url")+"?sid="+GlobalContext.getSession().getId()+"&actionId="+actionId+"</a>");
			dataMap.put("linkEmail",userEmail);
			try {
				content = VelocityUtil.evaluate(content, dataMap);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
			this.msgBiz.addEmailMsg(userEmail, InitConfig.getSysCfg("user_email_auth_email_title"), content);
		}
	}

	@Override
	public void addUserDept(SysUser user,List<String> deptFlows) {
		Map<String,SysUserDept> userDeptMap  = new HashMap<String, SysUserDept>();
		List<SysUserDept> userDeptList = getUserDept(user);
		
		for(SysUserDept userDept : userDeptList){
			userDeptMap.put(userDept.getDeptFlow(), userDept);
		}
		//批量废止
		disUserDept(user);
		//重新激活选中的
		for(String temp : deptFlows){
			if(userDeptMap.containsKey(temp)){ 
				SysUserDept userDept = userDeptMap.get(temp);
				userDept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				GeneralMethod.setRecordInfo(userDept, false);
				userDeptMapper.updateByPrimaryKey(userDept);
			}else {
				SysUserDept userDept = new SysUserDept();
				userDept.setRecordFlow(PkUtil.getUUID());
				userDept.setUserFlow(user.getUserFlow());
				userDept.setDeptFlow(temp);
				String deptName = InitConfig.getDeptNameByFlow(temp);
				if(!StringUtil.isNotBlank(deptName)){
					SysDept dept = deptBiz.readSysDept(temp);
					if(dept!=null){
						deptName = dept.getDeptName();
					}
				}
				userDept.setDeptName(deptName); 
				userDept.setOrgFlow(user.getOrgFlow());
				userDept.setOrgName(StringUtil.defaultString(InitConfig.getOrgNameByFlow(user.getOrgFlow())));
				GeneralMethod.setRecordInfo(userDept, true);
				userDeptMapper.insert(userDept);
			}
		}
	}

	@Override
	public List<SysUserDept> getUserDept(SysUser user) {
		SysUserDeptExample example = new SysUserDeptExample();
		com.pinde.sci.model.mo.SysUserDeptExample.Criteria criteria =  example.createCriteria().andUserFlowEqualTo(user.getUserFlow())
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(user.getOrgFlow())){
			criteria.andOrgFlowEqualTo(user.getOrgFlow());
		}
		example.setOrderByClause("ORDINAL");
		return userDeptMapper.selectByExample(example);
	}
	@Override
	public void disUserDept(SysUser user) {
		if(StringUtil.isNotBlank(user.getOrgFlow())){
			SysUserDeptExample example = new SysUserDeptExample();
			example.createCriteria().andUserFlowEqualTo(user.getUserFlow()).andOrgFlowEqualTo(user.getOrgFlow()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			
			SysUserDept delete = new SysUserDept();
			delete.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			userDeptMapper.updateByExampleSelective(delete,example);
		}
	}

	@Override
	public List<SysUser> searchResManageUser(SysUser user) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("deptFlow", user.getDeptFlow());
		map.put("idNo", user.getIdNo());
		map.put("userPhone", user.getUserPhone());
		map.put("userEmail", user.getUserEmail());
		map.put("userName", user.getUserName());
		map.put("statusId", user.getStatusId());
		map.put("orgFlow", user.getOrgFlow());
		return userExtMapper.searchResManageUser(map);
	}

	@Override
	public int importUserFromExcel(MultipartFile file) {
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
			//获取表头
			Row titleR =  sheet.getRow(0);
			//获取表头单元格数
			int cell_num = titleR.getLastCellNum();
			String title = "";
			for(int i = 0 ; i <cell_num; i++){
				 title = titleR.getCell(i).getStringCellValue();  
				 colnames.add(title);
			}
			for(int i = 1;i <row_num; i++){
				Row r =  sheet.getRow(i);
            	SysUser sysUser = new SysUser();
            	String userFlow;
            	String userName;
            	String idNo;
            	String userEmail;
            	String userPhone;
            	String orgFlow;
            	String orgName;
            	String deptFlow;
            	String deptName;
            	String postName;
            	String userCode;
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
					
					/* 用户编号	员工姓名	身份证  邮件电话 	机构编号	机构名称	科室编号	科室名称	职务	 登录名*/
					if("用户编号".equals(colnames.get(j))) {
						userFlow = value;
						sysUser.setUserFlow(userFlow);
					}else if("员工姓名".equals(colnames.get(j))){
						userName = value;
						sysUser.setUserName(userName);
					}else if("身份证".equals(colnames.get(j))){
						idNo = value;
						sysUser.setIdNo(idNo);
					}else if("邮件".equals(colnames.get(j))){
						userEmail = value;
						sysUser.setUserEmail(userEmail);
					}else if("电话".equals(colnames.get(j))){
						userPhone = value;
						sysUser.setUserPhone(userPhone);
					}else if("机构编号".equals(colnames.get(j))){
						orgFlow = value;
						sysUser.setOrgFlow(orgFlow);
					}else if("机构名称".equals(colnames.get(j))){
						orgName = value;
						sysUser.setOrgName(orgName);
					}else if("科室编号".equals(colnames.get(j))){
						deptFlow = value;
						sysUser.setDeptFlow(deptFlow);
					}else if("科室名称".equals(colnames.get(j))){
						deptName = value;
						sysUser.setDeptName(deptName);
					}else if("职务".equals(colnames.get(j))){
						postName = value;
						sysUser.setPostName(postName);
					}else if("登录名".equals(colnames.get(j))){
						userCode = value;
						sysUser.setUserCode(userCode);
					}
				}
				if(StringUtil.isBlank(sysUser.getUserFlow())){
					continue;
				}
				 
				if(StringUtil.isBlank(sysUser.getUserCode())){
					throw new RuntimeException("导入失败！，第"+ count+2 +"行，登录名不能为空！");
				}
				//验证同一机构的用户登录名
				if(StringUtil.isNotBlank(sysUser.getOrgFlow()) && StringUtil.isNotBlank(sysUser.getUserCode())){
					SysUserExample example=new SysUserExample();
					example.createCriteria().andOrgFlowEqualTo(sysUser.getOrgFlow()).andUserCodeEqualTo(sysUser.getUserCode()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
					List<SysUser> sysUserList = sysUserMapper.selectByExample(example);
					if(sysUserList != null && !sysUserList.isEmpty()){
						SysUser exitUser = sysUserList.get(0);
						if(!GlobalContext.getCurrentUser().getOrgFlow().equals(exitUser.getOrgFlow())){
							throw new RuntimeException("导入失败！，第"+count+2 +"行，当前机构已存在登录名为"+sysUser.getUserCode()+"的用户");
						}
					}		
				}
				
				//执行保存
				if(StringUtil.isNotBlank(sysUser.getUserFlow())){
					SysUser exitSysUser = readSysUser(sysUser.getUserFlow());
					if(exitSysUser != null){
						updateUser(sysUser);
					}else{
						addUser(sysUser);
					}
				}else{
					sysUser.setUserFlow(PkUtil.getUUID());
					addUser(sysUser);
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
	
	@Override
	public String uploadImg(String userFlow,MultipartFile file) {
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
				String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+File.separator+"userImages"+File.separator + dateString ;
				File fileDir = new File(newDir);
				if(!fileDir.exists()){
					fileDir.mkdirs();
				}
				/*文件名*/
				fileName = file.getOriginalFilename();
				fileName = PkUtil.getUUID()+fileName.substring(fileName.lastIndexOf("."));
				File newFile = new File(fileDir, fileName); 
				file.transferTo(newFile);
				String url = "userImages/"+dateString+"/"+fileName;
				if(StringUtil.isNotBlank(userFlow)){
					SysUser user = new SysUser();
					user.setUserFlow(userFlow);
					user.setUserHeadImg(url);
					saveUser(user);
				}
				return "success:"+url;
			} catch (Exception e) {
				e.printStackTrace();
				return GlobalConstant.UPLOAD_FAIL;
			}
		}
		return GlobalConstant.UPLOAD_FAIL;
	}
	
	@Override
	public List<SysUserDept> searchUserDeptByDept(String deptFlow){
		SysUserDeptExample example = new SysUserDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDeptFlowEqualTo(deptFlow);
		return userDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SysUserDept> searchUserDeptByUser(String userFlow){
		SysUserDeptExample example = new SysUserDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(userFlow);
		return userDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SysUser> searchUserByDeptAndRole(String deptFlow,String roleFlow){
		return userExtMapper.searchUserByDeptAndRole(deptFlow, roleFlow);
	}

	@Override
	public SysUser findByIdNoAndCretTypeNotSelf(String userFlow, String idNo,
			String cretTypeId) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andIdNoEqualTo(idNo);
		criteria.andCretTypeIdEqualTo(cretTypeId);
		criteria.andUserFlowNotEqualTo(userFlow);
		List<SysUser> sysUserList = sysUserMapper.selectByExample(sysUserExample);
		if(sysUserList.size()==1){
			return sysUserList.get(0);
		}		
		return null;
	}
	
	@Override
	public List<SysUser> searchUserNotInUserFlows(String orgFlow,List<String> userFlows){
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria = sysUserExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow);
		if(userFlows!=null&&userFlows.size()>0){
			criteria.andUserFlowNotIn(userFlows);
		}
		sysUserExample.setOrderByClause(" NLSSORT(USER_NAME,'NLS_SORT = SCHINESE_PINYIN_M')");
		return sysUserMapper.selectByExample(sysUserExample);
	}
	@Override
	public SysUser findByFlow(String userFlow) {
		return sysUserMapper.selectByPrimaryKey(userFlow); 
	}
	
	@Override
	public List<SysUser> searchAfterAuditUser(ResDoctorSchProcess process,SysUser user){
		return userExtMapper.searchAfterAuditUser(process,user);
	}

	@Override
	public Map<String, Map<String, Object>> courseFlowSysUserMap(
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
			SysUser sysUser=readSysUser(eduStudentCourse.getUserFlow());
			studentCourseMap.get(eduStudentCourse.getCourseFlow()).put(eduStudentCourse.getUserFlow(), sysUser);
		}
		return studentCourseMap;
		}
		return null;
		
	}
	
	@Override
	public List<SysUser> findUserByRoleFlow(String orgFlow, String roleFlow) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(StringUtil.isNotBlank(orgFlow)){
			paramMap.put("orgFlow", orgFlow);
		}
		if(StringUtil.isNotBlank(roleFlow)){
			paramMap.put("roleFlow", roleFlow);
		}
		return this.userExtMapper.selectUserByRoleFlow(paramMap);
	}

	@Override
	public List<SysUser> searchUserByUserCode(String userCode) {
		SysUserExample sysUserExample=new SysUserExample();
		Criteria criteria=sysUserExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(userCode)){ 
			criteria.andUserCodeEqualTo(userCode);
		}
		return sysUserMapper.selectByExample(sysUserExample);
	}
}
