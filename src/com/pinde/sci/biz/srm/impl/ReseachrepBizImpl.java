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
import com.pinde.sci.biz.srm.IReseachrepAuthorBiz;
import com.pinde.sci.biz.srm.IReseachrepBiz;
import com.pinde.sci.biz.srm.ISrmAchProcessBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmAchFileMapper;
import com.pinde.sci.dao.base.SrmAchReseachrepAuthorMapper;
import com.pinde.sci.dao.base.SrmAchReseachrepMapper;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchReseachrep;
import com.pinde.sci.model.mo.SrmAchReseachrepAuthor;
import com.pinde.sci.model.mo.SrmAchReseachrepAuthorExample;
import com.pinde.sci.model.mo.SrmAchReseachrepExample;
import com.pinde.sci.model.mo.SrmAchReseachrepExample.Criteria;
import com.pinde.sci.model.mo.SysOrg;

@Service
@Transactional(rollbackFor = Exception.class)
public class ReseachrepBizImpl implements IReseachrepBiz, IReseachrepAuthorBiz{

	@Resource
	private SrmAchReseachrepMapper reseachrepMapper;
	@Resource
	private SrmAchReseachrepAuthorMapper authorMapper;
	@Resource
	private SrmAchFileMapper fileMapper;

	@Autowired
	private ISrmAchProcessBiz srmAchProcessBiz;
	
	@Override
	public int save(SrmAchReseachrep reseachrep, List<SrmAchReseachrepAuthor> authorList, SrmAchFile srmAchFile, SrmAchProcess srmAchProcess) {
		/*报告*/
		if(StringUtil.isNotBlank(reseachrep.getReseachrepFlow())){
			GeneralMethod.setRecordInfo(reseachrep, false);
			this.reseachrepMapper.updateByPrimaryKeySelective(reseachrep);
		}else{
			GeneralMethod.setRecordInfo(reseachrep, true);
			reseachrep.setReseachrepFlow(PkUtil.getUUID());
			this.reseachrepMapper.insert(reseachrep);
		}
		
		/*作者*/
		for(int i=0;i<authorList.size();i++){
			if(StringUtil.isNotBlank(authorList.get(i).getAuthorFlow())){
				GeneralMethod.setRecordInfo(authorList.get(i), false);
				authorList.get(i).setReseachrepFlow(reseachrep.getReseachrepFlow());
				authorMapper.updateByPrimaryKeySelective(authorList.get(i));
			}else{
				GeneralMethod.setRecordInfo(authorList.get(i), true);
				authorList.get(i).setAuthorFlow(PkUtil.getUUID());
				authorList.get(i).setReseachrepFlow(reseachrep.getReseachrepFlow());
				authorMapper.insert(authorList.get(i));
			}
		}
		
		/*附件*/
		if(srmAchFile !=null){
			srmAchFile.setAchFlow(reseachrep.getReseachrepFlow());
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
		
		/*过程*/
	    srmAchProcess.setProcessFlow(PkUtil.getUUID());
	    srmAchProcess.setAchFlow(reseachrep.getReseachrepFlow());
	    GeneralMethod.setRecordInfo(srmAchProcess, true);
	    srmAchProcess.setOperateTime(srmAchProcess.getModifyTime());
	    //srmAchProcess.setContent("成果填写");
	    srmAchProcessBiz.saveAchProcess(srmAchProcess);
		return GlobalConstant.ZERO_LINE;
	}


	@Override
	public SrmAchReseachrep readReseachrep(String reseachrepFlow) {
		SrmAchReseachrep reseachrep = null;
		if(StringUtil.isNotBlank(reseachrepFlow)){
			reseachrep = reseachrepMapper.selectByPrimaryKey(reseachrepFlow);
		}
		return reseachrep;
	}

	@Override
	public int updateReseachrepStatus(SrmAchReseachrep reseachrep, SrmAchProcess process) {
		if(reseachrep!=null&&StringUtil.isNotBlank(reseachrep.getReseachrepFlow())){
			GeneralMethod.setRecordInfo(reseachrep, false);
			this.reseachrepMapper.updateByPrimaryKeySelective(reseachrep);
	    }
	    srmAchProcessBiz.saveAchProcess(process);
		return GlobalConstant.ONE_LINE;
	}

	@Override
	public List<SrmAchReseachrep> search(SrmAchReseachrep reseachrep, List<SysOrg> childOrgList) {
		SrmAchReseachrepExample example = new SrmAchReseachrepExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<String> orgFlowList=new ArrayList<String>();
		if(null!=childOrgList && !childOrgList.isEmpty()){
			for(SysOrg org:childOrgList){
				orgFlowList.add(org.getOrgFlow());
			}
			criteria.andApplyOrgFlowIn(orgFlowList);
		}
		if(reseachrep != null){
			if(StringUtil.isNotBlank(reseachrep.getRepTitle())){
				criteria.andRepTitleLike("%" + reseachrep.getRepTitle() + "%");
			}
			if(StringUtil.isNotBlank(reseachrep.getSubmitDate())){
				criteria.andSubmitDateEqualTo(reseachrep.getSubmitDate());
			}
			if(StringUtil.isNotBlank(reseachrep.getProjSourceId())){
				criteria.andProjSourceIdEqualTo(reseachrep.getProjSourceId());
			}
			if(StringUtil.isNotBlank(reseachrep.getApplyOrgFlow())){
				criteria.andApplyOrgFlowEqualTo(reseachrep.getApplyOrgFlow());
			}
			if(StringUtil.isNotBlank(reseachrep.getOperStatusId())){
				List<String> statusList=Arrays.asList(reseachrep.getOperStatusId().split(","));
				criteria.andOperStatusIdIn(statusList);
			}
			if(StringUtil.isNotBlank(reseachrep.getApplyUserFlow())){
				criteria.andApplyUserFlowEqualTo(reseachrep.getApplyUserFlow());
			}
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return this.reseachrepMapper.selectByExample(example);
	}

	@Override
	public int edit(SrmAchReseachrep reseachrep, List<SrmAchReseachrepAuthor> authorList,SrmAchFile file) {
		if(StringUtil.isNotBlank(reseachrep.getReseachrepFlow())){
			GeneralMethod.setRecordInfo(reseachrep, false);
			reseachrepMapper.updateByPrimaryKeySelective(reseachrep);
		}
		//作者
		if(null != authorList && !authorList.isEmpty()){
			for(SrmAchReseachrepAuthor author : authorList){
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
	
	
	
	//----------------------IReseachrepAuthorBiz-----------------------------
	@Override
	public int editReseachrepAuthor(SrmAchReseachrepAuthor author) {
		if(author != null && StringUtil.isNotBlank(author.getAuthorFlow())){
			GeneralMethod.setRecordInfo(author, false);
			return authorMapper.updateByPrimaryKeySelective(author);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<SrmAchReseachrepAuthor> searchAuthorList(SrmAchReseachrepAuthor author) {
		SrmAchReseachrepAuthorExample example = new SrmAchReseachrepAuthorExample();
		com.pinde.sci.model.mo.SrmAchReseachrepAuthorExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(author.getAuthorName())){
			criteria.andAuthorNameLike("%"+ author.getAuthorName() +"%");
		}
		if(StringUtil.isNotBlank(author.getReseachrepFlow())){
			criteria.andReseachrepFlowEqualTo(author.getReseachrepFlow());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return authorMapper.selectByExample(example);
	}
}
