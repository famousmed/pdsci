package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IAchSatAuthorBiz;
import com.pinde.sci.biz.srm.ISatBiz;
import com.pinde.sci.biz.srm.ISrmAchProcessBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmAchFileMapper;
import com.pinde.sci.dao.base.SrmAchSatAuthorMapper;
import com.pinde.sci.dao.base.SrmAchSatMapper;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchSat;
import com.pinde.sci.model.mo.SrmAchSatAuthor;
import com.pinde.sci.model.mo.SrmAchSatAuthorExample;
import com.pinde.sci.model.mo.SrmAchSatExample;
import com.pinde.sci.model.mo.SrmAchSatExample.Criteria;
import com.pinde.sci.model.mo.SysOrg;

@Service
@Transactional(rollbackFor=Exception.class)
public class AchSatBizImpl implements ISatBiz,IAchSatAuthorBiz{

	@Autowired
	private ISrmAchProcessBiz srmAchProcessBiz;
	
	@Resource
	private SrmAchSatMapper satMapper;
	@Resource
	private SrmAchSatAuthorMapper satAuthorMapper;
	@Resource
	private SrmAchFileMapper fileMapper;

	@Override
	public SrmAchSat readSat(String satFlow) {
		return satMapper.selectByPrimaryKey(satFlow);
	}

	@Override
	public int editSatAuthor(SrmAchSatAuthor author) {
		if(author != null && StringUtil.isNotBlank(author.getAuthorFlow())){
			GeneralMethod.setRecordInfo(author, false);
			satAuthorMapper.updateByPrimaryKeySelective(author);
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int save(SrmAchSat sat, List<SrmAchSatAuthor> authorList, SrmAchFile srmAchFile, SrmAchProcess srmAchProcess) {
		//判断科技编号是否为空，空则添加，不为空则修改
		if(StringUtil.isNotBlank(sat.getSatFlow())){
			GeneralMethod.setRecordInfo(sat, false);
			satMapper.updateByPrimaryKeySelective(sat);
		}else{
			GeneralMethod.setRecordInfo(sat, true);
			sat.setSatFlow(PkUtil.getUUID());
			satMapper.insert(sat);
		}
		
		//科技作者的操作
		if(null != authorList && !authorList.isEmpty()){
			for(SrmAchSatAuthor author : authorList){
				if(StringUtil.isNotBlank(author.getAuthorFlow())){//修改作者
					GeneralMethod.setRecordInfo(author, false);
					author.setSatFlow(sat.getSatFlow());
					satAuthorMapper.updateByPrimaryKeySelective(author);
				}else{//新增作者
					GeneralMethod.setRecordInfo(author, true);
					//作者流水号
					author.setAuthorFlow(PkUtil.getUUID());
					//科技流水号！！！
					author.setSatFlow(sat.getSatFlow());
					satAuthorMapper.insert(author);
				}
			}
		}
		
		
		//操作附件
		if(null != srmAchFile){
			srmAchFile.setAchFlow(sat.getSatFlow());
			if(StringUtil.isNotBlank(srmAchFile.getFileFlow())){
				GeneralMethod.setRecordInfo(srmAchFile, false);
				fileMapper.updateByPrimaryKeySelective(srmAchFile);
			}else{
				srmAchFile.setFileFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(srmAchFile, true);
				fileMapper.insert(srmAchFile);
			}
		}
		
		//记录过程
		srmAchProcess.setProcessFlow(PkUtil.getUUID());
		srmAchProcess.setAchFlow(sat.getSatFlow());
		GeneralMethod.setRecordInfo(srmAchProcess, true);
		srmAchProcess.setOperateTime(srmAchProcess.getModifyTime());//更改时间
		srmAchProcessBiz.saveAchProcess(srmAchProcess);

		return GlobalConstant.ONE_LINE;
	}
	
	public int save(SrmAchSat sat){
		if(StringUtil.isNotBlank(sat.getSatFlow())){
			GeneralMethod.setRecordInfo(sat, false);
			satMapper.updateByPrimaryKeySelective(sat);
		}else{
			GeneralMethod.setRecordInfo(sat, true);
			sat.setSatFlow(PkUtil.getUUID());
			satMapper.insert(sat);
		}
		return GlobalConstant.ONE_LINE;
	}

	@Override
	public int updateSatStatus(SrmAchSat sat, SrmAchProcess process) {
		if(StringUtil.isNotBlank(sat.getSatFlow())){
			GeneralMethod.setRecordInfo(sat, false);
			satMapper.updateByPrimaryKeySelective(sat);
			//保存操作过程
			srmAchProcessBiz.saveAchProcess(process);
			return GlobalConstant.ONE_LINE;
        }
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<SrmAchSat> search(SrmAchSat sat, List<SysOrg> childOrgList) {
		SrmAchSatExample example=new SrmAchSatExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<String> orgFlowList=new ArrayList<String>();
		if(null != childOrgList && !childOrgList.isEmpty()){
			for(SysOrg org : childOrgList){
				orgFlowList.add(org.getOrgFlow());
			}
			criteria.andApplyOrgFlowIn(orgFlowList);
		}
		if(null != sat){
			if(StringUtil.isNotBlank(sat.getSatName())){
				criteria.andSatNameLike("%"+sat.getSatName()+"%");
			}
			if(StringUtil.isNotBlank(sat.getApplyOrgFlow())){
				criteria.andApplyOrgFlowEqualTo(sat.getApplyOrgFlow());
			}
			if(StringUtil.isNotBlank(sat.getProjSourceId())){
				criteria.andProjSourceIdEqualTo(sat.getProjSourceId());
			}
			if(StringUtil.isNotBlank(sat.getOperStatusId())){
				List<String> statusList=Arrays.asList(sat.getOperStatusId().split(","));
				criteria.andOperStatusIdIn(statusList);
			}
			if(StringUtil.isNotBlank(sat.getApplyUserFlow())){
				criteria.andApplyUserFlowEqualTo(sat.getApplyUserFlow());
			}
			if(StringUtil.isNotBlank(sat.getPrizedDate())){
				criteria.andPrizedDateEqualTo(sat.getPrizedDate());
			}
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return satMapper.selectByExample(example);
	}
	

	@Override
	public int edit(SrmAchSat sat, List<SrmAchSatAuthor> authorList, SrmAchFile file){
		if(StringUtil.isNotBlank(sat.getSatFlow())){
			GeneralMethod.setRecordInfo(sat, false);
			satMapper.updateByPrimaryKeySelective(sat);
		}
		//作者
		if(null != authorList && !authorList.isEmpty()){
			for(SrmAchSatAuthor author : authorList){
				GeneralMethod.setRecordInfo(author, false);
				satAuthorMapper.updateByPrimaryKeySelective(author);
			}
		}
		//附件
		if(file != null && StringUtil.isNotBlank(file.getFileFlow())){
			GeneralMethod.setRecordInfo(file, false);
			fileMapper.updateByPrimaryKeySelective(file);
		}
		return GlobalConstant.ONE_LINE;
	}

	@Override
	public List<SrmAchSatAuthor> searchAuthorList(SrmAchSatAuthor author) {
		SrmAchSatAuthorExample example = new SrmAchSatAuthorExample();
		com.pinde.sci.model.mo.SrmAchSatAuthorExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(author.getAuthorName())){
			criteria.andAuthorNameLike("%"+ author.getAuthorName() +"%");
		}
		if(StringUtil.isNotBlank(author.getSatFlow())){
			criteria.andSatFlowEqualTo(author.getSatFlow());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return satAuthorMapper.selectByExample(example);
	}

}
