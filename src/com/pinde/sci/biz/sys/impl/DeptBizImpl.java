package com.pinde.sci.biz.sys.impl;


import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;




import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.WeixinQiYeUtil;
import com.pinde.sci.dao.base.SysDeptMapper;
import com.pinde.sci.model.mo.SchDeptExample;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysDeptExample;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysDeptExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class DeptBizImpl implements IDeptBiz {
	private static Logger logger = LoggerFactory.getLogger(DeptBizImpl.class);
	
	@Resource
	private SysDeptMapper sysDeptMapper;
	
	@Override
	public SysDept readSysDept(String sysDeptFlow) {
		return sysDeptMapper.selectByPrimaryKey(sysDeptFlow);
	}

	@Override
	public int saveDept(SysDept dept) {
		if(StringUtil.isNotBlank(dept.getDeptFlow())){
			GeneralMethod.setRecordInfo(dept, false);
			int ret = sysDeptMapper.updateByPrimaryKeySelective(dept);
//			if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("sys_weixin_qiye_flag"))){
//				//全部同步后saveDept改称update
//				dept = sysDeptMapper.selectByPrimaryKey(dept.getDeptFlow());
//				boolean result = WeixinQiYeUtil.saveDept(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"),dept);
//				logger.debug("wei xin qi ye saveuser is "+result);
//			}
			return ret;
		}else{
			dept.setDeptFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(dept, true);
			int ret = sysDeptMapper.insert(dept);
//			if(GlobalConstant.FLAG_Y.equals(InitConfig.getSysCfg("sys_weixin_qiye_flag"))){
//				//全部同步后saveDept改称update
//				dept = sysDeptMapper.selectByPrimaryKey(dept.getDeptFlow());
//				boolean result = WeixinQiYeUtil.saveDept(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"),dept);
//				logger.debug("wei xin qi ye saveuser is "+result);
//			}
			return ret;
		}
	}
	
	@Override
	public List<SysDept> searchDept(SysDept sysdept) {
		// TODO Auto-generated method stub
		SysDeptExample sysDeptExample=new SysDeptExample();
		Criteria criteria=sysDeptExample.createCriteria();//.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(sysdept.getDeptFlow())){
			criteria.andDeptFlowEqualTo(sysdept.getDeptFlow());
		}
		if(StringUtil.isNotBlank(sysdept.getDeptName())){
			criteria.andDeptNameLike("%"+sysdept.getDeptName()+"%");
		}
		if(StringUtil.isNotBlank(sysdept.getDeptCode())){
			criteria.andDeptCodeEqualTo(sysdept.getDeptCode());
		}
		if(StringUtil.isNotBlank(sysdept.getOrgFlow())){
			criteria.andOrgFlowEqualTo(sysdept.getOrgFlow());
		}
		if(StringUtil.isNotBlank(sysdept.getRecordStatus())){
			criteria.andRecordStatusEqualTo(sysdept.getRecordStatus());
		}
		sysDeptExample.setOrderByClause(" RECORD_STATUS DESC,ORDINAL");
		return sysDeptMapper.selectByExample(sysDeptExample);
	}

	@Override
	public List<SysDept> searchDeptByOrg(String orgFlow){
		SysDeptExample example = new SysDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("ORDINAL");
		return sysDeptMapper.selectByExample(example);
	}
	
	@Override
	public void saveOrder(String[] deptFlow) {
		if(deptFlow==null) return;
		int i=1;
		for(String flow : deptFlow){
			SysDept dept = new SysDept();
			dept.setDeptFlow(flow);
			dept.setOrdinal((i++));
			sysDeptMapper.updateByPrimaryKeySelective(dept);		
		}	
	}
	
	@Override
	public List<SysDept> searchDeptByFlows(List<String> deptFlows){
		SysDeptExample example = new SysDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDeptFlowIn(deptFlows);
		return sysDeptMapper.selectByExample(example);
	}

}
