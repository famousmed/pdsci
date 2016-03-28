package com.pinde.sci.biz.srm.impl;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.srm.IExpertProjBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.base.SrmExpertProjEvalMapper;
import com.pinde.sci.dao.base.SrmExpertProjMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.dao.srm.SrmExpertGroupExtMapper;
import com.pinde.sci.dao.srm.SrmExpertProjExtMapper;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.mo.SrmExpertProjExample;
import com.pinde.sci.model.mo.SrmExpertProjExample.Criteria;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmExpertProjExt;
import com.pinde.sci.model.srm.SysUserExt;
@Service
@Transactional(rollbackFor=Exception.class)
public class ExpertProjBizImpl implements IExpertProjBiz{

	@Resource
	private SrmExpertProjMapper expertProjMapper;
	@Resource
	private SrmExpertGroupExtMapper expertGroupExtMapper;
	@Autowired
	private SrmExpertProjEvalMapper srmExpertGroupProjMapper;
	@Resource
	private PubProjExtMapper PubProjExtMapper;
	@Resource
	private PubProjMapper projMapper;
	@Autowired
	private SysUserMapper userMapper;
	@Autowired
	private SrmExpertProjExtMapper srmExpertProjExtMapper;
	@Autowired
	private SrmExpertProjEvalMapper expertProjEvalMapper;
	@Autowired
	private IMsgBiz msgBiz;
	

	@Override
	public void save(SrmExpertProj expertProj) {
		expertProj.setExpertProjFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(expertProj,true);
		expertProjMapper.insertSelective(expertProj);
	}
 

