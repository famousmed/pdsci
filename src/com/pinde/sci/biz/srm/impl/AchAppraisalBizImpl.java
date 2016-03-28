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
import com.pinde.sci.biz.srm.IAppraisalAuthorBiz;
import com.pinde.sci.biz.srm.IAppraisalBiz;
import com.pinde.sci.biz.srm.ISrmAchProcessBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmAchAppraisalAuthorMapper;
import com.pinde.sci.dao.base.SrmAchAppraisalMapper;
import com.pinde.sci.dao.base.SrmAchFileMapper;
import com.pinde.sci.model.mo.SrmAchAppraisal;
import com.pinde.sci.model.mo.SrmAchAppraisalAuthor;
import com.pinde.sci.model.mo.SrmAchAppraisalAuthorExample;
import com.pinde.sci.model.mo.SrmAchAppraisalExample;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SrmAchAppraisalExample.Criteria;
@Service
@Transactional(rollbackFor=Exception.class)
public class AchAppraisalBizImpl implements IAppraisalBiz,IAppraisalAuthorBiz {
	@Resource
	private SrmAchAppraisalMapper appraisalMapper;
	@Resource
	private SrmAchAppraisalAuthorMapper authorMapper;
	@Resource
	private SrmAchFileMapper fileMapper;
	
	@Autowired
	private ISrmAchProcessBiz srmAchProcessBiz;
	
	
	/**
	 * 显示鉴定信息
	 * @param authorFlow
	 * @return
	 */
	@Override
	public SrmAchAppraisal readAppraisal(String appraisalFlow){
		SrmAchAppraisal appraisal = null;
		if(StringUtil.isNotBlank(appraisalFlow)){
			appraisal = appraisalMapper.selectByPrimaryKey(appraisalFlow);
		}
		return appraisal;
	}

