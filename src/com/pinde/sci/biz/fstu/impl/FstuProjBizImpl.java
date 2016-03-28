package com.pinde.sci.biz.fstu.impl;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.fstu.IFstuProjBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.FstuProjMapper;
import com.pinde.sci.model.mo.FstuProj;
import com.pinde.sci.model.mo.FstuProjExample;
import com.pinde.sci.model.mo.FstuProjExample.Criteria;
import com.pinde.sci.model.mo.PubFile;


@Service
@Transactional(rollbackFor=Exception.class)
public class FstuProjBizImpl implements IFstuProjBiz{

	@Resource
	private FstuProjMapper projMapper;
	@Autowired
	private IFileBiz fileBiz;
	@Override
	public List<FstuProj> search(FstuProj proj) {
		FstuProjExample example=new FstuProjExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);;
		if(StringUtil.isNotBlank(proj.getProjYear())){
			criteria.andProjYearEqualTo(proj.getProjYear());
		}
		if(StringUtil.isNotBlank(proj.getProjLevelName())){
			criteria.andProjLevelNameEqualTo(proj.getProjLevelName());
		}
		if(StringUtil.isNotBlank(proj.getProjSubject())){
			criteria.andProjSubjectEqualTo(proj.getProjSubject());
		}
		if(StringUtil.isNotBlank(proj.getDeclarationResultId())){
			criteria.andDeclarationResultIdEqualTo(proj.getDeclarationResultId());
		}
		if(StringUtil.isNotBlank(proj.getProjName())){
			criteria.andProjNameLike("%"+proj.getProjName()+"%");
		}
		if(StringUtil.isNotBlank(proj.getApplyUserName())){
			criteria.andApplyUserNameLike("%"+proj.getApplyUserName()+"%");
		}
		if(StringUtil.isNotBlank(proj.getOrgFlow())){
			criteria.andOrgFlowEqualTo(proj.getOrgFlow());
		}
		if(StringUtil.isNotBlank(proj.getApplyOrgName())){
			criteria.andApplyOrgNameLike("%"+proj.getApplyOrgName()+"%");
		}
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(proj.getApplyOrgFlow());
		}
		
		return projMapper.selectByExample(example);
	}
	@Override
	public int save(FstuProj proj){
		if(proj!=null){
			if(StringUtil.isNotBlank(proj.getProjFlow())){
				GeneralMethod.setRecordInfo(proj, false);
				return projMapper.updateByPrimaryKeySelective(proj);
			}else{
				proj.setProjFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(proj, true);
				return projMapper.insertSelective(proj);
				}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveProjAndFile(FstuProj proj,MultipartFile file) throws IOException {
		String projFlow = proj.getProjFlow();
		if(StringUtil.isNotBlank(projFlow) && !StringUtil.isNotBlank(proj.getDeclarationFormFlow())){
			delFile(projFlow);
		}
		if(file!=null&&file.getSize()>0){
			PubFile pubFile = new PubFile();
//			pubFile.setFileFlow(proj.getProjFlow());
			pubFile.setFileName(file.getOriginalFilename());
			pubFile.setFileContent(file.getBytes());
			int result = this.fileBiz.editFile(pubFile);
			if(result == GlobalConstant.ZERO_LINE){
				return GlobalConstant.ZERO_LINE;
			}
			
			proj.setDeclarationFormFlow(pubFile.getFileFlow());
		}
		return save(proj);
	}
	
	private void delFile(String projFlow){
		FstuProj oldProj = findByFlow(projFlow);
		if(oldProj!=null){
			String fileFlow = oldProj.getDeclarationFormFlow();
			if(StringUtil.isNotBlank(fileFlow)){
				PubFile pubFile = new PubFile();
				pubFile.setFileFlow(fileFlow);
				pubFile.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				this.fileBiz.editFile(pubFile);	
			}
		}
	}
	
	@Override
	public FstuProj findByFlow(String projFlow) {
		return projMapper.selectByPrimaryKey(projFlow);
	}
	

}
