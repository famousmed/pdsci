package com.pinde.sci.biz.gcp.impl;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IWorkFileBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.PubDiaryMapper;
import com.pinde.sci.dao.base.PubRegulationMapper;
import com.pinde.sci.dao.base.PubWorkpaperMapper;
import com.pinde.sci.enums.pub.RegulationCategoryEnum;
import com.pinde.sci.enums.pub.WorkpaperTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.PubDiary;
import com.pinde.sci.model.mo.PubDiaryExample;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubRegulation;
import com.pinde.sci.model.mo.PubRegulationExample;
import com.pinde.sci.model.mo.PubWorkpaper;
import com.pinde.sci.model.mo.PubWorkpaperExample;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class WorkFileBizImpl implements IWorkFileBiz {
	@Resource
	private PubDiaryMapper diaryMapper;
	@Resource
	private PubRegulationMapper regulationMapper;
	@Resource
	private PubWorkpaperMapper workpaperMapper;
	
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IFileBiz fileBiz;
	
	@Override
	public int saveDiary(PubDiary diary) {
		SysUser currUser = GlobalContext.getCurrentUser();
		diary.setOperUserFlow(currUser.getUserFlow());
		diary.setOperUserName(currUser.getUserName());
		if(StringUtil.isNotBlank(diary.getDiaryFlow())){
			GeneralMethod.setRecordInfo(diary, false);
			return diaryMapper.updateByPrimaryKeySelective(diary);
		}else{
			diary.setDiaryFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(diary, true);
			return diaryMapper.insert(diary);
		}
	}

	@Override
	public List<PubDiary> searchDiaryList() {
		PubDiaryExample example = new PubDiaryExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return diaryMapper.selectByExample(example);
	}

	@Override
	public PubDiary readDiary(String diaryFlow) {
		if(StringUtil.isNotBlank(diaryFlow)){
			return diaryMapper.selectByPrimaryKey(diaryFlow);
		}
		return null;
	}

	@Override
	public List<PubRegulation> searchRegulaionFileList(PubRegulation regulation) {
		PubRegulationExample example = new PubRegulationExample();
		com.pinde.sci.model.mo.PubRegulationExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(regulation.getRegulationCategoryId())){
			criteria.andRegulationCategoryIdEqualTo(regulation.getRegulationCategoryId());
		}
		if(StringUtil.isNotBlank(regulation.getRegulationTypeId())){
			criteria.andRegulationTypeIdEqualTo(regulation.getRegulationTypeId());
		}
		if(StringUtil.isNotBlank(regulation.getRegulationName())){
			criteria.andRegulationNameLike("%"+regulation.getRegulationName()+ "%");
		}
		if(StringUtil.isNotBlank(regulation.getRegulationCode())){
			criteria.andRegulationCodeEqualTo(regulation.getRegulationCode());
		}
		if(StringUtil.isNotBlank(regulation.getRegulationYear())){
			criteria.andRegulationYearEqualTo(regulation.getRegulationYear());
		}
		if(StringUtil.isNotBlank(regulation.getDeptFlow())){
			criteria.andDeptFlowEqualTo(regulation.getDeptFlow());
		}
		example.setOrderByClause("ORDINAL,CREATE_TIME DESC");
		return regulationMapper.selectByExample(example);
	}

	@Override
	public int saveRegulationFile(MultipartFile multipartFile, PubRegulation regulation){
		if(multipartFile != null){
			PubFile pubFile = new PubFile();
			String originalFilename = multipartFile.getOriginalFilename();
			String suffix = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
			//默认的文件名
			pubFile.setFileName(originalFilename);
			//文件后缀名
			pubFile.setFileSuffix(suffix);
			try {
				pubFile.setFileContent(multipartFile.getBytes());
				fileBiz.editFile(pubFile);
			} catch (IOException e) {
				 throw new RuntimeException("文件上传异常");
			}
			String fileFlow = pubFile.getFileFlow();
			
			regulation.setRegulationName(originalFilename);
			regulation.setRegulationCategoryName(RegulationCategoryEnum.getNameById(regulation.getRegulationCategoryId()));
			if(StringUtil.isNotBlank(regulation.getRegulationTypeId())){
				if(regulation.getRegulationCategoryId().equals(RegulationCategoryEnum.Country.getId())){
					regulation.setRegulationTypeName(DictTypeEnum.RegulationCountry.getDictNameById(regulation.getRegulationTypeId()));
				}
				if(regulation.getRegulationCategoryId().equals(RegulationCategoryEnum.Local.getId())){
					regulation.setRegulationTypeName(DictTypeEnum.RegulationLocal.getDictNameById(regulation.getRegulationTypeId()));
				}
				if(regulation.getRegulationCategoryId().equals(RegulationCategoryEnum.Org.getId())){
					regulation.setRegulationTypeName(DictTypeEnum.RegulationOrg.getDictNameById(regulation.getRegulationTypeId()));
				}
				if(regulation.getRegulationCategoryId().equals(RegulationCategoryEnum.Dept.getId())){
					regulation.setRegulationTypeName(DictTypeEnum.RegulationDept.getDictNameById(regulation.getRegulationTypeId()));
				}
			}
			regulation.setFileFlow(fileFlow);
			String deptFlow = regulation.getDeptFlow();
			if(StringUtil.isNotBlank(deptFlow)){
				regulation.setDeptName(InitConfig.getDeptNameByFlow(deptFlow));
			}
			
			return saveRegulation(regulation);
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	/**
	 * 保存Regulation
	 * @param regulation
	 */
	private int saveRegulation(PubRegulation regulation) {
		if(StringUtil.isNotBlank(regulation.getRegulationFlow())){//修改
			GeneralMethod.setRecordInfo(regulation, false);
			return regulationMapper.updateByPrimaryKeySelective(regulation);
		}else{//新增
			regulation.setRegulationFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(regulation, true);
			return regulationMapper.insert(regulation);
		}
	}

	@Override
	public int delRegulationFile(String regulationFlow, String fileFlow) {
		if(StringUtil.isNotBlank(regulationFlow) && StringUtil.isNotBlank(fileFlow)){
			PubRegulation regulation = new PubRegulation();
			regulation.setRegulationFlow(regulationFlow);
			regulation.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			regulationMapper.updateByPrimaryKeySelective(regulation);
			
			PubFile pubFile = new PubFile();
			pubFile.setFileFlow(fileFlow);
			pubFile.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			return fileBiz.editFile(pubFile);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int saveOrder(String[] regulationFlow) {
		if(regulationFlow.length > 0){
			for(int i = 0; i < regulationFlow.length; i++){
				PubRegulation regulation = new PubRegulation();
				regulation.setRegulationFlow(regulationFlow[i]);
				regulation.setOrdinal((i+1));
				regulationMapper.updateByPrimaryKeySelective(regulation);			
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int saveWorkpaper(PubWorkpaper workpaper) {
		if(StringUtil.isNotBlank(workpaper.getRecordFlow())){//修改
			GeneralMethod.setRecordInfo(workpaper, false);
			return workpaperMapper.updateByPrimaryKeySelective(workpaper);
		}else{//新增
			workpaper.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(workpaper, true);
			return workpaperMapper.insert(workpaper);
		}
	}
	
	@Override
	public List<PubWorkpaper> searchWorkpaperList(PubWorkpaper workpaper) {
		PubWorkpaperExample example = new PubWorkpaperExample();
		com.pinde.sci.model.mo.PubWorkpaperExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(workpaper.getWorkpaperTypeId())){
			criteria.andWorkpaperTypeIdEqualTo(workpaper.getWorkpaperTypeId());
		}
		if(StringUtil.isNotBlank(workpaper.getWorkpaperName())){
			criteria.andWorkpaperNameLike("%" + workpaper.getWorkpaperName() + "%");
		}
		if(StringUtil.isNotBlank(workpaper.getReportUserName())){
			criteria.andReportUserNameLike("%" + workpaper.getReportUserName() + "%");
		}
		if(StringUtil.isNotBlank(workpaper.getReportTime())){
			criteria.andReportTimeEqualTo(workpaper.getReportTime());
		}
		example.setOrderByClause("REPORT_TIME DESC, CREATE_TIME DESC");
		return workpaperMapper.selectByExample(example);
	}

	@Override
	public PubWorkpaper readWorkpaper(String recordFlow) {
		if(StringUtil.isNotBlank(recordFlow)){
			return workpaperMapper.selectByPrimaryKey(recordFlow);
		}
		return null;
	}
}
