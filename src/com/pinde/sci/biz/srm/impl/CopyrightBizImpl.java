package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.ICopyrightAuthorBiz;
import com.pinde.sci.biz.srm.ICopyrightBiz;
import com.pinde.sci.biz.srm.ISrmAchProcessBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmAchCopyrightAuthorMapper;
import com.pinde.sci.dao.base.SrmAchCopyrightMapper;
import com.pinde.sci.dao.base.SrmAchFileMapper;
import com.pinde.sci.model.mo.SrmAchCopyright;
import com.pinde.sci.model.mo.SrmAchCopyrightAuthor;
import com.pinde.sci.model.mo.SrmAchCopyrightAuthorExample;
import com.pinde.sci.model.mo.SrmAchCopyrightExample;
import com.pinde.sci.model.mo.SrmAchCopyrightExample.Criteria;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;

@Service
@Transactional(rollbackFor=Exception.class)
public class CopyrightBizImpl implements ICopyrightBiz,ICopyrightAuthorBiz{
	
	@Resource
	private SrmAchCopyrightMapper copyrightMapper;
	@Resource
	private SrmAchCopyrightAuthorMapper copyrightAuthorMapper;
	@Resource
	private SrmAchFileMapper fileMapper;
	
	@Resource
	private ISrmAchProcessBiz srmAchProcessBiz;

	@Override
	public SrmAchCopyright readCopyright(String copyrightFlow) {
		return copyrightMapper.selectByPrimaryKey(copyrightFlow);
	}

	@Override
	public void save(SrmAchCopyright copyright, List<SrmAchCopyrightAuthor> authorList, SrmAchFile srmAchFile, SrmAchProcess srmAchProcess) {
		//判断鉴定流水号是否为空？   非空-->修改   空-->新增
		if(StringUtil.isNotBlank(copyright.getCopyrightFlow())){
			GeneralMethod.setRecordInfo(copyright, false);
			copyrightMapper.updateByPrimaryKeySelective(copyright);
		}else{
			GeneralMethod.setRecordInfo(copyright, true);
			copyright.setCopyrightFlow(PkUtil.getUUID());
			copyrightMapper.insert(copyright);
		}
		//保存鉴定人员信息
		for(int i =0; i<authorList.size(); i++){
			//修改作者
			if(StringUtil.isNotBlank(authorList.get(i).getAuthorFlow())){
				GeneralMethod.setRecordInfo(authorList.get(i), false);
				//鉴定流水号
				authorList.get(i).setCopyrightFlow(copyright.getCopyrightFlow());
				copyrightAuthorMapper.updateByPrimaryKeySelective(authorList.get(i));
			//新增作者	
			}else{
				GeneralMethod.setRecordInfo(authorList.get(i), true);
				//作者流水号
				authorList.get(i).setAuthorFlow(PkUtil.getUUID());
				//鉴定流水号！！！！
				authorList.get(i).setCopyrightFlow(copyright.getCopyrightFlow());
				SrmAchCopyrightAuthor aAuthor = authorList.get(i);
				if(null != aAuthor){
					copyrightAuthorMapper.insert(aAuthor);
				}
			}
		}
		 //操作附件
		if(srmAchFile !=null){
			srmAchFile.setAchFlow(copyright.getCopyrightFlow());
			if(StringUtil.isNotBlank(srmAchFile.getFileFlow())){
				GeneralMethod.setRecordInfo(srmAchFile, false);
				fileMapper.updateByPrimaryKeySelective(srmAchFile);
			}
			else{
				srmAchFile.setFileFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(srmAchFile, true);
				fileMapper.insert(srmAchFile);
			}
		}
		//操作成果过程
	    srmAchProcess.setProcessFlow(PkUtil.getUUID());
	    srmAchProcess.setAchFlow(copyright.getCopyrightFlow());
	    GeneralMethod.setRecordInfo(srmAchProcess, true);
	    srmAchProcess.setOperateTime(srmAchProcess.getModifyTime());
	    srmAchProcessBiz.saveAchProcess(srmAchProcess);
				
	}


