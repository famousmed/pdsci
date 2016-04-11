package com.pinde.sci.biz.jsres.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.jsres.IJsResDoctorRecruitBiz;
import com.pinde.sci.biz.pub.IPubUserResumeBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.ResDoctorRecruitMapper;
import com.pinde.sci.dao.jsres.JsResDoctorRecruitExtMapper;
import com.pinde.sci.model.jsres.JsResDoctorRecruitExt;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitExample;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class JsResDoctorRecruitBizImpl implements IJsResDoctorRecruitBiz{

	@Autowired
	private IPubUserResumeBiz userResumeBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private ResDoctorRecruitMapper doctorRecruitMapper;
	@Autowired
	private JsResDoctorRecruitExtMapper jsResDoctorRecruitExtMapper;
	/**
	 * 根据recruitFlow获取相对应的一条记录
	 */
	@Override
	public ResDoctorRecruit readResDoctorRecruit(String recruitFlow) {
		
		if (StringUtil.isNotBlank(recruitFlow)) {
			return doctorRecruitMapper.selectByPrimaryKey(recruitFlow);
		}
		return null;
	}
	/**
	 * 查询当前机构下医师
	 */
	@Override
	public List<JsResDoctorRecruitExt> resDoctorRecruitExtList(ResDoctorRecruit resDoctorRecruit,SysUser user) {
		Map<String, Object> doctorRecruitMap=new HashMap<String, Object>();
		doctorRecruitMap.put("resDoctorRecruit", resDoctorRecruit);
		doctorRecruitMap.put("user", user);
		List<JsResDoctorRecruitExt> doctorRecruitList=jsResDoctorRecruitExtMapper.searchJsDoctorRecruitExtList(doctorRecruitMap);
		return doctorRecruitList;
	}
	/**
	 * 修改
	 */
	@Override
	public int saveDoctorRecruit(ResDoctorRecruitWithBLOBs doctorRecruitWithBLOBs) {
		if(StringUtil.isNotBlank(doctorRecruitWithBLOBs.getRecruitFlow())){
			GeneralMethod.setRecordInfo(doctorRecruitWithBLOBs, false);
			return doctorRecruitMapper.updateByPrimaryKeySelective(doctorRecruitWithBLOBs);
		}else{
			doctorRecruitWithBLOBs.setRecruitFlow(PkUtil.getUUID());
			SysUser currUser = GlobalContext.getCurrentUser();
			doctorRecruitWithBLOBs.setOrgFlow(currUser.getOrgFlow());
			doctorRecruitWithBLOBs.setOrgName(currUser.getOrgName());
			GeneralMethod.setRecordInfo(doctorRecruitWithBLOBs, true);
			return doctorRecruitMapper.insert(doctorRecruitWithBLOBs);
		}
	}

	@Override
	public List<ResDoctorRecruit> searchResDoctorRecruitList(ResDoctorRecruit recruit) {
		ResDoctorRecruitExample example = new ResDoctorRecruitExample();
		 com.pinde.sci.model.mo.ResDoctorRecruitExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		 if(StringUtil.isNotBlank(recruit.getDoctorFlow())){
			 criteria.andDoctorFlowEqualTo(recruit.getDoctorFlow());
		 }
		return doctorRecruitMapper.selectByExample(example);
	}
	
}
