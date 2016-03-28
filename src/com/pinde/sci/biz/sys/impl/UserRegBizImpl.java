package com.pinde.sci.biz.sys.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRegBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.WeixinQiYeUtil;
import com.pinde.sci.dao.base.SrmExpertMapper;
import com.pinde.sci.dao.base.SysOrgMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.base.SysUserRoleMapper;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.srm.RegPageEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.srm.UserRegForm;

@Service
@Transactional(rollbackFor=Exception.class)
public class UserRegBizImpl implements IUserRegBiz {
	
	private static Logger logger = LoggerFactory.getLogger(UserRegBizImpl.class);
	
	@Resource
	private SysUserMapper sysUserMapper;
	@Resource
	private SysUserRoleMapper sysUserRoleMapper;
	@Autowired
	private SrmExpertMapper srmExpertMapper;
	@Autowired
	private SysOrgMapper sysOrgMapper;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private IUserBiz userBiz;
	
	@Override
	public void activatSysUser(SysUser sysUser) {
		sysUser.setUserPasswd(PasswordHelper.encryptPassword(sysUser.getUserFlow(), sysUser.getUserPasswd()));
		//�޸��û���Ϣ
		sysUser.setStatusId(UserStatusEnum.Activated.getId());
		sysUser.setStatusDesc(UserStatusEnum.Activated.getName());
		GeneralMethod.setRecordInfo(sysUser, false);
	    sysUserMapper.updateByPrimaryKeySelective(sysUser);
		if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("sys_weixin_qiye_flag"))){
			sysUser = sysUserMapper.selectByPrimaryKey(sysUser.getUserFlow());
			boolean result = WeixinQiYeUtil.createUser(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"), InitConfig.getSysCfg("sys_weixin_qiye_dept_id"), sysUser);
			logger.debug("wei xin qi ye createUser is "+result);
		}
	}

	@Override
	public void regUser(SysUser user, String roleFlow) {
		user.setUserFlow(PkUtil.getUUID());
		user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), GlobalConstant.INIT_PASSWORD));
		user.setStatusId(UserStatusEnum.Reged.getId());
		user.setStatusDesc(UserStatusEnum.Reged.getName());
		GeneralMethod.setRecordInfo(user, true);
		sysUserMapper.insert(user);
		
		SysUserRole insert = new SysUserRole();
		insert.setUserFlow(user.getUserFlow());
		insert.setOrgFlow(user.getOrgFlow());
		insert.setWsId(GlobalConstant.SRM_WS_ID);
		insert.setRoleFlow(roleFlow);
		insert.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		insert.setRecordFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(insert, true);
		sysUserRoleMapper.insert(insert);
	
	}

	@Override
	public void regUser(UserRegForm form , SysRole role) {
		 String regPageId = role.getRegPageId();
		 if(RegPageEnum.ExpertRegPage.getId().equals(regPageId)){
			 //ר��ע��
			 regExpert(form);
		 }else if(RegPageEnum.ProjRegPage.getId().equals(regPageId)){
			 //��Ŀ������ע��
			 regProjUser(form);
		 }else if(RegPageEnum.orgRegPage.getId().equals(regPageId)){
			 //����������ע��
			 orgReg(form);
		 }
		
		
	}
	
	/**
	 * ר��ע��
	 * @param form
	 */
	private void regExpert(UserRegForm form){
		SysUser user = form.getUser();
		String roleFlow = form.getRoleFlow();
		SrmExpert expert = form.getExpert();
		
		user.setUserFlow(PkUtil.getUUID());
		user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), user.getUserPasswd()));
		user.setStatusId(UserStatusEnum.Reged.getId());
		user.setStatusDesc(UserStatusEnum.Reged.getName());
		user.setSrmExpertFlag(GlobalConstant.FLAG_Y);//�ȱ��Ϊר��
		user.setSexName(UserSexEnum.getNameById(user.getSexId()));
		user.setOrgName(this.sysOrgMapper.selectByPrimaryKey(user.getOrgFlow()).getOrgName());
		user.setEducationName(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));
		user.setPostName(DictTypeEnum.UserPost.getDictNameById(user.getPostId()));
		GeneralMethod.setRecordInfo(user, true);
		sysUserMapper.insert(user);
		
		expert.setUserFlow(user.getUserFlow());
		expert.setEducation(user.getEducationName());
		expert.setPost(user.getPostName());
		GeneralMethod.setRecordInfo(expert, true);
		this.srmExpertMapper.insertSelective(expert);
		
		SysUserRole insert = new SysUserRole();
		insert.setUserFlow(user.getUserFlow());
		insert.setOrgFlow(user.getOrgFlow());
		insert.setWsId(GlobalConstant.SRM_WS_ID);
		insert.setRoleFlow(roleFlow);
		insert.setRecordFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(insert, true);
		sysUserRoleMapper.insert(insert);
	}
	
	/**
	 * ��Ŀ������ע��
	 * @param form
	 */
	private void regProjUser(UserRegForm form){
		SysUser user = form.getUser();
		String roleFlow = form.getRoleFlow();
		user.setUserFlow(PkUtil.getUUID());
		user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), user.getUserPasswd()));
		user.setStatusId(UserStatusEnum.Reged.getId());
		user.setStatusDesc(UserStatusEnum.Reged.getName());
		user.setOrgName(this.sysOrgMapper.selectByPrimaryKey(user.getOrgFlow()).getOrgName());
		user.setSexName(UserSexEnum.getNameById(user.getSexId()));
		user.setEducationName(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));
		user.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(user.getDegreeId()));
		user.setTitleName(DictTypeEnum.UserTitle.getDictNameById(user.getTitleId()));
		user.setPostName(DictTypeEnum.UserPost.getDictNameById(user.getPostId()));
		GeneralMethod.setRecordInfo(user, true);
		sysUserMapper.insert(user);
		
		SysUserRole insert = new SysUserRole();
		insert.setUserFlow(user.getUserFlow());
		insert.setOrgFlow(user.getOrgFlow());
		insert.setWsId(GlobalConstant.SRM_WS_ID);
		insert.setRoleFlow(roleFlow);
		insert.setRecordFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(insert, true);
		sysUserRoleMapper.insert(insert);
	}
	
	/**
	 * ��������Աע��
	 * @param form
	 */
	private void orgReg(UserRegForm form){
		SysUser user = form.getUser();
		String roleFlow = form.getRoleFlow();
		//������û�
		user.setUserFlow(PkUtil.getUUID());
		user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), user.getUserPasswd()));
		user.setStatusId(UserStatusEnum.Reged.getId());
		user.setStatusDesc(UserStatusEnum.Reged.getName());
		user.setOrgName(this.sysOrgMapper.selectByPrimaryKey(user.getOrgFlow()).getOrgName());
		user.setSexName(UserSexEnum.getNameById(user.getSexId()));
		GeneralMethod.setRecordInfo(user, true);
		sysUserMapper.insert(user);
		//�ϴ��ļ�
		List<String[]> fileFlowList = new ArrayList<String[]>();
		MultipartFile orgFile = form.getOrgFile();
		String[] orgFileAry = new String[2];
		String fileFlow = "";
		if(orgFile!=null && StringUtil.isNotBlank(orgFile.getOriginalFilename())){
			fileFlow = this.fileBiz.addFile(orgFile , user.getUserFlow());
			orgFileAry[0] = fileFlow;
			orgFileAry[1] = "orgFile";
			fileFlowList.add(orgFileAry);
		}
		MultipartFile licenseFile = form.getLicenseFile();
		if(licenseFile!=null && StringUtil.isNotBlank(licenseFile.getOriginalFilename())){
			fileFlow = this.fileBiz.addFile(licenseFile , user.getUserFlow());
			orgFileAry = new String[2];
			orgFileAry[0] = fileFlow;
			orgFileAry[1] = "licenseFile";
			fileFlowList.add(orgFileAry);
		}
		
		//������֯����
		String orgFlow = user.getOrgFlow();
		SysOrg org = form.getOrg();
		org.setOrgFlow(orgFlow);
		SysOrg oldOrg = this.sysOrgMapper.selectByPrimaryKey(orgFlow);
		String orgInfo = oldOrg.getOrgInfo();
		if(StringUtil.isNotBlank(orgInfo)){
			//׷��
			try {
				Document document = DocumentHelper.parseText(orgInfo);
				Element rootElement = document.getRootElement();
				Element filesElement = rootElement.addElement("files");//�ļ��ڵ�
				for(int i=0 ; i<fileFlowList.size() ; i++ ){
					
					Element itemEle = filesElement.addElement("item");
					itemEle.addAttribute("name", fileFlowList.get(i)[1]);
					itemEle.addElement("value").setText(fileFlowList.get(i)[0]);
				}
				org.setOrgInfo(document.asXML());
			} catch (DocumentException e) {
				throw new RuntimeException("xml�����쳣");
			}
		}else{
			//�½�
			Document document=DocumentHelper.createDocument();
			Element rootElement=document.addElement("orgInfo");//���ڵ�
			Element filesElement = rootElement.addElement("files");//�ļ��ڵ�
			for(int i=0 ; i<fileFlowList.size() ; i++ ){
				Element itemEle = filesElement.addElement("item");
				itemEle.addAttribute("name", fileFlowList.get(i)[1]);
				itemEle.addElement("value").setText(fileFlowList.get(i)[0]);
			}
			org.setOrgInfo(document.asXML());
		}
		this.sysOrgMapper.updateByPrimaryKeySelective(org);
		
		//���û����ý�ɫ
		SysUserRole insert = new SysUserRole();
		insert.setUserFlow(user.getUserFlow());
		insert.setOrgFlow(user.getOrgFlow());
		insert.setWsId(GlobalConstant.SRM_WS_ID);
		insert.setRoleFlow(roleFlow);
		insert.setRecordFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(insert, true);
		sysUserRoleMapper.insert(insert);
	}

	@Override
	public String srmRegValidate(UserRegForm form, SysRole role) {
		String eroMsg = "";
		SysUser sysUser = form.getUser();
		String regPageId = role.getRegPageId();
		//�ж��û�id�Ƿ��ظ�
		SysUser old = userBiz.findByUserCode(sysUser.getUserCode());
		if(old!=null){
			eroMsg = GlobalConstant.USER_CODE_REPETE;
			return eroMsg;
		}	
		//�ж��û����֤���Ƿ��ظ�
		old = userBiz.findByIdNo(sysUser.getIdNo());
		if(old!=null){
			eroMsg = GlobalConstant.USER_ID_NO_REPETE;
			return eroMsg;
		}		
		//�ж��û��ֻ����Ƿ��ظ�
		old = userBiz.findByUserPhone(sysUser.getUserPhone());
		if(old!=null){
			eroMsg = GlobalConstant.USER_PHONE_REPETE;
			return eroMsg;
		}
		//�ж��û������ʼ��Ƿ��ظ�
		old = userBiz.findByUserEmail(sysUser.getUserEmail());
		if(old!=null){
			eroMsg = GlobalConstant.USER_EMAIL_REPETE;
			return eroMsg;
		}	
		
		//�ļ�У��
		if(RegPageEnum.orgRegPage.getId().equals(regPageId)){
			//ע���������Ա ��֤�ļ�
			eroMsg = this.checkFile(form.getOrgFile());
			if(StringUtil.isBlank(eroMsg)){
				eroMsg = this.checkFile(form.getLicenseFile());
			}
				
		}
		return eroMsg;
		
	}
	
	/**
	 * У��  �ļ��ϴ�
	 * @param file
	 * @return
	 */
	private String checkFile(MultipartFile file){
		if(file==null || StringUtil.isBlank(file.getOriginalFilename())){
			return GlobalConstant.UPLOAD_FILE_NULL;
		}
		try{
			String fileType = file.getContentType();//MIME����;
			String fileName = file.getOriginalFilename();//�ļ���
			String suffix = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();//��׺�� ת����Сд
			List<String> mimeList = new ArrayList<String>();
			if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")))){
				mimeList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")).split(","));
			}
			List<String> suffixList = new ArrayList<String>();
			if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")))){
				suffixList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")).split(","));
			}
			if(!(mimeList.contains(fileType)&&suffixList.contains(suffix))){
				return GlobalConstant.UPLOAD_IMG_TYPE_ERROR;
			}
			long limitSize = Long.parseLong(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_limit_size")));//ͼƬ��С����
			if(file.getSize()>limitSize*1024*1024){
				return GlobalConstant.UPLOAD_IMG_SIZE_ERROR +limitSize +"M" ;
			}
		}catch(Exception e){
			return GlobalConstant.VALIDATE_FILE_FAIL;
		}
		
		return "";//��ʾ�ļ��ϸ�
	}
	

}
