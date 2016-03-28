package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.BeanUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IExpertGroupsUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmExpertGroupUserMapper;
import com.pinde.sci.dao.base.SrmExpertMapper;
import com.pinde.sci.dao.base.SrmExpertProjMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.srm.ExpertExtMapper;
import com.pinde.sci.dao.srm.SrmExpertGroupExtMapper;
import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.mo.SrmExpertGroupUserExample;
import com.pinde.sci.model.mo.SrmExpertGroupUserExample.Criteria;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.ExpertGroupUserExt;
import com.pinde.sci.model.srm.ExpertInfo;
@Service
@Transactional(rollbackFor=Exception.class)
public class ExpertGroupUserBizImpl implements IExpertGroupsUserBiz {
	@Resource
	private SrmExpertGroupUserMapper srmExpertGroupUserMapper;
	
	@Resource
	private SysUserMapper userMapper;
	
	@Resource
	private SrmExpertMapper expertMapper;
	
	@Resource
	private ExpertExtMapper expertExtMapper;
	
	@Autowired
	private SrmExpertProjMapper expertProjMapper;
	
	@Autowired
	private SrmExpertGroupExtMapper expertGroupExtMapper;
	
	/**
	 * ��groupFlow(ר����ˮ��) userFlows(�û���ˮ��) ��ӵ���Ӧ��ר������
	 */
	@Override
	public void saveExpertGroupUser(String groupFlow,String [] userFlows) {
		if(userFlows==null){
			return;
		}
		SrmExpertGroupUser expertGroupUser = new SrmExpertGroupUser();
		expertGroupUser.setRecordStatus(GlobalConstant.FLAG_Y);
		expertGroupUser.setGroupFlow(groupFlow);
		for(String userFlow : userFlows){//����userFlows(��ˮ��)
			expertGroupUser.setUserFlow(userFlow);
			List<SrmExpertGroupUser> groupUserList = this.searchSrmExpertGroupUser(expertGroupUser);
			if(groupUserList==null || groupUserList.isEmpty()){
				SrmExpertGroupUser groupUser = new SrmExpertGroupUser();
				groupUser.setRecordFlow(PkUtil.getUUID());
				groupUser.setGroupFlow(groupFlow);
				groupUser.setUserFlow(userFlow);
				//groupUser.setExpertStatusId(GlobalConstant.RECORD_STATUS_Y);
				groupUser.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				GeneralMethod.setRecordInfo(groupUser, true);
				srmExpertGroupUserMapper.insert(groupUser);
			}
			
		}
	}
	/**
	 * ��ѯר�����ж�Ӧ��ר����Ϣ
	 */
	@Override
	public List<ExpertInfo> searchExpertGroupUserInfo(
			SrmExpertGroupUser expertGroupUser) throws RuntimeException{
		List<ExpertInfo> expertInfoList = new ArrayList<ExpertInfo>();
		List<ExpertGroupUserExt> expertGroupUserExtList = expertGroupExtMapper.selectExpertGroupExtByGroupFlow(expertGroupUser.getGroupFlow());
		
		for(ExpertGroupUserExt egue: expertGroupUserExtList){
				ExpertInfo expertInfo = new ExpertInfo();
				expertInfo.setUser(egue.getUser());
				expertInfo.setExpert(egue.getExpert());
				SrmExpertGroupUser groupUser = new SrmExpertGroupUser();
				try {
					BeanUtil.copyProperties(groupUser, egue);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException(e.getMessage());
				}
				expertInfo.setExpertGroupUser(groupUser);
				expertInfoList.add(expertInfo);
			
		}
		
//		SrmExpertGroupUserExample example = new SrmExpertGroupUserExample();
//		Criteria criteria =example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
//		//������ˮ��Ϊ��ʱ Ӧ����Ҫ�����
//		if(StringUtil.isNotBlank(expertGroupUser.getGroupFlow())){
//			criteria.andGroupFlowEqualTo(expertGroupUser.getGroupFlow());
//		}
//		
//		List<SrmExpertGroupUser> groupUserList = srmExpertGroupUserMapper.selectByExample(example);
//		for(SrmExpertGroupUser expGroupUser:groupUserList){
//			ExpertInfo expertInfo = new ExpertInfo();
//			String userFlow = expGroupUser.getUserFlow();
//			SysUser user = this.userMapper.selectByPrimaryKey(userFlow);
//			SrmExpert expert = this.expertMapper.selectByPrimaryKey(userFlow);
//			expertInfo.setExpert(expert);
//			expertInfo.setExpertGroupUser(expGroupUser);
//			expertInfo.setUser(user);
//			expertInfoList.add(expertInfo);
//		}
		return expertInfoList;
	}
	/**
	 * ����ר�����Ӧ��ר����Ϣ��ɾ��ר����Ķ�Ӧר����Ϣ
	 */
	@Override
	public int updateExpertGroupUser(SrmExpertGroupUser expertGroupUser) {
		if(StringUtil.isNotBlank(expertGroupUser.getRecordFlow())){
			GeneralMethod.setRecordInfo(expertGroupUser, false);
			return srmExpertGroupUserMapper.updateByPrimaryKeySelective(expertGroupUser);
		}else{
			GeneralMethod.setRecordInfo(expertGroupUser, true);
			expertGroupUser.setUserFlow(PkUtil.getUUID());
			return srmExpertGroupUserMapper.insert(expertGroupUser);
		}	
	}
	
