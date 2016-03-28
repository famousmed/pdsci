package com.pinde.sci.biz.edc.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.PubProjOrgMapper;
import com.pinde.sci.dao.base.PubProjUserMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.base.SysUserRoleMapper;
import com.pinde.sci.dao.pub.PubProjUserExtMapper;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjOrgExample;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.PubProjUserExample;
import com.pinde.sci.model.mo.PubProjUserExample.Criteria;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.pub.PubProjUserExt;
@Service
@Transactional(rollbackFor=Exception.class)
public class ProjUserBizImpl implements IProjUserBiz {
	
	private static Logger logger = LoggerFactory.getLogger(ProjUserBizImpl.class);
	
	@Resource
	private PubProjUserMapper pubProjUserMapper;
	@Resource
	private PubProjOrgMapper pubProjOrgMapper;
	@Resource
	private SysUserRoleMapper sysUserRoleMapper;
	@Resource
	private SysUserMapper sysUserMapper;
	@Autowired
	private PubProjUserExtMapper pubProjUserExtMapper;
	
	@Override
	public List<PubProjUser> search(PubProjUser pubProjUser) {
		PubProjUserExample example = new PubProjUserExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(pubProjUser.getProjFlow())){
			criteria.andProjFlowEqualTo(pubProjUser.getProjFlow());			
		}
		if(StringUtil.isNotBlank(pubProjUser.getOrgFlow())){
			criteria.andOrgFlowEqualTo(pubProjUser.getOrgFlow());		
		}
		if(StringUtil.isNotBlank(pubProjUser.getUserFlow())){
			criteria.andUserFlowEqualTo(pubProjUser.getUserFlow());		
		}
		if(StringUtil.isNotBlank(pubProjUser.getRoleFlow())){
			criteria.andRoleFlowEqualTo(pubProjUser.getRoleFlow());		
		}
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("AUTH_TIME");
		return pubProjUserMapper.selectByExample(example);
	}

	@Override
	public PubProjUser read(String recordFlow) {
		return pubProjUserMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public void add(PubProjUser projUser) {
		projUser.setRecordFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(projUser, true);
		pubProjUserMapper.insert(projUser);		
	}

	@Override
	public void mod(PubProjUser projUser) {
		GeneralMethod.setRecordInfo(projUser, false);
		pubProjUserMapper.updateByPrimaryKeySelective(projUser);		
	}

	@Override
	public void del(PubProjUser projUser) {
		GeneralMethod.setRecordInfo(projUser, false);
		projUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		pubProjUserMapper.updateByPrimaryKeySelective(projUser);			
	}

	@Override
	public void saveAllot(String projFlow, String userFlow, String orgFlow,
			String workStationId, String[] roleFlows) {
		//将原先该用户的角色都删除
		PubProjUser update = new PubProjUser();
//		update.setUserFlow(userFlow);
//		update.setProjFlow(projFlow);
		update.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		GeneralMethod.setRecordInfo(update, false);
		PubProjUserExample example = new PubProjUserExample();
		Criteria criteria = example.createCriteria();
		criteria.andUserFlowEqualTo(userFlow)
		.andProjFlowEqualTo(projFlow)
//		.andWsIdEqualTo(wsId)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		pubProjUserMapper.updateByExampleSelective(update, example);
		
		PubProjOrgExample example2 = new PubProjOrgExample();
		example2.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow);
		List<PubProjOrg> pubProjOrgList = pubProjOrgMapper.selectByExample(example2);
		if(pubProjOrgList.size()==0){
			PubProjOrg insert = new PubProjOrg();
			insert.setRecordFlow(PkUtil.getUUID());
			insert.setCenterNo(0);
			insert.setProjFlow(projFlow);
			insert.setOrgFlow(orgFlow);
			insert.setOrgName(InitConfig.getOrgNameByFlow(insert.getOrgFlow()));	
//			insert.setOrgTypeName(DictTypeEnum.ProjOrgType.getDictNameById(insert.getOrgTypeId()));
			GeneralMethod.setRecordInfo(insert, true);
			pubProjOrgMapper.insert(insert);
		}
		
		SysUser currUser = GlobalContext.getCurrentUser();
		if(roleFlows!=null){
			for(String roleFlow : roleFlows){
				PubProjUser insert = new PubProjUser();
				insert.setProjFlow(projFlow);
				insert.setUserFlow(userFlow);
//				insert.setWsId(workStationId);
				insert.setAuthTime(DateUtil.getCurrDateTime());
				insert.setAuthUserFlow(currUser.getUserFlow());
				insert.setOrgFlow(orgFlow);
				insert.setRoleFlow(roleFlow);
				insert.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				insert.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(insert, true);
				pubProjUserMapper.insert(insert);
			}		
			
		}
	}

	@Override
	public void addUserWithRole(SysUser user, String projFlow, String[] roleFlows,String wsId) {
		String userFlow = PkUtil.getUUID();
		user.setUserFlow(userFlow);
		user.setUserCode(userFlow);
		user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), GlobalConstant.INIT_PASSWORD));
		user.setStatusId(UserStatusEnum.Added.getId());
		user.setStatusDesc(UserStatusEnum.Added.getName());
		GeneralMethod.setRecordInfo(user, true);
		sysUserMapper.insert(user);
		
		for(String roleFlow : roleFlows){
			PubProjUser insert = new PubProjUser();
			insert.setProjFlow(projFlow);
			insert.setUserFlow(userFlow);
//			insert.setWsId(workStationId);
			insert.setOrgFlow(user.getOrgFlow());
			insert.setRoleFlow(roleFlow);
			insert.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			insert.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(insert, true);
			pubProjUserMapper.insert(insert);			
		}
		String allRoleFlow = "";
		for(String roleFlow : roleFlows){
			SysUserRole insert = new SysUserRole();
			insert.setUserFlow(userFlow);
			insert.setWsId(wsId);
			insert.setRoleFlow(roleFlow);
			insert.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			insert.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(insert, true);
			sysUserRoleMapper.insert(insert);
			allRoleFlow = allRoleFlow+roleFlow+",";
		}
	}

	@Override
	public int editUser(PubProjUser projUser) {
		if(null != projUser){
			if(StringUtil.isNotBlank(projUser.getRecordFlow())){//修改
				GeneralMethod.setRecordInfo(projUser, false);
				return pubProjUserMapper.updateByPrimaryKeySelective(projUser);
			}else{//新增
				projUser.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(projUser, true);
				return pubProjUserMapper.insert(projUser);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<PubProjUserExt> search(PubProjUserExt pubProjUserExt) {
		return this.pubProjUserExtMapper.selectList(pubProjUserExt);
	}
	
	
}
