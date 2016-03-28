package com.pinde.sci.biz.sys.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysOrgMapper;
import com.pinde.sci.dao.sys.SysOrgExtMapper;
import com.pinde.sci.enums.sys.OrgTypeEnum;
import com.pinde.sci.model.mo.SysDeptExample;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysOrgExample;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.mo.SysOrgExample.Criteria;
import com.pinde.sci.model.mo.SysUser;
@Service
@Transactional(rollbackFor=Exception.class)
public class OrgBizImpl implements IOrgBiz {
	
	@Resource
	private SysOrgMapper sysOrgMapper;
	@Autowired
	private SysOrgExtMapper sysOrgExtMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	
	@Override
	public SysOrg readSysOrg(String sysOrgFlow) {
		return sysOrgMapper.selectByPrimaryKey(sysOrgFlow);
	}

	@Override
	public int addOrg(SysOrg org) {
		GeneralMethod.setRecordInfo(org, true);
		return sysOrgMapper.insertSelective(org);
	}
	
	@Override
	public int saveOrg(SysOrg org) {
		if(StringUtil.isNotBlank(org.getOrgFlow())){
			GeneralMethod.setRecordInfo(org, false);
			int result = sysOrgMapper.updateByPrimaryKeySelective(org);
			//同时更新机构名到用户表中
			SysUser user = new SysUser();
			user.setOrgFlow(org.getOrgFlow());
			user.setOrgName(org.getOrgName());
			GeneralMethod.setRecordInfo(user, false);
			this.userBiz.modifyUserByExample(user);
			return result;
		}else{
			org.setOrgFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(org, true);
			return sysOrgMapper.insertSelective(org);
		}
	}
	