	/**
	 * ���ר��ҳ����ʾδ���ص�ר�����ר����Ϣ
	 */
	@Override
	public List<ExpertInfo> searchSysUserNotInByGroupFlow(String groupFlow) {
		List<ExpertInfo> expertInfoList = new ArrayList<ExpertInfo>();
		List<SrmExpert> expertList = expertExtMapper.searchSysUserNotInByGroupFlow(groupFlow);
		for(SrmExpert expert : expertList){
			ExpertInfo expertInfo = new ExpertInfo();
			SysUser user = this.userMapper.selectByPrimaryKey(expert.getUserFlow());
			expertInfo.setExpert(expert);
			expertInfo.setUser(user);
			expertInfoList.add(expertInfo);			
		}
		return expertInfoList;
	}
	
	@Override
	public List<ExpertInfo> searchSysUserNotInByExpertInfo(String groupFlow,
			ExpertInfo expertInformation) {
		List<ExpertInfo> expertInfoList = new ArrayList<ExpertInfo>();
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("groupFlow", groupFlow);
		map.put("expertInfo", expertInformation);
		List<SrmExpert> expertList = expertExtMapper.searchExpertInfo(map);
		for(SrmExpert expert : expertList){
			ExpertInfo expertInfo = new ExpertInfo();
			SysUser user = this.userMapper.selectByPrimaryKey(expert.getUserFlow());
			expertInfo.setExpert(expert);
			expertInfo.setUser(user);
			expertInfoList.add(expertInfo);			
		}
		return expertInfoList;
	}
	
	@Override
	public void expertSing(String recordFlow) {
		//���ҵ�ĳ��ר�Һ�ר����Ķ�Ӧ����
		SrmExpertGroupUser expertGroupUser = this.srmExpertGroupUserMapper.selectByPrimaryKey(recordFlow);
		expertGroupUser.setSignFlag(GlobalConstant.FLAG_Y);
		//���¸�����¼��ǩ�����
		this.srmExpertGroupUserMapper.updateByPrimaryKey(expertGroupUser);
		
		//���ҵ������ר�ҵ���Ҫ�������Ŀ �� ��������¼��ͬ���Ǹ�ΪY
		SrmExpertProjExample example = new SrmExpertProjExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y)
		.andGroupFlowEqualTo(expertGroupUser.getGroupFlow())
		.andUserFlowEqualTo(expertGroupUser.getUserFlow());
		SrmExpertProj record = new SrmExpertProj();
		record.setAgreeFlag(GlobalConstant.FLAG_Y);
		this.expertProjMapper.updateByExampleSelective(record, example);
		
	}
	@Override
	public List<SrmExpertGroupUser> searchSrmExpertGroupUser(
			SrmExpertGroupUser expertGroupUser) {
		SrmExpertGroupUserExample example = new SrmExpertGroupUserExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(expertGroupUser.getRecordStatus())){
			criteria.andRecordStatusEqualTo(expertGroupUser.getRecordStatus());
		}
		if(StringUtil.isNotBlank(expertGroupUser.getGroupFlow())){
			criteria.andGroupFlowEqualTo(expertGroupUser.getGroupFlow());
		}
		if(StringUtil.isNotBlank(expertGroupUser.getUserFlow())){
			criteria.andUserFlowEqualTo(expertGroupUser.getUserFlow());
		}
		return this.srmExpertGroupUserMapper.selectByExample(example );
	}
	
	@Override
	public SrmExpertGroupUser read(String recordFlow) {
		return this.srmExpertGroupUserMapper.selectByPrimaryKey(recordFlow);
	}
	
}