	@Override
	public SrmExpertProj read(String projFlow, String userFlow) {
		SrmExpertProjExample example = new SrmExpertProjExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow).andUserFlowEqualTo(userFlow);
		List<SrmExpertProj> list = expertProjMapper.selectByExampleWithBLOBs(example);
		if(list != null && list.size()>0){
			return list.get(0);
		}
		return null;
	}

 
	@Override
	public List<SrmExpertProj> searchExample(SrmExpertProjExample expertProj) {
		return expertProjMapper.selectByExample(expertProj);
	}
	@Override
	public void modifyByFlow(SrmExpertProj expertPro) {
		GeneralMethod.setRecordInfo(expertPro,  false);
		expertProjMapper.updateByPrimaryKeyWithBLOBs(expertPro);
	}

	@Override
	public void saveForHide(SrmExpertProj expertProj) {
		GeneralMethod.setRecordInfo(expertProj,false);
		expertProj.setRecordStatus(GlobalConstant.RECORD_STATUS_N); //特殊处理 隐藏默认失效记录
		expertProjMapper.updateByPrimaryKeySelective(expertProj);
	}

	@Override
	public SrmExpertProj read(String recordFlow) {
		return expertProjMapper.selectByPrimaryKey(recordFlow); 
	}

	@Override
	public List<SrmExpertProj> searchExperProjByEvaluationFlow(String evaluationFlow) {
		SrmExpertProjExample example = new SrmExpertProjExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andEvalSetFlowEqualTo(evaluationFlow);
		return searchExample(example);
	}

	@Override
	public void saveExpertProj(SrmExpertProjEval groupProj, List<String> userFlowList) {
		String projFlow = groupProj.getProjFlow();
		PubProj proj = projMapper.selectByPrimaryKey(projFlow);
		SrmExpertProjExample example = new SrmExpertProjExample();
		example.createCriteria().andProjFlowEqualTo(groupProj.getProjFlow()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andEvalSetFlowEqualTo(groupProj.getEvalSetFlow());
		List<SrmExpertProj> existRecord = expertProjMapper.selectByExample(example);
		Map<String,SrmExpertProj> existMap = new HashMap<String, SrmExpertProj>();
		for(SrmExpertProj record : existRecord){
			existMap.put(record.getUserFlow(), record);
		}
		
			for(String userFlow :userFlowList){
				SrmExpertProj record = new SrmExpertProj();
				if(!existMap.containsKey(userFlow)){  //新增加的委员
					record .setExpertProjFlow(PkUtil.getUUID());
					record.setProjFlow(groupProj.getProjFlow());
					record.setProjName(proj.getProjName());
					record.setUserFlow(userFlow);
					SysUser expert = this.userMapper.selectByPrimaryKey(userFlow);
					record.setUserName(expert.getUserName()); 
					record.setEvalSetFlow(groupProj.getEvalSetFlow());
					record.setGroupFlow(groupProj.getGroupFlow());
					GeneralMethod.setRecordInfo(record, true);
					this.expertProjMapper.insert(record);
				}//这个地方应该将原先被去除掉的专家在还原回来
				
				else{//更新
					SrmExpertProj existExpertProj = existMap.get(record.getUserFlow());
					record.setExpertProjFlow(existExpertProj.getExpertProjFlow());
					GeneralMethod.setRecordInfo(record, false);
					this.expertProjMapper.updateByPrimaryKeySelective(record);
				}
			}
//			for(SrmExpertProj expertProj :existRecord){
//			if(!userFlowList.contains(expertProj.getUserFlow())){ //去除的委员
//				expertProj.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
//				GeneralMethod.setRecordInfo(expertProj, false);
//				expertProjMapper.updateByPrimaryKey(expertProj);
//			}
//		}
		}
		

	


	@Override
	public void modifyWithOutBlobsByFlow(SrmExpertProj expertProj) {
		GeneralMethod.setRecordInfo(expertProj,  false);
		expertProjMapper.updateByPrimaryKeySelective(expertProj);
	}

	@Override
	public List<SrmExpertProjExt> searchExpertProj(
			SrmExpertProjExt srmExpertProjExt) {
		return this.srmExpertProjExtMapper.selectExpertProj(srmExpertProjExt);
	}

	@Override
	public void modifyWithBlob(SrmExpertProj expertProj) {
		SrmExpertProjExample example = new SrmExpertProjExample();
		this.expertProjMapper.updateByExampleWithBLOBs(expertProj, example );
		
	}

	@Override
	public void modify(SrmExpertProj expertProj) {
		SrmExpertProjExample example = new SrmExpertProjExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(expertProj.getGroupFlow())){
			criteria.andGroupFlowEqualTo(expertProj.getGroupFlow());
		}
		if(StringUtil.isNotBlank(expertProj.getUserFlow())){
			criteria.andUserFlowEqualTo(expertProj.getUserFlow());
		}
		if(StringUtil.isNotBlank(expertProj.getEvalSetFlow())){
			criteria.andEvalSetFlowEqualTo(expertProj.getEvalSetFlow());
		}
		this.expertProjMapper.updateByExampleSelective(expertProj, example);
		
	}

	@Override
	public List<SysUserExt> searchJoinEvalSetExpertList(SrmExpertProj expertProj) {
		return this.srmExpertProjExtMapper.selectJoinEvalSetExpertList(expertProj);
	}

	@Override
	public List<SrmExpertProjExt> searchExpertProjExtAndUserExt(
			SrmExpertProj expertProj) {
		 return this.srmExpertProjExtMapper.selectExpertProjAndUserExt(expertProj);
	}

	@Override
	public boolean searchExpertIsSetScoreByProjFlow(String projFlow) {
		SrmExpertProjExample example = new SrmExpertProjExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y).andProjFlowEqualTo(projFlow).andEvalStatusIdIsNotNull();
		List<SrmExpertProj> list = this.expertProjMapper.selectByExample(example);
		if(list.isEmpty()){
			return false;
		}
		return true;
	}


	@Override
	public void sendPhoneNotice(String evalSetFlow , String userFlow) {
		SrmExpertProjEval evalSet = this.expertProjEvalMapper.selectByPrimaryKey(evalSetFlow);
		String projFlow = evalSet.getProjFlow();
		SysUser user = this.userMapper.selectByPrimaryKey(userFlow);
		if(StringUtil.isNotBlank(user.getUserPhone())){
			PubProj proj = this.projMapper.selectByPrimaryKey(projFlow);
			String con = InitConfig.getSysCfg("srm_expert_notice");
			Object[] repStr = new Object[]{user.getUserName() , proj.getProjName() , evalSet.getBeginDate() , evalSet.getEndDate()};
			con = MessageFormat.format(con, repStr);
			this.msgBiz.addSmsMsg(user.getUserPhone(), con);	
			SrmExpertProjExample expertProjExample = new SrmExpertProjExample();
			expertProjExample.createCriteria()
			.andProjFlowEqualTo(projFlow)
			.andEvalSetFlowEqualTo(evalSetFlow)
			.andUserFlowEqualTo(userFlow)
			.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
			SrmExpertProj expertProj = new SrmExpertProj();
			expertProj.setPhoneNotifyFlag(GlobalConstant.FLAG_Y);
			this.expertProjMapper.updateByExampleSelective(expertProj, expertProjExample);
		}else{
			throw new RuntimeException("专家没有手机号");
		}
		
	}


	@Override
	public void sendEmailNotice(String evalSetFlow , String userFlow) {
		SrmExpertProjEval evalSet = this.expertProjEvalMapper.selectByPrimaryKey(evalSetFlow);
		String projFlow = evalSet.getProjFlow();
		SysUser user = this.userMapper.selectByPrimaryKey(userFlow);
		if(StringUtil.isNotBlank(user.getUserEmail())){
			PubProj proj = this.projMapper.selectByPrimaryKey(projFlow);
			String con = InitConfig.getSysCfg("srm_expert_notice");
			Object[] repStr = new Object[]{user.getUserName() , proj.getProjName() , evalSet.getBeginDate() , evalSet.getEndDate()};
			con = MessageFormat.format(con, repStr);
			this.msgBiz.addEmailMsg(user.getUserEmail(), "评审标题", con);	
			SrmExpertProjExample expertProjExample = new SrmExpertProjExample();
			expertProjExample.createCriteria()
			.andProjFlowEqualTo(projFlow)
			.andEvalSetFlowEqualTo(evalSetFlow)
			.andUserFlowEqualTo(userFlow)
			.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
			SrmExpertProj expertProj = new SrmExpertProj();
			expertProj.setEmailNotifyFlag(GlobalConstant.FLAG_Y);
			this.expertProjMapper.updateByExampleSelective(expertProj, expertProjExample);
		}else{
			throw new RuntimeException("专家没有邮件");
		}
	}
}
