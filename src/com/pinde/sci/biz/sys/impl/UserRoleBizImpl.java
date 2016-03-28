package com.pinde.sci.biz.sys.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IExpertBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.ErpUserRegionPopedomMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.base.SysUserRoleMapper;
import com.pinde.sci.enums.erp.RegionTypeEnum;
import com.pinde.sci.enums.srm.RegPageEnum;
import com.pinde.sci.model.mo.ErpUserRegionPopedom;
import com.pinde.sci.model.mo.ErpUserRegionPopedomExample;
import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.mo.SysUserRoleExample;
import com.pinde.sci.model.mo.SysUserRoleExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class UserRoleBizImpl implements IUserRoleBiz{

	@Resource
	private SysUserRoleMapper sysUserRoleMapper;
	@Resource
	private SysUserMapper sysUserMapper;
	@Resource
	private ErpUserRegionPopedomMapper erpUserRegionPopedomMapper;
	@Autowired
	private IExpertBiz expertBiz;
	
	
	@Override
	public List<SysUserRole> getByUserFlow(String userFlow) {
		SysUserRoleExample example = new SysUserRoleExample();
		Criteria criteria = example.createCriteria();
		criteria.andUserFlowEqualTo(userFlow);
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return sysUserRoleMapper.selectByExample(example);
	}
	
	@Override
	public List<SysUserRole> searchUserRole(SysUserRole userRole){
		SysUserRoleExample example = new SysUserRoleExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(userRole.getOrgFlow())){
			criteria.andOrgFlowEqualTo(userRole.getOrgFlow());
		}
		if(StringUtil.isNotBlank(userRole.getRoleFlow())){
			criteria.andRoleFlowEqualTo(userRole.getRoleFlow());
		}
		if(StringUtil.isNotBlank(userRole.getWsId())){
			criteria.andWsIdEqualTo(userRole.getWsId());
		}
		if(StringUtil.isNotBlank(userRole.getUserFlow())){
			criteria.andUserFlowEqualTo(userRole.getUserFlow());
		}
		return sysUserRoleMapper.selectByExample(example);
	}
	
	@Override
	public List<SysUserRole> getByOrgFlow(String orgFlow,String wsId) {
		SysUserRoleExample example = new SysUserRoleExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(orgFlow)){
			criteria.andOrgFlowEqualTo(orgFlow);
		}
		criteria.andWsIdEqualTo(wsId);
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return sysUserRoleMapper.selectByExample(example);
	}
	
	/**
	 * 处理科研专家角色
	 * @param userFlow
	 * @param workStationId
	 * @param roleFlows
	 */
	private void saveSrmExpertRole(String userFlow , String[] roleFlows){
		boolean expertFlag = false;
		if(roleFlows!=null && roleFlows.length>0){
			for(String rolwf : roleFlows){
				SysRole sysRole = InitConfig.getSysRole(rolwf);
				if(sysRole!=null && RegPageEnum.ExpertRegPage.getId().equals(sysRole.getRegPageId())){
					expertFlag = true;
					break;
				}
			}
		}
		
		SrmExpert expert = new SrmExpert();
		expert.setUserFlow(userFlow);
		if(expertFlag){
			expert.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		}else{
			expert.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		}
		this.expertBiz.addOrModifyExpertByUserFlow(expert);
			
	}
	
	@Override
	public void saveAllot(String userFlow,String orgFlow,String workStationId, String[] roleFlows) {
		//将原先该用户的角色都删除
		SysUserRole update = new SysUserRole();
//		update.setUserFlow(userFlow);
		update.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		GeneralMethod.setRecordInfo(update, false);
		SysUserRoleExample example = new SysUserRoleExample();
		com.pinde.sci.model.mo.SysUserRoleExample.Criteria criteria = example.createCriteria();
		criteria.andUserFlowEqualTo(userFlow)
		.andWsIdEqualTo(workStationId)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		sysUserRoleMapper.updateByExampleSelective(update, example);
		
		//重新添加角色
		if(roleFlows!=null){
			for(String rolwf : roleFlows){
				SysUserRole insert = new SysUserRole();
				insert.setUserFlow(userFlow);
				insert.setOrgFlow(orgFlow);
				insert.setWsId(workStationId);
				insert.setRoleFlow(rolwf);
				insert.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				insert.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(insert, true);
				sysUserRoleMapper.insert(insert);
			}
		}
		
		//处理科研专家角色
		String wsid = (String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		if(GlobalConstant.SRM_WS_ID.equals(wsid)){
		    saveSrmExpertRole(userFlow , roleFlows);
		}
		
	}
	
	@Override
	public int saveSysUserRole(SysUserRole userRole){
		if(userRole != null){
			if(StringUtil.isNotBlank(userRole.getRecordFlow())){
				GeneralMethod.setRecordInfo(userRole, false);
				return sysUserRoleMapper.updateByPrimaryKeySelective(userRole);
			}else{
				userRole.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(userRole, true);
				return sysUserRoleMapper.insertSelective(userRole);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public void saveRegion(String userFlow, String[] provIds,String [] provNames) {
		ErpUserRegionPopedom update = new ErpUserRegionPopedom();
		update.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		GeneralMethod.setRecordInfo(update, false);
		ErpUserRegionPopedomExample example = new ErpUserRegionPopedomExample();
		example.createCriteria().andUserFlowEqualTo(userFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		erpUserRegionPopedomMapper.updateByExampleSelective(update, example);
		if(provIds!=null){
			for(int i=0;i<provIds.length;i++){
				String provId = provIds[i];
				ErpUserRegionPopedom erpUserRegionPopedom = new ErpUserRegionPopedom();
				erpUserRegionPopedom.setRecordFlow(PkUtil.getUUID());
				erpUserRegionPopedom.setUserFlow(userFlow);
				erpUserRegionPopedom.setProvId(provId);
				erpUserRegionPopedom.setProvName(provNames[i]);
				erpUserRegionPopedom.setRegionTypeId(RegionTypeEnum.Prov.getId());
				erpUserRegionPopedom.setRegionTypeName(RegionTypeEnum.Prov.getName());
				GeneralMethod.setRecordInfo(erpUserRegionPopedom, true);
				erpUserRegionPopedomMapper.insertSelective(erpUserRegionPopedom);
			}
		}
		
	}

	@Override
	public List<ErpUserRegionPopedom> getErpUserRegionByUserFlow(String userFlow) {
		ErpUserRegionPopedomExample example = new ErpUserRegionPopedomExample();
		example.createCriteria().andUserFlowEqualTo(userFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("REGION_TYPE_ID desc,PROV_ID,CITY_ID,AREA_ID");
		return erpUserRegionPopedomMapper.selectByExample(example);
	}

	@Override
	public void delErpUserRegion(String recordFlow) {
		ErpUserRegionPopedom erpUserRegionPopedom = new ErpUserRegionPopedom();
		GeneralMethod.setRecordInfo(erpUserRegionPopedom, false);
		erpUserRegionPopedom.setRecordFlow(recordFlow);
		erpUserRegionPopedom.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		erpUserRegionPopedomMapper.updateByPrimaryKeySelective(erpUserRegionPopedom);
		
	}
	
	@Override
	public List<SysUserRole> searchUserByRoles(List<String> roleList,String orgFlow){
		SysUserRoleExample example = new SysUserRoleExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y).andRoleFlowIn(roleList).andOrgFlowEqualTo(orgFlow);
		return sysUserRoleMapper.selectByExample(example);
	}

	@Override
	public void saveSysUserRole(String userFlow, String roleFlow) {
		SysUserRoleExample example = new SysUserRoleExample();
		example.createCriteria().andRoleFlowEqualTo(roleFlow).andUserFlowEqualTo(userFlow);
		List<SysUserRole> userRoleList = sysUserRoleMapper.selectByExample(example);
		if(userRoleList.size()==0){
			SysUserRole userRole = new SysUserRole();
			userRole.setRecordFlow(PkUtil.getUUID());
			userRole.setUserFlow(userFlow);
			userRole.setRoleFlow(roleFlow);
			userRole.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			userRole.setWsId(GlobalContext.getCurrentWsId());
			userRole.setAuthUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			userRole.setAuthTime(DateUtil.getCurrDateTime());
			GeneralMethod.setRecordInfo(userRole, true);
			sysUserRoleMapper.insert(userRole);
		}else {
			if(userRoleList.size()==1){
				SysUserRole userRole = userRoleList.get(0);
				GeneralMethod.setRecordInfo(userRole, false);
				if(userRole.getRecordStatus().equals(GlobalConstant.RECORD_STATUS_Y)){
					userRole.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				}else {
					userRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				}
				sysUserRoleMapper.updateByPrimaryKeySelective(userRole);
			}
		}
	}
	
	@Override
	public SysUserRole readUserRole(String userFlow, String roleFlow){
		SysUserRoleExample example = new SysUserRoleExample();
		example.createCriteria().andRoleFlowEqualTo(roleFlow).andUserFlowEqualTo(userFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		SysUserRole role = null;
		List<SysUserRole> userRoleList = sysUserRoleMapper.selectByExample(example);
		if(userRoleList!=null && userRoleList.size()>0){
			role = userRoleList.get(0);
		}
		return role;
	}
}
