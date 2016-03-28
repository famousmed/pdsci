package com.pinde.sci.biz.sch.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDoctorAbsenceBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.SchDoctorAbsenceMapper;
import com.pinde.sci.dao.sch.SchDoctorAbsenceExtMapper;
import com.pinde.sci.enums.res.AbsenceTypeEnum;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDoctorAbsence;
import com.pinde.sci.model.mo.SchDoctorAbsenceExample;
import com.pinde.sci.model.mo.SysUser;

/**
 * @author tiger
 *
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class SchDoctorAbsenceBizImpl implements ISchDoctorAbsenceBiz {
	@Autowired
	private SchDoctorAbsenceMapper doctorAbsenceMapper;
	@Autowired
	private IResDoctorProcessBiz resDoctorProcessBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private SchDoctorAbsenceExtMapper doctorAbsenceExtMapper;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private ISchDeptBiz schDeptBiz;
	
	@Override
	public List<SchDoctorAbsence> searchSchDoctorAbsenceByDoctor(String doctorFlow) {
		SchDoctorAbsenceExample example = new SchDoctorAbsenceExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDoctorFlowEqualTo(doctorFlow);
		example.setOrderByClause("START_DATE");
		return doctorAbsenceMapper.selectByExample(example);
	}
	
	@Override
	public List<SchDoctorAbsence> searchSchDoctorAbsenceByOrg(String orgFlow) {
		SchDoctorAbsenceExample example = new SchDoctorAbsenceExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("START_DATE");
		return doctorAbsenceMapper.selectByExample(example);
	}

	@Override
	public SchDoctorAbsence readSchDoctorAbsence(String absenceFlow) {
		return doctorAbsenceMapper.selectByPrimaryKey(absenceFlow);
	}

	@Override
	public int saveSchDoctorAbsence(SchDoctorAbsence doctorAbsence) {
		if(doctorAbsence != null){
			if(StringUtil.isNotBlank(doctorAbsence.getAbsenceFlow())){
				GeneralMethod.setRecordInfo(doctorAbsence, false);
				return doctorAbsenceMapper.updateByPrimaryKeySelective(doctorAbsence);
			}else{
				doctorAbsence.setAbsenceFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(doctorAbsence, true);
				return doctorAbsenceMapper.insertSelective(doctorAbsence);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int editSchDoctorAbsence(SchDoctorAbsence doctorAbsence, MultipartFile multipartFile) {
		 if(!multipartFile.isEmpty()){
             PubFile pubFile = new PubFile();
             String originalFileName = multipartFile.getOriginalFilename();
             String suffix =originalFileName.substring(originalFileName.lastIndexOf(".")+1); 
             //默认的文件名
             pubFile.setFileName(originalFileName);
             //文件后缀名
             pubFile.setFileSuffix(suffix);
             pubFile.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
             try {
            	 pubFile.setFileContent(multipartFile.getBytes());
                 fileBiz.editFile(pubFile);
                 doctorAbsence.setMakingFile(pubFile.getFileFlow());
             } catch (Exception e) {
                 throw new RuntimeException("文件上传异常");
             } 
         }
		if(StringUtil.isNotBlank(doctorAbsence.getAbsenceTypeId())){
			doctorAbsence.setAbsenceTypeName(AbsenceTypeEnum.getNameById(doctorAbsence.getAbsenceTypeId()));
		}else{
			doctorAbsence.setAbsenceTypeName("");
		}
		if(StringUtil.isBlank(doctorAbsence.getAbsenceFlow())){//新增
			if(StringUtil.isBlank(doctorAbsence.getDoctorFlow())){//医师新增请假
				SysUser currUser = GlobalContext.getCurrentUser();
				doctorAbsence.setDoctorFlow(currUser.getUserFlow());
				doctorAbsence.setDoctorName(currUser.getUserName());
				doctorAbsence.setIsRegister(GlobalConstant.FLAG_N);
			}
			
			String schDeptFlow = doctorAbsence.getSchDeptFlow();
			if(StringUtil.isNotBlank(schDeptFlow)){
				SchDept dept = schDeptBiz.readSchDept(schDeptFlow);
				if(dept!=null){
					doctorAbsence.setDeptFlow(dept.getDeptFlow());
					doctorAbsence.setDeptName(dept.getDeptName());
				}
			}
			
			String doctorFlow = doctorAbsence.getDoctorFlow();
			ResDoctor resDoctor = resDoctorBiz.readDoctor(doctorFlow);
			if(resDoctor != null){
				doctorAbsence.setSessionNumber(resDoctor.getSessionNumber());
				doctorAbsence.setTrainingSpeId(resDoctor.getTrainingSpeId());
				doctorAbsence.setTrainingSpeName(resDoctor.getTrainingSpeName());
				doctorAbsence.setDoctorCategoryId(resDoctor.getDoctorCategoryId());
				doctorAbsence.setDoctorCategoryName(resDoctor.getDoctorCategoryName());
				doctorAbsence.setRepealAbsence(GlobalConstant.RECORD_STATUS_N);
				doctorAbsence.setOrgFlow(resDoctor.getOrgFlow());
				doctorAbsence.setOrgName(resDoctor.getOrgName());
				return saveSchDoctorAbsence(doctorAbsence);
			}
		}else{//修改
			return saveSchDoctorAbsence(doctorAbsence);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<SchDoctorAbsence> searchSchDoctorAbsenceList(SchDoctorAbsence doctorAbsence) {
		SchDoctorAbsenceExample example = new SchDoctorAbsenceExample();
		com.pinde.sci.model.mo.SchDoctorAbsenceExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(doctorAbsence.getDoctorFlow())){
			criteria.andDoctorFlowEqualTo(doctorAbsence.getDoctorFlow());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getDoctorName())){
			criteria.andDoctorNameLike("%" + doctorAbsence.getDoctorName() + "%");
		}
		if(StringUtil.isNotBlank(doctorAbsence.getSchDeptFlow())){
			criteria.andSchDeptFlowEqualTo(doctorAbsence.getSchDeptFlow());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getRepealAbsence())){
			criteria.andRepealAbsenceEqualTo(doctorAbsence.getRepealAbsence());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getStartDate())){
			criteria.andStartDateGreaterThanOrEqualTo(doctorAbsence.getStartDate());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getEndDate())){
			criteria.andEndDateLessThanOrEqualTo(doctorAbsence.getEndDate());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getOrgFlow())){
			criteria.andOrgFlowEqualTo(doctorAbsence.getOrgFlow());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getTeacherFlow())){
			criteria.andTeacherFlowEqualTo(doctorAbsence.getTeacherFlow());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getHeadFlow())){
			criteria.andHeadFlowEqualTo(doctorAbsence.getHeadFlow());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getTrainingSpeId())){
			criteria.andTrainingSpeIdEqualTo(doctorAbsence.getTrainingSpeId());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getSessionNumber())){
			criteria.andSessionNumberEqualTo(doctorAbsence.getSessionNumber());
		}
		if(StringUtil.isNotBlank(doctorAbsence.getIsRegister())){
			criteria.andIsRegisterEqualTo(doctorAbsence.getIsRegister());
		}
		example.setOrderByClause("START_DATE DESC");
		return doctorAbsenceMapper.selectByExample(example);
	}
	
	@Override
	public List<SchDoctorAbsence> searchDoctorAbsence(Map<String , Object> paramMap){
		return doctorAbsenceExtMapper.searchDoctorAbsence(paramMap);
	}
	
	@Override
	public List<Map<String,Object>> countAbsenceDays(List<String> doctorFlows){
		return doctorAbsenceExtMapper.countAbsenceDays(doctorFlows);
	}
	
}