	@Override
	public void updateCopyrightStatus(SrmAchCopyright copyright,
			SrmAchProcess process) {
		if(StringUtil.isNotBlank(copyright.getCopyrightFlow())){
			GeneralMethod.setRecordInfo(copyright, false);
			copyrightMapper.updateByPrimaryKeySelective(copyright);
		}
		srmAchProcessBiz.saveAchProcess(process);
	}

	@Override
	public void editAuthor(SrmAchCopyrightAuthor author) {
		if(StringUtil.isNotBlank(author.getAuthorFlow())){
			GeneralMethod.setRecordInfo(author, false);
			copyrightAuthorMapper.updateByPrimaryKeySelective(author);
		}
	}

	@Override
	public List<SrmAchCopyright> search(SrmAchCopyright copyright, List<SysOrg> childOrgList) {
		SrmAchCopyrightExample example = new SrmAchCopyrightExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<String> orgFlowList=new ArrayList<String>();
		if(childOrgList != null && !childOrgList.isEmpty()){
			for(SysOrg org:childOrgList){
				orgFlowList.add(org.getOrgFlow());
			}
			criteria.andApplyOrgFlowIn(orgFlowList);
		}
		if(StringUtil.isNotBlank(copyright.getCopyrightName())){
			criteria.andCopyrightNameLike("%" +copyright.getCopyrightName()+"%");
		}
		if(StringUtil.isNotBlank(copyright.getRegisterCode())){
			criteria.andRegisterCodeLike("%" + copyright.getRegisterCode() +"%");
		}
		if(StringUtil.isNotBlank(copyright.getPublishDate())){
			criteria.andPublishDateEqualTo(copyright.getPublishDate());
		}
		if(StringUtil.isNotBlank(copyright.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(copyright.getApplyOrgFlow());
		}
		if(StringUtil.isNotBlank(copyright.getCopyrightTypeId())){
			criteria.andCopyrightTypeIdEqualTo(copyright.getCopyrightTypeId());
		}
		if(StringUtil.isNotBlank(copyright.getOperStatusId())){
			List<String> statusList=Arrays.asList(copyright.getOperStatusId().split(","));
			criteria.andOperStatusIdIn(statusList);
		}
		if(StringUtil.isNotBlank(copyright.getApplyUserFlow())){
			criteria.andApplyUserFlowEqualTo(copyright.getApplyUserFlow());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return copyrightMapper.selectByExample(example);
	}

	@Override
	public int edit(SrmAchCopyright copyright, List<SrmAchCopyrightAuthor> authorList, SrmAchFile file) {
		if(StringUtil.isNotBlank(copyright.getCopyrightFlow())){
			GeneralMethod.setRecordInfo(copyright, false);
			copyrightMapper.updateByPrimaryKeySelective(copyright);
		}
		//作者
		if(null != authorList && !authorList.isEmpty()){
			for(SrmAchCopyrightAuthor author : authorList){
				GeneralMethod.setRecordInfo(author, false);
				copyrightAuthorMapper.updateByPrimaryKeySelective(author);
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
	public List<SrmAchCopyrightAuthor> searchAuthorList(SrmAchCopyrightAuthor author) {
		SrmAchCopyrightAuthorExample example = new SrmAchCopyrightAuthorExample();
		com.pinde.sci.model.mo.SrmAchCopyrightAuthorExample.Criteria criteria =example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(author.getAuthorName())){
			criteria.andAuthorNameLike("%" + author.getAuthorName() + "%");
		}
		if(StringUtil.isNotBlank(author.getCopyrightFlow())){
			criteria.andCopyrightFlowEqualTo(author.getCopyrightFlow());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return copyrightAuthorMapper.selectByExample(example);
	}
}