	@Override
	public int saveDeclarerOrg(SysOrg org,SysUser user) {
		if(org != null && user != null){
			boolean orgRecord = StringUtil.isNotBlank(org.getOrgFlow());
			boolean userRecord = StringUtil.isNotBlank(user.getUserFlow());
			if(orgRecord){
				update(org);
			}else{
				org.setOrgFlow(PkUtil.getUUID());
				save(org);
			}
			user.setOrgFlow(org.getOrgFlow());
			user.setOrgName(org.getOrgName());
			if(userRecord){
				userBiz.saveUser(user);
			}else{
				user.setUserFlow(PkUtil.getUUID());
				userBiz.addUser(user);
			}
			if(!userRecord){
				SysUserRole userRole = new SysUserRole();
				userRole.setUserFlow(user.getUserFlow());
				userRole.setOrgFlow(org.getOrgFlow());
				userRole.setWsId((String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
				userRole.setRoleFlow(InitConfig.getSysCfg(GlobalConstant.DECLARER_ROLE_FLOW));
				userRole.setAuthUserFlow(GlobalContext.getCurrentUser().getUserFlow());
				userRole.setAuthTime(DateUtil.getCurrDateTime());
				userRoleBiz.saveSysUserRole(userRole);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	private int save(SysOrg org){
		GeneralMethod.setRecordInfo(org, true);
		return sysOrgMapper.insertSelective(org);
	}
	
	@Override
	public int update(SysOrg org){
		GeneralMethod.setRecordInfo(org, false);
		return sysOrgMapper.updateByPrimaryKeySelective(org);
	}
	
	@Override
	public List<SysOrg> searchOrg(SysOrg sysorg) {
		SysOrgExample example=new SysOrgExample();
		Criteria criteria=example.createCriteria();//.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(sysorg.getOrgCode())){
			criteria.andOrgCodeEqualTo(sysorg.getOrgCode());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgName())){
			criteria.andOrgNameLike("%"+sysorg.getOrgName()+"%");
		}
		if(StringUtil.isNotBlank(sysorg.getOrgProvId())){
			criteria.andOrgProvIdEqualTo(sysorg.getOrgProvId());
		}
		if(StringUtil.isNotBlank(sysorg.getRecordStatus())){
			criteria.andRecordStatusEqualTo(sysorg.getRecordStatus());
		}
		if(StringUtil.isNotBlank(sysorg.getChargeOrgFlow())){
			criteria.andChargeOrgFlowEqualTo(sysorg.getChargeOrgFlow());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgProvId())){
			criteria.andOrgProvIdEqualTo(sysorg.getOrgProvId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgCityId())){
			criteria.andOrgCityIdEqualTo(sysorg.getOrgCityId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgAreaId())){
			criteria.andOrgAreaIdEqualTo(sysorg.getOrgAreaId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgTypeId())){
			criteria.andOrgTypeIdEqualTo(sysorg.getOrgTypeId());
		}
		example.setOrderByClause(" ORDINAL,RECORD_STATUS DESC,ORG_FLOW");
		return sysOrgMapper.selectByExample(example);
	}
	
	@Override
	public List<SysOrg> searchOrgWithBLOBs(SysOrg sysorg) {
		SysOrgExample example=new SysOrgExample();
		Criteria criteria=example.createCriteria();//.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(sysorg.getOrgCode())){
			criteria.andOrgCodeEqualTo(sysorg.getOrgCode());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgName())){
			criteria.andOrgNameLike("%"+sysorg.getOrgName()+"%");
		}
		if(StringUtil.isNotBlank(sysorg.getOrgProvId())){
			criteria.andOrgProvIdEqualTo(sysorg.getOrgProvId());
		}
		if(StringUtil.isNotBlank(sysorg.getRecordStatus())){
			criteria.andRecordStatusEqualTo(sysorg.getRecordStatus());
		}
		if(StringUtil.isNotBlank(sysorg.getChargeOrgFlow())){
			criteria.andChargeOrgFlowEqualTo(sysorg.getChargeOrgFlow());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgProvId())){
			criteria.andOrgProvIdEqualTo(sysorg.getOrgProvId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgCityId())){
			criteria.andOrgCityIdEqualTo(sysorg.getOrgCityId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgAreaId())){
			criteria.andOrgAreaIdEqualTo(sysorg.getOrgAreaId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgTypeId())){
			criteria.andOrgTypeIdEqualTo(sysorg.getOrgTypeId());
		}
		example.setOrderByClause(" RECORD_STATUS DESC,CREATE_TIME");
		return sysOrgMapper.selectByExampleWithBLOBs(example);
	}	
	
	@Override
	public List<SysOrg> queryAllSysOrg(SysOrg sysorg) {
		SysOrgExample example = new SysOrgExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(sysorg.getOrgName())){
			criteria.andOrgNameLike("%"+sysorg.getOrgName()+"%");
		}
	    return sysOrgMapper.selectByExample(example);
	}

	@Override
	public List<SysOrg> searchChildrenOrgByOrgFlow(String orgFlow) {
		return this. sysOrgExtMapper.selectChildrenOrgListByOrgFlow(orgFlow);
	}
    
	@Override
	public List<SysOrg> searchOrgNoRegByRoleFlow(String roleFlow) {
		return this.sysOrgExtMapper.selectOrgNoRegByRoleFlow(roleFlow);
	}

	@Override
	public List<SysOrg> searchChildrenOrgByOrgFlowNotIncludeSelf(String orgFlow) {
		 return sysOrgExtMapper.selectChildrenOrgListByOrgFlowNotIncludeSelf(orgFlow);
	}

	@Override
	public Map<String, List<SysOrg>> searchChargeAndApply(SysOrg org,String projListScope) {
		List<SysOrg> firstGradeOrgList=null;
		List<SysOrg> secondGradeOrgList=null;
		org.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		Map<String,List<SysOrg>> resultMap=new HashMap<String, List<SysOrg>>();
		SysUser currUser=GlobalContext.getCurrentUser();
		//如果chargeOrgFlow不为空，查询该机构下所有下属机构
		if(StringUtil.isNotBlank(org.getChargeOrgFlow())){
			secondGradeOrgList=searchOrg(org);
			resultMap.put("secondGradeOrgList", secondGradeOrgList);
		}
		//查询当前机构下一级所有机构
		SysOrg currOrg=new SysOrg();
		currOrg.setChargeOrgFlow(currUser.getOrgFlow());
		firstGradeOrgList=searchOrg(currOrg);
		if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
			SysOrg globalOrg=readSysOrg(currUser.getOrgFlow());
			firstGradeOrgList.add(globalOrg);
		}
		resultMap.put("firstGradeOrgList", firstGradeOrgList);
		return resultMap;
	}

	@Override
	public List<SysOrg> searchOrgListByChargeOrgFlow(String chargeOrgFlow) {
		SysOrg sysOrg = new SysOrg();
		sysOrg.setChargeOrgFlow(chargeOrgFlow);
		sysOrg.setRecordStatus(GlobalConstant.FLAG_Y);
		List<SysOrg> orgList = this.searchOrg(sysOrg);
		return orgList;
	}

	@Override
	public List<SysOrg> searchChargeOrg() {
		return this.sysOrgExtMapper.selectChargeOrgList();
	}
	
	@Override
	public List<SysOrg> searchSysOrg(SysOrg sysorg) {
		SysOrgExample example=new SysOrgExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		setCriteria(criteria,sysorg);
		example.setOrderByClause("CREATE_TIME");
		return sysOrgMapper.selectByExampleWithBLOBs(example);
	}
	
	@Override
	public List<SysOrg> searchSysOrg() {
		SysOrgExample example=new SysOrgExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return sysOrgMapper.selectByExample(example);
	}
	
	@Override
	public List<SysOrg> searchOrderBy(SysOrg sysorg){
		SysOrgExample example=new SysOrgExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		setCriteria(criteria,sysorg);
		example.setOrderByClause("ORDINAL");
		return sysOrgMapper.selectByExampleWithBLOBs(example);
	}
	
	private void setCriteria(Criteria criteria,SysOrg sysorg){
		if(StringUtil.isNotBlank(sysorg.getOrgFlow())){
			criteria.andOrgFlowEqualTo(sysorg.getOrgFlow());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgCode())){
			criteria.andOrgCodeEqualTo(sysorg.getOrgCode());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgName())){
			criteria.andOrgNameLike("%"+sysorg.getOrgName()+"%");
		}
		if(StringUtil.isNotBlank(sysorg.getOrgProvId())){
			criteria.andOrgProvIdEqualTo(sysorg.getOrgProvId());
		}
		if(StringUtil.isNotBlank(sysorg.getRecordStatus())){
			criteria.andRecordStatusEqualTo(sysorg.getRecordStatus());
		}
		if(StringUtil.isNotBlank(sysorg.getChargeOrgFlow())){
			criteria.andChargeOrgFlowEqualTo(sysorg.getChargeOrgFlow());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgProvId())){
			criteria.andOrgProvIdEqualTo(sysorg.getOrgProvId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgCityId())){
			criteria.andOrgCityIdEqualTo(sysorg.getOrgCityId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgAreaId())){
			criteria.andOrgAreaIdEqualTo(sysorg.getOrgAreaId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgTypeId())){
			criteria.andOrgTypeIdEqualTo(sysorg.getOrgTypeId());
		}
		if(StringUtil.isNotBlank(sysorg.getOrgLevelId())){
			criteria.andOrgLevelIdEqualTo(sysorg.getOrgLevelId());
		}
	}
	@Override
	public List<SysOrg> searchByOrgNotSelf(String orgFlow,SysOrg sysorg){
		SysOrgExample example=new SysOrgExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowNotEqualTo(orgFlow);
		setCriteria(criteria,sysorg);
		example.setOrderByClause("ORDINAL");
		return sysOrgMapper.selectByExample(example);
	}

	@Override
	public List<SysOrg> searchOrgByExample(SysOrgExample example) {
		return sysOrgMapper.selectByExample(example);
	}

	@Override
	public List<SysOrg> searchHbresOrgList() {
		SysOrgExample example = new SysOrgExample();
		example.createCriteria().andOrgTypeIdEqualTo(OrgTypeEnum.Hospital.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return sysOrgMapper.selectByExample(example);
	}

	@Override
	public List<SysOrg> searchOrgNotSelf(String orgFlow) {
		SysOrgExample example = new SysOrgExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowNotEqualTo(orgFlow);
		return sysOrgMapper.selectByExample(example);
	}
	@Override
	public List<SysOrg> searchOrgFlowIn(List<String> orgFlows){
		SysOrgExample example = new SysOrgExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowIn(orgFlows);
		return sysOrgMapper.selectByExample(example);
	}
}