	/**
	 * 保存 鉴定和作者
	 * 参考Thesis
	 */
	@Override
	public void save(SrmAchAppraisal achAppraisal,List<SrmAchAppraisalAuthor> authorList,SrmAchFile srmAchFile,SrmAchProcess srmAchProcess) {
		//判断鉴定流水号是否为空？   非空-->修改   空-->新增
		if(StringUtil.isNotBlank(achAppraisal.getAppraisalFlow())){
			GeneralMethod.setRecordInfo(achAppraisal, false);
			appraisalMapper.updateByPrimaryKeySelective(achAppraisal);
		}else{
			GeneralMethod.setRecordInfo(achAppraisal, true);
			achAppraisal.setAppraisalFlow(PkUtil.getUUID());
			appraisalMapper.insert(achAppraisal);
		}
		//保存鉴定人员信息
		for(int i =0; i<authorList.size(); i++){
			//修改作者
			if(StringUtil.isNotBlank(authorList.get(i).getAuthorFlow())){
				GeneralMethod.setRecordInfo(authorList.get(i), false);
				//鉴定流水号
				authorList.get(i).setAppraisalFlow(achAppraisal.getAppraisalFlow());
				authorMapper.updateByPrimaryKeySelective(authorList.get(i));
			//新增作者	
			}else{
				GeneralMethod.setRecordInfo(authorList.get(i), true);
				//作者流水号
				authorList.get(i).setAuthorFlow(PkUtil.getUUID());
				//鉴定流水号！！！！
				authorList.get(i).setAppraisalFlow(achAppraisal.getAppraisalFlow());
				SrmAchAppraisalAuthor aAuthor = authorList.get(i);
				if(null != aAuthor){
					authorMapper.insert(aAuthor);
				}
			}
		}
		 //操作附件
		 if(null != srmAchFile){
			srmAchFile.setAchFlow(achAppraisal.getAppraisalFlow());
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
	    srmAchProcess.setAchFlow(achAppraisal.getAppraisalFlow());
	    GeneralMethod.setRecordInfo(srmAchProcess, true);
	    srmAchProcess.setOperateTime(srmAchProcess.getModifyTime());
	    srmAchProcessBiz.saveAchProcess(srmAchProcess);
	}
	
	
	
	@Override
	public void editAppraisalAuthor(SrmAchAppraisalAuthor author) {
		if(author != null && StringUtil.isNotBlank(author.getAppraisalFlow())){
			GeneralMethod.setRecordInfo(author, false);
			authorMapper.updateByPrimaryKeySelective(author);
		}
	}
	
	@Override
	public void updateAppraisalStatus(SrmAchAppraisal appraisal,SrmAchProcess process) {
		if(StringUtil.isNotBlank(appraisal.getAppraisalFlow())){
			GeneralMethod.setRecordInfo(appraisal, false);
			appraisalMapper.updateByPrimaryKeySelective(appraisal);
	    }
	    srmAchProcessBiz.saveAchProcess(process);
	}
	

	@Override
	public List<SrmAchAppraisal> search(SrmAchAppraisal achAppraisal, List<SysOrg> childOrgList) {
		SrmAchAppraisalExample example=new SrmAchAppraisalExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<String> orgFlowList=new ArrayList<String>();
		if(null!=childOrgList && !childOrgList.isEmpty()){
			for(SysOrg org:childOrgList){
				orgFlowList.add(org.getOrgFlow());
			}
			criteria.andApplyOrgFlowIn(orgFlowList);
		}
		if(achAppraisal != null){
			if(StringUtil.isNotBlank(achAppraisal.getAppraisalName())){
				criteria.andAppraisalNameLike("%"+achAppraisal.getAppraisalName()+"%");
			}
			if(StringUtil.isNotBlank(achAppraisal.getAppraisalDate())){
				criteria.andAppraisalDateEqualTo(achAppraisal.getAppraisalDate());
			}
			if(StringUtil.isNotBlank(achAppraisal.getApplyOrgFlow())){
				criteria.andApplyOrgFlowEqualTo(achAppraisal.getApplyOrgFlow());
			}
			if(StringUtil.isNotBlank(achAppraisal.getProjSourceId())){
				criteria.andProjSourceIdEqualTo(achAppraisal.getProjSourceId());
			}
			if(StringUtil.isNotBlank(achAppraisal.getAppraisalTypeId())){
				criteria.andAppraisalTypeIdLike("%"+achAppraisal.getAppraisalTypeId()+"%");
			}
			if(StringUtil.isNotBlank(achAppraisal.getOperStatusId())){
				List<String> statusList=Arrays.asList(achAppraisal.getOperStatusId().split(","));
				criteria.andOperStatusIdIn(statusList);
			}
			if(StringUtil.isNotBlank(achAppraisal.getApplyUserFlow())){
				criteria.andApplyUserFlowEqualTo(achAppraisal.getApplyUserFlow());
			}
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return appraisalMapper.selectByExample(example);
	}
	
	@Override
	public int edit(SrmAchAppraisal appraisal, List<SrmAchAppraisalAuthor> authorList, SrmAchFile file) {
		if(StringUtil.isNotBlank(appraisal.getAppraisalFlow())){
			GeneralMethod.setRecordInfo(appraisal, false);
			appraisalMapper.updateByPrimaryKeySelective(appraisal);
		}
		//作者
		if(null != authorList && !authorList.isEmpty()){
			for(SrmAchAppraisalAuthor author : authorList){
				GeneralMethod.setRecordInfo(author, false);
				authorMapper.updateByPrimaryKeySelective(author);
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
	public List<SrmAchAppraisalAuthor> searchAuthorList(SrmAchAppraisalAuthor author) {
		SrmAchAppraisalAuthorExample example = new SrmAchAppraisalAuthorExample();
		com.pinde.sci.model.mo.SrmAchAppraisalAuthorExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(author.getAuthorName())){
			criteria.andAuthorNameLike("%" + author.getAuthorName() + "%");
		}
		if(StringUtil.isNotBlank(author.getAppraisalFlow())){
			criteria.andAppraisalFlowEqualTo(author.getAppraisalFlow());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return authorMapper.selectByExample(example);
	}
}
